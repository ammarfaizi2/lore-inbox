Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbTCSMXK>; Wed, 19 Mar 2003 07:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSMUz>; Wed, 19 Mar 2003 07:20:55 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:50056 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263003AbTCSMSh>;
	Wed, 19 Mar 2003 07:18:37 -0500
Date: Wed, 19 Mar 2003 13:29:38 +0100 (MET)
Message-Id: <200303191229.h2JCTck01000@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k timekeeping update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k timekeeping: Do not update the RTC every 11 minutes, since this confuses
NTP (the actual code has been commented out since a while).

--- linux-2.5.x/arch/m68k/kernel/time.c	Wed Mar  5 10:06:39 2003
+++ linux-m68k-2.5.x/arch/m68k/kernel/time.c	Wed Mar  5 10:26:04 2003
@@ -59,35 +59,11 @@
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
-	/*
-	 * This code hopefully becomes obsolete in 2.5 or earlier
-	 * Should it ever be reenabled it must be serialized with
-	 * genrtc.c operation
-	 */
-#if 0
-	if ((time_status & STA_UNSYNC) == 0 &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) tick) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) tick) / 2) {
-	  if (set_rtc_mmss(xtime.tv_sec) == 0)
-	    last_rtc_update = xtime.tv_sec;
-	  else
-	    last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
-	}
-#endif
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
