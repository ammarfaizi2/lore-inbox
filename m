Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVIUJVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVIUJVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVIUJVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:21:35 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:23467 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750785AbVIUJVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:21:34 -0400
Date: Wed, 21 Sep 2005 11:21:32 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch] eliminate CLONE_* duplications
Message-ID: <20050921092132.GA4710@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


several archs require some CLONE_* flags (usually
CLONE_VM and CLONE_UNTRACED) but can not include
<linux/sched.h> because of C specific code ...

some archs (alpha,cris,ia64,ppc/64,v850) map those
values via asm-offsets.c, others (cris-*,hppa/64)
redefine the values in the asm code ...

this patch moves the relevant defines into a
separate <linux/clone.h>, which is included by
<linux/sched.h>, removes all asm-offsets.c entries
and adds the <linux/clone.h> as include where the
CLONE_* values are used

alternatively I could imagine to add some ugly
#ifdefs to make <linux/sched.h> asm safe :)

patch is compile tested on relevant archs.
please consider for inclusion.

TIA,
Herbert



Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
---
diff -NurpP --minimal linux-2.6.14-rc1/arch/alpha/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/alpha/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/alpha/kernel/asm-offsets.c	2004-08-14 12:56:24 +0200
+++ linux-2.6.14-rc1-cl01/arch/alpha/kernel/asm-offsets.c	2005-09-21 07:03:09 +0200
@@ -33,8 +33,6 @@ void foo(void)
 
 	DEFINE(SIZEOF_PT_REGS, sizeof(struct pt_regs));
 	DEFINE(PT_PTRACED, PT_PTRACED);
-	DEFINE(CLONE_VM, CLONE_VM);
-	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(SIGCHLD, SIGCHLD);
 	BLANK();
 
diff -NurpP --minimal linux-2.6.14-rc1/arch/alpha/kernel/entry.S linux-2.6.14-rc1-cl01/arch/alpha/kernel/entry.S
--- linux-2.6.14-rc1/arch/alpha/kernel/entry.S	2005-09-20 00:37:08 +0200
+++ linux-2.6.14-rc1-cl01/arch/alpha/kernel/entry.S	2005-09-21 07:08:27 +0200
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/clone.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/pal.h>
diff -NurpP --minimal linux-2.6.14-rc1/arch/cris/arch-v10/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/cris/arch-v10/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/cris/arch-v10/kernel/asm-offsets.c	2004-08-14 12:55:32 +0200
+++ linux-2.6.14-rc1-cl01/arch/cris/arch-v10/kernel/asm-offsets.c	2005-09-21 08:44:21 +0200
@@ -40,8 +40,5 @@ int main(void)
 #undef ENTRY
 #define ENTRY(entry) DEFINE(TASK_ ## entry, offsetof(struct task_struct, entry))
         ENTRY(pid);
-        BLANK();
-        DEFINE(LCLONE_VM, CLONE_VM);
-        DEFINE(LCLONE_UNTRACED, CLONE_UNTRACED);
         return 0;
 }
diff -NurpP --minimal linux-2.6.14-rc1/arch/cris/arch-v10/kernel/entry.S linux-2.6.14-rc1-cl01/arch/cris/arch-v10/kernel/entry.S
--- linux-2.6.14-rc1/arch/cris/arch-v10/kernel/entry.S	2005-09-20 00:37:10 +0200
+++ linux-2.6.14-rc1-cl01/arch/cris/arch-v10/kernel/entry.S	2005-09-21 07:07:08 +0200
@@ -266,6 +266,7 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/sys.h>
+#include <linux/clone.h>
 #include <asm/unistd.h>
 #include <asm/arch/sv_addr_ag.h>
 #include <asm/errno.h>
diff -NurpP --minimal linux-2.6.14-rc1/arch/cris/arch-v32/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/cris/arch-v32/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/cris/arch-v32/kernel/asm-offsets.c	2005-08-29 22:24:51 +0200
+++ linux-2.6.14-rc1-cl01/arch/cris/arch-v32/kernel/asm-offsets.c	2005-09-21 08:44:35 +0200
@@ -42,8 +42,5 @@ int main(void)
 #undef ENTRY
 #define ENTRY(entry) DEFINE(TASK_ ## entry, offsetof(struct task_struct, entry))
         ENTRY(pid);
