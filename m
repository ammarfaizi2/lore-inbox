Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCCRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCCRtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVCCRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:47:14 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:52997 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S262174AbVCCR3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:29:00 -0500
Message-ID: <42274958.4050400@katalix.com>
Date: Thu, 03 Mar 2005 17:28:56 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90 driver
References: <4223513F.4030403@katalix.com>	<20050302165532.GB2311@kroah.com> <20050302203721.7cce650d.khali@linux-fr.org>
In-Reply-To: <20050302203721.7cce650d.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------050601020007080701060808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601020007080701060808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A revised adt7461 patch addressing all of Jean's comments is
attached.

This driver will detect the adt7461 chip only if boot firmware
has left the chip in its default lm90-compatible mode.



--------------050601020007080701060808
Content-Type: text/plain;
 name="adt7461.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adt7461.patch"

i2c: add adt7461 chip support

Signed-off-by: James Chapman <jchapman@katalix.com>

The Analog Devices ADT7461 temperature sensor chip is compatible with
the lm90 device provided its extended temperature range is not
enabled.  The chip will be ignored if the boot firmware enables
extended temperature range.

Also, since the adt7461 treats temp values <0 as 0 and >127 as 127,
the driver prevents temperature values outside the supported range
from being set.

Index: linux-2.6.i2c/drivers/i2c/chips/lm90.c
===================================================================
--- linux-2.6.i2c.orig/drivers/i2c/chips/lm90.c	2005-03-03 15:02:40.000000000 +0000
+++ linux-2.6.i2c/drivers/i2c/chips/lm90.c	2005-03-03 15:44:34.000000000 +0000
@@ -43,6 +43,12 @@
  * variants. The extra address and features of the MAX6659 are not
  * supported by this driver.
  *
+ * This driver also supports the ADT7461 chip from Analog Devices but
+ * only in its "compatability mode". If an ADT7461 chip is found but
+ * is configured in non-compatible mode (where its temperature
+ * register values are decoded differently) it is ignored by this
+ * driver.
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -76,6 +82,7 @@
  * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
+ * ADT7461 always has address 0x4c.
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -85,7 +92,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
+SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
 /*
  * The LM90 registers
@@ -180,6 +187,7 @@
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	int kind;
 
 	/* registers values */
 	s8 temp_input1, temp_low1, temp_high1; /* local */
@@ -221,6 +229,8 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+	if ((data->kind == adt7461) && ((val < 0) || (val > 127000))) \
+		return -EINVAL; \
 	data->value = TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
@@ -232,6 +242,8 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+	if ((data->kind == adt7461) && ((val < 0) || (val > 127000))) \
+		return -EINVAL; \
 	data->value = TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
@@ -386,6 +398,12 @@
 			 && (reg_config1 & 0x3F) == 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adm1032;
+			} else
+			if (address == 0x4c
+			 && chip_id == 0x51 /* ADT7461 */
+			 && (reg_config1 & 0x3F) == 0x00
+			 && reg_convrate <= 0x0A) {
+				kind = adt7461;
 			}
 		} else
 		if (man_id == 0x4D) { /* Maxim */
@@ -423,12 +441,15 @@
 		name = "lm86";
 	} else if (kind == max6657) {
 		name = "max6657";
+	} else if (kind == adt7461) {
+		name = "adt7461";
 	}
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	new_client->id = lm90_id++;
 	data->valid = 0;
+	data->kind = kind;
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */

--------------050601020007080701060808--
