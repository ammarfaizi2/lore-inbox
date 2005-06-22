Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVFVG1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVFVG1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVFVG0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:26:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:30620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbVFVFWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:06 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill common macro abuse in chip drivers
In-Reply-To: <11194174643068@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174641227@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Kill common macro abuse in chip drivers

This patch kills a common macro abuse in i2c chip drivers: defining
ALARMS_FROM_REG returning its argument unchanged. Dropping the macro
makes the code somewhat more readable IMHO.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 68188ba7de2db9999ff08a4544a78b2f10eb08bd
tree 37e0406d7f2b6ace2bc73043bda0c745d3aa5e37
parent ff3240946d6a3d9f2ecf273f7330e09eec5484eb
author Jean Delvare <khali@linux-fr.org> Mon, 16 May 2005 18:52:38 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:57 -0700

 drivers/i2c/chips/asb100.c  |    4 +---
 drivers/i2c/chips/it87.c    |    4 +---
 drivers/i2c/chips/lm85.c    |    4 +---
 drivers/i2c/chips/via686a.c |    4 +---
 drivers/i2c/chips/w83781d.c |    3 +--
 5 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c
+++ b/drivers/i2c/chips/asb100.c
@@ -169,8 +169,6 @@ static int ASB100_PWM_FROM_REG(u8 reg)
 	return reg * 16;
 }
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
@@ -557,7 +555,7 @@ device_create_file(&client->dev, &dev_at
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -172,8 +172,6 @@ static inline u8 FAN_TO_REG(long rpm, in
 					((val)+500)/1000),-128,127))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define PWM_TO_REG(val)   ((val) >> 1)
 #define PWM_FROM_REG(val) (((val)&0x7f) << 1)
 
@@ -665,7 +663,7 @@ show_pwm_offset(3);
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
diff --git a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c
+++ b/drivers/i2c/chips/lm85.c
@@ -284,8 +284,6 @@ static int ZONE_TO_REG( int zone )
 /* i2c-vid.h defines vid_from_reg() */
 #define VID_FROM_REG(val,vrm) (vid_from_reg((val),(vrm)))
 
-#define ALARMS_FROM_REG(val) (val)
-
 /* Unlike some other drivers we DO NOT set initial limits.  Use
  * the config file to set limits.  Some users have reported
  * motherboards shutting down when we set limits in a previous
@@ -480,7 +478,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 static ssize_t show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -292,8 +292,6 @@ static inline long TEMP_FROM_REG10(u16 v
 	        tempLUT[eightBits + 1] * twoBits) * 25;
 }
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define DIV_FROM_REG(val) (1 << (val))
 #define DIV_TO_REG(val) ((val)==8?3:(val)==4?2:(val)==1?0:1)
 
@@ -570,7 +568,7 @@ show_fan_offset(2);
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
diff --git a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c
+++ b/drivers/i2c/chips/w83781d.c
@@ -172,7 +172,6 @@ FAN_TO_REG(long rpm, int div)
 						: (val)) / 1000, 0, 0xff))
 #define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
 
-#define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
 #define BEEP_MASK_FROM_REG(val,type)	((type) == as99127f ? \
@@ -523,7 +522,7 @@ static ssize_t
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static

