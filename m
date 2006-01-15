Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWAORB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWAORB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWAORB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:01:26 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:55779 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750940AbWAORBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:01:25 -0500
Message-ID: <43CA91C5.7C92DCB@tv-sign.ru>
Date: Sun, 15 Jan 2006 21:17:41 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
>
> The attached patch handles TIF_RESTORE_SIGMASK as added by David Woodhouse's
> patch entitled:
>
>         [PATCH] 2/3 Add TIF_RESTORE_SIGMASK support for arch/powerpc
>         [PATCH] 3/3 Generic sys_rt_sigsuspend
>
> It does the following:
>
>  (1) Declares TIF_RESTORE_SIGMASK for i386.
>
>  (2) Invokes it over to do_signal() when TIF_RESTORE_SIGMASK is set.
>
>  (3) Makes do_signal() support TIF_RESTORE_SIGMASK, using the signal mask saved
>      in current->saved_sigmask.

Imho, there is a slightly better way to do it, see the patch below.

Instead of adding TIF_RESTORE_SIGMASK we can introduce ERESTART_SIGBLOCK
return value. Now,

sys_rt_sigsuspend(sigset_t *newset)
{
	current->saved_sigmask = current->blocked;
	current->blocked = newset;

	current->state = TASK_INTERRUPTIBLE;
	schedule();
	return -ERESTART_SIGBLOCK;
}

sys_pselect()
{
	...

	ret = core_sys_select();

	if (ret == -ERESTARTNOHAND)
		ret = -ERESTART_SIGBLOCK;
}

handle_signal()
{
	sigset_t *oldset; // removed from param list

	...

	oldset = &current->blocked;
	if (regs->eax == -ERESTART_SIGBLOCK)
		oldset = &current->saved_sigmask;

	...
}

Comments?

Only for illustration, but seems to work.

 include/linux/errno.h     |    1 
 include/linux/sched.h     |    2 -
 include/asm-i386/signal.h |    3 -
 arch/i386/kernel/signal.c |   73 +++++++++++++++++++++-------------------------
 4 files changed, 36 insertions(+), 43 deletions(-)

--- 2.6.15/include/linux/errno.h~1_SIGM	2004-09-13 09:33:11.000000000 +0400
+++ 2.6.15/include/linux/errno.h	2006-01-15 18:42:17.000000000 +0300
@@ -11,6 +11,7 @@
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
 #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
+#define ERESTART_SIGBLOCK     517
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
--- 2.6.15/include/linux/sched.h~1_SIGM	2005-12-06 23:33:16.000000000 +0300
+++ 2.6.15/include/linux/sched.h	2006-01-15 18:55:27.000000000 +0300
@@ -799,7 +799,7 @@ struct task_struct {
 	struct signal_struct *signal;
 	struct sighand_struct *sighand;
 
-	sigset_t blocked, real_blocked;
+	sigset_t blocked, real_blocked, saved_blocked;
 	struct sigpending pending;
 
 	unsigned long sas_ss_sp;
--- 2.6.15/include/asm-i386/signal.h~1_SIGM	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15/include/asm-i386/signal.h	2006-01-15 19:26:58.000000000 +0300
@@ -217,9 +217,6 @@ static __inline__ int sigfindinword(unsi
 	return word;
 }
 
-struct pt_regs;
-extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
-
 #define ptrace_signal_deliver(regs, cookie)		\
 	do {						\
 		if (current->ptrace & PT_DTRACE) {	\
--- 2.6.15/arch/i386/kernel/signal.c~1_SIGM	2005-10-11 16:22:42.000000000 +0400
+++ 2.6.15/arch/i386/kernel/signal.c	2006-01-15 23:13:36.000000000 +0300
@@ -37,29 +37,22 @@
 asmlinkage int
 sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
-	struct pt_regs * regs = (struct pt_regs *) &history0;
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_blocked = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs->eax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	return -ERESTART_SIGBLOCK;
 }
 
 asmlinkage int
 sys_rt_sigsuspend(struct pt_regs regs)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (regs.ecx != sizeof(sigset_t))
@@ -69,19 +62,11 @@ sys_rt_sigsuspend(struct pt_regs regs)
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	sigprocmask(SIG_SETMASK, &newset, &current->saved_blocked);
 
-	regs.eax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&regs, &saveset))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	return -ERESTART_SIGBLOCK;
 }
 
 asmlinkage int 
@@ -540,14 +525,18 @@ give_sigsegv:
 
 static int
 handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
-	      sigset_t *oldset,	struct pt_regs * regs)
+		struct pt_regs * regs)
 {
+	sigset_t *oldset;
+	int saved_blocked = 0;
 	int ret;
 
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
 		switch (regs->eax) {
+			case -ERESTART_SIGBLOCK:
+				saved_blocked = 1;
 		        case -ERESTART_RESTARTBLOCK:
 			case -ERESTARTNOHAND:
 				regs->eax = -EINTR;
@@ -575,6 +564,10 @@ handle_signal(unsigned long sig, siginfo
 		regs->eflags &= ~TF_MASK;
 	}
 
+	oldset = &current->blocked;
+	if (saved_blocked)
+		oldset = &current->saved_blocked;
+
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		ret = setup_rt_frame(sig, ka, info, oldset, regs);
@@ -588,7 +581,8 @@ handle_signal(unsigned long sig, siginfo
 			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
-	}
+	} else if (saved_blocked)
+		regs->eax = -ERESTART_SIGBLOCK;
 
 	return ret;
 }
@@ -598,7 +592,7 @@ handle_signal(unsigned long sig, siginfo
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int fastcall do_signal(struct pt_regs *regs, sigset_t *oldset)
+static void fastcall do_signal(struct pt_regs *regs)
 {
 	siginfo_t info;
 	int signr;
@@ -613,14 +607,11 @@ int fastcall do_signal(struct pt_regs *r
  	 * CS suffices.
 	 */
 	if (!user_mode(regs))
-		return 1;
+		return;
 
 	if (try_to_freeze())
 		goto no_signal;
 
-	if (!oldset)
-		oldset = &current->blocked;
-
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
@@ -633,25 +624,29 @@ int fastcall do_signal(struct pt_regs *r
 		}
 
 		/* Whee!  Actually deliver the signal.  */
-		return handle_signal(signr, &info, &ka, oldset, regs);
+		handle_signal(signr, &info, &ka, regs);
+		return;
 	}
 
  no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
-		if (regs->eax == -ERESTARTNOHAND ||
-		    regs->eax == -ERESTARTSYS ||
-		    regs->eax == -ERESTARTNOINTR) {
+		switch (regs->eax) {
+		case -ERESTART_SIGBLOCK:
+			sigprocmask(SIG_SETMASK, &current->saved_blocked, NULL);
+		case -ERESTARTSYS:
+		case -ERESTARTNOHAND:
+		case -ERESTARTNOINTR:
 			regs->eax = regs->orig_eax;
 			regs->eip -= 2;
-		}
-		if (regs->eax == -ERESTART_RESTARTBLOCK){
+			break;
+
+		case -ERESTART_RESTARTBLOCK:
 			regs->eax = __NR_restart_syscall;
 			regs->eip -= 2;
 		}
 	}
-	return 0;
 }
 
 /*
@@ -669,7 +664,7 @@ void do_notify_resume(struct pt_regs *re
 	}
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs,oldset);
+		do_signal(regs);
 	
 	clear_thread_flag(TIF_IRET);
 }
