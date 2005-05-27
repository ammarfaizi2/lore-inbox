Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVE0JIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVE0JIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVE0JFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:05:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53644 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262402AbVE0JDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:03:14 -0400
Date: Fri, 27 May 2005 02:02:43 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20050527090243.30833.93829.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH 2.6.12-rc4: resent] cpuset exit NULL dereference fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Resubmitting the same patch I submitted yesterday.  Simon Derr
and I agree that we need this patch now to fix a kernel crash.

The potential scaling issues are theoretical at this time.
When they become more real, we will be in a better position to
consider more ambitious changes to cpuset locking and reference
counting.

Meanwhile -- this patch is small, simple, and needed.

===

There is a race in the kernel cpuset code, between the code
to handle notify_on_release, and the code to remove a cpuset.
The notify_on_release code can end up trying to access a
cpuset that has been removed.  In the most common case, this
causes a NULL pointer dereference from the routine cpuset_path.
However all manner of bad things are possible, in theory at least.

The existing code decrements the cpuset use count, and if the
count goes to zero, processes the notify_on_release request,
if appropriate.  However, once the count goes to zero, unless we
are holding the global cpuset_sem semaphore, there is nothing to
stop another task from immediately removing the cpuset entirely,
and recycling its memory.

The obvious fix would be to always hold the cpuset_sem
semaphore while decrementing the use count and dealing with
notify_on_release.  However we don't want to force a global
semaphore into the mainline task exit path, as that might create
a scaling problem.

The actual fix is almost as easy - since this is only an issue
for cpusets using notify_on_release, which the top level big
cpusets don't normally need to use, only take the cpuset_sem
for cpusets using notify_on_release.

This code has been run for hours without a hiccup, while running
a cpuset create/destroy stress test that could crash the existing
kernel in seconds.  This patch applies to the current -linus
git kernel.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6-cpuset_path_fix/kernel/cpuset.c
===================================================================
--- 2.6-cpuset_path_fix.orig/kernel/cpuset.c	2005-05-25 19:20:27.000000000 -0700
+++ 2.6-cpuset_path_fix/kernel/cpuset.c	2005-05-26 00:50:32.000000000 -0700
@@ -166,9 +166,8 @@ static struct super_block *cpuset_sb = N
  * The hooks from fork and exit, cpuset_fork() and cpuset_exit(), don't
  * (usually) grab cpuset_sem.  These are the two most performance
  * critical pieces of code here.  The exception occurs on exit(),
- * if the last task using a cpuset exits, and the cpuset was marked
- * notify_on_release.  In that case, the cpuset_sem is taken, the
- * path to the released cpuset calculated, and a usermode call made
+ * when a task in a notify_on_release cpuset exits.  Then cpuset_sem
+ * is taken, and if the cpuset count is zero, a usermode call made
  * to /sbin/cpuset_release_agent with the name of the cpuset (path
  * relative to the root of cpuset file system) as the argument.
  *
@@ -1404,6 +1403,18 @@ void cpuset_fork(struct task_struct *tsk
  *
  * Description: Detach cpuset from @tsk and release it.
  *
+ * Note that cpusets marked notify_on_release force every task
+ * in them to take the global cpuset_sem semaphore when exiting.
+ * This could impact scaling on very large systems.  Be reluctant
+ * to use notify_on_release cpusets where very high task exit
+ * scaling is required on large systems.
+ *
+ * Don't even think about derefencing 'cs' after the cpuset use
+ * count goes to zero, except inside a critical section guarded
+ * by the cpuset_sem semaphore.  If you don't hold cpuset_sem,
+ * then a zero cpuset use count is a license to any other task to
+ * nuke the cpuset immediately.
+ *
  **/
 
 void cpuset_exit(struct task_struct *tsk)
@@ -1415,10 +1426,13 @@ void cpuset_exit(struct task_struct *tsk
 	tsk->cpuset = NULL;
 	task_unlock(tsk);
 
-	if (atomic_dec_and_test(&cs->count)) {
+	if (notify_on_release(cs)) {
 		down(&cpuset_sem);
-		check_for_release(cs);
+		if (atomic_dec_and_test(&cs->count))
+			check_for_release(cs);
 		up(&cpuset_sem);
+	} else {
+		atomic_dec(&cs->count);
 	}
 }
 

-- 
-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
