Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUCLThc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUCLThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:37:11 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:40583 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S262425AbUCLTf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:35:57 -0500
Date: Fri, 12 Mar 2004 20:35:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/10): core s390.
Message-ID: <20040312193541.GB2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 core changes:
 - Merge 31 and 64 bit NR_CPUS config option. Default to 32 cpus.
 - Remove unused system calls from compat_linux.c.
 - Add statfs64 and fstatfs64. Reserve system call number for 
   remap_file_pages.
 - Merge do_signal32 into do_signal.
 - Don't remove the per bit and the program mask from the user psw
   due to a signal.
 - Fix a problem with gdb and interrupted system calls.
 - Fix single stepping of interrupted system calls.
 - Fix compiler warnings in bitops.h.

diffstat:
 arch/s390/Kconfig                 |   17 ------
 arch/s390/kernel/compat_linux.c   |   50 ------------------
 arch/s390/kernel/compat_linux.h   |    5 +
 arch/s390/kernel/compat_signal.c  |   92 ++-------------------------------
 arch/s390/kernel/compat_wrapper.S |   14 +++++
 arch/s390/kernel/entry.S          |    4 -
 arch/s390/kernel/entry64.S        |    2 
 arch/s390/kernel/ptrace.c         |   12 ++--
 arch/s390/kernel/signal.c         |  104 ++++++++++++++++++++------------------
 arch/s390/kernel/sys_s390.c       |   47 -----------------
 arch/s390/kernel/syscalls.S       |    5 +
 include/asm-s390/bitops.h         |   16 ++---
 include/asm-s390/ptrace.h         |    8 ++
 include/asm-s390/unistd.h         |    8 ++
 kernel/exit.c                     |    3 -
 kernel/signal.c                   |    3 -
 16 files changed, 124 insertions(+), 266 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Fri Mar 12 20:01:31 2004
@@ -96,23 +96,10 @@
 	  Even if you don't know what to do here, say Y.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
-	depends on SMP && ARCH_S390X = 'n'
-	default "32"
-	help
-	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support.  The maximum supported value is 32 and the
-	  minimum value which makes sense is 2.
-
-	  This is purely to save memory - each supported CPU adds
-	  approximately eight kilobytes to the kernel image.
-	
-config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
-	depends on SMP && ARCH_S390X
-	default "64"
+	depends on SMP
+	default "32"
 	help
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  The maximum supported value is 64 and the
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Thu Mar 11 03:55:43 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Fri Mar 12 20:01:31 2004
@@ -1383,11 +1383,6 @@
 	return err;
 }
 
