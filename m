Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264349AbUEDVE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUEDVE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEDVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:04:27 -0400
Received: from pD95F30BB.dip.t-dialin.net ([217.95.48.187]:50187 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S264349AbUEDVEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:04:08 -0400
Date: Tue, 4 May 2004 21:03:59 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       ralf@linux-mips.org
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage take 3 [1/3]
Message-ID: <20040504210359.B6663@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
	akpm@osdl.org, ralf@linux-mips.org
References: <20040504210305.A6663@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040504210305.A6663@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, May 04, 2004 at 09:03:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/3:    introduce asm-*/8253pit.h, #define PIT_TICK_RATE constant.



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
