Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKGRfd>; Tue, 7 Nov 2000 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKGRfY>; Tue, 7 Nov 2000 12:35:24 -0500
Received: from ns1.metabyte.com ([216.218.208.34]:23302 "EHLO ns1.metabyte.com")
	by vger.kernel.org with ESMTP id <S129055AbQKGRfF>;
	Tue, 7 Nov 2000 12:35:05 -0500
From: Pete Zaitcev <zaitcev@metabyte.com>
Message-Id: <200011071735.JAA06929@ns1.metabyte.com>
Subject: Patch to DECODER_SET_NORM invocations
To: linux-kernel@vger.kernel.org
Date: Tue, 7 Nov 2000 09:35:03 -0800 (PST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the recent 2.2.x I discovered that saa7xxx driver expects norm
to be an int, while struct video_channel defines it as __u16.
This bombs if video_channel has something dirty next to it
on the stack.

Only one file is touched by the patch: drivers/char/buz.c, but
some more code is related. The unofficial patch for capture on
Netwinder (drivers/char/video-cyberpro.c) is broken. The bttv.c
is not affected (it has on-chip decoder instead of saa7xxx).
Pauline's Zoran patch is not affected (is uses int).

I am expiriencing difficulties identifying the maintainer of the code.
Alan, would you look at it please?

Greetings,
--Pete

diff -ur linux-2.2.18-pre19/drivers/char/buz.c linux-2.2.18-pre19-p3/drivers/char/buz.c
--- linux-2.2.18-pre19/drivers/char/buz.c	Wed May  3 17:16:33 2000
+++ linux-2.2.18-pre19-p3/drivers/char/buz.c	Tue Nov  7 08:43:58 2000
@@ -2389,7 +2389,7 @@
 	case VIDIOCSCHAN:
 		{
 			struct video_channel v;
-			int input;
+			int input, norm;
 			int on, res;
 
 			if (copy_from_user(&v, arg, sizeof(v))) {
@@ -2421,9 +2421,10 @@
 			if (on)
 				zr36057_overlay(zr, 0);
 
+			norm = zr->params.norm;
 			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_INPUT, &input);
-			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &zr->params.norm);
-			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &zr->params.norm);
+			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &norm);
+			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &norm);
 
 			if (on)
 				zr36057_overlay(zr, 1);
@@ -2781,7 +2782,7 @@
 	case BUZIOC_S_PARAMS:
 		{
 			struct zoran_params bp;
-			int input, on;
+			int input, on, norm;
 
 			if (zr->codec_mode != BUZ_MODE_IDLE) {
 				return -EINVAL;
@@ -2808,9 +2809,10 @@
 				zr36057_overlay(zr, 0);
 
 			input = zr->params.input == 0 ? 3 : 7;
+			norm = zr->params.norm;
 			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_INPUT, &input);
-			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &zr->params.norm);
-			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &zr->params.norm);
+			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &norm);
+			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &norm);
 
 			if (on)
 				zr36057_overlay(zr, 1);
@@ -2939,8 +2941,9 @@
 
 			/* restore previous input and norm */
 			input = zr->params.input == 0 ? 3 : 7;
+			norm = zr->params.norm;
 			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_INPUT, &input);
-			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &zr->params.norm);
+			i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &norm);
 
 			if (copy_to_user(arg, &bs, sizeof(bs))) {
 				return -EFAULT;
@@ -3252,8 +3255,9 @@
 
 	j = zr->params.input == 0 ? 3 : 7;
 	i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_INPUT, &j);
-	i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &zr->params.norm);
-	i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &zr->params.norm);
+	j = zr->params.norm;
+	i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &j);
+	i2c_control_device(&zr->i2c, I2C_DRIVERID_VIDEOENCODER, ENCODER_SET_NORM, &j);
 
 	/* set individual interrupt enables (without GIRQ0)
 	   but don't global enable until zoran_open() */


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
