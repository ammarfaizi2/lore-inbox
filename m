Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUEWTRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUEWTRy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUEWTRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:17:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:36530 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263415AbUEWTRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:17:41 -0400
Message-ID: <40B0F8C8.6030004@convergence.de>
Date: Sun, 23 May 2004 21:17:28 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Use saa7111 i2c module in V4L MXB driver
Content-Type: multipart/mixed;
 boundary="------------010608010204080901050705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010608010204080901050705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus,

the attached patch changes my "Multimedia eXtension Board" (MXB) 
Video4Linux-driver to use the standard saa7111 video decoder 
infrastructure (to which I recently submitted changes through Ronald 
Bultje) instead of some home-brewn direct-access stuff.

Nothing serious, but it removes code duplication and makes the code use 
the video decoder api.

Please apply.

Thanks!
Michael.

--------------010608010204080901050705
Content-Type: text/plain;
 name="mxb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mxb.diff"

- [V4L] use the standard saa7111 video decoder infrastructure in MXB V4L driver instead of some home-brewn direct-access stuff.
diff -urawB xx-linux-2.6.6-bk7/drivers/media/video/mxb.c linux-2.6.6-bk7/drivers/media/video/mxb.c
--- xx-linux-2.6.6-bk7/drivers/media/video/mxb.c	2004-05-21 17:08:44.000000000 +0200
+++ linux-2.6.6-bk7/drivers/media/video/mxb.c	2004-05-21 17:20:17.000000000 +0200
@@ -24,42 +24,15 @@
 #define DEBUG_VARIABLE debug
 
 #include <media/saa7146_vv.h>
-#include <linux/video_decoder.h>	/* for saa7111a */
+#include <media/tuner.h>
+#include <linux/video_decoder.h>
 
 #include "mxb.h"
 #include "tea6415c.h"
 #include "tea6420.h"
 #include "tda9840.h"
-#include <media/tuner.h>
 
-#define I2C_SAA7111A            0x24
-
-/* All unused bytes are reserverd. */
-#define SAA711X_CHIP_VERSION            0x00
-#define SAA711X_ANALOG_INPUT_CONTROL_1  0x02
-#define SAA711X_ANALOG_INPUT_CONTROL_2  0x03
-#define SAA711X_ANALOG_INPUT_CONTROL_3  0x04
-#define SAA711X_ANALOG_INPUT_CONTROL_4  0x05
-#define SAA711X_HORIZONTAL_SYNC_START   0x06
-#define SAA711X_HORIZONTAL_SYNC_STOP    0x07
-#define SAA711X_SYNC_CONTROL            0x08
-#define SAA711X_LUMINANCE_CONTROL       0x09
-#define SAA711X_LUMINANCE_BRIGHTNESS    0x0A
-#define SAA711X_LUMINANCE_CONTRAST      0x0B
-#define SAA711X_CHROMA_SATURATION       0x0C
-#define SAA711X_CHROMA_HUE_CONTROL      0x0D
-#define SAA711X_CHROMA_CONTROL          0x0E
-#define SAA711X_FORMAT_DELAY_CONTROL    0x10
-#define SAA711X_OUTPUT_CONTROL_1        0x11
-#define SAA711X_OUTPUT_CONTROL_2        0x12
-#define SAA711X_OUTPUT_CONTROL_3        0x13
-#define SAA711X_V_GATE_1_START          0x15
-#define SAA711X_V_GATE_1_STOP           0x16
-#define SAA711X_V_GATE_1_MSB            0x17
-#define SAA711X_TEXT_SLICER_STATUS      0x1A
-#define SAA711X_DECODED_BYTES_OF_TS_1   0x1B
-#define SAA711X_DECODED_BYTES_OF_TS_2   0x1C
-#define SAA711X_STATUS_BYTE             0x1F
+#define I2C_SAA7111 0x24
 
 #define MXB_BOARD_CAN_DO_VBI(dev)   (dev->revision != 0) 
 
@@ -175,42 +148,33 @@
 
 static struct saa7146_extension extension;
 
