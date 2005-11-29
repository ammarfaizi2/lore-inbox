Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVK2VST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVK2VST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVK2VST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:18:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932414AbVK2VSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:18:17 -0500
Date: Tue, 29 Nov 2005 21:18:01 GMT
Message-Id: <200511292118.jATLI1eE006340@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, dalomar@serrasold.com
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 2/2] FRV: Improve signal handling
In-Reply-To: <dhowells1133299080@warthog.cambridge.redhat.com>
References: <dhowells1133299080@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch improves the signal handling:

 (1) It makes do_signal() static as it isn't called from anywhere outside of
     the arch code.

 (2) It removes the regs argument to all the static functions within that file,
     using __frame instead (which is the same thing held in a global register).

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-dosignal-2615rc2.diff
 arch/frv/kernel/signal.c |  102 +++++++++++++++++++++++------------------------
 include/asm-frv/signal.h |    1 
 2 files changed, 50 insertions(+), 53 deletions(-)

diff -uNrp linux-2.6.15-rc2-frv-signal/arch/frv/kernel/signal.c linux-2.6.15-rc2-frv-dosignal/arch/frv/kernel/signal.c
--- linux-2.6.15-rc2-frv-signal/arch/frv/kernel/signal.c	2005-11-29 16:41:11.000000000 +0000
+++ linux-2.6.15-rc2-frv-dosignal/arch/frv/kernel/signal.c	2005-11-29 16:55:12.000000000 +0000
@@ -35,7 +35,7 @@ struct fdpic_func_descriptor {
 	unsigned long	GOT;
 };
 
-asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
+static int do_signal(sigset_t *oldset);
 
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
@@ -55,7 +55,7 @@ asmlinkage int sys_sigsuspend(int histor
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(__frame, &saveset))
+		if (do_signal(&saveset))
 			/* return the signal number as the return value of this function
 			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
 			 *   as entry.S sets regs->gr8 to the return value of the system call
@@ -91,7 +91,7 @@ asmlinkage int sys_rt_sigsuspend(sigset_
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(__frame, &saveset))
+		if (do_signal(&saveset))
 			/* return the signal number as the return value of this function
 			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
 			 *   as entry.S sets regs->gr8 to the return value of the system call
@@ -276,13 +276,12 @@ static int setup_sigcontext(struct sigco
  * Determine which stack to use..
  */
 static inline void __user *get_sigframe(struct k_sigaction *ka,
-					struct pt_regs *regs,
 					size_t frame_size)
 {
 	unsigned long sp;
 
 	/* Default to using normal stack */
-	sp = regs->sp;
+	sp = __frame->sp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
@@ -291,19 +290,19 @@ static inline void __user *get_sigframe(
 	}
 
 	return (void __user *) ((sp - frame_size) & ~7UL);
+
 } /* end get_sigframe() */
 
 /*****************************************************************************/
 /*
  *
  */
-static int setup_frame(int sig, struct k_sigaction *ka, sigset_t *set,
-		       struct pt_regs *regs)
+static int setup_frame(int sig, struct k_sigaction *ka, sigset_t *set)
 {
 	struct sigframe __user *frame;
 	int rsig;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -347,18 +346,18 @@ static int setup_frame(int sig, struct k
 	}
 
 	/* set up registers for signal handler */
-	regs->sp   = (unsigned long) frame;
-	regs->lr   = (unsigned long) &frame->retcode;
-	regs->gr8  = sig;
+	__frame->sp   = (unsigned long) frame;
+	__frame->lr   = (unsigned long) &frame->retcode;
+	__frame->gr8  = sig;
 
 	if (get_personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
 			(struct fdpic_func_descriptor *) ka->sa.sa_handler;
-		__get_user(regs->pc, &funcptr->text);
-		__get_user(regs->gr15, &funcptr->GOT);
+		__get_user(__frame->pc, &funcptr->text);
+		__get_user(__frame->gr15, &funcptr->GOT);
 	} else {
-		regs->pc   = (unsigned long) ka->sa.sa_handler;
-		regs->gr15 = 0;
+		__frame->pc   = (unsigned long) ka->sa.sa_handler;
+		__frame->gr15 = 0;
 	}
 
 	set_fs(USER_DS);
@@ -369,7 +368,7 @@ static int setup_frame(int sig, struct k
 
 #if DEBUG_SIG
 	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
-	       sig, current->comm, current->pid, frame, regs->pc,
+	       sig, current->comm, current->pid, frame, __frame->pc,
 	       frame->pretcode);
 #endif
 
@@ -386,12 +385,12 @@ give_sigsegv:
  *
  */
 static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set, struct pt_regs * regs)
+			  sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
 	int rsig;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -414,7 +413,7 @@ static int setup_rt_frame(int sig, struc
 	if (__put_user(0, &frame->uc.uc_flags) ||
 	    __put_user(0, &frame->uc.uc_link) ||
 	    __put_user((void*)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp) ||
-	    __put_user(sas_ss_flags(regs->sp), &frame->uc.uc_stack.ss_flags) ||
+	    __put_user(sas_ss_flags(__frame->sp), &frame->uc.uc_stack.ss_flags) ||
 	    __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size))
 		goto give_sigsegv;
 
@@ -445,19 +444,19 @@ static int setup_rt_frame(int sig, struc
 	}
 
 	/* Set up registers for signal handler */
