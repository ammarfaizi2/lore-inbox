Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVDAUO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVDAUO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVDAUO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:14:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:51912 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262867AbVDAUE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:04:27 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix a common race condition in hardware monitoring
In-Reply-To: <11123858552208@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 12:04:15 -0800
Message-Id: <11123858552488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2341, 2005/04/01 11:50:04-08:00, khali@linux-fr.org

[PATCH] I2C: Fix a common race condition in hardware monitoring

Grant Coady noticed that most hardware monitoring drivers are exposed to
a race condition when one writes to the sysfs files they create. While
the read calls properly request a lock on the internal data, write calls
manipulate the internal data without proper locking. This big patch
fixes that by adding locking wherever needed.

Affected drivers: adm1021, adm1025, asb100, ds1621, fscher, fscpos,
gl518sm, gl520sm, it87, lm63, lm75, lm77, lm78, lm80, lm83, lm87, lm90,
lm92, max1619, pc87360, pcf8591, sis5595, smsc47m1, via686a, w83627hf
and w83781d

The adm1026, adm1031 and lm85 were already locking on write calls, but
held the lock for code that did not require it, so they have been
modified too.

The smsc47b397 and w83l785ts drivers were not affected, because they are
read-only.

The patch should apply just fine on top of your stack, provided that you
applied all previous patches in order (in particular, there is one lm87
indentation patch which is needed).


Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/adm1021.c  |    2 +
 drivers/i2c/chips/adm1025.c  |   12 +++++++++
 drivers/i2c/chips/adm1026.c  |   55 ++++++++++++++-----------------------------
 drivers/i2c/chips/adm1031.c  |   23 +++++++----------
 drivers/i2c/chips/asb100.c   |   25 +++++++++++++++++--
 drivers/i2c/chips/ds1621.c   |    6 +++-
 drivers/i2c/chips/fscher.c   |   34 ++++++++++++++++++++------
 drivers/i2c/chips/fscpos.c   |   18 ++++++++++----
 drivers/i2c/chips/gl518sm.c  |   25 +++++++++++++++----
 drivers/i2c/chips/gl520sm.c  |   43 ++++++++++++++++++++++-----------
 drivers/i2c/chips/it87.c     |   44 +++++++++++++++++++++++++++++-----
 drivers/i2c/chips/lm63.c     |   19 +++++++++++++-
 drivers/i2c/chips/lm75.c     |    3 ++
 drivers/i2c/chips/lm77.c     |   21 +++++++++++++---
 drivers/i2c/chips/lm78.c     |   30 +++++++++++++++++++++--
 drivers/i2c/chips/lm80.c     |   16 ++++++++++--
 drivers/i2c/chips/lm83.c     |    3 ++
 drivers/i2c/chips/lm85.c     |   44 ++++++++++++----------------------
 drivers/i2c/chips/lm87.c     |   31 +++++++++++++++++++++---
 drivers/i2c/chips/lm90.c     |   14 +++++++++-
 drivers/i2c/chips/lm92.c     |   10 ++++++-
 drivers/i2c/chips/max1619.c  |    3 ++
 drivers/i2c/chips/pc87360.c  |   29 ++++++++++++++++++++++
 drivers/i2c/chips/pcf8591.c  |    6 +++-
 drivers/i2c/chips/sis5595.c  |   28 +++++++++++++++++++--
 drivers/i2c/chips/smsc47m1.c |   24 ++++++++++++++----
 drivers/i2c/chips/via686a.c  |   21 +++++++++++++++-
 drivers/i2c/chips/w83627hf.c |   32 ++++++++++++++++++++++++-
 drivers/i2c/chips/w83781d.c  |   29 ++++++++++++++++++++--
 29 files changed, 499 insertions(+), 151 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2005-04-01 11:52:47 -08:00
@@ -165,8 +165,10 @@
 	struct adm1021_data *data = i2c_get_clientdata(client);	\
 	int temp = simple_strtoul(buf, NULL, 10);		\
 								\
+	down(&data->update_lock);				\
 	data->value = TEMP_TO_REG(temp);			\
 	adm1021_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, ADM1021_REG_TOS_W);
diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/adm1025.c	2005-04-01 11:52:47 -08:00
@@ -206,9 +206,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
 				  data->in_min[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
@@ -217,9 +220,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
 				  data->in_max[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
@@ -240,9 +246,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_min[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
 				  data->temp_min[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
@@ -251,9 +260,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_max[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
 				  data->temp_max[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
diff -Nru a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/adm1026.c	2005-04-01 11:52:47 -08:00
@@ -726,10 +726,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_min[nr] = INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[nr], data->in_min[nr]);
 	up(&data->update_lock);
@@ -745,10 +744,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_max[nr] = INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[nr], data->in_max[nr]);
 	up(&data->update_lock);
@@ -818,10 +816,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_min[16] = INS_TO_REG(16, val + NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[16], data->in_min[16]);
 	up(&data->update_lock);
@@ -837,10 +834,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_max[16] = INS_TO_REG(16, val+NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[16], data->in_max[16]);
 	up(&data->update_lock);
@@ -873,10 +869,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
 	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
 		data->fan_min[nr]);
@@ -1009,10 +1004,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MIN[nr],
 		data->temp_min[nr]);
@@ -1029,10 +1023,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MAX[nr],
 		data->temp_max[nr]);
@@ -1083,10 +1076,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_offset[nr] = TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_OFFSET[nr],
 		data->temp_offset[nr]);
