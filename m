Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUGGVx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUGGVx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUGGVx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:53:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15293 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265510AbUGGVxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:53:46 -0400
Date: Wed, 7 Jul 2004 14:52:46 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-ID: <20040707215246.GB4314@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com> <20040701151935.1f61793c.akpm@osdl.org> <20040701224215.GC5090@w-mikek2.beaverton.ibm.com> <20040701160335.229cfe03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701160335.229cfe03.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 04:03:35PM -0700, Andrew Morton wrote:
> 
> If we need locking around task->comm (and it seems that we do) then
> let's do it.
> 
> void get_task_comm(char *buf, struct task_struct *tsk);
> void set_task_comm(struct task_struct *tsk, char *buf);
> 
> It would be a bit lame to add a new lock for this - probably
> task_lock() could be coopted.

OK - Here is a patch to implement/use the routines above.  I couldn't
decide on a good location (file) for them so I put them in 'fs/exec/c'
which is where the existing set_task_comm functionality resides.  In
addition, I took the liberty of replacing the code in 'fs/proc/array.c'
that replicates the code in get_task_mm() with a simple call to the
routine.

-- 
Mike

diff -Naur linux-2.6.7/fs/exec.c linux-2.6.7.ptest2/fs/exec.c
--- linux-2.6.7/fs/exec.c	Wed Jun 16 05:19:13 2004
+++ linux-2.6.7.ptest2/fs/exec.c	Wed Jul  7 21:46:20 2004
@@ -786,10 +786,33 @@
 	spin_unlock(&files->file_lock);
 }
 
+void get_task_comm(char *buf, struct task_struct *tsk)
+{
+	/* buf must be at least sizeof(tsk->comm) in size */
+	task_lock(tsk);
+	memcpy(buf, tsk->comm, sizeof(tsk->comm));
+	task_unlock(tsk);
+}
+
+void set_task_comm(struct task_struct *tsk, char *name)
+{
+	int i, ch;
+
+	task_lock(tsk);
+	for (i=0; (ch = *(name++)) != '\0';) {
+		if (ch == '/')
+			i = 0;
+		else
+			if (i < (sizeof(tsk->comm) - 1))
+				tsk->comm[i++] = ch;
+	}
+	tsk->comm[i] = '\0';
+	task_unlock(tsk);
+}
+
 int flush_old_exec(struct linux_binprm * bprm)
 {
-	char * name;
-	int i, ch, retval;
+	int retval;
 	struct files_struct *files;
 
 	/*
@@ -826,15 +849,8 @@
 
 	if (current->euid == current->uid && current->egid == current->gid)
 		current->mm->dumpable = 1;
-	name = bprm->filename;
-	for (i=0; (ch = *(name++)) != '\0';) {
-		if (ch == '/')
-			i = 0;
-		else
-			if (i < 15)
-				current->comm[i++] = ch;
-	}
-	current->comm[i] = '\0';
+
+	set_task_comm(current, bprm->filename);
 
 	flush_thread();
 
diff -Naur linux-2.6.7/fs/proc/array.c linux-2.6.7.ptest2/fs/proc/array.c
--- linux-2.6.7/fs/proc/array.c	Wed Jun 16 05:19:36 2004
+++ linux-2.6.7.ptest2/fs/proc/array.c	Wed Jul  7 17:41:28 2004
@@ -88,10 +88,13 @@
 {
 	int i;
 	char * name;
+	char tcomm[sizeof(p->comm)];
+
+	get_task_comm(tcomm, p);
 
 	ADDBUF(buf, "Name:\t");
-	name = p->comm;
-	i = sizeof(p->comm);
+	name = tcomm;
+	i = sizeof(tcomm);
 	do {
 		unsigned char c = *name;
 		name++;
@@ -308,14 +311,11 @@
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
+	char tcomm[sizeof(task->comm)];
 
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
@@ -324,6 +324,7 @@
 		up_read(&mm->mmap_sem);
 	}
 
+	get_task_comm(tcomm, task);
 	wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
@@ -361,7 +362,7 @@
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
-		task->comm,
+		tcomm,
 		state,
 		ppid,
 		pgid,
diff -Naur linux-2.6.7/include/linux/sched.h linux-2.6.7.ptest2/include/linux/sched.h
--- linux-2.6.7/include/linux/sched.h	Wed Jun 16 05:18:57 2004
+++ linux-2.6.7.ptest2/include/linux/sched.h	Tue Jul  6 22:39:25 2004
@@ -868,6 +868,9 @@
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 
+extern void set_task_comm(struct task_struct *, char *);
+extern void get_task_comm(char *, struct task_struct *);
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