-        BLANK();
-        DEFINE(LCLONE_VM, CLONE_VM);
-        DEFINE(LCLONE_UNTRACED, CLONE_UNTRACED);
         return 0;
 }
diff -NurpP --minimal linux-2.6.14-rc1/arch/frv/kernel/kernel_thread.S linux-2.6.14-rc1-cl01/arch/frv/kernel/kernel_thread.S
--- linux-2.6.14-rc1/arch/frv/kernel/kernel_thread.S	2005-03-02 12:38:20 +0100
+++ linux-2.6.14-rc1-cl01/arch/frv/kernel/kernel_thread.S	2005-09-21 07:10:41 +0200
@@ -10,9 +10,9 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/clone.h>
 #include <asm/unistd.h>
 
-#define CLONE_VM	0x00000100	/* set if VM shared between processes */
 #define	KERN_ERR	"<3>"
 
 	.section .rodata
diff -NurpP --minimal linux-2.6.14-rc1/arch/ia64/ia32/ia32_entry.S linux-2.6.14-rc1-cl01/arch/ia64/ia32/ia32_entry.S
--- linux-2.6.14-rc1/arch/ia64/ia32/ia32_entry.S	2005-09-20 00:37:11 +0200
+++ linux-2.6.14-rc1-cl01/arch/ia64/ia32/ia32_entry.S	2005-09-21 07:07:57 +0200
@@ -1,3 +1,4 @@
+#include <linux/clone.h>
 #include <asm/asmmacro.h>
 #include <asm/ia32.h>
 #include <asm/asm-offsets.h>
@@ -179,7 +180,7 @@ END(ia32_trace_syscall)
 
 GLOBAL_ENTRY(sys32_vfork)
 	alloc r16=ar.pfs,2,2,4,0;;
-	mov out0=IA64_CLONE_VFORK|IA64_CLONE_VM|SIGCHLD	// out0 = clone_flags
+	mov out0=CLONE_VFORK|CLONE_VM|SIGCHLD	// out0 = clone_flags
 	br.cond.sptk.few .fork1			// do the work
 END(sys32_vfork)
 
diff -NurpP --minimal linux-2.6.14-rc1/arch/ia64/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/ia64/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/ia64/kernel/asm-offsets.c	2005-09-20 00:37:11 +0200
+++ linux-2.6.14-rc1-cl01/arch/ia64/kernel/asm-offsets.c	2005-09-21 08:32:38 +0200
@@ -188,11 +188,7 @@ void foo(void)
 	DEFINE(IA64_SIGFRAME_HANDLER_OFFSET, offsetof (struct sigframe, handler));
 	DEFINE(IA64_SIGFRAME_SIGCONTEXT_OFFSET, offsetof (struct sigframe, sc));
 	BLANK();
-    /* for assembly files which can't include sched.h: */
-	DEFINE(IA64_CLONE_VFORK, CLONE_VFORK);
-	DEFINE(IA64_CLONE_VM, CLONE_VM);
 
