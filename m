Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVGNKsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVGNKsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVGNKsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:48:04 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:30957 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262993AbVGNKsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:48:02 -0400
Message-ID: <42D642DC.8080109@brturbo.com.br>
Date: Thu, 14 Jul 2005 07:47:56 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] V4L: Bug fixes at tuner, cx88 and tea5767 (against 2.6.13-rc3)
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040808030402010800050509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040808030402010800050509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040808030402010800050509
Content-Type: text/x-patch;
 name="v4l_bug_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_bug_fixes.diff"

- Bug fixes:
  1) On CX88 code, some cards needs to have audio reprogramed after 
changing video channel;
  2) Tuner autodetection code seems not to work on some cards. Now, 
no_autodetect insmod option allows disabling autodetection code;
  3) Minor fixes at tea5767 to reduce integer trunc;
  4) There are some new Pixelview Ultra Pro cards that doesn't use TEA5767 
for radio. As autodetection is capable of checking for tea, radio tuners 
and addresses removed.

- CX88 version number incremented.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-cards.c |    8 ++--
 linux/drivers/media/video/cx88/cx88-dvb.c   |    2 -
 linux/drivers/media/video/cx88/cx88-video.c |    7 +++-
 linux/drivers/media/video/cx88/cx88.h       |    6 +--
 linux/drivers/media/video/tea5767.c         |   34 +++++++++++---------
 linux/drivers/media/video/tuner-core.c      |   31 +++++++++++-------
 6 files changed, 52 insertions(+), 36 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.13/drivers/media/video/cx88/cx88.h	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88.h	2005-07-14 07:32:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.68 2005/07/07 14:17:47 mchehab Exp $
+ * $Id: cx88.h,v 1.69 2005/07/13 17:25:25 mchehab Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -35,8 +35,8 @@
 #include "btcx-risc.h"
 #include "cx88-reg.h"
 
-#include <linux/version.h>
-#define CX88_VERSION_CODE KERNEL_VERSION(0,0,4)
+#include <linux/utsname.h>
+#define CX88_VERSION_CODE KERNEL_VERSION(0,0,5)
 
 #ifndef TRUE
 # define TRUE (1==1)
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-14 07:32:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.85 2005/07/04 19:35:05 mkrufky Exp $
+ * $Id: cx88-cards.c,v 1.86 2005/07/14 03:06:43 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -682,9 +682,9 @@
 		.name           = "PixelView PlayTV Ultra Pro (Stereo)",
 		/* May be also TUNER_YMEC_TVF_5533MF for NTSC/M or PAL/M */
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-		.radio_type     = TUNER_TEA5767,
-		.tuner_addr	= 0xc2>>1,
-		.radio_addr	= 0xc0>>1,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-video.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-07-14 07:32:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.79 2005/07/07 14:17:47 mchehab Exp $
+ * $Id: cx88-video.c,v 1.80 2005/07/13 08:49:08 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -1346,6 +1346,11 @@
 		dev->freq = f->frequency;
 		cx88_newstation(core);
 		cx88_call_i2c_clients(dev->core,VIDIOC_S_FREQUENCY,f);
+
+		/* When changing channels it is required to reset TVAUDIO */
+		msleep (10);
+		cx88_set_tvaudio(core);
+
 		up(&dev->lock);
 		return 0;
 	}
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-14 07:32:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.41 2005/07/04 19:35:05 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.42 2005/07/12 15:44:55 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
diff -u linux-2.6.13/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.13/drivers/media/video/tuner-core.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-07-14 07:32:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.55 2005/07/08 13:20:33 mchehab Exp $
+ * $Id: tuner-core.c,v 1.58 2005/07/14 03:06:43 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -39,6 +39,9 @@
 static unsigned int addr = 0;
 module_param(addr, int, 0444);
 
+static unsigned int no_autodetect = 0;
+module_param(no_autodetect, int, 0444);
+
 /* insmod options used at runtime => read/write */
 unsigned int tuner_debug = 0;
 module_param(tuner_debug, int, 0644);
@@ -318,17 +321,19 @@
 	tuner_info("chip found @ 0x%x (%s)\n", addr << 1, adap->name);
 
 	/* TEA5767 autodetection code - only for addr = 0xc0 */
-	if (addr == 0x60) {
-		if (tea5767_autodetection(&t->i2c) != EINVAL) {
-			t->type = TUNER_TEA5767;
-			t->mode_mask = T_RADIO;
-			t->mode = T_STANDBY;
-			t->freq = 87.5 * 16; /* Sets freq to FM range */
-			default_mode_mask &= ~T_RADIO;
+	if (!no_autodetect) {
+		if (addr == 0x60) {
+			if (tea5767_autodetection(&t->i2c) != EINVAL) {
+				t->type = TUNER_TEA5767;
+				t->mode_mask = T_RADIO;
+				t->mode = T_STANDBY;
+				t->freq = 87.5 * 16; /* Sets freq to FM range */
+				default_mode_mask &= ~T_RADIO;
 
-			i2c_attach_client (&t->i2c);
-			set_type(&t->i2c,t->type, t->mode_mask);
-			return 0;
+				i2c_attach_client (&t->i2c);
+				set_type(&t->i2c,t->type, t->mode_mask);
+				return 0;
+			}
 		}
 	}
 
@@ -631,7 +636,9 @@
 			break;
 		}
 	default:
-		tuner_dbg("Unimplemented IOCTL 0x%08x called to tuner.\n", cmd);
+		tuner_dbg("Unimplemented IOCTL 0x%08x(dir=%d,tp=0x%02x,nr=%d,sz=%d)\n",
+					 cmd, _IOC_DIR(cmd), _IOC_TYPE(cmd),
+					_IOC_NR(cmd), _IOC_SIZE(cmd));
 		break;
 	}
 
