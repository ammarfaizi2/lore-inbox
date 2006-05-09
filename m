Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWEIIzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWEIIzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEIIyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:54:16 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5760 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751599AbWEIItV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:21 -0400
Message-Id: <20060509085155.666002000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 19/35] subarch support for control register accesses
Content-Disposition: inline; filename=i386-processor
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that accesses control register, and
add a separate subarch implementation for Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
TODO:
- better sharing to avoid unneeded (i.e. read_cr4_safe, stts)

 include/asm-i386/mach-default/mach_system.h |   58 ++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_system.h     |   53 +++++++++++++++++++++++++
 include/asm-i386/system.h                   |   58 ----------------------------
 3 files changed, 111 insertions(+), 58 deletions(-)

--- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
+++ linus-2.6/include/asm-i386/mach-default/mach_system.h
@@ -3,6 +3,64 @@
 
 #define clearsegment(seg)
 
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
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
+#define stts() write_cr0(8 | read_cr0())
+
 /* interrupt control.. */
 #define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
 #define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
--- linus-2.6.orig/include/asm-i386/mach-xen/mach_system.h
+++ linus-2.6/include/asm-i386/mach-xen/mach_system.h
@@ -13,6 +13,59 @@
 #define __vcpu_id 0
 #endif
 
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
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
+#define read_cr2() \
+	(HYPERVISOR_shared_info->vcpu_info[smp_processor_id()].arch.cr2)
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
+#define stts() write_cr0(8 | read_cr0())
+
 /* interrupt control.. */
 
 /*
--- linus-2.6.orig/include/asm-i386/system.h
+++ linus-2.6/include/asm-i386/system.h
@@ -83,64 +83,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
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
 
 #define wbinvd() \

--
