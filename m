Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVEAWGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVEAWGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:06:34 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:34323 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262705AbVEAVSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:50 -0400
Message-Id: <200505012112.j41LCefB016439@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 11/22] UML - S390 preparation, abstract host page fault data
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch removes the arch-specific fault/trap-infos
from thread and skas-regs.
It adds a new struct faultinfo, that is arch-specific
defined in sysdep/faultinfo.h.
The structure is inserted in thread.arch and
thread.regs.skas and thread.regs.tt
Now, segv and other trap-handlers can copy the contents
from regs.X.faultinfo to thread.arch.faultinfo
with one simple assignment.
Also, the number of macros necessary is reduced to

FAULT_ADDRESS(struct faultinfo)
    extracts the faulting address from faultinfo

FAULT_WRITE(struct faultinfo)
    extracts the "is_write" flag

SEGV_IS_FIXABLE(struct faultinfo)
    is true for the fixable segvs, i.e. (TRAP == 14)
    on i386

UPT_FAULTINFO(regs)
    result is (struct faultinfo *) to the faultinfo
    in regs->skas.faultinfo

GET_FAULTINFO_FROM_SC(struct faultinfo, struct sigcontext *)
    copies the relevant parts of the sigcontext to
    struct faultinfo.
On SIGSEGV, call user_signal() instead of handle_segv(), if the
architecture provides the information needed in PTRACE_FAULTINFO,
or if PTRACE_FAULTINFO is missing, because segv-stub will provide
the info.
The benefit of the change is, that in case of a non-fixable SIGSEGV,
we can give user processes a SIGSEGV, instead of possibly looping
on pagefault handling.
Since handle_segv() sikked arch_fixup() implicitly by passing ip==0
to segv(), I changed segv() to call arch_fixup() only, if !is_user.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/kern_util.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/kern_util.h	2005-04-30 13:08:02.000000000 -0400
@@ -8,6 +8,7 @@
 
 #include "linux/threads.h"
 #include "sysdep/ptrace.h"
+#include "sysdep/faultinfo.h"
 
 extern int ncpus;
 extern char *linux_prog;
@@ -31,8 +32,8 @@
 extern unsigned long alloc_stack(int order, int atomic);
 extern int do_signal(void);
 extern int is_stack_fault(unsigned long sp);
-extern unsigned long segv(unsigned long address, unsigned long ip, 
-			  int is_write, int is_user, void *sc);
+extern unsigned long segv(struct faultinfo fi, unsigned long ip,
+			  int is_user, void *sc);
 extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);
 extern void syscall_ready(void);
@@ -82,7 +83,7 @@
 extern void unprotect_stack(unsigned long stack);
 extern void do_uml_exitcalls(void);
 extern int attach_debugger(int idle_pid, int pid, int stop);
-extern void bad_segv(unsigned long address, unsigned long ip, int is_write);
+extern void bad_segv(struct faultinfo fi, unsigned long ip);
 extern int config_gdb(char *str);
 extern int remove_gdb(void);
 extern char *uml_strdup(char *string);
Index: linux-2.6.11-mm/arch/um/include/sysdep-i386/faultinfo.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-i386/faultinfo.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-i386/faultinfo.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ * Licensed under the GPL
+ */
+
+#ifndef __FAULTINFO_I386_H
+#define __FAULTINFO_I386_H
+
+/* this structure contains the full arch-specific faultinfo
+ * from the traps.
+ * On i386, ptrace_faultinfo unfortunately doesn't provide
+ * all the info, since trap_no is missing.
+ * All common elements are defined at the same position in
+ * both structures, thus making it easy to copy the
+ * contents without knowledge about the structure elements.
+ */
+struct faultinfo {
+        int error_code; /* in ptrace_faultinfo misleadingly called is_write */
+        unsigned long cr2; /* in ptrace_faultinfo called addr */
+        int trap_no; /* missing in ptrace_faultinfo */
+};
+
+#define FAULT_WRITE(fi) ((fi).error_code & 2)
+#define FAULT_ADDRESS(fi) ((fi).cr2)
+
+#define PTRACE_FULL_FAULTINFO 0
+
+#endif
Index: linux-2.6.11-mm/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-i386/ptrace.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-i386/ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -31,6 +31,7 @@
 #ifdef UML_CONFIG_MODE_SKAS
 
 #include "skas_ptregs.h"
