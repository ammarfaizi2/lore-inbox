Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVDAAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVDAAPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCaXik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:38:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:32480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262079AbVCaXYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:08 -0500
Cc: rafael.espindola@gmail.com
Subject: [PATCH] I2C: lsb in emc6d102 and adm1027
In-Reply-To: <1112311394943@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:14 -0800
Message-Id: <11123113943693@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2343, 2005/03/31 14:30:43-08:00, rafael.espindola@gmail.com

[PATCH] I2C: lsb in emc6d102 and adm1027

The attached patches add support for reading the lsb from the emc6d102
and change how they are read from the adm1027.

The lm85_update_device function decodes the LSBs to temp_ext and in_ext.
This strategy was suggested by Philip Pokorny.

The patch also changes some macros to use the SCALE macro. I think that
they become more readable this way.


Signed-off-by: Rafael Ávila de Espíndola <rafael.espindola@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/lm85.c |  100 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 77 insertions(+), 23 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-03-31 15:16:46 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-03-31 15:16:46 -08:00
@@ -37,7 +37,7 @@
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_5(lm85b, lm85c, adm1027, adt7463, emc6d100);
+SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
 
 /* The LM85 registers */
 
@@ -77,6 +77,7 @@
 #define	LM85_VERSTEP_ADT7463C		0x6A
 #define	LM85_VERSTEP_EMC6D100_A0        0x60
 #define	LM85_VERSTEP_EMC6D100_A1        0x61
+#define	LM85_VERSTEP_EMC6D102		0x65
 
 #define	LM85_REG_CONFIG			0x40
 
@@ -113,9 +114,13 @@
 
 #define EMC6D100_REG_ALARM3             0x7d
 /* IN5, IN6 and IN7 */
-#define EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
-#define EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
-#define EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
+#define	EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
+#define	EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
+#define	EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
+#define	EMC6D102_REG_EXTEND_ADC1	0x85
+#define	EMC6D102_REG_EXTEND_ADC2	0x86
+#define	EMC6D102_REG_EXTEND_ADC3	0x87
+#define	EMC6D102_REG_EXTEND_ADC4	0x88
 
 #define	LM85_ALARM_IN0			0x0001
 #define	LM85_ALARM_IN1			0x0002
@@ -140,35 +145,36 @@
    these macros are called: arguments may be evaluated more than once.
  */
 
-/* IN are scaled 1.000 == 0xc0, mag = 3 */
-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)*0xc0+500)/1000),0,255))
-#define INEXT_FROM_REG(val,ext) (((val)*1000 + (ext)*250 + 96)/0xc0)
-#define IN_FROM_REG(val)	(INEXT_FROM_REG(val,0))
-
 /* IN are scaled acording to built-in resistors */
 static int lm85_scaling[] = {  /* .001 Volts */
 		2500, 2250, 3300, 5000, 12000,
 		3300, 1500, 1800 /*EMC6D100*/
 	};
 #define SCALE(val,from,to)		(((val)*(to) + ((from)/2))/(from))
-#define INS_TO_REG(n,val)		(SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255))
-#define INSEXT_FROM_REG(n,val,ext)	(SCALE((val)*4 + (ext),192*4,lm85_scaling[n]))
-#define INS_FROM_REG(n,val)		(INSEXT_FROM_REG(n,val,0))
+
+#define INS_TO_REG(n,val)	\
+		SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255)
+
+#define INSEXT_FROM_REG(n,val,ext,scale)	\
+		SCALE((val)*(scale) + (ext),192*(scale),lm85_scaling[n])
+
+#define INS_FROM_REG(n,val)   INSEXT_FROM_REG(n,val,0,1)
 
 /* FAN speed is measured using 90kHz clock */
 #define FAN_TO_REG(val)		(SENSORS_LIMIT( (val)<=0?0: 5400000/(val),0,65534))
 #define FAN_FROM_REG(val)	((val)==0?-1:(val)==0xffff?0:5400000/(val))
 
 /* Temperature is reported in .001 degC increments */
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)+500)/1000,-127,127))
-#define TEMPEXT_FROM_REG(val,ext)	((val)*1000 + (ext)*250)
-#define TEMP_FROM_REG(val)		(TEMPEXT_FROM_REG(val,0))
-#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/250,-127,127))
+#define TEMP_TO_REG(val)	\
+		SENSORS_LIMIT(SCALE(val,1000,1),-127,127)
+#define TEMPEXT_FROM_REG(val,ext,scale)	\
+		SCALE((val)*scale + (ext),scale,1000)
+#define TEMP_FROM_REG(val)	\
+		TEMPEXT_FROM_REG(val,0,1)
 
 #define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
 #define PWM_FROM_REG(val)		(val)
 
