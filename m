Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUBQHja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUBQHja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:39:30 -0500
Received: from SMTP3.andrew.cmu.edu ([128.2.10.83]:15315 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S261827AbUBQHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:39:15 -0500
Message-ID: <4031C521.40203@andrew.cmu.edu>
Date: Tue, 17 Feb 2004 02:39:13 -0500
From: Peter Nelson <pnelson@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Nelson <pnelson@andrew.cmu.edu>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PSX support in input/joystick/gamecon.c
References: <20040215222107.720832C2CC@lists.samba.org> <4031AB8D.1040209@andrew.cmu.edu> <200402170108.07271.dtor_core@ameritech.net> <4031BB44.4080306@andrew.cmu.edu>
In-Reply-To: <4031BB44.4080306@andrew.cmu.edu>
Content-Type: multipart/mixed;
 boundary="------------060109000103020901020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109000103020901020409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Nelson wrote:

> Dmitry Torokhov wrote:
>
>> Nitpick: module_param, if module is compiled in, adds a prefix to 
>> parameter
>>
>> names, so the parameters will be:
>> gamecon.gc
>> gamecon.gc_2
>> gamecon.gc_3
>> gamecon.gc_psx_delay
>> gamecon.gc_psx_ddr
>>
>> At least with PSX stuff it would be nice to drop gc_ prefix.  
>>
> Hopefully my last patch submission related to this file, here's an 
> updated one using module_param_named so the external name is just psx_ 
> (I'm leaving the internal name as gc_psx_ just for consistency with 
> the rest of the file).
>
> Thanks for the feedback,
> -Peter

Helps if I actually attach the patch.

-Peter

--------------060109000103020901020409
Content-Type: text/x-patch;
 name="gamecon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon.diff"

diff -uprN -X dontdiff linux-2.6.2.orig/Documentation/input/joystick-parport.txt linux-2.6.2/Documentation/input/joystick-parport.txt
--- linux-2.6.2.orig/Documentation/input/joystick-parport.txt	2004-02-15 23:30:53.000000000 -0500
+++ linux-2.6.2/Documentation/input/joystick-parport.txt	2004-02-17 01:38:15.000000000 -0500
@@ -453,8 +453,16 @@ uses the following kernel/module command
 	  6  | N64 pad
 	  7  | Sony PSX controller
 
-  The exact type of the PSX controller type is autoprobed, so you must have
-your controller plugged in before initializing.
+  The exact type of the PSX controller type is autoprobed with use so hot
+swapping should work.  There are two options specifically for PSX controllers:
+
+  psx_delay=usec
+    The delay time between controller reads, default is 25 usec. Some users have
+    reported improved responsiveness at 10 usec.
+
+  psx_ddr=1
+    Register directions events as buttons instead of axes.  Usefull for Dance
+    Dance Revolution emulators so up and down can be pressed at once.
 
   Should you want to use more than one of parallel ports at once, you can use
 gc_2 and gc_3 as additional command line parameters for two more parallel
diff -uprN -X dontdiff linux-2.6.2.orig/drivers/input/joystick/gamecon.c linux-2.6.2/drivers/input/joystick/gamecon.c
--- linux-2.6.2.orig/drivers/input/joystick/gamecon.c	2004-02-15 23:30:55.000000000 -0500
+++ linux-2.6.2/drivers/input/joystick/gamecon.c	2004-02-17 01:35:15.000000000 -0500
@@ -6,6 +6,7 @@
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
  *  	David Kuder		Nathan Hand
+ * 	Peter Nelson
  */
 
 /*
@@ -35,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/parport.h>
 #include <linux/input.h>
@@ -43,11 +45,6 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
 MODULE_DESCRIPTION("NES, SNES, N64, MultiSystem, PSX gamepad driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(gc, "2-6i");
-MODULE_PARM(gc_2,"2-6i");
-MODULE_PARM(gc_3,"2-6i");
-MODULE_PARM(gc_psx_delay, "i");
-
 #define GC_SNES		1
 #define GC_NES		2
 #define GC_NES4		3
@@ -71,9 +68,12 @@ struct gc {
 
 static struct gc *gc_base[3];
 
-static int gc[] __initdata = { -1, 0, 0, 0, 0, 0 };
-static int gc_2[] __initdata = { -1, 0, 0, 0, 0, 0 };
-static int gc_3[] __initdata = { -1, 0, 0, 0, 0, 0 };
+static int gc[6] __initdata;
+static int gc_2[6] __initdata;
+static int gc_3[6] __initdata;
+static int gc_count __initdata;
+static int gc_2_count __initdata;
+static int gc_3_count __initdata;
 
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
@@ -224,7 +224,7 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
 
 #define GC_PSX_CLOCK	0x04		/* Pin 4 */
-#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_COMMAND	0x01		/* Pin 2 */
 #define GC_PSX_POWER	0xf8		/* Pins 5-9 */
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
@@ -232,28 +232,33 @@ static void gc_multi_read_packet(struct 
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
@@ -261,30 +266,39 @@ static int gc_psx_command(struct gc *gc,
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
@@ -298,6 +312,7 @@ static void gc_timer(unsigned long priva
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_LENGTH];
 	int i, j, s;
 
 /*
@@ -396,51 +411,67 @@ static void gc_timer(unsigned long priva
 
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
+		gc_psx_read_packet(gc, data_psx, data);
 
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
 
@@ -472,8 +503,7 @@ static struct gc __init *gc_probe(int *c
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx;
-	unsigned char data[32];
+	int i, j;
 
 	if (config[0] < 0)
 		return NULL;
@@ -562,43 +592,21 @@ static struct gc __init *gc_probe(int *c
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
 
@@ -629,44 +637,20 @@ static struct gc __init *gc_probe(int *c
 	return gc;
 }
 
-#ifndef MODULE
-static int __init gc_setup(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_setup_2(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc_2[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_setup_3(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc_3[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_psx_setup(char *str)
-{
-        get_option(&str, &gc_psx_delay);
-        return 1;
-}
-__setup("gc=", gc_setup);
-__setup("gc_2=", gc_setup_2);
-__setup("gc_3=", gc_setup_3);
-__setup("gc_psx_delay=", gc_psx_setup);
-#endif
+module_param_array(gc, int, gc_count, 0);
+module_param_array(gc_2, int, gc_2_count, 0);
+module_param_array(gc_3, int, gc_3_count, 0);
+module_param_named(psx_delay, gc_psx_delay, int, 0);
+module_param_named(psx_ddr, gc_psx_ddr, int, 0);
 
 int __init gc_init(void)
 {
-	gc_base[0] = gc_probe(gc);
-	gc_base[1] = gc_probe(gc_2);
-	gc_base[2] = gc_probe(gc_3);
+	if(gc_count)
+		gc_base[0] = gc_probe(gc);
+	if(gc_2_count)
+		gc_base[1] = gc_probe(gc_2);
+	if(gc_3_count)
+		gc_base[2] = gc_probe(gc_3);
 
 	if (gc_base[0] || gc_base[1] || gc_base[2])
 		return 0;

--------------060109000103020901020409--
