Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTDVKsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDVKsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:48:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36030 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263075AbTDVKsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:48:13 -0400
Date: Tue, 22 Apr 2003 07:00:05 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, <mbligh@aracnet.com>, <mingo@elte.hu>,
       <hugh@veritas.com>, <dmccr@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030405143138.27003289.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Apr 2003, Andrew Morton wrote:

> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I see what you mean, you're right. That's because all the 10,000 vma
> > belongs to the same inode.
> 
> I see two problems with objrmap - this search, and the complexity of the
> interworking with nonlinear mappings.
> 
> There is talk going around about implementing some more sophisticated
> search structure thatn a linear list.
> 
> And treating the nonlinear mappings as being mlocked is a great
> simplification - I'd be interested in Ingo's views on that.

i believe the right direction is the one that is currently happening: to
make nonlinear mappings more generic. sys_remap_file_pages() started off
as a special hack mostly usable for locked down pages. Now it's directly
encoded in the pte and thus swappable, and uses up a fraction of the vma
cost for finegrained mappings.

(i believe the next step should be to encode permission bits into the pte
as well, and thus enable eg. mprotect() to work without splitting up vmas.  
On 32-bit ptes this is not relistic due to the file size limit imposed,
but once 64-bit ptes become commonplace it's a step worth taking i
believe.)

the O(N^2) property of objrmap where N is the 'inode sharing factor' is a
serious design problem i believe. 100 mappings in 100 contexts on the same
inode is not uncommon at all - still it totally DoS-es the VM's scanning
code, if it uses objrmap. Sure, rmap is O(N) - after all we do have 100
users of that mapping.

If the O(N^2) can be optimized away then i'm all for it. If not, then i
dont really understand how the same people who call sys_remap_file_pages()
a 'hack' [i believe they are not understanding the current state of the
API] can argue for objrmap in the same paragraph.

i believe the main problem wrt. rmap is the pte_chain lowmem overhead on
32-bit systems. (it also causes some fork() runtime overhead, but i doubt
anyone these days should argue that fork() latency is a commanding
parameter to optimize the VM for. We have vfork() and good threading, and
any fork()-sensitive app uses preforking anyway.)

to solve this problem i believe the pte chains should be made
double-linked lists, and should be organized in a completely different
(and much simpler) way: in a 'companion page' to the actual pte page. The
companion page stores the pte-chain links, corresponding directly to the
pte in the pagetable. Ie. if we have pte #100 in the pagetable, then we
look at entry #100 in the companion page. [the size of the page is
platform-dependent, eg. on PAE x86 it's a single page, on 64-platforms
it's two pages most of the time.] That entry then points to the 'next' and
'previous' pte in the pte chain. [the pte pagetable page itself has
pointers towards the companion page(s) in the struct page itself, existing
fields can be reused for this.]

This simpler pte chain construct also makes it easy to high-map the pte
chains: whenever we high-map the pte page, we can high-map the pte chain
page(s) as well. No more lowmem overhead for pte chains.

It also makes it easy to calculate the overhead of the pte chains: twice
the amount of pagetable overhead. Ie. with 32-bit pte's it's +8 bytes
overhead, or +0.2% of RAM overhead per mapped page, using a 4K page. With
64-bit ptes on 32-bit platforms (PAE), the overhead is still 8 bytes. On
64-bit platforms using 8K pages the overhead is still +0.2% of RAM, in
additionl to the 0.1% of RAM overhead for the pte itself. The worst-case
is 64-bit platforms with a 4K pagesize, there the overhead is +0.4% of
RAM, in addition to the 0.2% overhead caused by the pte itself.

(as a comparison, for finegrained mappings, if a single page is mapped by
a single vma, the 64-byte overhead of the vma causes a +1.5% overhead.)

so i think it's doable, and it solves many of the hairy allocation
deadlock issues wrt. pte-chains - the 'companion pages' hosting the pte
chain back and forward pointers can be allocated at the same time a
pagetable page is allocated. I believe this approach also greatly reduces
the complexity of pte chains, plus it makes unmap-time O(1) unlinking of
pte chains possible. If we can live with the RAM overhead.  (which would
scale linearly with the already existing pagetable overhead.)

	Ingo

