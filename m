Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbUBFSIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUBFSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:07:45 -0500
Received: from SMTP3.andrew.cmu.edu ([128.2.10.83]:18343 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265588AbUBFSGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:06:54 -0500
Message-ID: <4023D7B9.9010201@andrew.cmu.edu>
Date: Fri, 06 Feb 2004 13:06:49 -0500
From: Peter Nelson <pnelson@andrew.cmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PSX support in input/joystick/gamecon.c
Content-Type: multipart/mixed;
 boundary="------------030403010506060301090306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030403010506060301090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this is my first kernel hack but it's fairly straight froward.  I 
did a partial-rewrite of the PSX support in gamecon.c to make it far 
more usable.  What this patch changes:

   * Adds support for more than one controller.  Previously more than
     one controller was initialized and the docs said they worked, but
     only one was actually read.
   * Removes unnecessary detection on initialization.  This allows the
     module to be initialized without controllers plugged in (hot
     swapping controllers works).  This removes a warning if the user
     has an unrecognized controller plugged in, but the only
     unrecognized controller I have been able to find information about
     online is the PSX mouse, which I've never actually seen.
   * Adds a gc_psx_ddr option to have direction presses register as
     buttons instead of axes.  Allows the module to be used for Dance
     Dance Revolution emulators like Stepmania.
   * Adds gc_psx_* to documentation.

I've tested this with a dualshock 2, clone digital controller, and DDR 
pads.  The patch applies against both 2.6.1 and 2.6.2.

-Peter Nelson

--------------030403010506060301090306
Content-Type: text/x-patch;
 name="docs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="docs.diff"

--- linux-2.6.2/Documentation/input/joystick-parport.txt.org	2004-02-05 02:25:41.000000000 -0500
+++ linux-2.6.2/Documentation/input/joystick-parport.txt	2004-02-05 02:38:24.000000000 -0500
@@ -453,8 +453,16 @@ uses the following kernel/module command
 	  6  | N64 pad
 	  7  | Sony PSX controller
 
-  The exact type of the PSX controller type is autoprobed, so you must have
-your controller plugged in before initializing.
+  The exact type of the PSX controller type is autoprobed with use so hot
+swapping should work.  There are two options specifically for PSX controllers:
+
+  gc_psx_delay=usec
+    The delay time between controller reads, default is 25 usec. Some users have
+    reported improved responsiveness at 10 usec.
+
+  gc_psx_ddr=1
+    Register directions events as buttons instead of axes.  Usefull for Dance
+    Dance Revolution emulators so up and down can be pressed at once.
 
   Should you want to use more than one of parallel ports at once, you can use
 gc_2 and gc_3 as additional command line parameters for two more parallel

--------------030403010506060301090306
Content-Type: text/x-patch;
 name="gamecon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon.diff"

--- linux-2.6.2/drivers/input/joystick/gamecon.c.org	2004-02-06 12:51:14.000000000 -0500
+++ linux-2.6.2/drivers/input/joystick/gamecon.c	2004-02-06 12:52:35.000000000 -0500
@@ -6,6 +6,7 @@
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
  *  	David Kuder		Nathan Hand
+ * 	Peter Nelson
  */
 
 /*
@@ -47,6 +48,7 @@ MODULE_PARM(gc, "2-6i");
 MODULE_PARM(gc_2,"2-6i");
 MODULE_PARM(gc_3,"2-6i");
 MODULE_PARM(gc_psx_delay, "i");
+MODULE_PARM(gc_psx_ddr, "i");
 
 #define GC_SNES		1
 #define GC_NES		2
@@ -224,7 +226,7 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
 
 #define GC_PSX_CLOCK	0x04		/* Pin 4 */
-#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_COMMAND	0x01		/* Pin 2 */
 #define GC_PSX_POWER	0xf8		/* Pins 5-9 */
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
@@ -232,28 +234,33 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
 static int gc_psx_delay = GC_PSX_DELAY;
+static int gc_psx_ddr = 0;
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
@@ -261,30 +268,39 @@ static int gc_psx_command(struct gc *gc,
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
+	gc_psx_command(gc, 0x01, data2);					/* Access pad */
+	gc_psx_command(gc, 0x42, id);						/* Get device ids */
+	gc_psx_command(gc, 0, data2);						/* Dump status */
+	
+	for (i =0; i < 5; i++)								/* Find the longest pad */
+		if((gc_status_bit[i] & gc->pads[GC_PSX]) && (GC_PSX_LEN(id[i]) > max_len))
+			max_len = GC_PSX_LEN(id[i]);
+			
+	for (i = 0; i < max_len * 2; i++) {					/* Read in all the data */
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
@@ -298,6 +314,7 @@ static void gc_timer(unsigned long priva
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_LENGTH];
 	int i, j, s;
 
 /*
@@ -396,51 +413,67 @@ static void gc_timer(unsigned long priva
 
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
-
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
-
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+		gc_psx_read_packet(gc, data_psx, data);
 
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
 
@@ -472,8 +505,7 @@ static struct gc __init *gc_probe(int *c
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx;
-	unsigned char data[32];
+	int i, j;
 
 	if (config[0] < 0)
 		return NULL;
@@ -562,43 +594,21 @@ static struct gc __init *gc_probe(int *c
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
 
@@ -656,10 +666,16 @@ static int __init gc_psx_setup(char *str
         get_option(&str, &gc_psx_delay);
         return 1;
 }
+static int __init gc_psx_ddr(char *str)
+{
+        get_option(&str, &gc_psx_ddr);
+        return 1;
+}
 __setup("gc=", gc_setup);
 __setup("gc_2=", gc_setup_2);
 __setup("gc_3=", gc_setup_3);
 __setup("gc_psx_delay=", gc_psx_setup);
+__setup("gc_psx_ddr=", gc_psx_ddr);
 #endif
 
 int __init gc_init(void)

--------------030403010506060301090306--