@@ -1136,10 +1128,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_tmin[nr] = TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_TMIN[nr],
 		data->temp_tmin[nr]);
@@ -1190,9 +1181,8 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
-	val = simple_strtol(buf, NULL, 10);
 	if ((val == 1) || (val==0)) {
 		down(&data->update_lock);
 		data->config1 = (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
@@ -1223,10 +1213,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_crit[nr] = TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_THERM[nr],
 		data->temp_crit[nr]);
@@ -1261,10 +1250,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->analog_out = DAC_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_DAC, data->analog_out);
 	up(&data->update_lock);
@@ -1317,11 +1305,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 	unsigned long mask;
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->alarm_mask = val & 0x7fffffff;
 	mask = data->alarm_mask
 		| (data->gpio_mask & 0x10000 ? 0x80000000 : 0);
@@ -1354,11 +1341,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 	long   gpio;
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->gpio = val & 0x1ffff;
 	gpio = data->gpio;
 	adm1026_write_value(client, ADM1026_REG_GPIO_STATUS_0_7,gpio & 0xff);
@@ -1383,11 +1369,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 	long   mask;
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->gpio_mask = val & 0x1ffff;
 	mask = data->gpio_mask;
 	adm1026_write_value(client, ADM1026_REG_GPIO_MASK_0_7,mask & 0xff);
