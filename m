Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVAQWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVAQWDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVAQV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:59:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52620 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262911AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Cleanups to the eeprom driver
In-Reply-To: <11059983951840@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:35 -0800
Message-Id: <1105998395257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.6, 2005/01/14 14:43:10-08:00, khali@linux-fr.org

[PATCH] I2C: Cleanups to the eeprom driver

Here comes a cleanup patch to the i2c eeprom client driver:

* Get rid of the unused i2c_client client_id.
* Get rid of the redundant non-ISA bus check.
* Fix the adapter capability check. We were previously using
  capabilities without checking if they were supported. Document
  which capabilities are required and which are optional.
* Reorder things a bit. In particular, wait to have a valid client
  before we bother checking if this is a Vaio EEPROM.
* Use strlcpy instead of strncpy, because I Heard It Was Better (TM) and
  all other chip drivers use it.
* Take benefit of the auto-increment feature of EEPROMs to speed up the
  Vaio check.
* Display an information message when a Vaio EEPROM is detected.

Tested successfully on my laptop, which happens to be a Vaio.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/eeprom.c |   47 +++++++++++++++++++++------------------------
 1 files changed, 22 insertions(+), 25 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-01-17 13:20:34 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2005-01-17 13:20:34 -08:00
@@ -78,8 +78,6 @@
 	.detach_client	= eeprom_detach_client,
 };
 
-static int eeprom_id;
-
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
@@ -165,16 +163,14 @@
 	struct eeprom_data *data;
 	int err = 0;
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev, " eeprom_detect called for an ISA bus adapter?!?\n");
-		return 0;
-	}
-#endif
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+	/* There are three ways we can read the EEPROM data:
+	   (1) I2C block reads (faster, but unsupported by most adapters)
+	   (2) Consecutive byte reads (100% overhead)
+	   (3) Regular byte data reads (200% overhead)
+	   The third method is not implemented by this driver because all
+	   known adapters support at least the second. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA
+					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
 	/* OK. For now, we presume we have a valid client. We now create the
@@ -197,26 +193,27 @@
 	/* prevent 24RF08 corruption */
 	i2c_smbus_write_quick(new_client, 0);
 
-	data->nature = UNKNOWN;
-	/* Detect the Vaio nature of EEPROMs.
-	   We use the "PCG-" prefix as the signature. */
-	if (address == 0x57) {
-		if (i2c_smbus_read_byte_data(new_client, 0x80) == 'P' && 
-		    i2c_smbus_read_byte_data(new_client, 0x81) == 'C' && 
-		    i2c_smbus_read_byte_data(new_client, 0x82) == 'G' &&
-		    i2c_smbus_read_byte_data(new_client, 0x83) == '-')
-			data->nature = VAIO;
-	}
-
 	/* Fill in the remaining client fields */
-	strncpy(new_client->name, "eeprom", I2C_NAME_SIZE);
-	new_client->id = eeprom_id++;
+	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
+	data->nature = UNKNOWN;
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_kfree;
+
+	/* Detect the Vaio nature of EEPROMs.
+	   We use the "PCG-" prefix as the signature. */
+	if (address == 0x57) {
+		if (i2c_smbus_read_byte_data(new_client, 0x80) == 'P'
+		 && i2c_smbus_read_byte(new_client) == 'C'
+		 && i2c_smbus_read_byte(new_client) == 'G'
+		 && i2c_smbus_read_byte(new_client) == '-')
+			dev_info(&new_client->dev, "Vaio EEPROM detected, "
+				"enabling password protection\n");
+			data->nature = VAIO;
+	}
 
 	/* create the sysfs eeprom file */
 	sysfs_create_bin_file(&new_client->dev.kobj, &eeprom_attr);

