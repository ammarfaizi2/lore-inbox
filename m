Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUDMWHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUDMWHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:07:42 -0400
Received: from pD953265E.dip.t-dialin.net ([217.83.38.94]:16141 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263785AbUDMWGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:06:31 -0400
Date: Tue, 13 Apr 2004 21:59:33 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [1/3]
Message-ID: <20040413215932.B7047@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040413215833.A7047@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040413215833.A7047@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, Apr 13, 2004 at 09:58:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/3:	introduce asm-*/8253pit.h, #defining PIT_TICK_RATE constant. 
 	It seems this is not always the same value.

diff -urN linux-2.6.5/arch/alpha/kernel/time.c linux-2.6.5-1a/arch/alpha/kernel/time.c
--- linux-2.6.5/arch/alpha/kernel/time.c	Sun Apr 11 14:24:42 2004
+++ linux-2.6.5-1a/arch/alpha/kernel/time.c	Tue Apr 13 17:18:19 2004
@@ -45,6 +45,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/hwrpb.h>
+#include <asm/8253pit.h>
 
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
@@ -254,12 +255,11 @@
  * arch/i386/time.c.
  */
 
-#define PIC_TICK_RATE	1193180UL
 #define CALIBRATE_LATCH	0xffff
 #define TIMEOUT_COUNT	0x100000
 
 static unsigned long __init
-calibrate_cc_with_pic(void)
+calibrate_cc_with_pit(void)
 {
 	int cc, count = 0;
 
@@ -287,7 +287,7 @@
 	if (count <= 1 || count == TIMEOUT_COUNT)
 		return 0;
 
-	return ((long)cc * PIC_TICK_RATE) / (CALIBRATE_LATCH + 1);
+	return ((long)cc * PIT_TICK_RATE) / (CALIBRATE_LATCH + 1);
 }
 
 /* The Linux interpretation of the CMOS clock register contents:
@@ -313,7 +313,7 @@
 
 	/* Calibrate CPU clock -- attempt #1.  */
 	if (!est_cycle_freq)
-		est_cycle_freq = validate_cc_value(calibrate_cc_with_pic());
+		est_cycle_freq = validate_cc_value(calibrate_cc_with_pit());
 
 	cc1 = rpcc_after_update_in_progress();
 
diff -urN linux-2.6.5/include/asm-alpha/8253pit.h linux-2.6.5-1a/include/asm-alpha/8253pit.h
--- linux-2.6.5/include/asm-alpha/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-alpha/8253pit.h	Tue Apr 13 17:14:40 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-arm/8253pit.h linux-2.6.5-1a/include/asm-arm/8253pit.h
--- linux-2.6.5/include/asm-arm/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-arm/8253pit.h	Tue Apr 13 17:19:31 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-arm26/8253pit.h linux-2.6.5-1a/include/asm-arm26/8253pit.h
--- linux-2.6.5/include/asm-arm26/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-arm26/8253pit.h	Tue Apr 13 17:20:08 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-cris/8253pit.h linux-2.6.5-1a/include/asm-cris/8253pit.h
--- linux-2.6.5/include/asm-cris/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-cris/8253pit.h	Tue Apr 13 17:20:25 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-h8300/8253pit.h linux-2.6.5-1a/include/asm-h8300/8253pit.h
--- linux-2.6.5/include/asm-h8300/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-h8300/8253pit.h	Tue Apr 13 17:20:42 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-i386/8253pit.h linux-2.6.5-1a/include/asm-i386/8253pit.h
--- linux-2.6.5/include/asm-i386/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-i386/8253pit.h	Tue Apr 13 17:21:49 2004
@@ -0,0 +1,12 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#include <asm/timex.h>
+
+#define PIT_TICK_RATE 	CLOCK_TICK_RATE
+
+#endif
diff -urN linux-2.6.5/include/asm-ia64/8253pit.h linux-2.6.5-1a/include/asm-ia64/8253pit.h
--- linux-2.6.5/include/asm-ia64/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-ia64/8253pit.h	Tue Apr 13 17:22:10 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-m68k/8253pit.h linux-2.6.5-1a/include/asm-m68k/8253pit.h
--- linux-2.6.5/include/asm-m68k/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-m68k/8253pit.h	Tue Apr 13 17:23:24 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-m68k/timex.h linux-2.6.5-1a/include/asm-m68k/timex.h
--- linux-2.6.5/include/asm-m68k/timex.h	Thu Dec 18 02:58:07 2003
+++ linux-2.6.5-1a/include/asm-m68k/timex.h	Tue Apr 13 17:24:50 2004
@@ -6,7 +6,9 @@
 #ifndef _ASMm68k_TIMEX_H
 #define _ASMm68k_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#include <asm/8253pit.h>
+
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-m68knommu/8253pit.h linux-2.6.5-1a/include/asm-m68knommu/8253pit.h
--- linux-2.6.5/include/asm-m68knommu/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-m68knommu/8253pit.h	Tue Apr 13 21:23:13 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-mips/8253pit.h linux-2.6.5-1a/include/asm-mips/8253pit.h
--- linux-2.6.5/include/asm-mips/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-mips/8253pit.h	Tue Apr 13 17:25:12 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-parisc/8253pit.h linux-2.6.5-1a/include/asm-parisc/8253pit.h
--- linux-2.6.5/include/asm-parisc/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-parisc/8253pit.h	Tue Apr 13 17:25:29 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-parisc/timex.h linux-2.6.5-1a/include/asm-parisc/timex.h
--- linux-2.6.5/include/asm-parisc/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1a/include/asm-parisc/timex.h	Tue Apr 13 17:26:16 2004
@@ -6,9 +6,10 @@
 #ifndef _ASMPARISC_TIMEX_H
 #define _ASMPARISC_TIMEX_H
 
+#include <asm8253pit.h>
 #include <asm/system.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6.5/include/asm-ppc/8253pit.h linux-2.6.5-1a/include/asm-ppc/8253pit.h
--- linux-2.6.5/include/asm-ppc/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-ppc/8253pit.h	Tue Apr 13 17:26:35 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-ppc/timex.h linux-2.6.5-1a/include/asm-ppc/timex.h
--- linux-2.6.5/include/asm-ppc/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1a/include/asm-ppc/timex.h	Tue Apr 13 17:27:36 2004
@@ -8,9 +8,10 @@
 #define _ASMppc_TIMEX_H
 
 #include <linux/config.h>
+#include <asm/8253pit.h>
 #include <asm/cputable.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-ppc64/8253pit.h linux-2.6.5-1a/include/asm-ppc64/8253pit.h
--- linux-2.6.5/include/asm-ppc64/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-ppc64/8253pit.h	Tue Apr 13 17:27:52 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-ppc64/timex.h linux-2.6.5-1a/include/asm-ppc64/timex.h
--- linux-2.6.5/include/asm-ppc64/timex.h	Thu Dec 18 02:59:59 2003
+++ linux-2.6.5-1a/include/asm-ppc64/timex.h	Tue Apr 13 17:28:32 2004
@@ -11,7 +11,9 @@
 #ifndef _ASMPPC64_TIMEX_H
 #define _ASMPPC64_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#include <asm/8253pit.h>
+
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-s390/8253pit.h linux-2.6.5-1a/include/asm-s390/8253pit.h
--- linux-2.6.5/include/asm-s390/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-s390/8253pit.h	Tue Apr 13 17:28:50 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-s390/timex.h linux-2.6.5-1a/include/asm-s390/timex.h
--- linux-2.6.5/include/asm-s390/timex.h	Sun Apr 11 14:23:27 2004
+++ linux-2.6.5-1a/include/asm-s390/timex.h	Tue Apr 13 17:29:23 2004
@@ -11,7 +11,9 @@
 #ifndef _ASM_S390_TIMEX_H
 #define _ASM_S390_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#include <asm/8253pit.h>
+
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-sh/8253pit.h linux-2.6.5-1a/include/asm-sh/8253pit.h
--- linux-2.6.5/include/asm-sh/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-sh/8253pit.h	Tue Apr 13 17:30:06 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-sparc/8253pit.h linux-2.6.5-1a/include/asm-sparc/8253pit.h
--- linux-2.6.5/include/asm-sparc/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-sparc/8253pit.h	Tue Apr 13 17:30:31 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-sparc/timex.h linux-2.6.5-1a/include/asm-sparc/timex.h
--- linux-2.6.5/include/asm-sparc/timex.h	Thu Dec 18 02:59:05 2003
+++ linux-2.6.5-1a/include/asm-sparc/timex.h	Tue Apr 13 17:31:19 2004
@@ -6,7 +6,9 @@
 #ifndef _ASMsparc_TIMEX_H
 #define _ASMsparc_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#include <asm/8253pit.h>
+
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-sparc64/8253pit.h linux-2.6.5-1a/include/asm-sparc64/8253pit.h
--- linux-2.6.5/include/asm-sparc64/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-sparc64/8253pit.h	Tue Apr 13 17:31:29 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193180UL
+
+#endif
diff -urN linux-2.6.5/include/asm-sparc64/timex.h linux-2.6.5-1a/include/asm-sparc64/timex.h
--- linux-2.6.5/include/asm-sparc64/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1a/include/asm-sparc64/timex.h	Tue Apr 13 17:32:16 2004
@@ -6,9 +6,10 @@
 #ifndef _ASMsparc64_TIMEX_H
 #define _ASMsparc64_TIMEX_H
 
+#include <asm/8253pit.h>
 #include <asm/timer.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -urN linux-2.6.5/include/asm-um/8253pit.h linux-2.6.5-1a/include/asm-um/8253pit.h
--- linux-2.6.5/include/asm-um/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-um/8253pit.h	Tue Apr 13 17:32:34 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-x86_64/8253pit.h linux-2.6.5-1a/include/asm-x86_64/8253pit.h
--- linux-2.6.5/include/asm-x86_64/8253pit.h	Thu Jan  1 00:00:00 1970
+++ linux-2.6.5-1a/include/asm-x86_64/8253pit.h	Tue Apr 13 17:32:49 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -urN linux-2.6.5/include/asm-x86_64/timex.h linux-2.6.5-1a/include/asm-x86_64/timex.h
--- linux-2.6.5/include/asm-x86_64/timex.h	Sun Apr 11 14:23:27 2004
+++ linux-2.6.5-1a/include/asm-x86_64/timex.h	Tue Apr 13 17:33:26 2004
@@ -7,11 +7,12 @@
 #define _ASMx8664_TIMEX_H
 
 #include <linux/config.h>
+#include <asm/8253pit.h>
 #include <asm/msr.h>
 #include <asm/vsyscall.h>
 #include <asm/hpet.h>
 
-#define CLOCK_TICK_RATE	1193182 /* Underlying HZ */
+#define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
