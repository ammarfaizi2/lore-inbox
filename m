Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUCPB0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbUCPBZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:25:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:49327 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262933AbUCPADI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:08 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391394165@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <107939139416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.14, 2004/03/15 13:08:29-08:00, khali@linux-fr.org

[PATCH] I2C: fix forced i2c chip drivers have no name

I just noticed that I am doing something wrong in the i2c chip drivers I
ported to Linux 2.6. If these drivers are forced to a specific chip type
("kind" as we call it internally), then the device doesn't have its name
set (and defaults to an empty string).

Affected drivers: gl518sm, lm83, lm90, w83l785ts.

I could verify the problem on my ADM1032 chip (lm90 driver). I also
verified that the proposed patch fixes the issue.

You may notice that I fix the problem differently for gl518sm and
w83l785ts on the one hand, and lm83 and lm90 on the other hand. This is
because the first two drivers are not expected to support more a single
chip in the future, while lm90 already does and lm83 could someday (for
example, support for the LM82 could be added on request).


 drivers/i2c/chips/gl518sm.c   |    5 +----
 drivers/i2c/chips/lm83.c      |    5 ++++-
 drivers/i2c/chips/lm90.c      |    8 ++++++--
 drivers/i2c/chips/w83l785ts.c |    4 +---
 4 files changed, 12 insertions(+), 10 deletions(-)


diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:09 2004
+++ b/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:09 2004
@@ -345,7 +345,6 @@
 	struct i2c_client *new_client;
 	struct gl518_data *data;
 	int err = 0;
-	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
@@ -385,10 +384,8 @@
 		i = gl518_read_value(new_client, GL518_REG_REVISION);
 		if (i == 0x00) {
 			kind = gl518sm_r00;
-			name = "gl518sm";
 		} else if (i == 0x80) {
 			kind = gl518sm_r80;
-			name = "gl518sm";
 		} else {
 			if (kind <= 0)
 				dev_info(&adapter->dev,
@@ -400,7 +397,7 @@
 	}
 
 	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
 	new_client->id = gl518_id++;
 	data->type = kind;
 	data->valid = 0;
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:09 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:09 2004
@@ -284,7 +284,6 @@
 		if (man_id == 0x01) { /* National Semiconductor */
 			if (chip_id == 0x03) {
 				kind = lm83;
-				name = "lm83";
 			}
 		}
 
@@ -294,6 +293,10 @@
 			    "chip_id=0x%02X).\n", man_id, chip_id);
 			goto exit_free;
 		}
+	}
+
+	if (kind == lm83) {
+		name = "lm83";
 	}
 
 	/* We can fill in the remaining client fields */
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:09 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:09 2004
@@ -337,7 +337,6 @@
 				LM90_REG_R_CONFIG2) & 0xF8) == 0x00
 			   && reg_convrate <= 0x09))) {
 				kind = lm90;
-				name = "lm90";
 			}
 		}
 		else if (man_id == 0x41) { /* Analog Devices */
@@ -345,7 +344,6 @@
 			 && (kind == 0 /* skip detection */
 			  || (reg_config1 & 0x3F) == 0x00)) {
 				kind = adm1032;
-				name = "adm1032";
 			}
 		}
 
@@ -355,6 +353,12 @@
 			    "chip_id=0x%02X).\n", man_id, chip_id);
 			goto exit_free;
 		}
+	}
+
+	if (kind == lm90) {
+		name = "lm90";
+	} else if (kind == adm1032) {
+		name = "adm1032";
 	}
 
 	/* We can fill in the remaining client fields */
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:09 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:09 2004
@@ -159,7 +159,6 @@
 	struct i2c_client *new_client;
 	struct w83l785ts_data *data;
 	int err = 0;
-	const char *name = "";
 
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -220,7 +219,6 @@
 		if (man_id == 0x5CA3) { /* Winbond */
 			if (chip_id == 0x70) { /* W83L785TS-S */
 				kind = w83l785ts;			
-				name = "w83l785ts";
 			}
 		}
 	
@@ -233,7 +231,7 @@
 	}
 
 	/* We can fill in the remaining client fields. */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	strlcpy(new_client->name, "w83l785ts", I2C_NAME_SIZE);
 	new_client->id = w83l785ts_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);

