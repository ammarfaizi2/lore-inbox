Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUG2ObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUG2ObQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUG2Oa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:30:56 -0400
Received: from styx.suse.cz ([82.119.242.94]:25494 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264936AbUG2OIM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:12 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 25/47] Enhancements/fixes for PSX pad support
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101953521@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101954037@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.11, 2004-06-21 08:35:20+02:00, pnelson@andrew.cmu.edu
  input: Enhancements/fixes for PSX pad support:
  
      * Adds support for more than one controller. Previously more than
        one controller was initialized and the docs said they worked, but
        only one was actually read.                                      
      * Removes unnecessary detection on initialization. This allows the
        module to be initialized without controllers plugged in (hot    
        swapping controllers works). This removes a warning if the user
        has an unrecognized controller plugged in, but the only        
        unrecognized controller I have been able to find information about
        online is the PSX mouse, which I've never actually seen.          
      * Adds a GC_DDR option value to have direction presses register as
        buttons instead of axes. Allows the module to be used for Dance
        Dance Revolution emulators like Stepmania.                     
      * Adds psx_* to documentation.   
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>           


 Documentation/input/joystick-parport.txt |   13 +-
 drivers/input/joystick/gamecon.c         |  192 ++++++++++++++++---------------
 2 files changed, 112 insertions(+), 93 deletions(-)

===================================================================

diff -Nru a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.txt
--- a/Documentation/input/joystick-parport.txt	Thu Jul 29 14:40:19 2004
+++ b/Documentation/input/joystick-parport.txt	Thu Jul 29 14:40:19 2004
@@ -335,6 +335,7 @@
  * Analog PSX Pad (red mode)
  * Analog PSX Pad (green mode)
  * PSX Rumble Pad
+ * PSX DDR Pad
 
 2.4 Sega
 ~~~~~~~~
@@ -452,13 +453,21 @@
 	  5  | Multisystem 2-button joystick
 	  6  | N64 pad
 	  7  | Sony PSX controller
+	  8  | Sony PSX DDR controller
 
-  The exact type of the PSX controller type is autoprobed, so you must have
-your controller plugged in before initializing.
+  The exact type of the PSX controller type is autoprobed when used so
+hot swapping should work (but is not recomended).
 
   Should you want to use more than one of parallel ports at once, you can use
 gamecon.map2 and gamecon.map3 as additional command line parameters for two
 more parallel ports.
+
+  There are two options specific to PSX driver portion.  gamecon.psx_delay sets
+the command delay when talking to the controllers. The default of 25 should
+work but you can try lowering it for better performace. If your pads don't
+respond try raising it untill they work. Setting the type to 8 allows the
+driver to be used with Dance Dance Revolution or similar games. Arrow keys are
+registered as key presses instead of X and Y axes.
 
 3.2 db9.c
 ~~~~~~~~~
diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Thu Jul 29 14:40:19 2004
+++ b/drivers/input/joystick/gamecon.c	Thu Jul 29 14:40:19 2004
@@ -1,7 +1,8 @@
 /*
- * $Id: gamecon.c,v 1.22 2002/07/01 15:42:25 vojtech Exp $
+ * NES, SNES, N64, MultiSystem, PSX gamepad driver for Linux
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ *  Copyright (c) 1999-2004 	Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2004 		Peter Nelson <pnelson@andrew.cmu.edu>
  *
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
@@ -9,10 +10,6 @@
  */
 
 /*
- * NES, SNES, N64, MultiSystem, PSX gamepad driver for Linux
- */
-
-/*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -72,8 +69,9 @@
 #define GC_MULTI2	5
 #define GC_N64		6
 #define GC_PSX		7
+#define GC_DDR		8
 
-#define GC_MAX		7
+#define GC_MAX		8
 
 #define GC_REFRESH_TIME	HZ/100
 
@@ -91,7 +89,8 @@
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
-				"Multisystem 2-button joystick", "N64 controller", "PSX controller" };
+				"Multisystem 2-button joystick", "N64 controller", "PSX controller"
+				"PSX DDR controller" };
 /*
  * N64 support.
  */
@@ -237,7 +236,7 @@
 #define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
 
 #define GC_PSX_CLOCK	0x04		/* Pin 4 */
-#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_COMMAND	0x01		/* Pin 2 */
 #define GC_PSX_POWER	0xf8		/* Pins 5-9 */
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
@@ -253,25 +252,29 @@
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
 				BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR };
+static short gc_psx_ddr_btn[] = { BTN_0, BTN_1, BTN_2, BTN_3 };
 
 /*
  * gc_psx_command() writes 8bit command and reads 8bit data from
  * the psx pad.
  */
 
