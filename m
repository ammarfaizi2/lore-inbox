Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbTFRSTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTFRSPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:15:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56978 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265407AbTFRSLs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:48 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607072903@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607073182@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:07 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.3, 2003/06/16 11:31:55-07:00, mhoffman@lightlink.com

[PATCH] I2C: w83781d bugfix

My first patch was naive; the patch below solves the problem by
letting w83781d_detach_client remove the three clients (1 * primary
+ 2 * subclients) independently.  It's a noisy patch because I had
to change the way the subclients were kmalloc'ed - sorry.  The meat
is around line 1422.  This patch works for me... comments?


 drivers/i2c/chips/w83781d.c |   76 +++++++++++++++++++++++---------------------
 1 files changed, 40 insertions(+), 36 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:39 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:39 2003
@@ -299,8 +299,8 @@
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	struct i2c_client *lm75;	/* for secondary I2C addresses */
-	/* pointer to array of 2 subclients */
+	struct i2c_client *lm75[2];	/* for secondary I2C addresses */
+	/* array of 2 pointers to subclients */
 
 	u8 in[9];		/* Register value - 8 & 9 for 782D only */
 	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
@@ -1043,12 +1043,12 @@
 	const char *client_name;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
-	if (!(data->lm75 = kmalloc(2 * sizeof (struct i2c_client),
-			GFP_KERNEL))) {
+	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+	memset(data->lm75[0], 0x00, sizeof (struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -1066,25 +1066,33 @@
 		w83781d_write_value(new_client, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
-		data->lm75[0].addr = force_subclients[2];
+		data->lm75[0]->addr = force_subclients[2];
 	} else {
 		val1 = w83781d_read_value(new_client, W83781D_REG_I2C_SUBADDR);
-		data->lm75[0].addr = 0x48 + (val1 & 0x07);
+		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
 	}
 
 	if (kind != w83783s) {
+
+		data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+		if (!(data->lm75[1])) {
+			err = -ENOMEM;
+			goto ERROR_SC_1;
+		}
+		memset(data->lm75[1], 0x0, sizeof(struct i2c_client));
+
 		if (force_subclients[0] == id &&
 		    force_subclients[1] == address) {
-			data->lm75[1].addr = force_subclients[3];
+			data->lm75[1]->addr = force_subclients[3];
 		} else {
-			data->lm75[1].addr = 0x48 + ((val1 >> 4) & 0x07);
+			data->lm75[1]->addr = 0x48 + ((val1 >> 4) & 0x07);
 		}
-		if (data->lm75[0].addr == data->lm75[1].addr) {
+		if (data->lm75[0]->addr == data->lm75[1]->addr) {
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
-			       data->lm75[0].addr);
+			       data->lm75[0]->addr);
 			err = -EBUSY;
-			goto ERROR_SC_1;
+			goto ERROR_SC_2;
 		}
 	}
 
@@ -1103,19 +1111,19 @@
 
 	for (i = 0; i <= 1; i++) {
 		/* store all data in w83781d */
-		i2c_set_clientdata(&data->lm75[i], NULL);
-		data->lm75[i].adapter = adapter;
-		data->lm75[i].driver = &w83781d_driver;
-		data->lm75[i].flags = 0;
-		strlcpy(data->lm75[i].dev.name, client_name,
+		i2c_set_clientdata(data->lm75[i], NULL);
+		data->lm75[i]->adapter = adapter;
+		data->lm75[i]->driver = &w83781d_driver;
+		data->lm75[i]->flags = 0;
+		strlcpy(data->lm75[i]->dev.name, client_name,
 			DEVICE_NAME_SIZE);
-		if ((err = i2c_attach_client(&(data->lm75[i])))) {
+		if ((err = i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
 				"registration at address 0x%x "
-				"failed.\n", i, data->lm75[i].addr);
+				"failed.\n", i, data->lm75[i]->addr);
 			if (i == 1)
-				goto ERROR_SC_2;
-			goto ERROR_SC_1;
+				goto ERROR_SC_3;
+			goto ERROR_SC_2;
 		}
 		if (kind == w83783s)
 			break;
@@ -1124,10 +1132,14 @@
 	return 0;
 
 /* Undo inits in case of errors */
+ERROR_SC_3:
+	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
-	i2c_detach_client(&(data->lm75[0]));
+	if (NULL != data->lm75[1])
+		kfree(data->lm75[1]);
 ERROR_SC_1:
-	kfree(data->lm75);
+	if (NULL != data->lm75[0])
+		kfree(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1326,7 +1338,8 @@
 				kind, new_client)))
 			goto ERROR3;
 	} else {
-		data->lm75 = NULL;
+		data->lm75[0] = NULL;
+		data->lm75[1] = NULL;
 	}
 
 	device_create_file_in(new_client, 0);
@@ -1409,20 +1422,11 @@
 static int
 w83781d_detach_client(struct i2c_client *client)
 {
-	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
-	/* release ISA region or I2C subclients first */
-	if (i2c_is_isa_client(client)) {
+	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
-	} else {
-		i2c_detach_client(&data->lm75[0]);
-		if (data->type != w83783s)
-			i2c_detach_client(&data->lm75[1]);
-		kfree(data->lm75);
-	}
 
-	/* now it's safe to scrap the rest */
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
@@ -1484,7 +1488,7 @@
 			res = i2c_smbus_read_byte_data(client, reg & 0xff);
 		} else {
 			/* switch to subclient */
-			cl = &data->lm75[bank - 1];
+			cl = data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x50:	/* TEMP */
@@ -1555,7 +1559,7 @@
 						  value & 0xff);
 		} else {
 			/* switch to subclient */
-			cl = &data->lm75[bank - 1];
+			cl = data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x52:	/* CONFIG */

