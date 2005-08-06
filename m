Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVHFHUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVHFHUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVHFHSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:18:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:10515 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262088AbVHFHQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:16:33 -0400
Message-ID: <42F4639A.7090304@vmware.com>
Date: Sat, 06 Aug 2005 00:15:38 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 4/8 Move TLB flush definitions to the sub-architecture level
Content-Type: multipart/mixed;
 boundary="------------030905040409070606080907"
X-OriginalArrivalTime: 06 Aug 2005 07:15:55.0937 (UTC) FILETIME=[AFED8110:01C59A56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905040409070606080907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030905040409070606080907
Content-Type: text/plain;
 name="subarch-tlbflush"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-tlbflush"

i386 Transparent Paravirtualization Patch #4

This change encapsulates TLB flush accessors into the sub-architecture layer.

Diffs against: linux-2.6.13-rc4-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/tlbflush.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/tlbflush.h	2005-08-03 16:24:11.000000000 -0700
+++ linux-2.6.13/include/asm-i386/tlbflush.h	2005-08-03 16:29:58.000000000 -0700
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
 
@@ -49,9 +18,6 @@
 
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
 
-#define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
-
 #ifdef CONFIG_X86_INVLPG
 # define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
Index: linux-2.6.13/include/asm-i386/mach-default/mach_tlbflush.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_tlbflush.h	2005-08-03 16:29:58.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_tlbflush.h	2005-08-03 16:31:31.000000000 -0700
@@ -0,0 +1,47 @@
+/*
+ * include/asm-i386/mach-default/mach_tlbflush.h
+ *
+ * Standard TLB accessors for running on real hardware
+ * Moved from include/asm-i386/tlbflush.h 07/05
+ *
+ */
+ 
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
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#endif /* _MACH_TLBFLUSH_H */

--------------030905040409070606080907--
