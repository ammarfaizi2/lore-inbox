Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVDAUGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVDAUGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVDAUGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:06:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:32968 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262862AbVDAUEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:04:25 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: pcf8574 doesn't need a lock
In-Reply-To: <20050401200324.GA12854@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 12:04:14 -0800
Message-Id: <11123858541382@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2339, 2005/04/01 11:48:28-08:00, khali@linux-fr.org

[PATCH] I2C: pcf8574 doesn't need a lock

While investigating the i2c chips drivers that were not properly
locking, we found that the pcf8574 driver does the exact contrary. It
uses a lock where it's not needed.

While we were there, we did some additional cleanups to the driver:
1* Merge pcf8574_update_client() in show_read(), as it was the only user
and the function became trivial once the locking was removed.
2* Add a validity check on values provided by user-space.

Aurelien Jarno tested the modified code for confirmation and it worked
just fine.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/pcf8574.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)


diff -Nru a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c	2005-04-01 11:53:38 -08:00
+++ b/drivers/i2c/chips/pcf8574.c	2005-04-01 11:53:38 -08:00
@@ -56,7 +56,6 @@
 /* Each client has this additional data */
 struct pcf8574_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
 
 	u8 read, write;			/* Register values */
 };
@@ -65,7 +64,6 @@
 static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind);
 static int pcf8574_detach_client(struct i2c_client *client);
 static void pcf8574_init_client(struct i2c_client *client);
-static struct pcf8574_data *pcf8574_update_client(struct device *dev);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8574_driver = {
@@ -80,7 +78,9 @@
 /* following are the sysfs callback functions */
 static ssize_t show_read(struct device *dev, char *buf)
 {
-	struct pcf8574_data *data = pcf8574_update_client(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+	data->read = i2c_smbus_read_byte(client); 
 	return sprintf(buf, "%u\n", data->read);
 }
 
@@ -97,7 +97,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->write = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	data->write = val;
 	i2c_smbus_write_byte(client, data->write);
 	return count;
 }
@@ -157,7 +162,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
@@ -200,19 +204,6 @@
 	struct pcf8574_data *data = i2c_get_clientdata(client);
 	data->write = PCF8574_INIT;
 	i2c_smbus_write_byte(client, data->write);
-}
-
-static struct pcf8574_data *pcf8574_update_client(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-
-	down(&data->update_lock);
-	dev_dbg(&client->dev, "Starting pcf8574 update\n");
-	data->read = i2c_smbus_read_byte(client); 
-	up(&data->update_lock);
-	
-	return data;
 }
 
 static int __init pcf8574_init(void)

