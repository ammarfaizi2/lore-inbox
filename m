Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUENXrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUENXrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUENXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:46:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:20709 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264609AbUENX3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:54 -0400
Subject: [PATCH] I2C update for 2.6.6
In-Reply-To: <20040514232755.GA18395@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:16 -0700
Message-Id: <10845773561979@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.1, 2004/05/01 16:47:38-07:00, khali@linux-fr.org

[PATCH] I2C: Add LM99 support to the lm90 driver

The following patch adds support for the LM99 chip to the lm90 driver,
on popular request. The nVidia GeForce FX 5900 series cards have such a
chip on-board for monitoring the GPU temperature.

Relevant pointers:
http://archives.andrew.net.au/lm-sensors/msg07671.html
http://secure.netroedge.com/~lm78/readticket.cgi?ticket=1661
http://secure.netroedge.com/~lm78/readticket.cgi?ticket=1662

Additional effects of the patch:

* Do not consider the lm90 driver experimental anymore. I have had
enough testers and not a single problem report, the driver is working
OK.

* Support the LM89. According to the datasheets, it is exactly the same
chip as the LM99 (to the chip ID). We've never seen this chip in a
computer so far, but it doesn't cost anything to support it (actually we
cannot not support it, since we have no way to differenciate with the
LM99).

* Scan two addresses instead of one. The LM99 and LM89 have a "-1"
variant using an alternate address.

* Update copyright year.

* Reword the identification code a bit. It is hopefully slightly less
unreadable.

This patch was successfully tested by Corey Hickey.


 drivers/i2c/chips/Kconfig |    6 ++---
 drivers/i2c/chips/lm90.c  |   49 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 15 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri May 14 16:21:27 2004
+++ b/drivers/i2c/chips/Kconfig	Fri May 14 16:21:27 2004
@@ -136,11 +136,11 @@
 
 config SENSORS_LM90
 	tristate "National Semiconductor LM90 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
-	  If you say yes here you get support for National Semiconductor LM90
-	  and Analog Devices ADM1032 sensor chips.
+	  If you say yes here you get support for National Semiconductor LM90,
+	  LM89 and LM99, and Analog Devices ADM1032 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Fri May 14 16:21:27 2004
+++ b/drivers/i2c/chips/lm90.c	Fri May 14 16:21:27 2004
@@ -1,7 +1,7 @@
 /*
  * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2004  Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
@@ -10,6 +10,17 @@
  * obtained from National's website at:
  *   http://www.national.com/pf/LM/LM90.html
  *
+ * This driver also supports the LM89 and LM99, two other sensor chips
+ * made by National Semiconductor. Both have an increased remote
+ * temperature measurement accuracy (1 degree), and the LM99
+ * additionally shifts remote temperatures (measured and limits) by 16
+ * degrees, which allows for higher temperatures measurement. The
+ * driver doesn't handle it since it can be done easily in user-space.
+ * Complete datasheets can be obtained from National's website at:
+ *   http://www.national.com/pf/LM/LM89.html
+ *   http://www.national.com/pf/LM/LM99.html
+ * Note that there is no way to differenciate between both chips.
+ *
  * This driver also supports the ADM1032, a sensor chip made by Analog
  * Devices. That chip is similar to the LM90, with a few differences
  * that are not handled by this driver. Complete datasheet can be
@@ -45,9 +56,11 @@
 /*
  * Addresses to scan
  * Address is fully defined internally and cannot be changed.
+ * LM89, LM90, LM99 and ADM1032 have address 0x4c.
+ * LM89-1, and LM99-1 have address 0x4d.
  */
 
-static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
@@ -56,7 +69,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_2(lm90, adm1032);
+SENSORS_INSMOD_3(lm90, adm1032, lm99);
 
 /*
  * The LM90 registers
@@ -330,16 +343,26 @@
 			  LM90_REG_R_CHIP_ID);
 		
 		if (man_id == 0x01) { /* National Semiconductor */
-			if (chip_id >= 0x21 && chip_id < 0x30 /* LM90 */
-			 && (kind == 0 /* skip detection */
-			  || ((i2c_smbus_read_byte_data(new_client,
-				LM90_REG_R_CONFIG2) & 0xF8) == 0x00
-			   && reg_convrate <= 0x09))) {
-				kind = lm90;
+			u8 reg_config2;
+
+			reg_config2 = i2c_smbus_read_byte_data(new_client,
+				      LM90_REG_R_CONFIG2);
+
+			if (kind == 0 /* skip detection */
+			 || ((reg_config2 & 0xF8) == 0x00
+			  && reg_convrate <= 0x09)) {
+				if (address == 0x4C
+				 && (chip_id & 0xF0) == 0x20) { /* LM90 */
+					kind = lm90;
+				} else
+				if ((chip_id & 0xF0) == 0x30) { /* LM89/LM99 */
+					kind = lm99;
+				}
 			}
-		}
-		else if (man_id == 0x41) { /* Analog Devices */
-			if ((chip_id & 0xF0) == 0x40 /* ADM1032 */
+		} else
+		if (man_id == 0x41) { /* Analog Devices */
+			if (address == 0x4C
+			 && (chip_id & 0xF0) == 0x40 /* ADM1032 */
 			 && (kind == 0 /* skip detection */
 			  || (reg_config1 & 0x3F) == 0x00)) {
 				kind = adm1032;
@@ -358,6 +381,8 @@
 		name = "lm90";
 	} else if (kind == adm1032) {
 		name = "adm1032";
+	} else if (kind == lm99) {
+		name = "lm99";
 	}
 
 	/* We can fill in the remaining client fields */

