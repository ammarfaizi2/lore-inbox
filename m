Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUENX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUENX4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUENXyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:54:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:26341 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264546AbUENXaA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:00 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773582979@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <10845773583580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.14, 2004/05/11 13:45:12-07:00, R.S.Bultje@students.uu.nl

[PATCH] I2C: new i2c video decoder calls: saa7111 driver

Attached patch implements the i2c calls in the saa7111 driver.

The driver is still compatible with old behaviour, so the zr36067 driver
(the original user of the saa7111 module) doesn't need any changes.  I'll
probably gradually make everything use DECODER_INIT instead of 0 (that was
a nice hack back then) somewhere later.

Can I just remove '0' later on? Or are there official ABI rules for
stable kernel versions?


 drivers/media/video/saa7111.c |   59 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 54 insertions(+), 5 deletions(-)


diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	Fri May 14 16:19:12 2004
+++ b/drivers/media/video/saa7111.c	Fri May 14 16:19:12 2004
@@ -9,6 +9,9 @@
  * Changes by Ronald Bultje <rbultje@ronald.bitfreak.net>
  *    - moved over to linux>=2.4.x i2c protocol (1/1/2003)
  *
+ * Changes by Michael Hunold <michael@mihu.de>
+ *    - implemented DECODER_SET_GPIO, DECODER_INIT, DECODER_SET_VBI_BYPASS
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -112,7 +115,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
@@ -142,6 +145,13 @@
 	return ret;
 }
 
+static int
+saa7111_init_decoder (struct i2c_client *client,
+	      struct video_decoder_init *init)
+{
+	return saa7111_write_block(client, init->data, init->len);
+}
+
 static inline int
 saa7111_read (struct i2c_client *client,
 	      u8                 reg)
@@ -151,7 +161,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-static const unsigned char init[] = {
+static const unsigned char saa7111_i2c_init[] = {
 	0x00, 0x00,		/* 00 - ID byte */
 	0x01, 0x00,		/* 01 - reserved */
 
@@ -201,8 +211,18 @@
 	switch (cmd) {
 
 	case 0:
-		//saa7111_write_block(client, init, sizeof(init));
-		break;
+	case DECODER_INIT:
+	{
+		struct video_decoder_init *init = arg;
+		if (NULL != init)
+			return saa7111_init_decoder(client, init);
+		else {
+			struct video_decoder_init vdi;
+			vdi.data = saa7111_i2c_init;
+			vdi.len = sizeof(saa7111_i2c_init);
+			return saa7111_init_decoder(client, &vdi);
+		}
+	}
 
 	case DECODER_DUMP:
 	{
@@ -274,6 +294,32 @@
 	}
 		break;
 
+	case DECODER_SET_GPIO:
+	{
+		int *iarg = arg;
+		if (0 != *iarg) {
+			saa7111_write(client, 0x11,
+				(decoder->reg[0x11] | 0x80));
+		} else {
+			saa7111_write(client, 0x11,
+				(decoder->reg[0x11] & 0x7f));
+		}
+		break;
+	}
+
+	case DECODER_SET_VBI_BYPASS:
+	{
+		int *iarg = arg;
+		if (0 != *iarg) {
+			saa7111_write(client, 0x13,
+				(decoder->reg[0x13] & 0xf0) | 0x0a);
+		} else {
+			saa7111_write(client, 0x13,
+				(decoder->reg[0x13] & 0xf0));
+		}
+		break;
+	}
+
 	case DECODER_SET_NORM:
 	{
 		int *iarg = arg;
@@ -465,6 +511,7 @@
 	int i;
 	struct i2c_client *client;
 	struct saa7111 *decoder;
+	struct video_decoder_init vdi;
 
 	dprintk(1,
 		KERN_INFO
@@ -509,7 +556,9 @@
 		return i;
 	}
 
-	i = saa7111_write_block(client, init, sizeof(init));
+	vdi.data = saa7111_i2c_init;
+	vdi.len = sizeof(saa7111_i2c_init);
+	i = saa7111_init_decoder(client, &vdi);
 	if (i < 0) {
 		dprintk(1, KERN_ERR "%s_attach error: init status %d\n",
 			I2C_NAME(client), i);

