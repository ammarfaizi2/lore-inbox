Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUBWVHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUBWVG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:06:58 -0500
Received: from mail.convergence.de ([212.84.236.4]:46826 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261971AbUBWVE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:04:58 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 5/9] Misc. DVB frontend updates
In-Reply-To: <107757028289@convergence.de>
Message-Id: <10775702834136@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:04:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] alps_tdlb7 + alps_tdmb7: Changed to use full i2c reads in probing instead of i2c pings to be compatable with ttusb
- [DVB] nxt6000: bugfix by Robert Cook: FE_RESET did the same as FE_INIT, thus invalidating current channel settings on FE_RESET
- [DVB] sp887x: fixed typo
- [DVB] Makefile: add nxt6000 frontend driver to Makefiles
- [DVB] Kconfig: DVB_TDA1004X and DVB_NXT6000 do not depend on !STANDALONE (i.e. no compile-time firmware image necessary)
- [DVB] ves1820: turn off ves1820 test output pins
- [DVB] ves1820: verbose-print AFC only if carrier has been recovered
- [DVB] ves1820: change AFC handling as suggested by Robert Schlabbach, use bit 1 of the SYNC register for FE_HAS_SIGNAL
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.3.p/drivers/media/dvb/frontends/alps_tdlb7.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/alps_tdlb7.c	2003-12-18 12:54:50.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/alps_tdlb7.c	2004-02-02 19:28:30.000000000 +0100
@@ -664,11 +663,14 @@
 
 static int tdlb7_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-	struct i2c_msg msg = { addr: 0x71, flags: 0, buf: NULL, len: 0 };
+        u8 b0 [] = { 0x02 , 0x00 };
+        u8 b1 [] = { 0, 0 };
+        struct i2c_msg msg [] = { { addr: 0x71, flags: 0, buf: b0, len: 2 },
+                                  { addr: 0x71, flags: I2C_M_RD, buf: b1, len: 2 } };
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (i2c->xfer (i2c, &msg, 1) != 1)
+        if (i2c->xfer (i2c, msg, 2) != 2)
                 return -ENODEV;
 
 	sp8870_firmware_upload(i2c);
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.3.p/drivers/media/dvb/frontends/alps_tdmb7.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/alps_tdmb7.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/alps_tdmb7.c	2004-02-02 19:28:30.000000000 +0100
@@ -404,11 +404,14 @@
 
 static int tdmb7_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-	struct i2c_msg msg = { .addr = 0x43, .flags = 0, .buf = NULL,. len = 0 };
