Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSH0Wwp>; Tue, 27 Aug 2002 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSH0Wwp>; Tue, 27 Aug 2002 18:52:45 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:36625 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316595AbSH0Wwi>;
	Tue, 27 Aug 2002 18:52:38 -0400
Date: Tue, 27 Aug 2002 18:49:09 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.32 (repost) : [i2c] drivers/media/video/bt856.c 
Message-ID: <Pine.LNX.4.44.0208271848130.899-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
  Another i2c-old --> i2c patch for bt856.c . Please review for inclusion. 

Regards,
Frank

--- drivers/media/video/bt856.c.old	Fri Jun 28 11:51:10 2002
+++ drivers/media/video/bt856.c	Thu Jul  4 00:34:45 2002
@@ -47,15 +47,32 @@
 #include <linux/version.h>
 #include <asm/uaccess.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 #include <linux/video_encoder.h>
 
 #define DEBUG(x)   x		/* Debug driver */
 
 /* ----------------------------------------------------------------------- */
 
+static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	normal_i2c , normal_i2c_range,
+	probe , probe_range,
+	ignore , ignore_range,
+	force
+};
+
+static struct i2c_client client_template;
+
 struct bt856 {
-	struct i2c_bus *bus;
+	struct i2c_client *client;
 	int addr;
 	unsigned char reg[128];
 
@@ -73,40 +90,35 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt856_write(struct bt856 *dev, unsigned char subaddr,
-		       unsigned char data)
+static int bt856_probe(struct i2c_adapter *adap)
 {
-	int ack;
-
-	LOCK_I2C_BUS(dev->bus);
-
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-	i2c_sendbyte(dev->bus, subaddr, I2C_DELAY);
-	ack = i2c_sendbyte(dev->bus, data, I2C_DELAY);
-	dev->reg[subaddr] = data;
-	i2c_stop(dev->bus);
-	UNLOCK_I2C_BUS(dev->bus);
-	return ack;
+	return i2c_probe(adap, &addr_data , bt856_attach);
 }
 
 static int bt856_setbit(struct bt856 *dev, int subaddr, int bit, int data)
 {
-	return bt856_write(dev, subaddr,(dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
+	return i2c_smbus_write_byte_data(dev->client, subaddr,(dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
 }
 
 /* ----------------------------------------------------------------------- */
 
-static int bt856_attach(struct i2c_device *device)
+static int bt856_attach(struct i2c_adapter *adap, int addr , unsigned long flags, int kind)
 {
 	struct bt856 *encoder;
-
+	struct i2c_client *client;
+	
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if(client == NULL)
+		return -ENOMEM;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));	
+	
 	/* This chip is not on the buz card but at the same address saa7185 */
 	//if (memcmp(device->bus->name, "buz", 3) == 0 || memcmp(device->bus->name, "zr36057", 6) == 0)
 	//   return 1;
 
-	MOD_INC_USE_COUNT;
-	device->data = encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
+	encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
 
 	if (encoder == NULL) {
 		MOD_DEC_USE_COUNT;
@@ -115,17 +127,21 @@
 
 
 	memset(encoder, 0, sizeof(struct bt856));
-	strcpy(device->name, "bt856");
-	encoder->bus = device->bus;
-	encoder->addr = device->addr;
+	strcpy(client->name, "bt856");
+	encoder->client = client;
+	client->data = encoder;
+	encoder->addr = client->addr;
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 
 	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->bus->name));
 
-	bt856_write(encoder, 0xdc, 0x18);
-	bt856_write(encoder, 0xda, 0);
-	bt856_write(encoder, 0xde, 0);
+	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
+	encoder->reg[0xdc] = 0x18;
+	i2c_smbus_write_byte_data(client, 0xda, 0);
+	encoder->reg[0xda] = 0;
+	i2c_smbus_write_byte_data(client, 0xde, 0);
+	encoder->reg[0xde] = 0;
 
 	bt856_setbit(encoder, 0xdc, 3, 1);
 	//bt856_setbit(encoder, 0xdc, 6, 0);
@@ -145,21 +161,26 @@
 	bt856_setbit(encoder, 0xdc, 1, 1);
 	bt856_setbit(encoder, 0xde, 4, 0);
 	bt856_setbit(encoder, 0xde, 3, 1);
+	init_MUTEX(&encoder->lock);
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 
-static int bt856_detach(struct i2c_device *device)
+static int bt856_detach(struct i2c_client *client)
 {
-	kfree(device->data);
+	i2c_detach_client(client);
+	kfree(client->data);
+	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int bt856_command(struct i2c_device *device, unsigned int cmd,
+static int bt856_command(struct i2c_client *client, unsigned int cmd,
 			 void *arg)
 {
-	struct bt856 *encoder = device->data;
+	struct bt856 *encoder = client->data;
 
 	switch (cmd) {
 
@@ -169,7 +190,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: get capabilities\n",
-			       encoder->bus->name));
+			       encoder->client->name));
 
 			cap->flags
 			    = VIDEO_ENCODER_PAL
@@ -184,7 +205,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set norm %d\n",
-				     encoder->bus->name, *iarg));
+				     encoder->client->name, *iarg));
 
 			switch (*iarg) {
 
@@ -211,7 +232,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set input %d\n",
-				     encoder->bus->name, *iarg));
+				     encoder->client->name, *iarg));
 
 			/*     We only have video bus.
 			   *iarg = 0: input is from bt819
@@ -247,7 +268,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set output %d\n",
-				     encoder->bus->name, *iarg));
+				     encoder->client->name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -264,7 +285,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: enable output %d\n",
-			       encoder->bus->name, encoder->enable));
+			       encoder->client->name, encoder->enable));
 		}
 		break;
 
@@ -279,21 +300,30 @@
 
 static struct i2c_driver i2c_driver_bt856 = {
 	"bt856",		/* name */
-	I2C_DRIVERID_VIDEOENCODER,	/* ID */
-	I2C_BT856, I2C_BT856 + 1,
-	bt856_attach,
+	I2C_DRIVERID_BT856,	/* ID */
+	I2C_DF_NOTIFY,
+	bt856_probe,
 	bt856_detach,
 	bt856_command
 };
 
+static struct i2c_client client_template = {
+	"bt856_client",
+	-1,
+	0,
+	0,
+	NULL,
+	&i2c_driver_bt856
+};
+
 static int bt856_init(void)
 {
-	return i2c_register_driver(&i2c_driver_bt856);
+	return i2c_add_driver(&i2c_driver_bt856);
 }
 
 static void bt856_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_bt856);
+	i2c_del_driver(&i2c_driver_bt856);
 }
 
 module_init(bt856_init);



