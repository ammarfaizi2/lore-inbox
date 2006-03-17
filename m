Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWCQD66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCQD66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 22:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCQD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 22:58:58 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:7386 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751240AbWCQD65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 22:58:57 -0500
Date: Thu, 16 Mar 2006 22:58:56 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne_lorrain@yahoo.fr>,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: [PATCH 2.6.16-rc6] i2c: require type parameter for i2c-parport and i2c-parport-light
Message-ID: <20060317035856.GB3446@jupiter.solarsys.private>
References: <20060316035916.GA10675@jupiter.solarsys.private> <3ZH07HE0.1142498811.4526410.khali@localhost> <20060317035616.GA3446@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317035616.GA3446@jupiter.solarsys.private>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch forces the user to specify what type of adapter is present when
loading i2c-parport or i2c-parport-light.  If none is specified, the driver
init simply fails - instead of assuming adapter type 0.

This alleviates the sometimes lengthy boot time delays which can be caused
by accidentally building one of these into a kernel along with several i2c
slave drivers that have lengthy probe routines (e.g. hwmon drivers).

Kconfig and documentation updated accordingly.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport-light.c
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport-light.c
@@ -121,9 +121,14 @@ static struct i2c_adapter parport_adapte
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	if (base == 0) {
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport.h
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport.h
@@ -90,7 +90,7 @@ static struct adapter_parm adapter_parm[
 	},
 };
 
-static int type;
+static int type = -1;
 module_param(type, int, 0);
 MODULE_PARM_DESC(type,
 	"Type of adapter:\n"
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport.c
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport.c
@@ -241,9 +241,14 @@ static struct parport_driver i2c_parport
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	return parport_register_driver(&i2c_parport_driver);
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.16-rc6/drivers/i2c/busses/Kconfig
@@ -284,7 +284,10 @@ config I2C_PARPORT
 	  This driver is a replacement for (and was inspired by) an older
 	  driver named i2c-philips-par.  The new driver supports more devices,
 	  and makes it easier to add support for new devices.
-	  
+
+	  An adapter type parameter is now mandatory.  Please read the file
+	  Documentation/i2c/busses/i2c-parport for details.
+
 	  Another driver exists, named i2c-parport-light, which doesn't depend
 	  on the parport driver.  This is meant for embedded systems. Don't say
 	  Y here if you intend to say Y or M there.
--- linux-2.6.16-rc6.orig/Documentation/i2c/busses/i2c-parport
+++ linux-2.6.16-rc6/Documentation/i2c/busses/i2c-parport
@@ -12,18 +12,21 @@ meant as a replacement for the older, in
                       teletext adapters)
 
 It currently supports the following devices:
- * Philips adapter
- * home brew teletext adapter
- * Velleman K8000 adapter
- * ELV adapter
- * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
- * Barco LPT->DVI (K5800236) adapter
+ * (type=0) Philips adapter
+ * (type=1) home brew teletext adapter
+ * (type=2) Velleman K8000 adapter
+ * (type=3) ELV adapter
+ * (type=4) Analog Devices ADM1032 evaluation board
+ * (type=5) Analog Devices evaluation boards: ADM1025, ADM103[01]
+ * (type=6) Barco LPT->DVI (K5800236) adapter
 
 These devices use different pinout configurations, so you have to tell
 the driver what you have, using the type module parameter. There is no
 way to autodetect the devices. Support for different pinout configurations
 can be easily added when needed.
 
+Earlier kernels defaulted to type=0 (Philips).  But now, if the type
+parameter is missing, the driver will simply fail to initialize.
 
 Building your own adapter
 -------------------------

-- 
Mark M. Hoffman
mhoffman@lightlink.com

