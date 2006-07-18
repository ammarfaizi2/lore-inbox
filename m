Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWGRJ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWGRJ3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGRJUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:20:53 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38786 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932115AbWGRJUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:43 -0400
Message-Id: <20060718091953.793160000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:21 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 21/33] subarch support for control register accesses
Content-Disposition: inline; filename=i386-processor
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that accesses control register, and
add a separate subarch implementation for Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/asm-i386/mach-default/mach_system.h |   57 +++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_system.h     |   54 +++++++++++++++++++++++++
 include/asm-i386/system.h                   |   57 ---------------------------
 3 files changed, 111 insertions(+), 57 deletions(-)


diff -r 6b500a8da576 include/asm-i386/mach-default/mach_system.h
--- a/include/asm-i386/mach-default/mach_system.h	Thu Jul 13 14:42:43 2006 -0700
+++ b/include/asm-i386/mach-default/mach_system.h	Thu Jul 13 15:01:15 2006 -0700
@@ -3,4 +3,61 @@
 
 #define clearsegment(seg)
 
+#define read_cr0() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr0,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr0(x) \
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x))
+
+#define read_cr2() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr2,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr2(x) \
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (x))
+
+#define read_cr3() ({ \
+	unsigned int __dummy; \
+	__asm__ ( \
+		"movl %%cr3,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr3(x) \
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (x))
+
+#define read_cr4() ({ \
+	unsigned int __dummy; \
+	__asm__( \
+		"movl %%cr4,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
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
+#define write_cr4(x) \
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
+
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
+#define stts() write_cr0(8 | read_cr0())
+
 #endif /* __ASM_MACH_SYSTEM_H */
diff -r 6b500a8da576 include/asm-i386/mach-xen/mach_system.h
--- a/include/asm-i386/mach-xen/mach_system.h	Thu Jul 13 14:42:43 2006 -0700
+++ b/include/asm-i386/mach-xen/mach_system.h	Thu Jul 13 14:42:43 2006 -0700
@@ -5,4 +5,58 @@
 
 #define clearsegment(seg) loadsegment(seg, 0)
 
+
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
 #endif /* __ASM_MACH_SYSTEM_H */
diff -r 6b500a8da576 include/asm-i386/system.h
--- a/include/asm-i386/system.h	Thu Jul 13 14:42:43 2006 -0700
+++ b/include/asm-i386/system.h	Thu Jul 13 15:00:54 2006 -0700
@@ -81,63 +81,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
  */
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
-
-#define read_cr0() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr0,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr0(x) \
-	__asm__ __volatile__("movl %0,%%cr0": :"r" (x))
-
-#define read_cr2() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr2,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr2(x) \
-	__asm__ __volatile__("movl %0,%%cr2": :"r" (x))
-
-#define read_cr3() ({ \
-	unsigned int __dummy; \
-	__asm__ ( \
-		"movl %%cr3,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr3(x) \
-	__asm__ __volatile__("movl %0,%%cr3": :"r" (x))
-
-#define read_cr4() ({ \
-	unsigned int __dummy; \
-	__asm__( \
-		"movl %%cr4,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
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
-#define write_cr4(x) \
-	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
-
-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
-#define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
 

--
