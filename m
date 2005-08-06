Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVHFHR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVHFHR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHFHPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:15:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:8467 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262088AbVHFHPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:15:18 -0400
Message-ID: <42F4634B.6040201@vmware.com>
Date: Sat, 06 Aug 2005 00:14:19 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 3/8 Move sensitive system definitions into the sub-arch layer
Content-Type: multipart/mixed;
 boundary="------------020204000106000000050308"
X-OriginalArrivalTime: 06 Aug 2005 07:14:36.0296 (UTC) FILETIME=[80754080:01C59A56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204000106000000050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020204000106000000050308
Content-Type: text/plain;
 name="subarch-system"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-system"

i386 Transparent Paravirtualization Subarch Patch #3

This change encapsulates privileged control register and flags accessors into
the sub-architecture layer.  The goal is a clean, uniform interface that may
be redefined on new sub-architectures of i386.

Diffs against: linux-2.6.13-rc4-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-08-03 16:24:16.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-08-03 16:27:00.000000000 -0700
@@ -100,56 +100,8 @@
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
@@ -459,15 +411,7 @@
 
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
+#include <mach_system.h>
 
 #define irqs_disabled()			\
 ({					\
@@ -476,9 +420,6 @@
 	!(flags & (1<<9));		\
 })
 
-/* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
-
 /*
  * disable hlt during certain critical i/o operations
  */
Index: linux-2.6.13/include/asm-i386/mach-default/mach_system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_system.h	2005-08-03 16:27:00.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_system.h	2005-08-03 16:29:32.000000000 -0700
@@ -0,0 +1,76 @@
+/*
+ * include/asm-i386/mach-default/mach_system.h
+ *
+ * Copyright (C) 2005, VMware, Inc & other authors
+ * Moved from include/asm-i386/system.h 07/05
+ *
+ */
+
+#ifndef _MACH_SYSTEM_H
+#define _MACH_SYSTEM_H
+
+#define read_cr0() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr0,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr0(x) \
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
+
+#define read_cr2() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr2,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr2(x) \
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (x));
+
+#define read_cr3() ({ \
+	unsigned int __dummy; \
+	__asm__ ( \
+		"movl %%cr3,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
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
+#define write_cr4(x) \
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
+
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
+#define stts() write_cr0(8 | read_cr0())
+
+#define wbinvd() \
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+
+/* interrupt control.. */
+#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+
+/* For spinlocks etc */
+#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+/* used in the idle loop; sti holds off interrupts for 1 instruction */
+#define safe_halt()             __asm__ __volatile__("sti; hlt": : :"memory")
+
+/* halt until interrupted */
+#define halt()			__asm__ __volatile__("hlt")
+
+#endif

--------------020204000106000000050308--
