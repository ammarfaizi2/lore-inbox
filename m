Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUCPDEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCPDCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:02:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:22959 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262898AbUCPAC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:27 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391392277@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <10793913921416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.17, 2004/02/23 16:43:25-08:00, khali@linux-fr.org

[PATCH] I2C: rename sysfs files, part 2 of 2

Here is the second step of my sysfs renaming plan.

This one does the following renames (as I already announced on the
LKML):
temp<n>_hyst  -> temp<n>_max_hyst or temp<n>_crit_hyst
sensor<n>     -> temp<n>_type
pwm<n>        -> fan<n>_pwm
pwm<n>_enable -> fan<n>_pwm_enable
vid           -> in<n>_ref

The associated libsensors patch is here:
http://jdelvare.net1.nerim.net/sensors/libsensors-sysfs-names-2.diff
(not applied yet, on purpose)


Note that the w83781d part is a bit more complex, not only because it is
the only driver to require the 5 changes, but also because at some point
the macros assume that the internal variable names match the sysfs
names, so I had to change them too (better than rewriting the macros,
methinks).

For reference, here is the list of changes, by driver:

asb100:
    hyst -> max_hyst (4)
    pwm -> fan_pwm (1)
    pwm_enable -> fan_pwm_enable (1)
    vid -> in_ref (1)
fscher:
     pwm -> fan_pwm (3)
gl518sm:
    hyst -> max_hyst (1)
it87:
    sensor -> temp_type (3)
lm75:
    hyst -> max_hyst (1)
lm78:
    hyst -> max_hyst (1)
    vid -> in_ref (1)
lm85:
    pwm -> fan_pwm (3)
    pwm_enable -> fan_pwm_enable (3)
    vid -> in_ref (1)
lm90:
    hyst -> crit_hyst (2)
via686a:
    hyst -> max_hyst (3)
w83781d:
    hyst -> max_hyst (2)
    sensor -> temp_type (3)
    pwm -> fan_pwm (4)
    pwm_enable -> fan_pwm_enable (1)
    vid -> in_ref (1)

There's also a documentation update. There will be one more after that
(to make it more readable, no contents change), and a patch to lm83.c to
bring it to compliance with the (new) standard. (If you wonder why I did
not change it with the other drivers: because it was *already* not in
compliance with the old standard. There's some real work to do for this
one.)


 Documentation/i2c/sysfs-interface |   26 +++++++++++++++++---------
 drivers/i2c/chips/asb100.c        |   16 ++++++++--------
 drivers/i2c/chips/fscher.c        |    8 ++++----
 drivers/i2c/chips/gl518sm.c       |    4 ++--
 drivers/i2c/chips/it87.c          |    8 ++++----
 drivers/i2c/chips/lm75.c          |    4 ++--
 drivers/i2c/chips/lm78.c          |    8 ++++----
 drivers/i2c/chips/lm85.c          |   20 ++++++++++----------
 drivers/i2c/chips/lm90.c          |    8 ++++----
 drivers/i2c/chips/via686a.c       |    8 ++++----
 drivers/i2c/chips/w83781d.c       |   34 +++++++++++++++++-----------------
 11 files changed, 76 insertions(+), 68 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:15 2004
+++ b/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:15 2004
@@ -107,7 +107,7 @@
 			in7_*	varies
 			in8_*	varies
 
-vid		CPU core voltage.
+in0_ref		CPU core reference voltage.
 		Read only.
 		Fixed point value in form XXXX corresponding to CPU core
 		voltage as told to the sensor chip.  Divide by 1000 to
@@ -138,14 +138,15 @@
 		Some chips only support values 1,2,4,8.
 		See doc/fan-divisors for details.
 
-pwm[1-3]	Pulse width modulation fan control.
+fan[1-3]_pwm	Pulse width modulation fan control.
 		Integer 0 - 255
 		Read/Write
 		255 is max or 100%.
 		Corresponds to the fans 1-3.
 
-pwm[1-3]_enable pwm enable
-		not always present even if pwm* is.
+fan[1-3]_pwm_enable
+		Switch PWM on and off.
+		Not always present even if fan*_pwm is.
 		0 to turn off
 		1 to turn on
 		Read/Write
@@ -155,7 +156,7 @@
 * Temperatures *
 ****************
 
-sensor[1-3]	Sensor type selection.
+temp[1-3]_type	Sensor type selection.
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
 
@@ -169,7 +170,8 @@
 		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp[1-3]_hyst	Temperature hysteresis value.
+temp[1-3]_max_hyst
+		Temperature hysteresis value for max limit.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.  Must be reported as an
 		absolute temperature, NOT a delta from the max value.
@@ -180,11 +182,17 @@
 		1000 to get degrees Celsius.
 		Read only value.
 
