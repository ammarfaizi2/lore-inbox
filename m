Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTLXXC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLXXC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 18:02:59 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:60425 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264113AbTLXXC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 18:02:56 -0500
Date: Thu, 25 Dec 2003 00:03:52 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave (4/5)
Message-Id: <20031225000352.4eea6856.khali@linux-fr.org>
In-Reply-To: <20031224225707.749707e5.khali@linux-fr.org>
References: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't really focus on the i2c subsystem, but one part of it
belongs to this subsystem. It fixes the dependancies between the various
SCx200 drivers, which happen to be incorrect at the time being. This is
a modified version of a patch I had previously submitted on the LKML,
but wasn't quite correct.

The patch also fixes Configure.help a bit for these drivers.

I've sent a similar (but smaller) patch to Greg KH for Linux 2.6, which
also has a few incorrectnesses in SCx200 driver dependancies.

Merry Christmas everyone :)

diff -ru linux-2.4.24-pre2/Documentation/Configure.help linux-2.4.24-pre2-k4/Documentation/Configure.help
--- linux-2.4.24-pre2/Documentation/Configure.help	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k4/Documentation/Configure.help	Tue Dec 23 22:58:53 2003
@@ -28276,6 +28276,14 @@
   This support is also available as a module.  If compiled as a
   module, it will be called scx200.o.
 
+NatSemi SCx200 GPIO support
+CONFIG_SCx200_GPIO
+  Give userspace access to the GPIO pins on the National
+  Semiconductor SCx200 processors.
+
+  This support is also available as a module.  If compiled as a
+  module, it will be called scx200_gpio.o.
+
 NatSemi SCx200 Watchdog
 CONFIG_SCx200_WDT
   Enable the built-in watchdog timer support on the National 
@@ -28427,7 +28435,7 @@
   If compiled as a module, it will be called uclinux.o.
 
 NatSemi SCx200 I2C using GPIO pins
-CONFIG_SCx200_GPIO
+CONFIG_SCx200_I2C
   Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
   If you don't know what to do here, say N.
diff -ru linux-2.4.24-pre2/drivers/char/Config.in linux-2.4.24-pre2-k4/drivers/char/Config.in
--- linux-2.4.24-pre2/drivers/char/Config.in	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k4/drivers/char/Config.in	Tue Dec 23 22:58:53 2003
@@ -285,7 +285,8 @@
    fi
    tristate 'NetWinder flash support' CONFIG_NWFLASH
 fi
-dep_tristate 'NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
+tristate 'NatSemi SCx200 Support' CONFIG_SCx200
+dep_tristate '  NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
 
 if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ] ; then
    bool 'SGI SN2 fetchop support' CONFIG_FETCHOP
diff -ru linux-2.4.24-pre2/drivers/char/Makefile linux-2.4.24-pre2-k4/drivers/char/Makefile
--- linux-2.4.24-pre2/drivers/char/Makefile	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k4/drivers/char/Makefile	Tue Dec 23 22:58:53 2003
@@ -288,7 +288,8 @@
 obj-$(CONFIG_DZ) += dz.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
-obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o scx200.o
+obj-$(CONFIG_SCx200) += scx200.o
+obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
diff -ru linux-2.4.24-pre2/drivers/i2c/Config.in linux-2.4.24-pre2-k4/drivers/i2c/Config.in
--- linux-2.4.24-pre2/drivers/i2c/Config.in	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k4/drivers/i2c/Config.in	Tue Dec 23 22:58:53 2003
@@ -18,8 +18,9 @@
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
          int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13
       fi
-      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
    fi
+
+   dep_tristate 'NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
