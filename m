Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281732AbRKQMNY>; Sat, 17 Nov 2001 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281733AbRKQMNP>; Sat, 17 Nov 2001 07:13:15 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:46090 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281732AbRKQMNG>;
	Sat, 17 Nov 2001 07:13:06 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15350.21525.585246.127272@cargo.ozlabs.ibm.com>
Date: Sat, 17 Nov 2001 23:12:05 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: prctl for PPC fp exception mode
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to provide a way for user tasks on PPC machines to control
which floating-point exception mode they are using.  The PowerPC
architecture provides four FP exception modes: exceptions disabled,
asynchronous non-recoverable, asynchronous recoverable, and precise.
The mode is controlled by 2 bits in the machine state register (MSR),
which is privileged.  Some modes are faster than others on some
implementations and some users want to be able to control the mode
from userspace.

To do this, I would like to add to the prctl system call as in the
patch below.  There is already provision for prctl to control whether
unaligned accesses trap or not on ia64, which seems somewhat similar
in spirit.

Is this a reasonable way to provide this facility?  Does anyone have
any objections and/or any better suggestions?

Thanks,
Paul.

diff -urN linux-2.4.15-pre5/kernel/sys.c pmac/kernel/sys.c
--- linux-2.4.15-pre5/kernel/sys.c	Mon Sep 24 09:31:38 2001
+++ pmac/kernel/sys.c	Fri Nov 16 06:57:29 2001
@@ -1256,6 +1256,16 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+
+#ifdef SET_FP_EXC_MODE
+		case PR_SET_FP_EXC:
+			error = SET_FP_EXC_MODE(current, arg2);
+			break;
+		case PR_GET_FP_EXC:
+			error = GET_FP_EXC_MODE(current);
+			break;
+#endif
+
 		default:
 			error = -EINVAL;
 			break;
diff -urN linux-2.4.15-pre5/include/linux/prctl.h pmac/include/linux/prctl.h
--- linux-2.4.15-pre5/include/linux/prctl.h	Sat Jul 21 09:51:58 2001
+++ pmac/include/linux/prctl.h	Fri Nov 16 06:52:26 2001
@@ -20,4 +20,11 @@
 #define PR_GET_KEEPCAPS   7
 #define PR_SET_KEEPCAPS   8
 
+/* Get/set floating-point exception mode (if meaningful) */
+#define PR_GET_FP_EXC	  9
+#define PR_SET_FP_EXC	 10
+# define PR_FP_EXC_DISABLED	0	/* FP exceptions disabled */
+# define PR_FP_EXC_NONRECOV	1	/* async non-recoverable exc. mode */
+# define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
+# define PR_FP_EXC_PRECISE	3	/* precise exception mode */
 #endif /* _LINUX_PRCTL_H */
diff -urN linux-2.4.15-pre5/include/asm-ppc/processor.h pmac/include/asm-ppc/processor.h
--- linux-2.4.15-pre5/include/asm-ppc/processor.h	Wed Oct 10 12:39:11 2001
+++ pmac/include/asm-ppc/processor.h	Fri Nov 16 16:39:33 2001
@@ -593,10 +593,10 @@
 
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
-	unsigned long	wchan;		/* Event task is sleeping on */
 	struct pt_regs	*regs;		/* Pointer to saved register state */
 	mm_segment_t	fs;		/* for get_fs() validation */
 	void		*pgdir;		/* root of page-table tree */
+	int		fpexc_mode;	/* floating-point exception mode */
 	signed long     last_syscall;
 	double		fpr[32];	/* Complete floating point set */
 	unsigned long	fpscr_pad;	/* fpr ... fpscr must be contiguous */
@@ -611,13 +611,9 @@
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 
 #define INIT_THREAD  { \
-	INIT_SP, /* ksp */ \
-	0, /* wchan */ \
-	0, /* regs */ \
-	KERNEL_DS, /*fs*/ \
-	swapper_pg_dir, /* pgdir */ \
-	0, /* last_syscall */ \
-	{0}, 0, 0 \
+	ksp: INIT_SP, \
+	fs: KERNEL_DS, \
+	pgdir: swapper_pg_dir, \
 }
 
 /*
@@ -636,6 +636,22 @@
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
+/* Get/set floating-point exception mode */
+#define GET_FP_EXC_MODE(tsk)		__unpack_fe01((tsk)->thread.fpexc_mode)
+#define SET_FP_EXC_MODE(tsk, val)	set_fpexc_mode((tsk), (val))
+
+extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
+
+static inline unsigned int __unpack_fe01(unsigned int msr_bits)
+{
+	return ((msr_bits & MSR_FE0) >> 10) | ((msr_bits & MSR_FE1) >> 8);
+}
+
+static inline unsigned int __pack_fe01(unsigned int fpmode)
+{
+	return ((fpmode << 10) & MSR_FE0) | ((fpmode << 8) & MSR_FE1);
+}
+
 /*
  * NOTE! The task struct and the stack go together
  */
diff -urN linux-2.4.15-pre5/arch/ppc/kernel/process.c pmac/arch/ppc/kernel/process.c
--- linux-2.4.15-pre5/arch/ppc/kernel/process.c	Wed Oct 10 12:38:52 2001
+++ pmac/arch/ppc/kernel/process.c	Fri Nov 16 08:11:03 2001
@@ -34,6 +34,7 @@
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/init.h>
+#include <linux/prctl.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -399,7 +399,26 @@
 		last_task_used_math = 0;
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = 0;
+	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
 	current->thread.fpscr = 0;
+#ifdef CONFIG_ALTIVEC
+	memset(current->thread.vr, 0, sizeof(current->thread.vr));
+	memset(&current->thread.vscr, 0, sizeof(current->thread.vscr));
+	current->thread.vrsave = 0;
+#endif /* CONFIG_ALTIVEC */
+}
+
+int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
+{
+	struct pt_regs *regs = tsk->thread.regs;
+
+	if (val > PR_FP_EXC_PRECISE)
+		return -EINVAL;
+	tsk->thread.fpexc_mode = __pack_fe01(val);
+	if (regs != NULL && (regs->msr & MSR_FP) != 0)
+		regs->msr = (regs->msr & ~(MSR_FE0|MSR_FE1))
+			| tsk->thread.fpexc_mode;
+	return 0;
 }
 
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
