Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGaOdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGaOdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWGaOdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:33:13 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:54360 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932282AbWGaOdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:33:12 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-rc3] build fixes:  tps65010
Date: Mon, 31 Jul 2006 07:25:33 -0700
User-Agent: KMail/1.7.1
Cc: i2c@lm-sensors.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eLhzE1xZsBMaPTC"
Message-Id: <200607310725.34094.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eLhzE1xZsBMaPTC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_eLhzE1xZsBMaPTC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tps65010.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tps65010.patch"

The tps65010.c driver in the main tree never got updated with
build fixes since the last batch of I2C driver changes; and the
genirq trigger flags were updated wierdly too.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/drivers/i2c/chips/tps65010.c
===================================================================
--- o26.orig/drivers/i2c/chips/tps65010.c	2006-07-30 22:09:03.000000000 -0700
+++ o26/drivers/i2c/chips/tps65010.c	2006-07-31 04:56:47.000000000 -0700
@@ -43,13 +43,12 @@
 /*-------------------------------------------------------------------------*/
 
 #define	DRIVER_VERSION	"2 May 2005"
-#define	DRIVER_NAME	(tps65010_driver.name)
+#define	DRIVER_NAME	(tps65010_driver.driver.name)
 
 MODULE_DESCRIPTION("TPS6501x Power Management Driver");
 MODULE_LICENSE("GPL");
 
 static unsigned short normal_i2c[] = { 0x48, /* 0x49, */ I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 I2C_CLIENT_INSMOD;
 
@@ -520,15 +519,16 @@ tps65010_probe(struct i2c_adapter *bus, 
 		goto fail1;
 	}
 
+	/* IRQ is active low, but some gpio lines can't support that */
+	irqflags = IRQF_SAMPLE_RANDOM;
 #ifdef	CONFIG_ARM
-	irqflags = IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_LOW;
 	if (machine_is_omap_h2()) {
 		tps->model = TPS65010;
 		omap_cfg_reg(W4_GPIO58);
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		irqflags |= IRQF_TRIGGER_FALLING;
+		irqflags |= IRQF_TRIGGER_LOW;
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -543,8 +543,6 @@ tps65010_probe(struct i2c_adapter *bus, 
 
 		// FIXME set up this board's IRQ ...
 	}
-#else
-	irqflags = IRQF_SAMPLE_RANDOM;
 #endif
 
 	if (tps->irq > 0) {

--Boundary-00=_eLhzE1xZsBMaPTC--
