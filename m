Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUCPARi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUCPAQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:16:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:17839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262857AbUCPACQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:16 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391394320@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <1079391394595@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.9, 2004/03/11 16:53:51-08:00, mhoffman@lightlink.com

[PATCH] I2C: sensor chip driver refactoring

This patch is a refactoring of some common code among all sensors chip
drivers (except asb100, which was written this way to begin with.)
It saves a handful of lines and ~100-300 bytes per module.  It compiles
ok.  I've only tested it against one of the drivers, but the changes are
similar across the board and quite mechanical.  Please apply.


 drivers/i2c/chips/adm1021.c   |   31 ++++++----------
 drivers/i2c/chips/fscher.c    |   11 +++--
 drivers/i2c/chips/gl518sm.c   |   15 +++----
 drivers/i2c/chips/it87.c      |   51 ++++++++-------------------
 drivers/i2c/chips/lm75.c      |   11 +++--
 drivers/i2c/chips/lm78.c      |   51 ++++++++-------------------
 drivers/i2c/chips/lm80.c      |   31 +++++-----------
 drivers/i2c/chips/lm83.c      |   15 +++----
 drivers/i2c/chips/lm85.c      |   71 +++++++++----------------------------
 drivers/i2c/chips/lm90.c      |   19 ++++------
 drivers/i2c/chips/via686a.c   |   47 +++++++-----------------
 drivers/i2c/chips/w83627hf.c  |   67 +++++++----------------------------
 drivers/i2c/chips/w83781d.c   |   79 +++++++++---------------------------------
 drivers/i2c/chips/w83l785ts.c |   15 +++----
 14 files changed, 162 insertions(+), 352 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:33 2004
@@ -139,7 +139,7 @@
 static int adm1021_read_value(struct i2c_client *client, u8 reg);
 static int adm1021_write_value(struct i2c_client *client, u8 reg,
 			       u16 value);
-static void adm1021_update_client(struct i2c_client *client);
+static struct adm1021_data *adm1021_update_device(struct device *dev);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
 static int read_only = 0;
@@ -161,15 +161,10 @@
 static int adm1021_id = 0;
 
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct adm1021_data *data = i2c_get_clientdata(client);	\
-	int temp;						\
-								\
-	adm1021_update_client(client);				\
-	temp = TEMP_FROM_REG(data->value);			\
-	return sprintf(buf, "%d\n", temp);			\
+static ssize_t show_##value(struct device *dev, char *buf)		\
+{									\
+	struct adm1021_data *data = adm1021_update_device(dev);		\
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));	\
 }
 show(temp_max);
 show(temp_hyst);
@@ -179,13 +174,10 @@
 show(remote_temp_input);
 
 #define show2(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct adm1021_data *data = i2c_get_clientdata(client);	\
-								\
-	adm1021_update_client(client);				\
-	return sprintf(buf, "%d\n", data->value);		\
+static ssize_t show_##value(struct device *dev, char *buf)		\
+{									\
+	struct adm1021_data *data = adm1021_update_device(dev);		\
+	return sprintf(buf, "%d\n", data->value);			\
 }
 show2(alarms);
 show2(die_code);
@@ -393,8 +385,9 @@
 	return 0;
 }
 
-static void adm1021_update_client(struct i2c_client *client)
+static struct adm1021_data *adm1021_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -424,6 +417,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_adm1021_init(void)
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:34:33 2004
@@ -113,7 +113,7 @@
 static int fscher_attach_adapter(struct i2c_adapter *adapter);
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscher_detach_client(struct i2c_client *client);
-static void fscher_update_client(struct i2c_client *client);
+static struct fscher_data *fscher_update_device(struct device *dev);
 static void fscher_init_client(struct i2c_client *client);
 
 static int fscher_read_value(struct i2c_client *client, u8 reg);
@@ -170,9 +170,7 @@
 static ssize_t show_##kind##offset##sub (struct device *, char *); \
 static ssize_t show_##kind##offset##sub (struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct fscher_data *data = i2c_get_clientdata(client); \
-	fscher_update_client(client); \
+	struct fscher_data *data = fscher_update_device(dev); \
 	return show_##kind##sub(data, buf, (offset)); \
 }
 
@@ -420,8 +418,9 @@
 	data->revision =  fscher_read_value(client, FSCHER_REG_REVISION);
 }
 