@@ -1411,11 +1396,11 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
 
 	if (data->pwm1.enable == 1) {
+		int val = simple_strtol(buf, NULL, 10);
+
 		down(&data->update_lock);
-		val = simple_strtol(buf, NULL, 10);
 		data->pwm1.pwm = PWM_TO_REG(val);
 		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
 		up(&data->update_lock);
@@ -1432,10 +1417,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->pwm1.auto_pwm_min = SENSORS_LIMIT(val,0,255);
 	if (data->pwm1.enable == 2) { /* apply immediately */
 		data->pwm1.pwm = PWM_TO_REG((data->pwm1.pwm & 0x0f) |
@@ -1459,10 +1443,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int     val;
+	int val = simple_strtol(buf, NULL, 10);
 	int     old_enable;
 
-	val = simple_strtol(buf, NULL, 10);
 	if ((val >= 0) && (val < 3)) {
 		down(&data->update_lock);
 		old_enable = data->pwm1.enable;
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/adm1031.c	2005-04-01 11:52:47 -08:00
@@ -254,7 +254,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 	u8 reg;
 	int ret;
 	u8 old_fan_mode;
@@ -262,7 +262,6 @@
 	old_fan_mode = data->conf1;
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	
 	if ((ret = get_fan_auto_nearest(data, nr, val, data->conf1, &reg))) {
 		up(&data->update_lock);
@@ -327,10 +326,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->auto_temp[nr] = AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->auto_temp[nr]);
@@ -348,10 +346,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] = AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr], data->pwm[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->temp_max[nr]);
@@ -404,10 +401,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 	int reg;
+
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) && 
 	    (((val>>4) & 0xf) != 5)) {
 		/* In automatic mode, the only PWM accepted is 33% */
@@ -511,10 +508,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	if (val) {
 		data->fan_min[nr] = 
 			FAN_TO_REG(val, FAN_DIV_FROM_REG(data->fan_div[nr]));
@@ -530,12 +526,11 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int val;
+	int val = simple_strtol(buf, NULL, 10);
 	u8 tmp;
-	int old_div = FAN_DIV_FROM_REG(data->fan_div[nr]);
+	int old_div;
 	int new_min;
 
-	val = simple_strtol(buf, NULL, 10);
 	tmp = val == 8 ? 0xc0 :
 	      val == 4 ? 0x80 :
 	      val == 2 ? 0x40 :	
@@ -543,7 +538,9 @@
 	      0xff;
 	if (tmp == 0xff)
 		return -EINVAL;
+	
 	down(&data->update_lock);
+	old_div = FAN_DIV_FROM_REG(data->fan_div[nr]);
 	data->fan_div[nr] = (tmp & 0xC0) | (0x3f & data->fan_div[nr]);
 	new_min = data->fan_min[nr] * old_div / 
 		FAN_DIV_FROM_REG(data->fan_div[nr]);
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/asb100.c	2005-04-01 11:52:47 -08:00
@@ -246,9 +246,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
 	unsigned long val = simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
 		data->in_##reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -329,8 +332,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	u32 val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -343,11 +349,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
 	
+	down(&data->update_lock);
+
+	min = FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
 	data->fan_div[nr] = DIV_TO_REG(val);
 
 	switch(nr) {
@@ -373,6 +382,9 @@
 	data->fan_min[nr] =
 		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+
+	up(&data->update_lock);
+
 	return count;
 }
 
@@ -450,6 +462,8 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
 	unsigned long val = simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	switch (nr) { \
 	case 1: case 2: \
 		data->reg[nr] = LM75_TEMP_TO_REG(val); \
@@ -460,6 +474,7 @@
 	} \
 	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -560,9 +575,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &= 0x80; /* keep the enable bit */
 	data->pwm |= (0x0f & ASB100_PWM_TO_REG(val));
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -578,9 +596,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &= 0x0f; /* keep the duty cycle bits */
 	data->pwm |= (val ? 0x80 : 0x00);
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/ds1621.c	2005-04-01 11:52:47 -08:00
@@ -153,8 +153,12 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
-	data->value = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	u16 val = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
+									\
+	down(&data->update_lock);					\
+	data->value = val;						\
 	ds1621_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/fscher.c	2005-04-01 11:52:47 -08:00
@@ -464,9 +464,11 @@
 {
 	/* bits 0..1, 3..7 reserved => mask with 0x04 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x04;
+	
+	down(&data->update_lock);
 	data->fan_status[FAN_INDEX_FROM_NUM(nr)] &= ~v;
-
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -480,9 +482,11 @@
 		       const char *buf, size_t count, int nr, int reg)
 {
 	unsigned long v = simple_strtoul(buf, NULL, 10);
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 
+	down(&data->update_lock);
+	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -507,11 +511,14 @@
 		return -EINVAL;
 	}
 
+	down(&data->update_lock);
+
 	/* bits 2..7 reserved => mask with 0x03 */
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &= ~0x03;
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |= v;
 
 	fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -537,9 +544,11 @@
 {
 	/* bits 2..7 reserved, 0 read only => mask with 0x02 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
-	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &= ~v;
 
+	down(&data->update_lock);
+	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -592,9 +601,11 @@
 {
 	/* bits 1..7 reserved => mask with 0x01 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x01;
-	data->global_control &= ~v;
 
+	down(&data->update_lock);
+	data->global_control &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -612,10 +623,12 @@
 {
 	/* bits 0..3 reserved => mask with 0xf0 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->watchdog[2] &= ~0xf0;
 	data->watchdog[2] |= v;
-
 	fscher_write_value(client, reg, data->watchdog[2]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -630,9 +643,11 @@
 {
 	/* bits 0, 2..7 reserved => mask with 0x02 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
-	data->watchdog[1] &= ~v;
 
+	down(&data->update_lock);
+	data->watchdog[1] &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -645,9 +660,12 @@
 static ssize_t set_watchdog_preset(struct i2c_client *client, struct fscher_data *data,
 				   const char *buf, size_t count, int nr, int reg)
 {
-	data->watchdog[0] = simple_strtoul(buf, NULL, 10) & 0xff;
-
+	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xff;
+	
+	down(&data->update_lock);
+	data->watchdog[0] = v;
 	fscher_write_value(client, reg, data->watchdog[0]);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-04-01 11:52:47 -08:00
@@ -206,11 +206,13 @@
 		return -EINVAL;
 	}
 	
+	down(&data->update_lock);
 	/* bits 2..7 reserved => mask with 0x03 */
 	data->fan_ripple[nr - 1] &= ~0x03;
 	data->fan_ripple[nr - 1] |= v;
 	
 	fscpos_write_value(client, reg, data->fan_ripple[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -228,8 +230,10 @@
 	if (v < 0) v = 0;
 	if (v > 255) v = 255;
 
+	down(&data->update_lock);
 	data->pwm[nr - 1] = v;
 	fscpos_write_value(client, reg, data->pwm[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -271,10 +275,12 @@
 {
 	/* bits 0..3 reserved => mask with 0xf0 */
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->wdog_control &= ~0xf0;
 	data->wdog_control |= v;
-	
 	fscpos_write_value(client, reg, data->wdog_control);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -296,9 +302,10 @@
 		return -EINVAL;
 	}
 
+	down(&data->update_lock);
 	data->wdog_state &= ~v;
-	
 	fscpos_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -310,9 +317,12 @@
 static ssize_t set_wdog_preset(struct i2c_client *client, struct fscpos_data
 				*data, const char *buf,	size_t count, int reg)
 {
-	data->wdog_preset = simple_strtoul(buf, NULL, 10) & 0xff;
-	
+	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xff;
+
+	down(&data->update_lock);
+	data->wdog_preset = v;
 	fscpos_write_value(client, reg, data->wdog_preset);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/gl518sm.c	2005-04-01 11:52:47 -08:00
@@ -211,8 +211,11 @@
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	long val = simple_strtol(buf, NULL, 10);			\
+									\
+	down(&data->update_lock);					\
 	data->value = type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
@@ -222,11 +225,15 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
-	int regvalue = gl518_read_value(client, reg);			\
+	int regvalue;							\
 	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+									\
+	down(&data->update_lock);					\
+	regvalue = gl518_read_value(client, reg);			\
 	data->value = type##_TO_REG(val);				\
 	regvalue = (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
@@ -255,9 +262,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
-	int regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
-	data->fan_min[0] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+	down(&data->update_lock);
+	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	data->fan_min[0] = FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[0]));
 	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
@@ -270,6 +280,7 @@
 	data->beep_mask &= data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -277,9 +288,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
-	int regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
-	data->fan_min[1] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+	down(&data->update_lock);
+	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	data->fan_min[1] = FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[1]));
 	regvalue = (regvalue & 0xff00) | data->fan_min[1];
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
@@ -292,6 +306,7 @@
 	data->beep_mask &= data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/gl520sm.c b/drivers/i2c/chips/gl520sm.c
--- a/drivers/i2c/chips/gl520sm.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/gl520sm.c	2005-04-01 11:52:47 -08:00
@@ -301,6 +301,8 @@
 	long v = simple_strtol(buf, NULL, 10);
 	u8 r;
 
+	down(&data->update_lock);
+
 	if (n == 0)
 		r = VDD_TO_REG(v);
 	else
@@ -313,6 +315,7 @@
 	else
 		gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -326,6 +329,8 @@
 	else
 		r = IN_TO_REG(v);
 
+	down(&data->update_lock);
+
 	data->in_max[n] = r;
 
 	if (n < 4)
@@ -333,6 +338,7 @@
 	else
 		gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -363,8 +369,10 @@
 static ssize_t set_fan_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	unsigned long v = simple_strtoul(buf, NULL, 10);
-	u8 r = FAN_TO_REG(v, data->fan_div[n - 1]);
+	u8 r;
 
+	down(&data->update_lock);
+	r = FAN_TO_REG(v, data->fan_div[n - 1]);
 	data->fan_min[n - 1] = r;
 
 	if (n == 1)
@@ -380,6 +388,7 @@
 	data->beep_mask &= data->alarm_mask;
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -398,6 +407,7 @@
 		return -EINVAL;
 	}
 
+	down(&data->update_lock);
 	data->fan_div[n - 1] = r;
 
 	if (n == 1)
@@ -405,6 +415,7 @@
 	else
 		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) | (r << 4));
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -412,9 +423,10 @@
 {
 	u8 r = simple_strtoul(buf, NULL, 10)?1:0;
 
+	down(&data->update_lock);
 	data->fan_off = r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | (r << 2));
-
+	up(&data->update_lock);
 	return count;
 }
 
@@ -439,22 +451,22 @@
 static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
-	u8 r = TEMP_TO_REG(v);
-
-	data->temp_max[n - 1] = r;
-	gl520_write_value(client, reg, r);
 
+	down(&data->update_lock);
+	data->temp_max[n - 1] = TEMP_TO_REG(v);;
+	gl520_write_value(client, reg, data->temp_max[n - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
-	u8 r = TEMP_TO_REG(v);
-
-	data->temp_max_hyst[n - 1] = r;
-	gl520_write_value(client, reg, r);
 
+	down(&data->update_lock);
+	data->temp_max_hyst[n - 1] = TEMP_TO_REG(v);
+	gl520_write_value(client, reg, data->temp_max_hyst[n - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -477,19 +489,22 @@
 {
 	u8 r = simple_strtoul(buf, NULL, 10)?0:1;
 
+	down(&data->update_lock);
 	data->beep_enable = !r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | (r << 2));
-
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
-	u8 r = simple_strtoul(buf, NULL, 10) & data->alarm_mask;
-
+	u8 r = simple_strtoul(buf, NULL, 10);
+	
+	down(&data->update_lock);
+	r &= data->alarm_mask;
 	data->beep_mask = r;
 	gl520_write_value(client, reg, r);
-
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-04-01 11:52:47 -08:00
@@ -265,9 +265,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr), 
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf, 
@@ -276,9 +279,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr), 
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -356,8 +362,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf, 
@@ -366,8 +375,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -408,9 +420,11 @@
 static ssize_t show_sensor(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	if (data->sensor & (1 << nr))
+	u8 reg = data->sensor; /* In case the value is updated while we use it */
+	
+	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
-	if (data->sensor & (8 << nr))
+	if (reg & (8 << nr))
 		return sprintf(buf, "2\n");  /* thermistor */
 	return sprintf(buf, "0\n");      /* disabled */
 }
@@ -421,6 +435,8 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	data->sensor &= ~(1 << nr);
 	data->sensor &= ~(8 << nr);
 	/* 3 = thermal diode; 2 = thermistor; 0 = disabled */
@@ -428,9 +444,12 @@
 	    data->sensor |= 1 << nr;
 	else if (val == 2)
 	    data->sensor |= 8 << nr;
-	else if (val != 0)
+	else if (val != 0) {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	up(&data->update_lock);
 	return count;
 }
 #define show_sensor_offset(offset)					\
@@ -484,8 +503,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
@@ -495,7 +517,10 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
 	int i, min[3];
-	u8 old = it87_read_value(client, IT87_REG_FAN_DIV);
+	u8 old;
+
+	down(&data->update_lock);
+	old = it87_read_value(client, IT87_REG_FAN_DIV);
 
 	for (i = 0; i < 3; i++)
 		min[i] = FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[i]));
@@ -522,6 +547,7 @@
 		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
 		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
 	}
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm_enable(struct device *dev, const char *buf,
@@ -531,6 +557,8 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (val == 0) {
 		int tmp;
 		/* make sure the fan is on when in on/off mode */
@@ -545,9 +573,12 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
-	} else
+	} else {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
 
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm(struct device *dev, const char *buf,
@@ -560,10 +591,11 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
 
+	down(&data->update_lock);
 	data->manual_pwm_ctl[nr] = val;
 	if (data->fan_main_ctrl & (1 << nr))
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
-
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm63.c	2005-04-01 11:52:47 -08:00
@@ -191,11 +191,14 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan1_low = FAN_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_LSB,
 				  data->fan1_low & 0xFF);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_MSB,
 				  data->fan1_low >> 8);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -217,10 +220,12 @@
 		return -EPERM;
 
 	val = simple_strtoul(buf, NULL, 10);
+	down(&data->update_lock);
 	data->pwm1_value = val <= 0 ? 0 :
 			   val >= 255 ? 2 * data->pwm1_freq :
 			   (val * data->pwm1_freq * 2 + 127) / 255;
 	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -256,8 +261,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm63_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP8_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 #define set_temp11(value, reg_msb, reg_lsb) \
@@ -267,9 +275,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm63_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP11_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg_msb, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, reg_lsb, data->value & 0xff); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp8(temp1_high, LM63_REG_LOCAL_HIGH);
@@ -292,10 +303,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	int hyst = TEMP8_FROM_REG(data->temp2_crit) -
-		   simple_strtol(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
+	long hyst;
+
+	down(&data->update_lock);
+	hyst = TEMP8_FROM_REG(data->temp2_crit) - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm75.c	2005-04-01 11:52:47 -08:00
@@ -90,8 +90,11 @@
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct lm75_data *data = i2c_get_clientdata(client);	\
 	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	down(&data->update_lock);				\
 	data->value = LM75_TEMP_TO_REG(temp);			\
 	lm75_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, LM75_REG_TEMP_OS);
diff -Nru a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm77.c	2005-04-01 11:52:47 -08:00
@@ -138,8 +138,12 @@
 {										\
 	struct i2c_client *client = to_i2c_client(dev);				\
 	struct lm77_data *data = i2c_get_clientdata(client);			\
-	data->value = simple_strtoul(buf, NULL, 10);				\
+	long val = simple_strtoul(buf, NULL, 10);				\
+										\
+	down(&data->update_lock);						\
+	data->value = val;				\
 	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));		\
+	up(&data->update_lock);							\
 	return count;								\
 }
 
@@ -152,9 +156,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	data->temp_hyst = data->temp_crit - simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_hyst = data->temp_crit - val;
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
+	up(&data->update_lock);
 	return count;
 }
 
@@ -163,13 +171,18 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	int oldcrithyst = data->temp_crit - data->temp_hyst;
-	data->temp_crit = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtoul(buf, NULL, 10);
+	int oldcrithyst;
+	
+	down(&data->update_lock);
+	oldcrithyst = data->temp_crit - data->temp_hyst;
+	data->temp_crit = val;
 	data->temp_hyst = data->temp_crit - oldcrithyst;
 	lm77_write_value(client, LM77_REG_TEMP_CRIT,
 			 LM77_TEMP_TO_REG(data->temp_crit));
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm78.c	2005-04-01 11:52:47 -08:00
@@ -200,8 +200,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -211,8 +214,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 	
@@ -275,8 +281,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_OVER, data->temp_over);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -291,8 +300,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_HYST, data->temp_hyst);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -323,8 +335,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -343,10 +358,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
 	unsigned long val = simple_strtoul(buf, NULL, 10);
