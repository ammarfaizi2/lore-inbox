Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWCMSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWCMSJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:09:11 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:56844 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932249AbWCMSJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:09:08 -0500
Date: Mon, 13 Mar 2006 10:09:07 -0800
Message-Id: <200603131809.k2DI97rJ005720@zach-dev.vmware.com>
Subject: [RFC, PATCH 13/24] i386 Vmi system header
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:09:07.0343 (UTC) FILETIME=[384AB9F0:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly straightforward code motion in system.h into the sub-arch
layer.  Affected functionality include control register accessors,
which are virtualizable but with great overhead due to the #GP
cost; wbinvd, and most importantly, halt and interrupt control,
which is non-virtualizable.

Since read_cr4_safe can never fault on a VMI kernel (P5+ processor
is required for VMI), we can omit the fault fixup, which does not
play well with the VMI inline assembler, and just call read_cr4()
directly.

Note that shutdown_halt is unused, but provided in case there is
really a use for it.  See arch/i386/kernel/smp.c for a potential
call site during AP shutdown.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/system.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/system.h	2006-03-10 12:55:08.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/system.h	2006-03-10 13:03:36.000000000 -0800
@@ -9,6 +9,8 @@
 
 #ifdef __KERNEL__
 
+#include <mach_system.h>
+
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern struct task_struct * FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
@@ -83,69 +85,8 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
-#define read_cr0() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr0,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr0(x) \
-	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
-
-#define read_cr2() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr2,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr2(x) \
-	__asm__ __volatile__("movl %0,%%cr2": :"r" (x));
-
-#define read_cr3() ({ \
-	unsigned int __dummy; \
-	__asm__ ( \
-		"movl %%cr3,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr3(x) \
-	__asm__ __volatile__("movl %0,%%cr3": :"r" (x));
-
-#define read_cr4() ({ \
-	unsigned int __dummy; \
-	__asm__( \
-		"movl %%cr4,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-
-#define read_cr4_safe() ({			      \
-	unsigned int __dummy;			      \
-	/* This could fault if %cr4 does not exist */ \
-	__asm__("1: movl %%cr4, %0		\n"   \
-		"2:				\n"   \
-		".section __ex_table,\"a\"	\n"   \
-		".long 1b,2b			\n"   \
-		".previous			\n"   \
-		: "=r" (__dummy): "0" (0));	      \
-	__dummy;				      \
-})
-
-#define write_cr4(x) \
-	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
-#define stts() write_cr0(8 | read_cr0())
-
 #endif	/* __KERNEL__ */
 
-#define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory");
-
 static inline unsigned long get_limit(unsigned long segment)
 {
 	unsigned long __limit;
@@ -518,16 +459,7 @@ struct alt_instr { 
 
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
-/* interrupt control.. */
-#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
-
+#define local_irq_save(x) do { typecheck(unsigned long,x); local_save_flags(x); local_irq_disable(); } while (0)
 #define irqs_disabled()			\
 ({					\
 	unsigned long flags;		\
@@ -535,9 +467,6 @@ struct alt_instr { 
 	!(flags & (1<<9));		\
 })
 
-/* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
-
 /*
  * disable hlt during certain critical i/o operations
  */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_system.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_system.h	2006-03-10 13:03:36.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_system.h	2006-03-10 13:03:36.000000000 -0800
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+
+#ifndef _MACH_SYSTEM_H
+#define _MACH_SYSTEM_H
+
+#include <vmi.h>
+
+static inline void write_cr0(const u32 val)
+{
+	vmi_wrap_call(
+		SetCR0, "mov %0, %%cr0",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(val),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void write_cr2(const u32 val)
+{
+	vmi_wrap_call(
+		SetCR2, "mov %0, %%cr2",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(val),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void write_cr3(const u32 val)
+{
+	vmi_wrap_call(
+		SetCR3, "mov %0, %%cr3",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(val),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void write_cr4(const u32 val)
+{
+	vmi_wrap_call(
+		SetCR4, "mov %0, %%cr4",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(val),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline u32 read_cr0(void)
+{
+	u32 ret;
+	vmi_wrap_call(
+		GetCR0, "mov %%cr0, %%eax",
+		VMI_OREG1(ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+static inline u32 read_cr2(void)
+{
+	u32 ret;
+	vmi_wrap_call(
+		GetCR2, "mov %%cr2, %%eax",
+		VMI_OREG1(ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+static inline u32 read_cr3(void)
+{
+	u32 ret;
+	vmi_wrap_call(
+		GetCR3, "mov %%cr3, %%eax",
+		VMI_OREG1(ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+static inline u32 read_cr4(void)
+{
+	u32 ret;
+	vmi_wrap_call(
+		GetCR4, "mov %%cr4, %%eax",
+		VMI_OREG1(ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+#define read_cr4_safe() read_cr4()
+#define load_cr3(pgdir) write_cr3(__pa(pgdir))
+
+static inline void clts(void)
+{
+	vmi_wrap_call(
+		CLTS, "clts",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+static inline void wbinvd(void)
+{
+	vmi_wrap_call(
+		WBINVD, "wbinvd",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+/* 
+ * For EnableInterrupts, DisableInterrupts, GetInterruptMask, SetInterruptMask,
+ * only flags are clobbered by these calls, since they have assembler call
+ * convention.  We can get better C code by indicating only "cc" clobber.
+ * Both setting and disabling interrupts must use memory clobber as well, to
+ * prevent GCC from reordering memory access around them.
+ */
+static inline void local_irq_disable(void)
+{
+	vmi_wrap_call(
+		DisableInterrupts, "cli",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		XCONC("cc", "memory"));
+}
+
+static inline void local_irq_enable(void)
+{
+	vmi_wrap_call(
+		EnableInterrupts, "sti",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		XCONC("cc", "memory"));
+}
+
+static inline void local_irq_restore(const unsigned long flags)
+{
+	vmi_wrap_call(
+		SetInterruptMask, "pushl %0; popfl",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (flags),
+		XCONC("cc", "memory"));
+}
+
+static inline unsigned long vmi_get_flags(void)
+{
+	unsigned long ret;
+	vmi_wrap_call(
+		GetInterruptMask, "pushfl; popl %%eax",
+		VMI_OREG1 (ret),
+		0, VMI_NO_INPUT,
+		"cc");
+	return ret;
+}
+
+#define local_save_flags(x)     do { typecheck(unsigned long,x); (x) = vmi_get_flags(); } while (0)
+
+static inline void vmi_reboot(int how)
+{
+	vmi_wrap_call(
+		Reboot, "",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(how),
+		"memory"); /* only memory clobber for better code */
+}
+
+static inline void safe_halt(void)
+{
+	vmi_wrap_call(
+		Halt, "sti; hlt",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+/* By default, halt is assumed safe, but we can drop the sti */
+static inline void halt(void)
+{
+	vmi_wrap_call(
+		Halt, "hlt",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+static inline void shutdown_halt(void)
+{
+	vmi_wrap_call(
+		Shutdown, "cli; hlt",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		"memory"); /* only memory clobber for better code */
+}
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_system.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_system.h	2006-03-10 13:03:36.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_system.h	2006-03-10 16:00:38.000000000 -0800
@@ -0,0 +1,80 @@
+#ifndef _MACH_SYSTEM_H
+#define _MACH_SYSTEM_H
+
+#define clts() __asm__ __volatile__ ("clts")
+#define read_cr0() ({ \
+	unsigned int __dummy; \
+	__asm__  __volatile__( \
+		"movl %%cr0,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+
+#define write_cr0(x) \
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
+
+#define read_cr2() ({ \
+        unsigned int __dummy; \
+        __asm__  __volatile__( \
+                "movl %%cr2,%0\n\t" \
+                :"=r" (__dummy)); \
+        __dummy; \
+})
+#define write_cr2(x) \
+	__asm__  __volatile__("movl %0,%%cr2": :"r" (x));
+
+#define read_cr3() ({ \
+        unsigned int __dummy; \
+        __asm__( \
+                "movl %%cr3,%0\n\t" \
+                :"=r" (__dummy)); \
+        __dummy; \
+})
+#define write_cr3(x) \
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (x));
+
+#define read_cr4() ({ \
+	unsigned int __dummy; \
+	__asm__( \
+		"movl %%cr4,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+
+#define read_cr4_safe() ({			      \
+	unsigned int __dummy;			      \
+	/* This could fault if %cr4 does not exist */ \
+	__asm__("1: movl %%cr4, %0		\n"   \
+		"2:				\n"   \
+		".section __ex_table,\"a\"	\n"   \
+		".long 1b,2b			\n"   \
+		".previous			\n"   \
+		: "=r" (__dummy): "0" (0));	      \
+	__dummy;				      \
+})
+
+#define write_cr4(x) \
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
+
+#define wbinvd() \
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+
+/* interrupt control.. */
+#define local_save_flags(x)     do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+
+/* For spinlocks etc */
+#define local_irq_restore(x)    do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+
+#define local_irq_disable()     __asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable()      __asm__ __volatile__("sti": : :"memory")
+
+/* used in the idle loop; sti holds off interrupts for 1 instruction */
+#define safe_halt()             __asm__ __volatile__("sti; hlt": : :"memory")
+
+/* force shutdown of the processor; used when IRQs are disabled */
+#define shutdown_halt()		__asm__ __volatile__("hlt": : :"memory")
+
+/* halt until interrupted */
+#define halt()			__asm__ __volatile__("hlt")
+
+#endif
