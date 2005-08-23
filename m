Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVHWUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVHWUgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVHWUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:36:33 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:30733 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932384AbVHWUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:36:32 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:33:31 +0200)
Subject: [PATCH 5/8] remove duplicated code from proc and ptrace
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:36:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extract common code used by ptrace_attach() and may_ptrace_attach()
into a separate function.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/kernel/ptrace.c
===================================================================
--- linux.orig/kernel/ptrace.c	2005-08-19 14:47:20.000000000 +0200
+++ linux/kernel/ptrace.c	2005-08-19 14:47:36.000000000 +0200
@@ -118,6 +118,33 @@ int ptrace_check_attach(struct task_stru
 	return ret;
 }
 
+static int may_attach(struct task_struct *task)
+{
+	if (!task->mm)
+		return -EPERM;
+	if (((current->uid != task->euid) ||
+	     (current->uid != task->suid) ||
+	     (current->uid != task->uid) ||
+	     (current->gid != task->egid) ||
+	     (current->gid != task->sgid) ||
+	     (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
+		return -EPERM;
+	smp_rmb();
+	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
+		return -EPERM;
+
+	return security_ptrace(current, task);
+}
+
+int ptrace_may_attach(struct task_struct *task)
+{
+	int err;
+	task_lock(task);
+	err = may_attach(task);
+	task_unlock(task);
+	return !err;
+}
+
 int ptrace_attach(struct task_struct *task)
 {
 	int retval;
@@ -127,22 +154,10 @@ int ptrace_attach(struct task_struct *ta
 		goto bad;
 	if (task == current)
 		goto bad;
-	if (!task->mm)
-		goto bad;
-	if(((current->uid != task->euid) ||
-	    (current->uid != task->suid) ||
-	    (current->uid != task->uid) ||
- 	    (current->gid != task->egid) ||
- 	    (current->gid != task->sgid) ||
- 	    (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
-		goto bad;
-	smp_rmb();
-	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
-		goto bad;
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
-	retval = security_ptrace(current, task);
+	retval = may_attach(task);
 	if (retval)
 		goto bad;
 
Index: linux/include/linux/ptrace.h
===================================================================
--- linux.orig/include/linux/ptrace.h	2005-08-19 14:47:20.000000000 +0200
+++ linux/include/linux/ptrace.h	2005-08-19 14:47:36.000000000 +0200
@@ -90,6 +90,7 @@ extern void __ptrace_link(struct task_st
 			  struct task_struct *new_parent);
 extern void __ptrace_unlink(struct task_struct *child);
 extern void ptrace_untrace(struct task_struct *child);
+extern int ptrace_may_attach(struct task_struct *task);
 
 static inline void ptrace_link(struct task_struct *child,
 			       struct task_struct *new_parent)
Index: linux/fs/proc/base.c
===================================================================
--- linux.orig/fs/proc/base.c	2005-08-19 14:47:36.000000000 +0200
+++ linux/fs/proc/base.c	2005-08-19 14:47:36.000000000 +0200
@@ -347,33 +347,6 @@ static int proc_root_link(struct inode *
 	 (task->state == TASK_STOPPED || task->state == TASK_TRACED) && \
 	 security_ptrace(current,task) == 0))
 
-static int may_ptrace_attach(struct task_struct *task)
-{
-	int retval = 0;
-
-	task_lock(task);
-
-	if (!task->mm)
-		goto out;
-	if (((current->uid != task->euid) ||
-	     (current->uid != task->suid) ||
-	     (current->uid != task->uid) ||
-	     (current->gid != task->egid) ||
-	     (current->gid != task->sgid) ||
-	     (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
-		goto out;
-	rmb();
-	if (task->mm->dumpable != 1 && !capable(CAP_SYS_PTRACE))
-		goto out;
-	if (security_ptrace(current, task))
-		goto out;
-
-	retval = 1;
-out:
-	task_unlock(task);
-	return retval;
-}
-
 static int proc_pid_environ(struct task_struct *task, char * buffer)
 {
 	int res = 0;
@@ -383,7 +356,7 @@ static int proc_pid_environ(struct task_
 		if (len > PAGE_SIZE)
 			len = PAGE_SIZE;
 		res = access_process_vm(task, mm->env_start, buffer, len, 0);
-		if (!may_ptrace_attach(task))
+		if (!ptrace_may_attach(task))
 			res = -ESRCH;
 		mmput(mm);
 	}
@@ -686,7 +659,7 @@ static ssize_t mem_read(struct file * fi
 	int ret = -ESRCH;
 	struct mm_struct *mm;
 
-	if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
+	if (!MAY_PTRACE(task) || !ptrace_may_attach(task))
 		goto out;
 
 	ret = -ENOMEM;
@@ -712,7 +685,7 @@ static ssize_t mem_read(struct file * fi
 
 		this_len = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		retval = access_process_vm(task, src, page, this_len, 0);
-		if (!retval || !MAY_PTRACE(task) || !may_ptrace_attach(task)) {
+		if (!retval || !MAY_PTRACE(task) || !ptrace_may_attach(task)) {
 			if (!ret)
 				ret = -EIO;
 			break;
@@ -750,7 +723,7 @@ static ssize_t mem_write(struct file * f
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
 	unsigned long dst = *ppos;
 
-	if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
+	if (!MAY_PTRACE(task) || !ptrace_may_attach(task))
 		return -ESRCH;
 
 	page = (char *)__get_free_page(GFP_USER);
