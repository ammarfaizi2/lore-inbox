Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUGOA0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUGOA0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUGOAZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:25:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:57579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266005AbUGOAJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:10 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <1089850026355@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:07 -0700
Message-Id: <10898500272030@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.4, 2004/07/08 16:07:05-07:00, khali@linux-fr.org

[PATCH] I2C: Add support for LM86, MAX6657 and MAX6658 to lm90

This adds support for the LM86, MAX6657 and MAX6658 sensor chips to the
lm90 driver. These are less popular than the LM90 and ADM1032 but
several users have reported to use these, so I added support to the lm90
driver. All these chips are fully compatible so that's just a matter of
accepting the new chip ids. I also slightly simplified the detection
code.


Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/Kconfig |    3 +-
 drivers/i2c/chips/lm90.c  |   69 ++++++++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 24 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2004-07-14 17:00:18 -07:00
+++ b/drivers/i2c/chips/Kconfig	2004-07-14 17:00:18 -07:00
@@ -150,7 +150,8 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
-	  LM89 and LM99, and Analog Devices ADM1032 sensor chips.
+	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
+	  MAX6658 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-07-14 17:00:18 -07:00
+++ b/drivers/i2c/chips/lm90.c	2004-07-14 17:00:18 -07:00
@@ -21,11 +21,26 @@
  *   http://www.national.com/pf/LM/LM99.html
  * Note that there is no way to differenciate between both chips.
  *
+ * This driver also supports the LM86, another sensor chip made by
+ * National Semiconductor. It is exactly similar to the LM90 except it
+ * has a higher accuracy.
+ * Complete datasheet can be obtained from National's website at:
+ *   http://www.national.com/pf/LM/LM86.html
+ *
  * This driver also supports the ADM1032, a sensor chip made by Analog
  * Devices. That chip is similar to the LM90, with a few differences
  * that are not handled by this driver. Complete datasheet can be
  * obtained from Analog's website at:
  *   http://products.analog.com/products/info.asp?product=ADM1032
+ * Among others, it has a higher accuracy than the LM90, much like the
+ * LM86 does.
+ *
+ * This driver also supports the MAX6657 and MAX6658, sensor chips made
+ * by Maxim. These chips are similar to the LM86. Complete datasheet
+ * can be obtained at Maxim's website at:
+ *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+ * Note that there is no way to differenciate between both chips (but
+ * no need either).
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -56,7 +71,7 @@
 /*
  * Addresses to scan
  * Address is fully defined internally and cannot be changed.
- * LM89, LM90, LM99 and ADM1032 have address 0x4c.
+ * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
  */
 
@@ -69,7 +84,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_3(lm90, adm1032, lm99);
+SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
 
 /*
  * The LM90 registers
@@ -289,7 +304,6 @@
 	struct lm90_data *data;
 	int err = 0;
 	const char *name = "";
-	u8 reg_config1=0, reg_convrate=0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
@@ -319,28 +333,22 @@
 	 * requested, so both the detection and the identification steps
 	 * are skipped.
 	 */
-	if (kind < 0) { /* detection */
-		reg_config1 = i2c_smbus_read_byte_data(new_client,
-			      LM90_REG_R_CONFIG1);
-		reg_convrate = i2c_smbus_read_byte_data(new_client,
-			       LM90_REG_R_CONVRATE);
 
-		if ((reg_config1 & 0x2A) != 0x00
-		 || reg_convrate > 0x0A) {
-			dev_dbg(&adapter->dev,
-				"LM90 detection failed at 0x%02x.\n",
-				address);
-			goto exit_free;
-		}
-	}
+	/* Default to an LM90 if forced */
+	if (kind == 0)
+		kind = lm90;
 
-	if (kind <= 0) { /* identification */
-		u8 man_id, chip_id;
+	if (kind < 0) { /* detection and identification */
+		u8 man_id, chip_id, reg_config1, reg_convrate;
 
 		man_id = i2c_smbus_read_byte_data(new_client,
 			 LM90_REG_R_MAN_ID);
 		chip_id = i2c_smbus_read_byte_data(new_client,
 			  LM90_REG_R_CHIP_ID);
+		reg_config1 = i2c_smbus_read_byte_data(new_client,
+			      LM90_REG_R_CONFIG1);
+		reg_convrate = i2c_smbus_read_byte_data(new_client,
+			       LM90_REG_R_CONVRATE);
 		
 		if (man_id == 0x01) { /* National Semiconductor */
 			u8 reg_config2;
@@ -348,25 +356,36 @@
 			reg_config2 = i2c_smbus_read_byte_data(new_client,
 				      LM90_REG_R_CONFIG2);
 
-			if (kind == 0 /* skip detection */
-			 || ((reg_config2 & 0xF8) == 0x00
-			  && reg_convrate <= 0x09)) {
+			if ((reg_config1 & 0x2A) == 0x00
+			 && (reg_config2 & 0xF8) == 0x00
+			 && reg_convrate <= 0x09) {
 				if (address == 0x4C
 				 && (chip_id & 0xF0) == 0x20) { /* LM90 */
 					kind = lm90;
 				} else
 				if ((chip_id & 0xF0) == 0x30) { /* LM89/LM99 */
 					kind = lm99;
+				} else
+				if (address == 0x4C
+				 && (chip_id & 0xF0) == 0x10) { /* LM86 */
+					kind = lm86;
 				}
 			}
 		} else
 		if (man_id == 0x41) { /* Analog Devices */
 			if (address == 0x4C
 			 && (chip_id & 0xF0) == 0x40 /* ADM1032 */
-			 && (kind == 0 /* skip detection */
-			  || (reg_config1 & 0x3F) == 0x00)) {
+			 && (reg_config1 & 0x3F) == 0x00
+			 && reg_convrate <= 0x0A) {
 				kind = adm1032;
 			}
+		} else
+		if (man_id == 0x4D) { /* Maxim */
+			if (address == 0x4C
+			 && (reg_config1 & 0x1F) == 0
+			 && reg_convrate <= 0x09) {
+			 	kind = max6657;
+			}
 		}
 
 		if (kind <= 0) { /* identification failed */
@@ -383,6 +402,10 @@
 		name = "adm1032";
 	} else if (kind == lm99) {
 		name = "lm99";
+	} else if (kind == lm86) {
+		name = "lm86";
+	} else if (kind == max6657) {
+		name = "max6657";
 	}
 
 	/* We can fill in the remaining client fields */

