Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVCBUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVCBUNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVCBUJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:09:45 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34704 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262454AbVCBUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:04:12 -0500
Message-ID: <42261C39.30000@acm.org>
Date: Wed, 02 Mar 2005 14:04:09 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 6
Content-Type: multipart/mixed;
 boundary="------------050605060005030805050209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605060005030805050209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See part 1 for details on what this does...


--------------050605060005030805050209
Content-Type: text/plain;
 name="i2c_add_read_block.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_add_read_block.diff"

This adds back in the i2c_smbus_read_block_data() function
which is needed by the IPMI SMB driver (coming soon).

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
@@ -1250,6 +1250,23 @@
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
@@ -1731,6 +1748,7 @@
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_non_blocking_capable);
Index: linux-2.6.11-rc5-mm1/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-rc5-mm1/include/linux/i2c.h
@@ -99,6 +99,8 @@
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      u8 *values);
+extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+				     u8 command, u8 *values);
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 

--------------050605060005030805050209--
