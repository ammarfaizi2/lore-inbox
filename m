Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263024AbTCWLRM>; Sun, 23 Mar 2003 06:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbTCWLRM>; Sun, 23 Mar 2003 06:17:12 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:64815 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263024AbTCWLRJ>; Sun, 23 Mar 2003 06:17:09 -0500
Date: Sun, 23 Mar 2003 12:26:02 +0100
Message-Id: <200303231126.h2NBQ25G009820@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k timekeeping update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k timekeeping: Do not update the RTC every 11 minutes, since this confuses
NTP (from 2.5.x).

--- linux-2.4.x/arch/m68k/kernel/time.c	Thu Jan  4 22:00:55 2001
+++ linux-m68k-2.4.x/arch/m68k/kernel/time.c	Tue Mar  4 17:10:38 2003
@@ -55,28 +55,11 @@
  */
 static void timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
-	/* last time the cmos clock got updated */
-	static long last_rtc_update=0;
-
 	do_timer(regs);
 
 	if (!user_mode(regs))
 		do_profile(regs->pc);
 
-	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
-	 * called as close as possible to 500 ms before the new second starts.
-	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
-	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-	  if (set_rtc_mmss(xtime.tv_sec) == 0)
-	    last_rtc_update = xtime.tv_sec;
-	  else
-	    last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
-	}
 #ifdef CONFIG_HEARTBEAT
 	/* use power LED as a heartbeat instead -- much more useful
 	   for debugging -- based on the version for PReP by Cort */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
