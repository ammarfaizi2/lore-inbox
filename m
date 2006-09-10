Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWIJBja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWIJBja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 21:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWIJBja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 21:39:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50107 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965077AbWIJBja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 21:39:30 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Sat, 09 Sep 2006 18:39:20 -0700
Message-Id: <20060910013920.5857.69514.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset: fix obscure attach_task vs exiting race
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix obscure race condition in kernel/cpuset.c attach_task() code.

There is basically zero chance of anyone accidentally being
harmed by this race.

It requires a special 'micro-stress' load and a special timing
loop hacks in the kernel to hit in less than an hour, and even
then you'd have to hit it hundreds or thousands of times,
followed by some unusual and senseless cpuset configuration
requests, including removing the top cpuset, to cause any
visibly harm affects.

One could, with perhaps a few days or weeks of such effort,
get the reference count on the top cpuset below zero, and manage
to crash the kernel by asking to remove the top cpuset.

I found it by code inspection.

The race was introduced when 'the_top_cpuset_hack' was
introduced, and one piece of code was not updated.  An old check
for a possibly null task cpuset pointer needed to be changed
to a check for a task marked PF_EXITING.  The pointer can't
be null anymore, thanks to the_top_cpuset_hack (documented in
kernel/cpuset.c).  But the task could have gone into PF_EXITING
state after it was found in the task_list scan.

If a task is PF_EXITING in this code, it is possible that
its task->cpuset pointer is pointing to the top cpuset due
to the_top_cpuset_hack, rather than because the top_cpuset was
that tasks last valid cpuset.  In that case, the wrong cpuset
reference counter would be decremented.

The fix is trivial.  Instead of failing the system call if the
tasks cpuset pointer is null here, fail it if the task is in
PF_EXITING state.

The code for 'the_top_cpuset_hack' that changes an exiting tasks
cpuset to the top_cpuset is done without locking, so could
happen at anytime.  But it is done during the exit handling,
after the PF_EXITING flag is set.  So if we verify that a task
is still not PF_EXITING after we copy out its cpuset pointer
(into 'oldcs', below), we know that 'oldcs' is not one of these
hack references to the top_cpuset.

Signed-off-by: Paul Jackson

---

 kernel/cpuset.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 2.6.18-rc6-mm1.orig/kernel/cpuset.c	2006-09-08 22:00:24.044717202 -0700
+++ 2.6.18-rc6-mm1/kernel/cpuset.c	2006-09-09 18:25:24.575654834 -0700
@@ -1225,7 +1225,12 @@ static int attach_task(struct cpuset *cs
 
 	task_lock(tsk);
 	oldcs = tsk->cpuset;
-	if (!oldcs) {
+	/*
+	 * After getting 'oldcs' cpuset ptr, be sure still not exiting.
+	 * If 'oldcs' might be the top_cpuset due to the_top_cpuset_hack
+	 * then fail this attach_task(), to avoid breaking top_cpuset.count.
+	 */
+	if (tsk->flags & PF_EXITING) {
 		task_unlock(tsk);
 		mutex_unlock(&callback_mutex);
 		put_task_struct(tsk);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
