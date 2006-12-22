Return-Path: <linux-kernel-owner+w=401wt.eu-S1752113AbWLVTWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWLVTWH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWLVTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:22:06 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:39792 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752113AbWLVTWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:22:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=uXYigrGv01bELJLokToim/y+CaZlF87JKNZLgokVqpt3rvbgFVx1Dli7V2jTzWfKMQoj8uUO5yINr4JH+arVG7R7G7WLjsVpPUtfMgMmIswAIURzyNuloyiTZFMGuFCPtBwZWmhF2VIaGkwDQUm+s4Zm0hPSn5kHXlflQd9/+AQ=  ;
X-YMail-OSG: bJ2KBakVM1kcv_6_O5aWWhRajP9qqLzijCzPbajHSIjWlxses7No9u588LFZ5qSYEJtilK0arv8oRx5MsJJX7drvdfqiR4V7fTrFSxt0tuy_Z40kS5J3Gurv4XuYTZl20AnMBPPjV_gURV4-
Date: Fri, 22 Dec 2006 11:22:01 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 2/6] input: ads7846 optionally leaves vREF on
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192201.644AC1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: imre.deak@solidboot.com <imre.deak@solidboot.com>
Date: Mon Jul 3 21:40:10 2006 +0300

Input ads7846: optionally leave Vref on during differential measurements

On some LCDs leaving the Vref on provides much better readings.

Signed-off-by: Jarkko Oikarinen <jarkko.oikarinen@nokia.com>
Signed-off-by: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/include/linux/spi/ads7846.h
===================================================================
--- osk.orig/include/linux/spi/ads7846.h	2006-12-22 11:08:41.000000000 -0800
+++ osk/include/linux/spi/ads7846.h	2006-12-22 11:08:43.000000000 -0800
@@ -14,6 +14,8 @@ enum ads7846_filter {
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
+	int	keep_vref_on : 1;	/* set to keep vref on for differential
+					 * measurements as well */
 	u16	x_plate_ohms;
 	u16	y_plate_ohms;
 
Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:41.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:43.000000000 -0800
@@ -145,15 +145,16 @@ struct ads7846 {
 #define	MAX_12BIT	((1<<12)-1)
 
 /* leave ADC powered up (disables penirq) between differential samples */
-#define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
-	| ADS_12_BIT | ADS_DFR)
+#define	READ_12BIT_DFR(x, adc, vref) (ADS_START | ADS_A2A1A0_d_ ## x \
+	| ADS_12_BIT | ADS_DFR | \
+	(adc ? ADS_PD10_ADC_ON : 0) | (vref ? ADS_PD10_REF_ON : 0))
 
-#define	READ_Y	(READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON)
-#define	READ_Z1	(READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON)
-#define	READ_Z2	(READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON)
+#define	READ_Y(vref)	(READ_12BIT_DFR(y,  1, vref))
+#define	READ_Z1(vref)	(READ_12BIT_DFR(z1, 1, vref))
+#define	READ_Z2(vref)	(READ_12BIT_DFR(z2, 1, vref))
 
-#define	READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_ADC_ON)
-#define	PWRDOWN	(READ_12BIT_DFR(y)  | ADS_PD10_PDOWN)	/* LAST */
+#define	READ_X(vref)	(READ_12BIT_DFR(x,  1, vref))
+#define	PWRDOWN		(READ_12BIT_DFR(y,  0, 0))	/* LAST */
 
 /* single-ended samples need to first power up reference voltage;
  * we leave both ADC and VREF powered
@@ -161,8 +162,8 @@ struct ads7846 {
 #define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
 	| ADS_12_BIT | ADS_SER)
 
-#define	REF_ON	(READ_12BIT_DFR(x) | ADS_PD10_ALL_ON)
-#define	REF_OFF	(READ_12BIT_DFR(y) | ADS_PD10_PDOWN)
+#define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
+#define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
 /*--------------------------------------------------------------------------*/
 
@@ -670,6 +671,7 @@ static int __devinit ads7846_probe(struc
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_message		*m;
 	struct spi_transfer		*x;
+	int				vref;
 	int				err;
 
 	if (!spi->irq) {
@@ -767,6 +769,8 @@ static int __devinit ads7846_probe(struc
 	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
+	vref = pdata->keep_vref_on;
+
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
@@ -776,7 +780,7 @@ static int __devinit ads7846_probe(struc
 	spi_message_init(m);
 
 	/* y- still on; turn on only y+ (and ADC) */
-	ts->read_y = READ_Y;
+	ts->read_y = READ_Y(vref);
 	x->tx_buf = &ts->read_y;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -794,7 +798,7 @@ static int __devinit ads7846_probe(struc
 
 	/* turn y- off, x+ on, then leave in lowpower */
 	x++;
-	ts->read_x = READ_X;
+	ts->read_x = READ_X(vref);
 	x->tx_buf = &ts->read_x;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -813,7 +817,7 @@ static int __devinit ads7846_probe(struc
 		spi_message_init(m);
 
 		x++;
-		ts->read_z1 = READ_Z1;
+		ts->read_z1 = READ_Z1(vref);
 		x->tx_buf = &ts->read_z1;
 		x->len = 1;
 		spi_message_add_tail(x, m);
@@ -830,7 +834,7 @@ static int __devinit ads7846_probe(struc
 		spi_message_init(m);
 
 		x++;
-		ts->read_z2 = READ_Z2;
+		ts->read_z2 = READ_Z2(vref);
 		x->tx_buf = &ts->read_z2;
 		x->len = 1;
 		spi_message_add_tail(x, m);
