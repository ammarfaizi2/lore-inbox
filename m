Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVBSBEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVBSBEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVBSBEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:04:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29329 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261598AbVBSBDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:03:46 -0500
Message-ID: <42168FF0.30700@sgi.com>
Date: Fri, 18 Feb 2005 19:01:36 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de>
In-Reply-To: <20050218130232.GB13953@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [Enjoy your vacation]
> 

[I am thanks -- or I was -- I go home tomorrow]

> I assume they would allow marking arbitary segments with specific
> policies, so it should be possible.
> 
> An alternative way to handle shared libraries BTW would be to add the ELF
> headers Steve did in his patch. And then handle them in user space
> in ld.so and let it apply the necessary policy. 
> 
> This won't work for non ELF files though.
> 

Would I then have to sign-off from the ld.so maintainer to get that patch
in?  :-(

This sounds more general than the xattr attribute thing I was thinking
of (i. e. marking a file non-migratable or library....)

Well, we can work the exact details of this part later.


>>(2)  Something along the lines of:
>>
>>     page_migrate(pid, old_node, new_node);
>>
>>     or perhaps
>>
>>     page_migrate(pid, old_node_mask, new_node_mask);
> 
> 
> + node mask length. 
> 
> I don't like old_node* very much because it's imho unreliable
> (because you can usually never fully know on which nodes the old
> process was and there can be good reasons to just migrate everything)
> 

In our case, it turns out we do because the job is running inside of
a cpuset.  So it can't allocate memory outside of that cpuset.  In
more general scenarios, you are right, you don't know.  But this
can be handled with a MIGRATE_NODE_ANY (more below).

> I assume the second way would be more flexible, although I found
> having node masks for this has the problem that you tend to allocate
> most memory on the lowest numbered node because it's not easy to
> round-robin over all set nodes (that's an issue in PREFERED policy
> in NUMA API currently). So maybe the simple  new_node argument
> is preferable.
> 
> 	page_migrate(pid, new_node)
> 
> (or putting it into a writable /proc file if you prefer that)  	
> 
> 
>>or
>>
>>(3)  mbind() with a pid argument?
> 
> 
> That would bring it to 7 arguments, really too much for a system
> call (and a function in general). Also it would mean needing
> to know about other process private addresses again.
> 
> Maybe set_mempolicy, but a new call is probably better.

OK, lets assume we have a new call of some kind then.
> 
> 
> But I think I now understand why you want this complicated
> user space control. You want to preserve relative ordering
> on a set of nodes, right? 
> 
> e.g. job runs threads on nodes 0,1,2,3  and you want it to move
> to nodes 4,5,6,7 with all memory staying staying in the same
> distance from the new CPUs as it were from the old CPUs, right? 

Yes, thats it:  we want the relative distances between the pages
on the new set of nodes to match the distances on the old set of
nodes as much as is possible, or we at least want a sufficiently
powerful system call to let us do this if the correct set of new
nodes is available.  This is to have the application have the same
level of performance before and after the migration call.

In actuality, what we intend to do is to use this API to migrate
jobs from one cpuset to another; we will require the administrator
to set up the cpusets so they are topologically equivalent for cpusets
of the same size.  If the don't do that, then performance can
change when a job is migrated.
> 
> It explains why you want old_node, you would do 
> (assuming node mask arguments) 
> 
> page_migrate(pid, 0, 4)
> page_migrate(pid, 1, 5)
> ...
> page_migrate(pid, 3, 7) 
> 
> keeping the memory in the same relative order. Problem is what happens
> when some memory is in some other node due to memory pressure fallbacks.
> Your scheme would not migrate this memory at all. While you may
> get away with this in your application I think it would make 
> page migration much less useful in the general case than it could
> be.  e.g. for a single threaded process it is very useful to just
> force all its pages that have been allocated on multiple nodes
> to a specific node. I would like to have this option at least, 
> but with old node it would be rather inefficient. Ok, I guess you could
> add a wildcard value for it; I guess that would work.
> 

The patch that I sent out already defines MIGRATE_NODE_ANY to request
any other available node; this is needed for those cases where memory
hotplug just wants to move the page off of >>this<< node.  I don't
see why we we couldn't allow this as a value for old node, and it
would mean "migrate all pages".  (i. e. MIGRATE_NODE_ANY matches
pages on all nodes.)

> Problem is still that you would need to iterate through all nodes for your 
> migration scenario (or how would you find out where the job  allocated
> its old pages?), which is not very nice.

Agreed.  Which is why  we really prefer an old_node_list, new_node_list,
then we iterate acrcoss pages and make the indicated decision for each
page.

> 
> Perhaps node masks would be better and teaching the kernel to handle
> relative distances inside the masks transparently while migrating?
> Not sure how complicated this would be to implement though.
> 
> Supporting interleaving on the new nodes may be also useful, that would
> need a policy argument at least too and masks.
> 

The worry I have about using node masks is that it is not as general as
old_node,new_node mappings (or preferably, the original proposal I made
of old_node_list, new_node_list).  One can't differentiate between the
N! different mappings that a pair of nodemasks (with N bits set in each
mask) represents.  So one would have to choose one such map (the canonical
one) where the Ith bit of the first mask maps to the Ith bit of the second.

I believe this limits the kind of cpusets one can define.  In particular,
it means that  for any cpuset, if you sort the nodes in ordinal order,
corresponding entries of that sorted order have the same topological
relationship to one other in each cpuset.  Now think of the comminications
interconnect as being a tree.  One could construct cpuset A by taking
nodes from the left hand side of the tree, and cpuset B by taking
symmetrically chosen nodes from the right hand side of the tree.    It
is clear that the two cpusets are toplogically equivalent.

If nodes are numbered right to left, then the loweset numbered node in
cpuset A doesn't correspond to the lowest numbered node in cpuset B,
it corresponds to the highest numbered node.  So we can't represent
the correct mapping of nodes between cpuset A and cpuset B  using
a node mask, we have to use an explicit 1-1 mapping of some kind.
> 
>>(I'm sorry to keep harping on this but I think this is the
>>heart of the issue we are discussing.  Are you of the opinion that
>>we sould require every program that runs on ALTIX under Linux 2.6 to use 
>>numactl?)
> 
> 
> Programs usually don't use numactl; administrators do.
> 
> If your job runs under the control of a NUMA aware job manager then I don't
> see why it couldn't use numactl or do the necessary kernel syscalls directly
> on its own.
> 

If a job manager is going to use numactl to control placement, then
the job manager has to understand which parts of the address space
the program wants allocated on which node.  The latter depends, in
general on the input data the program reads.  So I don't see a good
way for this to happen.  Instead, today, it happens by first touch.

Note, in particular, that the mappings that sophistocated HPC
programs use are much more complicated than "Interleave everything".
They typically will be something like put this part of the address
space on that node, this part over there, this part over there,
interleave this part, etc, etc.  And all of those decisions can
be different every time the input data is changed, since that input
data can control the size of the matrix being anlayzed, etc.

Additionally, note that the kind of NUMA aware job manager we use on
our Altix systems is based on cpusets.  Jobs typically just request
the number of processors and a cpuset is created as a container for
the job.

Finally, note that we can't force our ISV's to add new NUMA API
calls in order to migrate from our Linux 2.4.21 based kernel to
our Linux 2.6 kernel.  We are more or less at their mercy.  And
since what they have now works well under 2.4.21, and it works
under 2.6 if we use the DEFAULT mempolicy, I just can't see how
we are going to win that argument, particularly since we are
very close to shipping our first 2.6 based systems.

So we have to figure out a way to migrate NUMA-aware programs
that are using the DEFAULT mempolicy and using first-touch
for memory placement, and we have to figure out how to migrate
them so that application peformance before and after the
migration is equivalent.


> I don't think every programs needs to be linked with libnuma for
> NUMA policy, although I think that there should be limits on
> how much functionality you try to offer in the external tools.
> At some point internal support will need to be needed.
> 
> 
> 
> 
>>Compare this to the system call:
>>
>>sys_page_migrate(pid, count, old_node_list, new_node_list);
>>
>>We are then down to O(N) system calls and O(N) page table scans.
> 
> 
> Ok. I can see the point of that now.
> 
> The main problem i see is how to handle "unknown" nodes. But perhaps
> if a wild card node was defined for this purpose (-1?) it may do.
> 

Right, MIGRATE_NODE_ANY in the new node list means, allocate on
any node.  We can define MIGRATE_NODE_ANY in the old node list to
mean, "take all pages".  In this case, there can only only be one
entry in the old and new node lists, so you could gather all pages
for a PID and move them to a single new node.
> 
>>But we can do better than that.  If  we have a system  call
>>of the form
>>
>>sys_page_migrate(pid, va_start, va_end, count, old_node_list, 
>>new_node_list);
>>
>>and the majority of the memory is shared, then we only need to make
>>one system call and one page table scan.  (We just "migrate" the
>>shared object once.) So the time to do the page table scans disappears
> 
> 
> I don't like this because it makes it much more complicated
> to use for user space. And you can set separate policies for
> shared objects anyways.

Yes, but only programs that care have to use the va_start and
va_end.  Programs who want to move everything can specify
0 and MAX_INT there and they are done.

Indeed we can only expose what we want most users to see in
glibc and leave the underlying system call in its full form
for only those systems that need it.

> 
> -Andi

But we are least at the level of agreeing that the new system
call looks something like the following:

migrate_pages(pid, count, old_list, new_list);

right?

That's progress.  :-)


-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
