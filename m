Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUKIFga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUKIFga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUKIFdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:33:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:53918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261375AbUKIFYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:54 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778551027@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:15 -0800
Message-Id: <10999778552595@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.7, 2004/11/05 13:41:46-08:00, jthiessen@penguincomputing.com

[PATCH] I2C: lm85.c driver update

Signed off by: Justin Thiessen <jthiessen@penguincomputing.com
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm85.c |  417 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 388 insertions(+), 29 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-11-08 18:55:54 -08:00
+++ b/drivers/i2c/chips/lm85.c	2004-11-08 18:55:54 -08:00
@@ -4,6 +4,7 @@
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
     Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
     Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
+    Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
 
     Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
 
@@ -29,11 +30,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
-/*
-#include <asm/io.h>
-*/
-
-#undef	LM85EXTENDEDFUNC	/* Extended functionality */
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -163,8 +159,6 @@
 
 #define EXT_FROM_REG(val,sensor)	(((val)>>(sensor * 2))&0x03)
 
-#ifdef	LM85EXTENDEDFUNC	/* Extended functionality */
-
 /* ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
  *    Hysteresis (below limit),   1. degC (0-15)
@@ -183,20 +177,32 @@
  *    Filter constant (or disabled)   .1 seconds
  */
 
-/* These are the zone temperature range encodings */
-static int lm85_range_map[] = {   /* .1 degC */
-		 20,  25,  33,  40,  50,  66,
-		 80, 100, 133, 160, 200, 266,
-		320, 400, 533, 800
+/* These are the zone temperature range encodings in .001 degree C */
+static int lm85_range_map[] = {   
+		2000,  2500,  3300,  4000,  5000,  6600,
+		8000, 10000, 13300, 16000, 20000, 26600,
+		32000, 40000, 53300, 80000
 	};
 static int RANGE_TO_REG( int range )
 {
 	int i;
 
-	if( range >= lm85_range_map[15] ) { return 15 ; }
-	for( i = 0 ; i < 15 ; ++i )
-		if( range <= lm85_range_map[i] )
-			break ;
+	if ( range < lm85_range_map[0] ) { 
+		return 0 ;
+	} else if ( range > lm85_range_map[15] ) {
+		return 15 ;
+	} else {  /* find closest match */
+		for ( i = 14 ; i >= 0 ; --i ) {
+			if ( range > lm85_range_map[i] ) { /* range bracketed */
+				if ((lm85_range_map[i+1] - range) < 
+					(range - lm85_range_map[i])) {
+					i++;
+					break;
+				}
+				break;
+			}
+		}
+	}
 	return( i & 0x0f );
 }
 #define RANGE_FROM_REG(val) (lm85_range_map[(val)&0x0f])
@@ -240,7 +246,7 @@
 
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
-		100, 150, 230, 300, 380, 470, 620, 980
+		100, 150, 230, 300, 380, 470, 620, 940
 	};
 static int FREQ_TO_REG( int freq )
 {
@@ -266,13 +272,9 @@
  *     -2 -- PWM responds to manual control
  */
 
-#endif		/* Extended functionality */
-
 static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
 #define ZONE_FROM_REG(val) (lm85_zone_map[((val)>>5)&0x07])
 
-#ifdef	LM85EXTENDEDFUNC	/* Extended functionality */
-
 static int ZONE_TO_REG( int zone )
 {
 	int i;
@@ -285,10 +287,8 @@
 	return( (i & 0x07)<<5 );
 }
 
-#endif		/* Extended functionality */
-
-#define HYST_TO_REG(val) (SENSORS_LIMIT((-(val)+5)/10,0,15))
-#define HYST_FROM_REG(val) (-(val)*10)
+#define HYST_TO_REG(val) (SENSORS_LIMIT(((val)+500)/1000,0,15))
+#define HYST_FROM_REG(val) ((val)*1000)
 
 #define OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/25,-127,127))
 #define OFFSET_FROM_REG(val) ((val)*25)
@@ -338,6 +338,14 @@
 	u8 hyst;	/* Low limit hysteresis. (0-15) */
 	u8 range;	/* Temp range, encoded */
 	s8 critical;	/* "All fans ON" temp limit */
+	u8 off_desired; /* Actual "off" temperature specified.  Preserved 
+			 * to prevent "drift" as other autofan control
+			 * values change.
+			 */
+	u8 max_desired; /* Actual "max" temperature specified.  Preserved 
+			 * to prevent "drift" as other autofan control
+			 * values change.
+			 */
 };
 
 struct lm85_autofan {
@@ -448,7 +456,8 @@
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
+		NULL);							\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min);
 
