Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWAWL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWAWL7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWAWL7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:59:51 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:3496 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751266AbWAWL7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:59:50 -0500
Date: Mon, 23 Jan 2006 12:59:36 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390: Add support for new syscalls/TIF_RESTORE_SIGMASK.
Message-ID: <20060123115936.GD9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add support for the new *at, pselect6 and ppoll system calls.
This includes adding required support for TIF_RESTORE_SIGMASK.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_signal.c  |  100 +++++---------------------
 arch/s390/kernel/compat_wrapper.S |  137 ++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/entry.S          |   51 +++----------
 arch/s390/kernel/entry64.S        |   75 +++----------------
 arch/s390/kernel/signal.c         |  146 ++++++++++++++++++--------------------
 arch/s390/kernel/syscalls.S       |   22 ++++-
 include/asm-s390/thread_info.h    |    6 -
 include/asm-s390/unistd.h         |   24 +++++-
 8 files changed, 296 insertions(+), 265 deletions(-)

diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index fa2b3bc..ef70669 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -1,8 +1,7 @@
 /*
- *  arch/s390/kernel/signal32.c
+ *  arch/s390/kernel/compat_signal.c
  *
- *  S390 version
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 2000,2006
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
  *               Gerhard Tonn (ton@de.ibm.com)                  
  *
@@ -52,8 +51,6 @@ typedef struct 
 	struct ucontext32 uc;
 } rt_sigframe32;
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
-
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 {
 	int err;
@@ -161,66 +158,6 @@ int copy_siginfo_from_user32(siginfo_t *
 	return err;
 }
 
-/*
- * Atomically swap in the new signal mask, and wait for a signal.
- */
-asmlinkage int
-sys32_sigsuspend(struct pt_regs * regs,int history0, int history1, old_sigset_t mask)
-{
-	sigset_t saveset;
-
-	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	siginitset(&current->blocked, mask);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-	regs->gprs[2] = -EINTR;
-
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
-}
-
-asmlinkage int
-sys32_rt_sigsuspend(struct pt_regs * regs, compat_sigset_t __user *unewset,
-								size_t sigsetsize)
-{
-	sigset_t saveset, newset;
-	compat_sigset_t set32;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&set32, unewset, sizeof(set32)))
-		return -EFAULT;
-	switch (_NSIG_WORDS) {
-	case 4: newset.sig[3] = set32.sig[6] + (((long)set32.sig[7]) << 32);
-	case 3: newset.sig[2] = set32.sig[4] + (((long)set32.sig[5]) << 32);
-	case 2: newset.sig[1] = set32.sig[2] + (((long)set32.sig[3]) << 32);
-	case 1: newset.sig[0] = set32.sig[0] + (((long)set32.sig[1]) << 32);
-	}
-        sigdelsetmask(&newset, ~_BLOCKABLE);
-
-        spin_lock_irq(&current->sighand->siglock);
-        saveset = current->blocked;
-        current->blocked = newset;
-        recalc_sigpending();
-        spin_unlock_irq(&current->sighand->siglock);
-        regs->gprs[2] = -EINTR;
-
-        while (1) {
-                set_current_state(TASK_INTERRUPTIBLE);
-                schedule();
-                if (do_signal(regs, &saveset))
-                        return -EINTR;
-        }
-}
-
 asmlinkage long
 sys32_sigaction(int sig, const struct old_sigaction32 __user *act,
 		 struct old_sigaction32 __user *oact)
@@ -520,7 +457,7 @@ static inline int map_signal(int sig)
 		return sig;
 }
 
-static void setup_frame32(int sig, struct k_sigaction *ka,
+static int setup_frame32(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
 	sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(sigframe32));
@@ -565,13 +502,14 @@ static void setup_frame32(int sig, struc
 	/* Place signal number on stack to allow backtrace from handler.  */
 	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
 		goto give_sigsegv;
-	return;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return -EFAULT;
 }
 
-static void setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
+static int setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	int err = 0;
@@ -615,31 +553,37 @@ static void setup_rt_frame32(int sig, st
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__u64) &frame->info;
 	regs->gprs[4] = (__u64) &frame->uc;
-	return;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return -EFAULT;
 }
 
 /*
  * OK, we're invoking a handler
  */	
 
-void
+int
 handle_signal32(unsigned long sig, struct k_sigaction *ka,
 		siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
+	int ret;
+
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame32(sig, ka, info, oldset, regs);
+		ret = setup_rt_frame32(sig, ka, info, oldset, regs);
 	else
-		setup_frame32(sig, ka, oldset, regs);
+		ret = setup_frame32(sig, ka, oldset, regs);
 
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&current->blocked,sig);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	if (ret == 0) {
+		spin_lock_irq(&current->sighand->siglock);
+		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+	return ret;
 }
 
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index cfde190..706d13d 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1,9 +1,8 @@
 /*
-*  arch/s390/kernel/sys_wrapper31.S
+*  arch/s390/kernel/compat_wrapper.S
 *    wrapper for 31 bit compatible system calls.
 *
-*  S390 version
-*    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+*    Copyright (C) IBM Corp. 2000,2006
 *    Author(s): Gerhard Tonn (ton@de.ibm.com),
 *               Thomas Spatzier (tspat@de.ibm.com)
 */ 
@@ -288,7 +287,12 @@ sys32_setregid16_wrapper:
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t 
 	jg	sys32_setregid16	# branch to system call
 
-#sys32_sigsuspend_wrapper		# done in sigsuspend_glue 
+	.globl sys_sigsuspend_wrapper
+sys_sigsuspend_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	llgfr	%r4,%r4			# old_sigset_t
+	jg	sys_sigsuspend
 
 	.globl  compat_sys_sigpending_wrapper 
 compat_sys_sigpending_wrapper:
@@ -855,7 +859,11 @@ sys32_rt_sigqueueinfo_wrapper:
 	llgtr	%r4,%r4			# siginfo_emu31_t *
 	jg	sys32_rt_sigqueueinfo	# branch to system call
 
-#sys32_rt_sigsuspend_wrapper		# done in rt_sigsuspend_glue 
+	.globl compat_sys_rt_sigsuspend_wrapper
+compat_sys_rt_sigsuspend_wrapper:
+	llgtr	%r2,%r2			# compat_sigset_t *
+	llgfr	%r3,%r3			# compat_size_t
+	jg	compat_sys_rt_sigsuspend
 
 	.globl  sys32_pread64_wrapper 
 sys32_pread64_wrapper:
@@ -1475,3 +1483,122 @@ sys_inotify_rm_watch_wrapper:
 	lgfr	%r2,%r2			# int
 	llgfr	%r3,%r3			# u32
 	jg	sys_inotify_rm_watch
+
+	.globl compat_sys_openat_wrapper
+compat_sys_openat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	jg	compat_sys_openat
+
+	.globl sys_mkdirat_wrapper
+sys_mkdirat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	jg	sys_mkdirat
+
+	.globl sys_mknodat_wrapper
+sys_mknodat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	llgfr	%r5,%r5			# unsigned int
+	jg	sys_mknodat
+
+	.globl sys_fchownat_wrapper
+sys_fchownat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	llgfr	%r4,%r4			# uid_t
+	llgfr	%r5,%r5			# gid_t
+	lgfr	%r6,%r6			# int
+	jg	sys_fchownat
+
+	.globl compat_sys_futimesat_wrapper
+compat_sys_futimesat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# char *
+	llgtr	%r4,%r4			# struct timeval *
+	jg	compat_sys_futimesat
+
+	.globl compat_sys_newfstatat_wrapper
+compat_sys_newfstatat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# char *
+	llgtr	%r4,%r4			# struct stat *
+	lgfr	%r5,%r5			# int
+	jg	compat_sys_newfstatat
+	
+	.globl sys_unlinkat_wrapper
+sys_unlinkat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	jg	sys_unlinkat
+
+	.globl sys_renameat_wrapper
+sys_renameat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# const char *
+	jg	sys_renameat
+
+	.globl sys_linkat_wrapper
+sys_linkat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# const char *
+	jg	sys_linkat
+
+	.globl sys_symlinkat_wrapper
+sys_symlinkat_wrapper:
+	llgtr	%r2,%r2			# const char *
+	lgfr	%r3,%r3			# int
+	llgtr	%r4,%r4			# const char *
+	jg	sys_symlinkat
+
+	.globl sys_readlinkat_wrapper
+sys_readlinkat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	llgtr	%r4,%r4			# char *
+	lgfr	%r5,%r5			# int
+	jg	sys_readlinkat
+
+	.globl sys_fchmodat_wrapper
+sys_fchmodat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	llgfr	%r4,%r4			# mode_t
+	jg	sys_fchmodat
+
+	.globl sys_faccessat_wrapper
+sys_faccessat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	lgfr	%r4,%r4			# int
+	jg	sys_faccessat
+
+	.globl compat_sys_pselect6_wrapper
+compat_sys_pselect6_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# fd_set *
+	llgtr	%r4,%r4			# fd_set *
+	llgtr	%r5,%r5			# fd_set *
+	llgtr	%r6,%r6			# struct timespec *
+	llgt	%r0,164(%r15)		# void *
+	stg	%r0,160(%r15)
+	jg	compat_sys_pselect6
+
+	.globl compat_sys_ppoll_wrapper
+compat_sys_ppoll_wrapper:
+	llgtr	%r2,%r2			# struct pollfd *
+	llgfr	%r3,%r3			# unsigned int
+	llgtr	%r4,%r4			# struct timespec *
+	llgtr	%r5,%r5			# const sigset_t *
+	llgfr	%r6,%r6			# size_t
+	jg	compat_sys_ppoll
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 27b0773..b244848 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -2,8 +2,7 @@
  *  arch/s390/kernel/entry.S
  *    S390 low-level entry points.
  *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 1999,2006
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
@@ -50,9 +49,10 @@ SP_ILC       =  STACK_FRAME_OVERHEAD + _
 SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
 SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING | \
-		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
-_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NEED_RESCHED | \
+		 _TIF_MCCK_PENDING | _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NEED_RESCHED | \
+		 _TIF_MCCK_PENDING)
 
 STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
 STACK_SIZE  = 1 << STACK_SHIFT
@@ -251,8 +251,8 @@ sysc_work:
 	bo	BASED(sysc_mcck_pending)
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(sysc_reschedule)
-	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
-	bo	BASED(sysc_sigpending)
+	tm	__TI_flags+3(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
+	bnz	BASED(sysc_sigpending)
 	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
 	bo	BASED(sysc_restart)
 	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
@@ -276,12 +276,11 @@ sysc_mcck_pending:
 	br	%r1			# TIF bit will be cleared by handler
 
 #
-# _TIF_SIGPENDING is set, call do_signal
+# _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 sysc_sigpending:     
 	ni	__TI_flags+3(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
-        sr      %r3,%r3                # clear *oldset
         l       %r1,BASED(.Ldo_signal)
 	basr	%r14,%r1               # call do_signal
 	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
@@ -397,30 +396,6 @@ sys_rt_sigreturn_glue:     
         l       %r1,BASED(.Lrt_sigreturn)
         br      %r1                   # branch to sys_sigreturn
 
-#
-# sigsuspend and rt_sigsuspend need pt_regs as an additional
-# parameter and they have to skip the store of %r2 into the
-# user register %r2 because the return value was set in 
-# sigsuspend and rt_sigsuspend already and must not be overwritten!
-#
-
-sys_sigsuspend_glue:    
-        lr      %r5,%r4               # move mask back
-        lr      %r4,%r3               # move history1 parameter
-        lr      %r3,%r2               # move history0 parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-        l       %r1,BASED(.Lsigsuspend)
-	la      %r14,4(%r14)          # skip store of return value
-        br      %r1                   # branch to sys_sigsuspend
-
-sys_rt_sigsuspend_glue: 
-        lr      %r4,%r3               # move sigsetsize parameter
-        lr      %r3,%r2               # move unewset parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-        l       %r1,BASED(.Lrt_sigsuspend)
-	la      %r14,4(%r14)          # skip store of return value
-        br      %r1                   # branch to sys_rt_sigsuspend
-
 sys_sigaltstack_glue:
         la      %r4,SP_PTREGS(%r15)   # load pt_regs as parameter
         l       %r1,BASED(.Lsigaltstack)
@@ -604,15 +579,16 @@ io_work:
 	lr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING, _TIF_NEED_RESCHED and _TIF_MCCK_PENDING
+# Checked are: _TIF_SIGPENDING, _TIF_RESTORE_SIGMASK, _TIF_NEED_RESCHED
+#	        and _TIF_MCCK_PENDING
 #
 io_work_loop:
 	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
 	bo      BASED(io_mcck_pending)
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(io_reschedule)
-	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
-	bo	BASED(io_sigpending)
+	tm	__TI_flags+3(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
+	bnz	BASED(io_sigpending)
 	b	BASED(io_leave)
 
 #
@@ -636,12 +612,11 @@ io_reschedule:        
 	b	BASED(io_work_loop)
 
 #
-# _TIF_SIGPENDING is set, call do_signal
+# _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:     
         stosm   __SF_EMPTY(%r15),0x03  # reenable interrupts
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
-        sr      %r3,%r3                # clear *oldset
         l       %r1,BASED(.Ldo_signal)
 	basr    %r14,%r1	       # call do_signal
         stnsm   __SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 369ab44..2ac095b 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -1,9 +1,8 @@
 /*
- *  arch/s390/kernel/entry.S
+ *  arch/s390/kernel/entry64.S
  *    S390 low-level entry points.
  *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 1999,2006
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
@@ -53,9 +52,10 @@ SP_SIZE      =  STACK_FRAME_OVERHEAD + _
 STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
 STACK_SIZE  = 1 << STACK_SHIFT
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING | \
-		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
-_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NEED_RESCHED | \
+		 _TIF_MCCK_PENDING | _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NEED_RESCHED | \
+		 _TIF_MCCK_PENDING)
 
 #define BASED(name) name-system_call(%r13)
 
@@ -249,8 +249,8 @@ sysc_work:
 	jo	sysc_mcck_pending
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	sysc_reschedule
-	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
-	jo	sysc_sigpending
+	tm	__TI_flags+7(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
+	jnz	sysc_sigpending
 	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
 	jo	sysc_restart
 	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
@@ -272,12 +272,11 @@ sysc_mcck_pending:
 	jg	s390_handle_mcck    # TIF bit will be cleared by handler
 
 #
-# _TIF_SIGPENDING is set, call do_signal
+# _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 sysc_sigpending:     
 	ni	__TI_flags+7(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
         la      %r2,SP_PTREGS(%r15) # load pt_regs
-        sgr     %r3,%r3           # clear *oldset
 	brasl	%r14,do_signal    # call do_signal
 	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
 	jo	sysc_restart
@@ -414,52 +413,6 @@ sys32_rt_sigreturn_glue:     
         jg      sys32_rt_sigreturn    # branch to sys32_sigreturn
 #endif
 
-#
-# sigsuspend and rt_sigsuspend need pt_regs as an additional
-# parameter and they have to skip the store of %r2 into the
-# user register %r2 because the return value was set in 
-# sigsuspend and rt_sigsuspend already and must not be overwritten!
-#
-
-sys_sigsuspend_glue:    
-        lgr     %r5,%r4               # move mask back
-        lgr     %r4,%r3               # move history1 parameter
-        lgr     %r3,%r2               # move history0 parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-	la      %r14,6(%r14)          # skip store of return value
-        jg      sys_sigsuspend        # branch to sys_sigsuspend
-
-#ifdef CONFIG_COMPAT
-sys32_sigsuspend_glue:    
-	llgfr	%r4,%r4               # unsigned long			
-        lgr     %r5,%r4               # move mask back
-	lgfr	%r3,%r3               # int			
-        lgr     %r4,%r3               # move history1 parameter
-	lgfr	%r2,%r2               # int			
-        lgr     %r3,%r2               # move history0 parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-	la      %r14,6(%r14)          # skip store of return value
-        jg      sys32_sigsuspend      # branch to sys32_sigsuspend
-#endif
-
-sys_rt_sigsuspend_glue: 
-        lgr     %r4,%r3               # move sigsetsize parameter
-        lgr     %r3,%r2               # move unewset parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-	la      %r14,6(%r14)          # skip store of return value
-        jg      sys_rt_sigsuspend     # branch to sys_rt_sigsuspend
-
-#ifdef CONFIG_COMPAT
-sys32_rt_sigsuspend_glue: 
-	llgfr	%r3,%r3               # size_t			
-        lgr     %r4,%r3               # move sigsetsize parameter
-	llgtr	%r2,%r2               # sigset_emu31_t *
-        lgr     %r3,%r2               # move unewset parameter
-        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
-	la      %r14,6(%r14)          # skip store of return value
-        jg      sys32_rt_sigsuspend   # branch to sys32_rt_sigsuspend
-#endif
-
 sys_sigaltstack_glue:
         la      %r4,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys_sigaltstack       # branch to sys_sigreturn
@@ -646,15 +599,16 @@ io_work:
 	lgr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING, _TIF_NEED_RESCHED and _TIF_MCCK_PENDING
+# Checked are: _TIF_SIGPENDING, _TIF_RESTORE_SIGPENDING, _TIF_NEED_RESCHED
+#	       and _TIF_MCCK_PENDING
 #
 io_work_loop:
 	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
 	jo	io_mcck_pending
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	io_reschedule
-	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
-	jo	io_sigpending
+	tm	__TI_flags+7(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
+	jnz	io_sigpending
 	j	io_leave
 
 #
@@ -676,12 +630,11 @@ io_reschedule:        
 	j	io_work_loop
 
 #
-# _TIF_SIGPENDING is set, call do_signal
+# _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:     
 	stosm   __SF_EMPTY(%r15),0x03	# reenable interrupts
 	la      %r2,SP_PTREGS(%r15)	# load pt_regs
-	slgr    %r3,%r3			# clear *oldset
 	brasl	%r14,do_signal		# call do_signal
 	stnsm   __SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
 	j	io_work_loop
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 6ae4a77..ae1927e 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -1,8 +1,7 @@
 /*
  *  arch/s390/kernel/signal.c
  *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 1999,2006
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
  *
  *    Based on Intel version
@@ -51,60 +50,24 @@ typedef struct 
 	struct ucontext uc;
 } rt_sigframe;
 
-int do_signal(struct pt_regs *regs, sigset_t *oldset);
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 asmlinkage int
-sys_sigsuspend(struct pt_regs * regs, int history0, int history1,
-	       old_sigset_t mask)
+sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	regs->gprs[2] = -EINTR;
-
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
-}
-
-asmlinkage long
-sys_rt_sigsuspend(struct pt_regs *regs, sigset_t __user *unewset,
-						size_t sigsetsize)
-{
-	sigset_t saveset, newset;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, unewset, sizeof(newset)))
-		return -EFAULT;
-	sigdelsetmask(&newset, ~_BLOCKABLE);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
 
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-	regs->gprs[2] = -EINTR;
-
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
+	return -ERESTARTNOHAND;
 }
 
 asmlinkage long
@@ -306,8 +269,8 @@ static inline int map_signal(int sig)
 		return sig;
 }
 
-static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static int setup_frame(int sig, struct k_sigaction *ka,
+		       sigset_t *set, struct pt_regs * regs)
 {
 	sigframe __user *frame;
 
@@ -355,13 +318,14 @@ static void setup_frame(int sig, struct 
 	/* Place signal number on stack to allow backtrace from handler.  */
 	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
 		goto give_sigsegv;
-	return;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return -EFAULT;
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	int err = 0;
@@ -409,32 +373,39 @@ static void setup_rt_frame(int sig, stru
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (unsigned long) &frame->info;
 	regs->gprs[4] = (unsigned long) &frame->uc;
-	return;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return -EFAULT;
 }
 
 /*
  * OK, we're invoking a handler
  */	
 
-static void
+static int
 handle_signal(unsigned long sig, struct k_sigaction *ka,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
+	int ret;
+
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
+		ret = setup_rt_frame(sig, ka, info, oldset, regs);
 	else
-		setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(sig, ka, oldset, regs);
 
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&current->blocked,sig);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	if (ret == 0) {
+		spin_lock_irq(&current->sighand->siglock);
+		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+
+	return ret;
 }
 
 /*
@@ -446,12 +417,13 @@ handle_signal(unsigned long sig, struct 
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-int do_signal(struct pt_regs *regs, sigset_t *oldset)
+void do_signal(struct pt_regs *regs)
 {
 	unsigned long retval = 0, continue_addr = 0, restart_addr = 0;
 	siginfo_t info;
 	int signr;
 	struct k_sigaction ka;
+	sigset_t *oldset;
 
 	/*
 	 * We want the common case to go fast, which
@@ -460,9 +432,11 @@ int do_signal(struct pt_regs *regs, sigs
 	 * if so.
 	 */
 	if (!user_mode(regs))
-		return 1;
+		return;
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
 		oldset = &current->blocked;
 
 	/* Are we from a system call? */
@@ -473,12 +447,14 @@ int do_signal(struct pt_regs *regs, sigs
 
 		/* Prepare for system call restart.  We do this here so that a
 		   debugger will see the already changed PSW. */
-		if (retval == -ERESTARTNOHAND ||
-		    retval == -ERESTARTSYS ||
-		    retval == -ERESTARTNOINTR) {
+		switch (retval) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
 			regs->gprs[2] = regs->orig_gpr2;
 			regs->psw.addr = restart_addr;
-		} else if (retval == -ERESTART_RESTARTBLOCK) {
+			break;
+		case -ERESTART_RESTARTBLOCK:
 			regs->gprs[2] = -EINTR;
 		}
 	}
@@ -503,17 +479,38 @@ int do_signal(struct pt_regs *regs, sigs
 		/* Whee!  Actually deliver the signal.  */
 #ifdef CONFIG_COMPAT
 		if (test_thread_flag(TIF_31BIT)) {
-			extern void handle_signal32(unsigned long sig,
-						    struct k_sigaction *ka,
-						    siginfo_t *info,
-						    sigset_t *oldset,
-						    struct pt_regs *regs);
-			handle_signal32(signr, &ka, &info, oldset, regs);
-			return 1;
+			extern int handle_signal32(unsigned long sig,
+						   struct k_sigaction *ka,
+						   siginfo_t *info,
+						   sigset_t *oldset,
+						   struct pt_regs *regs);
+			if (handle_signal32(
+				    signr, &ka, &info, oldset, regs) == 0) {
+				if (test_thread_flag(TIF_RESTORE_SIGMASK))
+					clear_thread_flag(TIF_RESTORE_SIGMASK);
+			}
+			return;
 	        }
 #endif
-		handle_signal(signr, &ka, &info, oldset, regs);
-		return 1;
+		if (handle_signal(signr, &ka, &info, oldset, regs) == 0) {
+			/*
+			 * A signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag.
+			 */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+		return;
+	}
+
+	/*
+	 * If there's no signal to deliver, we just put the saved sigmask back.
+	 */
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
 	}
 
 	/* Restart a different system call. */
@@ -522,5 +519,4 @@ int do_signal(struct pt_regs *regs, sigs
 		regs->gprs[2] = __NR_restart_syscall;
 		set_thread_flag(TIF_RESTART_SVC);
 	}
-	return 0;
 }
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 426d7ca..3280345 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -80,7 +80,7 @@ NI_SYSCALL							/* old sgetmask syscall
 NI_SYSCALL							/* old ssetmask syscall*/
 SYSCALL(sys_setreuid16,sys_ni_syscall,sys32_setreuid16_wrapper)	/* old setreuid16 syscall */
 SYSCALL(sys_setregid16,sys_ni_syscall,sys32_setregid16_wrapper)	/* old setregid16 syscall */
-SYSCALL(sys_sigsuspend_glue,sys_sigsuspend_glue,sys32_sigsuspend_glue)
+SYSCALL(sys_sigsuspend,sys_sigsuspend,sys_sigsuspend_wrapper)
 SYSCALL(sys_sigpending,sys_sigpending,compat_sys_sigpending_wrapper)
 SYSCALL(sys_sethostname,sys_sethostname,sys32_sethostname_wrapper)
 SYSCALL(sys_setrlimit,sys_setrlimit,compat_sys_setrlimit_wrapper)	/* 75 */
@@ -187,7 +187,7 @@ SYSCALL(sys_rt_sigprocmask,sys_rt_sigpro
 SYSCALL(sys_rt_sigpending,sys_rt_sigpending,sys32_rt_sigpending_wrapper)
 SYSCALL(sys_rt_sigtimedwait,sys_rt_sigtimedwait,compat_sys_rt_sigtimedwait_wrapper)
 SYSCALL(sys_rt_sigqueueinfo,sys_rt_sigqueueinfo,sys32_rt_sigqueueinfo_wrapper)
-SYSCALL(sys_rt_sigsuspend_glue,sys_rt_sigsuspend_glue,sys32_rt_sigsuspend_glue)
+SYSCALL(sys_rt_sigsuspend,sys_rt_sigsuspend,compat_sys_rt_sigsuspend_wrapper)
 SYSCALL(sys_pread64,sys_pread64,sys32_pread64_wrapper)		/* 180 */
 SYSCALL(sys_pwrite64,sys_pwrite64,sys32_pwrite64_wrapper)
 SYSCALL(sys_chown16,sys_ni_syscall,sys32_chown16_wrapper)	/* old chown16 syscall */
@@ -293,5 +293,21 @@ SYSCALL(sys_waitid,sys_waitid,compat_sys
 SYSCALL(sys_ioprio_set,sys_ioprio_set,sys_ioprio_set_wrapper)
 SYSCALL(sys_ioprio_get,sys_ioprio_get,sys_ioprio_get_wrapper)
 SYSCALL(sys_inotify_init,sys_inotify_init,sys_inotify_init)
-SYSCALL(sys_inotify_add_watch,sys_inotify_add_watch,sys_inotify_add_watch_wrapper)
+SYSCALL(sys_inotify_add_watch,sys_inotify_add_watch,sys_inotify_add_watch_wrapper)	/* 285 */
 SYSCALL(sys_inotify_rm_watch,sys_inotify_rm_watch,sys_inotify_rm_watch_wrapper)
+NI_SYSCALL							/* 287 sys_migrate_pages */
+SYSCALL(sys_openat,sys_openat,compat_sys_openat_wrapper)
+SYSCALL(sys_mkdirat,sys_mkdirat,sys_mkdirat_wrapper)
+SYSCALL(sys_mknodat,sys_mknodat,sys_mknodat_wrapper)	/* 290 */
+SYSCALL(sys_fchownat,sys_fchownat,sys_fchownat_wrapper)
+SYSCALL(sys_futimesat,sys_futimesat,compat_sys_futimesat_wrapper)
+SYSCALL(sys_newfstatat,sys_newfstatat,compat_sys_newfstatat_wrapper)
+SYSCALL(sys_unlinkat,sys_unlinkat,sys_unlinkat_wrapper)
+SYSCALL(sys_renameat,sys_renameat,sys_renameat_wrapper)	/* 295 */
+SYSCALL(sys_linkat,sys_linkat,sys_linkat_wrapper)
+SYSCALL(sys_symlinkat,sys_symlinkat,sys_symlinkat_wrapper)
+SYSCALL(sys_readlinkat,sys_readlinkat,sys_readlinkat_wrapper)
+SYSCALL(sys_fchmodat,sys_fchmodat,sys_fchmodat_wrapper)
+SYSCALL(sys_faccessat,sys_faccessat,sys_faccessat_wrapper)	/* 300 */
+SYSCALL(sys_pselect6,sys_pselect6,compat_sys_pselect6_wrapper)
+SYSCALL(sys_ppoll,sys_ppoll,compat_sys_ppoll_wrapper)
diff --git a/include/asm-s390/thread_info.h b/include/asm-s390/thread_info.h
index f3797a5..8e0c7ed 100644
--- a/include/asm-s390/thread_info.h
+++ b/include/asm-s390/thread_info.h
@@ -2,7 +2,7 @@
  *  include/asm-s390/thread_info.h
  *
  *  S390 version
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 2002,2006
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
@@ -88,7 +88,7 @@ static inline struct thread_info *curren
  * thread information flags bit numbers
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
-#define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
+#define TIF_RESTORE_SIGMASK	1	/* restore signal mask in do_signal() */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
@@ -102,7 +102,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		19
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
+#define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index 2861cdc..29a9f35 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -279,8 +279,24 @@
 #define __NR_inotify_init	284
 #define __NR_inotify_add_watch	285
 #define __NR_inotify_rm_watch	286
+/* Number 287 is reserved for new sys_migrate_pages */
+#define __NR_openat		288
+#define __NR_mkdirat		289
+#define __NR_mknodat		290
+#define __NR_fchownat		291
+#define __NR_futimesat		292
+#define __NR_newfstatat		293
+#define __NR_unlinkat		294
+#define __NR_renameat		295
+#define __NR_linkat		296
+#define __NR_symlinkat		297
+#define __NR_readlinkat		298
+#define __NR_fchmodat		299
+#define __NR_faccessat		300
+#define __NR_pselect6		301
+#define __NR_ppoll		302
 
-#define NR_syscalls 287
+#define NR_syscalls 303
 
 /* 
  * There are some system calls that are not present on 64 bit, some
@@ -539,11 +555,15 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 # ifndef CONFIG_64BIT
 #   define __ARCH_WANT_STAT64
 #   define __ARCH_WANT_SYS_TIME
 # endif
-# define __ARCH_WANT_COMPAT_SYS_TIME
+# ifdef CONFIG_COMPAT
+#   define __ARCH_WANT_COMPAT_SYS_TIME
+#   define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+# endif
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