-asmlinkage int sys32_sysfs(int option, u32 arg1, u32 arg2)
-{
-	return sys_sysfs(option, arg1, arg2);
-}
-
 struct ncp_mount_data32 {
         int version;
         unsigned int ncp_fd;
@@ -2273,33 +2268,6 @@
 	return do_sys_settimeofday(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-asmlinkage int sys32_utimes(char __user *filename,
-			struct compat_timeval __user *tvs)
-{
-	char *kfilename;
-	struct timeval ktvs[2];
-	mm_segment_t old_fs;
-	int ret;
-
-	kfilename = getname(filename);
-	ret = PTR_ERR(kfilename);
-	if (!IS_ERR(kfilename)) {
-		if (tvs) {
-			if (get_tv32(&ktvs[0], tvs) ||
-			    get_tv32(&ktvs[1], 1+tvs))
-				return -EFAULT;
-		}
-
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		ret = sys_utimes(kfilename, &ktvs[0]);
-		set_fs(old_fs);
-
-		putname(kfilename);
-	}
-	return ret;
-}
-
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage int sys32_pause(void)
 {
@@ -2308,17 +2276,6 @@
 	return -ERESTARTNOHAND;
 }
 
-
-asmlinkage int sys32_prctl(int option, u32 arg2, u32 arg3, u32 arg4, u32 arg5)
-{
-	return sys_prctl(option,
-			 (unsigned long) arg2,
-			 (unsigned long) arg3,
-			 (unsigned long) arg4,
-			 (unsigned long) arg5);
-}
-
-
 asmlinkage compat_ssize_t sys32_pread64(unsigned int fd, char *ubuf,
 				 compat_size_t count, u32 poshi, u32 poslo)
 {
@@ -2452,13 +2409,6 @@
 	return ret;
 }
 
-asmlinkage int sys_setpriority32(u32 which, u32 who, u32 niceval)
-{
-	return sys_setpriority((int) which,
-			       (int) who,
-			       (int) niceval);
-}
-
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
diff -urN linux-2.6/arch/s390/kernel/compat_linux.h linux-2.6-s390/arch/s390/kernel/compat_linux.h
--- linux-2.6/arch/s390/kernel/compat_linux.h	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.h	Fri Mar 12 20:01:31 2004
@@ -144,6 +144,11 @@
 			 PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK | \
 			 PSW32_MASK_PSTATE)
 
+#define PSW32_MASK_MERGE(CURRENT,NEW) \
+        (((CURRENT) & ~(PSW32_MASK_CC|PSW32_MASK_PM)) | \
+         ((NEW) & (PSW32_MASK_CC|PSW32_MASK_PM)))
+
+
 typedef struct
 {
 	_psw_t32	psw;
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Fri Mar 12 20:01:31 2004
@@ -53,8 +53,6 @@
 
 asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
-int do_signal32(struct pt_regs *regs, sigset_t *oldset);
-
 int copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from)
 {
 	int err;
@@ -123,7 +121,7 @@
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
-		if (do_signal32(regs, &saveset))
+		if (do_signal(regs, &saveset))
 			return -EINTR;
 	}
 }
@@ -158,7 +156,7 @@
         while (1) {
                 set_current_state(TASK_INTERRUPTIBLE);
                 schedule();
-                if (do_signal32(regs, &saveset))
+                if (do_signal(regs, &saveset))
                         return -EINTR;
         }
 }                                                         
@@ -294,8 +292,8 @@
 	_s390_regs_common32 regs32;
 	int err, i;
 
-	regs32.psw.mask = PSW32_USER_BITS |
-		((__u32)(regs->psw.mask >> 32) & PSW32_MASK_CC);
+	regs32.psw.mask = PSW32_MASK_MERGE(PSW32_USER_BITS,
+					   (__u32)(regs->psw.mask >> 32));
 	regs32.psw.addr = PSW32_ADDR_AMODE31 | (__u32) regs->psw.addr;
 	for (i = 0; i < NUM_GPRS; i++)
 		regs32.gprs[i] = (__u32) regs->gprs[i];
@@ -320,8 +318,8 @@
 	err = __copy_from_user(&regs32, &sregs->regs, sizeof(regs32));
 	if (err)
 		return err;
-	regs->psw.mask = PSW_USER32_BITS |
-		(__u64)(regs32.psw.mask & PSW32_MASK_CC) << 32;
+	regs->psw.mask = PSW_MASK_MERGE(regs->psw.mask,
+				        (__u64)regs32.psw.mask << 32);
 	regs->psw.addr = (__u64)(regs32.psw.addr & PSW32_ADDR_INSN);
 	for (i = 0; i < NUM_GPRS; i++)
 		regs->gprs[i] = (__u64) regs32.gprs[i];
@@ -482,7 +480,6 @@
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__u64) frame;
 	regs->psw.addr = (__u64) ka->sa.sa_handler;
-	regs->psw.mask = PSW_USER32_BITS;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__u64) &frame->sc;
@@ -539,7 +536,6 @@
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__u64) frame;
 	regs->psw.addr = (__u64) ka->sa.sa_handler;
