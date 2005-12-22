Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVLVEvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVLVEvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVLVEvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35024 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965080AbVLVEvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:00 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 23/36] m68k: signal __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPr-0004si-Lc@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133512763 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/signal.c |   62 +++++++++++++++++++++++----------------------
 include/asm-m68k/signal.h |    2 +
 2 files changed, 32 insertions(+), 32 deletions(-)

dafff037d3e7ad98c08c58e7388296ba48f0fd6c
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 9c636a4..866917b 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -96,7 +96,7 @@ asmlinkage int do_sigsuspend(struct pt_r
 asmlinkage int
 do_rt_sigsuspend(struct pt_regs *regs)
 {
-	sigset_t *unewset = (sigset_t *)regs->d1;
+	sigset_t __user *unewset = (sigset_t __user *)regs->d1;
 	size_t sigsetsize = (size_t)regs->d2;
 	sigset_t saveset, newset;
 
@@ -122,8 +122,8 @@ do_rt_sigsuspend(struct pt_regs *regs)
 }
 
 asmlinkage int
-sys_sigaction(int sig, const struct old_sigaction *act,
-	      struct old_sigaction *oact)
+sys_sigaction(int sig, const struct old_sigaction __user *act,
+	      struct old_sigaction __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -154,7 +154,7 @@ sys_sigaction(int sig, const struct old_
 }
 
 asmlinkage int
-sys_sigaltstack(const stack_t *uss, stack_t *uoss)
+sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
 	return do_sigaltstack(uss, uoss, rdusp());
 }
@@ -169,10 +169,10 @@ sys_sigaltstack(const stack_t *uss, stac
 
 struct sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
 	int code;
-	struct sigcontext *psc;
+	struct sigcontext __user *psc;
 	char retcode[8];
 	unsigned long extramask[_NSIG_WORDS-1];
 	struct sigcontext sc;
@@ -180,10 +180,10 @@ struct sigframe
 
 struct rt_sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	char retcode[8];
 	struct siginfo info;
 	struct ucontext uc;
@@ -248,7 +248,7 @@ out:
 #define uc_formatvec	uc_filler[FPCONTEXT_SIZE/4]
 #define uc_extra	uc_filler[FPCONTEXT_SIZE/4+1]
 
-static inline int rt_restore_fpu_state(struct ucontext *uc)
+static inline int rt_restore_fpu_state(struct ucontext __user *uc)
 {
 	unsigned char fpstate[FPCONTEXT_SIZE];
 	int context_size = CPU_IS_060 ? 8 : 0;
@@ -267,7 +267,7 @@ static inline int rt_restore_fpu_state(s
 		return 0;
 	}
 
-	if (__get_user(*(long *)fpstate, (long *)&uc->uc_fpstate))
+	if (__get_user(*(long *)fpstate, (long __user *)&uc->uc_fpstate))
 		goto out;
 	if (CPU_IS_060 ? fpstate[2] : fpstate[0]) {
 		if (!CPU_IS_060)
@@ -306,7 +306,7 @@ static inline int rt_restore_fpu_state(s
 				    "m" (*fpregs.f_fpcntl));
 	}
 	if (context_size &&
-	    __copy_from_user(fpstate + 4, (long *)&uc->uc_fpstate + 1,
+	    __copy_from_user(fpstate + 4, (long __user *)&uc->uc_fpstate + 1,
 			     context_size))
 		goto out;
 	__asm__ volatile (".chip 68k/68881\n\t"
@@ -319,7 +319,7 @@ out:
 }
 
 static inline int
-restore_sigcontext(struct pt_regs *regs, struct sigcontext *usc, void *fp,
+restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, void __user *fp,
 		   int *pd0)
 {
 	int fsize, formatvec;
@@ -404,10 +404,10 @@ badframe:
 
 static inline int
 rt_restore_ucontext(struct pt_regs *regs, struct switch_stack *sw,
-		    struct ucontext *uc, int *pd0)
+		    struct ucontext __user *uc, int *pd0)
 {
 	int fsize, temp;
-	greg_t *gregs = uc->uc_mcontext.gregs;
+	greg_t __user *gregs = uc->uc_mcontext.gregs;
 	unsigned long usp;
 	int err;
 
@@ -506,7 +506,7 @@ asmlinkage int do_sigreturn(unsigned lon
 	struct switch_stack *sw = (struct switch_stack *) &__unused;
 	struct pt_regs *regs = (struct pt_regs *) (sw + 1);
 	unsigned long usp = rdusp();
-	struct sigframe *frame = (struct sigframe *)(usp - 4);
+	struct sigframe __user *frame = (struct sigframe __user *)(usp - 4);
 	sigset_t set;
 	int d0;
 
@@ -536,7 +536,7 @@ asmlinkage int do_rt_sigreturn(unsigned 
 	struct switch_stack *sw = (struct switch_stack *) &__unused;
 	struct pt_regs *regs = (struct pt_regs *) (sw + 1);
 	unsigned long usp = rdusp();
-	struct rt_sigframe *frame = (struct rt_sigframe *)(usp - 4);
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)(usp - 4);
 	sigset_t set;
 	int d0;
 
@@ -596,7 +596,7 @@ static inline void save_fpu_state(struct
 	}
 }
 
-static inline int rt_save_fpu_state(struct ucontext *uc, struct pt_regs *regs)
+static inline int rt_save_fpu_state(struct ucontext __user *uc, struct pt_regs *regs)
 {
 	unsigned char fpstate[FPCONTEXT_SIZE];
 	int context_size = CPU_IS_060 ? 8 : 0;
@@ -617,7 +617,7 @@ static inline int rt_save_fpu_state(stru
 			  ".chip 68k"
 			  : : "m" (*fpstate) : "memory");
 
-	err |= __put_user(*(long *)fpstate, (long *)&uc->uc_fpstate);
+	err |= __put_user(*(long *)fpstate, (long __user *)&uc->uc_fpstate);
 	if (CPU_IS_060 ? fpstate[2] : fpstate[0]) {
 		fpregset_t fpregs;
 		if (!CPU_IS_060)
@@ -642,7 +642,7 @@ static inline int rt_save_fpu_state(stru
 				    sizeof(fpregs));
 	}
 	if (context_size)
-		err |= copy_to_user((long *)&uc->uc_fpstate + 1, fpstate + 4,
+		err |= copy_to_user((long __user *)&uc->uc_fpstate + 1, fpstate + 4,
 				    context_size);
 	return err;
 }
@@ -662,10 +662,10 @@ static void setup_sigcontext(struct sigc
 	save_fpu_state(sc, regs);
 }
 
-static inline int rt_setup_ucontext(struct ucontext *uc, struct pt_regs *regs)
+static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *regs)
 {
 	struct switch_stack *sw = (struct switch_stack *)regs - 1;
-	greg_t *gregs = uc->uc_mcontext.gregs;
+	greg_t __user *gregs = uc->uc_mcontext.gregs;
 	int err = 0;
 
 	err |= __put_user(MCONTEXT_VERSION, &uc->uc_mcontext.version);
@@ -753,7 +753,7 @@ static inline void push_cache (unsigned 
 	}
 }
 
-static inline void *
+static inline void __user *
 get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long usp;
@@ -766,13 +766,13 @@ get_sigframe(struct k_sigaction *ka, str
 		if (!on_sig_stack(usp))
 			usp = current->sas_ss_sp + current->sas_ss_size;
 	}
-	return (void *)((usp - frame_size) & -8UL);
+	return (void __user *)((usp - frame_size) & -8UL);
 }
 
 static void setup_frame (int sig, struct k_sigaction *ka,
 			 sigset_t *set, struct pt_regs *regs)
 {
-	struct sigframe *frame;
+	struct sigframe __user *frame;
 	int fsize = frame_extra_sizes[regs->format];
 	struct sigcontext context;
 	int err = 0;
@@ -813,7 +813,7 @@ static void setup_frame (int sig, struct
 	err |= __put_user(frame->retcode, &frame->pretcode);
 	/* moveq #,d0; trap #0 */
 	err |= __put_user(0x70004e40 + (__NR_sigreturn << 16),
-			  (long *)(frame->retcode));
+			  (long __user *)(frame->retcode));
 
 	if (err)
 		goto give_sigsegv;
@@ -849,7 +849,7 @@ give_sigsegv:
 static void setup_rt_frame (int sig, struct k_sigaction *ka, siginfo_t *info,
 			    sigset_t *set, struct pt_regs *regs)
 {
-	struct rt_sigframe *frame;
+	struct rt_sigframe __user *frame;
 	int fsize = frame_extra_sizes[regs->format];
 	int err = 0;
 
@@ -880,8 +880,8 @@ static void setup_rt_frame (int sig, str
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
-	err |= __put_user((void *)current->sas_ss_sp,
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __put_user((void __user *)current->sas_ss_sp,
 			  &frame->uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(rdusp()),
 			  &frame->uc.uc_stack.ss_flags);
@@ -893,8 +893,8 @@ static void setup_rt_frame (int sig, str
 	err |= __put_user(frame->retcode, &frame->pretcode);
 	/* moveq #,d0; notb d0; trap #0 */
 	err |= __put_user(0x70004600 + ((__NR_rt_sigreturn ^ 0xff) << 16),
-			  (long *)(frame->retcode + 0));
-	err |= __put_user(0x4e40, (short *)(frame->retcode + 4));
+			  (long __user *)(frame->retcode + 0));
+	err |= __put_user(0x4e40, (short __user *)(frame->retcode + 4));
 
 	if (err)
 		goto give_sigsegv;
diff --git a/include/asm-m68k/signal.h b/include/asm-m68k/signal.h
index a0cdf90..b7b7ea2 100644
--- a/include/asm-m68k/signal.h
+++ b/include/asm-m68k/signal.h
@@ -144,7 +144,7 @@ struct sigaction {
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
-	void *ss_sp;
+	void __user *ss_sp;
 	int ss_flags;
 	size_t ss_size;
 } stack_t;
-- 
0.99.9.GIT

