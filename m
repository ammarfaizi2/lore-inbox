Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVBXXkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVBXXkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVBXXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:36:32 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39901 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262569AbVBXXdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:33:55 -0500
Message-ID: <421E6462.6070800@acm.org>
Date: Thu, 24 Feb 2005 17:33:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2C patch 6 - Add a block smbus read handler to the I2C core
Content-Type: multipart/mixed;
 boundary="------------030704030105040505040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704030105040505040007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is one in a series of patches for adding a non-blocking interface 
to the I2C driver for supporting the IPMI SMBus driver.

--------------030704030105040505040007
Content-Type: text/plain;
 name="i2c_add_read_block.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_add_read_block.diff"

This adds back in the i2c_smbus_read_block_data() function
which is needed by the IPMI SMB driver (coming soon).

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc4/drivers/i2c/i2c-core.c
@@ -1247,6 +1247,23 @@
 }
 
 /* Returns the number of read bytes */
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+	                      I2C_SMBUS_READ,command,
+	                      I2C_SMBUS_BLOCK_DATA,&data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
+/* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
@@ -1734,6 +1751,7 @@
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_non_blocking_capable);
Index: linux-2.6.11-rc4/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/i2c.h
+++ linux-2.6.11-rc4/include/linux/i2c.h
@@ -98,6 +98,8 @@
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      u8 *values);
+extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+				     u8 command, u8 *values);
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 

--------------030704030105040505040007--