+#include "sysdep/faultinfo.h"
 
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
@@ -53,12 +54,6 @@
 
 #define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
 
-#define REGS_SEGV_IS_FIXABLE(r) SEGV_IS_FIXABLE((r)->trap_type)
-
-#define REGS_FAULT_ADDR(r) ((r)->fault_addr)
-
-#define REGS_FAULT_WRITE(r) FAULT_WRITE((r)->fault_type)
-
 #endif
 #ifndef PTRACE_SYSEMU_SINGLESTEP
 #define PTRACE_SYSEMU_SINGLESTEP 32
@@ -71,6 +66,7 @@
 	struct tt_regs {
 		long syscall;
 		void *sc;
+                struct faultinfo faultinfo;
 	} tt;
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
@@ -78,9 +74,7 @@
 		unsigned long regs[HOST_FRAME_SIZE];
 		unsigned long fp[HOST_FP_SIZE];
 		unsigned long xfp[HOST_XFP_SIZE];
-		unsigned long fault_addr;
-		unsigned long fault_type;
-		unsigned long trap_type;
+                struct faultinfo faultinfo;
 		long syscall;
 		int is_user;
 	} skas;
@@ -217,15 +211,8 @@
 #define UPT_SYSCALL_NR(r) UPT_ORIG_EAX(r)
 #define UPT_SYSCALL_RET(r) UPT_EAX(r)
 
-#define UPT_SEGV_IS_FIXABLE(r) \
-	CHOOSE_MODE(SC_SEGV_IS_FIXABLE(UPT_SC(r)), \
-                    REGS_SEGV_IS_FIXABLE(&r->skas))
-
-#define UPT_FAULT_ADDR(r) \
-	__CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
-
-#define UPT_FAULT_WRITE(r) \
-	CHOOSE_MODE(SC_FAULT_WRITE(UPT_SC(r)), REGS_FAULT_WRITE(&r->skas))
+#define UPT_FAULTINFO(r) \
+        CHOOSE_MODE((&(r)->tt.faultinfo), (&(r)->skas.faultinfo))
 
 #endif
 
Index: linux-2.6.11-mm/arch/um/include/sysdep-i386/sigcontext.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-i386/sigcontext.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-i386/sigcontext.h	2005-04-30 13:08:02.000000000 -0400
@@ -13,15 +13,12 @@
 #define SC_RESTART_SYSCALL(sc) IP_RESTART_SYSCALL(SC_IP(sc))
 #define SC_SET_SYSCALL_RETURN(sc, result) SC_EAX(sc) = (result)
 
-#define SC_FAULT_ADDR(sc) SC_CR2(sc)
-#define SC_FAULT_TYPE(sc) SC_ERR(sc)
-
-#define FAULT_WRITE(err) (err & 2)
-#define TO_SC_ERR(is_write) ((is_write) ? 2 : 0)
-
-#define SC_FAULT_WRITE(sc) (FAULT_WRITE(SC_ERR(sc)))
-
-#define SC_TRAP_TYPE(sc) SC_TRAPNO(sc)
+#define GET_FAULTINFO_FROM_SC(fi,sc) \
+	{ \
+		(fi).cr2 = SC_CR2(sc); \
+		(fi).error_code = SC_ERR(sc); \
+		(fi).trap_no = SC_TRAPNO(sc); \
+	}
 
 /* ptrace expects that, at the start of a system call, %eax contains
  * -ENOSYS, so this makes it so.
@@ -29,9 +26,7 @@
 #define SC_START_SYSCALL(sc) do SC_EAX(sc) = -ENOSYS; while(0)
 
 /* This is Page Fault */
-#define SEGV_IS_FIXABLE(trap) (trap == 14)
-
-#define SC_SEGV_IS_FIXABLE(sc) (SEGV_IS_FIXABLE(SC_TRAPNO(sc)))
+#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 extern int sc_get_fpregs(unsigned long buf, void *sc_ptr);
Index: linux-2.6.11-mm/arch/um/include/sysdep-i386/skas_ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-i386/skas_ptrace.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-i386/skas_ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_I386_SKAS_PTRACE_H
+#define __SYSDEP_I386_SKAS_PTRACE_H
+
+struct ptrace_faultinfo {
+        int is_write;
+        unsigned long addr;
+};
+
+struct ptrace_ldt {
+        int func;
+        void *ptr;
+        unsigned long bytecount;
+};
+
+#define PTRACE_LDT 54
+
+#endif
Index: linux-2.6.11-mm/arch/um/include/sysdep-ia64/skas_ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-ia64/skas_ptrace.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-ia64/skas_ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_IA64_SKAS_PTRACE_H
+#define __SYSDEP_IA64_SKAS_PTRACE_H
+
+struct ptrace_faultinfo {
+        int is_write;
+        unsigned long addr;
+};
+
+struct ptrace_ldt {
+        int func;
+        void *ptr;
+        unsigned long bytecount;
+};
+
+#define PTRACE_LDT 54
+
+#endif
Index: linux-2.6.11-mm/arch/um/include/sysdep-ppc/skas_ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-ppc/skas_ptrace.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-ppc/skas_ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_PPC_SKAS_PTRACE_H
+#define __SYSDEP_PPC_SKAS_PTRACE_H
+
+struct ptrace_faultinfo {
+        int is_write;
+        unsigned long addr;
+};
+
+struct ptrace_ldt {
+        int func;
+        void *ptr;
+        unsigned long bytecount;
+};
+
+#define PTRACE_LDT 54
+
+#endif
Index: linux-2.6.11-mm/arch/um/include/sysdep-x86_64/faultinfo.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-x86_64/faultinfo.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-x86_64/faultinfo.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ * Licensed under the GPL
+ */
+
+#ifndef __FAULTINFO_X86_64_H
+#define __FAULTINFO_X86_64_H
+
+/* this structure contains the full arch-specific faultinfo
+ * from the traps.
+ * On i386, ptrace_faultinfo unfortunately doesn't provide
+ * all the info, since trap_no is missing.
+ * All common elements are defined at the same position in
+ * both structures, thus making it easy to copy the
+ * contents without knowledge about the structure elements.
+ */
+struct faultinfo {
+        int error_code; /* in ptrace_faultinfo misleadingly called is_write */
+        unsigned long cr2; /* in ptrace_faultinfo called addr */
+        int trap_no; /* missing in ptrace_faultinfo */
+};
+
+#define FAULT_WRITE(fi) ((fi).error_code & 2)
+#define FAULT_ADDRESS(fi) ((fi).cr2)
+
+#define PTRACE_FULL_FAULTINFO 1
+
+#endif
Index: linux-2.6.11-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-x86_64/ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -9,6 +9,7 @@
 
 #include "uml-config.h"
 #include "user_constants.h"
+#include "sysdep/faultinfo.h"
 
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 #define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
@@ -83,6 +84,7 @@
 		long syscall;
 		unsigned long orig_rax;
 		void *sc;
+                struct faultinfo faultinfo;
 	} tt;
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
@@ -90,9 +92,7 @@
 		/* XXX */
 		unsigned long regs[27];
 		unsigned long fp[65];
-		unsigned long fault_addr;
-		unsigned long fault_type;
-		unsigned long trap_type;
+                struct faultinfo faultinfo;
 		long syscall;
 		int is_user;
 	} skas;
@@ -241,14 +241,8 @@
 	CHOOSE_MODE(SC_SEGV_IS_FIXABLE(UPT_SC(r)), \
                     REGS_SEGV_IS_FIXABLE(&r->skas))
 
