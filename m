Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTJIKz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJIKyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:54:12 -0400
Received: from mail.convergence.de ([212.84.236.4]:43684 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261976AbTJIKr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:58 -0400
Subject: [PATCH 6/7] Misc. fixes for AT76C651 DVB frontend driver
In-Reply-To: <10656964763874@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:56 +0200
Message-Id: <1065696476413@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] fixed some return values in device attach functions
- [DVB] allow private data to be associated with frontend devices here, too
- [DVB] misc bugfixes and performance improvements (endianess, function split up)
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/at76c651.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/at76c651.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/at76c651.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/at76c651.c	2003-10-09 10:44:10.000000000 +0200
@@ -37,6 +37,8 @@
 #include "dvb_functions.h"
 
 static int debug = 0;
+static u8 at76c651_qam;
+static u8 at76c651_revision;
 
 #define dprintk	if (debug) printk
 
@@ -53,7 +55,7 @@
 
 static struct dvb_frontend_info at76c651_info = {
 
-	.name = "Atmel AT76c651(B) with DAT7021",
+	.name = "Atmel AT76C651(B) with DAT7021",
 	.type = FE_QAM,
 	.frequency_min = 48250000,
 	.frequency_max = 863250000,
@@ -126,46 +128,70 @@
 
 }
 
