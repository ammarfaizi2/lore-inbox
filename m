Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWCMSIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWCMSIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWCMSIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:08:34 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49676 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932271AbWCMSIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:08:32 -0500
Date: Mon, 13 Mar 2006 10:08:20 -0800
Message-Id: <200603131808.k2DI8KYs005714@zach-dev.vmware.com>
Subject: [RFC, PATCH 12/24] i386 Vmi processor header
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
X-OriginalArrivalTime: 13 Mar 2006 18:08:20.0141 (UTC) FILETIME=[1C2845D0:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly straight code motion.  Split non-virtualizable pieces of
processor.h into default and VMI subarches.  CPUID is
non-virtualizable, since it doesn't trap, and very often the
hypervisor will want to hide specific feature bits from the
kernel.  To provide a replacement for call sites that use
CPUID as a serializing instruction, the sync_core() macro is
still available.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/processor.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/processor.h	2006-03-10 12:55:09.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/processor.h	2006-03-10 13:03:35.000000000 -0800
@@ -137,79 +137,6 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
 /*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
-{
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c"(0));
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
-	       	int *edx)
-{
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c" (count));
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax;
-
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (op)
-		: "bx", "cx", "dx");
-	return eax;
-}
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx)
-		: "0" (op)
-		: "cx", "dx" );
-	return ebx;
-}
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ecx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=c" (ecx)
-		: "0" (op)
-		: "bx", "dx" );
-	return ecx;
-}
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, edx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=d" (edx)
-		: "0" (op)
-		: "bx", "cx");
-	return edx;
-}
-
-#define load_cr3(pgdir) write_cr3(__pa(pgdir))
-
-/*
  * Intel CPU features in CR4
  */
 #define X86_CR4_VME		0x0001	/* enable vm86 extensions */
@@ -224,6 +151,8 @@ static inline unsigned int cpuid_edx(uns
 #define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore */
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
 
+#include <mach_processor.h>
+
 /*
  * Save the cr4 feature set we're using (ie
  * Pentium 4MB enable and PPro Global page
@@ -489,6 +418,7 @@ struct thread_struct {
 static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
 {
 	tss->esp0 = thread->esp0;
+	arch_update_kernel_stack(tss, thread->esp0);
 	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
 	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
 		tss->ss1 = thread->sysenter_cs;
@@ -507,33 +437,6 @@ static inline void load_esp0(struct tss_
 	regs->esp = new_esp;					\
 } while (0)
 
-/*
- * These special macros can be used to get or set a debugging register
- */
-#define get_debugreg(var, register)				\
-		__asm__("movl %%db" #register ", %0"		\
-			:"=r" (var))
-#define set_debugreg(value, register)			\
-		__asm__("movl %0,%%db" #register		\
-			: /* no output */			\
-			:"r" (value))
-
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static inline void set_iopl_mask(unsigned mask)
-{
-	unsigned int reg;
-	__asm__ __volatile__ ("pushfl;"
-			      "popl %0;"
-			      "andl %1, %0;"
-			      "orl %2, %0;"
-			      "pushl %0;"
-			      "popfl"
-				: "=&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
-}
-
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
@@ -740,4 +643,8 @@ extern void mcheck_init(struct cpuinfo_x
 #define mcheck_init(c) do {} while(0)
 #endif
 
+#include <mach_processor.h>
+
+#define stts() write_cr0(8 | read_cr0())
+
 #endif /* __ASM_I386_PROCESSOR_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_processor.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_processor.h	2006-03-10 13:03:35.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_processor.h	2006-03-10 13:03:35.000000000 -0800
@@ -0,0 +1,137 @@
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
+#ifndef _MACH_PROCESSOR_H
+#define _MACH_PROCESSOR_H
+
+#include <vmi.h>
+
+static inline void vmi_cpuid(const int op, int *eax, int *ebx, int *ecx, int *edx)
+{
+	vmi_wrap_call(
+		CPUID, "cpuid",
+		XCONC("=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)),
+		1, "a" (op),
+		VMI_CLOBBER(FOUR_RETURNS));
+}
+
+/*
+ * Generic CPUID function
+ */
+static inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
+{
+	vmi_cpuid(op, eax, ebx, ecx, edx);
+}
+
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
+	       	int *edx)
+{
+	asm volatile(""::"c"(count));
+	vmi_cpuid(op, eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	vmi_cpuid(op, &eax, &ebx, &ecx, &edx);
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	vmi_cpuid(op, &eax, &ebx, &ecx, &edx);
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	vmi_cpuid(op, &eax, &ebx, &ecx, &edx);
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	vmi_cpuid(op, &eax, &ebx, &ecx, &edx);
+	return edx;
+}
+
+#define flush_deferred_cpu_state() vmi_flush_deferred_calls(0)
+
+static inline void arch_update_kernel_stack(void *tss, u32 stack)
+{
+	vmi_wrap_call(
+		UpdateKernelStack, "",
+		VMI_NO_OUTPUT,
+		2, XCONC(VMI_IREG1(tss), VMI_IREG2(stack)),
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+static inline void set_debugreg(const u32 val, const int num)
+{
+	vmi_wrap_call(
+		SetDR, "movl %1, %%db%c2",
+		VMI_NO_OUTPUT,
+		2, XCONC(VMI_IREG1(num), VMI_IREG2(val), VMI_IMM (num)),
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+static inline u32 vmi_get_dr(const int num)
+{
+	VMI_UINT32 ret;
+	vmi_wrap_call(
+		GetDR, "movl %%db%c1, %%eax",
+		VMI_OREG1(ret),
+		1, XCONC(VMI_IREG1(num), VMI_IMM (num)),
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+#define get_debugreg(var, register) do { var = vmi_get_dr(register); } while (0)
+
+static inline void set_iopl_mask(u32 mask)
+{
+	vmi_wrap_call(
+		SetIOPLMask,	"pushfl;"
+				"andl $0xffffcfff, (%%esp);"
+				"orl %0, (%%esp);"
+				"popfl",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (mask),
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_processor.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_processor.h	2006-03-10 13:03:35.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_processor.h	2006-03-10 16:00:53.000000000 -0800
@@ -0,0 +1,108 @@
+#ifndef _MACH_PROCESSOR_H
+#define _MACH_PROCESSOR_H
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
+{
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (op), "c"(0));
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
+	       	int *edx)
+{
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (op), "c" (count));
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax;
+
+	__asm__("cpuid"
+		: "=a" (eax)
+		: "0" (op)
+		: "bx", "cx", "dx");
+	return eax;
+}
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=b" (ebx)
+		: "0" (op)
+		: "cx", "dx" );
+	return ebx;
+}
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ecx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=c" (ecx)
+		: "0" (op)
+		: "bx", "dx" );
+	return ecx;
+}
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, edx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=d" (edx)
+		: "0" (op)
+		: "bx", "cx");
+	return edx;
+}
+
+#define load_cr3(pgdir) \
+        asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)))
+
+#define flush_deferred_cpu_state()
+#define arch_update_kernel_stack(t,s)
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, register)				\
+		__asm__("movl %%db" #register ", %0"		\
+			:"=r" (var))
+#define set_debugreg(value, register)				\
+		__asm__("movl %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static inline void set_iopl_mask(unsigned mask)
+{
+	unsigned int reg;
+	__asm__ __volatile__ ("pushfl;"
+			      "popl %0;"
+			      "andl %1, %0;"
+                              "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=&r" (reg)
+				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
+
+#endif
