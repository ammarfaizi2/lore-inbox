Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUIQP2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUIQP2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUIQP1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:27:07 -0400
Received: from mail.convergence.de ([212.227.36.84]:21159 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268839AbUIQOnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:43:06 -0400
Message-ID: <414AF7CB.5010100@linuxtv.org>
Date: Fri, 17 Sep 2004 16:42:19 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][14/14] follow saa7146 changes in other drivers
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org> <414AF6B1.9040706@linuxtv.org> <414AF71B.5070702@linuxtv.org> <414AF779.6040409@linuxtv.org>
In-Reply-To: <414AF779.6040409@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------060406060108070800070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060406060108070800070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060406060108070800070301
Content-Type: text/plain;
 name="14-V4L-follow-changes-in-saa7146.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="14-V4L-follow-changes-in-saa7146.diff"

- [V4L] mxb, dpc7146, hexium_orion, hexium_gemini: follow latest changes in saa7146 driver

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -ura a/drivers/media/video/dpc7146.c linux-2.6.8.1-dvb2/drivers/media/video/dpc7146.c
--- a/drivers/media/video/dpc7146.c	2004-09-17 14:35:42.000000000 +0200
+++ linux-2.6.8.1-dvb2/drivers/media/video/dpc7146.c	2004-09-17 14:40:49.000000000 +0200
@@ -79,8 +79,8 @@
 
 struct dpc
 {
-	struct video_device	video_dev;
-	struct video_device	vbi_dev;
+	struct video_device	*video_dev;
+	struct video_device	*vbi_dev;
 
 	struct i2c_adapter	i2c_adapter;	
 	struct i2c_client	*saa7111a;
@@ -106,7 +106,11 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	dpc->i2c_adapter = (struct i2c_adapter) {
+		.class = I2C_CLASS_TV_ANALOG,
+		.name = "dpc7146",
+	};
+	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&dpc->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(dpc);
diff -ura a/drivers/media/video/hexium_gemini.c linux-2.6.8.1-dvb2/drivers/media/video/hexium_gemini.c
--- a/drivers/media/video/hexium_gemini.c	2004-09-17 14:35:36.000000000 +0200
+++ linux-2.6.8.1-dvb2/drivers/media/video/hexium_gemini.c	2004-09-17 14:43:36.000000000 +0200
@@ -78,7 +78,8 @@
 struct hexium
 {
 	int type;
-	struct video_device	video_dev;
+	
+	struct video_device	*video_dev;
 	struct i2c_adapter	i2c_adapter;
 		
 	int 		cur_input;	/* current input */
@@ -250,7 +251,11 @@
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	hexium->i2c_adapter = (struct i2c_adapter) {
+		.class = I2C_CLASS_TV_ANALOG,
+		.name = "hexium gemini",
+	};
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura a/drivers/media/video/hexium_orion.c linux-2.6.8.1-dvb2/drivers/media/video/hexium_orion.c
--- a/drivers/media/video/hexium_orion.c	2004-09-17 14:35:36.000000000 +0200
+++ linux-2.6.8.1-dvb2/drivers/media/video/hexium_orion.c	2004-09-17 14:43:54.000000000 +0200
@@ -68,8 +68,9 @@
 struct hexium
 {
 	int type;
-	struct video_device	video_dev;
+	struct video_device	*video_dev;
 	struct i2c_adapter	i2c_adapter;	
+
 	int cur_input;	/* current input */
 };
 
@@ -237,7 +238,11 @@
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	hexium->i2c_adapter = (struct i2c_adapter) {
+		.class = I2C_CLASS_TV_ANALOG,
+		.name = "hexium orion",
+	};
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura a/drivers/media/video/mxb.c linux-2.6.8.1-dvb2/drivers/media/video/mxb.c
--- a/drivers/media/video/mxb.c	2004-09-17 14:35:32.000000000 +0200
+++ linux-2.6.8.1-dvb2/drivers/media/video/mxb.c	2004-09-17 14:44:17.000000000 +0200
@@ -128,8 +128,8 @@
 
 struct mxb
 {
-	struct video_device	video_dev;
-	struct video_device	vbi_dev;
+	struct video_device	*video_dev;
+	struct video_device	*vbi_dev;
 
 	struct i2c_adapter	i2c_adapter;	
 
@@ -183,7 +183,12 @@
 	}
 	memset(mxb, 0x0, sizeof(struct mxb));	
 
-	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	mxb->i2c_adapter = (struct i2c_adapter) {
+		.class = I2C_CLASS_TV_ANALOG,
+		.name = "mxb",
+	};
+	
+	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&mxb->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(mxb);

--------------060406060108070800070301--
