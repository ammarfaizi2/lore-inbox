Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVAQWEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVAQWEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVAQWBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:01:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54156 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262913AbVAQVtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:22 -0500
Cc: rafael.espindola@gmail.com
Subject: [PATCH] I2C: add EMC6D100 support in lm85 driver
In-Reply-To: <11059983961494@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:36 -0800
Message-Id: <11059983963929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.8, 2005/01/14 14:43:50-08:00, rafael.espindola@gmail.com

[PATCH] I2C: add EMC6D100 support in lm85 driver

I have ported the support for the EMC6D100 sensor from kernel 2.4 to kernel
2.6. In the process I received some comments from Jean Delvare.

Signed-off-by: Rafael Ávila de Espíndola <rafael.espindola@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm85.c |   76 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 62 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-01-17 13:20:15 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-01-17 13:20:15 -08:00
@@ -36,7 +36,7 @@
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(lm85b, lm85c, adm1027, adt7463);
+SENSORS_INSMOD_5(lm85b, lm85c, adm1027, adt7463, emc6d100);
 
 /* The LM85 registers */
 
@@ -66,11 +66,15 @@
 #define	LM85_DEVICE_ADX			0x27
 #define	LM85_COMPANY_NATIONAL		0x01
 #define	LM85_COMPANY_ANALOG_DEV		0x41
+#define	LM85_COMPANY_SMSC      		0x5c
+#define	LM85_VERSTEP_VMASK              0xf0
 #define	LM85_VERSTEP_GENERIC		0x60
 #define	LM85_VERSTEP_LM85C		0x60
 #define	LM85_VERSTEP_LM85B		0x62
 #define	LM85_VERSTEP_ADM1027		0x60
 #define	LM85_VERSTEP_ADT7463		0x62
+#define	LM85_VERSTEP_EMC6D100_A0        0x60
+#define	LM85_VERSTEP_EMC6D100_A1        0x61
 
 #define	LM85_REG_CONFIG			0x40
 
@@ -105,6 +109,12 @@
 #define	ADT7463_REG_THERM		0x79
 #define	ADT7463_REG_THERM_LIMIT		0x7A
 
+#define EMC6D100_REG_ALARM3             0x7d
+/* IN5, IN6 and IN7 */
+#define EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
+#define EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
+#define EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
+
 #define	LM85_ALARM_IN0			0x0001
 #define	LM85_ALARM_IN1			0x0002
 #define	LM85_ALARM_IN2			0x0004
@@ -135,7 +145,8 @@
 
 /* IN are scaled acording to built-in resistors */
 static int lm85_scaling[] = {  /* .001 Volts */
-		2500, 2250, 3300, 5000, 12000
+		2500, 2250, 3300, 5000, 12000,
+		3300, 1500, 1800 /*EMC6D100*/
 	};
 #define SCALE(val,from,to)		(((val)*(to) + ((from)/2))/(from))
 #define INS_TO_REG(n,val)		(SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255))
@@ -331,9 +342,9 @@
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
 
-	u8 in[5];		/* Register value */
-	u8 in_max[5];		/* Register value */
-	u8 in_min[5];		/* Register value */
+	u8 in[8];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
 	s8 temp[3];		/* Register value */
 	s8 temp_min[3];		/* Register value */
 	s8 temp_max[3];		/* Register value */
@@ -353,7 +364,7 @@
 	u16 tmin_ctl;		/* Register value */
 	unsigned long therm_total; /* Cummulative therm count */
 	u8 therm_limit;		/* Register value */
-	u16 alarms;		/* Register encoding, combined */
+	u32 alarms;		/* Register encoding, combined */
 	struct lm85_autofan autofan[3];
 	struct lm85_zone zone[3];
 };
@@ -1072,7 +1083,7 @@
 		    && verstep == LM85_VERSTEP_LM85B ) {
 			kind = lm85b ;
 		} else if( company == LM85_COMPANY_NATIONAL
-		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
+		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC ) {
 			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
@@ -1083,17 +1094,34 @@
 		    && verstep == LM85_VERSTEP_ADT7463 ) {
 			kind = adt7463 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
-		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
+		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC ) {
 			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
-				" Defaulting to ADM1027.\n", verstep);
-			kind = adm1027 ;
-		} else if( kind == 0 && (verstep & 0xf0) == 0x60) {
+				" Defaulting to Generic LM85.\n", verstep );
+			kind = any_chip ;
+		} else if( company == LM85_COMPANY_SMSC
+		    && (verstep == LM85_VERSTEP_EMC6D100_A0
+			 || verstep == LM85_VERSTEP_EMC6D100_A1) ) {
+			/* Unfortunately, we can't tell a '100 from a '101
+			 * from the registers.  Since a '101 is a '100
+			 * in a package with fewer pins and therefore no
+			 * 3.3V, 1.5V or 1.8V inputs, perhaps if those
+			 * inputs read 0, then it's a '101.
+			 */
+			kind = emc6d100 ;
+		} else if( company == LM85_COMPANY_SMSC
+		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC) {
+			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
+			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
+			    " Defaulting to Generic LM85.\n", verstep );
+			kind = any_chip ;
+		} else if( kind == any_chip
+		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC) {
 			dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
 			/* Leave kind as "any_chip" */
 		} else {
 			dev_dbg(&adapter->dev, "Autodetection failed\n");
 			/* Not an LM85 ... */
-			if( kind == 0 ) {  /* User used force=x,y */
+			if( kind == any_chip ) {  /* User used force=x,y */
 				dev_err(&adapter->dev, "Generic LM85 Version 6 not"
 					" found at %d,0x%02x. Try force_lm85c.\n",
 					i2c_adapter_id(adapter), address );
@@ -1114,6 +1142,8 @@
 		type_name = "adm1027";
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
+	} else if ( kind == emc6d100){
+		type_name = "emc6d100";
 	}
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
@@ -1365,15 +1395,24 @@
 			    lm85_read_value(client, LM85_REG_PWM(i));
 		}
 
+		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
+
 		if ( data->type == adt7463 ) {
 			if( data->therm_total < ULONG_MAX - 256 ) {
 			    data->therm_total +=
 				lm85_read_value(client, ADT7463_REG_THERM );
 			}
+		} else if ( data->type == emc6d100 ) {
+			/* Three more voltage sensors */
+			for (i = 5; i <= 7; ++i) {
+				data->in[i] =
+					lm85_read_value(client, EMC6D100_REG_IN(i));
+			}
+			/* More alarm bits */
+			data->alarms |=
+				lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
 		}
 
-		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
-
 		data->last_reading = jiffies ;
 	};  /* last_reading */
 
@@ -1387,6 +1426,15 @@
 			    lm85_read_value(client, LM85_REG_IN_MIN(i));
 			data->in_max[i] =
 			    lm85_read_value(client, LM85_REG_IN_MAX(i));
+		}
+
+		if ( data->type == emc6d100 ) {
+			for (i = 5; i <= 7; ++i) {
+				data->in_min[i] =
+					lm85_read_value(client, EMC6D100_REG_IN_MIN(i));
+				data->in_max[i] =
+					lm85_read_value(client, EMC6D100_REG_IN_MAX(i));
+			}
 		}
 
 		for (i = 0; i <= 3; ++i) {