-	BLANK();
 	DEFINE(IA64_CPUINFO_NSEC_PER_CYC_OFFSET,
 	       offsetof (struct cpuinfo_ia64, nsec_per_cyc));
 	DEFINE(IA64_CPUINFO_PTCE_BASE_OFFSET,
diff -NurpP --minimal linux-2.6.14-rc1/arch/parisc/kernel/entry.S linux-2.6.14-rc1-cl01/arch/parisc/kernel/entry.S
--- linux-2.6.14-rc1/arch/parisc/kernel/entry.S	2005-09-20 00:37:13 +0200
+++ linux-2.6.14-rc1-cl01/arch/parisc/kernel/entry.S	2005-09-21 07:09:46 +0200
@@ -23,6 +23,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/clone.h>
 #include <asm/asm-offsets.h>
 
 /* we have the following possibilities to act on an interruption:
@@ -751,9 +752,6 @@ fault_vector_11:
 	 * for copy_thread/ret_ to properly set up the child.
 	 */
 
-#define CLONE_VM 0x100	/* Must agree with <linux/sched.h> */
-#define CLONE_UNTRACED 0x00800000
-
 	.export __kernel_thread, code
 	.import do_fork
 __kernel_thread:
diff -NurpP --minimal linux-2.6.14-rc1/arch/ppc/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/ppc/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/ppc/kernel/asm-offsets.c	2005-06-22 02:37:56 +0200
+++ linux-2.6.14-rc1-cl01/arch/ppc/kernel/asm-offsets.c	2005-09-21 07:04:04 +0200
@@ -119,8 +119,6 @@ main(void)
 	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
-	DEFINE(CLONE_VM, CLONE_VM);
-	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
 
 	/* About the CPU features table */
diff -NurpP --minimal linux-2.6.14-rc1/arch/ppc/kernel/misc.S linux-2.6.14-rc1-cl01/arch/ppc/kernel/misc.S
--- linux-2.6.14-rc1/arch/ppc/kernel/misc.S	2005-09-20 00:37:14 +0200
+++ linux-2.6.14-rc1-cl01/arch/ppc/kernel/misc.S	2005-09-21 07:06:12 +0200
@@ -14,6 +14,7 @@
 
 #include <linux/config.h>
 #include <linux/sys.h>
+#include <linux/clone.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
diff -NurpP --minimal linux-2.6.14-rc1/arch/ppc64/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/ppc64/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/ppc64/kernel/asm-offsets.c	2005-09-20 00:37:15 +0200
+++ linux-2.6.14-rc1-cl01/arch/ppc64/kernel/asm-offsets.c	2005-09-21 07:04:11 +0200
@@ -160,9 +160,6 @@ int main(void)
 	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
 	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 
-	DEFINE(CLONE_VM, CLONE_VM);
-	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
-
 	/* About the CPU features table */
 	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
 	DEFINE(CPU_SPEC_PVR_MASK, offsetof(struct cpu_spec, pvr_mask));
diff -NurpP --minimal linux-2.6.14-rc1/arch/ppc64/kernel/misc.S linux-2.6.14-rc1-cl01/arch/ppc64/kernel/misc.S
--- linux-2.6.14-rc1/arch/ppc64/kernel/misc.S	2005-09-20 00:37:15 +0200
+++ linux-2.6.14-rc1-cl01/arch/ppc64/kernel/misc.S	2005-09-21 07:08:59 +0200
@@ -20,6 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/sys.h>
+#include <linux/clone.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
diff -NurpP --minimal linux-2.6.14-rc1/arch/v850/kernel/asm-offsets.c linux-2.6.14-rc1-cl01/arch/v850/kernel/asm-offsets.c
--- linux-2.6.14-rc1/arch/v850/kernel/asm-offsets.c	2005-09-20 00:37:17 +0200
+++ linux-2.6.14-rc1-cl01/arch/v850/kernel/asm-offsets.c	2005-09-21 07:04:25 +0200
@@ -53,9 +53,5 @@ int main (void)
 	/* error values */
 	DEFINE (ENOSYS, ENOSYS);
 
-	/* clone flag bits */
-	DEFINE (CLONE_VFORK, CLONE_VFORK);
-	DEFINE (CLONE_VM, CLONE_VM);
-
 	return 0;
 }
diff -NurpP --minimal linux-2.6.14-rc1/arch/v850/kernel/entry.S linux-2.6.14-rc1-cl01/arch/v850/kernel/entry.S
--- linux-2.6.14-rc1/arch/v850/kernel/entry.S	2005-09-20 00:37:17 +0200
+++ linux-2.6.14-rc1-cl01/arch/v850/kernel/entry.S	2005-09-21 07:10:08 +0200
@@ -13,6 +13,7 @@
  */
 
 #include <linux/sys.h>
+#include <linux/clone.h>
 
 #include <asm/entry.h>
 #include <asm/current.h>
diff -NurpP --minimal linux-2.6.14-rc1/include/asm-cris/arch-v10/offset.h linux-2.6.14-rc1-cl01/include/asm-cris/arch-v10/offset.h
--- linux-2.6.14-rc1/include/asm-cris/arch-v10/offset.h	2005-08-29 22:25:36 +0200
+++ linux-2.6.14-rc1-cl01/include/asm-cris/arch-v10/offset.h	2005-09-21 07:12:49 +0200
@@ -27,7 +27,4 @@
 
 #define TASK_pid 141 /* offsetof(struct task_struct, pid) */
 
