Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVAZH5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVAZH5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAZH5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:57:34 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:18052 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262377AbVAZH52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:57:28 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien) - Resubmit
Date: Wed, 26 Jan 2005 02:57:35 -0500
User-Agent: KMail/1.7.1
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
References: <200501260249.23583.shawn.starr@rogers.com>
In-Reply-To: <200501260249.23583.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v109BvEIrg3BrmV"
Message-Id: <200501260257.35605.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_v109BvEIrg3BrmV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

You know, after seeing that patch, that it just makes sense to add some of
those cleanups to the lm80 driver.

Shawn.

lm80-i2c-0-28
Adapter: SMBus PIIX4 adapter at fe00
+5V:       +4.90 V  (min =  +4.74 V, max =  +5.25 V)
VTT:       +1.72 V  (min =  +1.70 V, max =  +2.10 V)
+3.3V:     +3.35 V  (min =  +3.14 V, max =  +3.47 V)
+Vcore:    +1.98 V  (min =  +1.90 V, max =  +2.10 V)
+12V:     +11.30 V  (min = +11.18 V, max = +12.63 V)
-12V:     -11.88 V  (min = -12.60 V, max = -11.39 V)
-5V:       -4.92 V  (min =  -5.25 V, max =  -4.76 V)
fan1:     1679 RPM  (min = 1328 RPM, div = 4)
temp:     +32.38°C (hot: limit = +60°C, hyst = +65°C)
:                  (os:  limit = +54°C, hyst = +56°C)

Driver works with changes applied.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

* Note to self, dont use Kmail for raw diff files

--Boundary-00=_v109BvEIrg3BrmV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="lm80-cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lm80-cleanup.diff"

--- linux-2.6.11-rc2/drivers/i2c/chips/lm80.c	2005-01-26 02:04:38.000000000 -0500
+++ linux-2.6.11-rc2-fixes/drivers/i2c/chips/lm80.c	2005-01-26 02:41:00.000000000 -0500
@@ -72,7 +72,7 @@ SENSORS_INSMOD_1(lm80);
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 {
-	if (rpm == 0)
+	if (rpm <= 0)
 		return 255;
 	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
 	return SENSORS_LIMIT((1350000 + rpm*div / 2) / (rpm*div), 1, 254);
@@ -99,10 +99,7 @@ static inline long TEMP_FROM_REG(u16 tem
 #define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val)<0?\
 					((val)-500)/1000:((val)+500)/1000,0,255)
 
-#define ALARMS_FROM_REG(val)		(val)
-
 #define DIV_FROM_REG(val)		(1 << (val))
-#define DIV_TO_REG(val)			((val)==8?3:(val)==4?2:(val)==1?0:1)
 
 /*
  * Client data (each client gets its own)
@@ -269,7 +266,17 @@ static ssize_t set_fan_div(struct device
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	val = simple_strtoul(buf, NULL, 10);
-	data->fan_div[nr] = DIV_TO_REG(val);
+
+	switch (val) {
+	case 1: data->fan_div[nr] = 0; break;
+	case 2: data->fan_div[nr] = 1; break;
+	case 4: data->fan_div[nr] = 2; break;
+	case 8: data->fan_div[nr] = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not "
+			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		return -EINVAL;
+	}
 
 	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
@@ -327,7 +334,7 @@ set_temp(os_hyst, temp_os_hyst, LM80_REG
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);

--Boundary-00=_v109BvEIrg3BrmV--
