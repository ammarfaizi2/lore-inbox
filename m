Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUFVSBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUFVSBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUFVSBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:01:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:47285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265077AbUFVRnd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:33 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261113701@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <1087926111747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.102.4, 2004/06/08 14:36:23-07:00, jmunsin@iki.fi

[PATCH] I2C: drivers/i2c/chips/it87.c cleanup patch

Attached is a cleanup patch for the it87 sensor driver, against
2.6.7-rc2. Jean Delvare has reviewed it.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   48 +++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:50 2004
+++ b/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:50 2004
@@ -128,15 +128,15 @@
 
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
-#define IT87_REG_FAN_CTRL      0x13
+#define IT87_REG_FAN_MAIN_CTRL 0x13
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
 
 #define IT87_REG_VIN_MAX(nr)   (0x30 + (nr) * 2)
 #define IT87_REG_VIN_MIN(nr)   (0x31 + (nr) * 2)
-#define IT87_REG_TEMP_HIGH(nr) (0x40 + ((nr) * 2))
-#define IT87_REG_TEMP_LOW(nr)  (0x41 + ((nr) * 2))
+#define IT87_REG_TEMP_HIGH(nr) (0x40 + (nr) * 2)
+#define IT87_REG_TEMP_LOW(nr)  (0x41 + (nr) * 2)
 
 #define IT87_REG_I2C_ADDR      0x48
 
@@ -145,8 +145,8 @@
 
 #define IT87_REG_CHIPID        0x58
 
-#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
-#define IN_FROM_REG(val) (((val) *  16) / 10)
+#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
+#define IN_FROM_REG(val) ((val) * 16)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -159,9 +159,9 @@
 
 #define FAN_FROM_REG(val,div) ((val)==0?-1:(val)==255?0:1350000/((val)*(div)))
 
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
-					((val)+5)/10),0,255))
-#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
+					((val)+500)/1000),-128,127))
+#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
 
 #define VID_FROM_REG(val) ((val)==0x1f?0:(val)>=0x10?510-(val)*10:\
 				205-(val)*5)
@@ -231,19 +231,19 @@
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr])*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr])*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr])*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
 static ssize_t set_in_min(struct device *dev, const char *buf, 
@@ -251,7 +251,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_min[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr), 
 			data->in_min[nr]);
@@ -262,7 +262,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_max[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr), 
 			data->in_max[nr]);
@@ -325,24 +325,24 @@
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
 }
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*100);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr]));
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
 	return count;
@@ -352,7 +352,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
 	return count;
@@ -773,9 +773,7 @@
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+   would slow down the IT87 access and should not be necessary. */
 static int it87_read_value(struct i2c_client *client, u8 reg)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -795,9 +793,7 @@
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+   would slow down the IT87 access and should not be necessary. */
 static int it87_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -840,11 +836,11 @@
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_FAN_CTRL);
+	tmp = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
 	if ((tmp & 0x70) == 0) {
 		/* Enable all fan tachometers */
 		tmp = (tmp & 0x8f) | 0x70;
-		it87_write_value(client, IT87_REG_FAN_CTRL, tmp);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
 	}
 
 	/* Start monitoring */

