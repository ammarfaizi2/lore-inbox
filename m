Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbTAZKVw>; Sun, 26 Jan 2003 05:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTAZKVw>; Sun, 26 Jan 2003 05:21:52 -0500
Received: from dp.samba.org ([66.70.73.150]:60310 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266794AbTAZKVt>;
	Sun, 26 Jan 2003 05:21:49 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15923.47144.352.220728@argo.ozlabs.ibm.com>
Date: Sun, 26 Jan 2003 21:27:51 +1100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add prctls for FP exception control
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The patch below adds a couple of new prctl calls to allow processes to
get and set their floating-point exception mode.  We need this on
PowerPC since the exception mode is controlled by bits in the MSR,
which only the kernel can access.  (The 4 modes are exceptions
disabled, asynchronous non-recoverable exceptions, asynchronous
recoverable exceptions, and precise exceptions.  There can be
significant differences in floating-point performance depending on the
mode in some PPC implementations.)

This patch is back-ported from 2.5.  Linus accepted the equivalent
change for 2.5 several months ago.  The patch also tidies up the
sys_prctl() code a little as was done in the 2.5 tree.  Please apply
this to your tree.

Thanks,
Paul.

diff -urN linux-2.4/include/linux/prctl.h test/include/linux/prctl.h
--- linux-2.4/include/linux/prctl.h	2002-02-06 01:10:25.000000000 +1100
+++ test/include/linux/prctl.h	2003-01-25 22:14:15.000000000 +1100
@@ -26,4 +26,12 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get/set floating-point exception mode (if meaningful) */
+#define PR_GET_FPEXC	11
+#define PR_SET_FPEXC	12
+# define PR_FP_EXC_DISABLED	0	/* FP exceptions disabled */
+# define PR_FP_EXC_NONRECOV	1	/* async non-recoverable exc. mode */
+# define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
+# define PR_FP_EXC_PRECISE	3	/* precise exception mode */
+
 #endif /* _LINUX_PRCTL_H */
diff -urN linux-2.4/kernel/sys.c test/kernel/sys.c
--- linux-2.4/kernel/sys.c	2002-05-10 02:50:20.000000000 +1000
+++ test/kernel/sys.c	2003-01-25 22:14:15.000000000 +1100
@@ -18,6 +18,25 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#ifndef SET_UNALIGN_CTL
+# define SET_UNALIGN_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef GET_UNALIGN_CTL
+# define GET_UNALIGN_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef SET_FPEMU_CTL
+# define SET_FPEMU_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef GET_FPEMU_CTL
+# define GET_FPEMU_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef SET_FPEXC_CTL
+# define SET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef GET_FPEXC_CTL
+# define GET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
+
 /*
  * this is where the system-wide overflow UID and GID are defined, for
  * architectures that now have 32-bit UID/GID but didn't in the past
@@ -1229,36 +1248,24 @@
 			}
 			current->mm->dumpable = arg2;
 			break;
+
 	        case PR_SET_UNALIGN:
-#ifdef SET_UNALIGN_CTL
 			error = SET_UNALIGN_CTL(current, arg2);
-#else
-			error = -EINVAL;
-#endif
 			break;
-
 	        case PR_GET_UNALIGN:
-#ifdef GET_UNALIGN_CTL
 			error = GET_UNALIGN_CTL(current, arg2);
-#else
-			error = -EINVAL;
-#endif
 			break;
-
 	        case PR_SET_FPEMU:
-#ifdef SET_FPEMU_CTL
 			error = SET_FPEMU_CTL(current, arg2);
-#else
-			error = -EINVAL;
-#endif
 			break;
-
 	        case PR_GET_FPEMU:
-#ifdef GET_FPEMU_CTL
 			error = GET_FPEMU_CTL(current, arg2);
-#else
-			error = -EINVAL;
-#endif
+			break;
+		case PR_SET_FPEXC:
+			error = SET_FPEXC_CTL(current, arg2);
+			break;
+		case PR_GET_FPEXC:
+			error = GET_FPEXC_CTL(current, arg2);
 			break;
 
 		case PR_GET_KEEPCAPS:
diff -urN linux-2.4/arch/ppc/kernel/process.c test/arch/ppc/kernel/process.c
--- linux-2.4/arch/ppc/kernel/process.c	2002-02-05 18:58:43.000000000 +1100
+++ test/arch/ppc/kernel/process.c	2003-01-25 22:16:03.000000000 +1100
@@ -34,6 +34,7 @@
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/init.h>
+#include <linux/prctl.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -403,6 +404,40 @@
 	current->thread.fpscr = 0;
 }
 
+/*
+ * Support for the PR_GET/SET_FPEXC prctl() calls.
+ */
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
+}
+
+int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
+{
+	unsigned int val;
+
+	val = __unpack_fe01(tsk->thread.fpexc_mode);
+	return put_user(val, (unsigned int *) adr);
+}
+
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
diff -urN linux-2.4/include/asm-ppc/processor.h test/include/asm-ppc/processor.h
--- linux-2.4/include/asm-ppc/processor.h	2002-10-09 08:18:47.000000000 +1000
+++ test/include/asm-ppc/processor.h	2003-01-25 22:19:33.000000000 +1100
@@ -659,10 +659,10 @@
 
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
@@ -677,13 +677,10 @@
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 
 #define INIT_THREAD  { \
-	INIT_SP, /* ksp */ \
-	0, /* wchan */ \
-	0, /* regs */ \
-	KERNEL_DS, /*fs*/ \
-	swapper_pg_dir, /* pgdir */ \
-	0, /* last_syscall */ \
-	{0}, 0, 0 \
+	.ksp = INIT_SP, \
+	.fs = KERNEL_DS, \
+	.pgdir = swapper_pg_dir, \
+	.fpexc_mode = MSR_FE0 | MSR_FE1, \
 }
 
 /*
@@ -702,6 +699,13 @@
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
+/* Get/set floating-point exception mode */
+#define GET_FPEXC_CTL(tsk, adr)	get_fpexc_mode((tsk), (adr))
+#define SET_FPEXC_CTL(tsk, val)	set_fpexc_mode((tsk), (val))
+
+extern int get_fpexc_mode(struct task_struct *tsk, unsigned long adr);
+extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
+
 /*
  * NOTE! The task struct and the stack go together
  */