-static int gc_psx_command(struct gc *gc, int b)
+static void gc_psx_command(struct gc *gc, int b, unsigned char data[GC_PSX_LENGTH])
 {
-	int i, cmd, data = 0;
+	int i, j, cmd, read;
+	for (i = 0; i < 5; i++)
+		data[i] = 0;
 
 	for (i = 0; i < 8; i++, b >>= 1) {
 		cmd = (b & 1) ? GC_PSX_COMMAND : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
 		udelay(gc_psx_delay);
-		data |= ((parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX]) ? (1 << i) : 0;
+		read = parport_read_status(gc->pd->port) ^ 0x80;
+		for (j = 0; j < 5; j++)
+			data[j] |= (read & gc_status_bit[j] & gc->pads[GC_PSX]) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
 		udelay(gc_psx_delay);
 	}
-	return data;
 }
 
 /*
@@ -279,30 +282,39 @@
  * device identifier code.
  */
 
-static int gc_psx_read_packet(struct gc *gc, unsigned char *data)
+static void gc_psx_read_packet(struct gc *gc, unsigned char data[5][GC_PSX_LENGTH], unsigned char id[5])
 {
-	int i, id;
+	int i, j, max_len = 0;
 	unsigned long flags;
+	unsigned char data2[5];
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);	/* Select pad */
-	udelay(gc_psx_delay * 2);
+	udelay(gc_psx_delay);
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_POWER);			/* Deselect, begin command */
-	udelay(gc_psx_delay * 2);
+	udelay(gc_psx_delay);
 
 	local_irq_save(flags);
 
-	gc_psx_command(gc, 0x01);							/* Access pad */
-	id = gc_psx_command(gc, 0x42);							/* Get device id */
-	if (gc_psx_command(gc, 0) == 0x5a) {						/* Okay? */
-		for (i = 0; i < GC_PSX_LEN(id) * 2; i++)
-			data[i] = gc_psx_command(gc, 0);
-	} else id = 0;
+	gc_psx_command(gc, 0x01, data2);						/* Access pad */
+	gc_psx_command(gc, 0x42, id);							/* Get device ids */
+	gc_psx_command(gc, 0, data2);							/* Dump status */
+
+	for (i =0; i < 5; i++)								/* Find the longest pad */
+		if((gc_status_bit[i] & gc->pads[GC_PSX]) && (GC_PSX_LEN(id[i]) > max_len))
+			max_len = GC_PSX_LEN(id[i]);
+
+	for (i = 0; i < max_len * 2; i++) {						/* Read in all the data */
+		gc_psx_command(gc, 0, data2);
+		for (j = 0; j < 5; j++)
+			data[j][i] = data2[j];
+	}
 
 	local_irq_restore(flags);
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);
 
-	return GC_PSX_ID(id);
+	for(i = 0; i < 5; i++)								/* Set id's to the real value */
+		id[i] = GC_PSX_ID(id[i]);
 }
 
 /*
@@ -316,6 +328,7 @@
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_LENGTH];
 	int i, j, s;
 
 /*
@@ -412,53 +425,72 @@
  * PSX controllers
  */
 