+        u8 b0 [] = { 0x7 };
+        u8 b1 [] = { 0 };
+        struct i2c_msg msg [] = { { .addr = 0x43, .flags = 0, .buf = b0, .len = 1 },
+                                  { .addr = 0x43, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (i2c->xfer (i2c, &msg, 1) != 1)
+        if (i2c->xfer (i2c, msg, 2) != 2)
                 return -ENODEV;
 
 	return dvb_register_frontend (tdmb7_ioctl, i2c, NULL, &tdmb7_info);
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/nxt6000.c linux-2.6.3.p/drivers/media/dvb/frontends/nxt6000.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/nxt6000.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/nxt6000.c	2004-02-02 19:28:30.000000000 +0100
@@ -758,11 +653,11 @@
 		}
 	
 		case FE_INIT:
-		case FE_RESET:
-		
 			nxt6000_reset(fe);
 			nxt6000_setup(fe);
+		break;
 
+	case FE_RESET:
 			break;
 		
 		case FE_SET_FRONTEND:
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/sp887x.c linux-2.6.3.p/drivers/media/dvb/frontends/sp887x.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/sp887x.c	2004-01-09 09:22:40.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/sp887x.c	2004-02-23 12:52:31.000000000 +0100
@@ -57,7 +57,7 @@
 
 static
 struct dvb_frontend_info sp887x_info = {
-	.name = "Microtune MT7072DTF",
+	.name = "Microtune MT7202DTF",
 	.type = FE_OFDM,
 	.frequency_min =  50500000,
 	.frequency_max = 858000000,
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/Kconfig linux-2.6.3.p/drivers/media/dvb/frontends/Kconfig
--- xx-linux-2.6.3/drivers/media/dvb/frontends/Kconfig	2004-01-09 09:22:39.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/Kconfig	2004-02-23 12:52:31.000000000 +0100
@@ -154,8 +153,8 @@
 	  right one will get autodetected.
 
 config DVB_TDA1004X
-	tristate "Frontends with external TDA1004X demodulators (OFDM)"
-	depends on DVB_CORE && !STANDALONE
+	tristate "Frontends with external TDA10045H or TDA10046H demodulators (OFDM)"
+	depends on DVB_CORE
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
@@ -173,3 +172,15 @@
             wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
             unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
             mv ttlcdacc.dll /usr/lib/hotplug/firmware/tda1004x.bin
+	  Note: even if you're using a USB device, you MUST get the file from the
+	  TechnoTrend PCI drivers.
+
+config DVB_NXT6000
+	tristate "Frontends with NxtWave Communications NXT6000 demodulator (OFDM)"
+	depends on DVB_CORE
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  If you don't know what tuner module is soldered on your
+	  DVB adapter simply enable all supported frontends, the
+	  right one will get autodetected.
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/Makefile linux-2.6.3.p/drivers/media/dvb/frontends/Makefile
--- xx-linux-2.6.3/drivers/media/dvb/frontends/Makefile	2004-01-09 09:22:39.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/Makefile	2004-02-09 18:30:22.000000000 +0100
@@ -17,3 +17,4 @@
 obj-$(CONFIG_DVB_VES1X93) += ves1x93.o
 obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
 obj-$(CONFIG_DVB_SP887X) += sp887x.o
+obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/ves1820.c linux-2.6.3.p/drivers/media/dvb/frontends/ves1820.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/ves1820.c	2004-02-23 12:35:57.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/ves1820.c	2004-02-23 12:52:31.000000000 +0100
@@ -120,7 +120,7 @@
 static u8 ves1820_inittab [] =
 {
 	0x69, 0x6A, 0x9B, 0x12, 0x12, 0x46, 0x26, 0x1A,
-	0x43, 0x6A, 0xAA, 0xAA, 0x1E, 0x85, 0x43, 0x28,
+	0x43, 0x6A, 0xAA, 0xAA, 0x1E, 0x85, 0x43, 0x20,
 	0xE0, 0x00, 0xA1, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
 	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -380,7 +380,7 @@
 
                 sync = ves1820_readreg (fe, 0x11);
 
-		if (sync & 2)
+		if (sync & 1)
 			*status |= FE_HAS_SIGNAL;
 
 		if (sync & 2)
@@ -440,13 +440,14 @@
 		s8 afc = 0;
                 
                 sync = ves1820_readreg (fe, 0x11);
-		if (sync & 2)
-			/* AFC only valid when carrier has been recovered */
 			afc = ves1820_readreg(fe, 0x19);
-		if (verbose)
-			printk ("DVB: VES1820(%d): AFC (%d) %dHz\n",
+		if (verbose) {
+			/* AFC only valid when carrier has been recovered */
+			printk(sync & 2 ? "DVB: VES1820(%d): AFC (%d) %dHz\n" :
+					  "DVB: VES1820(%d): [AFC (%d) %dHz]\n",
 					fe->i2c->adapter->num, afc,
-				-((s32)(p->u.qam.symbol_rate >> 3) * afc >> 7));
+			       -((s32)p->u.qam.symbol_rate * afc) >> 10);
+		}
 
 		p->inversion = HAS_INVERSION(reg0) ? INVERSION_ON : INVERSION_OFF;
 		p->u.qam.modulation = ((reg0 >> 2) & 7) + QAM_16;
@@ -454,9 +455,8 @@
 		p->u.qam.fec_inner = FEC_NONE;
 
 		p->frequency = ((p->frequency + 31250) / 62500) * 62500;
-		/* To prevent overflow, shift symbol rate first a
-		   couple of bits. */
-		p->frequency -= (s32)(p->u.qam.symbol_rate >> 3) * afc >> 7;
+		if (sync & 2)
+			p->frequency -= ((s32)p->u.qam.symbol_rate * afc) >> 10;
 		break;
 	}
 	case FE_SLEEP:


