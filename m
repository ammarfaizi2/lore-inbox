Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVG3AWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVG3AWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVG2TTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:64430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262699AbVG2TQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:23 -0400
Date: Fri, 29 Jul 2005 12:15:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: [patch 11/29] I2C: 24RF08 corruption prevention (again)
Message-ID: <20050729191533.GM5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

The 24RF08 corruption prevention in the eeprom and max6875 drivers wasn't
complete. For one thing, the additional quick write should happen as soon
as possible and unconditionally, while both drivers had error paths before.
For another, when a given chip is forced, the core does not emit a quick
write, so a second quick write would cause the corruption rather than
prevent it.

I plan to move the corruption prevention in the core in the long run, so
that individual drivers don't have to care anymore. But I need to merge
i2c_probe and i2c_detect before I do (work in progress).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/chips/eeprom.c  |    8 +++++---
 drivers/i2c/chips/max6875.c |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/chips/eeprom.c	2005-07-29 11:36:14.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/eeprom.c	2005-07-29 11:36:18.000000000 -0700
@@ -163,6 +163,11 @@
 	struct eeprom_data *data;
 	int err = 0;
 
+	/* prevent 24RF08 corruption */
+	if (kind < 0)
+		i2c_smbus_xfer(adapter, address, 0, 0, 0,
+			       I2C_SMBUS_QUICK, NULL);
+
 	/* There are three ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
 	   (2) Consecutive byte reads (100% overhead)
@@ -187,9 +192,6 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
-	/* prevent 24RF08 corruption */
-	i2c_smbus_write_quick(new_client, 0);
-
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
--- gregkh-2.6.orig/drivers/i2c/chips/max6875.c	2005-07-29 11:36:14.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/max6875.c	2005-07-29 11:36:18.000000000 -0700
@@ -343,6 +343,11 @@
 	struct max6875_data *data;
 	int err = 0;
 
+	/* Prevent 24RF08 corruption (in case of user error) */
+	if (kind < 0)
+		i2c_smbus_xfer(adapter, address, 0, 0, 0,
+			       I2C_SMBUS_QUICK, NULL);
+
 	/* There are three ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
 	   (2) Consecutive byte reads (100% overhead)
@@ -370,9 +375,6 @@
 	new_client->driver = &max6875_driver;
 	new_client->flags = 0;
 
-	/* Prevent 24RF08 corruption */
-	i2c_smbus_write_quick(new_client, 0);
-
 	/* Setup the user section */
 	data->blocks[max6875_eeprom_user].type    = max6875_eeprom_user;
 	data->blocks[max6875_eeprom_user].slices  = USER_EEPROM_SLICES;

--
