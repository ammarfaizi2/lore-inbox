Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUHaWb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUHaWb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269224AbUHaW3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:29:20 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22518 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268458AbUHaW0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:26:21 -0400
Subject: [PATCH] distinct tgid/tid CPU usage
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093991085.434.7112.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Aug 2004 18:24:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts /proc/*/stat to have distinct
per-process and per-thread CPU usage, faults, and
wchan. It should fit the BitKeeper tree as of about
now, following after the two waitid/rusage patches.

Signed-off-by: Albert Cahalan <albert@users.sf.net>

diff -Naurd a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2004-08-31 18:08:38.000000000 -0400
+++ b/fs/proc/array.c	2004-08-31 17:55:30.000000000 -0400
@@ -300,9 +300,9 @@
 }
 
 extern unsigned long task_vsize(struct mm_struct *);
-int proc_pid_stat(struct task_struct *task, char * buffer)
+static int do_task_stat(struct task_struct *task, char * buffer, int whole)
 {
-	unsigned long vsize, eip, esp, wchan;
+	unsigned long vsize, eip, esp, wchan = ~0ul;
 	long priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -313,6 +313,7 @@
 	struct mm_struct *mm;
 	unsigned long long start_time;
 	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
+	unsigned long  min_flt = 0,  maj_flt = 0,  utime = 0,  stime = 0;
 	char tcomm[sizeof(task->comm)];
 
 	state = *get_task_state(task);
@@ -331,7 +332,6 @@
 	}
 
 	get_task_comm(tcomm, task);
-	wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
@@ -353,18 +353,30 @@
 		cmaj_flt = task->signal->cmaj_flt;
 		cutime = task->signal->cutime;
 		cstime = task->signal->cstime;
+		if (whole) {
+			min_flt = task->signal->min_flt;
+			maj_flt = task->signal->maj_flt;
+			utime = task->signal->utime;
+			stime = task->signal->stime;
+		}
 	}
+	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 
+	if (!whole || num_threads<2)
+		wchan = get_wchan(task);
+	if (!whole) {
+		min_flt = task->min_flt;
+		maj_flt = task->maj_flt;
+		utime = task->utime;
+		stime = task->stime;
+	}
+
 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */
 	priority = task_prio(task);
 	nice = task_nice(task);
 
-	read_lock(&tasklist_lock);
-	ppid = task->pid ? task->real_parent->pid : 0;
-	read_unlock(&tasklist_lock);
-
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
@@ -380,12 +392,12 @@
 		tty_nr,
 		tty_pgrp,
 		task->flags,
-		task->min_flt,
+		min_flt,
 		cmin_flt,
-		task->maj_flt,
+		maj_flt,
 		cmaj_flt,
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime),
+		jiffies_to_clock_t(utime),
+		jiffies_to_clock_t(stime),
 		jiffies_to_clock_t(cutime),
 		jiffies_to_clock_t(cstime),
 		priority,
@@ -421,6 +433,16 @@
 	return res;
 }
 
+int proc_tid_stat(struct task_struct *task, char * buffer)
+{
+	return do_task_stat(task, buffer, 0);
+}
+
+int proc_tgid_stat(struct task_struct *task, char * buffer)
+{
+	return do_task_stat(task, buffer, 1);
+}
+
 extern int task_statm(struct mm_struct *, int *, int *, int *, int *);
 int proc_pid_statm(struct task_struct *task, char *buffer)
 {
diff -Naurd a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	2004-08-24 03:02:58.000000000 -0400
+++ b/fs/proc/base.c	2004-08-31 17:33:00.000000000 -0400
@@ -177,7 +177,8 @@
 	return PROC_I(inode)->type;
 }
 
-int proc_pid_stat(struct task_struct*,char*);
+int proc_tid_stat(struct task_struct*,char*);
+int proc_tgid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 
@@ -1320,9 +1321,12 @@
 			ei->op.proc_read = proc_pid_status;
 			break;
 		case PROC_TID_STAT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_tid_stat;
+			break;
 		case PROC_TGID_STAT:
 			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_stat;
+			ei->op.proc_read = proc_tgid_stat;
 			break;
 		case PROC_TID_CMDLINE:
 		case PROC_TGID_CMDLINE:



