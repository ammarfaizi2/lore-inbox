Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUKSWFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUKSWFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUKSWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:04:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:3738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261604AbUKSWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:01:09 -0500
Date: Fri, 19 Nov 2004 14:00:30 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119220030.GD15956@kroah.com>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com> <20041119220015.GC15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119220015.GC15956@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2166, 2004/11/19 09:13:45-08:00, khali@linux-fr.org

[PATCH] I2C: Cleanups to the recent smbus functions removal

This patch cleans up the recent removal of smbus functions proposed by
Arjan and then fixed by Gabriel. Changes are as follow:

1* Discard i2c_smbus_block_process_call, as it isn't used anywhere
   either. I guess that Arjan missed it because it wasn't exported.

2* Document the functions removal, so that people have at least an idea
   that the functions can be restored later if needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/writing-clients |   20 ++++++++++++++++----
 drivers/i2c/i2c-core.c            |   19 -------------------
 2 files changed, 16 insertions(+), 23 deletions(-)


diff -Nru a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients	2004-11-19 11:40:43 -08:00
+++ b/Documentation/i2c/writing-clients	2004-11-19 11:40:43 -08:00
@@ -676,13 +676,25 @@
   extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
   extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                        u8 command, u16 value);
-  extern s32 i2c_smbus_process_call(struct i2c_client * client,
-                                    u8 command, u16 value);
-  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                       u8 command, u8 *values);
   extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                         u8 command, u8 length,
                                         u8 *values);
+
+These ones were removed in Linux 2.6.10 because they had no users, but could
+be added back later if needed:
+
+  extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                           u8 command, u8 *values);
+  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+                                       u8 command, u8 *values);
+  extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+                                            u8 command, u8 length,
+                                            u8 *values);
+  extern s32 i2c_smbus_process_call(struct i2c_client * client,
+                                    u8 command, u16 value);
+  extern s32 i2c_smbus_block_process_call(struct i2c_client *client,
+                                          u8 command, u8 length,
+                                          u8 *values)
 
 All these transactions return -1 on failure. The 'write' transactions 
 return 0 on success; the 'read' transactions return the read value, except 
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-19 11:40:43 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-19 11:40:43 -08:00
@@ -1038,25 +1038,6 @@
 }
 
 /* Returns the number of read bytes */
-s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > I2C_SMBUS_BLOCK_MAX - 1)
-		return -1;
-	data.block[0] = length;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	if(i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                  I2C_SMBUS_WRITE, command,
-	                  I2C_SMBUS_BLOCK_PROC_CALL, &data))
-		return -1;
-	for (i = 1; i <= data.block[0]; i++)
-		values[i-1] = data.block[i];
-	return data.block[0];
-}
-
-/* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