-	int reg = lm78_read_value(client, LM78_REG_VID_FANDIV);
+	unsigned long min;
+	u8 reg;
+
+	down(&data->update_lock);
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
+
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
@@ -355,9 +374,11 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
+	reg = lm78_read_value(client, LM78_REG_VID_FANDIV);
 	switch (nr) {
 	case 0:
 		reg = (reg & 0xcf) | (data->fan_div[nr] << 4);
@@ -367,9 +388,12 @@
 		break;
 	}
 	lm78_write_value(client, LM78_REG_VID_FANDIV, reg);
+
 	data->fan_min[nr] =
 		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm80.c	2005-04-01 11:52:47 -08:00
@@ -190,8 +190,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock);\
 	data->value = IN_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock);\
 	return count; \
 }
 set_in(min0, in_min[0], LM80_REG_IN_MIN(0));
@@ -237,8 +240,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock);\
 	data->value = FAN_TO_REG(val, DIV_FROM_REG(data->div)); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock);\
 	return count; \
 }
 set_fan(min1, fan_min[0], LM80_REG_FAN_MIN(1), fan_div[0]);
@@ -253,15 +259,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	unsigned long min, val;
+	unsigned long min, val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
 
 	/* Save fan_min */
+	down(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	val = simple_strtoul(buf, NULL, 10);
-
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
@@ -270,6 +275,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
@@ -280,6 +286,7 @@
 	/* Restore fan_min */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+	up(&data->update_lock);
 
 	return count;
 }
