Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbSKTAob>; Tue, 19 Nov 2002 19:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSKTAob>; Tue, 19 Nov 2002 19:44:31 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:42416 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267156AbSKTAo0>; Tue, 19 Nov 2002 19:44:26 -0500
Date: Tue, 19 Nov 2002 19:44:10 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.47-ac6 : drivers/media/video/saa7185.c
Message-ID: <Pine.LNX.4.44.0211191941320.855-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following updates the saa7185 driver with the current i2c API. 
Please review for inclusion.

Regards,
Frank

--- linux/drivers/media/video/saa7185.c.old	Sat Oct 19 12:04:54 2002
+++ linux/drivers/media/video/saa7185.c	Fri Nov  1 00:49:09 2002
@@ -43,7 +43,7 @@
 #include <linux/version.h>
 #include <asm/uaccess.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 
 #include <linux/video_encoder.h>
 
@@ -52,9 +52,10 @@
 /* ----------------------------------------------------------------------- */
 
 struct saa7185 {
-	struct i2c_bus *bus;
+	struct i2c_client *client;
 	int addr;
 	unsigned char reg[128];
+	struct semaphore lock;
 
 	int norm;
 	int enable;
@@ -69,66 +70,25 @@
 #define I2C_DELAY   10
 
 /* ----------------------------------------------------------------------- */
+static unsigned short normal_i2c[] = { 34>>1, I2C_CLIENT_END };	
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c 		= normal_i2c,
+	.normal_i2c_range 	= normal_i2c_range,
+	.probe 			= probe, 
+	.probe_range 		= probe_range,
+	.ignore 		= ignore,
+	.ignore_range 		= ignore_range,
+	.force 			= force
+};
 
-static int saa7185_read(struct saa7185 *dev)
-{
-	int ack;
-
-	LOCK_I2C_BUS(dev->bus);
-
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr | 1, I2C_DELAY);
-	ack = i2c_readbyte(dev->bus, 1);
-	i2c_stop(dev->bus);
-	UNLOCK_I2C_BUS(dev->bus);
-	return ack;
-}
-
-static int saa7185_write(struct saa7185 *dev, unsigned char subaddr,
-			 unsigned char data)
-{
-	int ack;
-
-	DEBUG(printk
-	      (KERN_DEBUG "SAA7185: %02x set to %02x\n", subaddr, data);
-	    )
-	    LOCK_I2C_BUS(dev->bus);
-
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-	i2c_sendbyte(dev->bus, subaddr, I2C_DELAY);
-	ack = i2c_sendbyte(dev->bus, data, I2C_DELAY);
-	dev->reg[subaddr] = data;
-	i2c_stop(dev->bus);
-	UNLOCK_I2C_BUS(dev->bus);
-	return ack;
-}
-
-static int saa7185_write_block(struct saa7185 *dev,
-			       unsigned const char *data, unsigned int len)
-{
-	int ack = -1;
-	unsigned subaddr;
-
-	while (len > 1) {
-		LOCK_I2C_BUS(dev->bus);
-		i2c_start(dev->bus);
-		i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-		ack = i2c_sendbyte(dev->bus, (subaddr = *data++), I2C_DELAY);
-		ack = i2c_sendbyte(dev->bus, (dev->reg[subaddr] = *data++), I2C_DELAY);
-		len -= 2;
-		while (len > 1 && *data == ++subaddr) {
-			data++;
-			ack = i2c_sendbyte(dev->bus, (dev->reg[subaddr] = *data++), I2C_DELAY);
-			len -= 2;
-		}
-		i2c_stop(dev->bus);
-		UNLOCK_I2C_BUS(dev->bus);
-	}
-	return ack;
-}
-
-/* ----------------------------------------------------------------------- */
+static struct i2c_client client_template;
 
 static const unsigned char init_common[] = {
 	0x3a, 0x0f,		/* CBENB=0, V656=0, VY2C=1, YUV2C=1, MY2C=1, MUV2C=1 */
@@ -222,58 +182,71 @@
 	0x66, 0x21,		/* FSC3 */
 };
 
-static int saa7185_attach(struct i2c_device *device)
+static int saa7185_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
 {
 	int i;
 	struct saa7185 *encoder;
+	struct i2c_client client;
 
-	MOD_INC_USE_COUNT;
-	
-	device->data = encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if (client == NULL)
+		return -ENOMEM;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));
+	encoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
 	if (encoder == NULL) {
-		MOD_DEC_USE_COUNT;
+		kfree(client);
 		return -ENOMEM;
 	}
 
 
