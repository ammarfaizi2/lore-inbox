Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUEDVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUEDVFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEDVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:05:30 -0400
Received: from pD95F30BB.dip.t-dialin.net ([217.95.48.187]:51467 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S264610AbUEDVFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:05:05 -0400
Date: Tue, 4 May 2004 21:04:58 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       ralf@linux-mips.org
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage take 3 [2/3]
Message-ID: <20040504210458.C6663@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
	akpm@osdl.org, ralf@linux-mips.org
References: <20040504210305.A6663@Marvin.DL8BCU.ampr.org> <20040504210359.B6663@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040504210359.B6663@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, May 04, 2004 at 09:03:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/3:    use PIT_TICK_RATE in *spkr.c

diff -urN linux-2.6.5-1a/arch/x86_64/kernel/time.c linux-2.6.5-2a/arch/x86_64/kernel/time.c
--- linux-2.6.5-1a/arch/x86_64/kernel/time.c	Sun Apr 11 14:24:16 2004
+++ linux-2.6.5-2a/arch/x86_64/kernel/time.c	Tue Apr 13 18:03:28 2004
@@ -27,6 +27,7 @@
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
+#include <asm/8253pit.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
 #include <asm/timex.h>
@@ -54,7 +55,7 @@
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 unsigned long hpet_period;				/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
-unsigned long vxtime_hz = 1193182;
+unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
 
@@ -600,8 +601,8 @@
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
 	outb(0xb0, 0x43);
-	outb((1193182 / (1000 / 50)) & 0xff, 0x42);
-	outb((1193182 / (1000 / 50)) >> 8, 0x42);
+	outb((PIT_TICK_RATE / (1000 / 50)) & 0xff, 0x42);
+	outb((PIT_TICK_RATE / (1000 / 50)) >> 8, 0x42);
 	rdtscll(start);
 	sync_core();
 	while ((inb(0x61) & 0x20) == 0);
diff -urN linux-2.6.5-1a/drivers/input/misc/98spkr.c linux-2.6.5-2a/drivers/input/misc/98spkr.c
--- linux-2.6.5-1a/drivers/input/misc/98spkr.c	Thu Dec 18 02:58:17 2003
+++ linux-2.6.5-2a/drivers/input/misc/98spkr.c	Tue Apr 13 18:32:44 2004
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <asm/8253pit.h>
 #include <asm/io.h>
 
 MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
@@ -44,7 +45,7 @@
 	} 
 
 	if (value > 20 && value < 32767)
-		count = CLOCK_TICK_RATE / value;
+		count = PIT_TICK_RATE / value;
 	
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
diff -urN linux-2.6.5-1a/drivers/input/misc/pcspkr.c linux-2.6.5-2a/drivers/input/misc/pcspkr.c
--- linux-2.6.5-1a/drivers/input/misc/pcspkr.c	Thu Dec 18 02:58:57 2003
+++ linux-2.6.5-2a/drivers/input/misc/pcspkr.c	Tue Apr 13 17:59:41 2004
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <asm/8253pit.h>
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -43,7 +44,7 @@
 	} 
 
 	if (value > 20 && value < 32767)
-		count = CLOCK_TICK_RATE / value;
+		count = PIT_TICK_RATE / value;
 	
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
diff -ur linux-2.6.5-b/drivers/input/misc/Kconfig linux-2.6.5-b2/drivers/input/misc/Kconfig
--- linux-2.6.5-b/drivers/input/misc/Kconfig	Sun Apr 11 14:24:49 2004
+++ linux-2.6.5-b2/drivers/input/misc/Kconfig	Tue May  4 20:31:42 2004
@@ -14,7 +14,7 @@
 
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-	depends on INPUT && INPUT_MISC
+	depends on (ALPHA || X86 || X86_64 || MIPS) && INPUT && INPUT_MISC
 	help
 	  Say Y here if you want the standard PC Speaker to be used for
 	  bells and whistles.
-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
