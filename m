Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbUDMWIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbUDMWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:08:23 -0400
Received: from pD953265E.dip.t-dialin.net ([217.83.38.94]:18701 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263683AbUDMWH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:07:58 -0400
Date: Tue, 13 Apr 2004 22:01:10 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [2/3]
Message-ID: <20040413220109.C7047@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040413215833.A7047@Marvin.DL8BCU.ampr.org> <20040413215932.B7047@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040413215932.B7047@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, Apr 13, 2004 at 09:59:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2/3 	use PIT_TICK_RATE in *spkr.c etc.



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
diff -urN linux-2.6.5-1a/drivers/char/vt_ioctl.c linux-2.6.5-2a/drivers/char/vt_ioctl.c
--- linux-2.6.5-1a/drivers/char/vt_ioctl.c	Sun Apr 11 14:24:19 2004
+++ linux-2.6.5-2a/drivers/char/vt_ioctl.c	Tue Apr 13 17:56:07 2004
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/console.h>
 
+#include <asm/8253pit.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -391,7 +392,7 @@
 		if (!perm)
 			return -EPERM;
 		if (arg)
-			arg = 1193182 / arg;
+			arg = PIT_TICK_RATE / arg;
 		kd_mksound(arg, 0);
 		return 0;
 
@@ -408,7 +409,7 @@
 		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
 		count = ticks ? (arg & 0xffff) : 0;
 		if (count)
-			count = 1193182 / count;
+			count = PIT_TICK_RATE / count;
 		kd_mksound(count, ticks);
 		return 0;
 	}
diff -urN linux-2.6.5-1a/drivers/input/gameport/gameport.c linux-2.6.5-2a/drivers/input/gameport/gameport.c
--- linux-2.6.5-1a/drivers/input/gameport/gameport.c	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-2a/drivers/input/gameport/gameport.c	Tue Apr 13 18:24:47 2004
@@ -10,6 +10,7 @@
  * the Free Software Foundation.
  */
 
+#include <asm/8253pit.h>
 #include <asm/io.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
@@ -37,7 +38,7 @@
 
 #ifdef __i386__
 
-#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
+#define DELTA(x,y)      ((y)-(x)+((y)<(x)?PIT_TICK_RATE/HZ:0))
 #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
 
 static unsigned int get_time_pit(void)
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
 
diff -urN linux-2.6.5-1a/drivers/input/misc/m68kspkr.c linux-2.6.5-2a/drivers/input/misc/m68kspkr.c
--- linux-2.6.5-1a/drivers/input/misc/m68kspkr.c	Thu Dec 18 02:58:15 2003
+++ linux-2.6.5-2a/drivers/input/misc/m68kspkr.c	Tue Apr 13 17:58:30 2004
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <asm/8253pit.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 
@@ -42,7 +43,7 @@
 	}
 
 	if (value > 20 && value < 32767)
-		count = 1193182 / value;
+		count = PIT_TICK_RATE / value;
 
 	mach_beep(count, -1);
 
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
 

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
