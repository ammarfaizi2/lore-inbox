Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUBIXzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBIXUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:20:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:47547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265373AbUBIXTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:36 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <10763687754014@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:35 -0800
Message-Id: <1076368775888@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.4, 2004/02/02 14:52:07-08:00, khali@linux-fr.org

[PATCH] I2C: Handle read errors in w83l785ts

Here is a patch that adds proper read error handling in the w83l785ts
driver. This is needed for this driver because on many Asus boards the
BIOS or something accesses the chip in our back and causes collisions or
something similar that causes many read errors. For now, these errors
make the driver return temperature values of -1 from times to times.

I have been working with James Bolt on this. See the thread on the
lm_sensors mailing list for details. The patch is fairly well tested. It
is against 2.6.2-rc3 + your current stack of patches as I know it.

The "retry until it works" method is the best I could think of, since we
have no information from Asus and I don't expect to get any. If it still
doesn't work after an arbitrary number (5) of tries it returns the
previously known value and generates an error in the logs. James' tests
showed that it will probably never happen though (highest retry count
was 3 and happened once out of 3000 reads) unless we lower the arbitrary
number (but we don't want to, do we?)

I inserted incremental delays as reads fail, I felt like it should help
avoid collisions with whatever-is-bugging-us. Seems to work OK, but it's
not perfect (since we sometimes need 3 retries) and I didn't test with a
different policy (no delay, constant delay or different increment).


 drivers/i2c/chips/w83l785ts.c |   55 +++++++++++++++++++++++++++++++-----------
 1 files changed, 41 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:54 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:54 2004
@@ -38,6 +38,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
+/* How many retries on register read error */
+#define MAX_RETRIES	5
+
 /*
  * Address to scan
  * Address is fully defined internally and cannot be changed.
@@ -82,6 +85,7 @@
 static int w83l785ts_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static int w83l785ts_detach_client(struct i2c_client *client);
+static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval);
 static void w83l785ts_update_client(struct i2c_client *client);
 
 /*
@@ -196,10 +200,10 @@
 	 * are skipped.
 	 */
 	if (kind < 0) { /* detection */
-		if (((i2c_smbus_read_byte_data(new_client,
-		      W83L785TS_REG_CONFIG) & 0x80) != 0x00)
-		 || ((i2c_smbus_read_byte_data(new_client,
-		      W83L785TS_REG_TYPE) & 0xFC) != 0x00)) {
+		if (((w83l785ts_read_value(new_client,
+		      W83L785TS_REG_CONFIG, 0) & 0x80) != 0x00)
+		 || ((w83l785ts_read_value(new_client,
+		      W83L785TS_REG_TYPE, 0) & 0xFC) != 0x00)) {
 			dev_dbg(&adapter->dev,
 				"W83L785TS-S detection failed at 0x%02x.\n",
 				address);
@@ -211,12 +215,12 @@
 		u16 man_id;
 		u8 chip_id;
 
-		man_id = (i2c_smbus_read_byte_data(new_client,
-			 W83L785TS_REG_MAN_ID1) << 8) +
-			 i2c_smbus_read_byte_data(new_client,
-			 W83L785TS_REG_MAN_ID2);
-		chip_id = i2c_smbus_read_byte_data(new_client,
-			  W83L785TS_REG_CHIP_ID);
+		man_id = (w83l785ts_read_value(new_client,
+			 W83L785TS_REG_MAN_ID1, 0) << 8) +
+			 w83l785ts_read_value(new_client,
+			 W83L785TS_REG_MAN_ID2, 0);
+		chip_id = w83l785ts_read_value(new_client,
+			  W83L785TS_REG_CHIP_ID, 0);
 
 		if (man_id == 0x5CA3) { /* Winbond */
 			if (chip_id == 0x70) { /* W83L785TS-S */
@@ -239,6 +243,9 @@
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
+	/* Default values in case the first read fails (unlikely). */
+	data->temp_over = data->temp = 0;
+
 	/* Tell the I2C layer a new client has arrived. */
 	if ((err = i2c_attach_client(new_client))) 
 		goto exit_free;
@@ -274,6 +281,26 @@
 	return 0;
 }
 
+static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval)
+{
+	int value, i;
+
+	/* Frequent read errors have been reported on Asus boards, so we
+	 * retry on read errors. If it still fails (unlikely), return the
+	 * default value requested by the caller. */
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_byte_data(client, reg);
+		if (value >= 0)
+			return value;
+		dev_dbg(&client->dev, "Read failed, will retry in %d.\n", i);
+		i2c_delay(i);
+	}
+
+	dev_err(&client->dev, "Couldn't read value from register. "
+		"Please report.\n");
+	return defval;
+}
+
 static void w83l785ts_update_client(struct i2c_client *client)
 {
 	struct w83l785ts_data *data = i2c_get_clientdata(client);
@@ -284,10 +311,10 @@
 	 || (jiffies - data->last_updated > HZ * 2)
 	 || (jiffies < data->last_updated)) {
 		dev_dbg(&client->dev, "Updating w83l785ts data.\n");
-		data->temp = i2c_smbus_read_byte_data(client,
-			     W83L785TS_REG_TEMP);
-		data->temp_over = i2c_smbus_read_byte_data(client,
-				  W83L785TS_REG_TEMP_OVER);
+		data->temp = w83l785ts_read_value(client,
+			     W83L785TS_REG_TEMP, data->temp);
+		data->temp_over = w83l785ts_read_value(client,
+				  W83L785TS_REG_TEMP_OVER, data->temp_over);
 
 		data->last_updated = jiffies;
 		data->valid = 1;