-#define UPT_FAULT_ADDR(r) \
-	__CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
-
-#define UPT_FAULT_WRITE(r) \
-	CHOOSE_MODE(SC_FAULT_WRITE(UPT_SC(r)), REGS_FAULT_WRITE(&r->skas))
-
-#define UPT_TRAP(r) __CHOOSE_MODE(SC_TRAP_TYPE(UPT_SC(r)), REGS_TRAP(&r->skas))
-#define UPT_ERR(r) __CHOOSE_MODE(SC_FAULT_TYPE(UPT_SC(r)), REGS_ERR(&r->skas))
+#define UPT_FAULTINFO(r) \
+        CHOOSE_MODE((&(r)->tt.faultinfo), (&(r)->skas.faultinfo))
 
 #endif
 
Index: linux-2.6.11-mm/arch/um/include/sysdep-x86_64/sigcontext.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-x86_64/sigcontext.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-x86_64/sigcontext.h	2005-04-30 13:08:02.000000000 -0400
@@ -17,11 +17,12 @@
 #define SC_FAULT_ADDR(sc) SC_CR2(sc)
 #define SC_FAULT_TYPE(sc) SC_ERR(sc)
 
-#define FAULT_WRITE(err) ((err) & 2)
-
-#define SC_FAULT_WRITE(sc) FAULT_WRITE(SC_FAULT_TYPE(sc))
-
-#define SC_TRAP_TYPE(sc) SC_TRAPNO(sc)
+#define GET_FAULTINFO_FROM_SC(fi,sc) \
+	{ \
+		(fi).cr2 = SC_CR2(sc); \
+		(fi).error_code = SC_ERR(sc); \
+		(fi).trap_no = SC_TRAPNO(sc); \
+	}
 
 /* ptrace expects that, at the start of a system call, %eax contains
  * -ENOSYS, so this makes it so.
@@ -29,8 +30,8 @@
 
 #define SC_START_SYSCALL(sc) do SC_RAX(sc) = -ENOSYS; while(0)
 
-#define SEGV_IS_FIXABLE(trap) ((trap) == 14)
-#define SC_SEGV_IS_FIXABLE(sc) SEGV_IS_FIXABLE(SC_TRAP_TYPE(sc))
+/* This is Page Fault */
+#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 
Index: linux-2.6.11-mm/arch/um/include/sysdep-x86_64/skas_ptrace.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-x86_64/skas_ptrace.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-x86_64/skas_ptrace.h	2005-04-30 13:08:02.000000000 -0400
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_64_SKAS_PTRACE_H
+#define __SYSDEP_X86_64_SKAS_PTRACE_H
+
+struct ptrace_faultinfo {
+        int is_write;
+        unsigned long addr;
+};
+
+struct ptrace_ldt {
+        int func;
+        void *ptr;
+        unsigned long bytecount;
+};
+
+#define PTRACE_LDT 54
+
+#endif
Index: linux-2.6.11-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/ptrace.c	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/ptrace.c	2005-04-30 13:08:02.000000000 -0400
@@ -250,13 +250,13 @@
 		break;
 #endif
 	case PTRACE_FAULTINFO: {
-		struct ptrace_faultinfo fault;
-
-		fault = ((struct ptrace_faultinfo) 
-			{ .is_write	= child->thread.err,
-			  .addr		= child->thread.cr2 });
-		ret = copy_to_user((unsigned long __user *) data, &fault,
-				   sizeof(fault));
+                /* Take the info from thread->arch->faultinfo,
+                 * but transfer max. sizeof(struct ptrace_faultinfo).
+                 * On i386, ptrace_faultinfo is smaller!
+                 */
+                ret = copy_to_user((unsigned long __user *) data, 
+                                   &child->thread.arch.faultinfo,
+                                   sizeof(struct ptrace_faultinfo));
 		if(ret)
 			break;
 		break;
@@ -267,6 +267,7 @@
 				   sizeof(child->pending.signal));
 		break;
 
