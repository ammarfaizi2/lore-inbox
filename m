Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVIAJQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVIAJQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIAJQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:16:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52374 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750784AbVIAJQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:16:42 -0400
Date: Thu, 1 Sep 2005 02:08:53 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Simon Derr <Simon.Derr@bull.net>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 0/4] cpusets mems_allowed constrain GFP_KERNEL, oom killer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is proposed for inclusion in 2.6.14.

This patch extends the use of the cpuset attribute 'mem_exclusive'
to support cpuset configurations that:
 1) allow GFP_KERNEL allocations to come from a potentially larger
    set of memory nodes than GFP_USER allocations, and
 2) can constrain the oom killer to tasks running in cpusets in
    a specified subtree of the cpuset hierarchy.

Here's an example usage scenario.  For a few hours or more, a large
NUMA system at a University is to be divided in two halves, with a
bunch of student jobs running in half the system under some form
of batch manager, and with a big research project running in the
other half.  Each of the student jobs is placed in a small cpuset, but
should share the classic Unix time share facilities, such as buffered
pages of files in /bin and /usr/lib.  The big research project wants no
interference whatsoever from the student jobs, and has highly tuned,
unusual memory and i/o patterns that intend to make full use of all
the main memory on the nodes available to it.

In this example, we have two big sibling cpusets, one of which is
further divided into a more dynamic set of child cpusets.

We want kernel memory allocations constrained by the two big cpusets,
and user allocations constrained by the smaller child cpusets where
present.  And we require that the oom killer not operate across the two
halves of this system, or else the first time a student job runs amuck,
the big research project will likely be first inline to get shot.

Tweaking /proc/<pid>/oom_adj is not ideal -- if the big research
project really does run amuck allocating memory, it should be shot,
not some other task outside the research projects mem_exclusive cpuset.

I propose to extend the use of the 'mem_exclusive' flag of cpusets
to manage such scenarios.  Let memory allocations for user space
(GFP_USER) be constrained by a tasks current cpuset, but memory
allocations for kernel space (GFP_KERNEL) by constrained by the
nearest mem_exclusive ancestor of the current cpuset, even though
kernel space allocations will still _prefer_ to remain within the
current tasks cpuset, if memory is easily available.

Let the oom killer be constrained to consider only tasks that are in
overlapping mem_exclusive cpusets (it won't help much to kill a task
that normally cannot allocate memory on any of the same nodes as the
ones on which the current task can allocate.)

The current constraints imposed on setting mem_exclusive are unchanged.
A cpuset may only be mem_exclusive if its parent is also mem_exclusive,
and a mem_exclusive cpuset may not overlap any of its siblings
memory nodes.

This patch was presented on linux-mm in early July 2005, though did not
generate much feedback at that time.  It has been built for a variety of
arch's using cross tools, and built, booted and tested for function
on SN2 (ia64).

There are 4 patches in this set:
  1) Some minor cleanup, and some improvements to the code layout
     of one routine to make subsequent patches cleaner.
  2) Add another GFP flag - __GFP_HARDWALL.  It marks memory
     requests for USER space, which are tightly confined by the
     current tasks cpuset.
  3) Now memory requests (such as KERNEL) that not marked HARDWALL can
     if short on memory, look in the potentially larger pool of memory
     defined by the nearest mem_exclusive ancestor cpuset of the current
     tasks cpuset.
  4) Finally, modify the oom killer to skip any task whose mem_exclusive
     cpuset doesn't overlap ours.

Patch (1), the one time I looked on an SN2 (ia64) build, actually saved
32 bytes of kernel text space.  Patch (2) has no affect on the size
of kernel text space (it just adds a preprocessor flag).  Patches (3)
and (4) added about 600 bytes each of kernel text space, mostly in
kernel/cpuset.c, which matters only if CONFIG_CPUSET is enabled.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
