Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUATC2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUATALS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:11:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:18348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265101AbUATAAC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:02 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567623617@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:22 -0800
Message-Id: <10745567623125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.11, 2004/01/14 11:27:58-08:00, khali@linux-fr.org

[PATCH] I2C: Fix w83781d temp

This patch fixes the temperature handling in the w83781d driver:
1* Fix bad magnitude.
2* Use MMH's lm75.h.
3* Allow negative temperatures.


 drivers/i2c/chips/w83781d.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Jan 19 15:31:21 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Jan 19 15:31:21 2004
@@ -43,6 +43,7 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <asm/io.h>
+#include "lm75.h"
 
 /* RT Table support #defined so we can take it out if it gets bothersome */
 #define W83781D_RT			1
@@ -170,17 +171,14 @@
 					((val) == 255 ? 0 : \
 							1350000 / ((val) * (div))))
 
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val / 10) < 0 ? (((val / 10) - 5) / 10) : \
-									 ((val / 10) + 5) / 10), 0, 255))
-#define TEMP_FROM_REG(val)		((((val ) > 0x80 ? (val) - 0x100 : (val)) * 10) * 10)
-
-#define TEMP_ADD_TO_REG(val)		(SENSORS_LIMIT(((((val / 10) + 2) / 5) << 7),\
-                                              0, 0xffff))
-#define TEMP_ADD_FROM_REG(val)		((((val) >> 7) * 5) * 10)
-
-#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((((val / 10) + 2)*4)/10) \
-                                               << 7), 0, 0xffff))
-#define AS99127_TEMP_ADD_FROM_REG(val)	(((((val) >> 7) * 10) / 4) * 10)
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
+						: (val)) / 1000, 0, 0xff))
+#define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
+
+#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((val) < 0 ? (val)+0x10000*250 \
+						: (val)) / 250) << 7, 0, 0xffff))
+#define AS99127_TEMP_ADD_FROM_REG(val)	((((val) & 0x8000 ? (val)-0x10000 : (val)) \
+						>> 7) * 250)
 
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
@@ -437,8 +435,8 @@
 			return sprintf(buf,"%ld\n", \
 				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
 		} else { \
-			return sprintf(buf,"%ld\n", \
-				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+			return sprintf(buf,"%d\n", \
+				LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 		} \
 	} else {	/* TEMP1 */ \
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
@@ -453,15 +451,15 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83781d_data *data = i2c_get_clientdata(client); \
-	u32 val; \
+	s32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	val = simple_strtol(buf, NULL, 10); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) \
 			data->temp_##reg##_add[nr-2] = AS99127_TEMP_ADD_TO_REG(val); \
 		else \
-			data->temp_##reg##_add[nr-2] = TEMP_ADD_TO_REG(val); \
+			data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
 		 \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \

