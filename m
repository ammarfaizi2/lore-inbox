Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTJERyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJERyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:54:38 -0400
Received: from mail.convergence.de ([212.84.236.4]:20135 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263272AbTJERyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:54:00 -0400
Message-ID: <3F805AAB.1030106@convergence.de>
Date: Sun, 05 Oct 2003 19:53:47 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tamas.patko@hexium.hu
Subject: [PATCH[[2.6] Update V4L2 "Hexium" driver
Content-Type: multipart/mixed;
 boundary="------------050307080302070508000206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307080302070508000206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus,

the following patch updates my two Video4Linux-2 drivers for the "Hexium 
Gemini" and "Hexium Orion" cards.

It adds the long missing input handling for the "Gemini" card and 
removes the annoying compile time warning about unused structures.
It simplifies the whole driver structure by removing the header files -- 
instead it puts all relevant data into the C file, because these 
informations are not used outside of the driver. This makes the patch 
quite large I admit.

Please apply. The detailed changes are described in the top of the patch.

Thanks!
Michael.


--------------050307080302070508000206
Content-Type: text/plain;
 name="v4l2-hexium-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l2-hexium-update.diff"

- [V4L] remove various hexium header files, put all driver relevant informations into the drivers. these informations are not needed anywhere else.
- [V4L] fix driver names in information printk()s
- [V4L] fix device initialization for Hexium Gemini cards
- [V4L] add input switching for Hexium Gemini cards
- [V4L] fix all remaining "fixme"s
diff -uraN xx-linux-2.6.0-test6/drivers/media/video/hexium_gemini.c linux-2.6.0-test6/drivers/media/video/hexium_gemini.c
--- xx-linux-2.6.0-test6/drivers/media/video/hexium_gemini.c	2003-10-04 21:05:31.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/hexium_gemini.c	2003-10-05 19:17:01.000000000 +0200
@@ -32,7 +32,148 @@
 /* global variables */
 static int hexium_num = 0;
 
-#include "hexium_gemini.h"
+#define HEXIUM_GEMINI			4
+#define HEXIUM_GEMINI_DUAL		5
+
+#define HEXIUM_INPUTS	9
+static struct v4l2_input hexium_inputs[HEXIUM_INPUTS] = {
+	{ 0, "CVBS 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 1, "CVBS 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 2, "CVBS 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 3, "CVBS 4",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 4, "CVBS 5",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 5, "CVBS 6",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 6, "Y/C 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 7, "Y/C 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 8, "Y/C 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+};
+
+#define HEXIUM_AUDIOS	0
+
+struct hexium_data
+{
+	s8 adr;
+	u8 byte;
+};
+
+static struct saa7146_extension_ioctls ioctls[] = {
+	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_QUERYCTRL, 	SAA7146_BEFORE },
+	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_STD,		SAA7146_AFTER },
+	{ VIDIOC_G_CTRL,	SAA7146_BEFORE },
+	{ VIDIOC_S_CTRL,	SAA7146_BEFORE },
+	{ 0,			0 }
+};
+
+#define HEXIUM_CONTROLS	1
+static struct v4l2_queryctrl hexium_controls[] = {
+	{ V4L2_CID_PRIVATE_BASE, V4L2_CTRL_TYPE_BOOLEAN, "B/W", 0, 1, 1, 0, 0 },
+};
+
+#define HEXIUM_GEMINI_V_1_0		1
+#define HEXIUM_GEMINI_DUAL_V_1_0	2
+
+struct hexium
+{
+	int type;
+	struct video_device	video_dev;
+	struct i2c_adapter	i2c_adapter;
+		
+	int 		cur_input;	/* current input */
+	v4l2_std_id 	cur_std;	/* current standard */
+	int		cur_bw;		/* current black/white status */
+};
+
+/* Samsung KS0127B decoder default registers */
+static u8 hexium_ks0127b[0x100]={
+/*00*/ 0x00,0x52,0x30,0x40,0x01,0x0C,0x2A,0x10,
+/*08*/ 0x00,0x00,0x00,0x60,0x00,0x00,0x0F,0x06,
+/*10*/ 0x00,0x00,0xE4,0xC0,0x00,0x00,0x00,0x00,
+/*18*/ 0x14,0x9B,0xFE,0xFF,0xFC,0xFF,0x03,0x22,
+/*20*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*28*/ 0x00,0x00,0x00,0x00,0x00,0x2C,0x9B,0x00,
+/*30*/ 0x00,0x00,0x10,0x80,0x80,0x10,0x80,0x80,
+/*38*/ 0x01,0x04,0x00,0x00,0x00,0x29,0xC0,0x00,
+/*40*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*48*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*50*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*58*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*60*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*68*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*70*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*78*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*80*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*88*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*90*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*98*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*A0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*A8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*B0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*B8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*C0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*C8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*D0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*D8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*E0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*E8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*F0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*F8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
+};
+
+static struct hexium_data hexium_pal[] = {
+	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_pal_bw[] = {
+	{ 0x01, 0x52 },	{ 0x12, 0x64 },	{ 0x2D, 0x2C },	{ 0x2E, 0x9B },	{ -1 , 0xFF }
+};
+
+static struct hexium_data hexium_ntsc[] = {
+	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_ntsc_bw[] = {
+	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_secam[] = {
+	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_input_select[] = {
+	{ 0x02, 0x60 },
+	{ 0x02, 0x64 },
+	{ 0x02, 0x61 },
+	{ 0x02, 0x65 },
+	{ 0x02, 0x62 },
+	{ 0x02, 0x66 },
+	{ 0x02, 0x68 },
+	{ 0x02, 0x69 },
+	{ 0x02, 0x6A },
+};
+
+/* fixme: h_offset = 0 for Hexium Gemini *Dual*, which
+   are currently *not* supported*/
+static struct saa7146_standard hexium_standards[] = {
+	{
+		.name	= "PAL", 	.id	= V4L2_STD_PAL,
+		.v_offset	= 28,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 1,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 28,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 1,	.h_pixels 	= 640,	.h_calc		= 641+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}, {
+		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
+		.v_offset	= 28,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 1,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}
+};		
 
 /* bring hardware to a sane state. this has to be done, just in case someone
    wants to capture from this device before it has been properly initialized.
@@ -50,7 +191,7 @@
 	for (i = 0; i < sizeof(hexium_ks0127b); i++) {
 		data.byte = hexium_ks0127b[i];
 		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x6c, 0, I2C_SMBUS_WRITE, i, I2C_SMBUS_BYTE_DATA, &data)) {
-			printk("failed for address 0x%02x\n", i);
+			printk("hexium_gemini: hexium_init_done() failed for address 0x%02x\n", i);
 		}
 	}
 
@@ -81,7 +222,7 @@
 	while (vdec[i].adr != -1) {
 		data.byte = vdec[i].byte;
 		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x6c, 0, I2C_SMBUS_WRITE, vdec[i].adr, I2C_SMBUS_BYTE_DATA, &data)) {
-			printk("failed for address 0x%02x\n", i);
+			printk("hexium_init_done: hexium_set_standard() failed for address 0x%02x\n", i);
 			return -1;
 		}
 		i++;
@@ -100,14 +241,13 @@
 
 	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
 	if (NULL == hexium) {
-		printk("hexium_v4l2.o: hexium_probe: not enough kernel memory.\n");
+		printk("hexium_gemini: not enough kernel memory in hexium_attach().\n");
 		return -ENOMEM;
 	}
 	memset(hexium, 0x0, sizeof(struct hexium));
 	(struct hexium *) dev->ext_priv = hexium;
 
-	/* FIXME: enable i2c-port pins, video-port-pins
-	   video port pins should be enabled here ?! */
+	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
 	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
@@ -135,12 +275,12 @@
 	hexium->cur_input = 0;
 
 	saa7146_vv_init(dev, &vv_data);
-	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium", VFL_TYPE_GRABBER)) {
-		ERR(("cannot register capture v4l2 device. skipping.\n"));
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_GRABBER)) {
+		printk("hexium_gemini: cannot register capture v4l2 device. skipping.\n");
 		return -1;
 	}
 
-	printk("hexium: found 'hexium frame grabber'-%d.\n", hexium_num);
+	printk("hexium_gemini: found 'hexium gemini' frame grabber-%d.\n", hexium_num);
 	hexium_num++;
 
 	return 0;
@@ -302,7 +442,7 @@
 		}
 	default:
 /*
-		DEB_D(("v4l2_ioctl does not handle this ioctl.\n"));
+		DEB_D(("hexium_ioctl() does not handle this ioctl.\n"));
 */
 		return -ENOIOCTLCMD;
 	}