+#ifdef PTRACE_LDT
 	case PTRACE_LDT: {
 		struct ptrace_ldt ldt;
 
@@ -282,6 +283,7 @@
 		ret = -EIO;
 		break;
 	}
+#endif
 #ifdef CONFIG_PROC_MM
 	case PTRACE_SWITCH_MM: {
 		struct mm_struct *old = child->mm;
Index: linux-2.6.11-mm/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/skas/include/skas.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/skas/include/skas.h	2005-04-30 13:08:02.000000000 -0400
@@ -27,9 +27,10 @@
 extern int unmap(int fd, void *addr, unsigned long len);
 extern int protect(int fd, unsigned long addr, unsigned long len, 
 		   int r, int w, int x);
-extern void user_signal(int sig, union uml_pt_regs *regs);
+extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(int from);
 extern void start_userspace(int cpu);
+extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 
 #endif
Index: linux-2.6.11-mm/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/skas/process.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/skas/process.c	2005-04-30 13:08:02.000000000 -0400
@@ -4,6 +4,7 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
@@ -37,17 +38,26 @@
 	return(1);
 }
 
-static void handle_segv(int pid)
+void get_skas_faultinfo(int pid, struct faultinfo * fi)
 {
-	struct ptrace_faultinfo fault;
 	int err;
 
-	err = ptrace(PTRACE_FAULTINFO, pid, 0, &fault);
+        err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
 	if(err)
-		panic("handle_segv - PTRACE_FAULTINFO failed, errno = %d\n",
-		      errno);
+                panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
+                      "errno = %d\n", errno);
+
+        /* Special handling for i386, which has different structs */
+        if (sizeof(struct ptrace_faultinfo) < sizeof(struct faultinfo))
+                memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
+                       sizeof(struct faultinfo) - 
+                       sizeof(struct ptrace_faultinfo));
+}
 
-	segv(fault.addr, 0, FAULT_WRITE(fault.is_write), 1, NULL);
+static void handle_segv(int pid, union uml_pt_regs * regs)
+{
+        get_skas_faultinfo(pid, &regs->skas.faultinfo);
+        segv(regs->skas.faultinfo, 0, 1, NULL);
 }
 
 /*To use the same value of using_sysemu as the caller, ask it that value (in local_using_sysemu)*/
