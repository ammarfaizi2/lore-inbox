Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTDVORW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDVORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:17:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41953 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263177AbTDVORT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:17:19 -0400
Date: Tue, 22 Apr 2003 07:29:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <170570000.1051021741@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.c
 om>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I see what you mean, you're right. That's because all the 10,000 vma
>> > belongs to the same inode.
>> 
>> I see two problems with objrmap - this search, and the complexity of the
>> interworking with nonlinear mappings.
>> 
>> There is talk going around about implementing some more sophisticated
>> search structure thatn a linear list.
>> 
>> And treating the nonlinear mappings as being mlocked is a great
>> simplification - I'd be interested in Ingo's views on that.
> 
> i believe the right direction is the one that is currently happening: to
> make nonlinear mappings more generic. sys_remap_file_pages() started off
> as a special hack mostly usable for locked down pages. Now it's directly
> encoded in the pte and thus swappable, and uses up a fraction of the vma
> cost for finegrained mappings.
> 
> (i believe the next step should be to encode permission bits into the pte
> as well, and thus enable eg. mprotect() to work without splitting up
> vmas.   On 32-bit ptes this is not relistic due to the file size limit
> imposed, but once 64-bit ptes become commonplace it's a step worth taking
> i believe.)

I don't think you commented on Andrew's actual question, as far as I can
see ... can we mlock the nonlinear mappings? I think for the original
designed usage (Oracle) that's fine, as far as I know.

The other massive problem we seem to have is that fact we don't know at
create time whether the mapping is non-linear or not. Knowing that would
allow us to do what we're acutally trying to do now, which is to keep
pte-chains for these mappings, and use objrmap for linear ones. The pain is
not dealing with them, it's converting from one to the other.

Either that, or we keep a list of the nonlinear regions for each VMA so we
can do the objrmap for the non-linear regions as well. Yes, it's a little
bit of overhead for sys_remap_file_pages, but you lose the overhead per
page on the pte-chain manipulation front.

So if we can do any of those 3 things, I think we're fine. I find it hard
to believe that none of them is acceptable. Particularly as we can probably
combine the first with one of the others fairly easily.

> the O(N^2) property of objrmap where N is the 'inode sharing factor' is a
> serious design problem i believe. 100 mappings in 100 contexts on the same
> inode is not uncommon at all - still it totally DoS-es the VM's scanning
> code, if it uses objrmap. Sure, rmap is O(N) - after all we do have 100
> users of that mapping.
> 
> If the O(N^2) can be optimized away then i'm all for it. If not, then i
> dont really understand how the same people who call sys_remap_file_pages()
> a 'hack' [i believe they are not understanding the current state of the
> API] can argue for objrmap in the same paragraph.

Well, we can easily fix the O(N^2) property by using a data structure other
than a simple non-sorted linked list. However ... that has significant
overhead itself. I think we're optimising for the wrong case here - isn't
the 100x100 mappings case exactly what we have sys_remap_file_pages for?
Which keeps pte_chains (for the hybrid case of partial objrmap), so it's
just as fast as before (assuming we can resolve the issue above).

We can make the O(?) stuff look as fancy as we like. However, in reality,
that makes the constants suck, and I'm not at all sure it's a good plan.

> i believe the main problem wrt. rmap is the pte_chain lowmem overhead on
> 32-bit systems. (it also causes some fork() runtime overhead, but i doubt
> anyone these days should argue that fork() latency is a commanding
> parameter to optimize the VM for. We have vfork() and good threading, and
> any fork()-sensitive app uses preforking anyway.)

For workloads like server consolidation, its not as easy as that. You have
myriad numbers of little applications, and rewriting all of them because
fork just became a lot slower is not really practical.

I think you're seriously underestimating the performance impact vs space
problems as well ... IIRC my simple kernel compile test became about 25%
less system time via partial objrmap.

> to solve this problem i believe the pte chains should be made
> double-linked lists, and should be organized in a completely different

It seems ironic that the solution to space consumption is do double the
amount of space taken ;-) I see what you're trying to do (shove things up
into highmem), but it seems like a much better plan to me to just kill the
bloat altogether. 

> This simpler pte chain construct also makes it easy to high-map the pte
> chains: whenever we high-map the pte page, we can high-map the pte chain
> page(s) as well. No more lowmem overhead for pte chains.

Well, it's traded lowmem space overhead for > 2x highmem overhead
(sparseness). But what's killer is even more time overhead than before. Now
you have to kmap the hell out of everything to do manipulations. The
overhead for pte-highmem is horrible as it is (something like 10% systime
for kernel compile IIRC). And this is worse - you have to manipulate the
prev and next elements in the list. I know how to fix pte_highmem kmap
overhead already (via UKVA), but not rmap pages. Not only is it kmap, but
you have double the number of cachelines touched.

I think the holes in objrmap are quite small - and are already addressed by
your sys_remap_file_pages mechanism.

M.
