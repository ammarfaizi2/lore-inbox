Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUGBKww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUGBKww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUGBKww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:52:52 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37836 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261932AbUGBKwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:52:46 -0400
Date: Fri, 2 Jul 2004 03:51:44 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Sylvain <sylvain.jeaugey@bull.net>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Simon <Simon.Derr@bull.net>, Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
Subject: [patch 1/8] cpusets v4 - Table of Contents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following cpusets v4 patch set is offered for review and comment.

It is similar to the cpusets v3 offered a couple of days ago, with
the following changes:

 * locking simplified and fixed
 * autoclean feature nuked
 * additional documentation
 * other lessor simplifications

Locking:

  The cpuset v3 locking was borked - mangled data and deadlocks.
  Now there is a single global cpuset_sem semaphore held across
  almost all ops that read or write cpusets.  Only the fork and exit
  hooks are exempt - they atomically increment and decrement a cpuset
  reference counter.

  Since cpuset ops are infrequent, this should be enough, even on
  SGI monster systems.  If it isn't, consider adding a reader-writer
  spinlock in each cpuset, guarding access to the cpus_allowed and
  mems_allowed fields, which could get the cpuset system call hooks
  (sched_setaffinity, mbind and set_mempolicy) off the global cpuset
  semaphore, if that helps.

  ** See further the locking comment in kernel/cpuset.c for cpuset_sem.

Autoclean:

  I removed the autoclean feature because its locking requirements
  seemed insane.  This feature would cause a 'rmdir(2)' operation,
  under certain specified conditions, to remove not only the specified
  cpuset (a directory in the cpuset virtual file system) but also
  start walking up the directory hierarchy, removing parents and
  grandparents.

  This seemed to require grabbing additional inode semaphores, walking
  up, while already holding some, from inside the vfs rmdir operation.
  I saw no way to avoid deadlocks on various inode semaphores, alone or
  in combination with the cpuset_sem semaphore.  I strongly suspected
  that any such effort was ill-advised in any case.

  ** If someone actually knows that the above can be done, and can
  ** explain to me how, I would be amazed and Sylvain of Bull would
  ** be delighted.

Documentation:

  Additional details are in the Documentation/cpusets.txt file.
  This is now the same file that is provided separately as item 2 of
  8 in this patch set for the Overview of Cpusets.

Lessor Simplifications:

  The other lessor simplifications were mostly made possible by
  the locking simplification and autoclean removal.  They include
  replacing the two flavors of release_cpuset (locked and unlocked)
  with a single flavor that just decrements the cpuset reference count.

  ** I have no further code changes planned.  I invite review.

===

The remainder of the comments below are copied from cpusets v3 of
two days ago ... almost exactly.

===

Shortly, not yet, I expect to be requesting Andrew to consider this
for inclusion in *-mm.  Andrew will be glad to hear that this patch
set (outside of Matthew Dobson's nodemask patch) has _much_ less
impact on existing kernel code than my previous cpumask patch set ;).

First I still need to perform further testing, obtain more feedback,
and provide a man page, before asking to get it into *-mm.  My thanks
to those who have reviewed it so far.

The bulk of the code and much of the design work in this patch has
been done by Simon Derr <Simon.Derr@bull.net> of Bull (France).
The nodemask patch is a preliminary draft of work by Matthew
Dobson, based on my cpumask patches.

This version v4 of the cpuset patch set is against 2.6.7-mm5.

These patches provide the essential kernel support for cpusets, which
enable identifying a hierarchy of subsets of system CPU and Memory Node
resources and attaching tasks to these subsets.  Tasks may only request
to use (sched_setaffinity, mbind and set_mempolicy) the CPUs and Memory
Nodes allowed to it by its cpuset.  Cpusets may be strictly exclusive
(other non-ancestral cpusets may not overlap).  One can list which
tasks are in which cpusets, and change which cpuset a task is in.
No new system calls are used; all access and modification is via a
virtual file system of type "cpuset", conventionally mounted at
/dev/cpuset.

See further the Cpuset Overview, item [2/9] of this email set.

==> I recommend that first time readers look first at items (2) Overview
    and (7) Kernel Hooks PATCH, for a better understanding of what this
    cpuset kernel patch is intended to do, and the very small kernel
    footprint required to accomplish this.

Now I have several email messages to present.  Items 2 through 8
will be sent as replies to this first message.

  1) This table of contents and introduction.
  2) Overview of kernel cpusets - a small text document.
  3) [patch] cpumask_consts - minor fix to my cpumask patch set
  4) [patch] nodemask - nodemask patch (draft of Matthew Dobson's patch)
  5) [patch] cpuset_bitmap_lists - add bitmap lists format
  6) [patch] cpuset_new_files - Main cpuset patch - cpuset.c, cpuset.h
  7) [patch] cpuset_kernel_hooks - The few, small kernel hooks needed
  8) [patch] cpuset_proc_hooks - One more hook, for /proc/<pid>/cpuset.

Your feedback is welcome.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
