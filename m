Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVAHGkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVAHGkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVAHGiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:38:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:22918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbVAHFst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:49 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162776515@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:36 -0800
Message-Id: <11051627762989@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.10, 2004/12/21 11:09:21-08:00, khali@linux-fr.org

[PATCH] I2C: Remove checksum code in eeprom driver

As a follow-up to my earlier proposal to remove the checksum code from
the i2c eeprom driver, here is a patch that does just that. This shrinks
the driver size by around 5%, and paves the way for further fixes and
cleanups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/eeprom.c |   19 -------------------
 1 files changed, 19 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-01-07 14:55:12 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2005-01-07 14:55:12 -08:00
@@ -43,13 +43,6 @@
 /* Insmod parameters */
 SENSORS_INSMOD_1(eeprom);
 
-static int checksum = 0;
-module_param(checksum, bool, 0);
-MODULE_PARM_DESC(checksum, "Only accept eeproms whose checksum is correct");
-
-
-/* EEPROM registers */
-#define EEPROM_REG_CHECKSUM	0x3f
 
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
@@ -168,7 +161,6 @@
 /* This function is called by i2c_detect */
 int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i, cs;
 	struct i2c_client *new_client;
 	struct eeprom_data *data;
 	int err = 0;
@@ -204,17 +196,6 @@
 
 	/* prevent 24RF08 corruption */
 	i2c_smbus_write_quick(new_client, 0);
-
-	/* Now, we do the remaining detection. It is not there, unless you force
-	   the checksum to work out. */
-	if (checksum) {
-		cs = 0;
-		for (i = 0; i <= 0x3e; i++)
-			cs += i2c_smbus_read_byte_data(new_client, i);
-		cs &= 0xff;
-		if (i2c_smbus_read_byte_data (new_client, EEPROM_REG_CHECKSUM) != cs)
-			goto exit_kfree;
-	}
 
 	data->nature = UNKNOWN;
 	/* Detect the Vaio nature of EEPROMs.

