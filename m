Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWAIEUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWAIEUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAIEUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:20:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:30882 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751246AbWAIEUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:20:34 -0500
Subject: Re: i2c/ smbus question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060109035323.GA2824@kroah.com>
References: <1136673364.30123.20.camel@localhost.localdomain>
	 <20060108113013.34fe5447.khali@linux-fr.org>
	 <1136761102.30123.87.camel@localhost.localdomain>
	 <20060109035323.GA2824@kroah.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 15:19:18 +1100
Message-Id: <1136780358.14374.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect i2c_smbus_write_i2c_block_data.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
> Sure, Jean, care to resend it to me, as it's now lost in my archives
> somewhere :)

here it is :-)

 drivers/i2c/i2c-core.c |   15 +++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 18 insertions(+)

--- linux-2.6.15-git.orig/drivers/i2c/i2c-core.c	2006-01-08 10:55:58.000000000 +0100
+++ linux-2.6.15-git/drivers/i2c/i2c-core.c	2006-01-08 11:17:57.000000000 +0100
@@ -948,6 +948,20 @@
 	}
 }
 
+s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
+				   u8 length, u8 *values)
+{
+	union i2c_smbus_data data;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	data.block[0] = length;
+	memcpy(data.block + 1, values, length);
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_I2C_BLOCK_DATA, &data);
+}
+
 /* Simulate a SMBus command using the i2c protocol 
    No checking of parameters is done!  */
 static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr, 
@@ -1152,6 +1166,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
--- linux-2.6.15-git.orig/include/linux/i2c.h	2006-01-08 10:56:08.000000000 +0100
+++ linux-2.6.15-git/include/linux/i2c.h	2006-01-08 11:02:00.000000000 +0100
@@ -100,6 +100,9 @@
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
+extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+					  u8 command, u8 length,
+					  u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on

-- 
Jean Delvare


