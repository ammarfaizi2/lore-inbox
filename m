Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVIJAoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVIJAoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVIJAoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:44:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44970 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932231AbVIJAoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:44:12 -0400
Date: Fri, 9 Sep 2005 17:44:03 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Message-Id: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code reading uncovered a potential deadlock on the global cpuset
semaphore, cpuset_sem.

==> This patch is only useful in the 2.6.13-stable series.

    (It's harmless, and useless, in the pre 2.6.14 fork)

The pre-2.6.14 fork has already diverged, with an additional patch
that further aggrevated this problem, and a more thorough overhaul
of the cpuset locking, to fix the problems.

All code paths in kernel/cpuset.c (2.6.13 or earlier) that first
grab cpuset_sem and then allocate memory _must_ call the routine
'refresh_mems()', after getting cpuset_sem, before any possible
allocation.

If this refresh_mems() call is not done, then there is a risk that one
of the cpuset_zone_allowed() calls made from within the page allocator
(__alloc_pages) will find that the mems_generation of the current task
doesn't match that of its cpuset, causing it to try to grab cpuset_sem.
Since it already held cpuset_sem, this deadlocks that task, and any
subsequent task wanting cpuset_sem.

==> The code paths leading to the kmalloc in check_for_release(), from
    cpuset_exit, cpuset_rmdir and attach_task (for the detached cpuset),
    fail to invoke refresh_mems() as required.

    The fix is easy enough - add the requisite refresh_mems() call.

Unless someone is rapidly creating, modifying and destroying cpusets,
they are unlikely to have any chance of encountering this deadlock.
And even then, it is apparently difficult to do so.

In the case we got here from cpuset_exit(), we have already torn
down the tasks connection to this cpuset and current->cpuset is NULL.
Don't call refresh_mems() in that case - it oops the kernel.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/kernel/cpuset.c
+++ linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
@@ -458,7 +458,10 @@ static void check_for_release(struct cpu
 	if (notify_on_release(cs) && atomic_read(&cs->count) == 0 &&
 	    list_empty(&cs->children)) {
 		char *buf;
+		static void refresh_mems(void);
 
+		if (current->cpuset)
+			refresh_mems();
 		buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!buf)
 			return;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
