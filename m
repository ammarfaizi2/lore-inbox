Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVAHGWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVAHGWE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVAHGVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:21:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:30598 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261944AbVAHFsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:53 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627762989@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:36 -0800
Message-Id: <11051627762271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.11, 2004/12/21 11:09:49-08:00, jmunsin@iki.fi

[PATCH] I2C: it87.c update

 - adds manual PWM
 - removes buggy "reset" module parameter
 - fixes some whitespaces

Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |  147 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 130 insertions(+), 17 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-01-07 14:55:04 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-01-07 14:55:04 -08:00
@@ -96,9 +96,6 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
-/* Reset the registers on init if true */
-static int reset;
-
 /* Chip Type */
 
 static u16 chip_type;
@@ -128,6 +125,8 @@
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
+#define IT87_REG_FAN_CTL       0x14
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -164,6 +163,9 @@
 
 #define ALARMS_FROM_REG(val) (val)
 
+#define PWM_TO_REG(val)   ((val) >> 1)
+#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
@@ -200,6 +202,8 @@
 	u8 vid;			/* Register encoding, combined */
 	int vrm;
 	u32 alarms;		/* Register encoding, combined */
+	u8 fan_main_ctrl;	/* Register value */
+	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
 };
 
 
@@ -440,18 +444,28 @@
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
-				DIV_FROM_REG(data->fan_div[nr])) );
+				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
+}
+static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
@@ -499,6 +513,44 @@
 	}
 	return count;
 }
+static ssize_t set_pwm_enable(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val == 0) {
+		/* set on/off mode */
+		data->fan_main_ctrl &= ~(1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+	} else if (val == 1) {
+		/* set SmartGuardian mode */
+		data->fan_main_ctrl |= (1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
+		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static ssize_t set_pwm(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	data->manual_pwm_ctl[nr] = val;
+	if (data->fan_main_ctrl & (1 << nr))
+		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
@@ -533,6 +585,36 @@
 show_fan_offset(2);
 show_fan_offset(3);
 
+#define show_pwm_offset(offset)						\
+static ssize_t show_pwm##offset##_enable (struct device *dev,		\
+	char *buf)							\
+{									\
+	return show_pwm_enable(dev, buf, offset - 1);			\
+}									\
+static ssize_t show_pwm##offset (struct device *dev, char *buf)		\
+{									\
+	return show_pwm(dev, buf, offset - 1);				\
+}									\
+static ssize_t set_pwm##offset##_enable (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_enable(dev, buf, count, offset - 1);		\
+}									\
+static ssize_t set_pwm##offset (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm(dev, buf, count, offset - 1);			\
+}									\
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_enable,				\
+		set_pwm##offset##_enable);				\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset , set_pwm##offset );
+
+show_pwm_offset(1);
+show_pwm_offset(2);
+show_pwm_offset(3);
+
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
@@ -774,6 +856,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
 
 	if (data->type == it8712) {
 		device_create_file_vrm(new_client);
@@ -851,12 +939,17 @@
 /* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	int tmp;
+	int tmp, i;
 
-	if (reset) {
-		/* Reset all except Watchdog values and last conversion values
-		   This sets fan-divs to 2, among others */
-		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	/* initialize to sane defaults:
+	 * - if the chip is in manual pwm mode, this will be overwritten with
+	 *   the actual settings on the chip (so in this case, initialization
+	 *   is not needed)
+	 * - if in automatic or on/off mode, we could switch to manual mode,
+	 *   read the registers and set manual_pwm_ctl accordingly, but currently
+	 *   this is not implemented, so we initialize to something sane */
+	for (i = 0; i < 3; i++) {
+		data->manual_pwm_ctl[i] = 0xff;
 	}
 
 	/* Check if temperature channnels are reset manually or by some reason */
@@ -876,13 +969,35 @@
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
-	if ((tmp & 0x70) == 0) {
+	data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+	if ((data->fan_main_ctrl & 0x70) == 0) {
 		/* Enable all fan tachometers */
-		tmp = (tmp & 0x8f) | 0x70;
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
+		data->fan_main_ctrl |= 0x70;
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 
+	/* Set current fan mode registers and the default settings for the
+	 * other mode registers */
+	for (i = 0; i < 3; i++) {
+		if (data->fan_main_ctrl & (1 << i)) {
+			/* pwm mode */
+			tmp = it87_read_value(client, IT87_REG_PWM(i));
+			if (tmp & 0x80) {
+				/* automatic pwm - not yet implemented, but
+				 * leave the settings made by the BIOS alone
+				 * until a change is requested via the sysfs
+				 * interface */
+			} else {
+				/* manual pwm */
+				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
+			}
+		}
+ 	}
+
+	/* make sure the fan is on when in on/off mode */
+	tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+	it87_write_value(client, IT87_REG_FAN_CTL, tmp | 0x07);
+
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
 			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
@@ -984,8 +1099,6 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-module_param(reset, bool, 0);
-MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

