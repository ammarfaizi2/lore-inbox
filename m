Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVBRNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVBRNCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRNCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:02:48 -0500
Received: from mail.suse.de ([195.135.220.2]:8423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261352AbVBRNCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:02:38 -0500
Date: Fri, 18 Feb 2005 14:02:32 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andi Kleen <ak@muc.de>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050218130232.GB13953@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4215A992.80400@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Enjoy your vacation]

On Fri, Feb 18, 2005 at 02:38:42AM -0600, Ray Bryant wrote:
> 
> Let's start off with at least one thing we can agree on.  If xattrs
> are already part of XFS, then it seems reasonable to use an extended
> attribute to mark certain files as non-migratable.   (Some further
> thought is going to be required here -- r/o sections of a
> shared library need not be migrated, but r/w sections containing
> program or thread private data would need to be migrated.  So
> the extended attribute may be a little more complicated than
> just "don't migrate".)

I assume they would allow marking arbitary segments with specific
policies, so it should be possible.

An alternative way to handle shared libraries BTW would be to add the ELF
headers Steve did in his patch. And then handle them in user space
in ld.so and let it apply the necessary policy. 

This won't work for non ELF files though.


> 
> The fact that NFS doesn't support this means that we will have to
> have some other way to handle files from NFS though.  It is possible
> we can live with the notion that files mapped in from NFS are always
> migratable.  (I'll need to look into that some more).

I don't know details, but I would assume selinux (and other "advanced security" 
people who generally need more security information per file) have plans in 
this area too.

> >
> >>>
> >>>Sorry, but the only real difference between your API and mbind is that
> >>>yours has a pid argument. 
> >>>
> 
> OK, so I've "lost the thread" a little bit here.  Specifically what
> would you propose the API for page migration be?  As I read through your 
> note,
> I see a couple of different possibilities being considered:
> 
> (1)  Map each object to be migrated into a management process,
>      update the object's memory policy to match the new node locations
>      and then unmap the object.  Use the MPOL_F_STRICT argument to mbind() 
>      and
>      the result is that migration happens as part of the call.
> 
> (2)  Something along the lines of:
> 
>      page_migrate(pid, old_node, new_node);
> 
>      or perhaps
> 
>      page_migrate(pid, old_node_mask, new_node_mask);

+ node mask length. 

I don't like old_node* very much because it's imho unreliable
(because you can usually never fully know on which nodes the old
process was and there can be good reasons to just migrate everything)

I assume the second way would be more flexible, although I found
having node masks for this has the problem that you tend to allocate
most memory on the lowest numbered node because it's not easy to
round-robin over all set nodes (that's an issue in PREFERED policy
in NUMA API currently). So maybe the simple  new_node argument
is preferable.

	page_migrate(pid, new_node)

(or putting it into a writable /proc file if you prefer that)  	

> 
> or
> 
> (3)  mbind() with a pid argument?

That would bring it to 7 arguments, really too much for a system
call (and a function in general). Also it would mean needing
to know about other process private addresses again.

Maybe set_mempolicy, but a new call is probably better.

> >NUMA API currently doesn't offer a way to do that, 
> >not even with Steve's patch that does simple page migration.
> >You only get a migration when you set a BIND or PREFERED
> >policy, and then it would stay. But I guess you could
> >force that and then set back DEFAULT. It's a big ugly,
> >but not too bad.
> >
> 
> Very ugly, I think.  Particularly if you have to do a lot of

Well, I guess it could be made a new flag that says to
not change the future policy. 

> vma splitting to get the correct node placement.  (Worst case
> is a VMA with nodes interleaved by first touch across a set of
> nodes in a way that doesn't match the INTERLEAVE mempolicy.
> Then you would have to create a separate VMA for each page
> and use the BIND policy.  Then after migration you would
> have to go through and set the policy back to DEFAULT,
> resulting in a lot of vma merges.)

Umm - I hope you don't want to do such tricks from external
processes. If a program does it by itself it can just use interleave
policy.

But I think I now understand why you want this complicated
user space control. You want to preserve relative ordering
on a set of nodes, right? 

e.g. job runs threads on nodes 0,1,2,3  and you want it to move
to nodes 4,5,6,7 with all memory staying staying in the same
distance from the new CPUs as it were from the old CPUs, right? 

It explains why you want old_node, you would do 
(assuming node mask arguments) 

page_migrate(pid, 0, 4)
page_migrate(pid, 1, 5)
...
page_migrate(pid, 3, 7) 

keeping the memory in the same relative order. Problem is what happens
when some memory is in some other node due to memory pressure fallbacks.
Your scheme would not migrate this memory at all. While you may
get away with this in your application I think it would make 
page migration much less useful in the general case than it could
be.  e.g. for a single threaded process it is very useful to just
force all its pages that have been allocated on multiple nodes
to a specific node. I would like to have this option at least, 
but with old node it would be rather inefficient. Ok, I guess you could
add a wildcard value for it; I guess that would work.

Problem is still that you would need to iterate through all nodes for your 
migration scenario (or how would you find out where the job  allocated
its old pages?), which is not very nice.  

Perhaps node masks would be better and teaching the kernel to handle
relative distances inside the masks transparently while migrating?
Not sure how complicated this would be to implement though.

Supporting interleaving on the new nodes may be also useful, that would
need a policy argument at least too and masks.

> (I'm sorry to keep harping on this but I think this is the
> heart of the issue we are discussing.  Are you of the opinion that
> we sould require every program that runs on ALTIX under Linux 2.6 to use 
> numactl?)

Programs usually don't use numactl; administrators do.

If your job runs under the control of a NUMA aware job manager then I don't
see why it couldn't use numactl or do the necessary kernel syscalls directly
on its own.

I don't think every programs needs to be linked with libnuma for
NUMA policy, although I think that there should be limits on
how much functionality you try to offer in the external tools.
At some point internal support will need to be needed.

> I'm sorry, I don't follow that at all.  The node array has nothing to do 
> with
> the size of the address range to be migrated.  It is not the case that the
> ith entry in the node array says what to do with the ith page.  Instead the
> old and new node arrays defining a mapping of pages:  for pages found on
> old_node[i], move them to new_node[i].  The count field is the size of those
> arrays, not the size of the region being migrated.

Yes, was a misunderstanding from my side.

> Compare this to the system call:
> 
> sys_page_migrate(pid, count, old_node_list, new_node_list);
> 
> We are then down to O(N) system calls and O(N) page table scans.

Ok. I can see the point of that now.

The main problem i see is how to handle "unknown" nodes. But perhaps
if a wild card node was defined for this purpose (-1?) it may do.

> But we can do better than that.  If  we have a system  call
> of the form
> 
> sys_page_migrate(pid, va_start, va_end, count, old_node_list, 
> new_node_list);
> 
> and the majority of the memory is shared, then we only need to make
> one system call and one page table scan.  (We just "migrate" the
> shared object once.) So the time to do the page table scans disappears

I don't like this because it makes it much more complicated
to use for user space. And you can set separate policies for
shared objects anyways.

-Andi