-	regs->sp  = (unsigned long) frame;
-	regs->lr   = (unsigned long) &frame->retcode;
-	regs->gr8 = sig;
-	regs->gr9 = (unsigned long) &frame->info;
+	__frame->sp  = (unsigned long) frame;
+	__frame->lr   = (unsigned long) &frame->retcode;
+	__frame->gr8 = sig;
+	__frame->gr9 = (unsigned long) &frame->info;
 
 	if (get_personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor *funcptr =
 			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
-		__get_user(regs->pc, &funcptr->text);
-		__get_user(regs->gr15, &funcptr->GOT);
+		__get_user(__frame->pc, &funcptr->text);
+		__get_user(__frame->gr15, &funcptr->GOT);
 	} else {
-		regs->pc   = (unsigned long) ka->sa.sa_handler;
-		regs->gr15 = 0;
+		__frame->pc   = (unsigned long) ka->sa.sa_handler;
+		__frame->gr15 = 0;
 	}
 
 	set_fs(USER_DS);
@@ -468,7 +467,7 @@ static int setup_rt_frame(int sig, struc
 
 #if DEBUG_SIG
 	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
-		sig, current->comm, current->pid, frame, regs->pc,
+	       sig, current->comm, current->pid, frame, __frame->pc,
 	       frame->pretcode);
 #endif
 
@@ -485,38 +484,37 @@ give_sigsegv:
  * OK, we're invoking a handler
  */
 static int handle_signal(unsigned long sig, siginfo_t *info,
-			 struct k_sigaction *ka, sigset_t *oldset,
-			 struct pt_regs *regs)
+			 struct k_sigaction *ka, sigset_t *oldset)
 {
 	int ret;
 
 	/* Are we from a system call? */
-	if (in_syscall(regs)) {
+	if (in_syscall(__frame)) {
 		/* If so, check system call restarting.. */
-		switch (regs->gr8) {
+		switch (__frame->gr8) {
 		case -ERESTART_RESTARTBLOCK:
 		case -ERESTARTNOHAND:
-			regs->gr8 = -EINTR;
+			__frame->gr8 = -EINTR;
 			break;
 
 		case -ERESTARTSYS:
 			if (!(ka->sa.sa_flags & SA_RESTART)) {
-				regs->gr8 = -EINTR;
+				__frame->gr8 = -EINTR;
 				break;
 			}
 
 			/* fallthrough */
 		case -ERESTARTNOINTR:
-			regs->gr8 = regs->orig_gr8;
-			regs->pc -= 4;
+			__frame->gr8 = __frame->orig_gr8;
+			__frame->pc -= 4;
 		}
 	}
 
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+		ret = setup_rt_frame(sig, ka, info, oldset);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(sig, ka, oldset);
 
 	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
@@ -538,7 +536,7 @@ static int handle_signal(unsigned long s
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int do_signal(struct pt_regs *regs, sigset_t *oldset)
+static int do_signal(sigset_t *oldset)
 {
 	struct k_sigaction ka;
 	siginfo_t info;
@@ -550,7 +548,7 @@ int do_signal(struct pt_regs *regs, sigs
 	 * kernel mode. Just return without doing anything
 	 * if so.
 	 */
-	if (!user_mode(regs))
+	if (!user_mode(__frame))
 		return 1;
 
 	if (try_to_freeze())
@@ -559,24 +557,24 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, __frame, NULL);
 	if (signr > 0)
-		return handle_signal(signr, &info, &ka, oldset, regs);
+		return handle_signal(signr, &info, &ka, oldset);
 
 no_signal:
 	/* Did we come from a system call? */
-	if (regs->syscallno >= 0) {
+	if (__frame->syscallno >= 0) {
 		/* Restart the system call - no handlers present */
-		if (regs->gr8 == -ERESTARTNOHAND ||
-		    regs->gr8 == -ERESTARTSYS ||
-		    regs->gr8 == -ERESTARTNOINTR) {
-			regs->gr8 = regs->orig_gr8;
-			regs->pc -= 4;
+		if (__frame->gr8 == -ERESTARTNOHAND ||
+		    __frame->gr8 == -ERESTARTSYS ||
+		    __frame->gr8 == -ERESTARTNOINTR) {
+			__frame->gr8 = __frame->orig_gr8;
+			__frame->pc -= 4;
 		}
 
-		if (regs->gr8 == -ERESTART_RESTARTBLOCK){
-			regs->gr8 = __NR_restart_syscall;
-			regs->pc -= 4;
+		if (__frame->gr8 == -ERESTART_RESTARTBLOCK){
+			__frame->gr8 = __NR_restart_syscall;
+			__frame->pc -= 4;
 		}
 	}
 
@@ -597,6 +595,6 @@ asmlinkage void do_notify_resume(__u32 t
 
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(__frame, NULL);
+		do_signal(NULL);
 
 } /* end do_notify_resume() */
diff -uNrp linux-2.6.15-rc2-frv-signal/include/asm-frv/signal.h linux-2.6.15-rc2-frv-dosignal/include/asm-frv/signal.h
--- linux-2.6.15-rc2-frv-signal/include/asm-frv/signal.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-rc2-frv-dosignal/include/asm-frv/signal.h	2005-11-29 16:54:26.000000000 +0000
@@ -151,7 +151,6 @@ typedef struct sigaltstack {
 	size_t ss_size;
 } stack_t;
 
-extern int do_signal(struct pt_regs *regs, sigset_t *oldset);
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 
 #ifdef __KERNEL__
