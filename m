Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRJJUyQ>; Wed, 10 Oct 2001 16:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274989AbRJJUyL>; Wed, 10 Oct 2001 16:54:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:15747 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S274862AbRJJUxy>;
	Wed, 10 Oct 2001 16:53:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 10 Oct 2001 20:54:22 GMT
Message-Id: <UTC200110102054.UAA09813.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, tip@internetwork-ag.de
Subject: Re: [Q] cannot fork w/ 1000s of procs (but still mem avail.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    hopefully a simple question to answer: I get "cannot fork" messages on my
    machine running some 20000 processes and threads (1 master proc, 3 threads)
    where each (master) process opens a socket and does IP traffic over it.
    Although there is plenty of memory left (4GB box, 2GB used, 0 swap), I get
    "cannot fork - out of memory" when trying to increase the number of procs.
    (If none of the procs does IP, I can start more [of course?!].)
    Anything I can do to increase the number of active processes using IP? Any
    kernel paramter, limit, sizing?

You run out of process numbers, I suppose.
pid is 15 bits only - look at getpid() in fork.c.
It is very easy to make it 31 bits instead, and one of my machines
has been running a system with 31 bit pids for a long time.

(Note, I am not talking about sizeof(pid_t) but just about code like

        if((++last_pid) & 0xffff8000) {
                last_pid = 300;         /* Skip daemons etc. */
                goto inside;
        }

that must be removed.)

I sent Linus a patch once or twice, will include it below if I can
find it.

Andries


Yes, found it [hand-edited to remove unrelated stuff].
I have not checked whether it still applies and still is correct.

==================================================================
>From aeb Sun Jan 23 22:47:48 2000
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] large pid and a few other fixes

Below a patch with 31-bit pids and various compilation fixes.
The fork patch makes a fork measurably faster on a system
with more than 5000 processes.

I started making CONFIG_15BIT_PID a config option,
but decided against it as long as no need had been established.
(Yesterday or so I did a grep on "all Linux sources" for
msqid_ds and shmid_ds, more in particular msg_lspid, msg_lrpid,
shm_cpid, shm_lpid, and these are used in only a handful of places,
but I have not yet studied these places. Maybe it will turn out
to be necessary to have a config option after all, say for ibcs users,
we'll see. In case you like the opposite default, change the
#ifdef CONFIG_15BIT_PID
into
#if 1
or so, below in threads.h. (But as long as 2.4 has not been released
some testing is good, to see the effects of a larger pid.
Maybe someone will adapt ps.)

Andries



diff -u --recursive --new-file ../linux-2.3.40/linux/fs/proc/base.c ./linux/fs/proc/base.c
--- ../linux-2.3.40/linux/fs/proc/base.c	Fri Jan  7 21:59:42 2000
+++ ./linux/fs/proc/base.c	Fri Jan 21 18:50:53 2000
@@ -29,9 +29,12 @@
  * inumbers of the rest of procfs (currently those are in 0x0000--0xffff).
  * As soon as we'll get a separate superblock we will be able to forget
  * about magical ranges too.
+ *
+ * For example, the define below may be replaced by
+ *	#define fake_ino(pid,ino) 0x10000
  */
 
-#define fake_ino(pid,ino) (((pid)<<16)|(ino))
+#define fake_ino(pid,ino) (((1)<<16)|(ino))
 
 ssize_t proc_pid_read_maps(struct task_struct*,struct file*,char*,size_t,loff_t*);
 int proc_pid_stat(struct task_struct*,char*);
@@ -610,7 +613,9 @@
 				return 1;
 			p = base_stuff + i;
 			while (p->name) {
-				if (filldir(dirent, p->name, p->len, filp->f_pos, fake_ino(pid, p->type)) < 0)
+				if (filldir(dirent, p->name, p->len,
+					    filp->f_pos,
+					    fake_ino(pid, p->type)) < 0)
 					return 0;
 				filp->f_pos++;
 				p++;
@@ -621,7 +626,8 @@
 
 /* building an inode */
 
-static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task, int ino)
+static struct inode *proc_pid_make_inode(struct super_block * sb,
+					 struct task_struct *task, int ino)
 {
 	struct inode * inode;
 
@@ -923,9 +929,7 @@
 			goto out;
 		pid *= 10;
 		pid += c;
-		if (!pid)
-			goto out;
-		if (pid & 0xffff0000)
+		if (pid <= 0 || pid >= PID_MAX)
 			goto out;
 	}
 
diff -u --recursive --new-file ../linux-2.3.40/linux/include/linux/threads.h ./linux/include/linux/threads.h
--- ../linux-2.3.40/linux/include/linux/threads.h	Tue Jan 11 03:29:07 2000
+++ ./linux/include/linux/threads.h	Fri Jan 21 19:12:26 2000
@@ -15,8 +15,18 @@
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
 /*
- * This controls the maximum pid allocated to a process
+ * One more than the maximum pid allocated to a process
+ * (should be positive when assigned to an int)
  */
+#ifdef CONFIG_15BIT_PID
 #define PID_MAX 0x8000
+#else
+#define PID_MAX	0x7fffffff
+#endif
+
+/*
+ * Place where we start again after a full cycle
+ */
+#define PID_MIN	300
 
 #endif
diff -u --recursive --new-file ../linux-2.3.40/linux/kernel/fork.c ./linux/kernel/fork.c
--- ../linux-2.3.40/linux/kernel/fork.c	Tue Dec 14 00:39:24 1999
+++ ./linux/kernel/fork.c	Fri Jan 21 14:30:04 2000
@@ -194,26 +194,19 @@
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
-	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-	if(last_pid >= next_safe) {
-inside:
-		next_safe = PID_MAX;
+	if(++last_pid >= next_safe) {
 		read_lock(&tasklist_lock);
 	repeat:
+		if (last_pid >= PID_MAX)
+			last_pid = PID_MIN;
+		next_safe = PID_MAX;
+
 		for_each_task(p) {
 			if(p->pid == last_pid	||
 			   p->pgrp == last_pid	||
-			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & 0xffff8000)
-						last_pid = 300;
-					next_safe = PID_MAX;
-				}
-				goto repeat;
-			}
+			   p->session == last_pid)
+				if(++last_pid >= next_safe)
+					goto repeat;
 			if(p->pid > last_pid && next_safe > p->pid)
 				next_safe = p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)

