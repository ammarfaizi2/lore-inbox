Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUIWEcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUIWEcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:32:41 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:13783 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S268257AbUIWEca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:32:30 -0400
Date: Wed, 22 Sep 2004 23:32:25 -0500 (CDT)
From: Ray Bryant <raybry@austin.rr.com>
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
Subject: [PATCH 0/2] mm: memory policy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

You may like the following patchset better.  (At least
I hope so...)

It's divided into 3 parts, with this file (the OVERVIEW)
making up the 0th part, and two patches in part 1 and 2.

I've tried to address several of your concerns with this
version of the patch:

(1)  We dropped the MPOL_ROUNDROBIN patch.  Instead, we
     use MPOL_INTERLEAVE to spread pages across nodes.
     However, rather than use the file offset etc to 
     calculate the node to allocate the page on, I used
     the same mechanism you used in alloc_pages_current()
     to calculate the node number (interleave_node()).
     That eliminates the need to generate an offset etc
     in the routines that call page_cache_alloc() and to
     me appears to be a simpler change that still fits
     within your design.

     We can still go the other way if you want, it matters
     not to me, this was just dramatically less code (i. e.
     0 lines) to use the existing functionality.

(2)  I implemented the sys_set_mempolicy() changes as
     suggested -- higher order bits in the mode (first)
     argument specify whether or not this request is for
     the page allocation policy (your existing policy)
     or for the page cache allocation policy.  Similarly,
     a bit there indicates whether or not we want to set
     the process level policy or the system level policy.

     These bits are to be set in the flags argument of
     sys_mbind().

(3)  As before, there is a process level policy and a
     system level policy for both regular page allocation
     and page cache allocation.  The primary rationale
     for this is that since that is the way your code 
     worked for regular page allocation, it was easiest
     to piggyback on that and hence you end up with a
     per process and system default page allocation policy.
     If no-one specifies a process level page cache 
     allocation policy, the overhead of this is one long
     per task struct.  Making it otherwise would make
     the code less clean, I think.

     We continue to believe that we will have applications
     that wish to set the page cache allocation policy, 
     but, we don't have any demonstrable cases of this.

(4)  I added a new patch to remove a bias toward node
     0 of page allocations.  That is because each
     new process starts with an il_next = 0.  Now, I
     set il_next to current->pid % MAX_NUMNODES.
     See the 2nd patch for more discussion.

I haven't tested this much, it compiles and boots.
More testing will be done once I get your NUMA_API code
converted (perhaps not much needs to be done, don't 
know yet) to use the new interface.

Also, I got Steve's patch, and have looked at the overview,
but not the details.  If we could create a default policy for
page cache allocation that would be like MPOL_INTERLEAVE,
and then have per file settable policies, I guess we could
live with that, but it seems to me that a process would 
likely want all of its pages allocated the same way.  That
is, an HPC process would want all of its files allocated
round robin across the cpuset (most likely), while a file
server process would want its page cache pages allocated
locally.  It would be pain to have to specify a special
policy for each file opened by a process, I would think,
unless there is some way to cache that in the proces and
have it apply to all files that the process opens, but
then you are effectively emulating a per process policy 
in user space, it seems to me.

    ---------------OVERVIEW--------------------

This is the second working release of this patch.

Changes since the last release
------------------------------

(1)  Dropped the MPOL_ROUNDROBIN patch.
(2)  Added some new text to the overview (see <new text>)
     below.
(3)  Changed to use the task struct field: il_next to
     control round robin allocation of pages when the
     policy is MPOL_INTERLEAVE.
(4)  Added code to set and get the additional policy types.
     The original policy in Andi Kleen's code is called
     POLICY_PAGE, because it deals with data page allocation,
     the new policy for page cache pages is called
     POLICY_PAGECACHE.
(5)  Added a new patch to this series to reduce allocation
     bias toward node 0.

Background
----------

In August, Jesse Barnes at SGI proposed a patch to do round robin
allocation of page cache pages on NUMA machines.  This got shot down
for a number of reasons (see
  http://marc.theaimsgroup.com/?l=linux-kernel&m=109235420329360&w=2
and the related thread), but it seemed to me that one of the most
significant issues was that this was a workload dependent optimization.
That is, for an Altix running an HPC workload, it was a good thing,
but for web servers or file servers it was not such a good idea.

So the idea of this patch is the following:  it creates a new memory
policy structure (default_pagecache_policy) that is used to control
how storage for page cache pages is allocated.  So, for a large Altix
running HPC workloads, we can specify a policy that does round robin
allocations, and for other workloads you can specify the default policy
(which results in page cache pages being allocated locally).

