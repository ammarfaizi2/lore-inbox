Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVAYWXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVAYWXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAYWWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:22:00 -0500
Received: from farad.aurel32.net ([82.232.2.251]:51649 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S262180AbVAYWSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:18:22 -0500
Date: Tue, 25 Jan 2005 23:18:19 +0100
From: =?iso-8859-15?Q?Aur=E9lien?= Jarno <aurelien@aurel32.net>
To: Greg KH <greg@kroah.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] I2C: lm78 driver improvement
Message-ID: <20050125221819.GB23560@bode.aurel32.net>
Mail-Followup-To: =?iso-8859-15?Q?Aur=E9lien?= Jarno <aurelien@aurel32.net>,
	Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.6+20040907i (CVS)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The following patch against kernel 2.6.11-rc2-mm1 improves the lm78
driver. I used it as a model to port the sis5595 driver to the 2.6
kernel, and I then applied the changes suggested by Jean Delvare on 
the sis5595 driver to this one.

Please apply.

Thanks,
Aurelien

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

diff -urN linux-2.6.11-rc2-mm1.orig/drivers/i2c/chips/lm78.c linux-2.6.11-rc2-mm1/drivers/i2c/chips/lm78.c
--- linux-2.6.11-rc2-mm1.orig/drivers/i2c/chips/lm78.c	2005-01-25 19:51:32.000000000 +0100
+++ linux-2.6.11-rc2-mm1/drivers/i2c/chips/lm78.c	2005-01-25 22:26:01.000000000 +0100
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

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net



