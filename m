Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWIVIKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWIVIKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIVIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:09:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:44179 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750949AbWIVIJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:09:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:message-id;
        b=BYOchTjCDayJJugeVTBlTRZNsDj7jVU4wZ2Ujx14L/Vy8R01d5OhsA+YvwmCL71o97oDkFSSRpq8mAmjGV4UFk+kw8zVVVMxbl1xegHpPjv+xOnrfplxNCd3601AJyA43opa+yBgxFD5FwSUgb+hVIyNu9rTeesztAv3yXHNgOA=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 3/3] delay: add generic udelay(), mdelay() and ssleep()
Date: Fri, 22 Sep 2006 10:00:33 +0200
User-Agent: KMail/1.8.2
References: <200609220955.35826.vda.linux@googlemail.com> <200609220957.43127.vda.linux@googlemail.com> <200609220958.52736.vda.linux@googlemail.com>
In-Reply-To: <200609220958.52736.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hg5EFfvckVXHj1+"
Message-Id: <200609221000.33978.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_hg5EFfvckVXHj1+
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch does the following:
* make it so than asm/delay.h does not define udelay(),
=9A only __udelay(), to be used in generic udelay()
* add generic udelay() which calls __udelay() repeatedly
=9A as needed. Protect against overflow in udelay() argument.
* similarly for mdelay() and ssleep()
* __const_udelay for all arches is removed or renamed to
=9A __const_delay (it did not do microsecond delays anyway)
=9A if still used by arch ndelay() function/macro
* remove EXPORT_SYMBOL(__udelay). It is not used in modules
=9A anymore
* remove MAX_UDELAY_MS

We specifically do not touch ndelay() in these patches.

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
=2D-
vda

--Boundary-00=_hg5EFfvckVXHj1+
Content-Type: text/x-diff;
  charset="koi8-r";
  name="delay8.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay8.3.patch"

diff -urpN linux-2.6.18.new.2/arch/arm/kernel/armksyms.c linux-2.6.18.new.3/arch/arm/kernel/armksyms.c
--- linux-2.6.18.new.2/arch/arm/kernel/armksyms.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/arm/kernel/armksyms.c	2006-09-22 02:30:27.000000000 +0200
@@ -70,10 +70,6 @@ EXPORT_SYMBOL_ALIAS(fp_send_sig,send_sig
 
 EXPORT_SYMBOL(__backtrace);
 
-	/* platform dependent support */
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__const_udelay);
-
 	/* networking */
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff -urpN linux-2.6.18.new.2/arch/arm/lib/delay.S linux-2.6.18.new.3/arch/arm/lib/delay.S
--- linux-2.6.18.new.2/arch/arm/lib/delay.S	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/arm/lib/delay.S	2006-09-22 02:30:27.000000000 +0200
@@ -24,7 +24,7 @@
 ENTRY(__udelay)
 		ldr	r2, .LC1
 		mul	r0, r2, r0
-ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
+						@ 0 <= r0 <= 0x7fffff06
 		ldr	r2, .LC0
 		ldr	r2, [r2]		@ max = 0x01ffffff
 		mov	r0, r0, lsr #14		@ max = 0x0001ffff
diff -urpN linux-2.6.18.new.2/arch/i386/lib/delay.c linux-2.6.18.new.3/arch/i386/lib/delay.c
--- linux-2.6.18.new.2/arch/i386/lib/delay.c	2006-09-21 23:59:50.000000000 +0200
+++ linux-2.6.18.new.3/arch/i386/lib/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -74,7 +74,8 @@ void __delay(unsigned long loops)
 	delay_fn(loops);
 }
 
-inline void __const_udelay(unsigned long xloops)
+/* cannot be static: ndelay macro needs it */
+inline void __const_delay(unsigned long xloops)
 {
 	int d0;
 
@@ -89,15 +90,14 @@ inline void __const_udelay(unsigned long
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
+	__const_delay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
 }
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
+	__const_delay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
 }
 
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
-EXPORT_SYMBOL(__udelay);
+EXPORT_SYMBOL(__const_delay);
 EXPORT_SYMBOL(__ndelay);
