Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJSBT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTJSBT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 21:19:59 -0400
Received: from holomorphy.com ([66.224.33.161]:23949 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261953AbTJSBTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 21:19:55 -0400
Date: Sat, 18 Oct 2003 18:19:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-ID: <20031019011949.GD711@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja Garc?a <aradorlinux@yahoo.es>,
	linux-kernel@vger.kernel.org
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018234848.51a2b723.aradorlinux@yahoo.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 11:48:48PM +0200, Diego Calleja Garc?a wrote:
> Hi, I got some oops with test8; the first time I got it it was under
> test8-wli1; but it seems the same is happening under plain -test8.
> This is the original bug report:
> The system was working well. Then I decided to run totem - a neat
> video player. It hanged. Trying to kill it I did "ps xa"; suprisingly
> after pid 560 ps (and the terminal) stopped and hanged. The rest of
were still alive. Then I fired another terminal, did /proc/562 (the
> following pid after 560); I run ls; and ls hanged. I fired another
> terminal, and I did 'find /proc'; and I got the oops. Some seconds
> after that the system locked up completely. Box is a dual p3; 256 MB
> ram, ide disks, running debian sid, no NPTL. Config pasted below.

Two stupid bugs in my case. With a bit of noise surrounding things
(e.g. EXPORT_SYMBOL() crud, init_task paranoia garbage, ->f_pos in
unsigned long removal), un-reversing the arguments to find_pid()
and not blowing away the last-seen tid while formatting it and later
trying to use it as ->f_pos are the needed fixes.


-- wli


diff -prauN wli-2.6.0-test8-38/fs/proc/base.c wli-2.6.0-test8-39/fs/proc/base.c
--- wli-2.6.0-test8-38/fs/proc/base.c	2003-10-17 19:16:54.000000000 -0700
+++ wli-2.6.0-test8-39/fs/proc/base.c	2003-10-18 18:01:43.000000000 -0700
@@ -1673,44 +1673,43 @@ static int proc_task_readdir(struct file
 	struct inode *inode = dentry->d_inode;
 	int retval = -ENOENT;
 	ino_t ino;
-	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
 	if (!pid_alive(proc_task(inode)))
 		goto out;
 	retval = 0;
 
-	switch (pos) {
+	switch (filp->f_pos) {
 	case 0:
 		ino = inode->i_ino;
-		if (filldir(dirent, ".", 1, pos, ino, DT_DIR) < 0)
+		if (filldir(dirent, ".", 1, filp->f_pos, ino, DT_DIR) < 0)
 			goto out;
-		pos++;
+		filp->f_pos++;
 		/* fall through */
 	case 1:
 		ino = parent_ino(dentry);
-		if (filldir(dirent, "..", 2, pos, ino, DT_DIR) < 0)
+		if (filldir(dirent, "..", 2, filp->f_pos, ino, DT_DIR) < 0)
 			goto out;
-		pos++;
+		filp->f_pos++;
 		/* fall through */
 	}
 
-	nr_tids = find_tids_after(proc_task(inode)->tgid, pos - 2, tid_array);
+	nr_tids = find_tids_after(proc_task(inode)->tgid, filp->f_pos - 2, tid_array);
 
 	for (i = 0; i < nr_tids; i++) {
-		unsigned long j = PROC_NUMBUF;
+		unsigned long k, j = PROC_NUMBUF;
 		int tid = tid_array[i];
 
 		ino = fake_ino(tid, PROC_TID_INO);
 
+		k = tid;
 		do
-			buf[--j] = '0' + (tid % 10);
-		while (tid /= 10);
+			buf[--j] = '0' + (k % 10);
+		while (k /= 10);
 
-		if (filldir(dirent, buf+j, PROC_NUMBUF-j, pos, ino, DT_DIR) < 0)
+		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
 			break;
-		pos = tid + 2;
+		filp->f_pos = tid + 2;
 	}
 out:
-	filp->f_pos = pos;
 	return retval;
 }
diff -prauN wli-2.6.0-test8-38/include/linux/init_task.h wli-2.6.0-test8-39/include/linux/init_task.h
--- wli-2.6.0-test8-38/include/linux/init_task.h	2003-10-17 19:14:11.000000000 -0700
+++ wli-2.6.0-test8-39/include/linux/init_task.h	2003-10-18 17:23:20.000000000 -0700
@@ -56,6 +56,29 @@
 	.siglock	= SPIN_LOCK_UNLOCKED, 		\
 }
 
+#define INIT_PID(tsk, type)						\
+{									\
+	.nr	= 0,							\
+	.count	= ATOMIC_INIT(1),					\
+	.task	= &(tsk),						\
+	.task_list = {							\
+			.rb_node = NULL,				\
+		},							\
+	.hash_chain = LIST_HEAD_INIT((tsk).pids[type].pid.hash_chain),	\
+}
+
+#define INIT_PID_LINK(task, type)			\
+	{						\
+		.pid_chain	= {			\
+			.rb_parent = NULL,		\
+			.rb_left  = NULL,		\
+			.rb_right = NULL,		\
+			.rb_color = RB_BLACK,		\
+		},					\
+		.pidptr		= NULL,			\
+		.pid		= INIT_PID(task, type),	\
+	}
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -113,6 +136,12 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.pids		= {						\
+				INIT_PID_LINK(tsk, 0),			\
+				INIT_PID_LINK(tsk, 1),			\
+				INIT_PID_LINK(tsk, 2),			\
+				INIT_PID_LINK(tsk, 3),			\
+			},						\
 }
 
 
diff -prauN wli-2.6.0-test8-38/kernel/pid.c wli-2.6.0-test8-39/kernel/pid.c
--- wli-2.6.0-test8-38/kernel/pid.c	2003-10-17 19:16:54.000000000 -0700
+++ wli-2.6.0-test8-39/kernel/pid.c	2003-10-18 18:02:45.000000000 -0700
@@ -167,6 +167,7 @@ task_t *first_task(void)
 	BUG_ON(!node);
 	return rb_entry(node, task_t, tasks);
 }
+EXPORT_SYMBOL(first_task);
 
 void insert_task_list(task_t *task)
 {
@@ -339,6 +340,7 @@ int find_tgids_after(int tgid, int tgids
 	read_unlock(&tasklist_lock);
 	return k;
 }
+EXPORT_SYMBOL(find_tgids_after);
 
 int find_tids_after(int tgid, int tid, int tids[PROC_MAXPIDS])
 {
@@ -348,7 +350,7 @@ int find_tids_after(int tgid, int tid, i
 	int k = 0;
 
 	read_lock(&tasklist_lock);
-	pid = find_pid(tgid, PIDTYPE_TGID);
+	pid = find_pid(PIDTYPE_TGID, tgid);
 	if (!pid)
 		goto out;
 	node = pid->task_list.rb_node;
@@ -373,6 +375,7 @@ out:
 	read_unlock(&tasklist_lock);
 	return k;
 }
+EXPORT_SYMBOL(find_tids_after);
 
 task_t *find_task_by_pid(int nr)
 {
