Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSCSVam>; Tue, 19 Mar 2002 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSCSVad>; Tue, 19 Mar 2002 16:30:33 -0500
Received: from daimi.au.dk ([130.225.16.1]:59301 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S292870AbSCSVaQ>;
	Tue, 19 Mar 2002 16:30:16 -0500
Message-ID: <3C97ADD8.71408946@daimi.au.dk>
Date: Tue, 19 Mar 2002 22:30:00 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
In-Reply-To: <sc91c4ce.020@mail-01.med.umich.edu> <20020315150241.H24984@flint.arm.linux.org.uk> <3C96F015.24BDC9FF@daimi.au.dk> <20020319162840.F11739@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------FC93FF3E59E0347F87E24ED8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FC93FF3E59E0347F87E24ED8
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Russell King wrote:
> 
> On Tue, Mar 19, 2002 at 09:00:21AM +0100, Kasper Dupont wrote:
> >
> > Why actually panic because of an attempt to kill init?
> >
> > Of course a message should be printed, but after that
> > couldn't do_exit enter a loop where it just handles
> > signals and zombies?
> 
> Examine the LKML archive around 23rd December 2001, where Alan Cox wrote:
> 
> | pid1 ends up trying to kill pid1 and it goes deeply down the toilet from
> | that point onwards. The Unix traditional world reboots when pid 1 dies.

Thank you for pointing that out. But I'm afraid it doesn't
answer my question. I understand that a system where init
has died cannot be expected to continue working like if
nothing was wrong.

What to do in this case might be a matter of taste, of
course a panic or a reboot does make sense. But trying to
recover as much as posible would also make sense. This
could be caused by a problem in userspace, the kernel does
not have to be corrupted already.

If we agree that this is a matter of taste lets not try to
argue about whose taste is the best.

I was really just wondering if the patch below would work.
Well I just tested it, and it did work like I expected. If
I killed init (by replacing /sbin/init with something else
and telling init to reexecute itself) I got the warning.
But the system continued to work.

Of course init would no longer respawn processes, and I
could not change runlevel. But I could login, kill
processes, and remount filesystems read-only. And no
processes became zombies.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
--------------FC93FF3E59E0347F87E24ED8
Content-Type: text/plain; charset=us-ascii;
 name="killinit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="killinit.patch"

--- exit.c~	Mon Feb 25 20:38:13 2002
+++ exit.c	Tue Mar 19 21:47:58 2002
@@ -429,6 +429,38 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
+#define __KERNEL_SYSCALLS__
+#include <linux/unistd.h>
+NORET_TYPE void flush_child_loop(struct task_struct *curtask)
+{
+	struct k_sigaction sa;
+	daemonize();
+
+	spin_lock_irq(&curtask->sigmask_lock);
+	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
+	recalc_sigpending(curtask);
+	spin_unlock_irq(&curtask->sigmask_lock);
+
+	/* Install a handler so SIGCLD is delivered */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+
+	for (;;) {
+		set_task_state(curtask, TASK_INTERRUPTIBLE);
+		schedule();
+		if (signal_pending(curtask)) {
+			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
+				;
+			spin_lock_irq(&curtask->sigmask_lock);
+			flush_signals(curtask);
+			recalc_sigpending(curtask);
+			spin_unlock_irq(&curtask->sigmask_lock);
+		}
+	}
+}
+
 NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -437,8 +469,10 @@
 		panic("Aiee, killing interrupt handler!");
 	if (!tsk->pid)
 		panic("Attempted to kill the idle task!");
-	if (tsk->pid == 1)
-		panic("Attempted to kill init!");
+	if (tsk->pid == 1) {
+		printk(KERN_EMERG "Attempted to kill init!\n");
+		flush_child_loop(tsk);
+	}
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 

--------------FC93FF3E59E0347F87E24ED8--

