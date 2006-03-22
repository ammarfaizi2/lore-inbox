Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWCVGmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWCVGmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWCVGii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:38 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13185 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750905AbWCVGiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:17 -0500
Message-Id: <20060322063754.391952000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 19/35] subarch support for control register accesses
Content-Disposition: inline; filename=18-i386-processor
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that accesses control register, and
add a separate subarch implementation for Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/mach-default/mach_system.h |   58 ++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_system.h     |   53 +++++++++++++++++++++++++
 include/asm-i386/system.h                   |   58 ----------------------------
 3 files changed, 111 insertions(+), 58 deletions(-)

--- xen-subarch-2.6.orig/include/asm-i386/mach-default/mach_system.h
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_system.h
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
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/mach_system.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_system.h
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
--- xen-subarch-2.6.orig/include/asm-i386/system.h
+++ xen-subarch-2.6/include/asm-i386/system.h
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
