Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSL0QEI>; Fri, 27 Dec 2002 11:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0QEG>; Fri, 27 Dec 2002 11:04:06 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:28766 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265065AbSL0QDg>; Fri, 27 Dec 2002 11:03:36 -0500
Date: Fri, 27 Dec 2002 17:11:12 +0100
Message-Id: <200212271611.gBRGBCV8008047@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k parport local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k parport drivers to new local_irq*() framework:
  - Atari parport

--- linux-2.5.53/drivers/parport/parport_atari.c	Tue Oct  9 10:54:48 2001
+++ linux-m68k-2.5.53/drivers/parport/parport_atari.c	Thu Nov  7 23:09:56 2002
@@ -25,11 +25,10 @@
 	unsigned long flags;
 	unsigned char data;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	sound_ym.rd_data_reg_sel = 15;
 	data = sound_ym.rd_data_reg_sel;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return data;
 }
 
@@ -38,11 +37,10 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	sound_ym.rd_data_reg_sel = 15;
 	sound_ym.wd_data = data;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static unsigned char
@@ -51,12 +49,11 @@
 	unsigned long flags;
 	unsigned char control = 0;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	sound_ym.rd_data_reg_sel = 14;
 	if (!(sound_ym.rd_data_reg_sel & (1 << 5)))
 		control = PARPORT_CONTROL_STROBE;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return control;
 }
 
@@ -65,14 +62,13 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	sound_ym.rd_data_reg_sel = 14;
 	if (control & PARPORT_CONTROL_STROBE)
 		sound_ym.wd_data = sound_ym.rd_data_reg_sel & ~(1 << 5);
 	else
 		sound_ym.wd_data = sound_ym.rd_data_reg_sel | (1 << 5);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static unsigned char
@@ -129,12 +125,11 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/* Soundchip port B as output. */
 	sound_ym.rd_data_reg_sel = 7;
 	sound_ym.wd_data = sound_ym.rd_data_reg_sel | 0x40;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void
@@ -143,12 +138,11 @@
 #if 0 /* too dangerous, can kill sound chip */
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/* Soundchip port B as input. */
 	sound_ym.rd_data_reg_sel = 7;
 	sound_ym.wd_data = sound_ym.rd_data_reg_sel & ~0x40;
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 }
 
@@ -209,15 +203,14 @@
 	unsigned long flags;
 
 	if (MACH_IS_ATARI) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		/* Soundchip port A/B as output. */
 		sound_ym.rd_data_reg_sel = 7;
 		sound_ym.wd_data = (sound_ym.rd_data_reg_sel & 0x3f) | 0xc0;
 		/* STROBE high. */
 		sound_ym.rd_data_reg_sel = 14;
 		sound_ym.wd_data = sound_ym.rd_data_reg_sel | (1 << 5);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		/* MFP port I0 as input. */
 		mfp.data_dir &= ~1;
 		/* MFP port I0 interrupt on high->low edge. */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
