Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUA3MV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUA3MVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 07:21:55 -0500
Received: from mail.convergence.de ([212.84.236.4]:16019 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263620AbUA3MVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 07:21:48 -0500
Message-ID: <401A4C57.4030000@convergence.de>
Date: Fri, 30 Jan 2004 13:21:43 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] dvb subsystem and saa7146 v4l fixes
Content-Type: multipart/mixed;
 boundary="------------060502070602050101020100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060502070602050101020100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus, Andrew,

the attached joint patch fixes some issues in the dvb subsystem and some 
nasty things in the v4l saa7146 driver.

Detailed informations can be found at the top of the patch.

Please apply. Thanks!

CU
Michael.

--------------060502070602050101020100
Content-Type: text/plain;
 name="dvb-subsystem-and-saa7146-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-subsystem-and-saa7146-fixes.diff"

[DVB] - dvb-core: aquire -> acquire spelling fix
[DVB] - nxt600 frontend: don't send zero-byte messages when probing the PLL type
[DVB] - Kconfig: add a note that says that the CI of the budget-CI card is not actually supported by the budget-CI driver
[DVB] - ttusb-dec: Check for presence of crc32 function. Make unknown types of packet less likely to cause packet loss.
[V4L] - saa7146: use kernel mint_t()/max_t() instead of homebrewn stuff
[V4L] - saa7146: disable video clipping before capturing for sure to prevent black pictures
[V4L] - saa7146: make sure to disable the right video dma upon device close
[V4L] - saa7146: don't free resources if disabling an already disabled video overlay
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/common/saa7146_hlp.c linux-2.6.2-rc2.pp/drivers/media/common/saa7146_hlp.c
--- linux-2.6.2-rc2/drivers/media/common/saa7146_hlp.c	2004-01-27 10:24:59.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/common/saa7146_hlp.c	2004-01-26 13:55:48.000000000 +0100
@@ -1,10 +1,6 @@
+#include <linux/kernel.h>
 #include <media/saa7146_vv.h>
 