-static void fscher_update_client(struct i2c_client *client)
+static struct fscher_data *fscher_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct fscher_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -466,6 +465,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:33 2004
@@ -151,7 +151,7 @@
 static int gl518_detach_client(struct i2c_client *client);
 static int gl518_read_value(struct i2c_client *client, u8 reg);
 static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value);
-static void gl518_update_client(struct i2c_client *client);
+static struct gl518_data *gl518_update_device(struct device *dev);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver gl518_driver = {
@@ -176,18 +176,14 @@
 #define show(type, suffix, value)					\
 static ssize_t show_##suffix(struct device *dev, char *buf)		\
 {									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct gl518_data *data = i2c_get_clientdata(client);		\
-	gl518_update_client(client);					\
+	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
 }
 
 #define show_fan(suffix, value, index)					\
 static ssize_t show_##suffix(struct device *dev, char *buf)		\
 {									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct gl518_data *data = i2c_get_clientdata(client);		\
-	gl518_update_client(client);					\
+	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[index],	\
 		DIV_FROM_REG(data->fan_div[index])));			\
 }
@@ -523,8 +519,9 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-static void gl518_update_client(struct i2c_client *client)
+static struct gl518_data *gl518_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
 	int val;
 
@@ -590,6 +587,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_gl518sm_init(void)
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:33 2004
@@ -167,7 +167,7 @@
 static int it87_read_value(struct i2c_client *client, u8 register);
 static int it87_write_value(struct i2c_client *client, u8 register,
 			u8 value);
-static void it87_update_client(struct i2c_client *client);
+static struct it87_data *it87_update_device(struct device *dev);
 static void it87_init_client(struct i2c_client *client, struct it87_data *data);
 
 
@@ -184,25 +184,19 @@
 
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr])*10 );
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr])*10 );
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr])*10 );
 }
 
@@ -284,23 +278,17 @@
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
 }
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*100);
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
@@ -360,9 +348,7 @@
 
 static ssize_t show_sensor(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	if (data->sensor & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
 	if (data->sensor & (8 << nr))
@@ -408,25 +394,19 @@
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
 				DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
 		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
@@ -512,9 +492,7 @@
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	it87_update_client(client);
+	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
 static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
@@ -811,8 +789,9 @@
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
-static void it87_update_client(struct i2c_client *client)
+static struct it87_data *it87_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -883,6 +862,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sm_it87_init(void)
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:33 2004
@@ -64,7 +64,7 @@
 static int lm75_detach_client(struct i2c_client *client);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
-static void lm75_update_client(struct i2c_client *client);
+static struct lm75_data *lm75_update_device(struct device *dev);
 
 
 /* This is the driver that will be inserted */
@@ -82,9 +82,7 @@
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
 {									\
-	struct i2c_client *client = to_i2c_client(dev);			\
-	struct lm75_data *data = i2c_get_clientdata(client);		\
-	lm75_update_client(client);					\
+	struct lm75_data *data = lm75_update_device(dev);		\
 	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
 }
 show(temp_max);
@@ -250,8 +248,9 @@
 	lm75_write_value(client, LM75_REG_CONF, 0);
 }
 
-static void lm75_update_client(struct i2c_client *client)
+static struct lm75_data *lm75_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -268,6 +267,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_lm75_init(void)
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:33 2004
@@ -223,7 +223,7 @@
 
 static int lm78_read_value(struct i2c_client *client, u8 register);
 static int lm78_write_value(struct i2c_client *client, u8 register, u8 value);
-static void lm78_update_client(struct i2c_client *client);
+static struct lm78_data *lm78_update_device(struct device *dev);
 static void lm78_init_client(struct i2c_client *client);
 
 
@@ -239,25 +239,19 @@
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
@@ -327,17 +321,13 @@
 /* Temperature */
 static ssize_t show_temp(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
 static ssize_t show_temp_over(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
@@ -353,9 +343,7 @@
 
 static ssize_t show_temp_hyst(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
@@ -378,18 +366,14 @@
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
@@ -407,9 +391,7 @@
 
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
 
@@ -490,9 +472,7 @@
 /* VID */
 static ssize_t show_vid(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
 }
 static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
@@ -500,9 +480,7 @@
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
@@ -829,8 +807,9 @@
 
 }
 
-static void lm78_update_client(struct i2c_client *client)
+static struct lm78_data *lm78_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -879,6 +858,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sm_lm78_init(void)
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm80.c	Mon Mar 15 14:34:33 2004
@@ -141,7 +141,7 @@
 static int lm80_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm80_init_client(struct i2c_client *client);
 static int lm80_detach_client(struct i2c_client *client);
-static void lm80_update_client(struct i2c_client *client);
+static struct lm80_data *lm80_update_device(struct device *dev);
 static int lm80_read_value(struct i2c_client *client, u8 reg);
 static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value);
 
@@ -171,9 +171,7 @@
 #define show_in(suffix, value) \
 static ssize_t show_in_##suffix(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
-	lm80_update_client(client); \
+	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->value)); \
 }
 show_in(min0, in_min[0]);