-temp_crit	Temperature critical value, typically greater than all
-		temp_max values.
+temp[1-4]_crit	Temperature critical value, typically greater than
+		corresponding temp_max values.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
-		Common to all temperature channels.
+		Read/Write value.
+
+temp[1-2]_crit_hyst
+		Temperature hysteresis value for critical limit.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.  Must be reported as an
+		absolute temperature, NOT a delta from the critical value.
 		Read/Write value.
 
 		If there are multiple temperature sensors, temp1_* is
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/asb100.c	Mon Mar 15 14:36:15 2004
@@ -505,7 +505,7 @@
 { \
 	return set_temp_hyst(dev, buf, count, num-1); \
 } \
-static DEVICE_ATTR(temp##num##_hyst, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(temp##num##_max_hyst, S_IRUGO | S_IWUSR, \
 		show_temp_hyst##num, set_temp_hyst##num)
 
 sysfs_temp(1)
@@ -517,7 +517,7 @@
 #define device_create_file_temp(client, num) do { \
 	device_create_file(&client->dev, &dev_attr_temp##num##_input); \
 	device_create_file(&client->dev, &dev_attr_temp##num##_max); \
-	device_create_file(&client->dev, &dev_attr_temp##num##_hyst); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_max_hyst); \
 } while (0)
 
 static ssize_t show_vid(struct device *dev, char *buf)
@@ -526,9 +526,9 @@
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(vid, S_IRUGO, show_vid, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL)
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_vid)
+device_create_file(&client->dev, &dev_attr_in0_ref)
 
 /* VRM */
 static ssize_t show_vrm(struct device *dev, char *buf)
@@ -597,12 +597,12 @@
 	return count;
 }
 
-static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1)
-static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1)
+static DEVICE_ATTR(fan1_pwm_enable, S_IRUGO | S_IWUSR,
 		show_pwm_enable1, set_pwm_enable1)
 #define device_create_file_pwm1(client) do { \
-	device_create_file(&new_client->dev, &dev_attr_pwm1); \
-	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm); \
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable); \
 } while (0)
 
 /* This function is called when:
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:36:15 2004
@@ -205,7 +205,7 @@
 static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
-sysfs_rw_n(pwm,        , offset, reg_min) \
+sysfs_rw_n(fan, _pwm   , offset, reg_min) \
 sysfs_rw_n(fan, _status, offset, reg_status) \
 sysfs_rw_n(fan, _div   , offset, reg_ripple) \
 sysfs_ro_n(fan, _input , offset, reg_act)
@@ -254,7 +254,7 @@
 #define device_create_file_fan(client, offset) \
 do { \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_status); \
-	device_create_file(&client->dev, &dev_attr_pwm##offset); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
 } while (0)
@@ -489,7 +489,7 @@
 	return sprintf(buf, "%u\n", data->fan_status[FAN_INDEX_FROM_NUM(nr)] & 0x04);
 }
 
-static ssize_t set_pwm(struct i2c_client *client, struct fscher_data *data,
+static ssize_t set_fan_pwm(struct i2c_client *client, struct fscher_data *data,
 		       const char *buf, size_t count, int nr, int reg)
 {
 	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = simple_strtoul(buf, NULL, 10) & 0xff;
@@ -498,7 +498,7 @@
 	return count;
 }
 
-static ssize_t show_pwm (struct fscher_data *data, char *buf, int nr)
+static ssize_t show_fan_pwm (struct fscher_data *data, char *buf, int nr)
 {
 	return sprintf(buf, "%u\n", data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 }
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:36:15 2004
@@ -309,7 +309,7 @@
 
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
 static DEVICE_ATTR(temp1_max, S_IWUSR|S_IRUGO, show_temp_max1, set_temp_max1);
-static DEVICE_ATTR(temp1_hyst, S_IWUSR|S_IRUGO,
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR|S_IRUGO,
 	show_temp_hyst1, set_temp_hyst1);
 static DEVICE_ATTR(fan1_auto, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
 static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
@@ -445,7 +445,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_beep_enable);
 	device_create_file(&new_client->dev, &dev_attr_beep_mask);
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:15 2004
@@ -450,7 +450,7 @@
 {									\
 	return set_sensor(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR,	 		\
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	 		\
 		show_sensor_##offset, set_sensor_##offset)
 
 show_sensor_offset(1);
@@ -737,9 +737,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
 	device_create_file(&new_client->dev, &dev_attr_temp2_min);
 	device_create_file(&new_client->dev, &dev_attr_temp3_min);
-	device_create_file(&new_client->dev, &dev_attr_sensor1);
-	device_create_file(&new_client->dev, &dev_attr_sensor2);
-	device_create_file(&new_client->dev, &dev_attr_sensor3);
+	device_create_file(&new_client->dev, &dev_attr_temp1_type);
+	device_create_file(&new_client->dev, &dev_attr_temp2_type);
+	device_create_file(&new_client->dev, &dev_attr_temp3_type);
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan2_input);
 	device_create_file(&new_client->dev, &dev_attr_fan3_input);
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 15 14:36:15 2004
@@ -105,7 +105,7 @@
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp1_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
@@ -198,7 +198,7 @@
 	
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Mar 15 14:36:15 2004
@@ -372,7 +372,7 @@
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL)
 static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp1_hyst, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -495,7 +495,7 @@
 	lm78_update_client(client);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
 }
-static DEVICE_ATTR(vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
@@ -680,7 +680,7 @@
 	device_create_file(&new_client->dev, &dev_attr_in6_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
@@ -691,7 +691,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_in0_ref);
 
 	return 0;
 
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Mar 15 14:36:15 2004
@@ -480,7 +480,7 @@
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -564,9 +564,9 @@
 {									\
 	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
 }									\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset)			\
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO, show_pwm_enable##offset, NULL)
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL)
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -894,12 +894,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan2_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan4_min);
-	device_create_file(&new_client->dev, &dev_attr_pwm1);
-	device_create_file(&new_client->dev, &dev_attr_pwm2);
-	device_create_file(&new_client->dev, &dev_attr_pwm3);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -925,7 +925,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
-	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_in0_ref);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Mar 15 14:36:15 2004
@@ -259,9 +259,9 @@
 	set_temp_crit1);
 static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
 	set_temp_crit2);
-static DEVICE_ATTR(temp1_hyst, S_IWUSR | S_IRUGO, show_temp_hyst1,
+static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst1,
 	set_temp_hyst1);
-static DEVICE_ATTR(temp2_hyst, S_IRUGO, show_temp_hyst2, NULL);
+static DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_hyst2, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -389,8 +389,8 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp2_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_crit_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Mar 15 14:36:15 2004
@@ -559,7 +559,7 @@
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_over, set_temp_##offset##_over) 	\
-static DEVICE_ATTR(temp##offset##_hyst, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_hyst, set_temp_##offset##_hyst)	
 
 show_temp_offset(1);
@@ -763,9 +763,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp2_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp3_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan2_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:15 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:15 2004
@@ -247,10 +247,10 @@
 	u8 fan_min[3];		/* Register value */
 	u8 temp;
 	u8 temp_max;		/* Register value */