diff -urpN linux-2.6.18.new.2/arch/m32r/kernel/m32r_ksyms.c linux-2.6.18.new.3/arch/m32r/kernel/m32r_ksyms.c
--- linux-2.6.18.new.2/arch/m32r/kernel/m32r_ksyms.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/m32r/kernel/m32r_ksyms.c	2006-09-22 02:30:27.000000000 +0200
@@ -30,9 +30,7 @@ EXPORT_SYMBOL(__down_trylock);
 
 /* Networking helper routines. */
 /* Delay loops */
-EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(strncpy_from_user);
 EXPORT_SYMBOL(__strncpy_from_user);
diff -urpN linux-2.6.18.new.2/arch/m32r/lib/delay.c linux-2.6.18.new.3/arch/m32r/lib/delay.c
--- linux-2.6.18.new.2/arch/m32r/lib/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/m32r/lib/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -57,7 +57,7 @@ void __delay(unsigned long loops)
 #endif
 }
 
-void __const_udelay(unsigned long xloops)
+void __const_delay(unsigned long xloops)
 {
 #if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	/*
@@ -116,10 +116,10 @@ void __const_udelay(unsigned long xloops
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
+	__const_delay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
 }
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+	__const_delay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
 }
diff -urpN linux-2.6.18.new.2/arch/m68knommu/lib/delay.c linux-2.6.18.new.3/arch/m68knommu/lib/delay.c
--- linux-2.6.18.new.2/arch/m68knommu/lib/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/m68knommu/lib/delay.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,21 +0,0 @@
-/*
- *	arch/m68knommu/lib/delay.c
- *
- *	(C) Copyright 2004, Greg Ungerer <gerg@snapgear.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <asm/param.h>
-#include <asm/delay.h>
-
-EXPORT_SYMBOL(udelay);
-
-void udelay(unsigned long usecs)
-{
-	_udelay(usecs);
-}
-
diff -urpN linux-2.6.18.new.2/arch/m68knommu/lib/Makefile linux-2.6.18.new.3/arch/m68knommu/lib/Makefile
--- linux-2.6.18.new.2/arch/m68knommu/lib/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/m68knommu/lib/Makefile	2006-09-22 02:30:27.000000000 +0200
@@ -4,4 +4,4 @@
 
 lib-y	:= ashldi3.o ashrdi3.o lshrdi3.o \
 	   muldi3.o mulsi3.o divsi3.o udivsi3.o modsi3.o umodsi3.o \
-	   checksum.o semaphore.o memcpy.o memset.o delay.o
+	   checksum.o semaphore.o memcpy.o memset.o
diff -urpN linux-2.6.18.new.2/arch/powerpc/kernel/time.c linux-2.6.18.new.3/arch/powerpc/kernel/time.c
--- linux-2.6.18.new.2/arch/powerpc/kernel/time.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/powerpc/kernel/time.c	2006-09-22 02:30:27.000000000 +0200
@@ -368,11 +368,11 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-void udelay(unsigned long usecs)
+void __udelay(unsigned long usecs)
 {
 	__delay(tb_ticks_per_usec * usecs);
 }
-EXPORT_SYMBOL(udelay);
+EXPORT_SYMBOL(__udelay);
 
 static __inline__ void timer_check_rtc(void)
 {
diff -urpN linux-2.6.18.new.2/arch/sh/kernel/sh_ksyms.c linux-2.6.18.new.3/arch/sh/kernel/sh_ksyms.c
--- linux-2.6.18.new.2/arch/sh/kernel/sh_ksyms.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/sh/kernel/sh_ksyms.c	2006-09-22 02:30:27.000000000 +0200
@@ -71,9 +71,8 @@ EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
 
-EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__const_delay);
 
 EXPORT_SYMBOL(__div64_32);
 
diff -urpN linux-2.6.18.new.2/arch/sh/lib/delay.c linux-2.6.18.new.3/arch/sh/lib/delay.c
--- linux-2.6.18.new.2/arch/sh/lib/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/sh/lib/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -19,7 +19,8 @@ void __delay(unsigned long loops)
 		: "t");
 }
 
-inline void __const_udelay(unsigned long xloops)
+/* cannot be static: ndelay macro needs it */
+inline void __const_delay(unsigned long xloops)
 {
 	__asm__("dmulu.l	%0, %2\n\t"
 		"sts	mach, %0"
@@ -31,11 +32,10 @@ inline void __const_udelay(unsigned long
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	__const_delay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00000005);
+	__const_delay(nsecs * 0x00000005);
 }
-
diff -urpN linux-2.6.18.new.2/arch/sh64/lib/udelay.c linux-2.6.18.new.3/arch/sh64/lib/udelay.c
--- linux-2.6.18.new.2/arch/sh64/lib/udelay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/sh64/lib/udelay.c	2006-09-22 02:30:27.000000000 +0200
@@ -35,25 +35,24 @@ void __delay(int loops)
 			     :"0"(loops));
 }
 
