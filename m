Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbTFRSOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTFRSOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:14:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46054 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265405AbTFRSLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:47 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607073182@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607053930@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:07 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.2, 2003/06/16 11:31:43-07:00, margitsw@t-online.de

[PATCH] I2C: lm85 fixups

OK Here's the patch which :
1) Fixes the race conditions
2) Correctly reports the temps :-)
3) Removes a bit of gunk in the defines which I forgot


 drivers/i2c/chips/lm85.c |   41 ++++++++++++++++++++++++++++-------------
 1 files changed, 28 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Wed Jun 18 11:19:44 2003
+++ b/drivers/i2c/chips/lm85.c	Wed Jun 18 11:19:44 2003
@@ -148,20 +148,17 @@
 #define SCALE(val,from,to)		(((val)*(to) + ((from)/2))/(from))
 #define INS_TO_REG(n,val)		(SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255))
 #define INSEXT_FROM_REG(n,val,ext)	(SCALE((val)*4 + (ext),192*4,lm85_scaling[n]))
-/*
 #define INS_FROM_REG(n,val)		(INSEXT_FROM_REG(n,val,0))
-*/
-#define INS_FROM_REG(n,val)		( ( (val*4*lm85_scaling[n]) + (192*4/2) ) / (192*4) )
 
 /* FAN speed is measured using 90kHz clock */
 #define FAN_TO_REG(val)		(SENSORS_LIMIT( (val)<=0?0: 5400000/(val),0,65534))
 #define FAN_FROM_REG(val)	((val)==0?-1:(val)==0xffff?0:5400000/(val))
 
-/* Temperature is reported in .01 degC increments */
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)+50)/100,-127,127))
-#define TEMPEXT_FROM_REG(val,ext)	((val)*100 + (ext)*25)
+/* Temperature is reported in .001 degC increments */
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)+500)/1000,-127,127))
+#define TEMPEXT_FROM_REG(val,ext)	((val)*1000 + (ext)*250)
 #define TEMP_FROM_REG(val)		(TEMPEXT_FROM_REG(val,0))
-#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/25,-127,127))
+#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/250,-127,127))
 
 #define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
 #define PWM_FROM_REG(val)		(val)
@@ -437,10 +434,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val);
 	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -528,10 +528,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->pwm[nr] = PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_PWM(nr), data->pwm[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
@@ -590,10 +593,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->in_min[nr] = INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
@@ -609,10 +615,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->in_max[nr] = INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_in_reg(offset)						\
@@ -673,10 +682,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), data->temp_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
@@ -692,10 +704,13 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
+	int	val;
 
-	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_reg(offset)						\