-	u8 temp_hyst;		/* Register value */
+	u8 temp_max_hyst;	/* Register value */
 	u16 temp_add[2];	/* Register value */
 	u16 temp_max_add[2];	/* Register value */
-	u16 temp_hyst_add[2];	/* Register value */
+	u16 temp_max_hyst_add[2];	/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -448,7 +448,7 @@
 }
 show_temp_reg(temp);
 show_temp_reg(temp_max);
-show_temp_reg(temp_hyst);
+show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
@@ -476,7 +476,7 @@
 	return count; \
 }
 store_temp_reg(OVER, max);
-store_temp_reg(HYST, hyst);
+store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -500,7 +500,7 @@
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset); \
 sysfs_temp_reg_offset(max, offset); \
-sysfs_temp_reg_offset(hyst, offset);
+sysfs_temp_reg_offset(max_hyst, offset);
 
 sysfs_temp_offsets(1);
 sysfs_temp_offsets(2);
@@ -510,7 +510,7 @@
 do { \
 device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
 device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
-device_create_file(&client->dev, &dev_attr_temp##offset##_hyst); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
 } while (0)
 
 static ssize_t
@@ -525,9 +525,9 @@
 }
 
 static
-DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL)
+DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_vid);
+device_create_file(&client->dev, &dev_attr_in0_ref);
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
 {
@@ -808,7 +808,7 @@
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset)
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset)
 
 #define sysfs_pwmenable(offset) \
 static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
@@ -819,7 +819,7 @@
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
 
 sysfs_pwm(1);
 sysfs_pwm(2);
@@ -829,12 +829,12 @@
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_pwm##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
 } while (0)
 
 #define device_create_file_pwmenable(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_pwm_enable); \
 } while (0)
 
 static ssize_t
@@ -901,7 +901,7 @@
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset)
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset)
 
 sysfs_sensor(1);
 sysfs_sensor(2);
@@ -909,7 +909,7 @@
 
 #define device_create_file_sensor(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_sensor##offset); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
 } while (0)
 
 #ifdef W83781D_RT
@@ -1698,13 +1698,13 @@
 		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));
 		data->temp_max =
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
-		data->temp_hyst =
+		data->temp_max_hyst =
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP(2));
 		data->temp_max_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
-		data->temp_hyst_add[0] =
+		data->temp_max_hyst_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83783s && data->type != w83697hf) {
 			data->temp_add[1] =
@@ -1712,7 +1712,7 @@
 			data->temp_max_add[1] =
 			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_OVER(3));
-			data->temp_hyst_add[1] =
+			data->temp_max_hyst_add[1] =
 			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_HYST(3));
 		}

