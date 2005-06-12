Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFLVe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFLVe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVFLVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:34:29 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:25007 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261215AbVFLVdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:33:55 -0400
Message-ID: <42ACAA3B.8050307@brturbo.com.br>
Date: Sun, 12 Jun 2005 18:33:47 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH] Adds support for TEA5767 chipset on V4L
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010601050106050803030904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601050106050803030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch adds support for TEA5767 FM radio tuner.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

PS.: This patch completes first series of synchronizing patches between
V4L CVS and 2.6.12-rc6-mm1.

PS 2: I'm resubmitting this patch. Please don't consider old patch.

PS 3: There were some I2C changes that affected V4L on 2.6.12-rc6-mm1. Now, it is necessary to use probe option in tuner to have its I2C addresses recognized by V4L. New patches will come to correct this behavior.


--------------010601050106050803030904
Content-Type: text/x-patch;
 name="patch06_tea5767.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch06_tea5767.patch"

diff -urN linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/Kconfig linux-2.6.12-rc6-mm1/drivers/media/video/Kconfig
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/Kconfig	2005-06-07 15:39:55.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/Kconfig	2005-06-12 11:55:18.000000000 -0300
@@ -7,7 +7,7 @@
 
 comment "Video Adapters"
 
-config CONFIG_TUNER_MULTI_I2C
+config TUNER_MULTI_I2C
 	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
 	depends on VIDEO_DEV && EXPERIMENTAL
 	---help---
@@ -16,7 +16,8 @@
 	  for some cards to allow tunning  both video and radio.
 	  It also improves I2C autodetection for these cards.
 
-	  Only few tuners currently is supporting this. More to come.
+	  Only few tuners currently is supporting this like those with 
+	  TEA5767 FM tuner. More to come.
 
 	  It is safe to say 'Y' here even if your card has only one I2C tuner.
 