@@ -227,9 +225,7 @@
 #define show_fan(suffix, value, div) \
 static ssize_t show_fan_##suffix(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
-	lm80_update_client(client); \
+	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value, \
 		       DIV_FROM_REG(data->div))); \
 }
@@ -241,9 +237,7 @@
 #define show_fan_div(suffix, value) \
 static ssize_t show_fan_div##suffix(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
-	lm80_update_client(client); \
+	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->value)); \
 }
 show_fan_div(1, fan_div[0]);
@@ -265,18 +259,14 @@
 
 static ssize_t show_temp_input1(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm80_data *data = i2c_get_clientdata(client);
-	lm80_update_client(client);
+	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
 }
 
 #define show_temp(suffix, value) \
 static ssize_t show_temp_##suffix(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
-	lm80_update_client(client); \
+	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
 }
 show_temp(hot_max, temp_hot_max);
@@ -302,9 +292,7 @@
 
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm80_data *data = i2c_get_clientdata(client);
-	lm80_update_client(client);
+	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
 }
 
@@ -498,8 +486,9 @@
 	lm80_write_value(client, LM80_REG_CONFIG, 0x01);
 }
 
-static void lm80_update_client(struct i2c_client *client)
+static struct lm80_data *lm80_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -546,6 +535,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_lm80_init(void)
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:33 2004
@@ -118,7 +118,7 @@
 static int lm83_attach_adapter(struct i2c_adapter *adapter);
 static int lm83_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm83_detach_client(struct i2c_client *client);
-static void lm83_update_client(struct i2c_client *client);
+static struct lm83_data *lm83_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
@@ -162,9 +162,7 @@
 #define show_temp(suffix, value) \
 static ssize_t show_temp_##suffix(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm83_data *data = i2c_get_clientdata(client); \
-	lm83_update_client(client); \
+	struct lm83_data *data = lm83_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
 }
 show_temp(input1, temp_input[0]);
@@ -195,9 +193,7 @@
 
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm83_data *data = i2c_get_clientdata(client);
-	lm83_update_client(client);
+	struct lm83_data *data = lm83_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
@@ -353,8 +349,9 @@
 	return 0;
 }
 
-static void lm83_update_client(struct i2c_client *client)
+static struct lm83_data *lm83_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm83_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -385,6 +382,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_lm83_init(void)
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:33 2004
@@ -397,7 +397,7 @@
 
 static int lm85_read_value(struct i2c_client *client, u8 register);
 static int lm85_write_value(struct i2c_client *client, u8 register, int value);
-static void lm85_update_client(struct i2c_client *client);
+static struct lm85_data *lm85_update_device(struct device *dev);
 static void lm85_init_client(struct i2c_client *client);
 
 