-#define my_min(type,x,y) \
-	({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
-#define my_max(type,x,y) \
-	({ type __x = (x), __y = (y); __x > __y ? __x: __y; })
-
 static void calculate_output_format_register(struct saa7146_dev* saa, u32 palette, u32* clip_format)
 {
 	/* clear out the necessary bits */
@@ -398,11 +394,11 @@
 		b = y[i]+h[i];
 		
 		/* insert left/right coordinates */
-		pixel_list[ 2*i   ] = my_min(int, l, width);
-		pixel_list[(2*i)+1] = my_min(int, r, width);
+		pixel_list[ 2*i   ] = min_t(int, l, width);
+		pixel_list[(2*i)+1] = min_t(int, r, width);
 		/* insert top/bottom coordinates */
-		line_list[ 2*i   ] = my_min(int, t, height);
-		line_list[(2*i)+1] = my_min(int, b, height);
+		line_list[ 2*i   ] = min_t(int, t, height);
+		line_list[(2*i)+1] = min_t(int, b, height);
 	}
 
 	/* sort and eliminate lists */
@@ -411,9 +407,9 @@
 	sort_and_eliminate( &line_list[0], &cnt_line );
 
 	/* calculate the number of used u32s */
-	numdwords = my_max(int, (cnt_line+1), (cnt_pixel+1))*2; 
-	numdwords = my_max(int, 4, numdwords);
-	numdwords = my_min(int, 64, numdwords);
+	numdwords = max_t(int, (cnt_line+1), (cnt_pixel+1))*2;
+	numdwords = max_t(int, 4, numdwords);
+	numdwords = min_t(int, 64, numdwords);
 
 	/* fill up cliptable */
 	for(i = 0; i < cnt_pixel; i++) {
@@ -1022,6 +1018,7 @@
 
 	saa7146_set_window(dev, buf->fmt->width, buf->fmt->height, buf->fmt->field);
 	saa7146_set_output_format(dev, sfmt->trans);
+	saa7146_disable_clipping(dev);
 
 	if ( vv->last_field == V4L2_FIELD_INTERLACED ) {
 	} else if ( vv->last_field == V4L2_FIELD_TOP ) {
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/common/saa7146_video.c linux-2.6.2-rc2.pp/drivers/media/common/saa7146_video.c
--- linux-2.6.2-rc2/drivers/media/common/saa7146_video.c	2004-01-27 10:24:59.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/common/saa7146_video.c	2004-01-27 10:28:47.000000000 +0100
@@ -755,7 +755,7 @@
 		dmas = MASK_22 | MASK_21 | MASK_20;
 	} else {
 		resource = RESOURCE_DMA1_HPS;
-		dmas = MASK_20;
+		dmas = MASK_22;
 	}
 	saa7146_res_free(fh, resource);
 
@@ -1110,6 +1116,9 @@
 				DEB_D(("overlay is active, but in another open\n"));
 					return -EAGAIN;
 				}
+		} else {
+			DEB_D(("overlay is not active\n"));
+			return 0;		
 			}
 			spin_lock_irqsave(&dev->slock,flags);
 			err = saa7146_stop_preview(fh);
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.2-rc2.pp/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.2-rc2/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-01-26 12:19:58.000000000 +0100
@@ -67,7 +67,7 @@
 	pid_t thread_pid;
 	unsigned long release_jiffies;
 	unsigned long lost_sync_jiffies;
-	int aquire_signal;
+	int acquire_signal;
 	int bending;
 	int lnb_drift;
 	int timeout_count;
@@ -306,7 +306,7 @@
 		fe->lost_sync_count = 0;
 		fe->lost_sync_jiffies = jiffies;
 		fe->lnb_drift = 0;
-		fe->aquire_signal = 1;
+		fe->acquire_signal = 1;
 		if (fe->status & ~FE_TIMEDOUT)
 			dvb_frontend_add_event (fe, 0);
 		memcpy (&fe->parameters, param,
@@ -467,13 +467,13 @@
 		if (s & FE_HAS_LOCK) {
 			fe->timeout_count = 0;
 			fe->lost_sync_count = 0;
-			fe->aquire_signal = 0;
+			fe->acquire_signal = 0;
 		} else {
 			fe->lost_sync_count++;
 			if (!(fe->info->caps & FE_CAN_RECOVER)) {
 				if (!(fe->info->caps & FE_CAN_CLEAN_SETUP)) {
 					if (fe->lost_sync_count < 10) {
-						if (fe->aquire_signal)
+						if (fe->acquire_signal)
 							dvb_frontend_internal_ioctl(
 									&fe->frontend,
 									FE_RESET, NULL);
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.2-rc2.pp/drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.6.2-rc2/drivers/media/dvb/frontends/alps_tdmb7.c	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/frontends/alps_tdmb7.c	2004-01-26 12:19:59.000000000 +0100
@@ -374,7 +374,7 @@
 		cx22700_set_inversion (i2c, p->inversion);
                 cx22700_set_tps (i2c, &p->u.ofdm);
 		cx22700_writereg (i2c, 0x37, 0x01);  /* PAL loop filter off */
-		cx22700_writereg (i2c, 0x00, 0x01);  /* restart aquire */
+		cx22700_writereg (i2c, 0x00, 0x01);  /* restart acquire */
                 break;
         }
 
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/ttpci/Kconfig linux-2.6.2-rc2.pp/drivers/media/dvb/ttpci/Kconfig
--- linux-2.6.2-rc2/drivers/media/dvb/ttpci/Kconfig	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/ttpci/Kconfig	2004-01-26 12:19:59.000000000 +0100
@@ -66,6 +66,9 @@
 	  (so called Budget- or Nova-PCI cards) without onboard
 	  MPEG2 decoder, but with onboard Common Interface connector.
 
+	  Note: The Common Interface is not yet supported by this driver
+	  due to lack of information from the vendor.
+
 	  Say Y if you own such a card and want to use it.
 
 	  To compile this driver as a module, choose M here: the
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/frontends/nxt6000.c linux-2.6.2-rc2.pp/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.6.2-rc2/drivers/media/dvb/frontends/nxt6000.c	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/frontends/nxt6000.c	2004-01-26 12:19:59.000000000 +0100
@@ -123,7 +113,19 @@
 	struct nxt6000_config *nxt = FE2NXT(fe);
 
 	return nxt6000_read(fe->i2c, nxt->demod_addr, reg);
+}
+
+static int pll_test(struct dvb_i2c_bus *i2c, u8 demod_addr, u8 tuner_addr)
+{
+	u8 buf [1];
+	struct i2c_msg msg = {.addr = tuner_addr >> 1,.flags = I2C_M_RD,.buf = buf,.len = 1 };
+	int ret;
 
+	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x01);	/* open i2c bus switch */
+	ret = i2c->xfer(i2c, &msg, 1);
+	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x00);	/* close i2c bus switch */
+
+	return (ret != 1) ? -EFAULT : 0;
 }
 
 static int pll_write(struct dvb_i2c_bus *i2c, u8 demod_addr, u8 tuner_addr, u8 *buf, u8 len)
@@ -833,21 +730,21 @@
 		if (nxt6000_read(i2c, demod_addr_tbl[addr_nr], OFDM_MSC_REV) != NXT6000ASICDEVICE)
 			continue;
 
-		if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC0, NULL, 0) == 0) {
+		if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC0) == 0) {
 			nxt->tuner_addr = 0xC0;
 			nxt->tuner_type = TUNER_TYPE_ALP510;
 			nxt->clock_inversion = 1;
 	
 			dprintk("nxt6000: detected TI ALP510 tuner at 0x%02X\n", nxt->tuner_addr);
 		
-		} else if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC2, NULL, 0) == 0) {
+		} else if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC2) == 0) {
 			nxt->tuner_addr = 0xC2;
 			nxt->tuner_type = TUNER_TYPE_SP5659;
 			nxt->clock_inversion = 0;
 
 			dprintk("nxt6000: detected MITEL SP5659 tuner at 0x%02X\n", nxt->tuner_addr);
 		
-		} else if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC0, NULL, 0) == 0) {
+		} else if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC0) == 0) {
 			nxt->tuner_addr = 0xC0;
 			nxt->tuner_type = TUNER_TYPE_SP5730;
 			nxt->clock_inversion = 0;
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.2-rc2.pp/drivers/media/dvb/ttusb-dec/Kconfig
--- linux-2.6.2-rc2/drivers/media/dvb/ttusb-dec/Kconfig	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/ttusb-dec/Kconfig	2004-01-26 12:19:59.000000000 +0100
@@ -2,6 +2,7 @@
 	tristate "Technotrend/Hauppauge USB DEC devices"
 	depends on DVB_CORE && USB
 	select FW_LOADER
+	select CRC32
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'DEC2000-t'
diff -uNrwB --new-file linux-2.6.2-rc2/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.2-rc2.pp/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.2-rc2/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-01-27 10:24:58.000000000 +0100
+++ linux-2.6.2-rc2.pp/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-01-26 12:19:59.000000000 +0100
@@ -552,13 +558,14 @@
 			break;
 
 		case 3:
-			if (*b++ == 0x00) {
+			if (*b == 0x00) {
 				dec->packet_state++;
 				dec->packet_length = 0;
-			} else {
+			} else if (*b != 0xaa) {
 				dec->packet_state = 0;
 			}
 
+			b++;
 			length--;
 			break;
 

--------------060502070602050101020100--
