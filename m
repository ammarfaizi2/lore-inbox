Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbTL3WIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbTL3WHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:07:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:47809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265852AbTL3WG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:29 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219712881@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:12 -0800
Message-Id: <1072821972731@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.40, 2003/12/30 12:10:39-08:00, khali@linux-fr.org

[PATCH] I2C: lm83 driver updates

Here is a patch for the lm83 driver, to be applied on top of your
pending patches stack. What it does:
* Remove limit initialisation by the driver. This is a backport from
  CVS.
* A few whitespace changes inspired by my recent porting of the lm90
  driver.


 drivers/i2c/chips/lm83.c |   37 ++++++++++++-------------------------
 1 files changed, 12 insertions(+), 25 deletions(-)


diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Tue Dec 30 12:27:57 2003
+++ b/drivers/i2c/chips/lm83.c	Tue Dec 30 12:27:57 2003
@@ -41,7 +41,7 @@
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-    0x4c, 0x4e, I2C_CLIENT_END };
+	0x4c, 0x4e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
@@ -78,16 +78,13 @@
 #define LM83_REG_W_TCRIT		0x5A
 
 /*
- * Conversions, initial values and various macros
+ * Conversions and various macros
  * The LM83 uses signed 8-bit values.
  */
 
 #define TEMP_FROM_REG(val)	((val > 127 ? val-256 : val) * 1000)
 #define TEMP_TO_REG(val)	((val < 0 ? val+256 : val) / 1000)
 
-#define LM83_INIT_HIGH		100
-#define LM83_INIT_CRIT		120
-
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
 	LM83_REG_R_REMOTE1_TEMP,
@@ -114,9 +111,7 @@
  */
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter);
-static int lm83_detect(struct i2c_adapter *adapter, int address,
-    int kind);
-static void lm83_init_client(struct i2c_client *client);
+static int lm83_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm83_detach_client(struct i2c_client *client);
 static void lm83_update_client(struct i2c_client *client);
 
@@ -137,8 +132,7 @@
  * Client data (each client gets its own)
  */
 
-struct lm83_data
-{
+struct lm83_data {
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -233,8 +227,7 @@
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
  */
-static int lm83_detect(struct i2c_adapter *adapter, int address,
-    int kind)
+static int lm83_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct lm83_data *data;
@@ -290,6 +283,7 @@
 		    LM83_REG_R_MAN_ID);
 		chip_id = i2c_smbus_read_byte_data(new_client,
 		    LM83_REG_R_CHIP_ID);
+
 		if (man_id == 0x01) { /* National Semiconductor */
 			if (chip_id == 0x03) {
 				kind = lm83;
@@ -315,8 +309,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
 
-	/* Initialize the LM83 chip */
-	lm83_init_client(new_client);
+	/*
+	 * Initialize the LM83 chip
+	 * (Nothing to do for this one.)
+	 */
 
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
@@ -338,17 +334,6 @@
 	return err;
 }
 
-static void lm83_init_client(struct i2c_client *client)
-{
-	int nr;
-
-	for (nr = 0; nr < 4; nr++)
-		i2c_smbus_write_byte_data(client, LM83_REG_W_HIGH[nr],
-	            TEMP_TO_REG(LM83_INIT_HIGH));
-	i2c_smbus_write_byte_data(client, LM83_REG_W_TCRIT,
-	    TEMP_TO_REG(LM83_INIT_CRIT));
-}
-
 static int lm83_detach_client(struct i2c_client *client)
 {
 	int err;
@@ -373,6 +358,7 @@
 	    (jiffies < data->last_updated) ||
 	    !data->valid) {
 		int nr;
+
 		dev_dbg(&client->dev, "Updating lm83 data.\n");
 		for (nr = 0; nr < 4 ; nr++) {
 			data->temp_input[nr] =
@@ -388,6 +374,7 @@
 		    i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS1)
 		    + (i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS2)
 		    << 8);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}