@@ -417,18 +417,12 @@
 /* 4 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr]) );
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr]) );
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
@@ -473,10 +467,7 @@
 
 static ssize_t show_vid_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
@@ -484,10 +475,7 @@
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
@@ -506,10 +494,7 @@
 
 static ssize_t show_alarms_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
 }
 
@@ -519,10 +504,7 @@
 
 static ssize_t show_pwm(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm[nr]) );
 }
 static ssize_t set_pwm(struct device *dev, const char *buf, 
@@ -541,11 +523,9 @@
 }
 static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	int	pwm_zone;
 
-	lm85_update_client(client);
 	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
 	return sprintf(buf,"%d\n", (pwm_zone != 0 && pwm_zone != -1) );
 }
@@ -576,18 +556,12 @@
 
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]) );
 }
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]) );
 }
 static ssize_t set_in_min(struct device *dev, const char *buf, 
@@ -606,10 +580,7 @@
 }
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]) );
 }
 static ssize_t set_in_max(struct device *dev, const char *buf, 
@@ -665,18 +636,12 @@
 
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]) );
 }
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]) );
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf, 
@@ -695,10 +660,7 @@
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	lm85_update_client(client);
+	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]) );
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
@@ -1047,8 +1009,9 @@
 	lm85_write_value(client, LM85_REG_CONFIG, value);
 }
 
-void lm85_update_client(struct i2c_client *client)
+static struct lm85_data *lm85_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -1189,6 +1152,8 @@
 	data->valid = 1;
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:33 2004
@@ -126,7 +126,7 @@
 	int kind);
 static void lm90_init_client(struct i2c_client *client);
 static int lm90_detach_client(struct i2c_client *client);
-static void lm90_update_client(struct i2c_client *client);
+static struct lm90_data *lm90_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
@@ -171,9 +171,7 @@
 #define show_temp(value, converter) \
 static ssize_t show_##value(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm90_data *data = i2c_get_clientdata(client); \
-	lm90_update_client(client); \
+	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", converter(data->value)); \
 }
 show_temp(temp_input1, TEMP1_FROM_REG);
@@ -216,9 +214,7 @@
 #define show_temp_hyst(value, basereg) \
 static ssize_t show_##value(struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm90_data *data = i2c_get_clientdata(client); \
-	lm90_update_client(client); \
+	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
 		       - HYST_FROM_REG(data->temp_hyst)); \
 }
@@ -239,9 +235,7 @@
 
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
-	lm90_update_client(client);
+	struct lm90_data *data = lm90_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
@@ -430,8 +424,9 @@
 	return 0;
 }
 
-static void lm90_update_client(struct i2c_client *client)
+static struct lm90_data *lm90_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -505,6 +500,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_lm90_init(void)
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Mar 15 14:34:33 2004
@@ -409,30 +409,24 @@
 	outb_p(value, client->addr + reg);
 }
 
-static void via686a_update_client(struct i2c_client *client);
+static struct via686a_data *via686a_update_device(struct device *dev);
 static void via686a_init_client(struct i2c_client *client);
 
 /* following are the sysfs callback functions */
 
 /* 7 voltage sensors */
 static ssize_t show_in(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
 }
 
