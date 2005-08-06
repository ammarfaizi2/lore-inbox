Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVHFHOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVHFHOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVHFHOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:14:08 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5395 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262058AbVHFHOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:14:06 -0400
Message-ID: <42F46307.606@vmware.com>
Date: Sat, 06 Aug 2005 00:13:11 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH 2/8] Move privileged processor operations to the subarch layer
Content-Type: multipart/mixed;
 boundary="------------010800070104020100040001"
X-OriginalArrivalTime: 06 Aug 2005 07:13:27.0718 (UTC) FILETIME=[57951460:01C59A56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800070104020100040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010800070104020100040001
Content-Type: text/plain;
 name="subarch-processor"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-processor"

i386 Transparent Paravirtualization Subarch Patch #2

This change encapsulates CPUID and debug register accessors and moves
them into the sub-architecture layer. 

Diffs against: linux-2.6.13-rc4-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-08-04 13:42:38.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-08-04 14:16:59.000000000 -0700
@@ -132,77 +132,6 @@
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
-/*
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
 #define load_cr3(pgdir) write_cr3(__pa(pgdir))
 
 /*
@@ -221,32 +150,6 @@
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
 
 /*
- * Save the cr4 feature set we're using (ie
- * Pentium 4MB enable and PPro Global page
- * enable), so that any CPU's that boot up
- * after us can get the correct flags.
- */
-extern unsigned long mmu_cr4_features;
-
-static inline void set_in_cr4 (unsigned long mask)
-{
-	unsigned cr4;
-	mmu_cr4_features |= mask;
-	cr4 = read_cr4();
-	cr4 |= mask;
-	write_cr4(cr4);
-}
-
-static inline void clear_in_cr4 (unsigned long mask)
-{
-	unsigned cr4;
-	mmu_cr4_features &= ~mask;
-	cr4 = read_cr4();
-	cr4 &= ~mask;
-	write_cr4(cr4);
-}
-
-/*
  *      NSC/Cyrix CPU configuration register indexes
  */
 
@@ -483,16 +386,6 @@
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
 
-static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
-{
-	tss->esp0 = thread->esp0;
-	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
-	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
-		tss->ss1 = thread->sysenter_cs;
-		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
-	}
-}
-
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
 	set_fs(USER_DS);					\
@@ -504,33 +397,6 @@
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
@@ -606,6 +472,34 @@
 /* '6' because it used to be for P6 only (but now covers Pentium 4 as well) */
 #define MICROCODE_IOCFREE	_IO('6',0)
 
+#include <mach_processor.h>
+
+/*
+ * Save the cr4 feature set we're using (ie
+ * Pentium 4MB enable and PPro Global page
+ * enable), so that any CPU's that boot up
+ * after us can get the correct flags.
+ */
+extern unsigned long mmu_cr4_features;
+
+static inline void set_in_cr4 (unsigned long mask)
+{
+	unsigned cr4;
+	mmu_cr4_features |= mask;
+	cr4 = read_cr4();
+	cr4 |= mask;
+	write_cr4(cr4);
+}
+
+static inline void clear_in_cr4 (unsigned long mask)
+{
+	unsigned cr4;
+	mmu_cr4_features &= ~mask;
+	cr4 = read_cr4();
+	cr4 &= ~mask;
+	write_cr4(cr4);
+}
+
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static inline void rep_nop(void)
 {
Index: linux-2.6.13/include/asm-i386/mach-default/mach_processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_processor.h	2005-08-04 14:02:01.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_processor.h	2005-08-04 14:08:15.000000000 -0700
@@ -0,0 +1,121 @@
+/*
+ * include/asm-i386/mach-default/mach_processor.h
+ *
+ * Copyright (C) 1994 Linus Torvalds
+ *
+ * Moved from include/asm-i386/processor.h 08/05
+ */
+
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
+
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
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, register)				\
+		__asm__("movl %%db" #register ", %0"		\
+			:"=r" (var))
+#define set_debugreg(value, register)			\
+		__asm__("movl %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
+static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
+{
+	tss->esp0 = thread->esp0;
+	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
+	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
+		tss->ss1 = thread->sysenter_cs;
+		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	}
+}
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
+			      "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=&r" (reg)
+				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
+
+#endif

--------------010800070104020100040001--
