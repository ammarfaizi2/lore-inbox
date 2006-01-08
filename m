Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWAHKaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWAHKaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWAHKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:30:05 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:52239 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161172AbWAHKaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:30:04 -0500
Date: Sun, 8 Jan 2006 11:30:13 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: i2c/ smbus question
Message-Id: <20060108113013.34fe5447.khali@linux-fr.org>
In-Reply-To: <1136673364.30123.20.camel@localhost.localdomain>
References: <1136673364.30123.20.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On January 7th, 2006, Benjamin Herrenschmidt asked:
> Can you confirm the difference between writing a block of data with
> I2C_SMBUS_BLOCK_DATA vs I2C_SMBUS_I2C_BLOCK_DATA on the wire ? It's my
> understanding that the former will actually send the length byte on the
> wire before the data while the later won't, though they both send a
> subaddress.

I confirm you are correct.

> I'm completely rewriting the powermac i2c support (consolidating all
> busses behind a low level layer that I need to use in circumstances
> where the linux i2c layer isn't useable, and with a single driver in
> drivers/i2c/busses/* replacing i2c-keywest.c and i2c-pmac-smu.c) and I
> think I'm hitting a problem where i2c-keywest didn't implement
> I2C_SMBUS_BLOCK_DATA properly (didn't send the length byte) and some
> drivers (our sound drivers) rely on that behaviour (that's fine, I can
> fix them too, I just want to make sure I understand what the semantic
> should be).

I just took a quick look at i2c-keywest.c and you seem to right: the
driver supposedly implements SMBus block transfers
(I2C_SMBUS_BLOCK_DATA) but the actual implementation pretty much looks
like I2C block transfers (I2C_SMBUS_I2C_BLOCK_DATA). Good catch.

> I'm a bit surprised that there seem to be no wrapper for writing with
> I2C_SMBUS_I2C_BLOCK_DATA, only for reading, in i2c-core.c since it
> appears to me that it's the most common one, at least for all devices
> I've dealt with so far (mostly sound & clock chips in addition to
> sensors)...

I suspect that these drivers which do I2C block writes do so by calling
i2c_master_send (or even i2c_transfer) directly, rather than relying on
the SMBus compatibility layer.

The i2c_smbus_write_i2c_block_data wrapper function used to be defined,
but was removed in 2.6.10-rc2 together with a couple other similar
wrappers [1] on request by Adrian Bunk, the reason being that they had
no user back then. I was a bit reluctant at first, but we finally agreed
with Adrian to remove the functions, and to reintroduce them later if
they were ever needed.

So, if you need i2c_smbus_write_i2c_block_data(), we can easily
resurrect it. See the patch below. I made the new version a bit faster
(I hope) than the original by using memcpy, please confirm it works for
you.

[1] http://jdelvare.net2.nerim.net/quian/2.6-wrc/diff.php?patch=patch-2.6.10-rc1-rc2.bz2&file=include/linux/i2c.h
    http://jdelvare.net2.nerim.net/quian/2.6-wrc/diff.php?patch=patch-2.6.10-rc1-rc2.bz2&file=drivers/i2c/i2c-core.c

* * * * *

Resurrect i2c_smbus_write_i2c_block_data.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
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