-#define EXT_FROM_REG(val,sensor)	(((val)>>(sensor * 2))&0x03)
 
 /* ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
@@ -356,7 +362,9 @@
 	u8 pwm[3];		/* Register value */
 	u8 spinup_ctl;		/* Register encoding, combined */
 	u8 tach_mode;		/* Register encoding, combined */
-	u16 extend_adc;		/* Register value */
+	u8 temp_ext[3];		/* Decoded values */
+	u8 in_ext[8];		/* Decoded values */
+	u8 adc_scale;		/* ADC Extended bits scaling factor */
 	u8 fan_ppr;		/* Register value */
 	u8 smooth[3];		/* Register encoding */
 	u8 vid;			/* Register value */
@@ -537,7 +545,10 @@
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]) );
+	return sprintf(	buf, "%d\n", INSEXT_FROM_REG(nr,
+						     data->in[nr],
+						     data->in_ext[nr],
+						     data->adc_scale) );
 }
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
@@ -618,7 +629,9 @@
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]) );
+	return sprintf(buf,"%d\n", TEMPEXT_FROM_REG(data->temp[nr],
+						    data->temp_ext[nr],
+						    data->adc_scale) );
 }
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
@@ -1109,6 +1122,9 @@
 			 */
 			kind = emc6d100 ;
 		} else if( company == LM85_COMPANY_SMSC
+		    && verstep == LM85_VERSTEP_EMC6D102) {
+			kind = emc6d102 ;
+		} else if( company == LM85_COMPANY_SMSC
 		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC) {
 			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
 			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
@@ -1144,6 +1160,8 @@
 		type_name = "adt7463";
 	} else if ( kind == emc6d100){
 		type_name = "emc6d100";
+	} else if ( kind == emc6d102 ) {
+		type_name = "emc6d102";
 	}
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
@@ -1261,7 +1279,6 @@
 	case LM85_REG_FAN_MIN(2) :
 	case LM85_REG_FAN_MIN(3) :
 	case LM85_REG_ALARM1 :	/* Read both bytes at once */
-	case ADM1027_REG_EXTEND_ADC1 :  /* Read two bytes at once */
 		res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
 		res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
 		break ;
@@ -1365,10 +1382,25 @@
 		 * more significant bits that are read later.
 		 */
 		if ( (data->type == adm1027) || (data->type == adt7463) ) {
-			data->extend_adc =
-			    lm85_read_value(client, ADM1027_REG_EXTEND_ADC1);
+			int ext1 = lm85_read_value(client,
+						   ADM1027_REG_EXTEND_ADC1);
+			int ext2 =  lm85_read_value(client,
+						    ADM1027_REG_EXTEND_ADC2);
+			int val = (ext1 << 8) + ext2;
+
+			for(i = 0; i <= 4; i++)
+				data->in_ext[i] = (val>>(i * 2))&0x03;
+
+			for(i = 0; i <= 2; i++)
+				data->temp_ext[i] = (val>>((i + 5) * 2))&0x03;
 		}
 
+		/* adc_scale is 2^(number of LSBs). There are 4 extra bits in
+		   the emc6d102 and 2 in the adt7463 and adm1027. In all
+		   other chips ext is always 0 and the value of scale is
+		   irrelevant. So it is left in 4*/
+		data->adc_scale = (data->type == emc6d102 ) ? 16 : 4;
+
 		for (i = 0; i <= 4; ++i) {
 			data->in[i] =
 			    lm85_read_value(client, LM85_REG_IN(i));
@@ -1405,6 +1437,28 @@
 			/* More alarm bits */
 			data->alarms |=
 				lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
+		} else if (data->type == emc6d102 ) {
+			/* Have to read LSB bits after the MSB ones because
+			   the reading of the MSB bits has frozen the
+			   LSBs (backward from the ADM1027).
+			 */
+			int ext1 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC1);
+			int ext2 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC2);
+			int ext3 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC3);
+			int ext4 = lm85_read_value(client,
+						   EMC6D102_REG_EXTEND_ADC4);
+			data->in_ext[0] = ext3 & 0x0f;
+			data->in_ext[1] = ext4 & 0x0f;
+			data->in_ext[2] = (ext4 >> 4) & 0x0f;
+			data->in_ext[3] = (ext3 >> 4) & 0x0f;
+			data->in_ext[4] = (ext2 >> 4) & 0x0f;
+
+			data->temp_ext[0] = ext1 & 0x0f;
+			data->temp_ext[1] = ext2 & 0x0f;
+			data->temp_ext[2] = (ext1 >> 4) & 0x0f;
 		}
 
 		data->last_reading = jiffies ;

