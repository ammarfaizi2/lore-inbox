Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUDMIsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUDMIsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:48:15 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:21575 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263281AbUDMIiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:24 -0400
Date: Tue, 13 Apr 2004 10:38:17 +0200
Message-Id: <200404130838.i3D8cHP9018491@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 436] M68k time update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update time adjustment code cfr. other architectures.
(perhaps do_gettimeofday() is a good candidate for consolidation across archs?)

--- linux-2.6.5/arch/m68k/kernel/time.c	2004-02-29 09:30:37.000000000 +0100
+++ linux-m68k-2.6.5/arch/m68k/kernel/time.c	2004-04-08 10:38:42.000000000 +0200
@@ -120,14 +120,28 @@
 	extern unsigned long wall_jiffies;
 	unsigned long seq;
 	unsigned long usec, sec, lost;
+	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 
 		usec = mach_gettimeoffset();
 		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000/HZ);
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(time_adjust < 0)) {
+			usec = min(usec, max_ntp_tick);
+
+			if (lost)
+				usec += lost * max_ntp_tick;
+		}
+		else if (unlikely(lost))
+			usec += lost * tick_usec;
+
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec/1000;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