@@ -317,8 +324,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP_LIMIT_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(hot_max, temp_hot_max, LM80_REG_TEMP_HOT_MAX);
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm83.c	2005-04-01 11:52:47 -08:00
@@ -177,8 +177,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(high1, temp_high[0], LM83_REG_W_LOCAL_HIGH);
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-04-01 11:52:47 -08:00
@@ -416,10 +416,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val);
 	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
 	up(&data->update_lock);
@@ -499,10 +498,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->pwm[nr] = PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_PWM(nr), data->pwm[nr]);
 	up(&data->update_lock);
@@ -560,10 +558,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_min[nr] = INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MIN(nr), data->in_min[nr]);
 	up(&data->update_lock);
@@ -579,10 +576,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->in_max[nr] = INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MAX(nr), data->in_max[nr]);
 	up(&data->update_lock);
@@ -643,10 +639,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), data->temp_min[nr]);
 	up(&data->update_lock);
@@ -662,10 +657,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int	val;
+	long val = simple_strtol(buf, NULL, 10);	
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
 	up(&data->update_lock);
@@ -718,10 +712,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int     val;
+	long val = simple_strtol(buf, NULL, 10);   
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->autofan[nr].config = (data->autofan[nr].config & (~0xe0))
 		| ZONE_TO_REG(val) ;
 	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
@@ -739,10 +732,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int     val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->autofan[nr].min_pwm = PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_MINPWM(nr),
 		data->autofan[nr].min_pwm);
@@ -759,10 +751,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int     val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->autofan[nr].min_off = val;
 	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
 		| data->syncpwm3
@@ -783,10 +774,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int     val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->autofan[nr].freq = FREQ_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		(data->zone[nr].range << 4)
@@ -865,10 +855,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int    min, val;
+	int min;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
 	data->zone[nr].off_desired = TEMP_TO_REG(val);
 	data->zone[nr].hyst = HYST_TO_REG(min - val);
@@ -895,10 +885,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int    val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->zone[nr].limit = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
@@ -939,11 +928,11 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int    min, val;
+	int min;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
-	val = simple_strtol(buf, NULL, 10);
 	data->zone[nr].max_desired = TEMP_TO_REG(val);
 	data->zone[nr].range = RANGE_TO_REG(
 		val - min);
@@ -963,10 +952,9 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	int     val;
+	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	val = simple_strtol(buf, NULL, 10);
 	data->zone[nr].critical = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
 		data->zone[nr].critical);
diff -Nru a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm87.c	2005-04-01 11:52:47 -08:00
@@ -252,9 +252,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
 			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
+	up(&data->update_lock);
 }
 
 static void set_in_max(struct device *dev, const char *buf, int nr)
@@ -262,9 +265,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
 			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
+	up(&data->update_lock);
 }
 
 #define set_in(offset) \
@@ -320,8 +326,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
+	up(&data->update_lock);
 }
 
 static void set_temp_high(struct device *dev, const char *buf, int nr)
@@ -329,8 +338,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
+	up(&data->update_lock);
 }
 
 #define set_temp(offset) \
@@ -398,9 +410,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val,
 			    FAN_DIV_FROM_REG(data->fan_div[nr]));
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
@@ -413,16 +428,21 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			    FAN_DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	u8 reg;
 
+	down(&data->update_lock);
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   FAN_DIV_FROM_REG(data->fan_div[nr]));
+
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
 	case 4: data->fan_div[nr] = 2; break;
 	case 8: data->fan_div[nr] = 3; break;
-	default: return -EINVAL;
+	default:
+		up(&data->update_lock);
+		return -EINVAL;
 	}
 
 	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
