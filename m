Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDMMzr (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTDMMzr (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:55:47 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:48735 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263493AbTDMMzp (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:55:45 -0400
Date: Sun, 13 Apr 2003 15:04:43 +0200
Message-Id: <200304131304.h3DD4hxp001244@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiflop mod_timer()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga floppy driver: Convert {del,add}_timer() sequences to mod_timer().

--- linux-2.4.x/drivers/block/amiflop.c	Fri Nov  8 18:43:37 2002
+++ linux-m68k-2.4.x/drivers/block/amiflop.c	Sun Mar 16 12:25:58 2003
@@ -366,10 +366,8 @@
 		unit[nr].motor = 1;
 		fd_select(nr);
 
-		del_timer(&motor_on_timer);
 		motor_on_timer.data = nr;
-		motor_on_timer.expires = jiffies + HZ/2;
-		add_timer(&motor_on_timer);
+		mod_timer(&motor_on_timer, jiffies + HZ/2);
 
 		on_attempts = 10;
 		sleep_on (&motor_wait);
@@ -427,11 +425,9 @@
 	int drive;
 
 	drive = nr & 3;
-	del_timer(motor_off_timer + drive);
-	motor_off_timer[drive].expires = jiffies + 3*HZ;
 	/* called this way it is always from interrupt */
 	motor_off_timer[drive].data = nr | 0x80000000;
-	add_timer(motor_off_timer + drive);
+	mod_timer(motor_off_timer + drive, jiffies + 3*HZ);
 }
 
 static int fd_calibrate(int drive)
@@ -1466,10 +1462,7 @@
 
 			unit[drive].dirty = 1;
 		        /* reset the timer */
-		        del_timer (flush_track_timer + drive);
-			    
-			flush_track_timer[drive].expires = jiffies + 1;
-			add_timer (flush_track_timer + drive);
+			mod_timer(flush_track_timer + drive, jiffies + 1);
 			restore_flags (flags);
 			break;
 		}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
