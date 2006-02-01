Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWBAFJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWBAFJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWBAFJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:14 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:24753 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030332AbWBAFJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:04 -0500
Message-Id: <20060201050734.663575000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 12/18] gamecon: fix crash when accessing device
Content-Disposition: inline; filename=gamecon-oops-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: gamecon - fix crash when accessing device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/gamecon.c |  339 ++++++++++++++++++++++-----------------
 1 files changed, 192 insertions(+), 147 deletions(-)

Index: work/drivers/input/joystick/gamecon.c
===================================================================
--- work.orig/drivers/input/joystick/gamecon.c
+++ work/drivers/input/joystick/gamecon.c
@@ -159,6 +159,48 @@ static void gc_n64_read_packet(struct gc
 
 }
 
+static void gc_n64_process_packet(struct gc *gc)
+{
+	unsigned char data[GC_N64_LENGTH];
+	signed char axes[2];
+	struct input_dev *dev;
+	int i, j, s;
+
+	gc_n64_read_packet(gc, data);
+
+	for (i = 0; i < GC_MAX_DEVICES; i++) {
+
+		dev = gc->dev[i];
+		if (!dev)
+			continue;
+
+		s = gc_status_bit[i];
+
+		if (s & gc->pads[GC_N64] & ~(data[8] | data[9])) {
+
+			axes[0] = axes[1] = 0;
+
+			for (j = 0; j < 8; j++) {
+				if (data[23 - j] & s)
+					axes[0] |= 1 << j;
+				if (data[31 - j] & s)
+					axes[1] |= 1 << j;
+			}
+
+			input_report_abs(dev, ABS_X,  axes[0]);
+			input_report_abs(dev, ABS_Y, -axes[1]);
+
+			input_report_abs(dev, ABS_HAT0X, !(s & data[6]) - !(s & data[7]));
+			input_report_abs(dev, ABS_HAT0Y, !(s & data[4]) - !(s & data[5]));
+
+			for (j = 0; j < 10; j++)
+				input_report_key(dev, gc_n64_btn[j], s & data[gc_n64_bytes[j]]);
+
+			input_sync(dev);
+		}
+	}
+}
+
 /*
  * NES/SNES support.
  */
@@ -198,6 +240,39 @@ static void gc_nes_read_packet(struct gc
 	}
 }
 
+static void gc_nes_process_packet(struct gc *gc)
+{
+	unsigned char data[GC_SNES_LENGTH];
+	struct input_dev *dev;
+	int i, j, s;
+
+	gc_nes_read_packet(gc, gc->pads[GC_SNES] ? GC_SNES_LENGTH : GC_NES_LENGTH, data);
+
+	for (i = 0; i < GC_MAX_DEVICES; i++) {
+
+		dev = gc->dev[i];
+		if (!dev)
+			continue;
+
+		s = gc_status_bit[i];
+
+		if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
+			input_report_abs(dev, ABS_X, !(s & data[6]) - !(s & data[7]));
+			input_report_abs(dev, ABS_Y, !(s & data[4]) - !(s & data[5]));
+		}
+
+		if (s & gc->pads[GC_NES])
+			for (j = 0; j < 4; j++)
+				input_report_key(dev, gc_snes_btn[j], s & data[gc_nes_bytes[j]]);
+
+		if (s & gc->pads[GC_SNES])
+			for (j = 0; j < 8; j++)
+				input_report_key(dev, gc_snes_btn[j], s & data[gc_snes_bytes[j]]);
+
+		input_sync(dev);
+	}
+}
+
 /*
  * Multisystem joystick support
  */
@@ -219,6 +294,35 @@ static void gc_multi_read_packet(struct 
 	}
 }
 
+static void gc_multi_process_packet(struct gc *gc)
+{
+	unsigned char data[GC_MULTI2_LENGTH];
+	struct input_dev *dev;
+	int i, s;
+
+	gc_multi_read_packet(gc, gc->pads[GC_MULTI2] ? GC_MULTI2_LENGTH : GC_MULTI_LENGTH, data);
+
+	for (i = 0; i < GC_MAX_DEVICES; i++) {
+
+		dev = gc->dev[i];
+		if (!dev)
+			continue;
+
+		s = gc_status_bit[i];
+
+		if (s & (gc->pads[GC_MULTI] | gc->pads[GC_MULTI2])) {
+			input_report_abs(dev, ABS_X,  !(s & data[2]) - !(s & data[3]));
+			input_report_abs(dev, ABS_Y,  !(s & data[0]) - !(s & data[1]));
+			input_report_key(dev, BTN_TRIGGER, s & data[4]);
+		}
+
+		if (s & gc->pads[GC_MULTI2])
+			input_report_key(dev, BTN_THUMB, s & data[5]);
+
+		input_sync(dev);
+	}
+}
+
 /*
  * PSX support
  *
@@ -263,10 +367,11 @@ static short gc_psx_ddr_btn[] = { BTN_0,
  * the psx pad.
  */
 
-static void gc_psx_command(struct gc *gc, int b, unsigned char data[5])
+static void gc_psx_command(struct gc *gc, int b, unsigned char data[GC_MAX_DEVICES])
 {
 	int i, j, cmd, read;
-	for (i = 0; i < 5; i++)
+
+	for (i = 0; i < GC_MAX_DEVICES; i++)
 		data[i] = 0;
 
 	for (i = 0; i < GC_PSX_LENGTH; i++, b >>= 1) {
@@ -274,7 +379,7 @@ static void gc_psx_command(struct gc *gc
 		parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
 		udelay(gc_psx_delay);
 		read = parport_read_status(gc->pd->port) ^ 0x80;
-		for (j = 0; j < 5; j++)
+		for (j = 0; j < GC_MAX_DEVICES; j++)
 			data[j] |= (read & gc_status_bit[j] & (gc->pads[GC_PSX] | gc->pads[GC_DDR])) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
 		udelay(gc_psx_delay);
@@ -286,11 +391,12 @@ static void gc_psx_command(struct gc *gc
  * device identifier code.
  */
 
-static void gc_psx_read_packet(struct gc *gc, unsigned char data[5][GC_PSX_BYTES], unsigned char id[5])
+static void gc_psx_read_packet(struct gc *gc, unsigned char data[GC_MAX_DEVICES][GC_PSX_BYTES],
+			       unsigned char id[GC_MAX_DEVICES])
 {
 	int i, j, max_len = 0;
 	unsigned long flags;
-	unsigned char data2[5];
+	unsigned char data2[GC_MAX_DEVICES];
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);	/* Select pad */
 	udelay(gc_psx_delay);
@@ -303,7 +409,7 @@ static void gc_psx_read_packet(struct gc
 	gc_psx_command(gc, 0x42, id);							/* Get device ids */
 	gc_psx_command(gc, 0, data2);							/* Dump status */
 
-	for (i =0; i < 5; i++)								/* Find the longest pad */
+	for (i =0; i < GC_MAX_DEVICES; i++)								/* Find the longest pad */
 		if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR]))
 			&& (GC_PSX_LEN(id[i]) > max_len)
 			&& (GC_PSX_LEN(id[i]) <= GC_PSX_BYTES))
@@ -311,7 +417,7 @@ static void gc_psx_read_packet(struct gc
 
 	for (i = 0; i < max_len; i++) {						/* Read in all the data */
 		gc_psx_command(gc, 0, data2);
-		for (j = 0; j < 5; j++)
+		for (j = 0; j < GC_MAX_DEVICES; j++)
 			data[j][i] = data2[j];
 	}
 
@@ -319,185 +425,124 @@ static void gc_psx_read_packet(struct gc
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);
 
-	for(i = 0; i < 5; i++)								/* Set id's to the real value */
+	for(i = 0; i < GC_MAX_DEVICES; i++)								/* Set id's to the real value */
 		id[i] = GC_PSX_ID(id[i]);
 }
 
-/*
- * gc_timer() reads and analyzes console pads data.
- */
-
-#define GC_MAX_LENGTH GC_N64_LENGTH
-
-static void gc_timer(unsigned long private)
+static void gc_psx_process_packet(struct gc *gc)
 {
-	struct gc *gc = (void *) private;
-	unsigned char data[GC_MAX_LENGTH];
-	unsigned char data_psx[5][GC_PSX_BYTES];
-	int i, j, s;
-
-/*
- * N64 pads - must be read first, any read confuses them for 200 us
- */
-
-	if (gc->pads[GC_N64]) {
+	unsigned char data[GC_MAX_DEVICES][GC_PSX_BYTES];
+	unsigned char id[GC_MAX_DEVICES];
+	struct input_dev *dev;
+	int i, j;
 
-		gc_n64_read_packet(gc, data);
+	gc_psx_read_packet(gc, data, id);
 
-		for (i = 0; i < 5; i++) {
+	for (i = 0; i < GC_MAX_DEVICES; i++) {
 
-			s = gc_status_bit[i];
+		dev = gc->dev[i];
+		if (!dev)
+			continue;
 
-			if (s & gc->pads[GC_N64] & ~(data[8] | data[9])) {
+		switch (id[i]) {
 
-				signed char axes[2];
-				axes[0] = axes[1] = 0;
+			case GC_PSX_RUMBLE:
 
-				for (j = 0; j < 8; j++) {
-					if (data[23 - j] & s) axes[0] |= 1 << j;
-					if (data[31 - j] & s) axes[1] |= 1 << j;
-				}
+				input_report_key(dev, BTN_THUMBL, ~data[i][0] & 0x04);
+				input_report_key(dev, BTN_THUMBR, ~data[i][0] & 0x02);
 
-				input_report_abs(gc->dev[i], ABS_X,  axes[0]);
-				input_report_abs(gc->dev[i], ABS_Y, -axes[1]);
+			case GC_PSX_NEGCON:
+			case GC_PSX_ANALOG:
 
-				input_report_abs(gc->dev[i], ABS_HAT0X, !(s & data[6]) - !(s & data[7]));
-				input_report_abs(gc->dev[i], ABS_HAT0Y, !(s & data[4]) - !(s & data[5]));
+				if (gc->pads[GC_DDR] & gc_status_bit[i]) {
+					for(j = 0; j < 4; j++)
+						input_report_key(dev, gc_psx_ddr_btn[j], ~data[i][0] & (0x10 << j));
+				} else {
+					for (j = 0; j < 4; j++)
+						input_report_abs(dev, gc_psx_abs[j + 2], data[i][j + 2]);
 
-				for (j = 0; j < 10; j++)
-					input_report_key(gc->dev[i], gc_n64_btn[j], s & data[gc_n64_bytes[j]]);
+					input_report_abs(dev, ABS_X, 128 + !(data[i][0] & 0x20) * 127 - !(data[i][0] & 0x80) * 128);
+					input_report_abs(dev, ABS_Y, 128 + !(data[i][0] & 0x40) * 127 - !(data[i][0] & 0x10) * 128);
+				}
 
-				input_sync(gc->dev[i]);
-			}
-		}
-	}
+				for (j = 0; j < 8; j++)
+					input_report_key(dev, gc_psx_btn[j], ~data[i][1] & (1 << j));
 
-/*
- * NES and SNES pads
- */
+				input_report_key(dev, BTN_START,  ~data[i][0] & 0x08);
+				input_report_key(dev, BTN_SELECT, ~data[i][0] & 0x01);
 
-	if (gc->pads[GC_NES] || gc->pads[GC_SNES]) {
+				input_sync(dev);
 
-		gc_nes_read_packet(gc, gc->pads[GC_SNES] ? GC_SNES_LENGTH : GC_NES_LENGTH, data);
+				break;
 
-		for (i = 0; i < 5; i++) {
+			case GC_PSX_NORMAL:
+				if (gc->pads[GC_DDR] & gc_status_bit[i]) {
+					for(j = 0; j < 4; j++)
+						input_report_key(dev, gc_psx_ddr_btn[j], ~data[i][0] & (0x10 << j));
+				} else {
+					input_report_abs(dev, ABS_X, 128 + !(data[i][0] & 0x20) * 127 - !(data[i][0] & 0x80) * 128);
+					input_report_abs(dev, ABS_Y, 128 + !(data[i][0] & 0x40) * 127 - !(data[i][0] & 0x10) * 128);
+
+					/* for some reason if the extra axes are left unset they drift */
+					/* for (j = 0; j < 4; j++)
+						input_report_abs(dev, gc_psx_abs[j + 2], 128);
+					 * This needs to be debugged properly,
+					 * maybe fuzz processing needs to be done in input_sync()
+					 *				 --vojtech
+					 */
+				}
 
-			s = gc_status_bit[i];
+				for (j = 0; j < 8; j++)
+					input_report_key(dev, gc_psx_btn[j], ~data[i][1] & (1 << j));
 
-			if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
-				input_report_abs(gc->dev[i], ABS_X, !(s & data[6]) - !(s & data[7]));
-				input_report_abs(gc->dev[i], ABS_Y, !(s & data[4]) - !(s & data[5]));
-			}
+				input_report_key(dev, BTN_START,  ~data[i][0] & 0x08);
+				input_report_key(dev, BTN_SELECT, ~data[i][0] & 0x01);
 
-			if (s & gc->pads[GC_NES])
-				for (j = 0; j < 4; j++)
-					input_report_key(gc->dev[i], gc_snes_btn[j], s & data[gc_nes_bytes[j]]);
+				input_sync(dev);
 
-			if (s & gc->pads[GC_SNES])
-				for (j = 0; j < 8; j++)
-					input_report_key(gc->dev[i], gc_snes_btn[j], s & data[gc_snes_bytes[j]]);
+				break;
 
-			input_sync(gc->dev[i]);
+			case 0: /* not a pad, ignore */
+				break;
 		}
 	}
+}
 
 /*
- * Multi and Multi2 joysticks
+ * gc_timer() initiates reads of console pads data.
  */
 
-	if (gc->pads[GC_MULTI] || gc->pads[GC_MULTI2]) {
+static void gc_timer(unsigned long private)
+{
+	struct gc *gc = (void *) private;
 
-		gc_multi_read_packet(gc, gc->pads[GC_MULTI2] ? GC_MULTI2_LENGTH : GC_MULTI_LENGTH, data);
+/*
+ * N64 pads - must be read first, any read confuses them for 200 us
+ */
 
-		for (i = 0; i < 5; i++) {
+	if (gc->pads[GC_N64])
+		gc_n64_process_packet(gc);
 
-			s = gc_status_bit[i];
+/*
+ * NES and SNES pads
+ */
 
-			if (s & (gc->pads[GC_MULTI] | gc->pads[GC_MULTI2])) {
-				input_report_abs(gc->dev[i], ABS_X,  !(s & data[2]) - !(s & data[3]));
-				input_report_abs(gc->dev[i], ABS_Y,  !(s & data[0]) - !(s & data[1]));
-				input_report_key(gc->dev[i], BTN_TRIGGER, s & data[4]);
-			}
+	if (gc->pads[GC_NES] || gc->pads[GC_SNES])
+		gc_nes_process_packet(gc);
 
-			if (s & gc->pads[GC_MULTI2])
-				input_report_key(gc->dev[i], BTN_THUMB, s & data[5]);
+/*
+ * Multi and Multi2 joysticks
+ */
 
-			input_sync(gc->dev[i]);
-		}
-	}
+	if (gc->pads[GC_MULTI] || gc->pads[GC_MULTI2])
+		gc_multi_process_packet(gc);
 
 /*
  * PSX controllers
  */
 
-	if (gc->pads[GC_PSX] || gc->pads[GC_DDR]) {
-
-		gc_psx_read_packet(gc, data_psx, data);
-
-		for (i = 0; i < 5; i++) {
-			switch (data[i]) {
-
-				case GC_PSX_RUMBLE:
-
-					input_report_key(gc->dev[i], BTN_THUMBL, ~data_psx[i][0] & 0x04);
-					input_report_key(gc->dev[i], BTN_THUMBR, ~data_psx[i][0] & 0x02);
-
-				case GC_PSX_NEGCON:
-				case GC_PSX_ANALOG:
-
-					if (gc->pads[GC_DDR] & gc_status_bit[i]) {
-						for(j = 0; j < 4; j++)
-							input_report_key(gc->dev[i], gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
-					} else {
-						for (j = 0; j < 4; j++)
-							input_report_abs(gc->dev[i], gc_psx_abs[j+2], data_psx[i][j + 2]);
-
-						input_report_abs(gc->dev[i], ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
-						input_report_abs(gc->dev[i], ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
-					}
-
-					for (j = 0; j < 8; j++)
-						input_report_key(gc->dev[i], gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
-
-					input_report_key(gc->dev[i], BTN_START,  ~data_psx[i][0] & 0x08);
-					input_report_key(gc->dev[i], BTN_SELECT, ~data_psx[i][0] & 0x01);
-
-					input_sync(gc->dev[i]);
-
-					break;
-
-				case GC_PSX_NORMAL:
-					if (gc->pads[GC_DDR] & gc_status_bit[i]) {
-						for(j = 0; j < 4; j++)
-							input_report_key(gc->dev[i], gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
-					} else {
-						input_report_abs(gc->dev[i], ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
-						input_report_abs(gc->dev[i], ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
-
-						/* for some reason if the extra axes are left unset they drift */
-						/* for (j = 0; j < 4; j++)
-							input_report_abs(gc->dev[i], gc_psx_abs[j+2], 128);
-						 * This needs to be debugged properly,
-						 * maybe fuzz processing needs to be done in input_sync()
-						 *				 --vojtech
-						 */
-					}
-
-					for (j = 0; j < 8; j++)
-						input_report_key(gc->dev[i], gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
-
-					input_report_key(gc->dev[i], BTN_START,  ~data_psx[i][0] & 0x08);
-					input_report_key(gc->dev[i], BTN_SELECT, ~data_psx[i][0] & 0x01);
-
-					input_sync(gc->dev[i]);
-
-					break;
-
-				case 0: /* not a pad, ignore */
-					break;
-			}
-		}
-	}
+	if (gc->pads[GC_PSX] || gc->pads[GC_DDR])
+		gc_psx_process_packet(gc);
 
 	mod_timer(&gc->timer, jiffies + GC_REFRESH_TIME);
 }
@@ -654,7 +699,7 @@ static struct gc __init *gc_probe(int pa
 	gc->timer.data = (long) gc;
 	gc->timer.function = gc_timer;
 
-	for (i = 0; i < n_pads; i++) {
+	for (i = 0; i < n_pads && i < GC_MAX_DEVICES; i++) {
 		if (!pads[i])
 			continue;
 