diff -urN linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/Makefile linux-2.6.12-rc6-mm1/drivers/media/video/Makefile
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/Makefile	2005-06-07 15:38:09.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/Makefile	2005-06-12 11:55:38.000000000 -0300
@@ -7,7 +7,7 @@
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
-tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o
+tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
 
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
diff -urN linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tea5767.c linux-2.6.12-rc6-mm1/drivers/media/video/tea5767.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tea5767.c	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tea5767.c	2005-06-12 11:54:07.000000000 -0300
@@ -0,0 +1,282 @@
+/*
+ * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
+ * I2C address is allways 0xC0.
+ *
+ * $Id: tea5767.c,v 1.6 2005/06/10 10:57:18 mchehab Exp $
+ *
+ * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
+ * This code is placed under the terms of the GNU General Public License
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/videodev.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#include "tuner.h"
+#include "i2c-compat.h"
+#else
+#include <media/tuner.h>
+#endif
+
+#define PREFIX "TEA5767 "
+
+/* Write mode register values */
+
+/* First register */
+#define TEA5767_MUTE		0x80 /* Mutes output */
+#define TEA5767_SEARCH		0x40 /* Activates station search */
+/* Bits 0-5 for divider MSB */
+
+/* Second register */
+/* Bits 0-7 for divider LSB */
+
+/* Third register */
+
+/* Station search from botton to up */
+#define TEA5767_SEARCH_UP	0x80 
+
+/* Searches with ADC output = 10 */
+#define TEA5767_SRCH_HIGH_LVL	0x60 
+
+/* Searches with ADC output = 10 */
+#define TEA5767_SRCH_MID_LVL	0x40
+
+/* Searches with ADC output = 5 */
+#define TEA5767_SRCH_LOW_LVL	0x20
+
+/* if on, div=4*(Frf+Fif)/Fref otherwise, div=4*(Frf-Fif)/Freq) */
+#define TEA5767_HIGH_LO_INJECT	0x10
+
+/* Disable stereo */
+#define TEA5767_MONO		0x08 
+
+/* Disable right channel and turns to mono */
+#define TEA5767_MUTE_RIGHT	0x04
+
+/* Disable left channel and turns to mono */
+#define TEA5767_MUTE_LEFT	0x02
+
+#define TEA5767_PORT1_HIGH	0x01
+
+/* Forth register */
+#define TEA5767_PORT2_HIGH	0x80
+/* Chips stops working. Only I2C bus remains on */
+#define TEA5767_STDBY		0x40
+
+/* Japan freq (76-108 MHz. If disabled, 87.5-108 MHz */
+#define TEA5767_JAPAN_BAND	0x20 
+
+/* Unselected means 32.768 KHz freq as reference. Otherwise Xtal at 13 MHz */
+#define TEA5767_XTAL_32768	0x10
+
+/* Cuts weak signals */
+#define TEA5767_SOFT_MUTE	0x08
+
+/* Activates high cut control */
+#define TEA5767_HIGH_CUT_CTRL	0x04
+
+/* Activates stereo noise control */
+#define TEA5767_ST_NOISE_CTL	0x02
+
+/* If activate PORT 1 indicates SEARCH or else it is used as PORT1 */
+#define TEA5767_SRCH_IND	0x01
+
+/* Fiveth register */
+
+/* By activating, it will use Xtal at 13 MHz as reference for divider */
+#define TEA5767_PLLREF_ENABLE	0x80
+
+/* By activating, deemphasis=50, or else, deemphasis of 50us */
+#define TEA5767_DEEMPH_75	0X40
+/* Read mode register values */
+/* First register */
+#define TEA5767_READY_FLAG_MASK	0x80
+#define TEA5767_BAND_LIMIT_MASK	0X40
+/* Bits 0-5 for divider MSB after search or preset */
+
+/* Second register */
+/* Bits 0-7 for divider LSB after search or preset */
+
+/* Third register */
+#define TEA5767_STEREO_MASK	0x80
+#define TEA5767_IF_CNTR_MASK	0x7f
+
+/* Four register */
+#define TEA5767_ADC_LEVEL_MASK	0xf0
+
+/* should be 0 */
+#define TEA5767_CHIP_ID_MASK	0x0f
+
+/* Fiveth register */
+/* Reserved for future extensions */
+#define TEA5767_RESERVED_MASK	0xff
+
+
+static void set_tv_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	tuner_warn("This tuner doesn't support TV freq.\n");
+}
+
+/* Closest value table */
+/* int radio_frq[16]={ 0, 1, 2, 4, 5, 6, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18 }; */
+/*                     0  1  2  3  4  5  6  7   8   9  10  11  12  13  14  15 */
+
+/* radio adjust freq for odd channel frequencies used in US, Brazil, ... */
+int radio_frq[16]={ 0, 1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15, 17, 18, 19 };
+/*                  0  1  2  3  4  5  6  7   8   9  10  11  12  13  14  15 */
+
+/* radio adjust freq for even channel frequencies */
+/* int radio_frq[16]={ 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 19 }; */
+/*                     0  1  2  3  4  5  6  7   8   9  10  11  12  13  14  15 */
+
+static void set_radio_freq(struct i2c_client *c, unsigned int frq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+        unsigned char buffer[5];
+	unsigned div;
+	int rc;
+
+	printk(PREFIX "radio freq counter %d\n",frq);
+
+
+	/* Rounds freq to next decimal value */
+	frq = 20*(frq/16)+radio_frq[frq%16];
+
+	buffer[2] = TEA5767_PORT1_HIGH;
+	buffer[3] = TEA5767_PORT2_HIGH | TEA5767_HIGH_CUT_CTRL | TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND;
+	buffer[4]=0;
+	
+	switch (t->type) {
+	case TEA5767_HIGH_LO_13MHz:
+		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
+		buffer[2] |= TEA5767_HIGH_LO_INJECT;
+		buffer[4] |= TEA5767_PLLREF_ENABLE;
+		div = (frq*4000/20+225+25)/50;
+		break;
+	case TEA5767_LOW_LO_13MHz:
+		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
+		
+		buffer[4] |= TEA5767_PLLREF_ENABLE;
+		div = (frq*4000/20-225+25)/50;
+		break;
+	case TEA5767_LOW_LO_32768:
+		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
+		buffer[3] |= TEA5767_XTAL_32768;
+		/* const 700=4000*175 Khz - to adjust freq to right value */
+		div = (1000*(frq*4000/20-700-225)+16384)>>15;
+		break;
+	case TEA5767_HIGH_LO_32768:
+	default:
+		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 32,768 MHz\n");
+		
+		buffer[2] |= TEA5767_HIGH_LO_INJECT;
+		buffer[3] |= TEA5767_XTAL_32768;
+		div = (1000*(frq*4000/20+700+225)+16384)/32768;
+		break;
+	}
+        buffer[0] = (div>>8) & 0x3f;
+        buffer[1] = div      & 0xff;
+
+	tuner_dbg("TEA5767 radio SET 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+	       buffer[0],buffer[1],buffer[2],buffer[3],buffer[4]);
+
+        if (5 != (rc = i2c_master_send(c,buffer,5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n",rc);
+}
+
+static void tea5767_status_dump(unsigned char *buffer)
+{
+	unsigned int div;
+	
+	if (TEA5767_READY_FLAG_MASK & buffer[0])
+		printk(PREFIX "Ready Flag ON\n");
+	else
+		printk(PREFIX "Ready Flag OFF\n");
+	
+	if (TEA5767_BAND_LIMIT_MASK & buffer[0])
+		printk(PREFIX "Tuner at band limit\n");
+	else
+		printk(PREFIX "Tuner not at band limit\n");
+
+	div=((buffer[0]&0x3f)<<8) | buffer[1];
+	
+	printk(PREFIX "Frequency divider = 0x%4x\n",div);
+
+	if (TEA5767_STEREO_MASK & buffer[2])
+		printk(PREFIX "Stereo\n");
+	else
+		printk(PREFIX "Mono\n");
+
+	printk(PREFIX "IF Counter = %d\n",buffer[2] & TEA5767_IF_CNTR_MASK);
+	
+	printk(PREFIX "ADC Level = %d\n",(buffer[3] & TEA5767_ADC_LEVEL_MASK) >> 4);
+
+	printk(PREFIX "Chip ID = %d\n",(buffer[3] & TEA5767_CHIP_ID_MASK));
+
+	printk(PREFIX "Reserved = 0x%02x\n",(buffer[4] & TEA5767_RESERVED_MASK));
+}
+
+static int tea5767_signal(struct i2c_client *c)
+{
+	unsigned char buffer[5];
+	int rc;
+	struct tuner *t = i2c_get_clientdata(c);
+
+	memset(buffer,0,sizeof(buffer));
+        if (5 != (rc = i2c_master_recv(c,buffer,5)))
+                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+		
+	tuner_dbg("TEA5767 radio SIG GET 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+	       buffer[0],buffer[1],buffer[2],buffer[3],buffer[4]);
+
+	tea5767_status_dump(buffer);
+	return ((buffer[3] & TEA5767_ADC_LEVEL_MASK) <<(13-4));
+}
+
+static int tea5767_stereo(struct i2c_client *c)
+{
+	unsigned char buffer[5];
+	int rc;
+	struct tuner *t = i2c_get_clientdata(c);
+
+	memset(buffer,0,sizeof(buffer));
+        if (5 != (rc = i2c_master_recv(c,buffer,5)))
+                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+	
+//	tuner_dbg("TEA5767 radio ST GET 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+//	       buffer[0],buffer[1],buffer[2],buffer[3],buffer[4]);
+	       
+	rc = buffer[2] & TEA5767_STEREO_MASK;
+
+	tuner_dbg("TEA5767 radio ST GET = %02x\n", rc);
+	
+	return ( (buffer[2] & TEA5767_STEREO_MASK) ? V4L2_TUNER_SUB_STEREO: 0);
+}
+
+int tea5767_tuner_init(struct i2c_client *c)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+        tuner_info("type set to %d (%s)\n",
+                   t->type, TEA5767_TUNER_NAME);
+        strlcpy(c->name, TEA5767_TUNER_NAME, sizeof(c->name));
+
+	t->tv_freq    = set_tv_freq;
+	t->radio_freq = set_radio_freq;
+	t->has_signal = tea5767_signal;
+	t->is_stereo  = tea5767_stereo;
+
+	return (0);
+}
diff -urN linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tuner-core.c linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tuner-core.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c	2005-06-12 12:24:09.000000000 -0300
@@ -26,7 +26,6 @@
 /*
  * comment line bellow to return to old behavor, where only one I2C device is supported
  */
-#define CONFIG_TUNER_MULTI_I2C /**/
 
 #define UNSET (-1U)
 

--------------010601050106050803030904--