diff -uraN xx-linux-2.6.0-test6/drivers/media/video/hexium_gemini.h linux-2.6.0-test6/drivers/media/video/hexium_gemini.h
--- xx-linux-2.6.0-test6/drivers/media/video/hexium_gemini.h	2003-10-04 21:05:06.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/hexium_gemini.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,103 +0,0 @@
-#ifndef __HEXIUM_GEMINI__
-#define __HEXIUM_GEMINI__
-
-#include "hexium.h"
-
-static struct saa7146_extension_ioctls ioctls[] = {
-	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
-	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
-	{ VIDIOC_QUERYCTRL, 	SAA7146_BEFORE },
-	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
-	{ VIDIOC_S_STD,		SAA7146_AFTER },
-	{ VIDIOC_G_CTRL,	SAA7146_BEFORE },
-	{ VIDIOC_S_CTRL,	SAA7146_BEFORE },
-	{ 0,			0 }
-};
-
-#define HEXIUM_CONTROLS	1
-static struct v4l2_queryctrl hexium_controls[] = {
-	{ V4L2_CID_PRIVATE_BASE, V4L2_CTRL_TYPE_BOOLEAN, "B/W", 0, 1, 1, 0, 0 },
-};
-
-#define HEXIUM_GEMUINI_V_1_0		1
-#define HEXIUM_GEMUINI_DUAL_V_1_0	2
-
-struct hexium
-{
-	int type;
-	struct video_device	video_dev;
-	struct i2c_adapter	i2c_adapter;
-		
-	int 		cur_input;	/* current input */
-	v4l2_std_id 	cur_std;	/* current standard */
-	int		cur_bw;		/* current black/white status */
-};
-
-/* Samsung KS0127B decoder default registers */
-static u8 hexium_ks0127b[0x100]={
-/*00*/ 0x00,0x52,0x30,0x40,0x01,0x0C,0x2A,0x10,
-/*08*/ 0x00,0x00,0x00,0x60,0x00,0x00,0x0F,0x06,
-/*10*/ 0x00,0x00,0xE4,0xC0,0x00,0x00,0x00,0x00,
-/*18*/ 0x14,0x9B,0xFE,0xFF,0xFC,0xFF,0x03,0x22,
-/*20*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*28*/ 0x00,0x00,0x00,0x00,0x00,0x2C,0x9B,0x00,
-/*30*/ 0x00,0x00,0x10,0x80,0x80,0x10,0x80,0x80,
-/*38*/ 0x01,0x04,0x00,0x00,0x00,0x29,0xC0,0x00,
-/*40*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*48*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*50*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*58*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*60*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*68*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*70*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*78*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*80*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*88*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*90*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*98*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*A0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*A8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*B0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*B8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*C0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*C8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*D0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*D8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*E0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*E8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*F0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-/*F8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
-};
-
-static struct hexium_data hexium_pal[] = {
-	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
-};
-
-static struct hexium_data hexium_pal_bw[] = {
-	{ 0x01, 0x52 },	{ 0x12, 0x64 },	{ 0x2D, 0x2C },	{ 0x2E, 0x9B },	{ -1 , 0xFF }
-};
-
-static struct hexium_data hexium_ntsc[] = {
-	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
-};
-
-static struct hexium_data hexium_ntsc_bw[] = {
-	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
-};
-
-static struct hexium_data hexium_secam[] = {
-	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
-};
-
-static struct hexium_data hexium_input_select[] = {
-	{ 0x02, 0x60 },
-	{ 0x02, 0x64 },
-	{ 0x02, 0x61 },
-	{ 0x02, 0x65 },
-	{ 0x02, 0x62 },
-	{ 0x02, 0x66 },
-	{ 0x02, 0x68 },
-	{ 0x02, 0x69 },
-	{ 0x02, 0x6A },
-};
-#endif
diff -uraN xx-linux-2.6.0-test6/drivers/media/video/hexium.h linux-2.6.0-test6/drivers/media/video/hexium.h
--- xx-linux-2.6.0-test6/drivers/media/video/hexium.h	2003-10-04 21:05:06.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/hexium.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,51 +0,0 @@
-#ifndef __HEXIUM__
-#define __HEXIUM__
-
-#define HEXIUM_HV_PCI6_ORION		1
-#define HEXIUM_ORION_1SVHS_3BNC		2
-#define HEXIUM_ORION_4BNC		3
-#define HEXIUM_GEMUINI			4
-#define HEXIUM_GEMUINI_DUAL		5
-
-static struct saa7146_standard hexium_standards[] = {
-	{
-		.name	= "PAL", 	.id	= V4L2_STD_PAL,
-		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
-		.v_max_out	= 576,	.h_max_out	= 768,
-	}, {
-		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 0x17,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 0x06,	.h_pixels 	= 640,	.h_calc		= 641+1,
-		.v_max_out	= 480,	.h_max_out	= 640,
-	}, {
-		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
-		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
-		.v_max_out	= 576,	.h_max_out	= 768,
-	}
-};		
-
-
-#define HEXIUM_INPUTS	9
-static struct v4l2_input hexium_inputs[HEXIUM_INPUTS] = {
-	{ 0, "CVBS 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 1, "CVBS 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 2, "CVBS 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 3, "CVBS 4",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 4, "CVBS 5",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 5, "CVBS 6",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 6, "Y/C 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 7, "Y/C 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-	{ 8, "Y/C 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
-};
-
-#define HEXIUM_AUDIOS	0
-
-struct hexium_data
-{
-	s8 adr;
-	u8 byte;
-};
-
-#endif
diff -uraN xx-linux-2.6.0-test6/drivers/media/video/hexium_orion.c linux-2.6.0-test6/drivers/media/video/hexium_orion.c
--- xx-linux-2.6.0-test6/drivers/media/video/hexium_orion.c	2003-10-04 21:05:31.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/hexium_orion.c	2003-10-05 19:16:10.000000000 +0200
@@ -30,9 +30,183 @@
 MODULE_PARM_DESC(debug, "debug verbosity");
 
 /* global variables */
-int hexium_num = 0;
+static int hexium_num = 0;
 
-#include "hexium_orion.h"
+#define HEXIUM_HV_PCI6_ORION		1
+#define HEXIUM_ORION_1SVHS_3BNC		2
+#define HEXIUM_ORION_4BNC		3
+
+#define HEXIUM_INPUTS	9
+static struct v4l2_input hexium_inputs[HEXIUM_INPUTS] = {
+	{ 0, "CVBS 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 1, "CVBS 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 2, "CVBS 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 3, "CVBS 4",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 4, "CVBS 5",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 5, "CVBS 6",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 6, "Y/C 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 7, "Y/C 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 8, "Y/C 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+};
+
+#define HEXIUM_AUDIOS	0
+
+struct hexium_data
+{
+	s8 adr;
+	u8 byte;
+};
+
+static struct saa7146_extension_ioctls ioctls[] = {
+	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_STD,		SAA7146_AFTER },
+	{ 0,			0 }
+};
+
+struct hexium
+{
+	int type;
+	struct video_device	video_dev;
+	struct i2c_adapter	i2c_adapter;	
+	int cur_input;	/* current input */
+};
+
+/* Philips SAA7110 decoder default registers */
+static u8 hexium_saa7110[53]={
+/*00*/ 0x4C,0x3C,0x0D,0xEF,0xBD,0xF0,0x00,0x00,
+/*08*/ 0xF8,0xF8,0x60,0x60,0x40,0x86,0x18,0x90,
+/*10*/ 0x00,0x2C,0x40,0x46,0x42,0x1A,0xFF,0xDA,
+/*18*/ 0xF0,0x8B,0x00,0x00,0x00,0x00,0x00,0x00,
+/*20*/ 0xD9,0x17,0x40,0x41,0x80,0x41,0x80,0x4F,
+/*28*/ 0xFE,0x01,0x0F,0x0F,0x03,0x01,0x81,0x03,
+/*30*/ 0x44,0x75,0x01,0x8C,0x03
+};
+
+static struct {
+	struct hexium_data data[8];	
+} hexium_input_select[] = {
+{
+	{ /* cvbs 1 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xD9 },
+		{ 0x21, 0x17 }, // 0x16,
+		{ 0x22, 0x40 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 }, // ??
+		{ 0x21, 0x16 }, // 0x03,
+	}
+}, {
+	{ /* cvbs 2 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0x78 },
+		{ 0x21, 0x07 }, // 0x03,
+		{ 0x22, 0xD2 },
+		{ 0x2C, 0x83 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ?
+		{ 0x21, 0x03 },
+	}
+}, {
+	{ /* cvbs 3 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xBA },
+		{ 0x21, 0x07 }, // 0x05,
+		{ 0x22, 0x91 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x05 }, // 0x03,
+	}
+}, {
+	{ /* cvbs 4 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xD8 },
+		{ 0x21, 0x17 }, // 0x16,
+		{ 0x22, 0x40 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 }, // ??
+		{ 0x21, 0x16 }, // 0x03,
+	}
+}, {
+	{ /* cvbs 5 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xB8 },
+		{ 0x21, 0x07 }, // 0x05,
+		{ 0x22, 0x91 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x05 }, // 0x03,
+	}
+}, {
+	{ /* cvbs 6 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0x7C },
+		{ 0x21, 0x07 }, // 0x03
+		{ 0x22, 0xD2 },
+		{ 0x2C, 0x83 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x03 },
+	} 
+}, {
+	{ /* y/c 1 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x59 },
+		{ 0x21, 0x17 },
+		{ 0x22, 0x42 },
+		{ 0x2C, 0xA3 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 },
+		{ 0x21, 0x12 },
+	}
+}, {
+	{ /* y/c 2 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x9A },
+		{ 0x21, 0x17 },
+		{ 0x22, 0xB1 },
+		{ 0x2C, 0x13 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 },
+		{ 0x21, 0x14 },
+	}
+}, {
+	{ /* y/c 3 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x3C },
+		{ 0x21, 0x27 },
+		{ 0x22, 0xC1 },
+		{ 0x2C, 0x23 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 },
+		{ 0x21, 0x21 },
+	}
+}	
+};
+
+static struct saa7146_standard hexium_standards[] = {
+	{
+		.name	= "PAL", 	.id	= V4L2_STD_PAL,
+		.v_offset	= 16,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 1,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 16,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 1,	.h_pixels 	= 640,	.h_calc		= 641+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}, {
+		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
+		.v_offset	= 16,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 1,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}
+};		
 
 /* this is only called for old HV-PCI6/Orion cards
    without eeprom */
@@ -51,16 +225,15 @@
 
 	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
 	if (NULL == hexium) {
-		printk("hexium_orion.o: hexium_probe: not enough kernel memory.\n");
+		printk("hexium_orion: hexium_probe: not enough kernel memory.\n");
 		return -ENOMEM;
 	}
 	memset(hexium, 0x0, sizeof(struct hexium));
 
-	/* FIXME: enable i2c-port pins, video-port-pins
-	   video port pins should be enabled here ?! */
+	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_write(dev, DD1_INIT, 0x02000200);
+	saa7146_write(dev, DD1_INIT, 0x01000100);
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
@@ -80,7 +253,7 @@
 
 	/* detect newer Hexium Orion cards by subsystem ids */
 	if (0x17c8 == dev->pci->subsystem_vendor && 0x0101 == dev->pci->subsystem_device) {
-		printk("hexium_orion.o: device is a Hexium Orion w/ 1 SVHS + 3 BNC inputs.\n");
+		printk("hexium_orion: device is a Hexium Orion w/ 1 SVHS + 3 BNC inputs.\n");
 		/* we store the pointer in our private data field */
 		(struct hexium *) dev->ext_priv = hexium;
 		hexium->type = HEXIUM_ORION_1SVHS_3BNC;
@@ -88,7 +261,7 @@
 	}
 
 	if (0x17c8 == dev->pci->subsystem_vendor && 0x2101 == dev->pci->subsystem_device) {
-		printk("hexium_orion.o: device is a Hexium Orion w/ 4 BNC inputs.\n");
+		printk("hexium_orion: device is a Hexium Orion w/ 4 BNC inputs.\n");
 		/* we store the pointer in our private data field */
 		(struct hexium *) dev->ext_priv = hexium;
 		hexium->type = HEXIUM_ORION_4BNC;
@@ -98,7 +271,7 @@
 	/* check if this is an old hexium Orion card by looking at 
 	   a saa7110 at address 0x4e */
 	if (0 == (err = i2c_smbus_xfer(&hexium->i2c_adapter, 0x4e, 0, I2C_SMBUS_READ, 0x00, I2C_SMBUS_BYTE_DATA, &data))) {
-		printk("hexium_orion.o: device is a Hexium HV-PCI6/Orion (old).\n");
+		printk("hexium_orion: device is a Hexium HV-PCI6/Orion (old).\n");
 		/* we store the pointer in our private data field */
 		(struct hexium *) dev->ext_priv = hexium;
 		hexium->type = HEXIUM_HV_PCI6_ORION;
@@ -133,6 +306,25 @@
 	return 0;
 }
 
+static int hexium_set_input(struct hexium *hexium, int input)
+{
+	union i2c_smbus_data data;
+	int i = 0;
+	
+	DEB_D((".\n"));
+
+	for (i = 0; i < 8; i++) {
+		int adr = hexium_input_select[input].data[i].adr;
+		data.byte = hexium_input_select[input].data[i].byte;
+		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x4e, 0, I2C_SMBUS_WRITE, adr, I2C_SMBUS_BYTE_DATA, &data)) {
+			return -1;
+		}
+		printk("%d: 0x%02x => 0x%02x\n",input, adr,data.byte);
+	}
+
+	return 0;
+}
+
 static struct saa7146_ext_vv vv_data;
 
 /* this function only gets called when the probing was successful */
@@ -143,12 +335,12 @@
 	DEB_EE((".\n"));
 
 	saa7146_vv_init(dev, &vv_data);
-	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium", VFL_TYPE_GRABBER)) {
-		ERR(("cannot register capture v4l2 device. skipping.\n"));
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_GRABBER)) {
+		printk("hexium_orion: cannot register capture v4l2 device. skipping.\n");
 		return -1;
 	}
 
-	printk("hexium_orion.o: found 'hexium orion' frame grabber-%d.\n", hexium_num);
+	printk("hexium_orion: found 'hexium orion' frame grabber-%d.\n", hexium_num);
 	hexium_num++;
 
 	/* the rest */
@@ -213,16 +405,13 @@
 			}
 
 			hexium->cur_input = input;
-
-			/* fixme: switch input here, switch audio, too! */
-//              saa7146_set_hps_source_and_sync(dev, input_port_selection[input].hps_source, input_port_selection[input].hps_sync);
-			printk("hexium_orion.o: VIDIOC_S_INPUT: fixme switch input.\n");
+			hexium_set_input(hexium, input);
 
 			return 0;
 		}
 	default:
 /*
-		DEB_D(("v4l2_ioctl does not handle this ioctl.\n"));
+		DEB_D(("hexium_ioctl() does not handle this ioctl.\n"));
 */
 		return -ENOIOCTLCMD;
 	}
diff -uraN xx-linux-2.6.0-test6/drivers/media/video/hexium_orion.h linux-2.6.0-test6/drivers/media/video/hexium_orion.h
--- xx-linux-2.6.0-test6/drivers/media/video/hexium_orion.h	2003-10-04 21:05:06.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/hexium_orion.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,138 +0,0 @@
-#ifndef __HEXIUM_ORION__
-#define __HEXIUM_ORION__
-
-#include "hexium.h"
-
-static struct saa7146_extension_ioctls ioctls[] = {
-	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
-	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
-	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
-	{ VIDIOC_S_STD,		SAA7146_AFTER },
-	{ 0,			0 }
-};
-
-struct hexium
-{
-	int type;
-	struct video_device	video_dev;
-	struct i2c_adapter	i2c_adapter;	
-	int cur_input;	/* current input */
-};
-
-/* Philips SAA7110 decoder default registers */
-static u8 hexium_saa7110[53]={
-/*00*/ 0x4C,0x3C,0x0D,0xEF,0xBD,0xF0,0x00,0x00,
-/*08*/ 0xF8,0xF8,0x60,0x60,0x40,0x86,0x18,0x90,
-/*10*/ 0x00,0x2C,0x40,0x46,0x42,0x1A,0xFF,0xDA,
-/*18*/ 0xF0,0x8B,0x00,0x00,0x00,0x00,0x00,0x00,
-/*20*/ 0xD9,0x17,0x40,0x41,0x80,0x41,0x80,0x4F,
-/*28*/ 0xFE,0x01,0x0F,0x0F,0x03,0x01,0x81,0x03,
-/*30*/ 0x44,0x75,0x01,0x8C,0x03
-};
-
-static struct {
-	struct hexium_data data[8];	
-} hexium_input_select[] = {
-{
-	{ /* input 0 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xD9 },
-		{ 0x21, 0x17 }, // 0x16,
-		{ 0x22, 0x40 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 }, // ??
-		{ 0x21, 0x16 }, // 0x03,
-	}
-}, {
-	{ /* input 1 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xD8 },
-		{ 0x21, 0x17 }, // 0x16,
-		{ 0x22, 0x40 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 }, // ??
-		{ 0x21, 0x16 }, // 0x03,
-	}
-}, {
-	{ /* input 2 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xBA },
-		{ 0x21, 0x07 }, // 0x05,
-		{ 0x22, 0x91 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x05 }, // 0x03,
-	}
-}, {
-	{ /* input 3 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xB8 },
-		{ 0x21, 0x07 }, // 0x05,
-		{ 0x22, 0x91 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x05 }, // 0x03,
-	}
-}, {
-	{ /* input 4 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0x7C },
-		{ 0x21, 0x07 }, // 0x03
-		{ 0x22, 0xD2 },
-		{ 0x2C, 0x83 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x03 },
-	} 
-}, {
-	{ /* input 5 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0x78 },
-		{ 0x21, 0x07 }, // 0x03,
-		{ 0x22, 0xD2 },
-		{ 0x2C, 0x83 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ?
-		{ 0x21, 0x03 },
-	}
-}, {
-	{ /* input 6 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x59 },
-		{ 0x21, 0x17 },
-		{ 0x22, 0x42 },
-		{ 0x2C, 0xA3 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 },
-		{ 0x21, 0x12 },
-	}
-}, {
-	{ /* input 7 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x9A },
-		{ 0x21, 0x17 },
-		{ 0x22, 0xB1 },
-		{ 0x2C, 0x13 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 },
-		{ 0x21, 0x14 },
-	}
-}, {
-	{ /* input 8 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x3C },
-		{ 0x21, 0x27 },
-		{ 0x22, 0xC1 },
-		{ 0x2C, 0x23 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 },
-		{ 0x21, 0x21 },
-	}
-}	
-};
-
-#endif

--------------050307080302070508000206--

