Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270098AbUJTA0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270098AbUJTA0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUJTAX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:23:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:18868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268051AbUJTATg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:36 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315051069@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <1098231505400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.6, 2004/09/29 13:37:26-07:00, mhoffman@lightlink.com

[PATCH] i2c: sensors chip driver updates

This patch modifies some sysfs file names for sensors chip drivers in
accordance with the standard interface proposed here [1] and refined
here [2].  The lm_sensors userspace tools have been modified to accept
both the new and old names.  This patch was tested for some drivers,
and at least compile tested for the rest.

[1] http://archives.andrew.net.au/lm-sensors/msg08477.html

[2] http://archives.andrew.net.au/lm-sensors/msg18391.html

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/sysfs-interface |    7 ++++--
 drivers/i2c/chips/adm1031.c       |    6 ++---
 drivers/i2c/chips/asb100.c        |    8 +++----
 drivers/i2c/chips/lm85.c          |   17 ++++++++--------
 drivers/i2c/chips/smsc47m1.c      |   40 +++++++++++++++++++-------------------
 drivers/i2c/chips/w83627hf.c      |    4 +--
 drivers/i2c/chips/w83781d.c       |   16 +++++++++------
 7 files changed, 53 insertions(+), 45 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	2004-10-19 16:54:30 -07:00
+++ b/Documentation/i2c/sysfs-interface	2004-10-19 16:54:30 -07:00
@@ -135,12 +135,15 @@
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
-fan[1-3]_pwm	Pulse width modulation fan control.
+*******
+* PWM *
+*******
+pwm[1-3]	Pulse width modulation fan control.
 		Integer value in the range 0 to 255
 		Read/Write
 		255 is max or 100%.
 
-fan[1-3]_pwm_enable
+pwm[1-3]_enable
 		Switch PWM on and off.
 		Not always present even if fan*_pwm is.
 		0 to turn off
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/adm1031.c	2004-10-19 16:54:30 -07:00
@@ -436,7 +436,7 @@
 {									\
 	return set_pwm(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
 		   show_pwm_##offset, set_pwm_##offset)
 
 pwm_reg(1);
@@ -799,7 +799,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
 	device_create_file(&new_client->dev, &dev_attr_auto_fan1_channel);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -826,7 +826,7 @@
 		device_create_file(&new_client->dev, &dev_attr_fan2_input);
 		device_create_file(&new_client->dev, &dev_attr_fan2_div);
 		device_create_file(&new_client->dev, &dev_attr_fan2_min);
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
+		device_create_file(&new_client->dev, &dev_attr_pwm2);
 		device_create_file(&new_client->dev,
 				   &dev_attr_auto_fan2_channel);
 		device_create_file(&new_client->dev, &dev_attr_temp3_input);
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/asb100.c	2004-10-19 16:54:30 -07:00
@@ -591,12 +591,12 @@
 	return count;
 }
 
-static DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
-static DEVICE_ATTR(fan1_pwm_enable, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 		show_pwm_enable1, set_pwm_enable1);
 #define device_create_file_pwm1(client) do { \
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm); \
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable); \
+	device_create_file(&new_client->dev, &dev_attr_pwm1); \
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
 } while (0)
 
 /* This function is called when:
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-10-19 16:54:30 -07:00
@@ -538,9 +538,10 @@
 {									\
 	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
 }									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset);			\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL);
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO, 			\
+		show_pwm_enable##offset, NULL);
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -845,12 +846,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan2_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan4_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-10-19 16:54:30 -07:00
@@ -182,13 +182,13 @@
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 
-static ssize_t get_fan_pwm(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm(struct device *dev, char *buf, int nr)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
 }
 
-static ssize_t get_fan_pwm_en(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm_en(struct device *dev, char *buf, int nr)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[nr]));
@@ -256,7 +256,7 @@
 	return count;
 }
 
-static ssize_t set_fan_pwm(struct device *dev, const char *buf,
+static ssize_t set_pwm(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -275,7 +275,7 @@
 	return count;
 }
 
-static ssize_t set_fan_pwm_en(struct device *dev, const char *buf,
+static ssize_t set_pwm_en(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -318,23 +318,23 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_pwm (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
 {									\
-	return get_fan_pwm(dev, buf, 0x##offset - 1);			\
+	return get_pwm(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_pwm (struct device *dev,		\
+static ssize_t set_pwm##offset (struct device *dev,			\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_pwm_en (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
 {									\
-	return get_fan_pwm_en(dev, buf, 0x##offset - 1);		\
+	return get_pwm_en(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_pwm_en (struct device *dev,		\
+static ssize_t set_pwm##offset##_en (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_pwm_en(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm_en(dev, buf, count, 0x##offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan##offset,	\
 		NULL);							\
@@ -342,10 +342,10 @@
 		get_fan##offset##_min, set_fan##offset##_min);		\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
 		get_fan##offset##_div, set_fan##offset##_div);		\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_pwm, set_fan##offset##_pwm);		\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_pwm_en, set_fan##offset##_pwm_en);
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
+		get_pwm##offset, set_pwm##offset);			\
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
+		get_pwm##offset##_en, set_pwm##offset##_en);
 
 fan_present(1);
 fan_present(2);
@@ -462,15 +462,15 @@
 
 	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
 	    == 0x04) {
-		device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
-		device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm1);
+		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
 			"skipping\n");
 	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
 	    == 0x04) {
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
-		device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm2);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 2 not enabled by hardware, "
 			"skipping\n");
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-10-19 16:54:30 -07:00
@@ -845,7 +845,7 @@
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
 		  show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 sysfs_pwm(1);
@@ -854,7 +854,7 @@
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
 } while (0)
 
 static ssize_t
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-10-19 16:54:30 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-10-19 16:54:30 -07:00
@@ -740,22 +740,26 @@
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_pwm_##offset (struct device *dev, \
+		const char *buf, size_t count) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset);
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
+		show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 #define sysfs_pwmenable(offset) \
 static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
 { \
 	return show_pwmenable_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwmenable_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_pwmenable_##offset (struct device *dev, \
+		const char *buf, size_t count) \
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, \
+		show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
 
 sysfs_pwm(1);
 sysfs_pwm(2);
@@ -765,12 +769,12 @@
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
 } while (0)
 
 #define device_create_file_pwmenable(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_pwm_enable); \
+device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
 } while (0)
 
 static ssize_t

