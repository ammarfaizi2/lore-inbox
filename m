Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbUAKPDY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAKPDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:03:24 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:60173 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265882AbUAKPCw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:02:52 -0500
Date: Sun, 11 Jan 2004 16:04:44 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (5/8)
Message-Id: <20040111160444.660f1bdd.khali@linux-fr.org>
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

This patch defines I2C_SMBUS_BLOCK_MAX and I2C_SMBUS_I2C_BLOCK_MAX,
those values were previously hardcoded in several places.

Part of the work was done by Kyösti Mälkki. Original comment follows:
***
Message block size.
***

The patch also fixes an incorrect error message and a potential buffer
overrun.

diff -ru linux-2.4.25-pre4-k4/drivers/i2c/i2c-core.c linux-2.4.25-pre4-k5/drivers/i2c/i2c-core.c
--- linux-2.4.25-pre4-k4/drivers/i2c/i2c-core.c	Sat Jan 10 20:27:50 2004
+++ linux-2.4.25-pre4-k5/drivers/i2c/i2c-core.c	Sun Jan 11 10:33:12 2004
@@ -1062,8 +1062,8 @@
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -1077,8 +1077,8 @@
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_I2C_BLOCK_MAX)
+		length = I2C_SMBUS_I2C_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -1152,10 +1152,10 @@
 			return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > 34) {
+			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
 				printk(KERN_ERR "i2c-core.o: smbus_access called with "
 				       "invalid block write size (%d)\n",
-				       msg[0].len);
+				       data->block[0]);
 				return -1;
 			}
 			for (i = 1; i <= msg[0].len; i++)
diff -ru linux-2.4.25-pre4-k4/include/linux/i2c.h linux-2.4.25-pre4-k5/include/linux/i2c.h
--- linux-2.4.25-pre4-k4/include/linux/i2c.h	Sat Jan 10 20:27:55 2004
+++ linux-2.4.25-pre4-k5/include/linux/i2c.h	Sun Jan 11 10:46:48 2004
@@ -413,10 +413,13 @@
 /* 
  * Data for SMBus Messages 
  */
+#define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
+#define I2C_SMBUS_I2C_BLOCK_MAX	32	/* Not specified but we use same structure */
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;
-	__u8 block[33]; /* block[0] is used for length */
+	__u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
+	                  /* one more for read length in block process call */
 };
 
 /* smbus_access read or write markers */


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
