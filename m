Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUDLIIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUDLIIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 04:08:12 -0400
Received: from pD9E57A79.dip.t-dialin.net ([217.229.122.121]:43274 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S262719AbUDLIHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 04:07:55 -0400
Date: Mon, 12 Apr 2004 07:57:30 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [2/3]
Message-ID: <20040412075729.C5198@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040412075704.B5198@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040412075704.B5198@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Mon, Apr 12, 2004 at 07:57:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ur linux-2.6.5-1/drivers/char/vt_ioctl.c linux-2.6.5-2/drivers/char/vt_ioctl.c
--- linux-2.6.5-1/drivers/char/vt_ioctl.c	Sat Apr 10 11:10:27 2004
+++ linux-2.6.5-2/drivers/char/vt_ioctl.c	Sun Apr 11 14:42:08 2004
@@ -26,6 +26,7 @@
 #include <linux/console.h>
 
 #include <asm/io.h>
+#include <asm/timex.h>
 #include <asm/uaccess.h>
 
 #include <linux/kbd_kern.h>
@@ -391,7 +392,7 @@
 		if (!perm)
 			return -EPERM;
 		if (arg)
-			arg = 1193182 / arg;
+			arg = PIC_TICK_RATE / arg;
 		kd_mksound(arg, 0);
 		return 0;
 
@@ -408,7 +409,7 @@
 		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
 		count = ticks ? (arg & 0xffff) : 0;
 		if (count)
-			count = 1193182 / count;
+			count = PIC_TICK_RATE / count;
 		kd_mksound(count, ticks);
 		return 0;
 	}
diff -ur linux-2.6.5-1/drivers/input/misc/98spkr.c linux-2.6.5-2/drivers/input/misc/98spkr.c
--- linux-2.6.5-1/drivers/input/misc/98spkr.c	Thu Dec 18 02:58:17 2003
+++ linux-2.6.5-2/drivers/input/misc/98spkr.c	Sun Apr 11 14:42:59 2004
@@ -44,7 +44,7 @@
 	} 
 
 	if (value > 20 && value < 32767)
-		count = CLOCK_TICK_RATE / value;
+		count = PIC_TICK_RATE / value;
 	
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
diff -ur linux-2.6.5-1/drivers/input/misc/m68kspkr.c linux-2.6.5-2/drivers/input/misc/m68kspkr.c
--- linux-2.6.5-1/drivers/input/misc/m68kspkr.c	Thu Dec 18 02:58:15 2003
+++ linux-2.6.5-2/drivers/input/misc/m68kspkr.c	Sun Apr 11 14:43:34 2004
@@ -42,7 +42,7 @@
 	}
 
 	if (value > 20 && value < 32767)
-		count = 1193182 / value;
+		count = PIC_TICK_RATE / value;
 
 	mach_beep(count, -1);
 
diff -ur linux-2.6.5-1/drivers/input/misc/pcspkr.c linux-2.6.5-2/drivers/input/misc/pcspkr.c
--- linux-2.6.5-1/drivers/input/misc/pcspkr.c	Thu Dec 18 02:58:57 2003
+++ linux-2.6.5-2/drivers/input/misc/pcspkr.c	Sun Apr 11 14:43:56 2004
@@ -43,7 +43,7 @@
 	} 
 
 	if (value > 20 && value < 32767)
-		count = CLOCK_TICK_RATE / value;
+		count = PIC_TICK_RATE / value;
 	
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 

diff -ur linux-2.6.5-2/arch/x86_64/kernel/time.c linux-2.6.5-3/arch/x86_64/kernel/time.c
--- linux-2.6.5-2/arch/x86_64/kernel/time.c	Sat Apr 10 11:10:26 2004
+++ linux-2.6.5-3/arch/x86_64/kernel/time.c	Sun Apr 11 15:26:49 2004
@@ -54,7 +54,7 @@
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 unsigned long hpet_period;				/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
-unsigned long vxtime_hz = 1193182;
+unsigned long vxtime_hz = PIC_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
 
@@ -600,8 +600,8 @@
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
 	outb(0xb0, 0x43);
-	outb((1193182 / (1000 / 50)) & 0xff, 0x42);
-	outb((1193182 / (1000 / 50)) >> 8, 0x42);
+	outb((PIC_TICK_RATE / (1000 / 50)) & 0xff, 0x42);
+	outb((PIC_TICK_RATE / (1000 / 50)) >> 8, 0x42);
 	rdtscll(start);
 	sync_core();
 	while ((inb(0x61) & 0x20) == 0);
diff -ur linux-2.6.5-2/drivers/input/gameport/gameport.c linux-2.6.5-3/drivers/input/gameport/gameport.c
--- linux-2.6.5-2/drivers/input/gameport/gameport.c	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-3/drivers/input/gameport/gameport.c	Sun Apr 11 15:23:35 2004
@@ -37,7 +37,7 @@
 
 #ifdef __i386__
 
-#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
+#define DELTA(x,y)      ((y)-(x)+((y)<(x)?PIC_TICK_RATE/HZ:0))
 #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
 
 static unsigned int get_time_pit(void)
-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
