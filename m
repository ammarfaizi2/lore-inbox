Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVAHJaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVAHJaB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVAHJWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:22:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:33157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261835AbVAHFsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:08 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162774441@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <1105162774832@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.48, 2005/01/06 13:55:55-08:00, khali@linux-fr.org

[PATCH] I2C: Add byte commands to i2c-stub

While working on EEPROMs, DDC/EDID and the like these last few days, I
wanted to use your i2c-stub driver to test my code. However, I noticed
that it wouldn't handle byte commands, while both i2cdetect and the
eeprom driver need it for proper operation. Thus I added this
functionality to the driver. What do you think about it?

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/i2c-stub    |    9 +++++++--
 drivers/i2c/busses/i2c-stub.c |   22 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/i2c/i2c-stub b/Documentation/i2c/i2c-stub
--- a/Documentation/i2c/i2c-stub	2005-01-07 14:54:26 -08:00
+++ b/Documentation/i2c/i2c-stub	2005-01-07 14:54:26 -08:00
@@ -2,13 +2,18 @@
 
 DESCRIPTION:
 
-This module is a very simple fake I2C/SMBus driver.  It implements three
-types of SMBus commands: write quick, (r/w) byte data, and (r/w) word data.
+This module is a very simple fake I2C/SMBus driver.  It implements four
+types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, and
+(r/w) word data.
 
 No hardware is needed nor associated with this module.  It will accept write
 quick commands to all addresses; it will respond to the other commands (also
 to all addresses) by reading from or writing to an array in memory.  It will
 also spam the kernel logs for every command it handles.
+
+A pointer register with auto-increment is implemented for all byte
+operations.  This allows for continuous byte reads like those supported by
+EEPROMs, among others.
 
 The typical use-case is like this:
 	1. load this module
diff -Nru a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
--- a/drivers/i2c/busses/i2c-stub.c	2005-01-07 14:54:26 -08:00
+++ b/drivers/i2c/busses/i2c-stub.c	2005-01-07 14:54:26 -08:00
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
+static u8  stub_pointer;
 static u8  stub_bytes[256];
 static u16 stub_words[256];
 
@@ -44,6 +45,22 @@
 		ret = 0;
 		break;
 
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE) {
+			stub_pointer = command;
+			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
+					"wrote 0x%02x.\n",
+					addr, command);
+		} else {
+			data->byte = stub_bytes[stub_pointer++];
+			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
+					"read  0x%02x.\n",
+					addr, data->byte);
+		}
+
+		ret = 0;
+		break;
+
 	case I2C_SMBUS_BYTE_DATA:
 		if (read_write == I2C_SMBUS_WRITE) {
 			stub_bytes[command] = data->byte;
@@ -56,6 +73,7 @@
 					"read  0x%02x at 0x%02x.\n",
 					addr, data->byte, command);
 		}
+		stub_pointer = command + 1;
 
 		ret = 0;
 		break;
@@ -87,8 +105,8 @@
 
 static u32 stub_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA;
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA;
 }
 
 static struct i2c_algorithm smbus_algorithm = {

