Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUENXsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUENXsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUENXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:47:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:24037 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264571AbUENX35 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:57 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <1084577357958@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <10845773573553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.9, 2004/05/05 15:34:20-07:00, khali@linux-fr.org

[PATCH] I2C: Rewrite temperature conversions in via686a driver

The following patch rewrites the temperature conversion macros and
functions found in the via686a chip driver. Contrary to the voltage
conversions a few weeks ago, temperature conversions were numerically
correct, but artificially complex. The new ones are cleaner. It also
fixes a highly improbable array overflow (would take one of the measured
temperatures to be over 145 degrees C).

Successfully tested by Mark D. Studebaker and I, and already applied to
our CVS repository.


 drivers/i2c/chips/via686a.c |   63 ++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 42 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri May 14 16:20:12 2004
+++ b/drivers/i2c/chips/via686a.c	Fri May 14 16:20:12 2004
@@ -268,52 +268,31 @@
 	    239, 240
 };
 
-/* Converting temps to (8-bit) hyst and over registers 
- No interpolation here.  Just check the limits and go.
- The +5 effectively rounds off properly and the +50 is because 
- the temps start at -50 */
+/* Converting temps to (8-bit) hyst and over registers
+   No interpolation here.
+   The +50 is because the temps start at -50 */
 static inline u8 TEMP_TO_REG(long val)
 {
-	return (u8)
-	    SENSORS_LIMIT(viaLUT[((val <= -500) ? 0 : (val >= 1100) ? 160 : 
-				  ((val + 5) / 10 + 50))], 0, 255);
+	return viaLUT[val <= -50000 ? 0 : val >= 110000 ? 160 : 
+		      (val < 0 ? val - 500 : val + 500) / 1000 + 50];
 }
 
-/* for 8-bit temperature hyst and over registers 
- The temp values are already *10, so we don't need to do that.
- But we _will_ round these off to the nearest degree with (...*10+5)/10 */
-#define TEMP_FROM_REG(val) ((tempLUT[(val)]*10+5)/10)
-
-/* for 10-bit temperature readings 
- You might _think_ this is too long to inline, but's it's really only
- called once... */
+/* for 8-bit temperature hyst and over registers */
+#define TEMP_FROM_REG(val) (tempLUT[(val)] * 100)
+
+/* for 10-bit temperature readings */
 static inline long TEMP_FROM_REG10(u16 val)
 {
-	/* the temp values are already *10, so we don't need to do that. */
-	long temp;
 	u16 eightBits = val >> 2;
 	u16 twoBits = val & 3;
 
-	/* handle the extremes first (they won't interpolate well! ;-) */
-	if (val == 0)
-		return (long) tempLUT[0];
-	if (val == 1023)
-		return (long) tempLUT[255];
-
-	if (twoBits == 0)
-		return (long) tempLUT[eightBits];
-	else {
-		/* do some interpolation by multipying the lower and upper
-		 bounds by 25, 50 or 75, then /100. */
-		temp = ((25 * (4 - twoBits)) * tempLUT[eightBits]
-			+ (25 * twoBits) * tempLUT[eightBits + 1]);
-		/* increase the magnitude by 50 to achieve rounding. */
-		if (temp > 0)
-			temp += 50;
-		else
-			temp -= 50;
-		return (temp / 100);
-	}
+	/* no interpolation for these */
+	if (twoBits == 0 || eightBits == 255)
+		return TEMP_FROM_REG(eightBits);
+
+	/* do some linear interpolation */
+	return (tempLUT[eightBits] * (4 - twoBits) +
+	        tempLUT[eightBits + 1] * twoBits) * 25;
 }
 
 #define ALARMS_FROM_REG(val) (val)
@@ -441,21 +420,21 @@
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr]));
 }
 static ssize_t show_temp_over(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr]));
 }
 static ssize_t show_temp_hyst(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr]));
 }
 static ssize_t set_temp_over(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
 	return count;
@@ -464,7 +443,7 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
 	return count;

