Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUFLAEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUFLAEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUFLAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:04:22 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:49833 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S264401AbUFLAD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:03:59 -0400
Message-ID: <40CA4867.6030501@andrew.cmu.edu>
Date: Fri, 11 Jun 2004 20:03:51 -0400
From: Peter Nelson <pnelson+kernel@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vojtech@suse.cz
Subject: [PATCH] improved PSX support in input/joystick/gamecon.c
Content-Type: multipart/mixed;
 boundary="------------070401000201030904070804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401000201030904070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I posted this patch a while ago for 2.6.2 and have gotten some good user 
feedback, but none so far from Vojtech Pavlik, the joystick maintainer.  
I've updated the patch for 2.6.6 and am interested any input.  Here's a 
summary of what it does again:

    * Adds support for more than one controller. Previously more than
      one controller was initialized and the docs said they worked, but
      only one was actually read.
    * Removes unnecessary detection on initialization. This allows the
      module to be initialized without controllers plugged in (hot
      swapping controllers works). This removes a warning if the user
      has an unrecognized controller plugged in, but the only
      unrecognized controller I have been able to find information about
      online is the PSX mouse, which I've never actually seen.
    * Adds a psx_ddr option to have direction presses register as
      buttons instead of axes. Allows the module to be used for Dance
      Dance Revolution emulators like Stepmania.
    * Adds psx_* to documentation.

As before, I've tested this with a DDR pay, a dualshock, and a clone 
digital controller.  I also have a bit of a writeup on my website:
http://rufus.hackish.org/wiki/gamecon

-Peter Nelson

--------------070401000201030904070804
Content-Type: text/plain;
 name="gamecon-2.6.6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon-2.6.6.diff"

--- linux-2.6.6.orig/Documentation/input/joystick-parport.txt	2004-05-29 01:31:01.000000000 -0400
+++ linux-2.6.6/Documentation/input/joystick-parport.txt	2004-06-11 19:26:55.000000000 -0400
@@ -453,13 +453,21 @@ uses the following kernel/module command
 	  6  | N64 pad
 	  7  | Sony PSX controller
 
-  The exact type of the PSX controller type is autoprobed, so you must have
-your controller plugged in before initializing.
+  The exact type of the PSX controller type is autoprobed when used so 
+hot swapping should work (but is not recomended).
 
   Should you want to use more than one of parallel ports at once, you can use
 gamecon.map2 and gamecon.map3 as additional command line parameters for two
 more parallel ports.
 
+  There are two options specific to PSX driver portion.  
+gamecon.psx_delay sets the command delay when talking to the 
+controllers.  The default of 25 should work but you can try lowering it for 
+better performace.  If your pads don't respond try raising it untill 
+they work.  gamecon.psx_ddr allows the driver to be for Dance Dance 
+Revolution or similar games.  Arrow keys are registered as key presses 
+instead of on axes.
+
 3.2 db9.c
 ~~~~~~~~~
   Apart from making an interface, there is nothing difficult on using the
diff -uprN -X dontdiff linux-2.6.6.orig/drivers/input/joystick/gamecon.c linux-2.6.6/drivers/input/joystick/gamecon.c
--- linux-2.6.6.orig/drivers/input/joystick/gamecon.c	2004-05-29 01:30:52.000000000 -0400
+++ linux-2.6.6/drivers/input/joystick/gamecon.c	2004-06-09 00:12:51.000000000 -0400
@@ -6,6 +6,7 @@
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
  *  	David Kuder		Nathan Hand
+ * 	Peter Nelson
  */
 
 /*
@@ -237,7 +238,7 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
 
 #define GC_PSX_CLOCK	0x04		/* Pin 4 */
