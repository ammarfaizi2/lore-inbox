Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUCPBmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbUCPB0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:26:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:29871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262863AbUCPACg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:36 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913921925@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913932371@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1597.1.10, 2004/03/01 11:27:29-08:00, komoriya@paken.org

[PATCH] I2C: it87 reset option

I wrote a patch which adds reset option to the it87 driver talking
with Jean Delvare.

* Do not reset the registers unless users want to do because
  resetting registers makes all fans go to full power and we can
  usually rely on values set by BIOS
* Remove all limit initializations as they should be done from
  user-space
* Better register mask for start of monitoring


 drivers/i2c/chips/it87.c |  162 +++++++++++------------------------------------
 1 files changed, 38 insertions(+), 124 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:35:47 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:35:47 2004
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -129,61 +132,6 @@
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* Initial limits. Use the config file to set better limits. */
-#define IT87_INIT_IN_0 170
-#define IT87_INIT_IN_1 250
-#define IT87_INIT_IN_2 (330 / 2)
-#define IT87_INIT_IN_3 (((500)   * 100)/168)
-#define IT87_INIT_IN_4 (((1200)  * 10)/38)
-#define IT87_INIT_IN_5 (((1200)  * 10)/72)
-#define IT87_INIT_IN_6 (((500)   * 10)/56)
-#define IT87_INIT_IN_7 (((500)   * 100)/168)
-
-#define IT87_INIT_IN_PERCENTAGE 10
-
-#define IT87_INIT_IN_MIN_0 \
-	(IT87_INIT_IN_0 - IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_0 \
-	(IT87_INIT_IN_0 + IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_1 \
-	(IT87_INIT_IN_1 - IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_1 \
-	(IT87_INIT_IN_1 + IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_2 \
-	(IT87_INIT_IN_2 - IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_2 \
-	(IT87_INIT_IN_2 + IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_3 \
-	(IT87_INIT_IN_3 - IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_3 \
-	(IT87_INIT_IN_3 + IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_4 \
-	(IT87_INIT_IN_4 - IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_4 \
-	(IT87_INIT_IN_4 + IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_5 \
-	(IT87_INIT_IN_5 - IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_5 \
-	(IT87_INIT_IN_5 + IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_6 \
-	(IT87_INIT_IN_6 - IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_6 \
-	(IT87_INIT_IN_6 + IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_7 \
-	(IT87_INIT_IN_7 - IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_7 \
-	(IT87_INIT_IN_7 + IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
-
-#define IT87_INIT_FAN_MIN_1 3000
-#define IT87_INIT_FAN_MIN_2 3000
-#define IT87_INIT_FAN_MIN_3 3000
-
-#define IT87_INIT_TEMP_HIGH_1 600
-#define IT87_INIT_TEMP_LOW_1  200
-#define IT87_INIT_TEMP_HIGH_2 600
-#define IT87_INIT_TEMP_LOW_2  200
-#define IT87_INIT_TEMP_HIGH_3 600 
-#define IT87_INIT_TEMP_LOW_3  200
 
 /* For each registered IT87, we need to keep some data in memory. That
    data is pointed to by it87_list[NR]->data. The structure itself is
@@ -822,80 +770,44 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new IT87. It should set limits, etc. */
+/* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others */
-	it87_write_value(client, IT87_REG_CONFIG, 0x80);
-	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0));
-	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0));
-	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1));
-	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1));
-	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2));
-	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2));
-	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3));
-	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3));
-	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4));
-	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4));
-	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5));
-	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5));
-	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6));
-	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6));
-	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7));
-	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7));
-	/* Note: Battery voltage does not have limit registers */
-	it87_write_value(client, IT87_REG_FAN_MIN(0),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(1),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(2),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
-	it87_write_value(client, IT87_REG_TEMP_LOW(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
-	it87_write_value(client, IT87_REG_TEMP_LOW(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
-	it87_write_value(client, IT87_REG_TEMP_LOW(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
-
-	/* Enable voltage monitors */
-	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
-
-	/* Enable Temp1-Temp3 */
-	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	int tmp;
 
-	/* Enable fans */
-	it87_write_value(client, IT87_REG_FAN_CTRL,
-			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
-			| 0x70);
+	if (reset) {
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	}
+
+	/* Check if temperature channnels are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+	if ((tmp & 0x3f) == 0) {
+		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
+		tmp = (tmp & 0xc0) | 0x2a;
+		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
+	}
+	data->sensor = tmp;
+
+	/* Check if voltage monitors are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_VIN_ENABLE);
+	if ((tmp & 0xff) == 0) {
+		/* Enable all voltage monitors */
+		it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+	}
+
+	/* Check if tachometers are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_FAN_CTRL);
+	if ((tmp & 0x70) == 0) {
+		/* Enable all fan tachometers */
+		tmp = (tmp & 0x8f) | 0x70;
+		it87_write_value(client, IT87_REG_FAN_CTRL, tmp);
+	}
 
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
@@ -988,6 +900,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