@@ -439,6 +459,8 @@
 	data->fan_min[nr] = FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
 			 data->fan_min[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
 
@@ -499,8 +521,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->aout = AOUT_TO_REG(val);
 	lm87_write_value(client, LM87_REG_AOUT, data->aout);
+	up(&data->update_lock);
 	return count;
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm90.c	2005-04-01 11:52:47 -08:00
@@ -239,11 +239,14 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	if (data->kind == adt7461) \
 		data->value = TEMP1_TO_REG_ADT7461(val); \
 	else \
 		data->value = TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 #define set_temp2(value, regh, regl) \
@@ -253,12 +256,15 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	if (data->kind == adt7461) \
 		data->value = TEMP2_TO_REG_ADT7461(val); \
 	else \
 		data->value = TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp1(temp_low1, LM90_REG_W_LOCAL_LOW);
@@ -283,10 +289,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int hyst = TEMP1_FROM_REG(data->temp_crit1) -
-		   simple_strtol(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
+	long hyst;
+
+	down(&data->update_lock);
+	hyst = TEMP1_FROM_REG(data->temp_crit1) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/lm92.c b/drivers/i2c/chips/lm92.c
--- a/drivers/i2c/chips/lm92.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/lm92.c	2005-04-01 11:52:47 -08:00
@@ -157,8 +157,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm92_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_word_data(client, reg, swab16(data->value)); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
@@ -189,10 +192,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm92_data *data = i2c_get_clientdata(client);
-	data->temp1_hyst = TEMP_FROM_REG(data->temp1_crit) -
-			   simple_strtol(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp1_hyst = TEMP_FROM_REG(data->temp1_crit) - val;
 	i2c_smbus_write_word_data(client, LM92_REG_TEMP_HYST,
 				  swab16(TEMP_TO_REG(data->temp1_hyst)));
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/max1619.c	2005-04-01 11:52:47 -08:00
@@ -141,8 +141,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 
diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2005-04-01 11:52:47 -08:00
@@ -259,6 +259,7 @@
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long fan_min = simple_strtol(buf, NULL, 10);
 
+	down(&data->update_lock);
 	fan_min = FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[nr]));
 
 	/* If it wouldn't fit, change clock divisor */
@@ -275,6 +276,7 @@
 	/* Write new divider, preserve alarm bits */
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(nr),
 			    data->fan_status[nr] & 0xF9);
+	up(&data->update_lock);
 
 	return count;
 }
@@ -336,10 +338,13 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->pwm[offset-1] = PWM_TO_REG(val, \
 			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
 			    data->pwm[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
@@ -378,9 +383,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset] = IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MIN, \
 			    data->in_min[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
@@ -389,10 +397,13 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset] = IN_TO_REG(val, \
 			       data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MAX, \
 			    data->in_max[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
@@ -451,9 +462,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset+7] = IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MIN, \
 			    data->in_min[offset+7]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
@@ -462,9 +476,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset+7] = IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MAX, \
 			    data->in_max[offset+7]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
@@ -473,9 +490,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_crit[offset-4] = IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_CRIT, \
 			    data->in_crit[offset-4]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
@@ -552,9 +572,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_min[offset-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MIN, \
 			    data->temp_min[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
@@ -563,9 +586,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_max[offset-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MAX, \
 			    data->temp_max[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
@@ -574,9 +600,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_crit[offset-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_CRIT, \
 			    data->temp_crit[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/pcf8591.c	2005-04-01 11:52:47 -08:00
@@ -144,11 +144,15 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	if (simple_strtoul(buf, NULL, 10))
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	if (val)
 		data->control |= PCF8591_CONTROL_AOEF;
 	else
 		data->control &= ~PCF8591_CONTROL_AOEF;
 	i2c_smbus_write_byte(client, data->control);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/sis5595.c b/drivers/i2c/chips/sis5595.c
--- a/drivers/i2c/chips/sis5595.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/sis5595.c	2005-04-01 11:52:47 -08:00
@@ -232,8 +232,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -243,8 +246,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -305,8 +311,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_OVER, data->temp_over);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -321,8 +330,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_HYST, data->temp_hyst);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -353,8 +365,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -373,10 +388,15 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
-	int reg = sis5595_read_value(client, SIS5595_REG_FANDIV);
+	int reg;
+
+	down(&data->update_lock);
+	min = FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
+	reg = sis5595_read_value(client, SIS5595_REG_FANDIV);
+
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
@@ -385,6 +405,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 	
@@ -400,6 +421,7 @@
 	data->fan_min[nr] =
 		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2005-04-01 11:52:47 -08:00
@@ -195,16 +195,20 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	long rpmdiv, val = simple_strtol(buf, NULL, 10);
 
-	long rpmdiv = simple_strtol(buf, NULL, 10)
-		    * DIV_FROM_REG(data->fan_div[nr]);
+	down(&data->update_lock);
+	rpmdiv = val * DIV_FROM_REG(data->fan_div[nr]);
 
-	if (983040 > 192 * rpmdiv || 2 * rpmdiv > 983040)
+	if (983040 > 192 * rpmdiv || 2 * rpmdiv > 983040) {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
 
 	data->fan_preload[nr] = 192 - ((983040 + rpmdiv / 2) / rpmdiv);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
+	up(&data->update_lock);
 
 	return count;
 }
@@ -224,12 +228,16 @@
 
 	if (new_div == old_div) /* No change */
 		return count;
+
+	down(&data->update_lock);
 	switch (new_div) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
 	case 4: data->fan_div[nr] = 2; break;
 	case 8: data->fan_div[nr] = 3; break;
-	default: return -EINVAL;
+	default:
+		up(&data->update_lock);
+		return -EINVAL;
 	}
 
 	tmp = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV) & 0x0F;
@@ -242,6 +250,7 @@
 	data->fan_preload[nr] = SENSORS_LIMIT(tmp, 0, 191);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
+	up(&data->update_lock);
 
 	return count;
 }
@@ -257,11 +266,13 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
 
+	down(&data->update_lock);
 	data->pwm[nr] &= 0x81; /* Preserve additional bits */
 	data->pwm[nr] |= PWM_TO_REG(val);
-
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
 
@@ -276,11 +287,12 @@
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
+	down(&data->update_lock);
 	data->pwm[nr] &= 0xFE; /* preserve the other bits */
 	data->pwm[nr] |= !val;
-
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
+	up(&data->update_lock);
 
 	return count;
 }
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/via686a.c	2005-04-01 11:52:47 -08:00
@@ -363,9 +363,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf, 
@@ -373,9 +376,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_in_offset(offset)					\
@@ -434,8 +440,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
@@ -443,8 +452,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -502,8 +514,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
@@ -511,10 +526,14 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
-	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	int old;
+
+	down(&data->update_lock);
+	old = via686a_read_value(client, VIA686A_REG_FANDIV);
 	data->fan_div[nr] = DIV_TO_REG(val);
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-04-01 11:52:47 -08:00
@@ -354,10 +354,13 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
+	 \
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83627hf_write_value(client, W83781D_REG_IN_##REG(nr), \
 			    data->in_##reg[nr]); \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min)
@@ -442,6 +445,9 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf == data->type || w83637hf == data->type))
 
