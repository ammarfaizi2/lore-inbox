Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUATC2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUATAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:10:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:18092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265083AbUATAAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:01 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <1074556764412@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:24 -0800
Message-Id: <10745567643254@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.19, 2004/01/16 14:13:08-08:00, khali@linux-fr.org

[PATCH] I2C: speed up eeprom driver by a factor of 4

Basically, I divide the eeprom in 8 32-byte slices. Each of it has a
"valid" boolean (combined together into a bitfield) and a jiffies
counter. Eeprom_update_client() is added a new parameter to specify
which slice to update. Code updated accordingly. Finally, the read
function updates only slices that need to be. The code is heavily
inspired from what was done in the CVS driver, of course.

Three additional notes:

1* This fixes a bug in eeprom_update_client()'s refresh condition. We
used to check jiffies before valid, although jiffies are not defined if
valid isn't true. That was already fixed in our CVS driver but for some
reason the fix did not go into 2.6 yet.

2* This also skips the update if the read if out of bounds. I think this
is the thing to do.

3* It can be discussed wether eeprom_update_client() should take two
slice parameters instead of one (start slice, end slice). This would
make things slightly faster when consecutive slices are requested. Maybe
the code would even be clearer. It wasn't done so far because the CVS
driver wouldn't benefit from it (because the EEPROM's contents are split
over several "output" files in that version of the driver) but I'll
probably give it a try in 2.6.


 drivers/i2c/chips/eeprom.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:29:39 2004
+++ b/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:29:39 2004
@@ -6,6 +6,11 @@
     Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
     Copyright (C) 2003 IBM Corp.
 
+    2004-01-16  Jean Delvare <khali@linux-fr.org>
+    Divide the eeprom in 32-byte (arbitrary) slices. This significantly
+    speeds sensors up, as well as various scripts using the eeprom
+    module.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -60,8 +65,8 @@
 /* Each client has this additional data */
 struct eeprom_data {
 	struct semaphore update_lock;
-	char valid;			/* !=0 if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
+	u8 valid;			/* bitfield, bit!=0 if slice is valid */
+	unsigned long last_updated[8];	/* In jiffies, 8 slices */
 	u8 data[EEPROM_SIZE];		/* Register values */
 	enum eeprom_nature nature;
 };
@@ -83,35 +88,36 @@
 
 static int eeprom_id = 0;
 
-static void eeprom_update_client(struct i2c_client *client)
+static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
 	int i, j;
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 300 * HZ) |
-	    (jiffies < data->last_updated) || !data->valid) {
-		dev_dbg(&client->dev, "Starting eeprom update\n");
+	if (!(data->valid & (1 << slice)) ||
+	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
+	    (jiffies < data->last_updated[slice])) {
+		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i=0; i < EEPROM_SIZE; i += I2C_SMBUS_I2C_BLOCK_MAX)
+			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_I2C_BLOCK_MAX)
 				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
 					goto exit;
 		} else {
-			if (i2c_smbus_write_byte(client, 0)) {
+			if (i2c_smbus_write_byte(client, slice << 5)) {
 				dev_dbg(&client->dev, "eeprom read start has failed!\n");
 				goto exit;
 			}
-			for (i = 0; i < EEPROM_SIZE; i++) {
+			for (i = slice << 5; i < (slice + 1) << 5; i++) {
 				j = i2c_smbus_read_byte(client);
 				if (j < 0)
 					goto exit;
 				data->data[i] = (u8) j;
 			}
 		}
-		data->last_updated = jiffies;
-		data->valid = 1;
+		data->last_updated[slice] = jiffies;
+		data->valid |= (1 << slice);
 	}
 exit:
 	up(&data->update_lock);
@@ -121,13 +127,16 @@
 {
 	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
 	struct eeprom_data *data = i2c_get_clientdata(client);
-
-	eeprom_update_client(client);
+	u8 slice;
 
 	if (off > EEPROM_SIZE)
 		return 0;
 	if (off + count > EEPROM_SIZE)
 		count = EEPROM_SIZE - off;
+
+	/* Only refresh slices which contain requested bytes */
+	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
+		eeprom_update_client(client, slice);
 
 	/* Hide Vaio security settings to regular users (16 first bytes) */
 	if (data->nature == VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {

