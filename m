Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271508AbVBESXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271508AbVBESXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271505AbVBESXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:23:07 -0500
Received: from mf00.sitadelle.com ([212.94.174.77]:21868 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S271397AbVBESWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:22:11 -0500
Message-ID: <42050EC2.3020402@tremplin-utc.net>
Date: Sat, 05 Feb 2005 19:21:54 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041216)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, rufus-kernel@hackish.org
Subject: [PATCH] hot-swapping support for PSX controllers
Content-Type: multipart/mixed;
 boundary="------------080208050903030004080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208050903030004080702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

For now, a bug in the PSX controllers support in gamecon prevents 
hot-swapping of such controllers. If a controllers is removed then all 
the controllers stop working and cpu usage gets high. The attached patch 
(against 2.6.11-rc3) corrects this bug by checking the information read 
from the controller. If the message length is bigger than the maximum 
possible, then it means the controller is not there and therefore this 
value should be discarded.

Note that this is a re-send of a previous patch now that the patch of 
Peter (which had to be applied before this one) has been intregrated in 
the vanilla kernel. It's Peter's version modified to apply cleanly 
against 2.6.11-rc3 plus a fix in the comment.

Please apply,
Eric

--
Fixes hotplug support for PSX controllers and some mis-sized arrays.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
Signed-off-by: Peter Nelson <rufus-kernel@hackish.org>
--

--------------080208050903030004080702
Content-Type: text/x-patch;
 name="gamecon-psx-hotplug-clamp-length-2.6.11-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon-psx-hotplug-clamp-length-2.6.11-rc3.patch"

--- linux-2.6.11-rc3/drivers/input/joystick/gamecon.c.orig	2005-01-23 00:59:37.000000000 +0100
+++ linux-2.6.11-rc3/drivers/input/joystick/gamecon.c	2005-01-23 01:39:40.000000000 +0100
@@ -227,7 +227,8 @@ static void gc_multi_read_packet(struct 
  */
 
 #define GC_PSX_DELAY	25		/* 25 usec */
-#define GC_PSX_LENGTH	8		/* talk to the controller in bytes */
+#define GC_PSX_LENGTH	8		/* talk to the controller in bits */
+#define GC_PSX_BYTES	6		/* the maximum number of bytes to read off the controller */
 
 #define GC_PSX_MOUSE	1		/* Mouse */
 #define GC_PSX_NEGCON	2		/* NegCon */
@@ -241,7 +242,7 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
-#define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
+#define GC_PSX_LEN(x)	(((x) & 0xf) << 1)	/* Low nibble is length in bytes/2 */
 
 static int gc_psx_delay = GC_PSX_DELAY;
 module_param_named(psx_delay, gc_psx_delay, uint, 0);
@@ -259,13 +260,13 @@ static short gc_psx_ddr_btn[] = { BTN_0,
  * the psx pad.
  */
 
-static void gc_psx_command(struct gc *gc, int b, unsigned char data[GC_PSX_LENGTH])
+static void gc_psx_command(struct gc *gc, int b, unsigned char data[5])
 {
 	int i, j, cmd, read;
 	for (i = 0; i < 5; i++)
 		data[i] = 0;
 
-	for (i = 0; i < 8; i++, b >>= 1) {
+	for (i = 0; i < GC_PSX_LENGTH; i++, b >>= 1) {
 		cmd = (b & 1) ? GC_PSX_COMMAND : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
 		udelay(gc_psx_delay);
@@ -282,7 +283,7 @@ static void gc_psx_command(struct gc *gc
  * device identifier code.
  */
 
-static void gc_psx_read_packet(struct gc *gc, unsigned char data[5][GC_PSX_LENGTH], unsigned char id[5])
+static void gc_psx_read_packet(struct gc *gc, unsigned char data[5][GC_PSX_BYTES], unsigned char id[5])
 {
 	int i, j, max_len = 0;
 	unsigned long flags;
@@ -300,10 +301,12 @@ static void gc_psx_read_packet(struct gc
 	gc_psx_command(gc, 0, data2);							/* Dump status */
 
 	for (i =0; i < 5; i++)								/* Find the longest pad */
-		if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR])) && (GC_PSX_LEN(id[i]) > max_len))
+		if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR]))
+			&& (GC_PSX_LEN(id[i]) > max_len)
+			&& (GC_PSX_LEN(id[i]) <= GC_PSX_BYTES))
 			max_len = GC_PSX_LEN(id[i]);
 
-	for (i = 0; i < max_len * 2; i++) {						/* Read in all the data */
+	for (i = 0; i < max_len; i++) {						/* Read in all the data */
 		gc_psx_command(gc, 0, data2);
 		for (j = 0; j < 5; j++)
 			data[j][i] = data2[j];
@@ -328,7 +331,7 @@ static void gc_timer(unsigned long priva
 	struct gc *gc = (void *) private;
 	struct input_dev *dev = gc->dev;
 	unsigned char data[GC_MAX_LENGTH];
-	unsigned char data_psx[5][GC_PSX_LENGTH];
+	unsigned char data_psx[5][GC_PSX_BYTES];
 	int i, j, s;
 
 /*

--------------080208050903030004080702--
