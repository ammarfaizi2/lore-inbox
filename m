Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWJIU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWJIU1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWJIU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:27:45 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:18336 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964823AbWJIU1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:27:44 -0400
Date: Mon, 9 Oct 2006 22:27:42 +0200
Message-Id: <200610092027.k99KRg1B031546@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 604] m68k/MVME167: SERIAL167 tty flip buffer updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile fixes related to changed tty flip buffer handling.

Signed-Off-By: Kars de Jong <jongk@linux-m68k.org>
Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 serial167.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- linux/drivers/char/serial167.c	2006/04/09 22:22:27	1.11
+++ linux/drivers/char/serial167.c	2006/05/21 22:00:37	1.12
@@ -63,6 +63,7 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/tty_flip.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -439,8 +440,9 @@ cd2401_rxerr_interrupt(int irq, void *de
 		       overflowing, we still loose
 		       the next incoming character.
 		     */
-		    tty_insert_flip_char(tty, data, TTY_NORMAL);
-		}
+		    if (tty_buffer_request_room(tty, 1) != 0){
+			tty_insert_flip_char(tty, data, TTY_FRAME);
+		    }
 		/* These two conditions may imply */
 		/* a normal read should be done. */
 		/* else if(data & CyTIMEOUT) */
@@ -449,14 +451,14 @@ cd2401_rxerr_interrupt(int irq, void *de
 		    tty_insert_flip_char(tty, 0, TTY_NORMAL);
 		}
 	    }else{
-		    tty_insert_flip_char(tty, data, TTY_NORMAL);
+		tty_insert_flip_char(tty, data, TTY_NORMAL);
 	    }
 	}else{
 	    /* there was a software buffer overrun
 	       and nothing could be done about it!!! */
 	}
     }
-    schedule_delayed_work(&tty->flip.work, 1);
+    tty_schedule_flip(tty);
     /* end of service */
     base_addr[CyREOIR] = rfoc ? 0 : CyNOTRANS;
     return IRQ_HANDLED;
@@ -647,6 +649,7 @@ cd2401_rx_interrupt(int irq, void *dev_i
     char data;
     int char_count;
     int save_cnt;
+    int len;
 
     /* determine the channel and change to that context */
     channel = (u_short ) (base_addr[CyLICR] >> 2);
@@ -679,14 +682,15 @@ cd2401_rx_interrupt(int irq, void *dev_i
 	    info->mon.char_max = char_count;
 	info->mon.char_last = char_count;
 #endif
-	while(char_count--){
+	len = tty_buffer_request_room(tty, char_count);
+	while(len--){
 	    data = base_addr[CyRDR];
 	    tty_insert_flip_char(tty, data, TTY_NORMAL);
 #ifdef CYCLOM_16Y_HACK
 	    udelay(10L);
 #endif
         }
-	schedule_delayed_work(&tty->flip.work, 1);
+	tty_schedule_flip(tty);
     }
     /* end of service */
     base_addr[CyREOIR] = save_cnt ? 0 : CyNOTRANS;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