-	memset(encoder, 0, sizeof(struct saa7185));
-	strcpy(device->name, "saa7185");
-	encoder->bus = device->bus;
-	encoder->addr = device->addr;
+	memset(encoder, 0, sizeof(*decoder));
+	strcpy(client->name, "saa7185");
+	encoder->client = client;
+	client->data = encoder;
+	encoder->addr = addr;
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 
-	i = saa7185_write_block(encoder, init_common, sizeof(init_common));
+	i = i2c_master_send(client, init_common, sizeof(init_common));
 	if (i >= 0) {
-		i = saa7185_write_block(encoder, init_ntsc,
+		i = i2c_master_send(client, init_ntsc,
 					sizeof(init_ntsc));
 	}
 	if (i < 0) {
-		printk(KERN_ERR "%s_attach: init error %d\n", device->name,
+		printk(KERN_ERR "%s_attach: init error %d\n", client->name,
 		       i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %d\n",
-		       device->name, saa7185_read(encoder) >> 5);
+		       client->name, i2c_smbus_read_byte(client) >> 5);
 	}
-
+	init_MUTEX(&decoder->lock);
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
 	return 0;
 }
+static int saa7185_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, saa7185_attach);
+}
 
-
-static int saa7185_detach(struct i2c_device *device)
+static int saa7185_detach(struct i2c_client *client)
 {
-	struct saa7185 *encoder = device->data;
-	saa7185_write(encoder, 0x61, (encoder->reg[0x61]) | 0x40);	/* SW: output off is active */
-	//saa7185_write(encoder, 0x3a, (encoder->reg[0x3a]) | 0x80); /* SW: color bar */
+	struct saa7185 *encoder = client->data;
+	i2c_detach_client(client);
+	i2c_smbus_write_byte_data(client, 0x61, (encoder->reg[0x61]) | 0x40);	/* SW: output off is active */
+	//i2c_smbus_write_byte_data(client, 0x3a, (encoder->reg[0x3a]) | 0x80); /* SW: color bar */
 	kfree(encoder);
+	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int saa7185_command(struct i2c_device *device, unsigned int cmd,
+static int saa7185_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct saa7185 *encoder = device->data;
+	struct saa7185 *encoder = client->data;
 
 	switch (cmd) {
 
@@ -297,12 +270,12 @@
 			switch (*iarg) {
 
 			case VIDEO_MODE_NTSC:
-				saa7185_write_block(encoder, init_ntsc,
+				i2c_master_send(client, init_ntsc,
 						    sizeof(init_ntsc));
 				break;
 
 			case VIDEO_MODE_PAL:
-				saa7185_write_block(encoder, init_pal,
+				i2c_master_send(client, init_pal,
 						    sizeof(init_pal));
 				break;
 
@@ -326,19 +299,19 @@
 
 			case 0:
 				/* Switch RTCE to 1 */
-				saa7185_write(encoder, 0x61,
+				i2c_smbus_write_byte_data(client, 0x61,
 					      (encoder->
 					       reg[0x61] & 0xf7) | 0x08);
-				saa7185_write(encoder, 0x6e, 0x01);
+				i2c_smbus_write_byte_data(client, 0x6e, 0x01);
 				break;
 
 			case 1:
 				/* Switch RTCE to 0 */
-				saa7185_write(encoder, 0x61,
+				i2c_smbus_write_byte_data(client, 0x61,
 					      (encoder->
 					       reg[0x61] & 0xf7) | 0x00);
 				/* SW: a slight sync problem... */
-				saa7185_write(encoder, 0x6e, 0x00);
+				i2c_smbus_write_byte_data(client, 0x6e, 0x00);
 				break;
 
 			default:
@@ -364,7 +337,7 @@
 			int *iarg = arg;
 
 			encoder->enable = !!*iarg;
-			saa7185_write(encoder, 0x61,
+			i2c_smbus_write_byte_data(client, 0x61,
 				      (encoder->
 				       reg[0x61] & 0xbf) | (encoder->
 							    enable ? 0x00 :
@@ -382,23 +355,28 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7185 = {
-	"saa7185",		/* name */
-	I2C_DRIVERID_VIDEOENCODER,	/* ID */
-	I2C_SAA7185, I2C_SAA7185 + 1,
-
-	saa7185_attach,
-	saa7185_detach,
-	saa7185_command
+	.name	 	= "saa7185",		 /* name */
+	.id 		= I2C_DRIVERID_SAA7185B, /* ID */
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = saa7185_probe,
+	.detach_client 	= saa7185_detach,
+	.command	= saa7185_command
+};
+
+static struct i2c_client client_template = {
+	.name 	= "saa7185_client",
+	.id 	= -1,
+	.driver = &i2c_driver_saa7185
 };
 
 static int saa7185_init(void)
 {
-	return i2c_register_driver(&i2c_driver_saa7185);
+	return i2c_add_driver(&i2c_driver_saa7185);
 }
 
 static void saa7185_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_saa7185);
+	i2c_del_driver(&i2c_driver_saa7185);
 }
 
 module_init(saa7185_init);

