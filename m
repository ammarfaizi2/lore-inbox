Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbTCPPmH>; Sun, 16 Mar 2003 10:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbTCPPmH>; Sun, 16 Mar 2003 10:42:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:3049 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262682AbTCPPmA>;
	Sun, 16 Mar 2003 10:42:00 -0500
Date: Sun, 16 Mar 2003 16:52:48 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: linux-kernel@vger.kernel.org
Subject: [RFC] O(1) proc_pid_readdir
Message-ID: <Pine.LNX.4.44.0303161645030.27928-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a proposal to get rid of the quadratic behaviour of 
proc_pid_readir(): Instead of storing the task number in f_pos and walking 
tasks by tasklist order, the pid is stored in f_pos and the tasks are 
walked by (hash-mangled) pid order.

--
	Manfred
<<
// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 64
//  EXTRAVERSION = -ac4
--- 2.5/include/linux/sched.h	2003-02-26 19:08:43.000000000 +0100
+++ build-2.5/include/linux/sched.h	2003-03-16 13:47:59.000000000 +0100
@@ -507,6 +507,7 @@
 
 extern struct   mm_struct init_mm;
 
+extern int find_next_pid(int pid);
 extern struct task_struct *find_task_by_pid(int pid);
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
--- 2.5/kernel/pid.c	2003-01-15 20:30:27.000000000 +0100
+++ build-2.5/kernel/pid.c	2003-03-16 15:41:43.000000000 +0100
@@ -172,13 +172,22 @@
 	if (pid)
 		atomic_inc(&pid->count);
 	else {
+		struct list_head *elem, *bucket;
+
 		pid = &task->pids[type].pid;
 		pid->nr = nr;
 		atomic_set(&pid->count, 1);
 		INIT_LIST_HEAD(&pid->task_list);
 		pid->task = task;
 		get_task_struct(task);
-		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
+		bucket = &pid_hash[type][pid_hashfn(nr)];
+		__list_for_each(elem, bucket) {
+			struct pid *walk;
+			walk = list_entry(elem, struct pid, hash_chain);
+			if (walk->nr > nr)
+		       		break;
+		}
+		list_add_tail(&pid->hash_chain, elem);
 	}
 	list_add_tail(&task->pids[type].pid_chain, &pid->task_list);
 	task->pids[type].pidptr = pid;
@@ -221,6 +230,42 @@
 	free_pidmap(nr);
 }
 
+/**
+ * find_next_pid - Returns the pid of next task.
+ * @pid: Starting point for the search.
+ *
+ * Returns the pid number of the task that follows behind
+ * "pid". The function works even if the input pid value
+ * is not valid anymore.
+ */
+ int find_next_pid(int pid)
+{
+	struct list_head *elem, *bucket;
+       
+	if(!pid) {
+		bucket = &pid_hash[PIDTYPE_PID][0];
+	} else {
+		bucket = &pid_hash[PIDTYPE_PID][pid_hashfn(pid)];
+	}
+	read_lock(&tasklist_lock);
+next_chain:
+	__list_for_each(elem, bucket) {
+		struct pid *walk;
+		walk = list_entry(elem, struct pid, hash_chain);
+		if (walk->nr > pid) {
+			pid = walk->nr;
+			read_unlock(&tasklist_lock);
+			return pid;
+		}
+	}
+	pid = 0;
+	bucket++;
+	if (bucket < &pid_hash[PIDTYPE_PID][1<<pidhash_shift])
+		goto next_chain;
+	read_unlock(&tasklist_lock);
+	return -1;
+}
+
 task_t *find_task_by_pid(int nr)
 {
 	struct pid *pid = find_pid(PIDTYPE_PID, nr);
--- 2.5/fs/proc/base.c	2003-02-21 17:53:10.000000000 +0100
+++ build-2.5/fs/proc/base.c	2003-03-16 15:40:20.000000000 +0100
@@ -1148,62 +1148,37 @@
 }
 
 #define PROC_NUMBUF 10
-#define PROC_MAXPIDS 20
-
-/*
- * Get a few pid's to return for filldir - we need to hold the
- * tasklist lock while doing this, and we must release it before
- * we actually do the filldir itself, so we use a temp buffer..
- */
-static int get_pid_list(int index, unsigned int *pids)
-{
-	struct task_struct *p;
-	int nr_pids = 0;
-
-	index--;
-	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		int pid = p->pid;
-		if (!pid)
-			continue;
-		if (--index >= 0)
-			continue;
-		pids[nr_pids] = pid;
-		nr_pids++;
-		if (nr_pids >= PROC_MAXPIDS)
-			break;
-	}
-	read_unlock(&tasklist_lock);
-	return nr_pids;
-}
 
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	unsigned int pid_array[PROC_MAXPIDS];
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
-	unsigned int nr_pids, i;
+	int pid;
 
 	if (!nr) {
 		ino_t ino = fake_ino(0,PROC_PID_INO);
 		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
 			return 0;
 		filp->f_pos++;
-		nr++;
+		nr = 1;
 	}
+	pid = nr - 1;
+	for (;;) {
+		unsigned long i, j;
+		ino_t ino;
 
-	nr_pids = get_pid_list(nr, pid_array);
-
-	for (i = 0; i < nr_pids; i++) {
-		int pid = pid_array[i];
-		ino_t ino = fake_ino(pid,PROC_PID_INO);
-		unsigned long j = PROC_NUMBUF;
+		pid = find_next_pid(pid);
+		if (pid < 0)
+			break;
 
-		do buf[--j] = '0' + (pid % 10); while (pid/=10);
+		i = pid;
+	       	j = PROC_NUMBUF;
+		do buf[--j] = '0' + (i % 10); while (i/=10);
 
+		ino = fake_ino(pid,PROC_PID_INO);
 		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
 			break;
-		filp->f_pos++;
+		filp->f_pos = pid + 1 + FIRST_PROCESS_ENTRY;
 	}
 	return 0;
 }
<<

