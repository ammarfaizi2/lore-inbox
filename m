Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUGOAJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUGOAJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUGOAJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:09:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:50923 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265973AbUGOAI6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:08:58 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <1089850035501@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:15 -0700
Message-Id: <10898500353542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.14, 2004/07/14 11:51:29-07:00, khali@linux-fr.org

[PATCH] I2C: Refine detection of LM75 chips

The LM75 detection method was a bit loose so far and would accept
non-LM75-compatible chips from times to times. It should be better now.
Additionally, the help for the lm75 driver was reworked because we now
know that the LM75 and the LM77 are not compatible.


Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/Kconfig |    8 ++++++--
 drivers/i2c/chips/lm75.c  |   37 +++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2004-07-14 16:59:00 -07:00
+++ b/drivers/i2c/chips/Kconfig	2004-07-14 16:59:00 -07:00
@@ -103,8 +103,12 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM75
-	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
-	  TCN75, and National Semiconductor LM77.
+	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
+	  9-bit precision mode), and TelCom (now Microchip) TCN75.
+
+	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
+	  a force module parameter. The driver will not handle the extra
+	  precision anyhow.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm75.
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2004-07-14 16:59:00 -07:00
+++ b/drivers/i2c/chips/lm75.c	2004-07-14 16:59:00 -07:00
@@ -113,7 +113,7 @@
 /* This function is called by i2c_detect */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i, cur, conf, hyst, os;
+	int i;
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
@@ -149,16 +149,41 @@
 	new_client->driver = &lm75_driver;
 	new_client->flags = 0;
 
-	/* Now, we do the remaining detection. It is lousy. */
+	/* Now, we do the remaining detection. There is no identification-
+	   dedicated register so we have to rely on several tricks:
+	   unused bits, registers cycling over 8-address boundaries,
+	   addresses 0x04-0x07 returning the last read value.
+	   The cycling+unused addresses combination is not tested,
+	   since it would significantly slow the detection down and would
+	   hardly add any value. */
 	if (kind < 0) {
+		int cur, conf, hyst, os;
+
+		/* Unused addresses */
 		cur = i2c_smbus_read_word_data(new_client, 0);
 		conf = i2c_smbus_read_byte_data(new_client, 1);
 		hyst = i2c_smbus_read_word_data(new_client, 2);
+		if (i2c_smbus_read_word_data(new_client, 4) != hyst
+		 || i2c_smbus_read_word_data(new_client, 5) != hyst
+		 || i2c_smbus_read_word_data(new_client, 6) != hyst
+		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
+		 	goto exit_free;
 		os = i2c_smbus_read_word_data(new_client, 3);
-		for (i = 0; i <= 0x1f; i++)
-			if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||
-			    (i2c_smbus_read_word_data(new_client, i * 8 + 2) != hyst) ||
-			    (i2c_smbus_read_word_data(new_client, i * 8 + 3) != os))
+		if (i2c_smbus_read_word_data(new_client, 4) != os
+		 || i2c_smbus_read_word_data(new_client, 5) != os
+		 || i2c_smbus_read_word_data(new_client, 6) != os
+		 || i2c_smbus_read_word_data(new_client, 7) != os)
+		 	goto exit_free;
+
+		/* Unused bits */
+		if (conf & 0xe0)
+		 	goto exit_free;
+
+		/* Addresses cycling */
+		for (i = 8; i < 0xff; i += 8)
+			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
+			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
+			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
 				goto exit_free;
 	}
 