-	regs->psw.mask = PSW_USER32_BITS;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__u64) &frame->info;
@@ -556,36 +552,12 @@
  * OK, we're invoking a handler
  */	
 
-static void
+void
 handle_signal32(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs)
 {
 	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
-	/* Are we from a system call? */
-	if (regs->trap == __LC_SVC_OLD_PSW) {
-		/* If so, check system call restarting.. */
-		switch (regs->gprs[2]) {
-			case -ERESTART_RESTARTBLOCK:
-				current_thread_info()->restart_block.fn =
-					do_no_restart_syscall;
-				clear_thread_flag(TIF_RESTART_SVC);
-			case -ERESTARTNOHAND:
-				regs->gprs[2] = -EINTR;
-				break;
-
-			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
-					regs->gprs[2] = -EINTR;
-					break;
-				}
-			/* fallthrough */
-			case -ERESTARTNOINTR:
-				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= regs->ilc;
-		}
-	}
-
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame32(sig, ka, info, oldset, regs);
@@ -604,53 +576,3 @@
 	}
 }
 
-/*
- * Note that 'init' is a special process: it doesn't get signals it doesn't
- * want to handle. Thus you cannot kill init even with a SIGKILL even by
- * mistake.
- *
- * Note that we go through the signals twice: once to check the signals that
- * the kernel can handle, and then we build all the user-level signal handling
- * stack-frames in one go after that.
- */
-int do_signal32(struct pt_regs *regs, sigset_t *oldset)
-{
-	siginfo_t info;
-	int signr;
-
-	/*
-	 * We want the common case to go fast, which
-	 * is why we may in certain cases get here from
-	 * kernel mode. Just return without doing anything
-	 * if so.
-	 */
-	if (!user_mode(regs))
-		return 1;
-
-	if (!oldset)
-		oldset = &current->blocked;
-
-	signr = get_signal_to_deliver(&info, regs, NULL);
-	if (signr > 0) {
-		/* Whee!  Actually deliver the signal.  */
-		handle_signal32(signr, &info, oldset, regs);
-		return 1;
-	}
-
-	/* Did we come from a system call? */
-	if ( regs->trap == __LC_SVC_OLD_PSW /* System Call! */ ) {
-		/* Restart the system call - no handlers present */
-		if (regs->gprs[2] == -ERESTARTNOHAND ||
-		    regs->gprs[2] == -ERESTARTSYS ||
-		    regs->gprs[2] == -ERESTARTNOINTR) {
-			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= regs->ilc;
-		}
-		/* Restart the system call with a new system call number */
-		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
-			regs->gprs[2] = __NR_restart_syscall;
-			set_thread_flag(TIF_RESTART_SVC);
-		}
-	}
-	return 0;
-}
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	Thu Mar 11 03:55:54 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Fri Mar 12 20:01:31 2004
@@ -1338,3 +1338,17 @@
 	llgtr	%r3,%r3			# struct iocb *
 	llgtr	%r4,%r4			# struct io_event *
 	jg	sys_io_cancel
+
+	.globl compat_sys_statfs64_wrapper
+compat_sys_statfs64_wrapper:
+	llgtr	%r2,%r2			# const char *
+	llgfr	%r3,%r3			# compat_size_t
+	llgtr	%r4,%r4			# struct compat_statfs64 *
+	jg	compat_statfs64
+
+	.globl compat_sys_fstatfs64_wrapper
+compat_sys_fstatfs64_wrapper:
+	llgfr	%r2,%r2			# unsigned int fd
+	llgfr	%r3,%r3			# compat_size_t
+	llgtr	%r4,%r4			# struct compat_statfs64 *
+	jg	compat_fstatfs64
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Mar 12 20:01:31 2004
@@ -473,11 +473,11 @@
 
 pgm_svcret:
 	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
-	bo	BASED(pgm_svcper_nosig)
+	bno	BASED(pgm_svcper_nosig)
 	la	%r2,SP_PTREGS(%r15) # load pt_regs
 	sr	%r3,%r3		  # clear *oldset
 	l	%r1,BASED(.Ldo_signal)
-	basr	%r4,%r1		  # call do_signal
+	basr	%r14,%r1	  # call do_signal
 	
 pgm_svcper_nosig:
         mvi     SP_TRAP+3(%r15),0x28     # set trap indication to pgm check
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Mar 12 20:01:31 2004
@@ -516,7 +516,7 @@
 
 pgm_svcret:
 	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
-	jo	pgm_svcper_nosig
+	jno	pgm_svcper_nosig
         la      %r2,SP_PTREGS(%r15) # load pt_regs
         sgr     %r3,%r3             # clear *oldset
 	brasl	%r14,do_signal
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Fri Mar 12 20:01:31 2004
@@ -193,9 +193,9 @@
 		 */
 		if (addr == (addr_t) &dummy->regs.psw.mask &&
 #ifdef CONFIG_S390_SUPPORT
-		    (data & ~PSW_MASK_CC) != PSW_USER32_BITS &&
+		    data != PSW_MASK_MERGE(PSW_USER32_BITS, data) &&
 #endif
-		    (data & ~PSW_MASK_CC) != PSW_USER_BITS)
+		    data != PSW_MASK_MERGE(PSW_USER_BITS, data))
 			/* Invalid psw mask. */
 			return -EINVAL;
 #ifndef CONFIG_ARCH_S390X
