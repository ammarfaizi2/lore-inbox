Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbUJYUkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUJYUkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUJYUju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:39:50 -0400
Received: from gateway.penguincomputing.com ([64.243.132.186]:36759 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261976AbUJYUey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:34:54 -0400
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
Cc: linux-kernel@vger.kernel.org, phil@netroedge.com,
       sensors@stimpy.netroedge.com, ppokorny@penguincomputing.com,
       jthiessen@penguincomputing.com
User-Agent: Mutt/1.4.1i
Subject: Re: [PATCH] 2.6 lm85.c driver update
In-Reply-To: <20041019222920.GJ9521@kroah.com>
Content-Disposition: inline
Date: Mon, 25 Oct 2004 13:36:10 -0700
Message-Id: <20041025203610.GA19053@penguincomputing.com>
References: <20041004200943.GE22290@penguincomputing.com>
 <20041019222920.GJ9521@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 03:29:20PM -0700, Greg KH wrote:
> On Mon, Oct 04, 2004 at 01:09:43PM -0700, Justin Thiessen wrote:
> > Hi,
> > 
> > Here is a patch to restore fan control to the lm85 driver in the 2.6.X kernel.
> 
> Hm, there are a number of rejects in this patch.  Care to resync up with
> the next kernel release and resend this?

Ok, try this:


signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>

patch for kernel 2.6.X lm85 driver follows:
----------------------------------------------------


--- linux-2.6.9/drivers/i2c/chips/lm85.c.orig	2004-10-18 14:53:46.000000000 -0700
+++ linux-2.6.9/drivers/i2c/chips/lm85.c	2004-10-24 18:16:04.188509824 -0700
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
@@ -163,8 +159,6 @@ static int lm85_scaling[] = {  /* .001 V
 
 #define EXT_FROM_REG(val,sensor)	(((val)>>(sensor * 2))&0x03)
 
-#ifdef	LM85EXTENDEDFUNC	/* Extended functionality */
-
 /* ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
  *    Hysteresis (below limit),   1. degC (0-15)
@@ -183,20 +177,32 @@ static int lm85_scaling[] = {  /* .001 V
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
@@ -240,7 +246,7 @@ static int SPINUP_TO_REG( int spinup )
 
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
-		100, 150, 230, 300, 380, 470, 620, 980
+		100, 150, 230, 300, 380, 470, 620, 940
 	};
 static int FREQ_TO_REG( int freq )
 {
@@ -266,13 +272,9 @@ static int FREQ_TO_REG( int freq )
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
@@ -285,10 +287,8 @@ static int ZONE_TO_REG( int zone )
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
@@ -338,6 +338,14 @@ struct lm85_zone {
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
@@ -437,18 +445,19 @@ static ssize_t set_fan_min(struct device
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);			        \
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,     \
+		NULL);                                                  \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min);
 
@@ -527,20 +536,21 @@ static ssize_t show_pwm_enable(struct de
 #define show_pwm_reg(offset)						\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm(dev, buf, 0x##offset - 1);			\
+	return show_pwm(dev, buf, offset - 1);			        \
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
 				 const char *buf, size_t count)		\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);     		\
 }									\
 static ssize_t show_pwm_enable##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
+	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 		\
 		show_pwm_##offset, set_pwm_##offset);			\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL);
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO,                   \
+		show_pwm_enable##offset, NULL);
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -594,25 +604,25 @@ static ssize_t set_in_max(struct device 
 #define show_in_reg(offset)						\
 static ssize_t show_in_##offset (struct device *dev, char *buf)		\
 {									\
-	return show_in(dev, buf, 0x##offset);				\
+	return show_in(dev, buf, offset);				\
 }									\
 static ssize_t show_in_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_in_min(dev, buf, 0x##offset);			\
+	return show_in_min(dev, buf, offset);			\
 }									\
 static ssize_t show_in_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_in_max(dev, buf, 0x##offset);			\
+	return show_in_max(dev, buf, offset);			\
 }									\
 static ssize_t set_in_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_min(dev, buf, count, 0x##offset);			\
+	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t set_in_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_max(dev, buf, count, 0x##offset);			\
+	return set_in_max(dev, buf, count, offset);			\
 }									\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL);	\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
@@ -674,27 +684,28 @@ static ssize_t set_temp_max(struct devic
 #define show_temp_reg(offset)						\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);  			\
 }									\
 static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);	\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,   \
+		NULL);	                                                \
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_min, set_temp_##offset##_min);	\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -705,6 +716,330 @@ show_temp_reg(2);
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
+	return show_pwm_auto_channels(dev, buf, offset - 1);	\
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
+	return show_pwm_auto_pwm_minctl(dev, buf, offset - 1);	\
+}									\
+static ssize_t set_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_pwm_minctl(dev, buf, count, offset - 1);\
+}									\
+static ssize_t show_pwm##offset##_auto_pwm_freq (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_pwm_auto_pwm_freq(dev, buf, offset - 1);	\
+}									\
+static ssize_t set_pwm##offset##_auto_pwm_freq(struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_pwm_auto_pwm_freq(dev, buf, count, offset - 1);	\
+}									\
+static DEVICE_ATTR(pwm##offset##_auto_channels, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_channels,			\
+		set_pwm##offset##_auto_channels);                       \
+static DEVICE_ATTR(pwm##offset##_auto_pwm_min, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_pwm_min,			\
+		set_pwm##offset##_auto_pwm_min);			\
+static DEVICE_ATTR(pwm##offset##_auto_pwm_minctl, S_IRUGO | S_IWUSR,	\
+		show_pwm##offset##_auto_pwm_minctl,			\
+		set_pwm##offset##_auto_pwm_minctl);                     \
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
+	return show_temp_auto_temp_off(dev, buf, offset - 1);	\
+}									\
+static ssize_t set_temp##offset##_auto_temp_off (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_off(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_min (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_min(dev, buf, offset - 1);	\
+}									\
+static ssize_t set_temp##offset##_auto_temp_min (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_min(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_max (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_max(dev, buf, offset - 1);	\
+}									\
+static ssize_t set_temp##offset##_auto_temp_max (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_max(dev, buf, count, offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_temp_crit (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_temp_crit(dev, buf, offset - 1);          \
+}									\
+static ssize_t set_temp##offset##_auto_temp_crit (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_temp_crit(dev, buf, count, offset - 1);    \
+}									\
+static DEVICE_ATTR(temp##offset##_auto_temp_off, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_off,			\
+		set_temp##offset##_auto_temp_off);                      \
+static DEVICE_ATTR(temp##offset##_auto_temp_min, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_min,			\
+		set_temp##offset##_auto_temp_min);                      \
+static DEVICE_ATTR(temp##offset##_auto_temp_max, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_max,			\
+		set_temp##offset##_auto_temp_max);                      \
+static DEVICE_ATTR(temp##offset##_auto_temp_crit, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_temp_crit,			\
+		set_temp##offset##_auto_temp_crit);
+temp_auto(1);
+temp_auto(2);
+temp_auto(3);
+
 int lm85_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, lm85_detect);
@@ -876,6 +1211,30 @@ int lm85_detect(struct i2c_adapter *adap
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
 
@@ -1159,7 +1518,7 @@ static void  __exit sm_lm85_exit(void)
  *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");
+MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>, Justin Thiessen <jthiessen@penguincomputing.com");
 MODULE_DESCRIPTION("LM85-B, LM85-C driver");
 
 module_init(sm_lm85_init);

