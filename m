Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUENXnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUENXnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUENXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:40:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:31973 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264572AbUENXaH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:07 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773561233@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:16 -0700
Message-Id: <10845773562431@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.3, 2004/05/01 22:33:50-07:00, khali@linux-fr.org

[PATCH] I2C: Voltage conversions in via686a

My previous patch was actually not correct, reading from the chip's
registers was fixed but writing limits to it wasn't. This new version of
the patch should be better. Sorry for the trouble.


 drivers/i2c/chips/via686a.c |   56 ++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 32 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri May 14 16:21:17 2004
+++ b/drivers/i2c/chips/via686a.c	Fri May 14 16:21:17 2004
@@ -108,7 +108,7 @@
 #define VIA686A_TEMP_MODE_MASK 0x3F
 #define VIA686A_TEMP_MODE_CONTINUOUS (0x00)
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
+/* Conversions. Limit checking is only done on the TO_REG
    variants. 
 
 ********* VOLTAGE CONVERSIONS (Bob Dougherty) ********
@@ -123,49 +123,41 @@
  volts = (25*regVal+133)*factor
  regVal = (volts/factor-133)/25
  (These conversions were contributed by Jonathan Teh Soon Yew 
- <j.teh@iname.com>)
- 
- These get us close, but they don't completely agree with what my BIOS 
- says- they are all a bit low.  But, it all we have to go on... */
+ <j.teh@iname.com>) */
 static inline u8 IN_TO_REG(long val, int inNum)
 {
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of 
-	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
-	 /250 (which should really be /2500).
-	 At the end, we need to /100 because we *100 everything and we need
-	 to /10 because of the rounding thing, so we /1000.   */
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   Rounding is done (120500 is actually 133000 - 12500).
+	   Remember that val is expressed in 0.001V/bit, which is why we divide
+	   by an additional 10000 (100000 for +12V): 1000 for val and 10 (100)
+	   for the constants. */
 	if (inNum <= 1)
 		return (u8)
-		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 21024 - 1205000) / 250000, 0, 255);
 	else if (inNum == 2)
 		return (u8)
-		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 15737 - 1205000) / 250000, 0, 255);
 	else if (inNum == 3)
 		return (u8)
-		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 10108 - 1205000) / 250000, 0, 255);
 	else
-		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
-					  / 1000, 0, 255);
+		return (u8)
+		    SENSORS_LIMIT((val * 41714 - 12050000) / 2500000, 0, 255);
 }
 
 static inline long IN_FROM_REG(u8 val, int inNum)
 {
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of
-	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	 We need to scale with *100 anyway, so no need to /100 at the end. */
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   We also multiply them by 1000 because we want 0.001V/bit for the
+	   output value. Rounding is done. */
 	if (inNum <= 1)
-		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 21024 / 2) / 21024);
 	else if (inNum == 2)
-		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 15737 / 2) / 15737);
 	else if (inNum == 3)
-		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 10108 / 2) / 10108);
 	else
-		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
+		return (long) ((2500000 * val + 13300000 + 41714 / 2) / 41714);
 }
 
 /********* FAN RPM CONVERSIONS ********/
@@ -375,24 +367,24 @@
 /* 7 voltage sensors */
 static ssize_t show_in(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr));
 }
 
 static ssize_t set_in_min(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_min[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
 			data->in_min[nr]);
@@ -402,7 +394,7 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_max[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
 			data->in_max[nr]);

