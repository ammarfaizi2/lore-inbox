Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269583AbRHCUJq>; Fri, 3 Aug 2001 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269587AbRHCUJh>; Fri, 3 Aug 2001 16:09:37 -0400
Received: from [212.113.174.249] ([212.113.174.249]:52768 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S269583AbRHCUJ0> convert rfc822-to-8bit;
	Fri, 3 Aug 2001 16:09:26 -0400
From: =?iso-8859-1?Q?Andr=E9_Cruz?= <afafc@rnl.ist.utl.pt>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: BUG can fill process table
Date: Fri, 3 Aug 2001 21:09:12 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAArqXyEnDnsk6P8VUX1zHRj8KAAAAQAAAAiSj7Lm1mokiaqvnR9Q09VAEAAAAA@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
In-Reply-To: <3B6AFF2F.D99F8ECD@zip.com.au>
X-OriginalArrivalTime: 03 Aug 2001 20:05:46.0743 (UTC) FILETIME=[AF092870:01C11C57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be leaving tomorrow for vacations and can't test this patch right
now. I'll be back in 10 days and if it hasn't been tested enough by then
I'll apply it.

Meanwhile if someone else could look into this issue I would appreciate
it. It's surprising no one else has been annoyed by this issue. :)

Btw here is a ps output of my router after dhcpcd has been running for a
few days:

sprawl# ./ps -fx
  PID TTY      STAT   TIME COMMAND
    7 ?        SW     0:00 [kupdated]
    6 ?        SW     0:00 [bdflush]
    5 ?        SW     0:00 [kreclaimd]
    4 ?        SW     0:00 [kswapd]
    3 ?        SWN    0:01 [ksoftirqd_CPU0]
    1 ?        S      0:01 init [3] 
    2 ?        SW     0:00 [keventd]
  289 ?        S      0:01 /sbin/syslogd -m 0
  292 ?        S      0:00 /sbin/klogd
  301 ?        SW     0:00 [eth1]
  317 ?        S      0:00 /usr/sbin/cron
  330 ?        S      0:41 /usr/sbin/sshd
11190 ?        S      0:00  \_ /usr/sbin/sshd
11192 ttyp0    S      0:00      \_ -sh
11228 ttyp0    R      0:00          \_ ./ps -fx
 9684 ?        S      0:03 dhcpcd eth0
 9728 ?        Z      0:00  \_ [eth0 <defunct>]
 9731 ?        Z      0:00  \_ [eth0 <defunct>]
 9735 ?        Z      0:00  \_ [eth0 <defunct>]
 9742 ?        Z      0:00  \_ [eth0 <defunct>]
 9752 ?        SW     0:00  \_ [eth0]
sprawl# 

Thanks for the help!


----------
André Cruz

-----Original Message-----
From: akpm@vasquez.zip.com.au [mailto:akpm@vasquez.zip.com.au] On Behalf
Of Andrew Morton
Sent: sexta-feira, 3 de Agosto de 2001 20:45
To: André Cruz
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG can fill process table


André Cruz wrote:
> 
> When a process (say dhcpcd) changes the IFF_UP flag to TRUE on an 
> interface (say eth0) to bring it up, a new process is created named 
> after the interface (eth0 in this case) and it's PPID is dhcpcd.
> 
> If dhcpcd later changes the IFF_UP flag to FALSE to bring the 
> interface down, the eth0 process dies but stays as a zombie. The 
> problem is that dhcpcd never receives a sigchld (suposedly eth0 is 
> it's child) and even if it executes a wait() no process is reaped and 
> wait() returns -1.
> 
> The worse part of this is that when dhcpcd wants to bring up the 
> interface again a NEW eth0 process is created and so this starts to 
> fill up the process table.
 
Oh.  That one again.

Could you please try the below patch?

We really need to fix this - we shouldn't be giving random userspace
tasks surprise children just because some syscall decided to create a
kernel thread.

This patch _should_ fix it, as well as the problem reported in April at
http://uwsg.iu.edu/hypermail/linux/kernel/0104.1/0763.html
But the patch may be incomplete - I did it back in April and got
distracted partway through testing.

It reparents to init OK, but it's only a partial solution - the other
problem we have is that these kernel threads will inherit things like
UIDs, scheduling priority, scheduling policy, etc from the parent.  I
haven't seen any bug reports attributable to this, but....

I think we should have a standalone function which performs this
reparenting and also initialises siginficant values in *current to
useful values.


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
+ * 	Kernel 2.4.4-pre3, andrewm@uow.edu.au: reparent the caller
+ *	to init and set the exit signal to SIGCHLD so the thread
+ *	will be properly reaped if it exist.
  */
 
 void daemonize(void)
 {
 	struct fs_struct *fs;
-
+	struct task_struct *this_task = current;
 
 	/*
 	 * If we were started as result of loading a module, close all
of the
 	 * user space pages.  We don't need them, and if we didn't close
them
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
+		printk(KERN_ERR "task `%s' exit_signal %d in
daemonize()\n",
+			this_task->comm, this_task->exit_signal);
+	}
+	this_task->exit_signal = SIGCHLD;
+
+	write_unlock_irq(&tasklist_lock);
 }
 
 void __init init_idle(void)

