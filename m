Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTEIXqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTEIXnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:43:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:59355 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263589AbTEIXmG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:42:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10525245943373@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.69
In-Reply-To: <10525245943578@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 9 May 2003 16:56:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.4, 2003/05/09 14:54:15-07:00, warp@mercury.d2dc.net

[PATCH] I2C: Yet another it87 patch.

Ok, after writing up something in the way of a perl script to make some
sense of the data for voltages, and finding that there is no sense to
make, I took a longer look at things.

The it87 driver in 2.5.x is doing some, down right /odd/ math on the
numbers for the in_input* readings, and the 2.4.x driver is doing
something quite different.

And while it might be possible to get sane numbers out of the 2.5.x
driver, people /expect/ to get the numbers that they were getting from
2.4.x.

So this patch puts things back to the simpler calculations done by the
2.4.x lm-sensors drivers, and my script confirms that the numbers come
out right.


 drivers/i2c/chips/it87.c |   84 ++++++++++++-----------------------------------
 1 files changed, 23 insertions(+), 61 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May  9 16:47:59 2003
+++ b/drivers/i2c/chips/it87.c	Fri May  9 16:47:59 2003
@@ -99,46 +99,8 @@
 
 #define IT87_REG_CHIPID        0x58
 
-static inline u8 IN_TO_REG(long val, int inNum)
-{
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of 
-	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
-	 /250 (which should really be /2500).
-	 At the end, we need to /100 because we *100 everything and we need
-	 to /10 because of the rounding thing, so we /1000.   */
-	if (inNum <= 1)
-		return (u8)
-		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
-	else if (inNum == 2)
-		return (u8)
-		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
-	else if (inNum == 3)
-		return (u8)
-		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
-	else
-		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
-					  / 1000, 0, 255);
-}
-
-static inline long IN_FROM_REG(u8 val, int inNum)
-{
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of
-	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	 We need to scale with *100 anyway, so no need to /100 at the end. */
-	if (inNum <= 1)
-		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
-	else if (inNum == 2)
-		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
-	else if (inNum == 3)
-		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
-	else
-		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
-}
+#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
+#define IN_FROM_REG(val) (((val) *  16) / 10)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -279,7 +241,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr])*10 );
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
@@ -287,7 +249,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr])*10 );
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
@@ -295,7 +257,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr])*10 );
 }
 
 static ssize_t set_in_min(struct device *dev, const char *buf, 
@@ -304,7 +266,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
-	data->in_min[nr] = IN_TO_REG(val,nr);
+	data->in_min[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr), 
 			data->in_min[nr]);
 	return count;
@@ -315,7 +277,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
-	data->in_max[nr] = IN_TO_REG(val,nr);
+	data->in_max[nr] = IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr), 
 			data->in_max[nr]);
 	return count;
@@ -855,37 +817,37 @@
 	   This sets fan-divs to 2, among others */
 	it87_write_value(client, IT87_REG_CONFIG, 0x80);
 	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0, 0));
+			 IN_TO_REG(IT87_INIT_IN_MIN_0));
 	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0, 0));
+			 IN_TO_REG(IT87_INIT_IN_MAX_0));
 	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1, 1));
+			 IN_TO_REG(IT87_INIT_IN_MIN_1));
 	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1, 1));
+			 IN_TO_REG(IT87_INIT_IN_MAX_1));
 	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2, 2));
+			 IN_TO_REG(IT87_INIT_IN_MIN_2));
 	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2, 2));
+			 IN_TO_REG(IT87_INIT_IN_MAX_2));
 	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3, 3));
+			 IN_TO_REG(IT87_INIT_IN_MIN_3));
 	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3, 3));
+			 IN_TO_REG(IT87_INIT_IN_MAX_3));
 	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4, 4));
+			 IN_TO_REG(IT87_INIT_IN_MIN_4));
 	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4, 4));
+			 IN_TO_REG(IT87_INIT_IN_MAX_4));
 	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5, 5));
+			 IN_TO_REG(IT87_INIT_IN_MIN_5));
 	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5, 5));
+			 IN_TO_REG(IT87_INIT_IN_MAX_5));
 	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6, 6));
+			 IN_TO_REG(IT87_INIT_IN_MIN_6));
 	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6, 6));
+			 IN_TO_REG(IT87_INIT_IN_MAX_6));
 	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7, 7));
+			 IN_TO_REG(IT87_INIT_IN_MIN_7));
 	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7, 7));
+			 IN_TO_REG(IT87_INIT_IN_MAX_7));
 	/* Note: Battery voltage does not have limit registers */
 	it87_write_value(client, IT87_REG_FAN_MIN(1),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));

