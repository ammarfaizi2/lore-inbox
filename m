Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWALRsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWALRsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWALRsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:48:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932481AbWALRsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:48:31 -0500
Date: Thu, 12 Jan 2006 09:48:02 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Arjan van de Ven <arjan@infradead.org>, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
       Jes Sorensen <jes@trained-monkey.org>, Paul Jackson <pj@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20060112174802.21396.63708.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] kernel/cpuset.c mutex conversion comment fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of kernel/cpuset from semaphores to mutexes
missed some comments - thanks to Joe Perches for reporting this.

I didn't know offhand the state of read-write mutexes, so just
removed the hypothetical comment involving read-write semaphores,
rather than investigate how to reword it.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

This goes on top of [PATCH v2] kernel/cpuset.c, mutex conversion.

 kernel/cpuset.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

--- 2.6.15-mm2.orig/kernel/cpuset.c	2006-01-12 07:53:37.345145712 -0800
+++ 2.6.15-mm2/kernel/cpuset.c	2006-01-12 09:44:38.065160378 -0800
@@ -168,12 +168,12 @@ static struct vfsmount *cpuset_mount;
 static struct super_block *cpuset_sb;
 
 /*
- * We have two global cpuset semaphores below.  They can nest.
+ * We have two global cpuset mutexes below.  They can nest.
  * It is ok to first take manage_mutex, then nest callback_mutex.  We also
  * require taking task_lock() when dereferencing a tasks cpuset pointer.
  * See "The task_lock() exception", at the end of this comment.
  *
- * A task must hold both semaphores to modify cpusets.  If a task
+ * A task must hold both mutexes to modify cpusets.  If a task
  * holds manage_mutex, then it blocks others wanting that mutex,
  * ensuring that it is the only task able to also acquire callback_mutex
  * and be able to modify cpusets.  It can perform various checks on
@@ -197,7 +197,7 @@ static struct super_block *cpuset_sb;
  * Any task can increment and decrement the count field without lock.
  * So in general, code holding manage_mutex or callback_mutex can't rely
  * on the count field not changing.  However, if the count goes to
- * zero, then only attach_task(), which holds both semaphores, can
+ * zero, then only attach_task(), which holds both mutexes, can
  * increment it again.  Because a count of zero means that no tasks
  * are currently attached, therefore there is no way a task attached
  * to that cpuset can fork (the other way to increment the count).
@@ -205,13 +205,7 @@ static struct super_block *cpuset_sb;
  * if the count is zero, it will stay zero.  Similarly, if a task
  * holds manage_mutex or callback_mutex on a cpuset with zero count, it
  * knows that the cpuset won't be removed, as cpuset_rmdir() needs
- * both of those semaphores.
- *
- * A possible optimization to improve parallelism would be to make
- * callback_mutex a R/W mutex (rwsem), allowing the callback routines
- * to proceed in parallel, with read access, until the holder of
- * manage_mutex needed to take this rwsem for exclusive write access
- * and modify some cpusets.
+ * both of those mutexes.
  *
  * The cpuset_common_file_write handler for operations that modify
  * the cpuset hierarchy holds manage_mutex across the entire operation,
@@ -242,7 +236,7 @@ static struct super_block *cpuset_sb;
  *
  * The need for this exception arises from the action of attach_task(),
  * which overwrites one tasks cpuset pointer with another.  It does
- * so using both semaphores, however there are several performance
+ * so using both mutexes, however there are several performance
  * critical places that need to reference task->cpuset without the
  * expense of grabbing a system global mutex.  Therefore except as
  * noted below, when dereferencing or, as in attach_task(), modifying
@@ -1598,7 +1592,7 @@ static int pid_array_to_buf(char *buf, i
  * Handle an open on 'tasks' file.  Prepare a buffer listing the
  * process id's of tasks currently attached to the cpuset being opened.
  *
- * Does not require any specific cpuset semaphores, and does not take any.
+ * Does not require any specific cpuset mutexes, and does not take any.
  */
 static int cpuset_tasks_open(struct inode *unused, struct file *file)
 {
@@ -1972,7 +1966,7 @@ void cpuset_fork(struct task_struct *chi
  *
  * This routine has to take manage_mutex, not callback_mutex, because
  * it is holding that mutex while calling check_for_release(),
- * which calls kmalloc(), so can't be called holding callback__sem().
+ * which calls kmalloc(), so can't be called holding callback_mutex().
  *
  * We don't need to task_lock() this reference to tsk->cpuset,
  * because tsk is already marked PF_EXITING, so attach_task() won't

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