diff -u linux-2.6.13/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.13/drivers/media/video/tea5767.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/tea5767.c	2005-07-14 07:32:17.000000000 -0300
@@ -2,7 +2,7 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.18 2005/07/07 03:02:55 mchehab Exp $
+ * $Id: tea5767.c,v 1.21 2005/07/14 03:06:43 mchehab Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -153,17 +153,17 @@
 
 	switch (TEA5767_HIGH_LO_32768) {
 	case TEA5767_HIGH_LO_13MHz:
-		frq = 1000 * (div * 50 - 700 - 225) / 4;	/* Freq in KHz */
+		frq = (div * 50000 - 700000 - 225000) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_LOW_LO_13MHz:
-		frq = 1000 * (div * 50 + 700 + 225) / 4;	/* Freq in KHz */
+		frq = (div * 50000 + 700000 + 225000) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_LOW_LO_32768:
-		frq = 1000 * (div * 32768 / 1000 + 700 + 225) / 4;	/* Freq in KHz */
+		frq = (div * 32768 + 700000 + 225000) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_HIGH_LO_32768:
 	default:
-		frq = 1000 * (div * 32768 / 1000 - 700 - 225) / 4;	/* Freq in KHz */
+		frq = (div * 32768 - 700000 - 225000) / 4;	/* Freq in KHz */
 		break;
 	}
 	buffer[0] = (div >> 8) & 0x3f;
@@ -196,7 +196,7 @@
 	unsigned div;
 	int rc;
 
-	tuner_dbg (PREFIX "radio freq counter %d\n", frq);
+	tuner_dbg (PREFIX "radio freq = %d.%03d MHz\n", frq/16000,(frq/16)%1000);
 
 	/* Rounds freq to next decimal value - for 62.5 KHz step */
 	/* frq = 20*(frq/16)+radio_frq[frq%16]; */
@@ -224,19 +224,19 @@
 		tuner_dbg ("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
 		buffer[2] |= TEA5767_HIGH_LO_INJECT;
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq * 4 / 16 + 700 + 225 + 25) / 50;
+		div = (frq * 4000 / 16 + 700000 + 225000 + 25000) / 50000;
 		break;
 	case TEA5767_LOW_LO_13MHz:
 		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
 
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq * 4 / 16 - 700 - 225 + 25) / 50;
+		div = (frq * 4000 / 16 - 700000 - 225000 + 25000) / 50000;
 		break;
 	case TEA5767_LOW_LO_32768:
 		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
 		buffer[3] |= TEA5767_XTAL_32768;
 		/* const 700=4000*175 Khz - to adjust freq to right value */
-		div = (1000 * (frq * 4 / 16 - 700 - 225) + 16384) >> 15;
+		div = ((frq * 4000 / 16 - 700000 - 225000) + 16384) >> 15;
 		break;
 	case TEA5767_HIGH_LO_32768:
 	default:
@@ -244,17 +244,21 @@
 
 		buffer[2] |= TEA5767_HIGH_LO_INJECT;
 		buffer[3] |= TEA5767_XTAL_32768;
-		div = (1000 * (frq * 4 / 16 + 700 + 225) + 16384) >> 15;
+		div = ((frq * (4000 / 16) + 700000 + 225000) + 16384) >> 15;
 		break;
 	}
 	buffer[0] = (div >> 8) & 0x3f;
 	buffer[1] = div & 0xff;
 
-	if (tuner_debug)
-		tea5767_status_dump(buffer);
-
 	if (5 != (rc = i2c_master_send(c, buffer, 5)))
 		tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
+
+	if (tuner_debug) {
+		if (5 != (rc = i2c_master_recv(c, buffer, 5)))
+			tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
+		else
+			tea5767_status_dump(buffer);
+	}
 }
 
 static int tea5767_signal(struct i2c_client *c)
@@ -294,7 +298,7 @@
 	struct tuner *t = i2c_get_clientdata(c);
 
 	if (5 != (rc = i2c_master_recv(c, buffer, 5))) {
-		tuner_warn("it is not a TEA5767. Received %i chars.\n", rc);
+		tuner_warn("It is not a TEA5767. Received %i bytes.\n", rc);
 		return EINVAL;
 	}
 
@@ -310,11 +314,11 @@
 	 *          bit 0   : internally set to 0
 	 *  Byte 5: bit 7:0 : == 0
 	 */
-
 	if (!((buffer[3] & 0x0f) == 0x00) && (buffer[4] == 0x00)) {
 		tuner_warn("Chip ID is not zero. It is not a TEA5767\n");
 		return EINVAL;
 	}
+
 	tuner_warn("TEA5767 detected.\n");
 	return 0;
 }

--------------040808030402010800050509--
