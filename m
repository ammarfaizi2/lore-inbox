Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUEDVGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUEDVGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbUEDVGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:06:41 -0400
Received: from pD95F30BB.dip.t-dialin.net ([217.95.48.187]:52747 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S264609AbUEDVFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:05:34 -0400
Date: Tue, 4 May 2004 21:05:27 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       ralf@linux-mips.org
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage take 3 [3/3]
Message-ID: <20040504210527.D6663@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
	akpm@osdl.org, ralf@linux-mips.org
References: <20040504210305.A6663@Marvin.DL8BCU.ampr.org> <20040504210359.B6663@Marvin.DL8BCU.ampr.org> <20040504210458.C6663@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040504210458.C6663@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, May 04, 2004 at 09:04:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/3:    use CLOCK_TICK_RATE where 1193180 was used in general timing
        calculations. (optional)


diff -urN linux-2.6.5-2a/drivers/input/joystick/analog.c linux-2.6.5-3a/drivers/input/joystick/analog.c
--- linux-2.6.5-2a/drivers/input/joystick/analog.c	Sun Apr 11 14:24:48 2004
+++ linux-2.6.5-3a/drivers/input/joystick/analog.c	Tue Apr 13 18:38:03 2004
@@ -142,7 +142,7 @@
 
 #ifdef __i386__
 #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
-#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193182L/HZ:0)))
+#define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? CLOCK_TICK_RATE / HZ : 0)))
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
+		foo = ((CLOCK_TICK_RATE / 2) + (arg / 2)) / arg;
+		arg = ((CLOCK_TICK_RATE / 2) + (foo / 2)) / foo;
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