@@ -615,7 +624,8 @@
 {									\
 	return set_in_max(dev, buf, count, offset);			\
 }									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL);	\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, 	\
+		NULL);							\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_in_##offset##_min, set_in_##offset##_min);		\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -695,7 +705,8 @@
 {									\
 	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);	\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,	\
+		NULL);							\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_min, set_temp_##offset##_min);	\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -706,6 +717,330 @@
 show_temp_reg(3);
 
 
+/* Automatic PWM control */
+
+static ssize_t show_pwm_auto_channels(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ZONE_FROM_REG(data->autofan[nr].config));
+}
+static ssize_t set_pwm_auto_channels(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->autofan[nr].config = (data->autofan[nr].config & (~0xe0))
+		| ZONE_TO_REG(val) ;
+	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
+		data->autofan[nr].config);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_pwm_auto_pwm_min(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
+}
+static ssize_t set_pwm_auto_pwm_min(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->autofan[nr].min_pwm = PWM_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_MINPWM(nr),
+		data->autofan[nr].min_pwm);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_pwm_auto_pwm_minctl(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", data->autofan[nr].min_off);
+}
+static ssize_t set_pwm_auto_pwm_minctl(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->autofan[nr].min_off = val;
+	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
+		| data->syncpwm3
+		| (data->autofan[0].min_off ? 0x20 : 0)
+		| (data->autofan[1].min_off ? 0x40 : 0)
+		| (data->autofan[2].min_off ? 0x80 : 0)
+	);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_pwm_auto_pwm_freq(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", FREQ_FROM_REG(data->autofan[nr].freq));
+}
+static ssize_t set_pwm_auto_pwm_freq(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->autofan[nr].freq = FREQ_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		(data->zone[nr].range << 4)
+		| data->autofan[nr].freq
+	); 
+	up(&data->update_lock);
+	return count;
+}
+#define pwm_auto(offset)						\
+static ssize_t show_pwm##offset##_auto_channels (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_pwm_auto_channels(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_pwm##offset##_auto_channels (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_channels(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_pwm##offset##_auto_pwm_min (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_pwm_auto_pwm_min(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_pwm##offset##_auto_pwm_min (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_pwm_min(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_pwm_auto_pwm_minctl(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_pwm_minctl(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_pwm##offset##_auto_pwm_freq (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_pwm_auto_pwm_freq(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_pwm##offset##_auto_pwm_freq(struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_pwm_freq(dev, buf, count, offset - 1);	\
+}									\
+static DEVICE_ATTR(pwm##offset##_auto_channels, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_channels,			\
+		set_pwm##offset##_auto_channels);			\
+static DEVICE_ATTR(pwm##offset##_auto_pwm_min, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_pwm_min,			\
+		set_pwm##offset##_auto_pwm_min);			\
+static DEVICE_ATTR(pwm##offset##_auto_pwm_minctl, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_pwm_minctl,			\
+		set_pwm##offset##_auto_pwm_minctl);			\
+static DEVICE_ATTR(pwm##offset##_auto_pwm_freq, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_pwm_freq,			\
+		set_pwm##offset##_auto_pwm_freq);              
+pwm_auto(1);
+pwm_auto(2);
+pwm_auto(3);
+
+/* Temperature settings for automatic PWM control */
+
+static ssize_t show_temp_auto_temp_off(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
+		HYST_FROM_REG(data->zone[nr].hyst));
+}
+static ssize_t set_temp_auto_temp_off(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    min, val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	min = TEMP_FROM_REG(data->zone[nr].limit);
+	data->zone[nr].off_desired = TEMP_TO_REG(val);
+	data->zone[nr].hyst = HYST_TO_REG(min - val);
+	if ( nr == 0 || nr == 1 ) {
+		lm85_write_value(client, LM85_REG_AFAN_HYST1,
+			(data->zone[0].hyst << 4)
+			| data->zone[1].hyst
+			);
+	} else {
+		lm85_write_value(client, LM85_REG_AFAN_HYST2,
+			(data->zone[2].hyst << 4)
+		);
+	}
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_temp_auto_temp_min(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) );
+}
+static ssize_t set_temp_auto_temp_min(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->zone[nr].limit = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
+		data->zone[nr].limit);
+
+/* Update temp_auto_max and temp_auto_range */
+	data->zone[nr].range = RANGE_TO_REG(
+		TEMP_FROM_REG(data->zone[nr].max_desired) -
+		TEMP_FROM_REG(data->zone[nr].limit));
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		((data->zone[nr].range & 0x0f) << 4)
+		| (data->autofan[nr].freq & 0x07));
+
+/* Update temp_auto_hyst and temp_auto_off */
+	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
+		data->zone[nr].limit) - TEMP_FROM_REG(
+		data->zone[nr].off_desired));
+	if ( nr == 0 || nr == 1 ) {
+		lm85_write_value(client, LM85_REG_AFAN_HYST1,
+			(data->zone[0].hyst << 4)
+			| data->zone[1].hyst
+			);
+	} else {
+		lm85_write_value(client, LM85_REG_AFAN_HYST2,
+			(data->zone[2].hyst << 4)
+		);
+	}
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_temp_auto_temp_max(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
+		RANGE_FROM_REG(data->zone[nr].range));
+}
+static ssize_t set_temp_auto_temp_max(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    min, val;
+
+	down(&data->update_lock);
+	min = TEMP_FROM_REG(data->zone[nr].limit);
+	val = simple_strtol(buf, NULL, 10);
+	data->zone[nr].max_desired = TEMP_TO_REG(val);
+	data->zone[nr].range = RANGE_TO_REG(
+		val - min);
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		((data->zone[nr].range & 0x0f) << 4)
+		| (data->autofan[nr].freq & 0x07));
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_temp_auto_temp_crit(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].critical));
+}
+static ssize_t set_temp_auto_temp_crit(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->zone[nr].critical = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
+		data->zone[nr].critical);
+	up(&data->update_lock);
+	return count;
+}
+#define temp_auto(offset)						\
+static ssize_t show_temp##offset##_auto_temp_off (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_off(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_temp_off (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_off(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_min (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_min(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_temp_min (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_min(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_max (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_max(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_temp_max (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_max(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_crit (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_crit(dev, buf, offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_temp_crit (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_crit(dev, buf, count, offset - 1);	\
+}									\
+static DEVICE_ATTR(temp##offset##_auto_temp_off, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_off,			\
+		set_temp##offset##_auto_temp_off);			\
+static DEVICE_ATTR(temp##offset##_auto_temp_min, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_min,			\
+		set_temp##offset##_auto_temp_min);			\
+static DEVICE_ATTR(temp##offset##_auto_temp_max, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_max,			\
+		set_temp##offset##_auto_temp_max);			\
+static DEVICE_ATTR(temp##offset##_auto_temp_crit, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_crit,			\
+		set_temp##offset##_auto_temp_crit);
+temp_auto(1);
+temp_auto(2);
+temp_auto(3);
+
 int lm85_attach_adapter(struct i2c_adapter *adapter)
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
@@ -879,6 +1214,30 @@
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_channels);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_channels);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_channels);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_minctl);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_minctl);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_minctl);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_freq);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_freq);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_freq);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_crit);
 
 	return 0;
 
@@ -1162,7 +1521,7 @@
  *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");
+MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>, Justin Thiessen <jthiessen@penguincomputing.com");
 MODULE_DESCRIPTION("LM85-B, LM85-C driver");
 
 module_init(sm_lm85_init);

