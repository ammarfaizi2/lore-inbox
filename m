Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVHDAr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVHDAr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVHDApk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:45:40 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:26131 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261669AbVHDApN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:45:13 -0400
Date: Wed, 3 Aug 2005 17:43:44 -0700
From: zach@vmware.com
Message-Id: <200508040043.j740hi0R004184@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 3/5 explicit-iopl
X-OriginalArrivalTime: 04 Aug 2005 00:43:42.0062 (UTC) FILETIME=[8FD1A8E0:01C5988D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pushf/popf in switch_to are ONLY used to switch IOPL.  Making this
explicit in C code is more clear.  This pushf/popf pair was added as a
bugfix for leaking IOPL to unprivileged processes when using sysenter/sysexit
based system calls (sysexit does not restore flags).

When requesting an IOPL change in sys_iopl(), it is just as easy to
change the current flags and the flags in the stack image (in case an IRET
is required), but there is no reason to force an IRET if we came in from the
SYSENTER path.

This change is the minimal solution for supporting a paravirtualized Linux
kernel that allows user processes to run with I/O privilege.  Other solutions
require radical rewrites of part of the low level fault / system call handling
code, or do not fully support sysenter based system calls.

Unfortunately, this added one field to the thread_struct.  But as a bonus, on
P4, the fastest time measured for switch_to() went from 312 to 260 cycles, a
win of about 17% in the fast case through this performance critical path.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/ioport.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ioport.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ioport.c	2005-08-02 17:11:01.000000000 -0700
@@ -132,6 +132,7 @@
 	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
 	unsigned int level = regs->ebx;
 	unsigned int old = (regs->eflags >> 12) & 3;
+	struct thread_struct * t = &current->thread;
 
 	if (level > 3)
 		return -EINVAL;
@@ -140,8 +141,8 @@
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	regs->eflags = (regs->eflags &~ 0x3000UL) | (level << 12);
-	/* Make sure we return the long way (not sysenter) */
-	set_thread_flag(TIF_IRET);
+	t->iopl = level << 12;
+	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) | t->iopl;
+	set_iopl_mask(t->iopl);
 	return 0;
 }
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-02 17:08:58.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-02 17:11:01.000000000 -0700
@@ -716,6 +716,13 @@
 		loadsegment(gs, next->gs);
 
 	/*
+	 * Restore IOPL if needed.
+	 */
+	if (unlikely(prev->iopl != next->iopl)) {
+		set_iopl_mask(next->iopl);
+	}
+
+	/*
 	 * Now maybe reload the debug registers
 	 */
 	if (unlikely(next->debugreg[7])) {
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-08-02 17:06:23.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-08-02 17:11:27.000000000 -0700
@@ -457,6 +457,7 @@
 	unsigned long	*io_bitmap_ptr;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
+ 	unsigned long	iopl;
 /* performance counters */
 	struct vperfctr *perfctr;
 };
@@ -514,6 +515,21 @@
 			: /* no output */			\
 			:"r" (value))
 
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static inline void set_iopl_mask(unsigned mask)
+{
+	unsigned int reg;
+	__asm__ __volatile__ ("pushfl;"
+			      "popl %0;"
+			      "andl %1, %0;"
+			      "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=&r" (reg)
+				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
 
 /* Forward declaration, a strange C thing */
 struct task_struct;
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-08-02 17:06:23.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-08-02 17:11:49.000000000 -0700
@@ -15,8 +15,7 @@
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
  	perfctr_suspend_thread(&(prev)->thread);			\
-	asm volatile("pushfl\n\t"					\
-		     "pushl %%ebp\n\t"					\
+	asm volatile("pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
 		     "movl $1f,%1\n\t"		/* save EIP */		\
@@ -24,7 +23,6 @@
 		     "jmp __switch_to\n"				\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"					\
-		     "popfl"						\
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
