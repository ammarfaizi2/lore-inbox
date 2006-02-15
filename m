Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWBOGbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBOGbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBOGbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:31:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60878 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932376AbWBOGbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:31:08 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Date: Tue, 14 Feb 2006 22:30:58 -0800
Message-Id: <20060215063058.22043.61848.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: oops in exit on null cpuset fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix a latent bug in cpuset_exit() handling.  If a task tried
to allocate memory after calling cpuset_exit(), it oops'd in
cpuset_update_task_memory_state() on a NULL cpuset pointer.

So set the exiting tasks cpuset to the root cpuset instead of
to NULL.

A distro kernel hit this with an added kernel package that had
just such a hook (allocating memory) in the exit code path.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletion(-)

--- 2.6.16-rc2-mm1.orig/kernel/cpuset.c	2006-02-14 19:33:40.451668121 -0800
+++ 2.6.16-rc2-mm1/kernel/cpuset.c	2006-02-14 22:26:35.488167828 -0800
@@ -2022,6 +2022,39 @@ void cpuset_fork(struct task_struct *chi
  * We don't need to task_lock() this reference to tsk->cpuset,
  * because tsk is already marked PF_EXITING, so attach_task() won't
  * mess with it, or task is a failed fork, never visible to attach_task.
+ *
+ * Hack:
+ *
+ *    Set the exiting tasks cpuset to the root cpuset (top_cpuset).
+ *
+ *    Don't leave a task unable to allocate memory, as that is an
+ *    accident waiting to happen should someone add a callout in
+ *    do_exit() after the cpuset_exit() call that might allocate.
+ *    If a task tries to allocate memory with an invalid cpuset,
+ *    it will oops in cpuset_update_task_memory_state().
+ *
+ *    We call cpuset_exit() while the task is still competent to
+ *    handle notify_on_release(), then leave the task attached to
+ *    the root cpuset (top_cpuset) for the remainder of its exit.
+ *
+ *    To do this properly, we would increment the reference count on
+ *    top_cpuset, and near the very end of the kernel/exit.c do_exit()
+ *    code we would add a second cpuset function call, to drop that
+ *    reference.  This would just create an unnecessary hot spot on
+ *    the top_cpuset reference count, to no avail.
+ *
+ *    Normally, holding a reference to a cpuset without bumping its
+ *    count is unsafe.   The cpuset could go away, or someone could
+ *    attach us to a different cpuset, decrementing the count on
+ *    the first cpuset that we never incremented.  But in this case,
+ *    top_cpuset isn't going away, and either task has PF_EXITING set,
+ *    which wards off any attach_task() attempts, or task is a failed
+ *    fork, never visible to attach_task.
+ *
+ *    Another way to do this would be to set the cpuset pointer
+ *    to NULL here, and check in cpuset_update_task_memory_state()
+ *    for a NULL pointer.  This hack avoids that NULL check, for no
+ *    cost (other than this way too long comment ;).
  **/
 
 void cpuset_exit(struct task_struct *tsk)
@@ -2029,7 +2062,7 @@ void cpuset_exit(struct task_struct *tsk
 	struct cpuset *cs;
 
 	cs = tsk->cpuset;
-	tsk->cpuset = NULL;
+	tsk->cpuset = &top_cpuset;	/* Hack - see comment above */
 
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
