Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVAKUZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVAKUZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAKUZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:25:37 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:3828 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S262614AbVAKUYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:24:36 -0500
Date: Tue, 11 Jan 2005 22:24:38 +0200
From: Jonas Munsin <jmunsin@iki.fi>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-reply-to: <YN0o4rkI.1105435582.0805630.khali@localhost>
To: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>
Cc: pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com,
       Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net,
       LKML <linux-kernel@vger.kernel.org>
Reply-to: Jonas Munsin <jmunsin@iki.fi>
Mail-followup-to: Jonas Munsin <jmunsin@iki.fi>,
 Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
 pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com, djg@pdp8.net,
 LKML <linux-kernel@vger.kernel.org>
Message-id: <20050111202437.GA2914@nemo.sby.abo.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <200501102341.44949.pioppo@ferrara.linux.it>
 <YN0o4rkI.1105435582.0805630.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:26:22AM +0100, Jean Delvare wrote:
> 1* Jonas, please send a modified version of your original patch to Greg.
> The only difference would be that you wouldn't force on/off mode to be
> on at driver load time. Instead, disabling PWM for one fan control
> output (echo 0 > pwmN_enable) would both set on/off mode to on for that
> output (new) and turn that output to on/off mode (same as before).

Ok, thanks for doing the thinking ;), here is the modified patch
(it87.c_2.6.10-jm3-corrected_manual_pwm_20050111.diff). In addition to
the above change, it also refreshes fan_main_ctrl in the update routine,
as suggested by Jean on IRC.

 - adds manual PWM
 - removes buggy "reset" module parameter
 - fixes some whitespaces

Signed-off-by: Jonas Munsin <jmunsin@iki.fi>

--- linux-2.6.10/drivers/i2c/chips/it87.c	2005-01-11 21:48:16.000000000 +0200
+++ linux-2.6.10/drivers/i2c/chips/it87.c_2.6.10-jm2-corrected_manual_pwm_20050111	2005-01-11 21:24:55.000000000 +0200
@@ -96,9 +96,6 @@ superio_exit(void)
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
-/* Reset the registers on init if true */
-static int reset;
-
 /* Chip Type */
 
 static u16 chip_type;
@@ -128,6 +125,8 @@ static u16 chip_type;
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
+#define IT87_REG_FAN_CTL       0x14
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -164,6 +163,9 @@ static inline u8 FAN_TO_REG(long rpm, in
 
 #define ALARMS_FROM_REG(val) (val)
 
+#define PWM_TO_REG(val)   ((val) >> 1)
+#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
@@ -200,6 +202,8 @@ struct it87_data {
 	u8 vid;			/* Register encoding, combined */
 	int vrm;
 	u32 alarms;		/* Register encoding, combined */
+	u8 fan_main_ctrl;	/* Register value */
+	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
 };
 
 
@@ -440,18 +444,28 @@ static ssize_t show_fan(struct device *d
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
@@ -499,6 +513,48 @@ static ssize_t set_fan_div(struct device
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
+		int tmp;
+		/* make sure the fan is on when in on/off mode */
+		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+		it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));
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
@@ -533,6 +589,36 @@ show_fan_offset(1);
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
@@ -774,6 +860,12 @@ int it87_detect(struct i2c_adapter *adap
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
@@ -851,12 +943,17 @@ static int it87_write_value(struct i2c_c
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
@@ -876,13 +973,31 @@ static void it87_init_client(struct i2c_
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
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
 			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
@@ -948,6 +1063,7 @@ static struct it87_data *it87_update_dev
 			it87_read_value(client, IT87_REG_ALARM1) |
 			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
 			(it87_read_value(client, IT87_REG_ALARM3) << 16);
+		data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
 
 		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 		/* The 8705 does not have VID capability */
@@ -984,8 +1100,6 @@ MODULE_AUTHOR("Chris Gauthron <chrisg@0-
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-module_param(reset, bool, 0);
-MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);