@@ -331,7 +331,7 @@
 		if (addr == (addr_t) &dummy32->regs.psw.mask) {
 			/* Fake a 31 bit psw mask. */
 			tmp = (__u32)(__KSTK_PTREGS(child)->psw.mask >> 32);
-			tmp = (tmp & PSW32_MASK_CC) | PSW32_USER_BITS;
+			tmp = PSW32_MASK_MERGE(PSW32_USER_BITS, tmp);
 		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
 			/* Fake a 31 bit psw address. */
 			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
@@ -402,11 +402,11 @@
 		 */
 		if (addr == (addr_t) &dummy32->regs.psw.mask) {
 			/* Build a 64 bit psw mask from 31 bit mask. */
-			if ((tmp & ~PSW32_MASK_CC) != PSW32_USER_BITS)
+			if (tmp != PSW32_MASK_MERGE(PSW32_USER_BITS, tmp))
 				/* Invalid psw mask. */
 				return -EINVAL;
-			__KSTK_PTREGS(child)->psw.mask = PSW_USER32_BITS |
-				((tmp & PSW32_MASK_CC) << 32);
+			__KSTK_PTREGS(child)->psw.mask = 
+				PSW_MASK_MERGE(PSW_USER32_BITS, (__u64) tmp << 32);
 		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
 			/* Build a 64 bit psw address from 31 bit address. */
 			__KSTK_PTREGS(child)->psw.addr = 
diff -urN linux-2.6/arch/s390/kernel/signal.c linux-2.6-s390/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/arch/s390/kernel/signal.c	Fri Mar 12 20:01:31 2004
@@ -148,9 +148,14 @@
 /* Returns non-zero on fault. */
 static int save_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
+	unsigned long old_mask = regs->psw.mask;
 	int err;
   
+	/* Copy a 'clean' PSW mask to the user to avoid leaking
+	   information about whether PER is currently on.  */
+	regs->psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
 	err = __copy_to_user(&sregs->regs, regs, sizeof(_s390_regs_common));
+	regs->psw.mask = old_mask;
 	if (err != 0)
 		return err;
 	/* 
@@ -165,13 +170,14 @@
 /* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
+	unsigned long old_mask = regs->psw.mask;
 	int err;
 
 	/* Alwys make any pending restarted system call return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
-	regs->psw.mask = PSW_USER_BITS | (regs->psw.mask & PSW_MASK_CC);
+	regs->psw.mask = PSW_MASK_MERGE(old_mask, regs->psw.mask);
 	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
@@ -319,7 +325,6 @@
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
 	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
-	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (unsigned long) &frame->sc;
@@ -378,7 +383,6 @@
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
 	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
-	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (unsigned long) &frame->info;
@@ -401,30 +405,6 @@
 {
 	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
-	/* Are we from a system call? */
-	if (regs->trap == __LC_SVC_OLD_PSW) {
-		/* If so, check system call restarting.. */
-		switch (regs->gprs[2]) {
-			case -ERESTART_RESTARTBLOCK:
-				current_thread_info()->restart_block.fn =
-					do_no_restart_syscall;
-				clear_thread_flag(TIF_RESTART_SVC);
-			case -ERESTARTNOHAND:
-				regs->gprs[2] = -EINTR;
-				break;
-
-			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
-					regs->gprs[2] = -EINTR;
-					break;
-				}
-			/* fallthrough */
-			case -ERESTARTNOINTR:
-				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= regs->ilc;
-		}
-	}
-
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(sig, ka, info, oldset, regs);
@@ -454,6 +434,7 @@
  */
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
+	unsigned long retval = 0, continue_addr = 0, restart_addr = 0;
 	siginfo_t info;
 	int signr;
 
@@ -468,35 +449,62 @@
 
 	if (!oldset)
 		oldset = &current->blocked;
-#ifdef CONFIG_S390_SUPPORT 
-	if (test_thread_flag(TIF_31BIT)) {
-		extern asmlinkage int do_signal32(struct pt_regs *regs,
-						  sigset_t *oldset); 
-		return do_signal32(regs, oldset);
-        }
-#endif 
 
+	/* Are we from a system call? */
+	if (regs->trap == __LC_SVC_OLD_PSW) {
+		continue_addr = regs->psw.addr;
+		restart_addr = continue_addr - regs->ilc;
+		retval = regs->gprs[2];
+
+		/* Prepare for system call restart.  We do this here so that a
+		   debugger will see the already changed PSW. */
+		if (retval == -ERESTARTNOHAND ||
+		    retval == -ERESTARTSYS ||
+		    retval == -ERESTARTNOINTR) {
+			regs->gprs[2] = regs->orig_gpr2;
+			regs->psw.addr = restart_addr;
+		} else if (retval == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = -EINTR;
+		}
+	}
+
+	/* Get signal to deliver.  When running under ptrace, at this point
+	   the debugger may change all our registers ... */
 	signr = get_signal_to_deliver(&info, regs, NULL);
+
+	/* Depending on the signal settings we may need to revert the
+	   decision to restart the system call. */
+	if (signr > 0 && regs->psw.addr == restart_addr) {
+		if (retval == -ERESTARTNOHAND
+		    || (retval == -ERESTARTSYS
+			 && !(current->sighand->action[signr-1].sa.sa_flags 
+			      & SA_RESTART))) {
+			regs->gprs[2] = -EINTR;
+			regs->psw.addr = continue_addr;
+		}
+	}
+	
 	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
+#ifdef CONFIG_S390_SUPPORT 
+		if (test_thread_flag(TIF_31BIT)) {
+			extern void handle_signal32(unsigned long sig, 
+						    siginfo_t *info, 
+						    sigset_t *oldset,
+						    struct pt_regs *regs);
+			handle_signal32(signr, &info, oldset, regs);
+			return 1;
+	        }
+#endif 
 		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
-	/* Did we come from a system call? */
-	if ( regs->trap == __LC_SVC_OLD_PSW /* System Call! */ ) {
-		/* Restart the system call - no handlers present */
-		if (regs->gprs[2] == -ERESTARTNOHAND ||
-		    regs->gprs[2] == -ERESTARTSYS ||
-		    regs->gprs[2] == -ERESTARTNOINTR) {
-			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= regs->ilc;
-		}
-		/* Restart the system call with a new system call number */
-		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
-			regs->gprs[2] = __NR_restart_syscall;
-			set_thread_flag(TIF_RESTART_SVC);
-		}
+	/* Restart a different system call. */
+	if (retval == -ERESTART_RESTARTBLOCK 
+	    && regs->psw.addr == continue_addr) {
+		regs->gprs[2] = __NR_restart_syscall;
+		set_thread_flag(TIF_RESTART_SVC);
 	}
 	return 0;
 }
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-s390/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	Fri Mar 12 20:01:29 2004
+++ linux-2.6-s390/arch/s390/kernel/sys_s390.c	Fri Mar 12 20:02:52 2004
@@ -245,52 +245,7 @@
 	return -EINVAL;
 }
 
-/*
- * Old cruft
- */
-asmlinkage int sys_uname(struct old_utsname * name)
-{
-	int err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
-}
-
-#ifndef CONFIG_ARCH_S390X
-asmlinkage int sys_olduname(struct oldold_utsname * name)
-{
-	int error;
-
-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-  
-  	down_read(&uts_sem);
-	
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
-	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
-	
-	up_read(&uts_sem);
-	
-	error = error ? -EFAULT : 0;
-
-	return error;
-}
-
-#else /* CONFIG_ARCH_S390X */
-
+#ifdef CONFIG_ARCH_S390X
 asmlinkage int s390x_newuname(struct new_utsname * name)
 {
 	int ret = sys_newuname(name);
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-s390/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	Fri Mar 12 20:01:29 2004
+++ linux-2.6-s390/arch/s390/kernel/syscalls.S	Fri Mar 12 20:01:31 2004
@@ -54,7 +54,7 @@
 SYSCALL(sys_times,sys_times,compat_sys_times_wrapper)
 NI_SYSCALL							/* old prof syscall */
 SYSCALL(sys_brk,sys_brk,sys32_brk_wrapper)			/* 45 */
-SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16)		/* old setgid16 syscall*/
+SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16_wrapper)	/* old setgid16 syscall*/
 SYSCALL(sys_getgid16,sys_ni_syscall,sys32_getgid16)		/* old getgid16 syscall*/
 SYSCALL(sys_signal,sys_signal,sys32_signal_wrapper)
 SYSCALL(sys_geteuid16,sys_ni_syscall,sys32_geteuid16)		/* old geteuid16 syscall */
@@ -273,3 +273,6 @@
 SYSCALL(sys_clock_nanosleep,sys_clock_nanosleep,sys32_clock_nanosleep_wrapper)
 NI_SYSCALL							/* reserved for vserver */
 SYSCALL(s390_fadvise64_64,sys_ni_syscall,sys32_fadvise64_64_wrapper)
+NI_SYSCALL							/* 265 new sys_remap_file_pages */
+SYSCALL(sys_statfs64,sys_statfs64,compat_sys_statfs64_wrapper)
+SYSCALL(sys_fstatfs64,sys_fstatfs64,compat_sys_fstatfs64_wrapper)
diff -urN linux-2.6/include/asm-s390/bitops.h linux-2.6-s390/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	Thu Mar 11 03:55:21 2004
+++ linux-2.6-s390/include/asm-s390/bitops.h	Fri Mar 12 20:01:31 2004
@@ -532,7 +532,7 @@
  * Find-bit routines..
  */
 static inline int
-find_first_zero_bit(unsigned long * addr, unsigned int size)
+find_first_zero_bit(const unsigned long * addr, unsigned int size)
 {
 	unsigned long cmp, count;
         unsigned int res;
@@ -571,7 +571,7 @@
 }
 
 static inline int
-find_first_bit(unsigned long * addr, unsigned int size)
+find_first_bit(const unsigned long * addr, unsigned int size)
 {
 	unsigned long cmp, count;
         unsigned int res;
@@ -610,7 +610,7 @@
 }
 
 static inline int
