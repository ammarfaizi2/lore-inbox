Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbULLU2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbULLU2T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbULLU1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:27:52 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:7609 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S262117AbULLU0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:26:09 -0500
Message-ID: <41BCA915.3030407@tremplin-utc.net>
Date: Sun, 12 Dec 2004 21:24:53 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
CC: decklin@red-bean.com, Peter Nelson <rufus-kernel@hackish.org>
Subject: [PATCH] Hotplug support for several PSX controlers
Content-Type: multipart/mixed;
 boundary="------------000501060206090409070607"
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501060206090409070607
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Since 2.6.9, several PSX controlers in the same time can be supported. 
However, because of a bug, if not all the PSX controlers are pluged in 
then nothing works. Typically, you load gamecon with options saying that 
you have two PSX adapter ports and then you plug and unplug has many 
controllers has you want. There is a bug which prevent keypress to be 
detected when not all the controllers connected.

The problem was that when a port didn't have a controler pluged the 
packet length to receive was read as very big, leading to a kind of 
buffer overflow. This patch checks the packet length and if it is bigger 
than the theoritical possible it considers that there is no controller 
pluged on this port.

It probably works on a vanilla 2.6.10-rc3 but I highly recommand to use 
the Vojtech's tree which contains an important fix about PSX DDR (cf 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110118014804716&w=2).

I've heard that Linus wants 2.6.10 ready for Christmas, this patch 
should definitetly helps ;-)

Eric

--------------000501060206090409070607
Content-Type: text/x-patch;
 name="gamecon-psx-hotplug-clamp-length.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon-psx-hotplug-clamp-length.patch"

--- linux-2.6.10.orig/drivers/input/joystick/gamecon.c	2004-10-20 21:25:06.000000000 +0200
+++ linux-2.6.10-rc3/drivers/input/joystick/gamecon.c	2004-12-12 14:58:35.000000000 +0100
@@ -241,7 +241,7 @@ static void gc_multi_read_packet(struct 
 #define GC_PSX_SELECT	0x02		/* Pin 3 */
 
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
-#define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
+#define GC_PSX_LEN(x)	(((x) & 0xf) << 1)	/* Low nibble is length in words */
 
 static int gc_psx_delay = GC_PSX_DELAY;
 module_param_named(psx_delay, gc_psx_delay, uint, 0);
@@ -259,7 +259,7 @@ static short gc_psx_ddr_btn[] = { BTN_0,
  * the psx pad.
  */
 
-static void gc_psx_command(struct gc *gc, int b, unsigned char data[GC_PSX_LENGTH])
+static void gc_psx_command(struct gc *gc, int b, unsigned char data[5])
 {
 	int i, j, cmd, read;
 	for (i = 0; i < 5; i++)
@@ -302,10 +302,12 @@ static void gc_psx_read_packet(struct gc
 
 	for (i =0; i < 5; i++)								/* Find the longest pad */
 		if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR])) &&
-			       	(GC_PSX_LEN(id[i]) > max_len))
+			       	(GC_PSX_LEN(id[i]) > max_len) &&
+				/* Too long length is a sign that no joystick is present */
+			       	(GC_PSX_LEN(id[i]) <= GC_PSX_LENGTH))			
 			max_len = GC_PSX_LEN(id[i]);
 
-	for (i = 0; i < max_len * 2; i++) {						/* Read in all the data */
+	for (i = 0; i < max_len; i++) {						/* Read in all the data */
 		gc_psx_command(gc, 0, data2);
 		for (j = 0; j < 5; j++)
 			data[j][i] = data2[j];

--------------000501060206090409070607--