@@ -163,7 +173,7 @@
 		if(WIFSTOPPED(status)){
 		  	switch(WSTOPSIG(status)){
 			case SIGSEGV:
-				handle_segv(pid);
+                                handle_segv(pid, regs);
 				break;
 			case SIGTRAP + 0x80:
 			        handle_trap(pid, regs, local_using_sysemu);
@@ -177,7 +187,7 @@
 			case SIGBUS:
 			case SIGFPE:
 			case SIGWINCH:
-				user_signal(WSTOPSIG(status), regs);
+                                user_signal(WSTOPSIG(status), regs, pid);
 				break;
 			default:
 			        printk("userspace - child stopped with signal "
Index: linux-2.6.11-mm/arch/um/kernel/skas/trap_user.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/skas/trap_user.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/skas/trap_user.c	2005-04-30 13:08:02.000000000 -0400
@@ -5,12 +5,15 @@
 
 #include <signal.h>
 #include <errno.h>
-#include "sysdep/ptrace.h"
 #include "signal_user.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "task.h"
 #include "sigcontext.h"
+#include "skas.h"
+#include "ptrace_user.h"
+#include "sysdep/ptrace.h"
+#include "sysdep/ptrace_user.h"
 
 void sig_handler_common_skas(int sig, void *sc_ptr)
 {
@@ -31,9 +34,11 @@
 	r = &TASK_REGS(get_current())->skas;
 	save_user = r->is_user;
 	r->is_user = 0;
-	r->fault_addr = SC_FAULT_ADDR(sc);
-	r->fault_type = SC_FAULT_TYPE(sc);
-	r->trap_type = SC_TRAP_TYPE(sc);
+        if ( sig == SIGFPE || sig == SIGSEGV ||
+             sig == SIGBUS || sig == SIGILL ||
+             sig == SIGTRAP ) {
+                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+        }
 
 	change_sig(SIGUSR1, 1);
 	info = &sig_info[sig];
@@ -45,14 +50,17 @@
 	r->is_user = save_user;
 }
 
-void user_signal(int sig, union uml_pt_regs *regs)
+extern int ptrace_faultinfo;
+
+void user_signal(int sig, union uml_pt_regs *regs, int pid)
 {
 	struct signal_info *info;
+        int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) || 
+                    (sig == SIGILL) || (sig == SIGTRAP));
 
 	regs->skas.is_user = 1;
-	regs->skas.fault_addr = 0;
-	regs->skas.fault_type = 0;
-	regs->skas.trap_type = 0;
+	if (segv)
+		get_skas_faultinfo(pid, &regs->skas.faultinfo);
 	info = &sig_info[sig];
 	(*info->handler)(sig, regs);
 
Index: linux-2.6.11-mm/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/trap_kern.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/trap_kern.c	2005-04-30 13:08:02.000000000 -0400
@@ -133,12 +133,19 @@
 	return(0);
 }
 
-unsigned long segv(unsigned long address, unsigned long ip, int is_write, 
-		   int is_user, void *sc)
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user, void *sc)
 {
 	struct siginfo si;
 	void *catcher;
 	int err;
+        int is_write = FAULT_WRITE(fi);
+        unsigned long address = FAULT_ADDRESS(fi);
 
         if(!is_user && (address >= start_vm) && (address < end_vm)){
                 flush_tlb_kernel_vm();
@@ -159,7 +166,7 @@
 	} 
 	else if(current->thread.fault_addr != NULL)
 		panic("fault_addr set but no fault catcher");
-	else if(arch_fixup(ip, sc))
+        else if(!is_user && arch_fixup(ip, sc))
 		return(0);
 
  	if(!is_user) 
@@ -171,6 +178,7 @@
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
 		si.si_addr = (void *)address;
+                current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
 	}
 	else if(err == -ENOMEM){
@@ -180,22 +188,20 @@
 	else {
 		si.si_signo = SIGSEGV;
 		si.si_addr = (void *) address;
-		current->thread.cr2 = address;
-		current->thread.err = is_write;
+                current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGSEGV, &si, current);
 	}
 	return(0);
 }
 
-void bad_segv(unsigned long address, unsigned long ip, int is_write)
+void bad_segv(struct faultinfo fi, unsigned long ip)
 {
 	struct siginfo si;
 
 	si.si_signo = SIGSEGV;
 	si.si_code = SEGV_ACCERR;
-	si.si_addr = (void *) address;
-	current->thread.cr2 = address;
-	current->thread.err = is_write;
+        si.si_addr = (void *) FAULT_ADDRESS(fi);
+        current->thread.arch.faultinfo = fi;
 	force_sig_info(SIGSEGV, &si, current);
 }
 
@@ -204,6 +210,7 @@
 	if(arch_handle_signal(sig, regs)) return;
 	if(!UPT_IS_USER(regs))
 		panic("Kernel mode signal %d", sig);
+        current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
 	force_sig(sig, current);
 }
 
