Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWAKVOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWAKVOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWAKVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:14:05 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:34832 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964849AbWAKVOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:14:03 -0500
Date: Wed, 11 Jan 2006 22:14:12 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] copy loop versus memcpy
Message-Id: <20060111221412.57ef8fc1.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am considering applying the following patch, in the hope to slightly
speed up some I2C/SMBus transfers. Am I right assuming that using memcpy
is faster than an explicit copy loop? The typical data size will be 32
bytes.

Thanks.

---
 drivers/i2c/i2c-core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- linux-2.6.15-git.orig/drivers/i2c/i2c-core.c	2006-01-11 18:53:43.000000000 +0100
+++ linux-2.6.15-git/drivers/i2c/i2c-core.c	2006-01-11 21:35:53.000000000 +0100
@@ -921,12 +921,11 @@
 			       u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+
 	if (length > I2C_SMBUS_BLOCK_MAX)
 		length = I2C_SMBUS_BLOCK_MAX;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
 	data.block[0] = length;
+	memcpy(data.block + 1, values, length);
 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 			      I2C_SMBUS_WRITE,command,
 			      I2C_SMBUS_BLOCK_DATA,&data);
@@ -936,16 +935,14 @@
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+
 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 	                      I2C_SMBUS_READ,command,
 	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
 		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
+
+	memcpy(values, data.block + 1, data.block[0]);
+	return data.block[0];
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,


-- 
Jean Delvare
