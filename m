Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUDMWMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUDMWMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:12:33 -0400
Received: from pD953265E.dip.t-dialin.net ([217.83.38.94]:21517 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263795AbUDMWM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:12:26 -0400
Date: Tue, 13 Apr 2004 22:02:30 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [3/3]
Message-ID: <20040413220230.D7047@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040413215833.A7047@Marvin.DL8BCU.ampr.org> <20040413215932.B7047@Marvin.DL8BCU.ampr.org> <20040413220109.C7047@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040413220109.C7047@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, Apr 13, 2004 at 10:01:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3/3	use CLOCK_TICK_RATE where 1193182 constant was used in timing 
	calculations



diff -urN linux-2.6.5-2a/drivers/input/joystick/analog.c linux-2.6.5-3a/drivers/input/joystick/analog.c
--- linux-2.6.5-2a/drivers/input/joystick/analog.c	Sun Apr 11 14:24:48 2004
+++ linux-2.6.5-3a/drivers/input/joystick/analog.c	Tue Apr 13 18:38:03 2004
@@ -142,7 +142,7 @@
 
 #ifdef __i386__
 #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
-#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193182L/HZ:0)))
+#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?CLOCK_TICK_RATE/HZ:0)))
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
 {
diff -urN linux-2.6.5-2a/sound/oss/pas2_pcm.c linux-2.6.5-3a/sound/oss/pas2_pcm.c
--- linux-2.6.5-2a/sound/oss/pas2_pcm.c	Thu Dec 18 02:58:28 2003
+++ linux-2.6.5-3a/sound/oss/pas2_pcm.c	Tue Apr 13 18:39:22 2004
@@ -17,6 +17,7 @@
 
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <asm/timex.h>
 #include "sound_config.h"
 
 #include "pas2.h"
@@ -62,13 +63,13 @@
 
 	if (pcm_channels & 2)
 	{
-		foo = (596590 + (arg / 2)) / arg;
-		arg = (596590 + (foo / 2)) / foo;
+		foo = ((CLOCK_TICK_RATE/2) + (arg / 2)) / arg;
+		arg = ((CLOCK_TICK_RATE/2) + (foo / 2)) / foo;
 	}
 	else
 	{
-		foo = (1193180 + (arg / 2)) / arg;
-		arg = (1193180 + (foo / 2)) / foo;
+		foo = (CLOCK_TICK_RATE + (arg / 2)) / arg;
+		arg = (CLOCK_TICK_RATE + (foo / 2)) / foo;
 	}
 
 	pcm_speed = arg;

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
