Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVBCRz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVBCRz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbVBCRze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:55:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:61351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262940AbVBCRlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:05 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Use standard temperature converters for as99127f
In-Reply-To: <1107452338762@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:58 -0800
Message-Id: <11074523383338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2043, 2005/02/03 00:29:27-08:00, khali@linux-fr.org

[PATCH] I2C: Use standard temperature converters for as99127f

When support for the Asus AS99127F chip was once added to the w83781d
driver, it was decided that we would treat temp2 and temp3 as having a
LSB of 0.25 degree C, as opposed to 0.5 degree C for the compatible
Winbond chips. The reason why this was done seems to be a couple of
users reporting that these temperatures were reading twice as high as it
should for them in the first place. We had much more feedback about the
A99127F chip since, and it turns out that the exact conversion required
for temp2 and temp3 depends on the motherboard model. For some models
(including my A7V133-C), we now have to multiply the readings by 2,
effectively negating the change that was once done in the driver. For
other models, a linear conversion formula is needed. The bottom line is
that the raw readings from the driver are correct for no known board,
while it would be for at least some of them if we had kept the same LSB
as the Winbond chips are known to have. Thus I believe that the standard
LSB of 0.5 degree C should be restored.

There is no datasheet available for the AS99127F chip, so whatever was
done was guess work (and still is). I see no reason why we would keep
additional code in the w83781d driver to handle this former supposed
difference, especially when the facts now tend to prove that this
difference doesn't exist.

The following patch drops the additional code and treats temp2 and temp3
the same way for all chips supported by the w83781d driver. A similar
change will be made to the 2.4 version of this driver, and the default
sensors.conf will be updated accordingly. Users will have to update
their configuration file, or their readings will of course read twice as
high as they should due to the old conversion formulae.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83781d.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-02-03 09:35:09 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-02-03 09:35:09 -08:00
@@ -175,11 +175,6 @@
 						: (val)) / 1000, 0, 0xff))
 #define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
 
-#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((val) < 0 ? (val)+0x10000*250 \
-						: (val)) / 250) << 7, 0, 0xffff))
-#define AS99127_TEMP_ADD_FROM_REG(val)	((((val) & 0x8000 ? (val)-0x10000 : (val)) \
-						>> 7) * 250)
-
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
@@ -417,13 +412,8 @@
 { \
 	struct w83781d_data *data = w83781d_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		if (data->type == as99127f) { \
-			return sprintf(buf,"%ld\n", \
-				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
-		} else { \
-			return sprintf(buf,"%d\n", \
-				LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
-		} \
+		return sprintf(buf,"%d\n", \
+			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 	} else {	/* TEMP1 */ \
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
 	} \
@@ -442,11 +432,7 @@
 	val = simple_strtol(buf, NULL, 10); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		if (data->type == as99127f) \
-			data->temp_##reg##_add[nr-2] = AS99127_TEMP_ADD_TO_REG(val); \
-		else \
-			data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
-		 \
+		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \
 	} else {	/* TEMP1 */ \

