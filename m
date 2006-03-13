Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWCMUes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWCMUes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWCMUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:34:48 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:15633 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964775AbWCMUer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:34:47 -0500
Date: Mon, 13 Mar 2006 21:34:47 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 6/8] zoran: Use i2c_master_send when possible
Message-Id: <20060313213447.c0b6b69d.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change all the Zoran (ZR36050/ZR36060) drivers to use i2c_master_send
instead of i2c_transfer when possible. This simplifies the code by a
few lines in each driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/adv7170.c |   17 +++++++----------
 drivers/media/video/adv7175.c |   17 +++++++----------
 drivers/media/video/bt819.c   |   17 +++++++----------
 drivers/media/video/saa7110.c |    7 +------
 drivers/media/video/saa7111.c |   17 +++++++----------
 drivers/media/video/saa7114.c |   17 +++++++----------
 drivers/media/video/saa7185.c |   17 +++++++----------
 7 files changed, 43 insertions(+), 66 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/saa7110.c	2006-03-01 21:10:01.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7110.c	2006-03-01 21:10:16.000000000 +0100
@@ -107,13 +107,8 @@
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		struct saa7110 *decoder = i2c_get_clientdata(client);
-		struct i2c_msg msg;
 
-		msg.len = len;
-		msg.buf = (char *) data;
-		msg.addr = client->addr;
-		msg.flags = 0;
-		ret = i2c_transfer(client->adapter, &msg, 1);
+		ret = i2c_master_send(client, data, len);
 
 		/* Cache the written data */
 		memcpy(decoder->reg + reg, data + 1, len - 1);
--- linux-2.6.16-rc5.orig/drivers/media/video/adv7175.c	2006-03-01 21:10:14.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/adv7175.c	2006-03-01 21:10:16.000000000 +0100
@@ -114,24 +114,21 @@
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] = data[1];
+				block_data[block_len++] = data[1];
 				reg++;
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {
--- linux-2.6.16-rc5.orig/drivers/media/video/saa7111.c	2006-03-01 21:10:07.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7111.c	2006-03-01 21:10:16.000000000 +0100
@@ -111,24 +111,21 @@
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
 		struct saa7111 *decoder = i2c_get_clientdata(client);
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
+				block_data[block_len++] =
 				    decoder->reg[reg++] = data[1];
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {
--- linux-2.6.16-rc5.orig/drivers/media/video/saa7185.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7185.c	2006-03-01 21:10:16.000000000 +0100
@@ -112,24 +112,21 @@
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
 		struct saa7185 *encoder = i2c_get_clientdata(client);
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
+				block_data[block_len++] =
 				    encoder->reg[reg++] = data[1];
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {
--- linux-2.6.16-rc5.orig/drivers/media/video/bt819.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/bt819.c	2006-03-01 21:10:16.000000000 +0100
@@ -140,24 +140,21 @@
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
 		struct bt819 *decoder = i2c_get_clientdata(client);
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
+				block_data[block_len++] =
 				    decoder->reg[reg++] = data[1];
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {
--- linux-2.6.16-rc5.orig/drivers/media/video/adv7170.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/adv7170.c	2006-03-01 21:10:16.000000000 +0100
@@ -124,24 +124,21 @@
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
 		struct adv7170 *encoder = i2c_get_clientdata(client);
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
+				block_data[block_len++] =
 				    encoder->reg[reg++] = data[1];
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {
--- linux-2.6.16-rc5.orig/drivers/media/video/saa7114.c	2006-03-01 21:10:10.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7114.c	2006-03-01 21:10:16.000000000 +0100
@@ -153,24 +153,21 @@
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
-		struct i2c_msg msg;
 		u8 block_data[32];
+		int block_len;
 
-		msg.addr = client->addr;
-		msg.flags = 0;
 		while (len >= 2) {
-			msg.buf = (char *) block_data;
-			msg.len = 0;
-			block_data[msg.len++] = reg = data[0];
+			block_len = 0;
+			block_data[block_len++] = reg = data[0];
 			do {
-				block_data[msg.len++] = data[1];
+				block_data[block_len++] = data[1];
 				reg++;
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&
-				 msg.len < 32);
-			if ((ret = i2c_transfer(client->adapter,
-						&msg, 1)) < 0)
+				 block_len < 32);
+			if ((ret = i2c_master_send(client, block_data,
+						   block_len)) < 0)
 				break;
 		}
 	} else {

-- 
Jean Delvare
