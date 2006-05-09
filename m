Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWEII61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWEII61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWEII5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:57:50 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54147 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751595AbWEIItK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:10 -0400
Message-Id: <20060509085156.337930000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:21 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 21/35] subarch TLB support
Content-Disposition: inline; filename=i386-tlbflush
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paravirtualize TLB flushes by using the flush interfaces provided by
the hypervisor. These hide the details of cross-CPU shootdowns and
allow significant optimisations (for example, by avoiding shooting
down on virtual CPUs that are descheduled). This is considerably
faster in most cases than performing virtual IPIs in the guest kernel.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/mach-default/mach_tlbflush.h |   59 ++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_tlbflush.h     |   25 +++++++++++
 include/asm-i386/tlbflush.h                   |   55 ------------------------
 3 files changed, 85 insertions(+), 54 deletions(-)

--- linus-2.6.orig/include/asm-i386/tlbflush.h
+++ linus-2.6/include/asm-i386/tlbflush.h
@@ -5,64 +5,11 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
-#define __flush_tlb()							\
-	do {								\
-		unsigned int tmpreg;					\
-									\
-		__asm__ __volatile__(					\
-			"movl %%cr3, %0;              \n"		\
-			"movl %0, %%cr3;  # flush TLB \n"		\
-			: "=r" (tmpreg)					\
-			:: "memory");					\
-	} while (0)
-
-/*
- * Global pages have to be flushed a bit differently. Not a real
- * performance problem because this does not happen often.
- */
-#define __flush_tlb_global()						\
-	do {								\
-		unsigned int tmpreg, cr4, cr4_orig;			\
-									\
-		__asm__ __volatile__(					\
-			"movl %%cr4, %2;  # turn off PGE     \n"	\
-			"movl %2, %1;                        \n"	\
-			"andl %3, %1;                        \n"	\
-			"movl %1, %%cr4;                     \n"	\
-			"movl %%cr3, %0;                     \n"	\
-			"movl %0, %%cr3;  # flush TLB        \n"	\
-			"movl %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
-			: "i" (~X86_CR4_PGE)				\
-			: "memory");					\
-	} while (0)
-
 extern unsigned long pgkern_mask;
 
-# define __flush_tlb_all()						\
-	do {								\
-		if (cpu_has_pge)					\
-			__flush_tlb_global();				\
-		else							\
-			__flush_tlb();					\
-	} while (0)
-
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
 
-#define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
-
-#ifdef CONFIG_X86_INVLPG
-# define __flush_tlb_one(addr) __flush_tlb_single(addr)
-#else
-# define __flush_tlb_one(addr)						\
-	do {								\
-		if (cpu_has_invlpg)					\
-			__flush_tlb_single(addr);			\
-		else							\
-			__flush_tlb();					\
-	} while (0)
-#endif
+#include <mach_tlbflush.h>
 
 /*
  * TLB flushing:
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_tlbflush.h
@@ -0,0 +1,59 @@
+#ifndef __ASM_MACH_TLBFLUSH_H
+#define __ASM_MACH_TLBFLUSH_H
+
+#define __flush_tlb()							\
+	do {								\
+		unsigned int tmpreg;					\
+									\
+		__asm__ __volatile__(					\
+			"movl %%cr3, %0;              \n"		\
+			"movl %0, %%cr3;  # flush TLB \n"		\
+			: "=r" (tmpreg)					\
+			:: "memory");					\
+	} while (0)
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+#define __flush_tlb_global()						\
+	do {								\
+		unsigned int tmpreg, cr4, cr4_orig;			\
+									\
+		__asm__ __volatile__(					\
+			"movl %%cr4, %2;  # turn off PGE     \n"	\
+			"movl %2, %1;                        \n"	\
+			"andl %3, %1;                        \n"	\
+			"movl %1, %%cr4;                     \n"	\
+			"movl %%cr3, %0;                     \n"	\
+			"movl %0, %%cr3;  # flush TLB        \n"	\
+			"movl %2, %%cr4;  # turn PGE back on \n"	\
+			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
+			: "i" (~X86_CR4_PGE)				\
+			: "memory");					\
+	} while (0)
+
+#define __flush_tlb_all()						\
+	do {								\
+		if (cpu_has_pge)					\
+			__flush_tlb_global();				\
+		else							\
+			__flush_tlb();					\
+	} while (0)
+
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#ifdef CONFIG_X86_INVLPG
+# define __flush_tlb_one(addr) __flush_tlb_single(addr)
+#else
+# define __flush_tlb_one(addr)						\
+	do {								\
+		if (cpu_has_invlpg)					\
+			__flush_tlb_single(addr);			\
+		else							\
+			__flush_tlb();					\
+	} while (0)
+#endif
+
+#endif /* __ASM_MACH_TLBFLUSH_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_tlbflush.h
@@ -0,0 +1,25 @@
+#ifndef __ASM_MACH_TLBFLUSH_H
+#define __ASM_MACH_TLBFLUSH_H
+
+static inline void xen_tlb_flush(void)
+{
+        struct mmuext_op op;
+        op.cmd = MMUEXT_TLB_FLUSH_LOCAL;
+        BUG_ON(HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0);
+}
+
+static inline void xen_invlpg(unsigned long ptr)
+{
+        struct mmuext_op op;
+        op.cmd = MMUEXT_INVLPG_LOCAL;
+        op.arg1.linear_addr = ptr & PAGE_MASK;
+        BUG_ON(HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0);
+}
+
+#define __flush_tlb() xen_tlb_flush()
+#define __flush_tlb_global() xen_tlb_flush()
+#define __flush_tlb_all() xen_tlb_flush()
+#define __flush_tlb_single(addr) xen_invlpg(addr)
+#define __flush_tlb_one(addr) __flush_tlb_single(addr)
+
+#endif /* __ASM_MACH_TLBFLUSH_H */

--
