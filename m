Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270982AbRHOAfN>; Tue, 14 Aug 2001 20:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270983AbRHOAfD>; Tue, 14 Aug 2001 20:35:03 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:62993 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270982AbRHOAez>; Tue, 14 Aug 2001 20:34:55 -0400
Message-ID: <3B79C3A9.52562F71@zip.com.au>
Date: Tue, 14 Aug 2001 17:34:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010814221556.A7704@lightning.swansea.linux.org.uk> <3B79B43D.B9350226@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Alan Cox wrote:
> > *
> > *       This is a fairly experimental -ac so please treat it with care
> > *
> >
> > 2.4.8-ac5
> 
> Hi Alan,
> 
> 2.4.8-ac5 makes the kpnpbios kernel thread go zombie here every time right
> during boot.

Interesting that kpnpbiosd has a ppid of zero, whereas keventd, which
is started a few statements later has a ppid of one.  hmmm..

Signalling, exitting from and waiting upon kernel threads is all
screwed up.  Sometimes it's because a userspace process doesn't
reap children.  Sometimes it's because when the userspace process
_does_ wait on the kernel thread, the wait4() code decides it
doesn't want to deliver the SIGCHLD and everything breaks.  Other
times it's because the wait4 code decides the thread can't deliver
the exit signal to init because it isn't set to SIGCHLD. I used
to understand the details of all this but that grey cell died.

I bet this ancient reparent-kernel-thread-to-init patch fixes it.  It always
does.


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
+ * 	Kernel 2.4.4-pre3, akpm: reparent the caller
+ *	to init and set the exit signal to SIGCHLD so the thread
+ *	will be properly reaped if it exits.
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