The default_pagecache_policy is override-able on a per process basis, so
that if your application prefers to allocate page cache pages locally,
it can.  <new text>  In this regard the pagecache policy behaves the same
as the page allocation policy and indeed all of the code to implement
the two is basically the same.

<new text>
The primary rationale for this is that is the way the existing mempolicy
code works -- there is a per process policy, which is used if it exists,
and if the per process policy is null, then a global, default policy
is used.  This patch piggybacks on that existing code, so you get the
per process policy and a global policy for page cache allocations as well.

If the user does not define a per process policy, the extra cost is an
unused pointer in the task struct.  We can envision situations where
a per process cache allocation policy may be beneficial, but the real
case for this is that it allows us to use the existing code with only
minor modifications to implement, set and get the page cache mempolicy.

This is all done by making default_policy and current->mempolicy an
array of size 2 and of type "struct mempolicy *".   Entry POLICY_PAGE
in these arrays is the old default_policy and process memory policy.
Entry POLICY_PAGECACHE in these arrays contains the system default and
per process page cache allocation policies, respectively.

While one can, in principle, change the global page cache allocation
policy, we think this will be done precisely once per boot by calls from
startup scripts into the NUMA API code.  The idea is not so much to allow
the global page cache policy to be easily changeable, but rather allowing
it to be settable by the system admin so that we don't have to compile
separate kernels for file servers and HPC servers.   In particular,
changing the page cache allocation policy doesn't cause previously
allocated pages to be moved so that they are now placed correctly
according to the new policy.  Over time, they will get replaced and the
system will slowly migrate to a state where most page cache pages are
on the correct nodes for the new policy.

Efficiencies in setting and getting the page cache policy from user
space are also achieve through this approach.  The system call 
entry points "sys_set_mempolicy", "sys_get_mempolicy" and "sys_mbind"
have been enhanced to support specifying whether the policy that is
being operated on is:

(1)  The process-level policy or the default system level policy.
(2)  The page allocation policy or the page cache allocation policy.

This is done using higher order bits in the mode (first) argument to
sys_set/get_mempolicy() and the flags word in sys_mbind().  These
bits are defined so that users of the original interface will get
the same results using the old and new implementations of these
routines.
<end new text>

A new worker routine is defined:
	alloc_pages_by_policy(gfp, order, policy)
This routine allocates the requested number of pages using the policy
index specified.

alloc_pages_current() and page_cache_alloc() are then defined in terms
of alloc_pages_by_policy().

<new text>
This patch is in two parts.  The first part is the page cache policy
patch itself (we dropped the previous first patch).  The second
patch is a patch to slightly modify the implementation of policy
MPOL_INTERLEAVE to remove a bias toward allocating on node 0.

Further specific details of these patches are in the patch files,
which follow this email.
<end new text>


Caveats
-------

(1)  page_cache_alloc_local() is defined, but is not currently called.
This was added in SGI ProPack to make sure that mmap'd() files were
allocated locally rather than round-robin'd (i. e. to override the
round robin allocation in that case.)  This was an SGI MPT requirement.
It may be this is not needed with the current mempolicy code if we can
associate the default mempolicy with mmap()'d files for those MPT users.

(2)  alloc_pages_current() is now an inline, but there is no easy way
to do that totally correctly with the current include file order (that I
could figure out at least...)  The problem is that alloc_pages_current()
wants to use the define constant POLICY_PAGE, but that is defined yet.
We know it is zero, so we just use zero.  A comment in mempolicy.h
suggests not to change the value of this constant to something other
than zero, and references the file gfp.h.

(3) <new>  The code compiles and boots but has not been extensively
tested.  The latter will wait for a NUMA API library that supports
the new functionality.    My next goal is to get those modifications
done so we can do some serious testing.

(4)  I've not thought a bit about locking issues related to changing a
mempolicy whilst the system is actually running.   However, now that
the mempolicies themselves are stateless (as per Andi Kleen's original
design) it may be that these issues are not as significant.

(5)  It seems there may be a potential conflict between the page cache
mempolicy and a mmap mempolicy (do those exist?).  Here's the concern:
If you mmap() a file, and any pages of that file are in the page cache,
then the location of those pages will (have been) dictated by the page
cache mempolicy, which could differ (will likely differ) from the mmap
mempolicy.  It seems that the only solution to this is to migrate those
pages (when they are touched) after the mmap().

(6)  Testing of this particular patch has been minimal since I don't 
yet have a compatible NUMA API.   I'm working on that next.

Comments, flames, etc to the undersigned.

Best Regards,

Ray

Ray Bryant <raybry@sgi.com>