-#define LCLONE_VM 256 /* CLONE_VM */
-#define LCLONE_UNTRACED 8388608 /* CLONE_UNTRACED */
-
 #endif
diff -NurpP --minimal linux-2.6.14-rc1/include/asm-cris/arch-v32/offset.h linux-2.6.14-rc1-cl01/include/asm-cris/arch-v32/offset.h
--- linux-2.6.14-rc1/include/asm-cris/arch-v32/offset.h	2005-08-29 22:25:36 +0200
+++ linux-2.6.14-rc1-cl01/include/asm-cris/arch-v32/offset.h	2005-09-21 07:13:01 +0200
@@ -29,7 +29,4 @@
 
 #define TASK_pid 149 /* offsetof(struct task_struct, pid) */
 
-#define LCLONE_VM 256 /* CLONE_VM */
-#define LCLONE_UNTRACED 8388608 /* CLONE_UNTRACED */
-
 #endif
diff -NurpP --minimal linux-2.6.14-rc1/include/linux/clone.h linux-2.6.14-rc1-cl01/include/linux/clone.h
--- linux-2.6.14-rc1/include/linux/clone.h	1970-01-01 01:00:00 +0100
+++ linux-2.6.14-rc1-cl01/include/linux/clone.h	2005-09-21 04:09:06 +0200
@@ -0,0 +1,32 @@
+#ifndef _LINUX_CLONE_H
+#define _LINUX_CLONE_H
+
+/*
+ * cloning flags:
+ */
+#define CSIGNAL		0x000000ff	/* signal mask to be sent at exit */
+#define CLONE_VM	0x00000100	/* set if VM shared between processes */
+#define CLONE_FS	0x00000200	/* set if fs info shared between processes */
+#define CLONE_FILES	0x00000400	/* set if open files shared between processes */
+#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
+#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
+#define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
+#define CLONE_THREAD	0x00010000	/* Same thread group? */
+#define CLONE_NEWNS	0x00020000	/* New namespace group? */
+#define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
+#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
+#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
+#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
+#define CLONE_DETACHED		0x00400000	/* Unused, ignored */
+#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
+#define CLONE_STOPPED		0x02000000	/* Start in stopped state */
+
+/*
+ * List of flags we want to share for kernel threads,
+ * if only because they are not used by them anyway.
+ */
+#define CLONE_KERNEL	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
+
+#endif
diff -NurpP --minimal linux-2.6.14-rc1/include/linux/sched.h linux-2.6.14-rc1-cl01/include/linux/sched.h
--- linux-2.6.14-rc1/include/linux/sched.h	2005-09-20 00:37:38 +0200
+++ linux-2.6.14-rc1-cl01/include/linux/sched.h	2005-09-21 04:08:27 +0200
@@ -36,38 +36,11 @@
 #include <linux/seccomp.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
+#include <linux/clone.h>
 
 struct exec_domain;
 
 /*
- * cloning flags:
- */
-#define CSIGNAL		0x000000ff	/* signal mask to be sent at exit */
-#define CLONE_VM	0x00000100	/* set if VM shared between processes */
-#define CLONE_FS	0x00000200	/* set if fs info shared between processes */
-#define CLONE_FILES	0x00000400	/* set if open files shared between processes */
-#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
-#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
-#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
-#define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
-#define CLONE_THREAD	0x00010000	/* Same thread group? */
-#define CLONE_NEWNS	0x00020000	/* New namespace group? */
-#define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
-#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
-#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
-#define CLONE_DETACHED		0x00400000	/* Unused, ignored */
-#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
-#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
-#define CLONE_STOPPED		0x02000000	/* Start in stopped state */
-
-/*
- * List of flags we want to share for kernel threads,
- * if only because they are not used by them anyway.
- */
-#define CLONE_KERNEL	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
-
-/*
  * These are the constant used to fake the fixed-point load-average
  * counting. Some notes:
  *  - 11 bit fractions expand to 22 bits by the multiplies: this gives