@@ -496,21 +490,15 @@
 
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
 }
 static ssize_t show_temp_over(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
 }
 static ssize_t show_temp_hyst(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
 }
 static ssize_t set_temp_over(struct device *dev, const char *buf, 
@@ -568,23 +556,17 @@
 
 /* 2 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
 				DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n",
 		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
@@ -642,9 +624,7 @@
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
-	via686a_update_client(client);
+	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
 static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
@@ -854,8 +834,9 @@
 			    !(VIA686A_TEMP_MODE_MASK | VIA686A_TEMP_MODE_CONTINUOUS));
 }
 
-static void via686a_update_client(struct i2c_client *client)
+static struct via686a_data *via686a_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -916,6 +897,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static struct pci_device_id via686a_pci_ids[] = {
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:34:33 2004
@@ -322,7 +322,7 @@
 static int w83627hf_read_value(struct i2c_client *client, u16 register);
 static int w83627hf_write_value(struct i2c_client *client, u16 register,
 			       u16 value);
-static void w83627hf_update_client(struct i2c_client *client);
+static struct w83627hf_data *w83627hf_update_device(struct device *dev);
 static void w83627hf_init_client(struct i2c_client *client);
 
 static struct i2c_driver w83627hf_driver = {
@@ -338,11 +338,7 @@
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
-	 \
-	w83627hf_update_client(client); \
-	 \
+	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
 }
 show_in_reg(in)
@@ -414,11 +410,7 @@
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
-	 \
-	w83627hf_update_client(client); \
-	 \
+	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
 		FAN_FROM_REG(data->reg[nr-1], \
 			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
@@ -478,11 +470,7 @@
 #define show_temp_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
-	 \
-	w83627hf_update_client(client); \
-	 \
+	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		return sprintf(buf,"%ld\n", \
 			(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
@@ -560,11 +548,7 @@
 static ssize_t
 show_vid_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
@@ -574,11 +558,7 @@
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
@@ -600,11 +580,7 @@
 static ssize_t
 show_alarms_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
@@ -614,11 +590,7 @@
 #define show_beep_reg(REG, reg) \
 static ssize_t show_beep_##reg (struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
-	 \
-	w83627hf_update_client(client); \
-	 \
+	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
 		      (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
 }
@@ -682,11 +654,7 @@
 static ssize_t
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n",
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
@@ -749,11 +717,7 @@
 static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->pwm[nr - 1]);
 }
 
@@ -809,11 +773,7 @@
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-
-	w83627hf_update_client(client);
-
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
 }
 
@@ -1273,8 +1233,9 @@
 			    | 0x01);
 }
 
-static void w83627hf_update_client(struct i2c_client *client)
+static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -1362,6 +1323,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_w83627hf_init(void)
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:33 2004
@@ -276,7 +276,7 @@
 static int w83781d_read_value(struct i2c_client *client, u16 register);
 static int w83781d_write_value(struct i2c_client *client, u16 register,
 			       u16 value);
-static void w83781d_update_client(struct i2c_client *client);
+static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_client(struct i2c_client *client);
 
 static inline u16 swap_bytes(u16 val)
@@ -297,11 +297,7 @@
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
-	 \
-	w83781d_update_client(client); \
-	 \
+	struct w83781d_data *data = w83781d_update_device(dev); \
 	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
 }
 show_in_reg(in);
@@ -368,11 +364,7 @@
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
-	 \
-	w83781d_update_client(client); \
-	 \
+	struct w83781d_data *data = w83781d_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
 		FAN_FROM_REG(data->reg[nr-1], (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
 }
@@ -429,11 +421,7 @@
 #define show_temp_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
-	 \
-	w83781d_update_client(client); \
-	 \
+	struct w83781d_data *data = w83781d_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) { \
 			return sprintf(buf,"%ld\n", \
@@ -516,11 +504,7 @@
 static ssize_t
 show_vid_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
@@ -531,11 +515,7 @@
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
@@ -559,11 +539,7 @@
 static ssize_t
 show_alarms_reg(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
 }
 
@@ -574,11 +550,7 @@
 #define show_beep_reg(REG, reg) \
 static ssize_t show_beep_##reg (struct device *dev, char *buf) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
-	 \
-	w83781d_update_client(client); \
-	 \
+	struct w83781d_data *data = w83781d_update_device(dev); \
 	return sprintf(buf,"%ld\n", (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
 }
 show_beep_reg(ENABLE, enable);
@@ -642,11 +614,7 @@
 static ssize_t
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
@@ -743,11 +711,7 @@
 static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
 }
 
@@ -755,11 +719,7 @@
 static ssize_t
 show_pwmenable_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
 }
 
@@ -861,11 +821,7 @@
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-
-	w83781d_update_client(client);
-
+	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
 }
 
@@ -937,12 +893,9 @@
 static ssize_t
 show_rt_reg(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = w83781d_update_device(dev);
 	int i, j = 0;
 
-	w83781d_update_client(client);
-
 	for (i = 0; i < 32; i++) {
 		if (i > 0)
 			j += sprintf(buf, " %ld", (long) data->rt[nr - 1][i]);
@@ -1667,9 +1620,9 @@
 			    | 0x01);
 }
 
-static void
-w83781d_update_client(struct i2c_client *client)
+static struct w83781d_data *w83781d_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -1782,6 +1735,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:33 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:33 2004
@@ -89,7 +89,7 @@
 	int kind);
 static int w83l785ts_detach_client(struct i2c_client *client);
 static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval);
-static void w83l785ts_update_client(struct i2c_client *client);
+static struct w83l785ts_data *w83l785ts_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
@@ -130,17 +130,13 @@
 
 static ssize_t show_temp(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l785ts_data *data = i2c_get_clientdata(client);
-	w83l785ts_update_client(client);
+	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
 static ssize_t show_temp_over(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83l785ts_data *data = i2c_get_clientdata(client);
-	w83l785ts_update_client(client);
+	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
@@ -304,8 +300,9 @@
 	return defval;
 }
 
-static void w83l785ts_update_client(struct i2c_client *client)
+static struct w83l785ts_data *w83l785ts_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l785ts_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
@@ -324,6 +321,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sensors_w83l785ts_init(void)

