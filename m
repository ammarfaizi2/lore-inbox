Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUAKPSy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUAKPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:18:54 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:21775 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265898AbUAKPSt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:18:49 -0500
Date: Sun, 11 Jan 2004 16:20:41 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (7/8)
Message-Id: <20040111162041.27fb51fa.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up various i2c algorithms:

* Remove empty algo_control function (i2c-algo-bit, i2c-algo-pcf,
i2c-algo-sibyte).
* Convert i2c_algorithm init to C99 style (i2c-algo-bit, i2c-algo-ite,
i2c-algo-pcf, i2c-algo-sibyte).

Original patch by Kyösti Mälkki.

diff -ru linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-bit.c linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-bit.c	Sat Jan 10 21:16:02 2004
+++ linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-bit.c	Sun Jan 11 13:02:02 2004
@@ -494,12 +494,6 @@
 	return num;
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
@@ -510,14 +504,10 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_bit_algo = {
-	"Bit-shift algorithm",
-	I2C_ALGO_BIT,
-	bit_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.name		= "Bit-shift algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= bit_xfer,
+	.functionality	= bit_func,
 };
 
 /* 
diff -ru linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-ite.c linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-ite.c	Sat Jan 10 21:16:02 2004
+++ linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-ite.c	Sun Jan 11 13:01:10 2004
@@ -727,14 +727,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm iic_algo = {
-	"ITE IIC algorithm",
-	I2C_ALGO_IIC,
-	iic_xfer,		/* master_xfer	*/
-	NULL,				/* smbus_xfer	*/
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	iic_func,			/* functionality	*/
+	.name		= "ITE IIC algorithm",
+	.id		= I2C_ALGO_IIC,
+	.master_xfer	= iic_xfer,
+	.algo_control	= algo_control, /* ioctl */
+	.functionality	= iic_func,
 };
 
 
diff -ru linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-pcf.c linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-pcf.c	Sat Jan 10 21:16:02 2004
+++ linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-pcf.c	Sun Jan 11 12:57:49 2004
@@ -426,12 +426,6 @@
 	return (i);
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 pcf_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
@@ -441,14 +435,10 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm pcf_algo = {
-	"PCF8584 algorithm",
-	I2C_ALGO_PCF,
-	pcf_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	pcf_func,			/* functionality	*/
+	.name		= "PCF8584 algorithm",
+	.id		= I2C_ALGO_PCF,
+	.master_xfer	= pcf_xfer,
+	.functionality	= pcf_func,
 };
 
 /* 
diff -ru linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-sibyte.c linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-sibyte.c
--- linux-2.4.25-pre4-k6/drivers/i2c/i2c-algo-sibyte.c	Sat Jan 10 21:16:02 2004
+++ linux-2.4.25-pre4-k7/drivers/i2c/i2c-algo-sibyte.c	Sun Jan 11 12:56:49 2004
@@ -115,12 +115,6 @@
         return 0;
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -131,14 +125,10 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_sibyte_algo = {
-	"SiByte algorithm",
-	I2C_ALGO_SIBYTE,
-	NULL,                           /* master_xfer          */
-	smbus_xfer,                   	/* smbus_xfer           */
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.name		= "SiByte algorithm",
+	.id		= I2C_ALGO_SIBYTE,
+	.smbus_xfer	= smbus_xfer,
+	.functionality	= bit_func,
 };
 
 /* 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
