Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135339AbREANdf>; Tue, 1 May 2001 09:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136001AbREANdY>; Tue, 1 May 2001 09:33:24 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:38334 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135339AbREANdF>; Tue, 1 May 2001 09:33:05 -0400
Message-ID: <3AEEBAD7.27203DCA@uow.edu.au>
Date: Tue, 01 May 2001 23:32:07 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <telomerase@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New rtl8139 driver prevents ssh from exiting.
In-Reply-To: <20010501124124.1532.qmail@web5202.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> The kernel thread the new rtl8139 driver spawns
> apparently wants to write to stdout, because it counts
> as an unfinished process that prevents an ssh session
> from exiting.

Does this help?


--- linux-2.4.4-pre3/kernel/sched.c	Sun Apr 15 15:34:25 2001
+++ linux-akpm/kernel/sched.c	Mon Apr 16 20:40:47 2001
@@ -32,6 +32,7 @@
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
+extern struct task_struct *child_reaper;
 
 /*
  * scheduler variables
@@ -1260,32 +1261,53 @@
 /*
  *	Put all the gunge required to become a kernel thread without
  *	attached user resources in one place where it belongs.
+ *
+ * 	Kernel 2.4.4-pre3, andrewm#uow.edu.au: reparent the caller
+ *	to init and set the exit signal to SIGCHLD so the thread
+ *	will be properly reaped if it exist.
  */
 
 void daemonize(void)
 {
 	struct fs_struct *fs;
-
+	struct task_struct *this_task = current;
 
 	/*
 	 * If we were started as result of loading a module, close all of the
 	 * user space pages.  We don't need them, and if we didn't close them
 	 * they would be locked into memory.
 	 */
-	exit_mm(current);
+	exit_mm(this_task);
 
-	current->session = 1;
-	current->pgrp = 1;
+	this_task->session = 1;
+	this_task->pgrp = 1;
 
 	/* Become as one with the init task */
 
-	exit_fs(current);	/* current->fs->count--; */
+	exit_fs(this_task);		/* this_task->fs->count--; */
 	fs = init_task.fs;
-	current->fs = fs;
+	this_task->fs = fs;
 	atomic_inc(&fs->count);
- 	exit_files(current);
-	current->files = init_task.files;
-	atomic_inc(&current->files->count);
+ 	exit_files(this_task);		/* this_task->files->count-- */
+	this_task->files = init_task.files;
+	atomic_inc(&this_task->files->count);
+
+	write_lock_irq(&tasklist_lock);
+
+	/* Reparent to init */
+	REMOVE_LINKS(this_task);
+	this_task->p_pptr = child_reaper;
+	this_task->p_opptr = child_reaper;
+	SET_LINKS(this_task);
+
+	/* Set the exit signal to SIGCHLD so we signal init on exit */
+	if (this_task->exit_signal != 0) {
+		printk(KERN_ERR "task `%s' exit_signal %d in daemonize()\n",
+			this_task->comm, this_task->exit_signal);
+	}
+	this_task->exit_signal = SIGCHLD;
+
+	write_unlock_irq(&tasklist_lock);
 }
 
 void __init init_idle(void)
