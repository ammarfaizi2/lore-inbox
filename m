Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbVCDWG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVCDWG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVCDWEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:04:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:7074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263163AbVCDUyd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:33 -0500
Cc: aurelien@aurel32.net
Subject: [PATCH] I2C: lm78 driver improvement
In-Reply-To: <1109968594850@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <11099685942479@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091, 2005/03/02 12:04:28-08:00, aurelien@aurel32.net

[PATCH] I2C: lm78 driver improvement

The following patch against kernel 2.6.11-rc2-mm1 improves the lm78
driver. I used it as a model to port the sis5595 driver to the 2.6
kernel, and I then applied the changes suggested by Jean Delvare on
the sis5595 driver to this one.


Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm78.c |   53 +++++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 29 deletions(-)


diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2005-03-04 12:25:31 -08:00
+++ b/drivers/i2c/chips/lm78.c	2005-03-04 12:25:31 -08:00
@@ -81,9 +81,8 @@
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
-	if (rpm == 0)
+	if (rpm <= 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
@@ -94,15 +93,15 @@
 
 /* TEMP: mC (-128C to +127C)
    REG: 1C/bit, two's complement */
-static inline u8 TEMP_TO_REG(int val)
+static inline s8 TEMP_TO_REG(int val)
 {
 	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
-	return nval<0 ? (nval-500)/1000+0x100 : (nval+500)/1000;
+	return nval<0 ? (nval-500)/1000 : (nval+500)/1000;
 }
 
-static inline int TEMP_FROM_REG(u8 val)
+static inline int TEMP_FROM_REG(s8 val)
 {
-	return (val>=0x80 ? val-0x100 : val) * 1000;
+	return val * 1000;
 }
 
 /* VID: mV
@@ -112,16 +111,6 @@
 	return val==0x1f ? 0 : val>=0x10 ? 5100-val*100 : 2050-val*50;
 }
 
-/* ALARMS: chip-specific bitmask
-   REG: (same) */
-#define ALARMS_FROM_REG(val) (val)
-
-/* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
-   REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
-static inline u8 DIV_TO_REG(int val)
-{
-	return val==8 ? 3 : val==4 ? 2 : val==1 ? 0 : 1;
-}
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* There are some complications in a module like this. First off, LM78 chips
@@ -157,9 +146,9 @@
 	u8 in_min[7];		/* Register value */
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
-	u8 temp;		/* Register value */
-	u8 temp_over;		/* Register value */
-	u8 temp_hyst;		/* Register value */
+	s8 temp;		/* Register value */
+	s8 temp_over;		/* Register value */
+	s8 temp_hyst;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u16 alarms;		/* Register encoding, combined */
@@ -357,7 +346,17 @@
 			DIV_FROM_REG(data->fan_div[nr]));
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg = lm78_read_value(client, LM78_REG_VID_FANDIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	switch (val) {
+	case 1: data->fan_div[nr] = 0; break;
+	case 2: data->fan_div[nr] = 1; break;
+	case 4: data->fan_div[nr] = 2; break;
+	case 8: data->fan_div[nr] = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not "
+			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		return -EINVAL;
+	}
+
 	switch (nr) {
 	case 0:
 		reg = (reg & 0xcf) | (data->fan_div[nr] << 4);
@@ -430,7 +429,7 @@
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
@@ -633,17 +632,15 @@
 {
 	int err;
 
-	/* release ISA region first */
-	if(i2c_is_isa_client(client))
-		release_region(client->addr, LM78_EXTENT);
-
-	/* now it's safe to scrap the rest */
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
+	if(i2c_is_isa_client(client))
+		release_region(client->addr, LM78_EXTENT);
+
 	kfree(i2c_get_clientdata(client));
 
 	return 0;
@@ -653,9 +650,7 @@
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+   would slow down the LM78 access and should not be necessary.  */
 static int lm78_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;