-void __udelay(unsigned long long usecs, unsigned long lpj)
+static inline void __arch_udelay(unsigned long long usecs, unsigned long lpj)
 {
 	usecs *= (((unsigned long long) HZ << 32) / 1000000) * lpj;
 	__delay((long long) usecs >> 32);
 }
 
-void __ndelay(unsigned long long nsecs, unsigned long lpj)
+static inline void __arch_ndelay(unsigned long long nsecs, unsigned long lpj)
 {
 	nsecs *= (((unsigned long long) HZ << 32) / 1000000000) * lpj;
 	__delay((long long) nsecs >> 32);
 }
 
-void udelay(unsigned long usecs)
+void __udelay(unsigned long usecs)
 {
-	__udelay(usecs, loops_per_jiffy);
+	__arch_udelay(usecs, loops_per_jiffy);
 }
 
 void ndelay(unsigned long nsecs)
 {
-	__ndelay(nsecs, loops_per_jiffy);
+	__arch_ndelay(nsecs, loops_per_jiffy);
 }
-
diff -urpN linux-2.6.18.new.2/arch/sparc64/kernel/sparc64_ksyms.c linux-2.6.18.new.3/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.6.18.new.2/arch/sparc64/kernel/sparc64_ksyms.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/sparc64/kernel/sparc64_ksyms.c	2006-09-22 02:30:27.000000000 +0200
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(strncmp);
 /* Delay routines. */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__const_delay);
 EXPORT_SYMBOL(__delay);
 
 void VISenter(void);
diff -urpN linux-2.6.18.new.2/arch/sparc64/lib/delay.c linux-2.6.18.new.3/arch/sparc64/lib/delay.c
--- linux-2.6.18.new.2/arch/sparc64/lib/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/sparc64/lib/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -24,7 +24,7 @@ void __delay(unsigned long loops)
  * but that runs into problems for higher values of HZ and
  * slow cpus.
  */
-void __const_udelay(unsigned long n)
+void __const_delay(unsigned long n)
 {
 	n *= 4;
 
@@ -36,11 +36,11 @@ void __const_udelay(unsigned long n)
 
 void __udelay(unsigned long n)
 {
-	__const_udelay(n * 0x10c7UL);
+	__const_delay(n * 0x10c7UL);
 }
 
 
 void __ndelay(unsigned long n)
 {
-	__const_udelay(n * 0x5UL);
+	__const_delay(n * 0x5UL);
 }
diff -urpN linux-2.6.18.new.2/arch/um/sys-i386/delay.c linux-2.6.18.new.3/arch/um/sys-i386/delay.c
--- linux-2.6.18.new.2/arch/um/sys-i386/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/um/sys-i386/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -25,16 +25,3 @@ void __udelay(unsigned long usecs)
         for(i=0;i<n;i++)
                 cpu_relax();
 }
-
-EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff -urpN linux-2.6.18.new.2/arch/um/sys-x86_64/delay.c linux-2.6.18.new.3/arch/um/sys-x86_64/delay.c
--- linux-2.6.18.new.2/arch/um/sys-x86_64/delay.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/um/sys-x86_64/delay.c	2006-09-22 02:30:27.000000000 +0200
@@ -26,16 +26,3 @@ void __udelay(unsigned long usecs)
         for(i=0;i<n;i++)
                 cpu_relax();
 }
-
-EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	unsigned long i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff -urpN linux-2.6.18.new.2/arch/x86_64/kernel/functionlist linux-2.6.18.new.3/arch/x86_64/kernel/functionlist
--- linux-2.6.18.new.2/arch/x86_64/kernel/functionlist	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/arch/x86_64/kernel/functionlist	2006-09-22 02:30:27.000000000 +0200
@@ -494,7 +494,7 @@
 *(.text.do_setitimer)
 *(.text.dev_queue_xmit_nit)
 *(.text.copy_from_read_buf)
-*(.text.__const_udelay)
+*(.text.__const_delay)
 *(.text.console_conditional_schedule)
 *(.text.wake_up_new_task)
 *(.text.wait_for_completion_interruptible)
diff -urpN linux-2.6.18.new.2/arch/x86_64/lib/delay.c linux-2.6.18.new.3/arch/x86_64/lib/delay.c
--- linux-2.6.18.new.2/arch/x86_64/lib/delay.c	2006-09-21 23:58:07.000000000 +0200
+++ linux-2.6.18.new.3/arch/x86_64/lib/delay.c	2006-09-22 02:30:43.000000000 +0200
@@ -39,20 +39,21 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-inline void __const_udelay(unsigned long xloops)
+/* cannot be static: ndelay macro needs it */
+inline void __const_delay(unsigned long xloops)
 {
 	__delay((xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32);
 }
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__const_delay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	__const_delay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+	__const_delay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
 }
 EXPORT_SYMBOL(__ndelay);
diff -urpN linux-2.6.18.new.2/include/asm-arm/delay.h linux-2.6.18.new.3/include/asm-arm/delay.h
--- linux-2.6.18.new.2/include/asm-arm/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-arm/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -9,36 +9,6 @@
 #include <asm/param.h>	/* HZ */
 
 extern void __delay(int loops);
-
-/*
- * This function intentionally does not exist; if you see references to
- * it, it means that you're calling udelay() with an out of range value.
- *
- * With currently imposed limits, this means that we support a max delay
- * of 2000us. Further limits: HZ<=1000 and bogomips<=3355
- */
-extern void __bad_udelay(void);
-
-/*
- * division by multiplication: you don't have to worry about
- * loss of precision.
- *
- * Use only for very small delays ( < 1 msec).  Should probably use a
- * lookup table, really, as the multiplications take much too long with
- * short delays.  This is a "reasonable" implementation, though (and the
- * first constant multiplications gets optimized away if the delay is
- * a constant)
- */
 extern void __udelay(unsigned long usecs);
-extern void __const_udelay(unsigned long);
-
-#define MAX_UDELAY_MS 2
-
-#define udelay(n)							\
-	(__builtin_constant_p(n) ?					\
-	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
-			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
-	  __udelay(n))
 
 #endif /* defined(_ARM_DELAY_H) */
-
diff -urpN linux-2.6.18.new.2/include/asm-arm26/delay.h linux-2.6.18.new.3/include/asm-arm26/delay.h
--- linux-2.6.18.new.2/include/asm-arm26/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-arm26/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -21,14 +21,10 @@ extern void __delay(int loops);
  *
  * FIXME - lets improve it then...
  */
-extern void udelay(unsigned long usecs);
-
 static inline unsigned long muldiv(unsigned long a, unsigned long b, unsigned long c)
 {
 	return a * b / c;
 }
 
-	
-
 #endif /* defined(_ARM_DELAY_H) */
 
diff -urpN linux-2.6.18.new.2/include/asm-cris/delay.h linux-2.6.18.new.3/include/asm-cris/delay.h
--- linux-2.6.18.new.2/include/asm-cris/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-cris/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -13,12 +13,9 @@
 
 extern unsigned long loops_per_usec; /* arch/cris/mm/init.c */
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	__delay(usecs * loops_per_usec);
 }
 
 #endif /* defined(_CRIS_DELAY_H) */
-
-
-
diff -urpN linux-2.6.18.new.2/include/asm-frv/delay.h linux-2.6.18.new.3/include/asm-frv/delay.h
--- linux-2.6.18.new.2/include/asm-frv/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-frv/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -40,11 +40,12 @@ static inline void __delay(unsigned long
 
 extern unsigned long loops_per_jiffy;
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	__delay(usecs * __delay_loops_MHz);
 }
 
