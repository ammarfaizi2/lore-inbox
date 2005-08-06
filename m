Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVHFHZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVHFHZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHFHXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:23:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2308 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262408AbVHFHWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:22:38 -0400
Message-ID: <42F46506.4030304@vmware.com>
Date: Sat, 06 Aug 2005 00:21:42 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 7/8 Create accessors that allow the i386 kernel to run at
 CPLs 0-2
Content-Type: multipart/mixed;
 boundary="------------020003000907070501050409"
X-OriginalArrivalTime: 06 Aug 2005 07:22:00.0921 (UTC) FILETIME=[8979A490:01C59A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020003000907070501050409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020003000907070501050409
Content-Type: text/plain;
 name="subarch-segment"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-segment"

i386 Transparent paravirtualization subarch patch #7.

These changes allow a sub-architecture to change the notion of privilege
by running the kernel at CPL 0, 1, or 2.  The make_kernel_segment() macro
can be redefined by a subarchitecture to change the RPL on kernel segments
to the appropriate value, and the tests user_mode() and user_mode_vm()
may be similarly overridden.

Changes to the assembly code are required to fully support this, and
provided in a separate patch.

Diffs against: 2.6.13-rc4-mm1

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-03 23:37:25.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-04 10:04:42.000000000 -0700
@@ -356,7 +356,7 @@
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = make_kernel_segment(__KERNEL_CS);
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
Index: linux-2.6.13/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/traps.c	2005-08-03 23:36:46.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/traps.c	2005-08-04 10:04:42.000000000 -0700
@@ -1025,10 +1025,10 @@
 	memcpy((void *)(stack_bot + iret_frame16_off), &regs->eip, 20);
 	/* fill in the switch pointers */
 	switch16_ptr[0] = (regs->esp & 0xffff0000) | iret_frame16_off;
-	switch16_ptr[1] = __ESPFIX_SS;
+	switch16_ptr[1] = make_kernel_segment(__ESPFIX_SS);
 	switch32_ptr[0] = (unsigned long)stk + sizeof(struct pt_regs) +
 		8 - CPU_16BIT_STACK_SIZE;
-	switch32_ptr[1] = __KERNEL_DS;
+	switch32_ptr[1] = make_kernel_segment(__KERNEL_DS);
 }
 
 fastcall unsigned char * fixup_x86_bogus_stack(unsigned short sp)
Index: linux-2.6.13/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/ptrace.h	2005-08-03 23:36:46.000000000 -0700
+++ linux-2.6.13/include/asm-i386/ptrace.h	2005-08-04 10:04:42.000000000 -0700
@@ -57,25 +57,11 @@
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
+#include <mach_segment.h>
 
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
 
-/*
- * user_mode_vm(regs) determines whether a register set came from user mode.
- * This is true if V8086 mode was enabled OR if the register set was from
- * protected mode with RPL-3 CS value.  This tricky test checks that with
- * one comparison.  Many places in the kernel can bypass this full check
- * if they have already ruled out V8086 mode, so user_mode(regs) can be used.
- */
-static inline int user_mode(struct pt_regs *regs)
-{
-	return (regs->xcs & 3) != 0;
-}
-static inline int user_mode_vm(struct pt_regs *regs)
-{
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
-}
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
Index: linux-2.6.13/include/asm-i386/mach-default/mach_segment.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_segment.h	2005-08-04 10:04:42.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_segment.h	2005-08-04 10:05:17.000000000 -0700
@@ -0,0 +1,28 @@
+/*
+ * include/asm-i386/mach-default/mach_segment.h
+ *
+ * user_mode macros moved from include/asm-i386/ptrace.h 08/05
+ */
+
+#ifndef __MACH_SEGMENT_H
+#define __MACH_SEGMENT_H
+
+/*
+ * user_mode_vm(regs) determines whether a register set came from user mode.
+ * This is true if V8086 mode was enabled OR if the register set was from
+ * protected mode with RPL-3 CS value.  This tricky test checks that with
+ * one comparison.  Many places in the kernel can bypass this full check
+ * if they have already ruled out V8086 mode, so user_mode(regs) can be used.
+ */
+static inline int user_mode(struct pt_regs *regs)
+{
+	return (regs->xcs & 3) != 0;
+}
+static inline int user_mode_vm(struct pt_regs *regs)
+{
+	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+}
+
+#define make_kernel_segment(seg)	(seg)
+
+#endif

--------------020003000907070501050409--