-find_next_zero_bit (unsigned long * addr, int size, int offset)
+find_next_zero_bit (const unsigned long * addr, int size, int offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
         unsigned long bitvec, reg;
@@ -649,7 +649,7 @@
 }
 
 static inline int
-find_next_bit (unsigned long * addr, int size, int offset)
+find_next_bit (const unsigned long * addr, int size, int offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
         unsigned long bitvec, reg;
@@ -693,7 +693,7 @@
  * Find-bit routines..
  */
 static inline unsigned long
-find_first_zero_bit(unsigned long * addr, unsigned long size)
+find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
         unsigned long res, cmp, count;
 
@@ -735,7 +735,7 @@
 }
 
 static inline unsigned long
-find_first_bit(unsigned long * addr, unsigned long size)
+find_first_bit(const unsigned long * addr, unsigned long size)
 {
         unsigned long res, cmp, count;
 
@@ -777,7 +777,7 @@
 }
 
 static inline unsigned long
-find_next_zero_bit (unsigned long * addr, unsigned long size, unsigned long offset)
+find_next_zero_bit (const unsigned long * addr, unsigned long size, unsigned long offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
         unsigned long bitvec, reg;
@@ -821,7 +821,7 @@
 }
 
 static inline unsigned long
-find_next_bit (unsigned long * addr, unsigned long size, unsigned long offset)
+find_next_bit (const unsigned long * addr, unsigned long size, unsigned long offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
         unsigned long bitvec, reg;
diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/include/asm-s390/ptrace.h	Fri Mar 12 20:01:31 2004
@@ -277,6 +277,14 @@
 			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
 			 PSW_MASK_PSTATE)
 
+/* This macro merges a NEW PSW mask specified by the user into
+   the currently active PSW mask CURRENT, modifying only those
+   bits in CURRENT that the user may be allowed to change: this
+   is the condition code and the program mask bits.  */
+#define PSW_MASK_MERGE(CURRENT,NEW) \
+	(((CURRENT) & ~(PSW_MASK_CC|PSW_MASK_PM)) | \
+	 ((NEW) & (PSW_MASK_CC|PSW_MASK_PM)))
+
 /*
  * The first entries in pt_regs and user_regs_struct
  * are common for the two structures. The s390_regs structure
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-s390/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	Fri Mar 12 20:01:30 2004
+++ linux-2.6-s390/include/asm-s390/unistd.h	Fri Mar 12 20:01:31 2004
@@ -260,8 +260,12 @@
  * Number 263 is reserved for vserver
  */
 #define __NR_fadvise64_64	264
-
-#define NR_syscalls 265
+/*
+ * Number 265 is reserved for new sys_remap_file_pages
+ */
+#define __NR_statfs64		266
+#define __NR_fstatfs64		267
+#define NR_syscalls 268
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff -urN linux-2.6/kernel/exit.c linux-2.6-s390/kernel/exit.c
--- linux-2.6/kernel/exit.c	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/kernel/exit.c	Fri Mar 12 20:01:31 2004
@@ -1146,7 +1146,8 @@
 	return retval;
 }
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__arm__)
+#if !defined(__alpha__) && !defined(__ia64__) && \
+    !defined(__arm__) && !defined(__s390__)
 
 /*
  * sys_waitpid() remains for compatibility. waitpid() should be
diff -urN linux-2.6/kernel/signal.c linux-2.6-s390/kernel/signal.c
--- linux-2.6/kernel/signal.c	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/kernel/signal.c	Fri Mar 12 20:01:31 2004
@@ -2476,7 +2476,8 @@
 #endif /* __sparc__ */
 #endif
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__arm__)
+#if !defined(__alpha__) && !defined(__ia64__) && \
+    !defined(__arm__) && !defined(__s390__)
 /*
  * For backwards compatibility.  Functionality superseded by sigprocmask.
  */