+/* FIXME: looks like bug to me: */
 #define ndelay(n)	udelay((n) * 5)
 
 #endif /* _ASM_DELAY_H */
diff -urpN linux-2.6.18.new.2/include/asm-h8300/delay.h linux-2.6.18.new.3/include/asm-h8300/delay.h
--- linux-2.6.18.new.2/include/asm-h8300/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-h8300/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -27,7 +27,7 @@ extern __inline__ void __delay(unsigned 
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	usecs *= 4295;		/* 2**32 / 1000000 */
 	usecs /= (loops_per_jiffy*HZ);
diff -urpN linux-2.6.18.new.2/include/asm-i386/delay.h linux-2.6.18.new.3/include/asm-i386/delay.h
--- linux-2.6.18.new.2/include/asm-i386/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-i386/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -7,20 +7,15 @@
  * Delay routines calling functions in arch/i386/lib/delay.c
  */
  
-extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+extern void __const_delay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-	
 #define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	((n) > 20000 ? __bad_ndelay() : __const_delay((n) * 5ul)) : \
 	__ndelay(n))
 
 void use_tsc_delay(void);
diff -urpN linux-2.6.18.new.2/include/asm-ia64/delay.h linux-2.6.18.new.3/include/asm-ia64/delay.h
--- linux-2.6.18.new.2/include/asm-ia64/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-ia64/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -83,6 +83,4 @@ __delay (unsigned long loops)
 	ia64_delay_loop (loops - 1);
 }
 
-extern void udelay (unsigned long usecs);
-
 #endif /* _ASM_IA64_DELAY_H */
diff -urpN linux-2.6.18.new.2/include/asm-m32r/delay.h linux-2.6.18.new.3/include/asm-m32r/delay.h
--- linux-2.6.18.new.2/include/asm-m32r/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-m32r/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -9,20 +9,15 @@
  * Delay routines calling functions in arch/m32r/lib/delay.c
  */
 
-extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+extern void __const_delay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-
 #define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	((n) > 20000 ? __bad_ndelay() : __const_delay((n) * 5ul)) : \
 	__ndelay(n))
 
 #endif /* _ASM_M32R_DELAY_H */
diff -urpN linux-2.6.18.new.2/include/asm-m68k/delay.h linux-2.6.18.new.3/include/asm-m68k/delay.h
--- linux-2.6.18.new.2/include/asm-m68k/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-m68k/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -15,8 +15,6 @@ static inline void __delay(unsigned long
 		: "=d" (loops) : "0" (loops));
 }
 
-extern void __bad_udelay(void);
-
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
@@ -24,7 +22,7 @@ extern void __bad_udelay(void);
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
-static inline void __const_udelay(unsigned long xloops)
+static inline void __const_delay(unsigned long xloops)
 {
 	unsigned long tmp;
 
@@ -36,13 +34,9 @@ static inline void __const_udelay(unsign
 
 static inline void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 4295);	/* 2**32 / 1000000 */
+	__const_delay(usecs * 4295);	/* 2**32 / 1000000 */
 }
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4295)) : \
-	__udelay(n))
-
 static inline unsigned long muldiv(unsigned long a, unsigned long b,
 				   unsigned long c)
 {
diff -urpN linux-2.6.18.new.2/include/asm-m68knommu/delay.h linux-2.6.18.new.3/include/asm-m68knommu/delay.h
--- linux-2.6.18.new.2/include/asm-m68knommu/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-m68knommu/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -48,7 +48,7 @@ static inline void __delay(unsigned long
 
 extern unsigned long loops_per_jiffy;
 
-static inline void _udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 #if defined(CONFIG_M68328) || defined(CONFIG_M68EZ328) || \
     defined(CONFIG_M68VZ328) || defined(CONFIG_M68360) || \
@@ -65,12 +65,4 @@ static inline void _udelay(unsigned long
 #endif
 }
 
-/*
- *	Moved the udelay() function into library code, no longer inlined.
- *	I had to change the algorithm because we are overflowing now on
- *	the faster ColdFire parts. The code is a little biger, so it makes
- *	sense to library it.
- */
-extern void udelay(unsigned long usecs);
-
 #endif /* defined(_M68KNOMMU_DELAY_H) */
diff -urpN linux-2.6.18.new.2/include/asm-mips/delay.h linux-2.6.18.new.3/include/asm-mips/delay.h
--- linux-2.6.18.new.2/include/asm-mips/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-mips/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -48,7 +48,7 @@ static inline void __delay(unsigned long
  * a constant)
  */
 
-static inline void __udelay(unsigned long usecs, unsigned long lpj)
+static inline void __arch_udelay(unsigned long usecs, unsigned long lpj)
 {
 	unsigned long lo;
 
@@ -81,15 +81,6 @@ static inline void __udelay(unsigned lon
 
 #define __udelay_val cpu_data[smp_processor_id()].udelay_val
 
-#define udelay(usecs) __udelay((usecs),__udelay_val)
-
-/* make sure "usecs *= ..." in udelay do not overflow. */
-#if HZ >= 1000
-#define MAX_UDELAY_MS	1
-#elif HZ <= 200
-#define MAX_UDELAY_MS	5
-#else
-#define MAX_UDELAY_MS	(1000 / HZ)
-#endif
+#define __udelay(usecs) __arch_udelay((usecs),__udelay_val)
 
 #endif /* _ASM_DELAY_H */
diff -urpN linux-2.6.18.new.2/include/asm-parisc/delay.h linux-2.6.18.new.3/include/asm-parisc/delay.h
--- linux-2.6.18.new.2/include/asm-parisc/delay.h	2006-09-22 00:00:48.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-parisc/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -37,6 +37,4 @@ static __inline__ void __udelay(unsigned
 	__cr16_delay(usecs * ((unsigned long)boot_cpu_data.cpu_hz / 1000000UL));
 }
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_PARISC_DELAY_H) */
diff -urpN linux-2.6.18.new.2/include/asm-powerpc/delay.h linux-2.6.18.new.3/include/asm-powerpc/delay.h
--- linux-2.6.18.new.2/include/asm-powerpc/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-powerpc/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -15,7 +15,7 @@
  */
 
 extern void __delay(unsigned long loops);
-extern void udelay(unsigned long usecs);
+extern void __udelay(unsigned long usecs);
 
 /*
  * On shared processor machines the generic implementation of mdelay can
diff -urpN linux-2.6.18.new.2/include/asm-ppc/delay.h linux-2.6.18.new.3/include/asm-ppc/delay.h
--- linux-2.6.18.new.2/include/asm-ppc/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-ppc/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -30,10 +30,9 @@ extern void __delay(unsigned int loops);
  * (which corresponds to ~3800 bogomips at HZ = 100).
  *  -- paulus
  */
-#define __MAX_UDELAY	(226050910UL/HZ)	/* maximum udelay argument */
 #define __MAX_NDELAY	(4294967295UL/HZ)	/* maximum ndelay argument */
 
-extern __inline__ void __udelay(unsigned int x)
+extern __inline__ void __arch_udelay(unsigned int x)
 {
 	unsigned int loops;
 
@@ -42,7 +41,7 @@ extern __inline__ void __udelay(unsigned
 	__delay(loops);
 }
 
-extern __inline__ void __ndelay(unsigned int x)
+extern __inline__ void __arch_ndelay(unsigned int x)
 {
 	unsigned int loops;
 
@@ -51,16 +50,13 @@ extern __inline__ void __ndelay(unsigned
 	__delay(loops);
 }
 
-extern void __bad_udelay(void);		/* deliberately undefined */
 extern void __bad_ndelay(void);		/* deliberately undefined */
 
-#define udelay(n) (__builtin_constant_p(n)? \
-	((n) > __MAX_UDELAY? __bad_udelay(): __udelay((n) * (19 * HZ))) : \
-	__udelay((n) * (19 * HZ)))
+#define __udelay(n) __arch_udelay((n) * (19 * HZ))
 
 #define ndelay(n) (__builtin_constant_p(n)? \
-	((n) > __MAX_NDELAY? __bad_ndelay(): __ndelay((n) * HZ)) : \
-	__ndelay((n) * HZ))
+	((n) > __MAX_NDELAY? __bad_ndelay(): __arch_ndelay((n) * HZ)) : \
+	__arch_ndelay((n) * HZ))
 
 #endif /* defined(_PPC_DELAY_H) */
 #endif /* __KERNEL__ */
diff -urpN linux-2.6.18.new.2/include/asm-s390/delay.h linux-2.6.18.new.3/include/asm-s390/delay.h
--- linux-2.6.18.new.2/include/asm-s390/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-s390/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -17,6 +17,4 @@
 extern void __udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_S390_DELAY_H) */
diff -urpN linux-2.6.18.new.2/include/asm-sh/delay.h linux-2.6.18.new.3/include/asm-sh/delay.h
--- linux-2.6.18.new.2/include/asm-sh/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-sh/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -7,21 +7,15 @@
  * Delay routines calling functions in arch/sh/lib/delay.c
  */
  
-extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+extern void __const_delay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
-	__udelay(n))
-
-
 #define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	((n) > 20000 ? __bad_ndelay() : __const_delay((n) * 5ul)) : \
 	__ndelay(n))
 
 #endif /* __ASM_SH_DELAY_H */
diff -urpN linux-2.6.18.new.2/include/asm-sh64/delay.h linux-2.6.18.new.3/include/asm-sh64/delay.h
--- linux-2.6.18.new.2/include/asm-sh64/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-sh64/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -2,10 +2,10 @@
 #define __ASM_SH64_DELAY_H
 
 extern void __delay(int loops);
-extern void __udelay(unsigned long long usecs, unsigned long lpj);
-extern void __ndelay(unsigned long long nsecs, unsigned long lpj);
-extern void udelay(unsigned long usecs);
+extern void __udelay(unsigned long usecs);
 extern void ndelay(unsigned long nsecs);
+/* for linux/delay.h: */
+#define ndelay ndelay
 
 #endif /* __ASM_SH64_DELAY_H */
 
diff -urpN linux-2.6.18.new.2/include/asm-sparc/delay.h linux-2.6.18.new.3/include/asm-sparc/delay.h
--- linux-2.6.18.new.2/include/asm-sparc/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-sparc/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -28,7 +28,6 @@ extern void __ndelay(unsigned long nsecs
 #else /* SMP */
 #define __udelay_val	loops_per_jiffy
 #endif /* SMP */
-#define udelay(__usecs)	__udelay(__usecs, __udelay_val)
 #define ndelay(__nsecs)	__ndelay(__nsecs, __udelay_val)
 
 #endif /* defined(__SPARC_DELAY_H) */
diff -urpN linux-2.6.18.new.2/include/asm-sparc64/delay.h linux-2.6.18.new.3/include/asm-sparc64/delay.h
--- linux-2.6.18.new.2/include/asm-sparc64/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-sparc64/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -21,15 +21,11 @@ extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+extern void __const_delay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-	
 #define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	((n) > 20000 ? __bad_ndelay() : __const_delay((n) * 5ul)) : \
 	__ndelay(n))
 
 #endif /* !__ASSEMBLY__ */
diff -urpN linux-2.6.18.new.2/include/asm-v850/delay.h linux-2.6.18.new.3/include/asm-v850/delay.h
--- linux-2.6.18.new.2/include/asm-v850/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-v850/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -33,7 +33,7 @@ static inline void __delay(unsigned long
 
 extern unsigned long loops_per_jiffy;
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	register unsigned long full_loops, part_loops;
 
diff -urpN linux-2.6.18.new.2/include/asm-x86_64/delay.h linux-2.6.18.new.3/include/asm-x86_64/delay.h
--- linux-2.6.18.new.2/include/asm-x86_64/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-x86_64/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -7,20 +7,15 @@
  * Delay routines calling functions in arch/x86_64/lib/delay.c
  */
  
-extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long usecs);
-extern void __const_udelay(unsigned long usecs);
+extern void __const_delay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
-	__udelay(n))
-
 #define ndelay(n) (__builtin_constant_p(n) ? \