-	if (gc->pads[GC_PSX]) {
+	if (gc->pads[GC_PSX] || gc->pads[GC_DDR]) {
 
-		for (i = 0; i < 5; i++)
-	       		if (gc->pads[GC_PSX] & gc_status_bit[i])
-				break;
+		gc_psx_read_packet(gc, data_psx, data);
 
- 		switch (gc_psx_read_packet(gc, data)) {
+		for (i = 0; i < 5; i++) {
+	 		switch (data[i]) {
 
-			case GC_PSX_RUMBLE:
+				case GC_PSX_RUMBLE:
 
-				input_report_key(dev + i, BTN_THUMBL, ~data[0] & 0x04);
-				input_report_key(dev + i, BTN_THUMBR, ~data[0] & 0x02);
-				input_sync(dev + i);
+					input_report_key(dev + i, BTN_THUMBL, ~data_psx[i][0] & 0x04);
+					input_report_key(dev + i, BTN_THUMBR, ~data_psx[i][0] & 0x02);
 
-			case GC_PSX_NEGCON:
-			case GC_PSX_ANALOG:
+				case GC_PSX_NEGCON:
+				case GC_PSX_ANALOG:
 
-				for (j = 0; j < 4; j++)
-					input_report_abs(dev + i, gc_psx_abs[j], data[j + 2]);
+					if(gc->pads[GC_DDR] & gc_status_bit[i]) {
+						for(j = 0; j < 4; j++)
+							input_report_key(dev + i, gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
+					} else {
+						for (j = 0; j < 4; j++)
+							input_report_abs(dev + i, gc_psx_abs[j+2], data_psx[i][j + 2]);
 
-				input_report_abs(dev + i, ABS_HAT0X, !(data[0] & 0x20) - !(data[0] & 0x80));
-				input_report_abs(dev + i, ABS_HAT0Y, !(data[0] & 0x40) - !(data[0] & 0x10));
+						input_report_abs(dev + i, ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
+						input_report_abs(dev + i, ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
+					}
 
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
+					for (j = 0; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
 
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+					input_report_key(dev + i, BTN_START,  ~data_psx[i][0] & 0x08);
+					input_report_key(dev + i, BTN_SELECT, ~data_psx[i][0] & 0x01);
 
-				input_sync(dev + i);
+					input_sync(dev + i);
 
-				break;
+					break;
 
-			case GC_PSX_NORMAL:
+				case GC_PSX_NORMAL:
+					if(gc->pads[GC_DDR] & gc_status_bit[i]) {
+						for(j = 0; j < 4; j++)
+							input_report_key(dev + i, gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
+					} else {
+						input_report_abs(dev + i, ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
+						input_report_abs(dev + i, ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
 
-				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
+						/* for some reason if the extra axes are left unset they drift */
+						/* for (j = 0; j < 4; j++)
+							input_report_abs(dev + i, gc_psx_abs[j+2], 128);
+						 * This needs to be debugged properly,
+						 * maybe fuzz processing needs to be done in input_sync()
+						 *				 --vojtech
+						 */
+					}
 
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
+					for (j = 0; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
 
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+					input_report_key(dev + i, BTN_START,  ~data_psx[i][0] & 0x08);
+					input_report_key(dev + i, BTN_SELECT, ~data_psx[i][0] & 0x01);
 
-				input_sync(dev + i);
+					input_sync(dev + i);
 
-				break;
+					break;
+
+				case 0: /* not a pad, ignore */
+					break;
+			}
 		}
 	}
 
@@ -490,8 +522,7 @@
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx;
-	unsigned char data[32];
+	int i, j;
 
 	if (config[0] < 0)
 		return NULL;
@@ -588,43 +619,22 @@
 				break;
 
 			case GC_PSX:
+			case GC_DDR:
+				if(config[i + 1] == GC_DDR) {
+					for (j = 0; j < 4; j++)
+						set_bit(gc_psx_ddr_btn[j], gc->dev[i].keybit);
+				} else {
+					for (j = 0; j < 6; j++) {
+						set_bit(gc_psx_abs[j], gc->dev[i].absbit);
+						gc->dev[i].absmin[gc_psx_abs[j]] = 4;
+						gc->dev[i].absmax[gc_psx_abs[j]] = 252;
+						gc->dev[i].absflat[gc_psx_abs[j]] = 2;
+					}
+				}
 
-				psx = gc_psx_read_packet(gc, data);
+				for (j = 0; j < 12; j++)
+					set_bit(gc_psx_btn[j], gc->dev[i].keybit);
 
-				switch(psx) {
-					case GC_PSX_NEGCON:
-					case GC_PSX_NORMAL:
-					case GC_PSX_ANALOG:
-					case GC_PSX_RUMBLE:
-
-						for (j = 0; j < 6; j++) {
-							psx = gc_psx_abs[j];
-							set_bit(psx, gc->dev[i].absbit);
-							if (j < 4) {
-								gc->dev[i].absmin[psx] = 4;
-								gc->dev[i].absmax[psx] = 252;
-								gc->dev[i].absflat[psx] = 2;
-							} else {
-								gc->dev[i].absmin[psx] = -1;
-								gc->dev[i].absmax[psx] = 1;
-							}
-						}
-
-						for (j = 0; j < 12; j++)
-							set_bit(gc_psx_btn[j], gc->dev[i].keybit);
-
-						break;
-
-					case 0:
-						gc->pads[GC_PSX] &= ~gc_status_bit[i];
-						printk(KERN_ERR "gamecon.c: No PSX controller found.\n");
-						break;
-
-					default:
-						gc->pads[GC_PSX] &= ~gc_status_bit[i];
-						printk(KERN_WARNING "gamecon.c: Unsupported PSX controller %#x,"
-							" please report to <vojtech@ucw.cz>.\n", psx);
-				}
 				break;
 		}
 

