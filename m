Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267811AbUHEUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267811AbUHEUaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUHEUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:30:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17270 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267811AbUHEU3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:29:55 -0400
Date: Thu, 5 Aug 2004 21:29:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] clarify get_task_mm (mmgrab)
Message-ID: <Pine.LNX.4.44.0408052125030.2563-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify mmgrab by collapsing it into get_task_mm (in fork.c not inline),
and commenting on the special case it is guarding against: when use_mm
in an AIO daemon temporarily adopts the mm while it's on its way out.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.8-rc3-mm1/fs/proc/array.c	2004-08-05 12:13:06.000000000 +0100
+++ linux/fs/proc/array.c	2004-08-05 20:25:43.968797320 +0100
@@ -311,11 +311,7 @@ int proc_pid_stat(struct task_struct *ta
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
-	task_lock(task);
-	mm = task->mm;
-	if(mm)
-		mm = mmgrab(mm);
-	task_unlock(task);
+	mm = get_task_mm(task);
 	if (mm) {
 		down_read(&mm->mmap_sem);
 		vsize = task_vsize(mm);
--- 2.6.8-rc3-mm1/include/linux/sched.h	2004-08-05 12:13:07.000000000 +0100
+++ linux/include/linux/sched.h	2004-08-05 20:25:43.990793976 +0100
@@ -941,8 +941,8 @@ static inline void mmdrop(struct mm_stru
 
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
-/* Grab a reference to the mm if its not already going away */
-extern struct mm_struct *mmgrab(struct mm_struct *);
+/* Grab a reference to a task's mm, if it is not already going away */
+extern struct mm_struct *get_task_mm(struct task_struct *task);
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(struct task_struct *, struct mm_struct *);
 
@@ -1043,27 +1043,7 @@ static inline void task_unlock(struct ta
 {
 	spin_unlock(&p->alloc_lock);
 }
- 
-/**
- * get_task_mm - acquire a reference to the task's mm
- *
- * Returns %NULL if the task has no mm. User must release
- * the mm via mmput() after use.
- */
-static inline struct mm_struct * get_task_mm(struct task_struct * task)
-{
-	struct mm_struct * mm;
- 
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		mm = mmgrab(mm);
-	task_unlock(task);
 
-	return mm;
-}
- 
- 
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
--- 2.6.8-rc3-mm1/kernel/fork.c	2004-08-05 12:13:07.000000000 +0100
+++ linux/kernel/fork.c	2004-08-05 20:25:44.008791240 +0100
@@ -483,20 +483,34 @@ void mmput(struct mm_struct *mm)
 	}
 }
 
-/*
- * Checks if the use count of an mm is non-zero and if so
- * returns a reference to it after bumping up the use count.
- * If the use count is zero, it means this mm is going away,
- * so return NULL.
+/**
+ * get_task_mm - acquire a reference to the task's mm
+ *
+ * Returns %NULL if the task has no mm.  Checks if the use count
+ * of the mm is non-zero and if so returns a reference to it, after
+ * bumping up the use count.  User must release the mm via mmput()
+ * after use.  Typically used by /proc and ptrace.
+ *
+ * If the use count is zero, it means that this mm is going away,
+ * so return %NULL.  This only happens in the case of an AIO daemon
+ * which has temporarily adopted an mm (see use_mm), in the course
+ * of its final mmput, before exit_aio has completed.
  */
-struct mm_struct *mmgrab(struct mm_struct *mm)
+struct mm_struct *get_task_mm(struct task_struct *task)
 {
-	spin_lock(&mmlist_lock);
-	if (!atomic_read(&mm->mm_users))
-		mm = NULL;
-	else
-		atomic_inc(&mm->mm_users);
-	spin_unlock(&mmlist_lock);
+	struct mm_struct *mm;
+ 
+	task_lock(task);
+	mm = task->mm;
+	if (mm) {
+		spin_lock(&mmlist_lock);
+		if (!atomic_read(&mm->mm_users))
+			mm = NULL;
+		else
+			atomic_inc(&mm->mm_users);
+		spin_unlock(&mmlist_lock);
+	}
+	task_unlock(task);
 	return mm;
 }
 

