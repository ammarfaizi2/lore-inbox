Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSGWXn4>; Tue, 23 Jul 2002 19:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSGWXny>; Tue, 23 Jul 2002 19:43:54 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:30727 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S315760AbSGWXnr>; Tue, 23 Jul 2002 19:43:47 -0400
Date: Wed, 24 Jul 2002 00:46:49 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] consolidate task->mm code + fix
Message-ID: <20020723234649.GA1706@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17X9Mi-000MZT-00*m1e0TtbIm/E* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Re-send]

The patch below consolidates some duplicate code, reduces some
indentation, and adds a freeing of a page in mem_read() that could be left
unfreed, as far as I can see.

Against 2.5.27 (sorry, I don't have bitkeeper ...)

regards
john


diff -u -r1.1.1.1 array.c
--- linux/fs/proc/array.c	2002/07/15 01:40:22	1.1.1.1
+++ linux/fs/proc/array.c	2002/07/22 23:44:29
@@ -277,15 +277,11 @@
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
-	struct mm_struct *mm;
+	struct mm_struct *mm = get_task_mm(task);
 
 	buffer = task_name(task, buffer);
 	buffer = task_state(task, buffer);
-	task_lock(task);
-	mm = task->mm;
-	if(mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
+ 
 	if (mm) {
 		buffer = task_mem(mm, buffer);
 		mmput(mm);
@@ -481,14 +477,9 @@
 
 int proc_pid_statm(struct task_struct *task, char * buffer)
 {
-	struct mm_struct *mm;
 	int size=0, resident=0, share=0, trs=0, lrs=0, drs=0, dt=0;
+	struct mm_struct *mm = get_task_mm(task);
 
-	task_lock(task);
-	mm = task->mm;
-	if(mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
 	if (mm) {
 		struct vm_area_struct * vma;
 		down_read(&mm->mmap_sem);
@@ -626,11 +617,8 @@
 	if (!tmp)
 		goto out_free1;
 
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
+	mm = get_task_mm(task);
+ 
 	retval = 0;
 	if (!mm)
 		goto out_free2;
Index: linux/fs/proc/base.c
===================================================================
RCS file: /old/linux-2.5/cvs/linux/fs/proc/base.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 base.c
--- linux/fs/proc/base.c	2002/07/15 01:40:22	1.1.1.1
+++ linux/fs/proc/base.c	2002/07/23 22:05:57
@@ -131,16 +131,11 @@
 
 static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct mm_struct * mm;
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
 	struct task_struct *task = proc_task(inode);
+	struct mm_struct * mm = get_task_mm(task);
 
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
 	if (!mm)
 		goto out;
 	down_read(&mm->mmap_sem);
@@ -203,13 +198,8 @@
 
 static int proc_pid_environ(struct task_struct *task, char * buffer)
 {
-	struct mm_struct *mm;
 	int res = 0;
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
+	struct mm_struct *mm = get_task_mm(task);
 	if (mm) {
 		int len = mm->env_end - mm->env_start;
 		if (len > PAGE_SIZE)
@@ -222,38 +212,36 @@
 
 static int proc_pid_cmdline(struct task_struct *task, char * buffer)
 {
-	struct mm_struct *mm;
 	int res = 0;
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
-	if (mm) {
-		int len = mm->arg_end - mm->arg_start;
-		if (len > PAGE_SIZE)
-			len = PAGE_SIZE;
-		res = access_process_vm(task, mm->arg_start, buffer, len, 0);
-		// If the nul at the end of args has been overwritten, then
-		// assume application is using setproctitle(3).
-		if ( res > 0 && buffer[res-1] != '\0' )
-		{
-			len = strnlen( buffer, res );
-			if ( len < res )
-			{
-			    res = len;
-			}
-			else
-			{
-				len = mm->env_end - mm->env_start;
-				if (len > PAGE_SIZE - res)
-					len = PAGE_SIZE - res;
-				res += access_process_vm(task, mm->env_start, buffer+res, len, 0);
-				res = strnlen( buffer, res );
-			}
+	int len;
+	struct mm_struct *mm = get_task_mm(task);
+	if (!mm)
+		goto out;
+
+ 	len = mm->arg_end - mm->arg_start;
+ 
+	if (len > PAGE_SIZE)
+		len = PAGE_SIZE;
+ 
+	res = access_process_vm(task, mm->arg_start, buffer, len, 0);
+
+	// If the nul at the end of args has been overwritten, then
+	// assume application is using setproctitle(3).
+	if (res > 0 && buffer[res-1] != '\0') {
+		len = strnlen(buffer, res);
+		if (len < res) {
+		    res = len;
+		} else {
+			len = mm->env_end - mm->env_start;
+			if (len > PAGE_SIZE - res)
+				len = PAGE_SIZE - res;
+			res += access_process_vm(task, mm->env_start, buffer+res, len, 0);
+			res = strnlen(buffer, res);
 		}
-		mmput(mm);
 	}
+	mmput(mm);
+
+out:
 	return res;
 }
 
@@ -421,54 +409,59 @@
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
 	char *page;
 	unsigned long src = *ppos;
-	int copied = 0;
+	int ret = -ESRCH;
 	struct mm_struct *mm;
 
-
 	if (!MAY_PTRACE(task))
-		return -ESRCH;
+		goto out;
 
+	ret = -ENOMEM;
 	page = (char *)__get_free_page(GFP_USER);
 	if (!page)
-		return -ENOMEM;
+		goto out;
 
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(task);
+	ret = 0;
+ 
+	mm = get_task_mm(task);
 	if (!mm)
-		return 0;
+		goto out_free;
 
-	if (file->private_data != (void*)((long)current->self_exec_id) ) {
-		mmput(mm);
-		return -EIO;
-	}
-		
+	ret = -EIO;
+ 
+	if (file->private_data != (void*)((long)current->self_exec_id))
+		goto out_put;
 
+	ret = 0;
+ 
 	while (count > 0) {
 		int this_len, retval;
 
 		this_len = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		retval = access_process_vm(task, src, page, this_len, 0);
 		if (!retval) {
-			if (!copied)
-				copied = -EIO;
+			if (!ret)
+				ret = -EIO;
 			break;
 		}
+
 		if (copy_to_user(buf, page, retval)) {
-			copied = -EFAULT;
+			ret = -EFAULT;
 			break;
 		}
-		copied += retval;
+ 
+		ret += retval;
 		src += retval;
 		buf += retval;
 		count -= retval;
 	}
 	*ppos = src;
+
+out_put:
 	mmput(mm);
+out_free:
 	free_page((unsigned long) page);
-	return copied;
+out:
+	return ret;
 }
 
 #define mem_write NULL
diff -u -r1.1.1.1.2.2 sched.h
--- linux/include/linux/sched.h	2002/07/22 23:25:36	1.1.1.1.2.2
+++ linux/include/linux/sched.h	2002/07/22 23:44:29
@@ -810,6 +813,27 @@
 	return res;
 }
 
+ 
+/**
+ * get_task_mm - acquire a reference to the task's mm
+ *
+ * Returns %NULL if the task has no mm. User must release
+ * the mm via mmput() after use.
+ */
+static inline struct mm_struct * get_task_mm(struct task_struct * task)
+{
+	struct mm_struct * mm;
+ 
+	task_lock(task);
+	mm = task->mm;
+	if (mm)
+		atomic_inc(&mm->mm_users);
+	task_unlock(task);
+
+	return mm;
+}
+ 
+ 
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
Index: linux/kernel/ptrace.c
===================================================================
RCS file: /old/linux-2.5/cvs/linux/kernel/ptrace.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 ptrace.c
--- linux/kernel/ptrace.c	2002/07/22 23:25:36	1.1.1.1.2.1
+++ linux/kernel/ptrace.c	2002/07/22 23:44:29
@@ -124,12 +124,7 @@
 	struct page *page;
 	void *old_buf = buf;
 
-	/* Worry about races with exit() */
-	task_lock(tsk);
-	mm = tsk->mm;
-	if (mm)
-		atomic_inc(&mm->mm_users);
-	task_unlock(tsk);
+	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;
 
