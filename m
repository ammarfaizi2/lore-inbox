Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTJHNrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJHNdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:33:05 -0400
Received: from mail.convergence.de ([212.84.236.4]:8929 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261552AbTJHN3A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:29:00 -0400
Subject: [PATCH 10/14] update dvb frontend drivers
In-Reply-To: <106561973797@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:58 +0200
Message-Id: <10656197382984@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] add budget driver as possible client of the ves1820 frontend driver
- [DVB] fix wrong include in sp887x.c frontend driver
- [DVB] fix wrong chip description in tda1004xh  frontend driver
- [DVB] fixed detection of stv0299 if chip is in standby mode
- [DVB] change some #ifdef to #if, for easier debug enable/disable
- [DVB] ves1820: patch by Peter Bieringer: nicer log output
- [DVB] ves1820: allow PWM (tuner calibaration) value from EEPROM to be overridden on command line (based on patch by Peter Bieringer). New module paramters: "pwm" (max 4 ints, range -1..0xff) and "verbose" (to print AFC value aftger tuning).
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/frontends/ves1820.c linux-2.6.0-test5/drivers/media/dvb/frontends/ves1820.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/frontends/ves1820.c	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/frontends/ves1820.c	2003-08-25 12:16:12.000000000 +0200
@@ -173,7 +173,8 @@
 	if (tuner_type == 0xff)     /*  PLL not reachable over i2c ...  */
 		return 0;
 
-	if (strstr (fe->i2c->adapter->name, "Technotrend"))
+	if (strstr (fe->i2c->adapter->name, "Technotrend") ||
+	    strstr (fe->i2c->adapter->name, "TT-Budget"))
 		ifreq = 35937500;
 	else
 		ifreq = 36125000;
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/sp887x.c linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.0-test6/drivers/media/dvb/frontends/sp887x.c	2003-10-01 12:25:24.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/sp887x.c	2003-09-16 10:01:00.000000000 +0200
@@ -4,7 +4,7 @@
 #include <linux/i2c.h>
 
 #include "dvb_frontend.h"
-#include "dvb_compat.h"
+#include "dvb_functions.h"
 
 
 #if 0
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/tda1004x.c linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.0-test6/drivers/media/dvb/frontends/tda1004x.c	2003-10-01 12:20:37.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/tda1004x.c	2003-09-10 11:59:54.000000000 +0200
@@ -1,5 +1,5 @@
   /*
-     Driver for Philips tda1004x OFDM Frontend
+     Driver for Philips tda1004xh OFDM Frontend
 
      This program is free software; you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/stv0299.c linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.0-test6/drivers/media/dvb/frontends/stv0299.c	2003-10-01 12:20:37.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/stv0299.c	2003-09-29 16:04:08.000000000 +0200
@@ -913,7 +913,10 @@
 static int uni0299_attach (struct dvb_i2c_bus *i2c)
 {
         long tuner_type;
-	u8 id = stv0299_readreg (i2c, 0x00);
+	u8 id;
+ 
+	stv0299_writereg (i2c, 0x02, 0x00); /* standby off */
+	id = stv0299_readreg (i2c, 0x00);
 
 	dprintk ("%s: id == 0x%02x\n", __FUNCTION__, id);
 
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/mt312.c linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.0-test6/drivers/media/dvb/frontends/mt312.c	2003-10-01 12:20:37.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/mt312.c	2003-09-16 10:01:00.000000000 +0200
@@ -85,7 +85,7 @@
 		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
 		return -EREMOTEIO;
 	}
-#ifdef MT312_DEBUG
+#if MT312_DEBUG
 	{
 		int i;
 		printk(KERN_INFO "R(%d):", reg & 0x7f);
@@ -106,7 +106,7 @@
 	u8 buf[count + 1];
 	struct i2c_msg msg;
 
-#ifdef MT312_DEBUG
+#if MT312_DEBUG
 	{
 		int i;
 		printk(KERN_INFO "W(%d):", reg & 0x7f);
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/ves1820.c linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.0-test6/drivers/media/dvb/frontends/ves1820.c	2003-10-01 12:25:36.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/ves1820.c	2003-10-01 13:01:43.000000000 +0200
@@ -36,6 +36,9 @@
 #define dprintk(x...)
 #endif
 
+#define MAX_UNITS 4
+static int pwm[MAX_UNITS] = { -1, -1, -1, -1 };
+static int verbose;
 
 /**
  *  since we need only a few bits to store internal state we don't allocate
@@ -116,9 +119,9 @@
 	ret = i2c->xfer (i2c, &msg, 1);
 
 	if (ret != 1)
-		dprintk("%s: writereg error "
+		printk("DVB: VES1820(%d): %s, writereg error "
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
-			__FUNCTION__, reg, data, ret);
+			fe->i2c->adapter->num, __FUNCTION__, reg, data, ret);
 
 	dvb_delay(10);
 	return (ret != 1) ? -EREMOTEIO : 0;
@@ -138,7 +141,8 @@
 	ret = i2c->xfer (i2c, msg, 2);
 
 	if (ret != 2)
-		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+		printk("DVB: VES1820(%d): %s: readreg error (ret == %i)\n",
+				fe->i2c->adapter->num, __FUNCTION__, ret);
 
 	return b1[0];
 }
@@ -152,7 +156,8 @@
         ret = i2c->xfer (i2c, &msg, 1);
 
         if (ret != 1)
-                printk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
+                printk("DVB: VES1820(%d): %s: i/o error (ret == %i)\n",
+				i2c->adapter->num, __FUNCTION__, ret);
 
         return (ret != 1) ? -EREMOTEIO : 0;
 }
@@ -233,7 +238,7 @@
 {
 	int i;
         
-        dprintk("VES1820: init chip\n");
+        dprintk("DVB: VES1820(%d): init chip\n", fe->i2c->adapter->num);
 
         ves1820_writereg (fe, 0, 0);
 
@@ -409,10 +414,11 @@
 		if (sync & 2)
 			/* AFC only valid when carrier has been recovered */
 			afc = ves1820_readreg(fe, 0x19);
-		printk ("%s: AFC (%d) %dHz\n", __FILE__, afc,
+		if (verbose)
+			printk ("DVB: VES1820(%d): AFC (%d) %dHz\n",
+					fe->i2c->adapter->num, afc,
 				-((s32)(p->u.qam.symbol_rate >> 3) * afc >> 7));
 
-
 		p->inversion = reg0 & 0x20 ? INVERSION_OFF : INVERSION_ON;
 		p->u.qam.modulation = ((reg0 >> 2) & 7) + QAM_16;
 
@@ -450,15 +456,14 @@
 
 	if (i2c->xfer(i2c, &msg1, 1) == 1) {
 		type = 0;
-		printk ("%s: setup for tuner spXXXX\n", __FILE__);
+		printk ("DVB: VES1820(%d): setup for tuner spXXXX\n", i2c->adapter->num);
 	} else if (i2c->xfer(i2c, &msg2, 1) == 1) {
 		type = 1;
-		printk ("%s: setup for tuner sp5659c\n", __FILE__);
+		printk ("DVB: VES1820(%d): setup for tuner sp5659c\n", i2c->adapter->num);
 	} else {
 		type = -1;
-		printk ("%s: unknown PLL, "
-			"please report to <linuxdvb@linuxtv.org>!!\n",
-			__FILE__);
+		printk ("DVB: VES1820(%d): unknown PLL, "
+			"please report to <linuxdvb@linuxtv.org>!!\n", i2c->adapter->num);
 	}
 
 	return type;
@@ -474,7 +479,7 @@
 
 	i2c->xfer (i2c, msg, 2);
 
-	dprintk("VES1820: pwm=%02x\n", pwm);
+	printk("DVB: VES1820(%d): pwm=0x%02x\n", i2c->adapter->num, pwm);
 
 	if (pwm == 0xff)
 		pwm = 0x48;
@@ -514,6 +519,12 @@
 	if ((tuner_type = probe_tuner(i2c)) < 0)
 		return -ENODEV;
 
+	if ((i2c->adapter->num < MAX_UNITS) && pwm[i2c->adapter->num] != -1) {
+		printk("DVB: VES1820(%d): pwm=0x%02x (user specified)\n",
+				i2c->adapter->num, pwm[i2c->adapter->num]);
+		SET_PWM(data, pwm[i2c->adapter->num]);
+	}
+	else
 	SET_PWM(data, read_pwm(i2c));
 	SET_REG0(data, ves1820_inittab[0]);
 	SET_TUNER(data, tuner_type);
@@ -533,6 +544,10 @@
 
 static int __init init_ves1820 (void)
 {
+	int i;
+	for (i = 0; i < MAX_UNITS; i++)
+		if (pwm[i] < -1 || pwm[i] > 255)
+			return -EINVAL;
 	return dvb_register_i2c_device (THIS_MODULE,
 					ves1820_attach, ves1820_detach);
 }
@@ -547,6 +562,11 @@
 module_init(init_ves1820);
 module_exit(exit_ves1820);
 
+MODULE_PARM(pwm, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(pwm, "override PWM value stored in EEPROM (tuner calibration)");
+MODULE_PARM(verbose, "i");
+MODULE_PARM_DESC(verbose, "print AFC offset after tuning for debugging the PWM setting");
+
 MODULE_DESCRIPTION("VES1820 DVB-C frontend driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");