@@ -452,6 +458,7 @@
 		data->in_min[0] = IN_TO_REG(val);
 
 	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -463,6 +470,9 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf == data->type || w83637hf == data->type))
 		
@@ -473,6 +483,7 @@
 		data->in_max[0] = IN_TO_REG(val);
 
 	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -508,11 +519,14 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1] =
 	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -574,6 +588,8 @@
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
 	 \
+	down(&data->update_lock); \
+	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		w83627hf_write_value(client, W83781D_REG_TEMP_##REG(nr), \
@@ -584,6 +600,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -692,6 +709,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (update_mask == BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val);
 		w83627hf_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -708,6 +727,7 @@
 	w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -752,12 +772,15 @@
 	struct w83627hf_data *data = i2c_get_clientdata(client);
 	unsigned long min;
 	u8 reg;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	data->fan_div[nr] = DIV_TO_REG(val);
 
 	reg = (w83627hf_read_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
 	       & (nr==0 ? 0xcf : 0x3f))
@@ -773,6 +796,7 @@
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -815,6 +839,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (data->type == w83627thf) {
 		/* bits 0-3 are reserved  in 627THF */
 		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
@@ -830,6 +856,7 @@
 				     data->pwm[nr - 1]);
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -871,6 +898,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
@@ -903,6 +932,7 @@
 		break;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-04-01 11:52:47 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-04-01 11:52:47 -08:00
@@ -296,9 +296,12 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10) / 10; \
+	 \
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min);
@@ -363,11 +366,14 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1] =
 	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -426,6 +432,8 @@
 	 \
 	val = simple_strtol(buf, NULL, 10); \
 	 \
+	down(&data->update_lock); \
+	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
@@ -436,6 +444,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -548,6 +557,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (update_mask == BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -567,6 +578,7 @@
 	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -609,13 +621,15 @@
 	struct w83781d_data *data = i2c_get_clientdata(client);
 	unsigned long min;
 	u8 reg;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+	
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
+	data->fan_div[nr] = DIV_TO_REG(val, data->type);
 
 	reg = (w83781d_read_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
 	       & (nr==0 ? 0xcf : 0x3f))
@@ -634,6 +648,7 @@
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -680,9 +695,10 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
 	data->pwm[nr - 1] = PWM_TO_REG(val);
 	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
-
+	up(&data->update_lock);
 	return count;
 }
 
@@ -695,6 +711,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 0:
 	case 1:
@@ -710,9 +728,11 @@
 		break;
 
 	default:
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -774,6 +794,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
@@ -805,6 +827,7 @@
 		break;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 