-       ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+       ((n) > 20000 ? __bad_ndelay() : __const_delay((n) * 5ul)) : \
        __ndelay(n))
 
 
diff -urpN linux-2.6.18.new.2/include/asm-xtensa/delay.h linux-2.6.18.new.3/include/asm-xtensa/delay.h
--- linux-2.6.18.new.2/include/asm-xtensa/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/asm-xtensa/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -35,7 +35,7 @@ static __inline__ u32 xtensa_get_ccount(
  * local_cpu_data->... where local_cpu_data points to the current
  * cpu. */
 
-static __inline__ void udelay (unsigned long usecs)
+static __inline__ void __udelay (unsigned long usecs)
 {
 	unsigned long start = xtensa_get_ccount();
 	unsigned long cycles = usecs * (loops_per_jiffy / (1000000UL / HZ));
diff -urpN linux-2.6.18.new.2/include/linux/delay.h linux-2.6.18.new.3/include/linux/delay.h
--- linux-2.6.18.new.2/include/linux/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/include/linux/delay.h	2006-09-22 02:30:27.000000000 +0200
@@ -11,37 +11,15 @@ extern unsigned long loops_per_jiffy;
 
 #include <asm/delay.h>
 
-/*
- * Using udelay() for intervals greater than a few milliseconds can
- * risk overflow for high loops_per_jiffy (high bogomips) machines. The
- * mdelay() provides a wrapper to prevent this.  For delays greater
- * than MAX_UDELAY_MS milliseconds, the wrapper is used.  Architecture
- * specific values can be defined in asm-???/delay.h as an override.
- * The 2nd mdelay() definition ensures GCC will optimize away the 
- * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
- */
-
-#ifndef MAX_UDELAY_MS
-#define MAX_UDELAY_MS	5
-#endif
-
-#ifndef mdelay
-#define mdelay(n) (\
-	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
-#endif
-
+void calibrate_delay(void);
+void udelay(unsigned int usecs);
+void mdelay(unsigned int msecs);
 #ifndef ndelay
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
-void calibrate_delay(void);
 void msleep(unsigned int msecs);
+void ssleep(unsigned int secs);
 unsigned long msleep_interruptible(unsigned int msecs);
 
-static inline void ssleep(unsigned int seconds)
-{
-	msleep(seconds * 1000);
-}
-
 #endif /* defined(_LINUX_DELAY_H) */
diff -urpN linux-2.6.18.new.2/kernel/timer.c linux-2.6.18.new.3/kernel/timer.c
--- linux-2.6.18.new.2/kernel/timer.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.3/kernel/timer.c	2006-09-22 02:30:27.000000000 +0200
@@ -1882,6 +1882,36 @@ unregister_time_interpolator(struct time
 }
 #endif /* CONFIG_TIME_INTERPOLATION */
 
+/*
+ * Not inlined because we do not optimize delays for speed. ;)
+ */
+void udelay(unsigned int usecs)
+{
+	unsigned int k;
+	if (unlikely(usecs > 200*1000)) {
+		printk("BUG: delay too large: udelay(%u)\n", usecs);
+		dump_stack();
+		usecs = 200*1000;
+	}
+	k = usecs / 1024;
+	usecs %= 1024;
+	while (k) {
+		__udelay(1024);
+		k--;
+	}
+	__udelay(usecs);
+}
+
+EXPORT_SYMBOL(udelay);
+
+void mdelay(unsigned int msecs)
+{
+	while (msecs--)
+		__udelay(1000);
+}
+
+EXPORT_SYMBOL(mdelay);
+
 /**
  * msleep - sleep safely even with waitqueue interruptions
  * @msecs: Time in milliseconds to sleep for
@@ -1896,6 +1926,13 @@ void msleep(unsigned int msecs)
 
 EXPORT_SYMBOL(msleep);
 
+void ssleep(unsigned int secs)
+{
+        msleep(secs * 1000);
+}
+
+EXPORT_SYMBOL(ssleep);
+
 /**
  * msleep_interruptible - sleep waiting for signals
  * @msecs: Time in milliseconds to sleep for

--Boundary-00=_hg5EFfvckVXHj1+--