-#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_COMMAND	0x01		/* Pin 2 */
 #define GC_PSX_POWER	0xf8		/* Pins 5-9 */
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
@@ -250,28 +251,36 @@ MODULE_PARM_DESC(psx_delay, "Delay when 
 
 __obsolete_setup("gc_psx_delay=");
 
+static int gc_psx_ddr = 0;
+module_param_named(psx_ddr, gc_psx_ddr, uint, 0);
+MODULE_PARM_DESC(psx_ddr, "DDR mode for direction pad (as unique buttons instead of axis)");
+
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
@@ -279,30 +288,39 @@ static int gc_psx_command(struct gc *gc,
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
@@ -316,6 +334,7 @@ static void gc_timer(unsigned long priva
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_LENGTH];
 	int i, j, s;
 
 /*
@@ -414,51 +433,67 @@ static void gc_timer(unsigned long priva
 
 	if (gc->pads[GC_PSX]) {
 
-		for (i = 0; i < 5; i++)
-	       		if (gc->pads[GC_PSX] & gc_status_bit[i])
-				break;
-
- 		switch (gc_psx_read_packet(gc, data)) {
-
-			case GC_PSX_RUMBLE:
-
-				input_report_key(dev + i, BTN_THUMBL, ~data[0] & 0x04);
-				input_report_key(dev + i, BTN_THUMBR, ~data[0] & 0x02);
-				input_sync(dev + i);
-
-			case GC_PSX_NEGCON:
-			case GC_PSX_ANALOG:
-
-				for (j = 0; j < 4; j++)
-					input_report_abs(dev + i, gc_psx_abs[j], data[j + 2]);
-
-				input_report_abs(dev + i, ABS_HAT0X, !(data[0] & 0x20) - !(data[0] & 0x80));
-				input_report_abs(dev + i, ABS_HAT0Y, !(data[0] & 0x40) - !(data[0] & 0x10));
-
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
-
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
-
-				input_sync(dev + i);
-
-				break;
-
-			case GC_PSX_NORMAL:
-
-				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
+		gc_psx_read_packet(gc, data_psx, data);
 
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
-
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
-
-				input_sync(dev + i);
+		for (i = 0; i < 5; i++) {
+	 		switch (data[i]) {
+	
+				case GC_PSX_RUMBLE:
+	
+					input_report_key(dev + i, BTN_THUMBL, ~data_psx[i][0] & 0x04);
+					input_report_key(dev + i, BTN_THUMBR, ~data_psx[i][0] & 0x02);
+					input_sync(dev + i);
+	
+				case GC_PSX_NEGCON:
+				case GC_PSX_ANALOG:
+	
+					if(gc_psx_ddr == 1) {
+						for(j = 0; j < 4; j++)
+							input_report_key(dev + i, gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
+					} else {
+						for (j = 0; j < 4; j++)
+							input_report_abs(dev + i, gc_psx_abs[j+2], data_psx[i][j + 2]);
+	
+						input_report_abs(dev + i, ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
+						input_report_abs(dev + i, ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
+					}
+					
+					for (j = 0; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
+	
+					input_report_key(dev + i, BTN_START,  ~data_psx[i][0] & 0x08);
+					input_report_key(dev + i, BTN_SELECT, ~data_psx[i][0] & 0x01);
+	
+					input_sync(dev + i);
+	
+					break;
+	
+				case GC_PSX_NORMAL:
+					if(gc_psx_ddr == 1) {
+						for(j = 0; j < 4; j++)
+							input_report_key(dev + i, gc_psx_ddr_btn[j], ~data_psx[i][0] & (0x10 << j));
+					} else {
+						input_report_abs(dev + i, ABS_X, 128 + !(data_psx[i][0] & 0x20) * 127 - !(data_psx[i][0] & 0x80) * 128);
+						input_report_abs(dev + i, ABS_Y, 128 + !(data_psx[i][0] & 0x40) * 127 - !(data_psx[i][0] & 0x10) * 128);
+
+						/* for some reason if the extra axes are left unset they drift */
+						for (j = 0; j < 4; j++)
+							input_report_abs(dev + i, gc_psx_abs[j+2], 128);
+					}
+
+					for (j = 0; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data_psx[i][1] & (1 << j));
+					
+					input_report_key(dev + i, BTN_START,  ~data_psx[i][0] & 0x08);
+					input_report_key(dev + i, BTN_SELECT, ~data_psx[i][0] & 0x01);
+	
+					input_sync(dev + i);
+	
+					break;
 
-				break;
+				case 0: /* not a pad, ignore */
+					break;
+			}
 		}
 	}
 
@@ -490,8 +525,7 @@ static struct gc __init *gc_probe(int *c
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx;
-	unsigned char data[32];
+	int i, j;
 
 	if (config[0] < 0)
 		return NULL;
@@ -588,43 +622,21 @@ static struct gc __init *gc_probe(int *c
 				break;
 
 			case GC_PSX:
-				
-				psx = gc_psx_read_packet(gc, data);
-
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
+				if(gc_psx_ddr == 1) {
+					for (j = 0; j < 4; j++)
+						set_bit(gc_psx_ddr_btn[j], gc->dev[i].keybit);
+				} else {
+					for (j = 0; j < 6; j++) {
+						set_bit(gc_psx_abs[j], gc->dev[i].absbit);
+						gc->dev[i].absmin[gc_psx_abs[j]] = 4;
+						gc->dev[i].absmax[gc_psx_abs[j]] = 252;
+						gc->dev[i].absflat[gc_psx_abs[j]] = 2;
+					}
 				}
+						
+				for (j = 0; j < 12; j++)
+					set_bit(gc_psx_btn[j], gc->dev[i].keybit);
+
 				break;
 		}
 

--------------070401000201030904070804--