Index: linux-2.6.11-mm/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/trap_user.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/trap_user.c	2005-04-30 13:08:02.000000000 -0400
@@ -54,23 +54,22 @@
 void segv_handler(int sig, union uml_pt_regs *regs)
 {
 	int index, max;
+        struct faultinfo * fi = UPT_FAULTINFO(regs);
 
-	if(UPT_IS_USER(regs) && !UPT_SEGV_IS_FIXABLE(regs)){
-		bad_segv(UPT_FAULT_ADDR(regs), UPT_IP(regs), 
-			 UPT_FAULT_WRITE(regs));
+        if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
+                bad_segv(*fi, UPT_IP(regs));
 		return;
 	}
 	max = sizeof(segfault_record)/sizeof(segfault_record[0]);
 	index = next_trap_index(max);
 
 	nsegfaults++;
-	segfault_record[index].address = UPT_FAULT_ADDR(regs);
+        segfault_record[index].address = FAULT_ADDRESS(*fi);
 	segfault_record[index].pid = os_getpid();
-	segfault_record[index].is_write = UPT_FAULT_WRITE(regs);
+        segfault_record[index].is_write = FAULT_WRITE(*fi);
 	segfault_record[index].sp = UPT_SP(regs);
 	segfault_record[index].is_user = UPT_IS_USER(regs);
-	segv(UPT_FAULT_ADDR(regs), UPT_IP(regs), UPT_FAULT_WRITE(regs),
-	     UPT_IS_USER(regs), regs);
+        segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
 void usr2_handler(int sig, union uml_pt_regs *regs)
Index: linux-2.6.11-mm/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/tt/tracer.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/tt/tracer.c	2005-04-30 13:08:02.000000000 -0400
@@ -89,8 +89,10 @@
 
 static void tracer_segv(int sig, struct sigcontext sc)
 {
+        struct faultinfo fi;
+        GET_FAULTINFO_FROM_SC(fi, &sc);
 	printf("Tracing thread segfault at address 0x%lx, ip 0x%lx\n",
-	       SC_FAULT_ADDR(&sc), SC_IP(&sc));
+               FAULT_ADDRESS(fi), SC_IP(&sc));
 	while(1)
 		pause();
 }
Index: linux-2.6.11-mm/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/tt/trap_user.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/tt/trap_user.c	2005-04-30 13:08:02.000000000 -0400
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <signal.h>
 #include "sysdep/ptrace.h"
+#include "sysdep/sigcontext.h"
 #include "signal_user.h"
 #include "user_util.h"
 #include "kern_util.h"
@@ -28,6 +29,11 @@
 		change_sig(SIGSEGV, 1);
 
 	r = &TASK_REGS(get_current())->tt;
+        if ( sig == SIGFPE || sig == SIGSEGV ||
+             sig == SIGBUS || sig == SIGILL ||
+             sig == SIGTRAP ) {
+                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+        }
 	save_regs = *r;
 	is_user = user_context(SC_SP(sc));
 	r->sc = sc;
Index: linux-2.6.11-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/sys-i386/signal.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/sys-i386/signal.c	2005-04-30 13:08:02.000000000 -0400
@@ -47,9 +47,6 @@
 	REGS_CS(regs->regs.skas.regs) = sc.cs;
 	REGS_EFLAGS(regs->regs.skas.regs) = sc.eflags;
 	REGS_SS(regs->regs.skas.regs) = sc.ss;
-	regs->regs.skas.fault_addr = sc.cr2;
-	regs->regs.skas.fault_type = FAULT_WRITE(sc.err);
-	regs->regs.skas.trap_type = sc.trapno;
 
 	err = restore_fp_registers(userspace_pid[0], fpregs);
 	if(err < 0){
@@ -62,11 +59,11 @@
 }
 
 int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
