Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSHEDYO>; Sun, 4 Aug 2002 23:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHEDYO>; Sun, 4 Aug 2002 23:24:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:42448 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318291AbSHEDYM>;
	Sun, 4 Aug 2002 23:24:12 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15693.61439.882186.69740@argo.ozlabs.ibm.com>
Date: Mon, 5 Aug 2002 13:24:47 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add FP exception mode prctl
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch that adds a prctl so that processes can set their
floating-point exception mode on PPC (and potentially on PPC64).  We
need this because the FP exception mode is controlled by bits in the
machine state register, which can only be accessed by the kernel, and
because the exception mode setting interacts with the lazy FPU
save/restore that the kernel does.

Would you mind applying this to your tree?

 arch/ppc/kernel/process.c   |   10 ++++++++--
 include/asm-ppc/processor.h |    5 +++--
 include/linux/prctl.h       |    8 ++++++++
 kernel/sys.c                |   13 +++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

Thanks,
Paul.


diff -urN linux-2.5/include/linux/prctl.h pmac-2.5/include/linux/prctl.h
--- linux-2.5/include/linux/prctl.h	Thu Apr 18 10:38:54 2002
+++ pmac-2.5/include/linux/prctl.h	Fri Aug  2 10:34:04 2002
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
diff -urN linux-2.5/kernel/sys.c pmac-2.5/kernel/sys.c
--- linux-2.5/kernel/sys.c	Fri Aug  2 07:48:46 2002
+++ pmac-2.5/kernel/sys.c	Fri Aug  2 16:25:32 2002
@@ -37,6 +37,12 @@
 #ifndef GET_FPEMU_CTL
 # define GET_FPEMU_CTL(a,b)	(-EINVAL)
 #endif
+#ifndef SET_FPEXC_CTL
+# define SET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef GET_FPEXC_CTL
+# define GET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -1283,6 +1289,13 @@
 		case PR_GET_FPEMU:
 			error = GET_FPEMU_CTL(current, arg2);
 			break;
+		case PR_SET_FPEXC:
+			error = SET_FPEXC_CTL(current, arg2);
+			break;
+		case PR_GET_FPEXC:
+			error = GET_FPEXC_CTL(current, arg2);
+			break;
+
 
 		case PR_GET_KEEPCAPS:
 			if (current->keep_capabilities)
diff -urN linux-2.5/arch/ppc/kernel/process.c pmac-2.5/arch/ppc/kernel/process.c
--- linux-2.5/arch/ppc/kernel/process.c	Sat Jul 27 21:52:45 2002
+++ pmac-2.5/arch/ppc/kernel/process.c	Sat Aug  3 19:22:31 2002
@@ -418,7 +418,6 @@
 #endif /* CONFIG_ALTIVEC */
 }
 
-#if 0
 int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 {
 	struct pt_regs *regs = tsk->thread.regs;
@@ -431,7 +430,14 @@
 			| tsk->thread.fpexc_mode;
 	return 0;
 }
-#endif
+
+int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
+{
+	unsigned int val;
+
+	val = __unpack_fe01(tsk->thread.fpexc_mode);
+	return put_user(val, (unsigned int *) adr);
+}
 
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
diff -urN linux-2.5/include/asm-ppc/processor.h pmac-2.5/include/asm-ppc/processor.h
--- linux-2.5/include/asm-ppc/processor.h	Wed Jul 31 09:53:49 2002
+++ pmac-2.5/include/asm-ppc/processor.h	Fri Aug  2 16:26:42 2002
@@ -747,9 +747,10 @@
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
 /* Get/set floating-point exception mode */
-#define GET_FP_EXC_MODE(tsk)		__unpack_fe01((tsk)->thread.fpexc_mode)
-#define SET_FP_EXC_MODE(tsk, val)	set_fpexc_mode((tsk), (val))
+#define GET_FPEXC_CTL(tsk, adr)	get_fpexc_mode((tsk), (adr))
+#define SET_FPEXC_CTL(tsk, val)	set_fpexc_mode((tsk), (val))
 
+extern int get_fpexc_mode(struct task_struct *tsk, unsigned long adr);
 extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
 
 static inline unsigned int __unpack_fe01(unsigned int msr_bits)
