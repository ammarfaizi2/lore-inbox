Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWCMSNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWCMSNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:13:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:1285 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932294AbWCMSNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:13:04 -0500
Date: Mon, 13 Mar 2006 10:13:03 -0800
Message-Id: <200603131813.k2DID3Gm005754@zach-dev.vmware.com>
Subject: [RFC, PATCH 18/24] i386 Vmi tlbflush header
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
X-OriginalArrivalTime: 13 Mar 2006 18:13:03.0459 (UTC) FILETIME=[C5072B30:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, more simple code movement.  Move page invalidations and local
and global flushes to the sub-arch layer.  Note global here does not
mean SMP, but the global bit of the page table entry.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/tlbflush.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/tlbflush.h	2006-03-10 12:55:06.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/tlbflush.h	2006-03-10 13:03:38.000000000 -0800
@@ -4,38 +4,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <asm/processor.h>
-
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
+#include <mach_tlbflush.h>
 
 extern unsigned long pgkern_mask;
 
@@ -49,9 +18,6 @@ extern unsigned long pgkern_mask;
 
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
 
-#define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
-
 #ifdef CONFIG_X86_INVLPG
 # define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_tlbflush.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_tlbflush.h	2006-03-10 13:03:38.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_tlbflush.h	2006-03-10 13:03:38.000000000 -0800
@@ -0,0 +1,62 @@
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
+#ifndef _MACH_TLBFLUSH_H
+#define _MACH_TLBFLUSH_H
+
+#include <vmi.h>
+
+static inline void __flush_tlb(void)
+{
+	vmi_wrap_call(
+		FlushTLB, "mov %%cr3, %%eax; mov %%eax, %%cr3",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(VMI_FLUSH_TLB),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "eax", "memory"));
+}
+
+static inline void __flush_tlb_global(void)
+{
+	vmi_wrap_call(
+		FlushTLB, "mov %%cr4, %%eax;	\n"
+			  "andb $0x7f, %%al;	\n"
+			  "mov %%eax, %%cr4;	\n"
+			  "orb $0x80, %%al;	\n"
+			  "mov %%eax, %%cr4",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(VMI_FLUSH_TLB | VMI_FLUSH_GLOBAL),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "eax", "memory"));
+}
+
+static inline void __flush_tlb_single(u32 va)
+{
+	vmi_wrap_call(
+		InvalPage, "invlpg (%0)",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(va),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+#endif /* _MACH_TLBFLUSH_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_tlbflush.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_tlbflush.h	2006-03-10 13:03:38.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_tlbflush.h	2006-03-10 15:59:30.000000000 -0800
@@ -0,0 +1,37 @@
+#ifndef _MACH_TLBFLUSH_H
+#define _MACH_TLBFLUSH_H
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
+		unsigned int tmpreg;					\
+									\
+		__asm__ __volatile__(					\
+			"movl %1, %%cr4;  # turn off PGE     \n"	\
+			"movl %%cr3, %0;                     \n"	\
+			"movl %0, %%cr3;  # flush TLB        \n"	\
+			"movl %2, %%cr4;  # turn PGE back on \n"	\
+			: "=&r" (tmpreg)				\
+			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
+			  "r" (mmu_cr4_features)			\
+			: "memory");					\
+	} while (0)
+
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#endif /* _MACH_TLBFLUSH_H */
