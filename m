Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSL0QGW>; Fri, 27 Dec 2002 11:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0QEO>; Fri, 27 Dec 2002 11:04:14 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:48157 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265066AbSL0QDg>; Fri, 27 Dec 2002 11:03:36 -0500
Date: Fri, 27 Dec 2002 17:11:09 +0100
Message-Id: <200212271611.gBRGB9BR008017@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] BVME6000 core local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert core BVME6000 code to new local_irq*() framework

--- linux-2.5.53/arch/m68k/bvme6000/rtc.c	Fri Jul 19 11:06:49 2002
+++ linux-m68k-2.5.53/arch/m68k/bvme6000/rtc.c	Thu Nov  7 22:03:47 2002
@@ -49,8 +49,7 @@
 	switch (cmd) {
 	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
 	{
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		/* Ensure clock and real-time-mode-register are accessible */
 		msr = rtc->msr & 0xc0;
 		rtc->msr = 0x40;
@@ -66,7 +65,7 @@
 			wtime.tm_wday = BCD2BIN(rtc->bcd_dow)-1;
 		} while (wtime.tm_sec != BCD2BIN(rtc->bcd_sec));
 		rtc->msr = msr;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return copy_to_user((void *)arg, &wtime, sizeof wtime) ?
 								-EFAULT : 0;
 	}
@@ -106,8 +105,7 @@
 		if (yrs >= 2070)
 			return -EINVAL;
 		
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		/* Ensure clock and real-time-mode-register are accessible */
 		msr = rtc->msr & 0xc0;
 		rtc->msr = 0x40;
@@ -125,7 +123,7 @@
 		rtc->t0cr_rtmr = yrs%4 | 0x08;
 
 		rtc->msr = msr;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	}
 	default:
--- linux-2.5.53/arch/m68k/bvme6000/config.c	Fri Aug 30 15:37:40 2002
+++ linux-m68k-2.5.53/arch/m68k/bvme6000/config.c	Thu Nov  7 22:03:41 2002
@@ -358,8 +358,7 @@
 		? real_minutes - rtc_minutes
 			: rtc_minutes - real_minutes) < 30)
 	{
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		rtc_tenms = rtc->bcd_tenms;
 		while (rtc_tenms == rtc->bcd_tenms)
 			;
@@ -367,7 +366,7 @@
 			;
 		rtc->bcd_min = bin2bcd(real_minutes);
 		rtc->bcd_sec = bin2bcd(real_seconds);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	else
 		retval = -1;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
