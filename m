Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266814AbUHISY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266814AbUHISY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHISXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:23:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20126 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266814AbUHISTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:19:01 -0400
Date: Mon, 9 Aug 2004 11:16:41 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc fs task name handling
Message-ID: <20040809181641.GA6204@w-mikek2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another copy of the patch to fix up path name handling in
the proc fs.  It is against 2.6.8-rc3-mm2 and contains all suggestions
previously recommended.  The new routines get/set_task_comm() are put
into fs/exec.c due to lack of a better place.

-- 
Mike

diff -Naur linux-2.6.8-rc3-mm2/fs/exec.c linux-2.6.8-rc3-mm2.work/fs/exec.c
--- linux-2.6.8-rc3-mm2/fs/exec.c	2004-08-09 16:19:55.000000000 +0000
+++ linux-2.6.8-rc3-mm2.work/fs/exec.c	2004-08-09 18:13:40.000000000 +0000
@@ -789,11 +789,27 @@
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
+void set_task_comm(struct task_struct *tsk, char *buf)
+{
+	task_lock(tsk);
+	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
+	task_unlock(tsk);
+}
+
 int flush_old_exec(struct linux_binprm * bprm)
 {
 	char * name;
 	int i, ch, retval;
 	struct files_struct *files;
+	char tcomm[sizeof(current->comm)];
 
 	/*
 	 * Make sure we have a private signal table and that
@@ -834,10 +850,11 @@
 		if (ch == '/')
 			i = 0;
 		else
-			if (i < 15)
-				current->comm[i++] = ch;
+			if (i < (sizeof(tcomm) - 1))
+				tcomm[i++] = ch;
 	}
-	current->comm[i] = '\0';
+	tcomm[i] = '\0';
+	set_task_comm(current, tcomm);
 
 	flush_thread();
 
diff -Naur linux-2.6.8-rc3-mm2/fs/proc/array.c linux-2.6.8-rc3-mm2.work/fs/proc/array.c
--- linux-2.6.8-rc3-mm2/fs/proc/array.c	2004-08-09 16:19:55.000000000 +0000
+++ linux-2.6.8-rc3-mm2.work/fs/proc/array.c	2004-08-09 16:28:19.000000000 +0000
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
@@ -309,6 +312,7 @@
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
+	char tcomm[sizeof(task->comm)];
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -321,6 +325,7 @@
 		up_read(&mm->mmap_sem);
 	}
 
+	get_task_comm(tcomm, task);
 	wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
@@ -358,7 +363,7 @@
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
-		task->comm,
+		tcomm,
 		state,
 		ppid,
 		pgid,
diff -Naur linux-2.6.8-rc3-mm2/include/linux/sched.h linux-2.6.8-rc3-mm2.work/include/linux/sched.h
--- linux-2.6.8-rc3-mm2/include/linux/sched.h	2004-08-09 16:19:55.000000000 +0000
+++ linux-2.6.8-rc3-mm2.work/include/linux/sched.h	2004-08-09 16:22:34.000000000 +0000
@@ -833,6 +833,9 @@
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 task_t *fork_idle(int);
 
+extern void set_task_comm(struct task_struct *, char *);
+extern void get_task_comm(char *, struct task_struct *);
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