+static int at76c651_reset(struct dvb_i2c_bus *i2c)
+{
+
+	return at76c651_writereg(i2c, 0x07, 0x01);
+
+}
+
+static int at76c651_disable_interrupts(struct dvb_i2c_bus *i2c)
+{
+
+	return at76c651_writereg(i2c, 0x0b, 0x00);
+
+}
+
 static int at76c651_set_auto_config(struct dvb_i2c_bus *i2c)
 {
 
+	/*
+	 * Autoconfig
+	 */
+
 	at76c651_writereg(i2c, 0x06, 0x01);
 
 	/*
-	 * performance optimizations 
+	 * Performance optimizations, should be done after autoconfig
 	 */
 
 	at76c651_writereg(i2c, 0x10, 0x06);
-	at76c651_writereg(i2c, 0x11, 0x10);
+	at76c651_writereg(i2c, 0x11, ((at76c651_qam == 5) || (at76c651_qam == 7)) ? 0x12 : 0x10);
 	at76c651_writereg(i2c, 0x15, 0x28);
 	at76c651_writereg(i2c, 0x20, 0x09);
-	at76c651_writereg(i2c, 0x24, 0x90);
+	at76c651_writereg(i2c, 0x24, ((at76c651_qam == 5) || (at76c651_qam == 7)) ? 0xC0 : 0x90);
+	at76c651_writereg(i2c, 0x30, 0x90);
+	if (at76c651_qam == 5)
+		at76c651_writereg(i2c, 0x35, 0x2A);
 
-	return 0;
+	/*
+	 * Initialize A/D-converter
+	 */
 
+	if (at76c651_revision == 0x11) {
+		at76c651_writereg(i2c, 0x2E, 0x38);
+		at76c651_writereg(i2c, 0x2F, 0x13);
 }
 
-static int at76c651_set_bbfreq(struct dvb_i2c_bus *i2c)
-{
+	at76c651_disable_interrupts(i2c);
 
-	at76c651_writereg(i2c, 0x04, 0x3f);
-	at76c651_writereg(i2c, 0x05, 0xee);
+	/*
+	 * Restart operation
+	 */
+
+	at76c651_reset(i2c);
 
 	return 0;
 
 }
 
-static int at76c651_reset(struct dvb_i2c_bus *i2c)
+static int at76c651_set_bbfreq(struct dvb_i2c_bus *i2c)
 {
 
-	return at76c651_writereg(i2c, 0x07, 0x01);
-
-}
-
-static int at76c651_disable_interrupts(struct dvb_i2c_bus *i2c)
-{
+	at76c651_writereg(i2c, 0x04, 0x3f);
+	at76c651_writereg(i2c, 0x05, 0xee);
 
-	return at76c651_writereg(i2c, 0x0b, 0x00);
+	return 0;
 
 }
 
@@ -186,6 +212,10 @@
 	struct i2c_msg msg =
 	    { .addr = 0xc2 >> 1, .flags = 0, .buf = (u8 *) & tw, .len = sizeof (tw) };
 
+#ifdef __LITTLE_ENDIAN
+	tw = __cpu_to_be32(tw);
+#endif
+
 	at76c651_switch_tuner_i2c(i2c, 1);
 
 	ret = i2c->xfer(i2c, &msg, 1);
@@ -236,7 +266,7 @@
 	u32 mantissa;
 
 	if (symbolrate > 9360000)
-		return -1;
+		return -EINVAL;
 
 	/*
 	 * FREF = 57800 kHz
@@ -258,34 +288,31 @@
 static int at76c651_set_qam(struct dvb_i2c_bus *i2c, fe_modulation_t qam)
 {
 
-	u8 qamsel = 0;
-
 	switch (qam) {
-
 	case QPSK:
-		qamsel = 0x02;
+		at76c651_qam = 0x02;
 		break;
 	case QAM_16:
-		qamsel = 0x04;
+		at76c651_qam = 0x04;
 		break;
 	case QAM_32:
-		qamsel = 0x05;
+		at76c651_qam = 0x05;
 		break;
 	case QAM_64:
-		qamsel = 0x06;
+		at76c651_qam = 0x06;
 		break;
 	case QAM_128:
-		qamsel = 0x07;
+		at76c651_qam = 0x07;
 		break;
 	case QAM_256:
-		qamsel = 0x08;
+		at76c651_qam = 0x08;
 		break;
 #if 0
 	case QAM_512:
-		qamsel = 0x09;
+		at76c651_qam = 0x09;
 		break;
 	case QAM_1024:
-		qamsel = 0x0A;
+		at76c651_qam = 0x0A;
 		break;
 #endif
 	default:
@@ -293,7 +320,7 @@
 
 	}
 
-	return at76c651_writereg(i2c, 0x03, qamsel);
+	return at76c651_writereg(i2c, 0x03, at76c651_qam);
 
 }
 
@@ -345,7 +371,6 @@
 	at76c651_set_qam(i2c, QAM_64);
 	at76c651_set_bbfreq(i2c);
 	at76c651_set_auto_config(i2c);
-	at76c651_disable_interrupts(i2c);
 
 	return 0;
 
@@ -408,13 +432,12 @@
 		{
 			u8 gain = ~at76c651_readreg(fe->i2c, 0x91);
 
-			*(s32 *) arg = (gain << 8) | gain;
-			*(s32 *) arg = 0x0FFF;
+			*(u16 *) arg = (gain << 8) | gain;
 			break;
 		}
 
 	case FE_READ_SNR:
-		*(s32 *) arg =
+		*(u16 *) arg =
 		    0xFFFF -
 		    ((at76c651_readreg(fe->i2c, 0x8F) << 8) |
 		     at76c651_readreg(fe->i2c, 0x90));
@@ -440,42 +463,31 @@
 		return at76c651_reset(fe->i2c);
 
 	default:
-		return -ENOSYS;
+		return -ENOIOCTLCMD;
 	}
 
 	return 0;
 
 }
 
-static int at76c651_attach(struct dvb_i2c_bus *i2c)
+static int at76c651_attach(struct dvb_i2c_bus *i2c, void **data)
+{
+	if ( (at76c651_readreg(i2c, 0x0E) != 0x65) ||
+	     ( ( (at76c651_revision = at76c651_readreg(i2c, 0x0F)) & 0xFE) != 0x10) )
 {
-
-	if (at76c651_readreg(i2c, 0x0e) != 0x65) {
-
 		dprintk("no AT76C651(B) found\n");
-
 		return -ENODEV;
-
 	}
 
-	if (at76c651_readreg(i2c, 0x0F) != 0x10) {
-
-		if (at76c651_readreg(i2c, 0x0F) == 0x11) {
-
-			dprintk("AT76C651B found\n");
-
-		} else {
-
-			dprintk("no AT76C651(B) found\n");
-
-			return -ENODEV;
-
+	if (at76c651_revision == 0x10)
+	{
+		dprintk("AT76C651A found\n");
+		strcpy(at76c651_info.name,"Atmel AT76C651A with DAT7021");
 		}
-
-	} else {
-
+	else
+	{
+		strcpy(at76c651_info.name,"Atmel AT76C651B with DAT7021");
 		dprintk("AT76C651B found\n");
-
 	}
 
 	at76c651_set_defaults(i2c);
@@ -480,19 +492,15 @@
 
 	at76c651_set_defaults(i2c);
 
-	dvb_register_frontend(at76c651_ioctl, i2c, NULL, &at76c651_info);
-
-	return 0;
+	return dvb_register_frontend(at76c651_ioctl, i2c, NULL, &at76c651_info);
 
 }
 
-static void at76c651_detach(struct dvb_i2c_bus *i2c)
+static void at76c651_detach(struct dvb_i2c_bus *i2c, void *data)
 {
 
 	dvb_unregister_frontend(at76c651_ioctl, i2c);
 
-	at76c651_disable_interrupts(i2c);
-
 }
 
 static int __init at76c651_init(void)
@@ -513,11 +521,7 @@
 module_init(at76c651_init);
 module_exit(at76c651_exit);
 
-#ifdef MODULE
 MODULE_DESCRIPTION("at76c651/dat7021 dvb-c frontend driver");
 MODULE_AUTHOR("Andreas Oberritter <andreas@oberritter.de>");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
 MODULE_PARM(debug, "i");
-#endif

