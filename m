Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUBFXSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUBFXSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:18:46 -0500
Received: from SMTP1.andrew.cmu.edu ([128.2.10.81]:29127 "EHLO
	smtp1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265821AbUBFXRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:17:48 -0500
Message-ID: <40242092.5090904@andrew.cmu.edu>
Date: Fri, 06 Feb 2004 18:17:38 -0500
From: Peter Nelson <pnelson@andrew.cmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "iuri.f" <iuri.f@terra.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>, vojtech <vojtech@suse.cz>,
       linux-joystick <linux-joystick@atrey.karlin.mff.cuni.cz>
Subject: Re: [PATCH] PSX support in input/joystick/gamecon.c
References: <HSOEWO$7C844976F840E6CB6B3C3C4530825AF6@terra.com.br>
In-Reply-To: <HSOEWO$7C844976F840E6CB6B3C3C4530825AF6@terra.com.br>
Content-Type: multipart/mixed;
 boundary="------------020101060800030300070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101060800030300070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

iuri.f wrote:

>Looks nice, any chance of a 2.4.22+ kernel patch? 
>  
>
Thanks.  I haven't booted into 2.4 for months now and for some reason it 
doesn't want to boot back into it.  Anyway here is a port of the current 
driver back to 2.4, keeping the 2.4 irq stuff and some things like 
that.  It compiles fine and should run, but can you test it?  Also 
vojtech should take a look at some of the name/comment changes but since 
there will be no more features in 2.4 I'm sure this will never be 
applied officially.

-Peter

--------------020101060800030300070806
Content-Type: text/x-patch;
 name="gamecon.2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon.2.4.diff"

diff -uprN -X dontdiff kernel-source-2.4.24.orig/Documentation/input/joystick-parport.txt kernel-source-2.4.24/Documentation/input/joystick-parport.txt
--- kernel-source-2.4.24.orig/Documentation/input/joystick-parport.txt	2004-02-06 14:02:03.000000000 -0500
+++ kernel-source-2.4.24/Documentation/input/joystick-parport.txt	2004-02-06 14:02:53.000000000 -0500
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
diff -uprN -X dontdiff kernel-source-2.4.24.orig/drivers/char/joystick/gamecon.c kernel-source-2.4.24/drivers/char/joystick/gamecon.c
--- kernel-source-2.4.24.orig/drivers/char/joystick/gamecon.c	2004-02-06 14:02:06.000000000 -0500
+++ kernel-source-2.4.24/drivers/char/joystick/gamecon.c	2004-02-06 16:39:03.000000000 -0500
@@ -1,17 +1,16 @@
 /*
- * $Id: gamecon.c,v 1.14 2001/04/29 22:42:14 vojtech Exp $
+ * $Id: gamecon.c,v 1.22 2002/07/01 15:42:25 vojtech Exp $
  *
  *  Copyright (c) 1999-2001 Vojtech Pavlik
  *
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
  *  	David Kuder		Nathan Hand
- *
- *  Sponsored by SuSE
+ * 	Peter Nelson
  */
 
 /*
- * NES, SNES, N64, Multi1, Multi2, PSX gamepad driver for Linux
+ * NES, SNES, N64, MultiSystem, PSX gamepad driver for Linux
  */
 
 /*
@@ -30,8 +29,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
- * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
@@ -41,11 +40,15 @@
 #include <linux/parport.h>
 #include <linux/input.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("NES, SNES, N64, MultiSystem, PSX gamepad driver");
 MODULE_LICENSE("GPL");
+
 MODULE_PARM(gc, "2-6i");
 MODULE_PARM(gc_2,"2-6i");
 MODULE_PARM(gc_3,"2-6i");
+MODULE_PARM(gc_psx_delay, "i");
+MODULE_PARM(gc_psx_ddr, "i");
 
 #define GC_SNES		1
 #define GC_NES		2
@@ -213,7 +216,7 @@ static void gc_multi_read_packet(struct 
  *	
  */
 
-#define GC_PSX_DELAY	60		/* 60 usec */
+#define GC_PSX_DELAY	25		/* 25 usec */
 #define GC_PSX_LENGTH	8		/* talk to the controller in bytes */
 
 #define GC_PSX_MOUSE	1		/* Mouse */
@@ -223,35 +226,41 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
 
 #define GC_PSX_CLOCK	0x04		/* Pin 4 */
-#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_COMMAND	0x01		/* Pin 2 */
 #define GC_PSX_POWER	0xf8		/* Pins 5-9 */
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
+static int gc_psx_delay = GC_PSX_DELAY;
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
-		udelay(GC_PSX_DELAY);
-		data |= ((parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX]) ? (1 << i) : 0;
+		udelay(gc_psx_delay);
+		read = parport_read_status(gc->pd->port) ^ 0x80;
+		for (j = 0; j < 5; j++)
+			data[j] |= (read & gc_status_bit[j] & gc->pads[GC_PSX]) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
-		udelay(GC_PSX_DELAY);
+		udelay(gc_psx_delay);
 	}
-	return data;
 }
 
 /*
@@ -259,31 +268,40 @@ static int gc_psx_command(struct gc *gc,
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
-	udelay(GC_PSX_DELAY * 2);
+	udelay(gc_psx_delay);
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_POWER);			/* Deselect, begin command */
-	udelay(GC_PSX_DELAY * 2);
+	udelay(gc_psx_delay);
 
 	__save_flags(flags);
 	__cli();
 
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
 
 	__restore_flags(flags);
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);
 
-	return GC_PSX_ID(id);
+	for(i = 0; i < 5; i++)								/* Set id's to the real value */
+		id[i] = GC_PSX_ID(id[i]);
 }
 
 /*
@@ -297,6 +315,7 @@ static void gc_timer(unsigned long priva
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_LENGTH];
 	int i, j, s;
 
 /*
@@ -389,46 +408,62 @@ static void gc_timer(unsigned long priva
 
 	if (gc->pads[GC_PSX]) {
 
-		for (i = 0; i < 5; i++)
-	       		if (gc->pads[GC_PSX] & gc_status_bit[i])
-				break;
-
- 		switch (gc_psx_read_packet(gc, data)) {
-
-			case GC_PSX_RUMBLE:
-
-				input_report_key(dev + i, BTN_THUMB,  ~data[0] & 0x04);
-				input_report_key(dev + i, BTN_THUMB2, ~data[0] & 0x02);
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
-				break;
-
-			case GC_PSX_NORMAL:
-
-				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
-
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
+		gc_psx_read_packet(gc, data_psx, data);
 
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+		for (i = 0; i < 5; i++) {
+	 		switch (data[i]) {
+	
+				case GC_PSX_RUMBLE:
+	
+					input_report_key(dev + i, BTN_THUMBL, ~data_psx[i][0] & 0x04);
+					input_report_key(dev + i, BTN_THUMBR, ~data_psx[i][0] & 0x02);
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
+					break;
 
-				break;
+				case 0: /* not a pad, ignore */
+					break;
+			}
 		}
 	}
 
@@ -460,8 +495,7 @@ static struct gc __init *gc_probe(int *c
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx;
-	unsigned char data[32];
+	int i, j;
 
 	if (config[0] < 0)
 		return NULL;
@@ -550,47 +584,26 @@ static struct gc __init *gc_probe(int *c
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
-							" please report to <vojtech@suse.cz>.\n", psx);
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
 
                 gc->dev[i].name = gc_names[config[i + 1]];
+		gc->dev[i].phys = gc->phys[i];
                 gc->dev[i].idbus = BUS_PARPORT;
                 gc->dev[i].idvendor = 0x0001;
                 gc->dev[i].idproduct = config[i + 1];
@@ -608,7 +621,7 @@ static struct gc __init *gc_probe(int *c
 	for (i = 0; i < 5; i++) 
 		if (gc->pads[0] & gc_status_bit[i]) {
 			input_register_device(gc->dev + i);
-			printk(KERN_INFO "input%d: %s on %s\n", gc->dev[i].number, gc->dev[i].name, gc->pd->port->name);
+			printk(KERN_INFO "input: %s on %s\n", gc->dev[i].name, gc->pd->port->name);
 		}
 
 	return gc;
@@ -636,9 +649,21 @@ int __init gc_setup_3(char *str)
 	for (i = 0; i <= ints[0] && i < 6; i++) gc_3[i] = ints[i + 1];
 	return 1;
 }
+int __init gc_psx_setup(char *str)
+{
+        get_option(&str, &gc_psx_delay);
+        return 1;
+}
+int __init gc_psx_ddr(char *str)
+{
+        get_option(&str, &gc_psx_ddr);
+        return 1;
+}
 __setup("gc=", gc_setup);
 __setup("gc_2=", gc_setup_2);
 __setup("gc_3=", gc_setup_3);
+__setup("gc_psx_delay=", gc_psx_setup);
+__setup("gc_psx_ddr=", gc_psx_ddr);
 #endif
 
 int __init gc_init(void)

--------------020101060800030300070806--
