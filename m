Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVHFHLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVHFHLg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVHFHLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:11:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2579 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262020AbVHFHLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:11:34 -0400
Message-ID: <42F4626D.1000401@vmware.com>
Date: Sat, 06 Aug 2005 00:10:37 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH 1/8] Move MSR accessors into the sub-arch layer
Content-Type: multipart/mixed;
 boundary="------------050905070607020008020301"
X-OriginalArrivalTime: 06 Aug 2005 07:10:55.0398 (UTC) FILETIME=[FCCAE460:01C59A55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905070607020008020301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050905070607020008020301
Content-Type: text/plain;
 name="subarch-msr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-msr"

i386 Transparent Paravirtualization Subarch Patch #1

This change encapsulates MSR register accessors and moves them into the
sub-architecture layer.  The goal is a clean, uniform interface that may
be redefined on new sub-architectures of i386.

Diffs against: linux-2.6.13-rc4-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/msr.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/msr.h	2005-08-02 17:08:58.000000000 -0700
+++ linux-2.6.13/include/asm-i386/msr.h	2005-08-02 17:13:43.000000000 -0700
@@ -1,22 +1,14 @@
 #ifndef __ASM_MSR_H
 #define __ASM_MSR_H
 
+#include <mach_msr.h>
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr,val1,val2) \
-	__asm__ __volatile__("rdmsr" \
-			  : "=a" (val1), "=d" (val2) \
-			  : "c" (msr))
-
-#define wrmsr(msr,val1,val2) \
-	__asm__ __volatile__("wrmsr" \
-			  : /* no outputs */ \
-			  : "c" (msr), "a" (val1), "d" (val2))
-
 #define rdmsrl(msr,val) do { \
 	unsigned long l__,h__; \
 	rdmsr (msr, l__, h__);  \
@@ -32,52 +24,6 @@
 	wrmsr (msr, lo, hi);
 }
 
-/* wrmsr with exception handling */
-#define wrmsr_safe(msr,a,b) ({ int ret__;						\
-	asm volatile("2: wrmsr ; xorl %0,%0\n"						\
-		     "1:\n\t"								\
-		     ".section .fixup,\"ax\"\n\t"					\
-		     "3:  movl %4,%0 ; jmp 1b\n\t"					\
-		     ".previous\n\t"							\
- 		     ".section __ex_table,\"a\"\n"					\
-		     "   .align 4\n\t"							\
-		     "   .long 	2b,3b\n\t"						\
-		     ".previous"							\
-		     : "=a" (ret__)							\
-		     : "c" (msr), "0" (a), "d" (b), "i" (-EFAULT));\
-	ret__; })
-
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr,a,b) ({ int ret__;						\
-	asm volatile("2: rdmsr ; xorl %0,%0\n"						\
-		     "1:\n\t"								\
-		     ".section .fixup,\"ax\"\n\t"					\
-		     "3:  movl %4,%0 ; jmp 1b\n\t"					\
-		     ".previous\n\t"							\
- 		     ".section __ex_table,\"a\"\n"					\
-		     "   .align 4\n\t"							\
-		     "   .long 	2b,3b\n\t"						\
-		     ".previous"							\
-		     : "=r" (ret__), "=a" (*(a)), "=d" (*(b))				\
-		     : "c" (msr), "i" (-EFAULT));\
-	ret__; })
-
-#define rdtsc(low,high) \
-     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
-
-#define rdtscl(low) \
-     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
-
-#define rdtscll(val) \
-     __asm__ __volatile__("rdtsc" : "=A" (val))
-
-#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
-
-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=a" (low), "=d" (high) \
-			  : "c" (counter))
-
 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
 #define MSR_IA32_P5_MC_ADDR		0
Index: linux-2.6.13/include/asm-i386/mach-default/mach_msr.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_msr.h	2005-08-02 17:12:02.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_msr.h	2005-08-02 17:14:11.000000000 -0700
@@ -0,0 +1,60 @@
+#ifndef MACH_MSR_H
+#define MACH_MSR_H
+
+#define rdmsr(msr,val1,val2) \
+	__asm__ __volatile__("rdmsr" \
+			  : "=a" (val1), "=d" (val2) \
+			  : "c" (msr))
+
+#define wrmsr(msr,val1,val2) \
+	__asm__ __volatile__("wrmsr" \
+			  : /* no outputs */ \
+			  : "c" (msr), "a" (val1), "d" (val2))
+
+/* wrmsr with exception handling */
+#define wrmsr_safe(msr,a,b) ({ int ret__;						\
+	asm volatile("2: wrmsr ; xorl %0,%0\n"						\
+		     "1:\n\t"								\
+		     ".section .fixup,\"ax\"\n\t"					\
+		     "3:  movl %4,%0 ; jmp 1b\n\t"					\
+		     ".previous\n\t"							\
+ 		     ".section __ex_table,\"a\"\n"					\
+		     "   .align 4\n\t"							\
+		     "   .long 	2b,3b\n\t"						\
+		     ".previous"							\
+		     : "=a" (ret__)							\
+		     : "c" (msr), "0" (a), "d" (b), "i" (-EFAULT));\
+	ret__; })
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({ int ret__;						\
+	asm volatile("2: rdmsr ; xorl %0,%0\n"						\
+		     "1:\n\t"								\
+		     ".section .fixup,\"ax\"\n\t"					\
+		     "3:  movl %4,%0 ; jmp 1b\n\t"					\
+		     ".previous\n\t"							\
+ 		     ".section __ex_table,\"a\"\n"					\
+		     "   .align 4\n\t"							\
+		     "   .long 	2b,3b\n\t"						\
+		     ".previous"							\
+		     : "=r" (ret__), "=a" (*(a)), "=d" (*(b))				\
+		     : "c" (msr), "i" (-EFAULT));\
+	ret__; })
+
+#define rdtsc(low,high) \
+     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
+
+#define rdtscl(low) \
+     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
+
+#define rdtscll(val) \
+     __asm__ __volatile__("rdtsc" : "=A" (val))
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) \
+     __asm__ __volatile__("rdpmc" \
+			  : "=a" (low), "=d" (high) \
+			  : "c" (counter))
+
+#endif

--------------050905070607020008020301--
