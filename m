Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVCaXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVCaXcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVCaXbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:31:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:26592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262070AbVCaXYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:05 -0500
Cc: jchapman@katalix.com
Subject: [PATCH] i2c: add adt7461 chip support to lm90 driver
In-Reply-To: <11123113913563@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:11 -0800
Message-Id: <11123113914006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2332, 2005/03/31 14:08:21-08:00, jchapman@katalix.com

[PATCH] i2c: add adt7461 chip support to lm90 driver

i2c: add adt7461 chip support

The Analog Devices ADT7461 temperature sensor chip is compatible with
the lm90 device provided its extended temperature range is not
enabled.  The chip will be ignored if the boot firmware enables
extended temperature range.

Also, since the adt7461 treats temp values <0 as 0 and >127 as 127,
the driver prevents temperature values outside the supported range
from being set.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/lm90.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-03-31 15:18:08 -08:00
+++ b/drivers/i2c/chips/lm90.c	2005-03-31 15:18:08 -08:00
@@ -43,6 +43,14 @@
  * variants. The extra address and features of the MAX6659 are not
  * supported by this driver.
  *
+ * This driver also supports the ADT7461 chip from Analog Devices but
+ * only in its "compatability mode". If an ADT7461 chip is found but
+ * is configured in non-compatible mode (where its temperature
+ * register values are decoded differently) it is ignored by this
+ * driver. Complete datasheet can be obtained from Analog's website
+ * at:
+ *   http://products.analog.com/products/info.asp?product=ADT7461
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -77,6 +85,7 @@
  * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
+ * ADT7461 always has address 0x4c.
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -86,7 +95,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
+SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
 /*
  * The LM90 registers
@@ -148,6 +157,19 @@
 #define HYST_TO_REG(val)	((val) <= 0 ? 0 : (val) >= 30500 ? 31 : \
 				 ((val) + 500) / 1000)
 
+/* 
+ * ADT7461 is almost identical to LM90 except that attempts to write
+ * values that are outside the range 0 < temp < 127 are treated as
+ * the boundary value. 
+ */
+
+#define TEMP1_TO_REG_ADT7461(val) ((val) <= 0 ? 0 : \
+				 (val) >= 127000 ? 127 : \
+				 ((val) + 500) / 1000)
+#define TEMP2_TO_REG_ADT7461(val) ((val) <= 0 ? 0 : \
+				 (val) >= 127750 ? 0x7FC0 : \
+				 ((val) + 125) / 250 * 64)
+
 /*
  * Functions declaration
  */
@@ -181,6 +203,7 @@
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	int kind;
 
 	/* registers values */
 	s8 temp_input1, temp_low1, temp_high1; /* local */
@@ -216,7 +239,10 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
-	data->value = TEMP1_TO_REG(val); \
+	if (data->kind == adt7461) \
+		data->value = TEMP1_TO_REG_ADT7461(val); \
+	else \
+		data->value = TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -227,7 +253,10 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
-	data->value = TEMP2_TO_REG(val); \
+	if (data->kind == adt7461) \
+		data->value = TEMP2_TO_REG_ADT7461(val); \
+	else \
+		data->value = TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
 	return count; \
@@ -381,6 +410,12 @@
 			 && (reg_config1 & 0x3F) == 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adm1032;
+			} else
+			if (address == 0x4c
+			 && chip_id == 0x51 /* ADT7461 */
+			 && (reg_config1 & 0x1F) == 0x00 /* check compat mode */
+			 && reg_convrate <= 0x0A) {
+				kind = adt7461;
 			}
 		} else
 		if (man_id == 0x4D) { /* Maxim */
@@ -418,11 +453,14 @@
 		name = "lm86";
 	} else if (kind == max6657) {
 		name = "max6657";
+	} else if (kind == adt7461) {
+		name = "adt7461";
 	}
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
+	data->kind = kind;
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */

