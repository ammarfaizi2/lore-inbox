Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUDNWs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUDNWlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:41:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:58015 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262005AbUDNWZY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:24 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814521034@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:12 -0700
Message-Id: <10819814523538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.23, 2004/04/12 15:15:13-07:00, khali@linux-fr.org

[PATCH] I2C: Rework memory allocation in i2c chip drivers

Additional remarks:

1* This patch also removes an unused struct member in via686a and fixes
an error message in ds1621.

2* I discovered error path problems in it87 and via686a detection
functions. For the it87, I think that this patch makes it even more
broken. I will fix both drivers in a later patch (really soon).


 drivers/i2c/chips/adm1021.c   |   14 ++++++--------
 drivers/i2c/chips/asb100.c    |   14 ++++++--------
 drivers/i2c/chips/ds1621.c    |   18 ++++++++----------
 drivers/i2c/chips/eeprom.c    |   14 ++++++--------
 drivers/i2c/chips/fscher.c    |   17 ++++++++---------
 drivers/i2c/chips/gl518sm.c   |   14 ++++++--------
 drivers/i2c/chips/it87.c      |   16 +++++++---------
 drivers/i2c/chips/lm75.c      |   14 ++++++--------
 drivers/i2c/chips/lm78.c      |   14 ++++++--------
 drivers/i2c/chips/lm80.c      |   13 ++++++-------
 drivers/i2c/chips/lm83.c      |   17 ++++++++---------
 drivers/i2c/chips/lm85.c      |   14 ++++++--------
 drivers/i2c/chips/lm90.c      |   17 ++++++++---------
 drivers/i2c/chips/pcf8574.c   |   15 ++++++---------
 drivers/i2c/chips/pcf8591.c   |   15 ++++++---------
 drivers/i2c/chips/via686a.c   |   16 ++++++----------
 drivers/i2c/chips/w83627hf.c  |   15 ++++++---------
 drivers/i2c/chips/w83781d.c   |   14 ++++++--------
 drivers/i2c/chips/w83l785ts.c |   18 ++++++++----------
 19 files changed, 125 insertions(+), 164 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:12:58 2004
@@ -101,6 +101,7 @@
 
 /* Each client has this additional data */
 struct adm1021_data {
+	struct i2c_client client;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -228,16 +229,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1021_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct adm1021_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error0;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct adm1021_data));
+	memset(data, 0, sizeof(struct adm1021_data));
 
-	data = (struct adm1021_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -329,7 +327,7 @@
 	return 0;
 
 error1:
-	kfree(new_client);
+	kfree(data);
 error0:
 	return err;
 }
@@ -352,7 +350,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:58 2004
@@ -193,6 +193,7 @@
    data is pointed to by client->data. The structure itself is
    dynamically allocated, at the same time the client itself is allocated. */
 struct asb100_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -722,17 +723,14 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access asb100_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-			sizeof(struct asb100_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
 		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(data, 0, sizeof(struct asb100_data));
 
-	memset(new_client, 0,
-		sizeof(struct i2c_client) + sizeof(struct asb100_data));
-
-	data = (struct asb100_data *) (new_client + 1);
+	new_client = &data->client;
 	init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
@@ -842,7 +840,7 @@
 ERROR2:
 	i2c_detach_client(new_client);
 ERROR1:
-	kfree(new_client);
+	kfree(data);
 ERROR0:
 	return err;
 }
@@ -857,7 +855,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/ds1621.c	Wed Apr 14 15:12:58 2004
@@ -70,6 +70,7 @@
 
 /* Each client has this additional data */
 struct ds1621_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -196,16 +197,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access ds1621_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct ds1621_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0, sizeof(struct i2c_client) +
-	       sizeof(struct ds1621_data));
+	memset(data, 0, sizeof(struct ds1621_data));
 	
-	data = (struct ds1621_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -258,7 +256,7 @@
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
       exit_free:
-	kfree(new_client);
+	kfree(data);
       exit:
 	return err;
 }
@@ -268,12 +266,12 @@
 	int err;
 
 	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		        "ds1621.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:12:58 2004
@@ -63,6 +63,7 @@
 
 /* Each client has this additional data */
 struct eeprom_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	u8 valid;			/* bitfield, bit!=0 if slice is valid */
 	unsigned long last_updated[8];	/* In jiffies, 8 slices */
@@ -187,16 +188,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access eeprom_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct eeprom_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct eeprom_data));
+	memset(data, 0, sizeof(struct eeprom_data));
 
-	data = (struct eeprom_data *) (new_client + 1);
+	new_client = &data->client;
 	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
@@ -244,7 +242,7 @@
 	return 0;
 
 exit_kfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -259,7 +257,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:58 2004
@@ -133,6 +133,7 @@
  */
 
 struct fscher_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -309,17 +310,15 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	 * client structure, even though we cannot fill it completely yet.
 	 * But it allows us to access i2c_smbus_read_byte_data. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct fscher_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
   	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct fscher_data));
+	memset(data, 0, sizeof(struct fscher_data));
 
-	/* The Hermes-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct fscher_data *) (new_client + 1);
+	/* The common I2C client data is placed right before the
+	 * Hermes-specific data. */
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -371,7 +370,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -386,7 +385,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/gl518sm.c	Wed Apr 14 15:12:58 2004
@@ -118,6 +118,7 @@
 
 /* Each client has this additional data */
 struct gl518_data {
+	struct i2c_client client;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -354,16 +355,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl518_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct gl518_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-		sizeof(struct gl518_data));
+	memset(data, 0, sizeof(struct gl518_data));
 
-	data = (struct gl518_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 
 	new_client->addr = address;
@@ -445,7 +443,7 @@
    very code-efficient in this case. */
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -479,7 +477,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:58 2004
@@ -134,6 +134,7 @@
    dynamically allocated, at the same time when a new it87 client is
    allocated. */
 struct it87_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -508,7 +509,7 @@
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client = NULL;
+	struct i2c_client *new_client;
 	struct it87_data *data;
 	int err = 0;
 	const char *name = "";
@@ -554,16 +555,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access it87_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-					sizeof(struct it87_data),
-					GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct it87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct it87_data));
+	memset(data, 0, sizeof(struct it87_data));
 
-	data = (struct it87_data *) (new_client + 1);
+	new_client = &data->client;
 	if (is_isa)
 		init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
@@ -670,7 +668,7 @@
 	return 0;
 
 ERROR1:
-	kfree(new_client);
+	kfree(data);
 
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
@@ -690,7 +688,7 @@
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, IT87_EXTENT);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm75.c	Wed Apr 14 15:12:58 2004
@@ -46,6 +46,7 @@
 
 /* Each client has this additional data */
 struct lm75_data {
+	struct i2c_client	client;
 	struct semaphore	update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
@@ -135,16 +136,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct lm75_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct lm75_data));
+	memset(data, 0, sizeof(struct lm75_data));
 
-	data = (struct lm75_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -194,7 +192,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -202,7 +200,7 @@
 static int lm75_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm78.c	Wed Apr 14 15:12:58 2004
@@ -192,6 +192,7 @@
    dynamically allocated, at the same time when a new lm78 client is
    allocated. */
 struct lm78_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -552,16 +553,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm78_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				   sizeof(struct lm78_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(new_client, 0, sizeof(struct i2c_client) + 
-			      sizeof(struct lm78_data));
+	memset(data, 0, sizeof(struct lm78_data));
 
-	data = (struct lm78_data *) (new_client + 1);
+	new_client = &data->client;
 	if (is_isa)
 		init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
@@ -671,7 +669,7 @@
 	return 0;
 
 ERROR2:
-	kfree(new_client);
+	kfree(data);
 ERROR1:
 	if (is_isa)
 		release_region(address, LM78_EXTENT);
@@ -694,7 +692,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:58 2004
@@ -110,6 +110,7 @@
  */
 
 struct lm80_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -394,15 +395,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm80_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm80_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct lm80_data));
+	memset(data, 0, sizeof(struct lm80_data));
 
-	data = (struct lm80_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -480,7 +479,7 @@
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -495,7 +494,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm83.c	Wed Apr 14 15:12:58 2004
@@ -134,6 +134,7 @@
  */
 
 struct lm83_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -234,17 +235,15 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm83_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	    sizeof(struct lm83_data));
+	memset(data, 0, sizeof(struct lm83_data));
 
-	/* The LM83-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct lm83_data *) (new_client + 1);
+	/* The common I2C client data is placed right after the
+	 * LM83-specific data. */
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -329,7 +328,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -344,7 +343,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm85.c	Wed Apr 14 15:12:58 2004
@@ -351,6 +351,7 @@
 };
 
 struct lm85_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -736,16 +737,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm85_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				    sizeof(struct lm85_data),
-				    GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(data, 0, sizeof(struct lm85_data));
 
-	memset(new_client, 0, sizeof(struct i2c_client) +
-			      sizeof(struct lm85_data));
-	data = (struct lm85_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -886,7 +884,7 @@
 
 	/* Error out and cleanup code */
     ERROR1:
-	kfree(new_client);
+	kfree(data);
     ERROR0:
 	return err;
 }
@@ -894,7 +892,7 @@
 int lm85_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/lm90.c	Wed Apr 14 15:12:58 2004
@@ -142,6 +142,7 @@
  */
 
 struct lm90_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -280,17 +281,15 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm90_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct lm90_data));
+	memset(data, 0, sizeof(struct lm90_data));
 
-	/* The LM90-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct lm90_data *) (new_client + 1);
+	/* The common I2C client data is placed right before the
+	   LM90-specific data. */
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -390,7 +389,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -420,7 +419,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/pcf8574.c	Wed Apr 14 15:12:58 2004
@@ -55,6 +55,7 @@
 
 /* Each client has this additional data */
 struct pcf8574_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 
 	u8 read, write;			/* Register values */
@@ -127,17 +128,13 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct pcf8574_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct pcf8574_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
+	memset(data, 0, sizeof(struct pcf8574_data));
 
-	memset(new_client, 0, sizeof(struct i2c_client) +
-	       sizeof(struct pcf8574_data));
-
-	data = (struct pcf8574_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -182,7 +179,7 @@
    very code-efficient in this case. */
 
       exit_free:
-	kfree(new_client);
+	kfree(data);
       exit:
 	return err;
 }
@@ -197,7 +194,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:58 2004
@@ -76,6 +76,7 @@
 #define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
 
 struct pcf8591_data {
+	struct i2c_client client;
 	struct semaphore update_lock;
 
 	u8 control;
@@ -177,17 +178,13 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct pcf8591_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-
-	memset(new_client, 0, sizeof(struct i2c_client) +
-			      sizeof(struct pcf8591_data));
+	memset(data, 0, sizeof(struct pcf8591_data));
 	
-	data = (struct pcf8591_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -235,7 +232,7 @@
 	   very code-efficient in this case. */
 
 exit_kfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -250,7 +247,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:58 2004
@@ -369,8 +369,7 @@
    dynamically allocated, at the same time when a new via686a client is
    allocated. */
 struct via686a_data {
-	int sysctl_id;
-
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -687,16 +686,13 @@
 		return -ENODEV;
 	}
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct via686a_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(data, 0, sizeof(struct via686a_data));
 
-	memset(new_client,0x00, sizeof(struct i2c_client) +
-				sizeof(struct via686a_data));
-	data = (struct via686a_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -753,7 +749,7 @@
 
       ERROR3:
 	release_region(address, VIA686A_EXTENT);
-	kfree(new_client);
+	kfree(data);
       ERROR0:
 	return err;
 }
@@ -769,7 +765,7 @@
 	}
 
 	release_region(client->addr, VIA686A_EXTENT);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/w83627hf.c	Wed Apr 14 15:12:58 2004
@@ -277,6 +277,7 @@
    data is pointed to by w83627hf_list[NR]->data. The structure itself is
    dynamically allocated, at the same time when a new client is allocated. */
 struct w83627hf_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -941,17 +942,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83627hf_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct w83627hf_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(data, 0, sizeof(struct w83627hf_data));
 
-	memset(new_client, 0x00, sizeof (struct i2c_client) +
-	       sizeof (struct w83627hf_data));
-
-	data = (struct w83627hf_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
@@ -1042,7 +1039,7 @@
 	return 0;
 
       ERROR2:
-	kfree(new_client);
+	kfree(data);
       ERROR1:
 	release_region(address, WINB_EXTENT);
       ERROR0:
@@ -1060,7 +1057,7 @@
 	}
 
 	release_region(client->addr, WINB_EXTENT);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:12:58 2004
@@ -226,6 +226,7 @@
    dynamically allocated, at the same time when a new w83781d client is
    allocated. */
 struct w83781d_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -1112,16 +1113,13 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83781d_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof (struct i2c_client) +
-				   sizeof (struct w83781d_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(data, 0, sizeof(struct w83781d_data));
 
-	memset(new_client, 0x00, sizeof (struct i2c_client) +
-	       sizeof (struct w83781d_data));
-
-	data = (struct w83781d_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
@@ -1321,7 +1319,7 @@
 ERROR3:
 	i2c_detach_client(new_client);
 ERROR2:
-	kfree(new_client);
+	kfree(data);
 ERROR1:
 	if (is_isa)
 		release_region(address, W83781D_EXTENT);
@@ -1343,7 +1341,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Wed Apr 14 15:12:58 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Wed Apr 14 15:12:58 2004
@@ -105,7 +105,7 @@
  */
 
 struct w83l785ts_data {
-	
+	struct i2c_client client;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -164,18 +164,16 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +  
-		sizeof(struct w83l785ts_data), GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct w83l785ts_data));
+	memset(data, 0, sizeof(struct w83l785ts_data));
 
 
-	/* The W83L785TS-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct w83l785ts_data *) (new_client + 1);
+	/* The common I2C client data is placed right before the
+	 * W83L785TS-specific data. */
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -255,7 +253,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -270,7 +268,7 @@
 		return err;
 	}
 
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 