-static int mxb_vbi_bypass(struct saa7146_dev* dev)
-{
-	struct mxb* mxb = (struct mxb*)dev->ext_priv;
-	s32 byte = 0x0;
-	int result = 0;
-
-	DEB_EE(("dev:%p\n",dev));
-
-	/* switch bypass in saa7111a, this should be done in the
-	   saa7111a driver of course... */
-	if ( -1 == (result = i2c_smbus_read_byte_data(mxb->saa7111a, SAA711X_OUTPUT_CONTROL_3))) {
-		DEB_D(("could not read from saa7111a.\n"));
-		return -EFAULT;
-	}
-	byte = result;
-	byte &= 0xf0;
-	byte |= 0x0a;
-
-	if ( 0 != (result = i2c_smbus_write_byte_data(mxb->saa7111a, SAA711X_OUTPUT_CONTROL_3, byte))) {
-		DEB_D(("could not write to saa7111a.\n"));
-		return -EFAULT;
-	}
-	return 0;
-}
-
 static int mxb_probe(struct saa7146_dev* dev)
 {
 	struct mxb* mxb = 0;
 	struct i2c_client *client;
 	struct list_head *item;
+	int result;
 
-	request_module("tuner");
-	request_module("tea6420");
-	request_module("tea6415c");
-	request_module("tda9840");
-	request_module("saa7111");
+	if ((result = request_module("saa7111")) < 0) {
+		printk("mxb: saa7111 i2c module not available.\n");
+		return -ENODEV;
+	}
+	if ((result = request_module("tuner")) < 0) {
+		printk("mxb: tuner i2c module not available.\n");
+		return -ENODEV;
+	}
+	if ((result = request_module("tea6420")) < 0) {
+		printk("mxb: tea6420 i2c module not available.\n");
+		return -ENODEV;
+	}
+	if ((result = request_module("tea6415c")) < 0) {
+		printk("mxb: tea6415c i2c module not available.\n");
+		return -ENODEV;
+	}
+	if ((result = request_module("tda9840")) < 0) {
+		printk("mxb: tda9840 i2c module not available.\n");
+		return -ENODEV;
+	}
 
 	mxb = (struct mxb*)kmalloc(sizeof(struct mxb), GFP_KERNEL);
 	if( NULL == mxb ) {
@@ -219,10 +183,6 @@
 	}
 	memset(mxb, 0x0, sizeof(struct mxb));	
 
-	/* FIXME: enable i2c-port pins, video-port-pins
-	   video port pins should be enabled here ?! */
-	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
-
 	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&mxb->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
@@ -241,7 +201,7 @@
 			mxb->tea6415c = client;
 		if( I2C_TDA9840 == client->addr ) 
 			mxb->tda9840 = client;
-		if( I2C_SAA7111A == client->addr ) 
+		if( I2C_SAA7111 == client->addr ) 
 			mxb->saa7111a = client;
 		if( 0x60 == client->addr ) 
 			mxb->tuner = client;
@@ -251,8 +211,7 @@
 	if(    0 == mxb->tea6420_1	|| 0 == mxb->tea6420_2	|| 0 == mxb->tea6415c
 	    || 0 == mxb->tda9840	|| 0 == mxb->saa7111a	|| 0 == mxb->tuner ) {
 
-		printk("mxb: did not find all i2c devices. are you sure you\n");
-		printk("mxb: insmod'ed tea6420, tea6415c, saa7111, tea6415c and tuner?\n");
+		printk("mxb: did not find all i2c devices. aborting\n");
 		i2c_del_adapter(&mxb->i2c_adapter);
 		kfree(mxb);
 		return -ENODEV;
@@ -322,37 +281,35 @@
 	{-1, { 0} }
 };
 
-static unsigned char mxb_saa7111_init[25] = {
-	0x00,
-	
-	0x00,	  /* 00 - ID byte */
-	0x00,	  /* 01 - reserved */
+static const unsigned char mxb_saa7111_init[] = {
+	0x00, 0x00,	  /* 00 - ID byte */
+	0x01, 0x00,	  /* 01 - reserved */
 
 	/*front end */
-	0xd8,	  /* 02 - FUSE=x, GUDL=x, MODE=x */
-	0x23,	  /* 03 - HLNRS=0, VBSL=1, WPOFF=0, HOLDG=0, GAFIX=0, GAI1=256, GAI2=256 */
-	0x00,	  /* 04 - GAI1=256 */
-	0x00,	  /* 05 - GAI2=256 */
+	0x02, 0xd8,	  /* 02 - FUSE=x, GUDL=x, MODE=x */
+	0x03, 0x23,	  /* 03 - HLNRS=0, VBSL=1, WPOFF=0, HOLDG=0, GAFIX=0, GAI1=256, GAI2=256 */
+	0x04, 0x00,	  /* 04 - GAI1=256 */
+	0x05, 0x00,	  /* 05 - GAI2=256 */
 
 	/* decoder */
-	0xf0,	  /* 06 - HSB at  xx(50Hz) /  xx(60Hz) pixels after end of last line */
-	0x30,	  /* 07 - HSS at  xx(50Hz) /  xx(60Hz) pixels after end of last line */
-	0xa8,	  /* 08 - AUFD=x, FSEL=x, EXFIL=x, VTRC=x, HPLL=x, VNOI=x */
-	0x02,	  /* 09 - BYPS=x, PREF=x, BPSS=x, VBLB=x, UPTCV=x, APER=x */
-	0x80,	  /* 0a - BRIG=128 */
-	0x47,	  /* 0b - CONT=1.109 */
-	0x40,	  /* 0c - SATN=1.0 */
-	0x00,	  /* 0d - HUE=0 */
-	0x01,	  /* 0e - CDTO=0, CSTD=0, DCCF=0, FCTC=0, CHBW=1 */
-	0x00,	  /* 0f - reserved */
-	0xd0,	  /* 10 - OFTS=x, HDEL=x, VRLN=x, YDEL=x */
-	0x8c,	  /* 11 - GPSW=x, CM99=x, FECO=x, COMPO=x, OEYC=1, OEHV=1, VIPB=0, COLO=0 */
-	0x80,	  /* 12 - xx output control 2 */
-	0x30,	  /* 13 - xx output control 3 */
-	0x00,	  /* 14 - reserved */
-	0x15,	  /* 15 - VBI */
-	0x04,	  /* 16 - VBI */
-	0x00,	  /* 17 - VBI */
+	0x06, 0xf0,	  /* 06 - HSB at  xx(50Hz) /  xx(60Hz) pixels after end of last line */
+	0x07, 0x30,	  /* 07 - HSS at  xx(50Hz) /  xx(60Hz) pixels after end of last line */
+	0x08, 0xa8,	  /* 08 - AUFD=x, FSEL=x, EXFIL=x, VTRC=x, HPLL=x, VNOI=x */
+	0x09, 0x02,	  /* 09 - BYPS=x, PREF=x, BPSS=x, VBLB=x, UPTCV=x, APER=x */
+	0x0a, 0x80,	  /* 0a - BRIG=128 */
+	0x0b, 0x47,	  /* 0b - CONT=1.109 */
+	0x0c, 0x40,	  /* 0c - SATN=1.0 */
+	0x0d, 0x00,	  /* 0d - HUE=0 */
+	0x0e, 0x01,	  /* 0e - CDTO=0, CSTD=0, DCCF=0, FCTC=0, CHBW=1 */
+	0x0f, 0x00,	  /* 0f - reserved */
+	0x10, 0xd0,	  /* 10 - OFTS=x, HDEL=x, VRLN=x, YDEL=x */
+	0x11, 0x8c,	  /* 11 - GPSW=x, CM99=x, FECO=x, COMPO=x, OEYC=1, OEHV=1, VIPB=0, COLO=0 */
+	0x12, 0x80,	  /* 12 - xx output control 2 */
+	0x13, 0x30,	  /* 13 - xx output control 3 */
+	0x14, 0x00,	  /* 14 - reserved */
+	0x15, 0x15,	  /* 15 - VBI */
+	0x16, 0x04,	  /* 16 - VBI */
+	0x17, 0x00,	  /* 17 - VBI */
 };
 
 /* bring hardware to a sane state. this has to be done, just in case someone
@@ -362,25 +319,29 @@
 static int mxb_init_done(struct saa7146_dev* dev)
 {
 	struct mxb* mxb = (struct mxb*)dev->ext_priv;
-	
+	struct video_decoder_init init;	
 	struct i2c_msg msg;
 
 	int i = 0, err = 0;
 	struct	tea6415c_multiplex vm;	
 
+	/* select video mode in saa7111a */
+	i = VIDEO_MODE_PAL;
+	/* fixme: currently pointless: gets overwritten by configuration below */
+	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_NORM, &i);
+
 	/* write configuration to saa7111a */
-	i = i2c_master_send(mxb->saa7111a, mxb_saa7111_init, sizeof(mxb_saa7111_init));
-	if (i < 0) {
-		printk("failed to initialize saa7111a. this should never happen.\n");
-	}
+	init.data = mxb_saa7111_init;
+	init.len = sizeof(mxb_saa7111_init);
+	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_INIT, &init);
 
 	/* select tuner-output on saa7111a */
 	i = 0;
 	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_INPUT, &i);
-//	i = VIDEO_MODE_PAL;
-//	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_NORM, &i);
 
-	mxb_vbi_bypass(dev);
+	/* enable vbi bypass */
+	i = 1;
+	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_VBI_BYPASS, &i);
 
 	/* select a tuner type */
 	i = 5; 
@@ -538,36 +499,6 @@
 	return 0;
 }
 
-/* hack: this should go into saa711x */
-static int saa7111_set_gpio(struct saa7146_dev *dev, int bl)
-{
-	struct mxb* mxb = (struct mxb*)dev->ext_priv;
-	s32 byte = 0x0;
-	int result = 0;
-	
-	DEB_EE(("dev:%p\n",dev));
-
-	/* get the old register contents */
-	if ( -1 == (byte = i2c_smbus_read_byte_data(mxb->saa7111a, SAA711X_OUTPUT_CONTROL_1))) {
-		DEB_D(("could not read from saa711x\n"));
-		return -EFAULT;
-	}
-	
-	if( 0 == bl ) {
-		byte &= 0x7f;
-	} else {
-		byte |= 0x80;
-	}
-
-	/* write register contents back */
-	if ( 0 != (result = i2c_smbus_write_byte_data(mxb->saa7111a, SAA711X_OUTPUT_CONTROL_1, byte))) {
-		DEB_D(("could not write to saa711x\n"));
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
 static int mxb_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg) 
 {
 	struct saa7146_dev *dev = fh->dev;
@@ -988,18 +919,22 @@
 
 static int std_callback(struct saa7146_dev* dev, struct saa7146_standard *std)
 {
+	struct mxb* mxb = (struct mxb*)dev->ext_priv;
+	int zero = 0;
+	int one = 1;
+	
 	if(V4L2_STD_PAL_I == std->id ) {
 		DEB_D(("VIDIOC_S_STD: setting mxb for PAL_I.\n"));
 		/* set the 7146 gpio register -- I don't know what this does exactly */
       		saa7146_write(dev, GPIO_CTRL, 0x00404050);
 		/* unset the 7111 gpio register -- I don't know what this does exactly */
-		saa7111_set_gpio(dev,0);
+		mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_GPIO, &zero);
 	} else {
 		DEB_D(("VIDIOC_S_STD: setting mxb for PAL/NTSC/SECAM.\n"));
 		/* set the 7146 gpio register -- I don't know what this does exactly */
       		saa7146_write(dev, GPIO_CTRL, 0x00404050);
 		/* set the 7111 gpio register -- I don't know what this does exactly */
-		saa7111_set_gpio(dev,1);
+		mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_GPIO, &one);
 	}
 	return 0;
 }

--------------010608010204080901050705--