-			 struct pt_regs *regs, unsigned long fault_addr,
-			 int fault_type)
+                         struct pt_regs *regs)
 {
   	struct sigcontext sc;
 	unsigned long fpregs[HOST_FP_SIZE];
+	struct faultinfo * fi = &current->thread.arch.faultinfo;
 	int err;
 
 	sc.gs = REGS_GS(regs->regs.skas.regs);
@@ -86,9 +83,9 @@
 	sc.eflags = REGS_EFLAGS(regs->regs.skas.regs);
 	sc.esp_at_signal = regs->regs.skas.regs[UESP];
 	sc.ss = regs->regs.skas.regs[SS];
-	sc.cr2 = fault_addr;
-	sc.err = TO_SC_ERR(fault_type);
-	sc.trapno = regs->regs.skas.trap_type;
+        sc.cr2 = fi->cr2;
+        sc.err = fi->error_code;
+        sc.trapno = fi->trap_no;
 
 	err = save_fp_registers(userspace_pid[0], fpregs);
 	if(err < 0){
@@ -167,9 +164,7 @@
 {
 	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
 					      sizeof(*fp)),
-			   copy_sc_to_user_skas(to, fp, from,
-						current->thread.cr2,
-						current->thread.err)));
+                           copy_sc_to_user_skas(to, fp, from)));
 }
 
 static int copy_ucontext_to_user(struct ucontext *uc, struct _fpstate *fp,
Index: linux-2.6.11-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/sys-x86_64/signal.c	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/sys-x86_64/signal.c	2005-04-30 13:08:02.000000000 -0400
@@ -57,7 +57,7 @@
 int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
                         struct pt_regs *regs, unsigned long mask)
 {
-	unsigned long eflags;
+        struct faultinfo * fi = &current->thread.arch.faultinfo;
 	int err = 0;
 
 	err |= __put_user(0, &to->gs);
@@ -84,14 +84,16 @@
 	err |= PUTREG(regs, R14, to, r14);
 	err |= PUTREG(regs, R15, to, r15);
 	err |= PUTREG(regs, CS, to, cs); /* XXX x86_64 doesn't do this */
-	err |= __put_user(current->thread.err, &to->err);
-	err |= __put_user(current->thread.trap_no, &to->trapno);
+
+        err |= __put_user(fi->cr2, &to->cr2);
+        err |= __put_user(fi->error_code, &to->err);
+        err |= __put_user(fi->trap_no, &to->trapno);
+
 	err |= PUTREG(regs, RIP, to, rip);
 	err |= PUTREG(regs, EFLAGS, to, eflags);
 #undef PUTREG
 
 	err |= __put_user(mask, &to->oldmask);
-	err |= __put_user(current->thread.cr2, &to->cr2);
 
 	return(err);
 }
Index: linux-2.6.11-mm/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/processor-generic.h	2005-04-30 12:57:45.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/processor-generic.h	2005-04-30 13:08:02.000000000 -0400
@@ -24,9 +24,6 @@
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;
-	unsigned long cr2;
-	int err;
-	unsigned long trap_no;
 	int singlestep_syscall;
 	void *fault_addr;
 	void *fault_catcher;
@@ -74,8 +71,6 @@
 	.forking		= 0, \
 	.nsyscalls		= 0, \
         .regs		   	= EMPTY_REGS, \
-	.cr2			= 0, \
-	.err			= 0, \
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.temp_stack		= 0, \
Index: linux-2.6.11-mm/include/asm-um/processor-i386.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/processor-i386.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/processor-i386.h	2005-04-30 13:08:02.000000000 -0400
@@ -9,13 +9,18 @@
 extern int host_has_xmm;
 extern int host_has_cmov;
 
+/* include faultinfo structure */
+#include "sysdep/faultinfo.h"
+
 struct arch_thread {
 	unsigned long debugregs[8];
 	int debugregs_seq;
+	struct faultinfo faultinfo;
 };
 
 #define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
-                           .debugregs_seq	= 0 }
+                           .debugregs_seq	= 0, \
+                           .faultinfo		= { 0, 0, 0 } }
 
 #include "asm/arch/user.h"
 
Index: linux-2.6.11-mm/include/asm-um/processor-x86_64.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/processor-x86_64.h	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/processor-x86_64.h	2005-04-30 13:08:02.000000000 -0400
@@ -7,9 +7,13 @@
 #ifndef __UM_PROCESSOR_X86_64_H
 #define __UM_PROCESSOR_X86_64_H
 
-#include "asm/arch/user.h"
+/* include faultinfo structure */
+#include "sysdep/faultinfo.h"
 
 struct arch_thread {
+        unsigned long debugregs[8];
+        int debugregs_seq;
+        struct faultinfo faultinfo;
 };
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
@@ -20,7 +24,11 @@
 
 #define cpu_relax()   rep_nop()
 
-#define INIT_ARCH_THREAD { }
+#define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
+                           .debugregs_seq	= 0, \
+                           .faultinfo		= { 0, 0, 0 } }
+
+#include "asm/arch/user.h"
 
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })

