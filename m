Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265582AbSKACWW>; Thu, 31 Oct 2002 21:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265585AbSKACWW>; Thu, 31 Oct 2002 21:22:22 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:54924 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265582AbSKACWM>; Thu, 31 Oct 2002 21:22:12 -0500
Date: Thu, 31 Oct 2002 22:20:45 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <ac9410@attbi.com>, <dperks@ibm.net>
Subject: [PATCH] 2.5.45 : drivers/media/video/saa7111.c
Message-ID: <Pine.LNX.4.44.0210312217170.963-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This converts the saa7111 driver's i2c api from i2c-old --> i2c . This 
one was never converted (for some reason). Please review. 
Regards,
Frank

--- linux/drivers/media/video/saa7111.c.old	Sat Oct 19 12:04:53 2002
+++ linux/drivers/media/video/saa7111.c	Thu Oct 31 20:29:00 2002
@@ -34,7 +34,7 @@
 
 #include <linux/videodev.h>
 #include <linux/version.h>
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 
 #include <linux/video_decoder.h>
 
@@ -43,8 +43,9 @@
 /* ----------------------------------------------------------------------- */
 
 struct saa7111 {
-	struct i2c_bus *bus;
+	struct i2c_client *client;
 	int addr;
+	struct semaphore lock;
 	unsigned char reg[32];
 
 	int norm;
@@ -60,74 +61,29 @@
 
 #define   I2C_DELAY   10
 
-/* ----------------------------------------------------------------------- */
-
-static int saa7111_write(struct saa7111 *dev, unsigned char subaddr,
-			 unsigned char data)
-{
-	int ack;
-
-	LOCK_I2C_BUS(dev->bus);
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
-static int saa7111_write_block(struct saa7111 *dev,
-	       unsigned const char *data, unsigned int len)
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
-			ack =
-			    i2c_sendbyte(dev->bus,
-					 (dev->reg[subaddr] =
-					  *data++), I2C_DELAY);
-			len -= 2;
-		}
-		i2c_stop(dev->bus);
-		UNLOCK_I2C_BUS(dev->bus);
-	}
-	return ack;
-}
-
-static int saa7111_read(struct saa7111 *dev, unsigned char subaddr)
-{
-	int data;
-
-	LOCK_I2C_BUS(dev->bus);
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-	i2c_sendbyte(dev->bus, subaddr, I2C_DELAY);
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr | 1, I2C_DELAY);
-	data = i2c_readbyte(dev->bus, 1);
-	i2c_stop(dev->bus);
-	UNLOCK_I2C_BUS(dev->bus);
-	return data;
-}
+static unsigned short normal_i2c[] = { 34>>1, I2C_CLIENT_END };	
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };	
+static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };	
+
+static struct i2c_client_address_data addr_data = {
+	normal_i2c, normal_i2c_range,
+	probe, probe_range,
+	ignore, ignore_range,
+	force
+};
 
+static struct i2c_client client_template;
 /* ----------------------------------------------------------------------- */
 
-static int saa7111_attach(struct i2c_device *device)
+static int saa7111_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
 {
 	int i;
 	struct saa7111 *decoder;
-
+	struct i2c_client *client;
 	static const unsigned char init[] = {
 		0x00, 0x00,	/* 00 - ID byte */
 		0x01, 0x00,	/* 01 - reserved */
@@ -158,20 +114,25 @@
 		0x16, 0x00,	/* 16 - VBI */
 		0x17, 0x00,	/* 17 - VBI */
 	};
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if(client == NULL) 
+		return -ENOMEM;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));
 
-	MOD_INC_USE_COUNT;
-
-	device->data = decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
+	decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
 	if (decoder == NULL)
 	{
-		MOD_DEC_USE_COUNT;
+		kfree(client);
 		return -ENOMEM;
 	}
 
-	memset(decoder, 0, sizeof(struct saa7111));
-	strcpy(device->name, "saa7111");
-	decoder->bus = device->bus;
-	decoder->addr = device->addr;
+	memset(decoder, 0, sizeof(*decoder));
+	strcpy(client->name, "saa7111");
+	decoder->client = client;
+	client->data = decoder;
+	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
@@ -180,29 +141,38 @@
 	decoder->hue = 32768;
 	decoder->sat = 32768;
 
-	i = saa7111_write_block(decoder, init, sizeof(init));
+	i = i2c_master_send(client, init, sizeof(init));
 	if (i < 0) {
 		printk(KERN_ERR "%s_attach: init status %d\n",
-		       device->name, i);
+		       client->name, i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %x\n",
-		       device->name, saa7111_read(decoder, 0x00) >> 4);
+		       client->name, i2c_smbus_read_byte_data(client, 0x00) >> 4);
 	}
+	init_MUTEX(&decoder->lock);
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
 	return 0;
 }
+static int saa7111_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, saa7111_attach);
+}
 
-
-static int saa7111_detach(struct i2c_device *device)
+static int saa7111_detach(struct i2c_client *client)
 {
-	kfree(device->data);
+	struct saa7111 *decoder = client->data;
+	i2c_detach_client(client);
+	kfree(decoder);
+	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int saa7111_command(struct i2c_device *device, unsigned int cmd,
+static int saa7111_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct saa7111 *decoder = device->data;
+	struct saa7111 *decoder = client->data;
 
 	switch (cmd) {
 
@@ -214,11 +184,11 @@
 			for (i = 0; i < 32; i += 16) {
 				int j;
 
-				printk("KERN_DEBUG %s: %03x", device->name,
+				printk("KERN_DEBUG %s: %03x", client->name,
 				       i);
 				for (j = 0; j < 16; ++j) {
 					printk(" %02x",
-					       saa7111_read(decoder,
+					       i2c_smbus_read_byte_data(client,
 							    i + j));
 				}
 				printk("\n");
@@ -246,7 +216,7 @@
 			int status;
 			int res;
 
-			status = saa7111_read(decoder, 0x1f);
+			status = i2c_smbus_read_byte_data(client, 0x1f);
 			res = 0;
 			if ((status & (1 << 6)) == 0) {
 				res |= DECODER_STATUS_GOOD;
@@ -281,19 +251,19 @@
 			switch (*iarg) {
 
 			case VIDEO_MODE_NTSC:
-				saa7111_write(decoder, 0x08,
+				i2c_smbus_write_byte_data(client, 0x08,
 					      (decoder->
 					       reg[0x08] & 0x3f) | 0x40);
 				break;
 
 			case VIDEO_MODE_PAL:
-				saa7111_write(decoder, 0x08,
+				i2c_smbus_write_byte_data(client, 0x08,
 					      (decoder->
 					       reg[0x08] & 0x3f) | 0x00);
 				break;
 
 			case VIDEO_MODE_AUTO:
-				saa7111_write(decoder, 0x08,
+				i2c_smbus_write_byte_data(client, 0x08,
 					      (decoder->
 					       reg[0x08] & 0x3f) | 0x80);
 				break;
@@ -317,12 +287,12 @@
 			if (decoder->input != *iarg) {
 				decoder->input = *iarg;
 				/* select mode */
-				saa7111_write(decoder, 0x02,
+				i2c_smbus_write_byte_data(client, 0x02,
 					      (decoder->
 					       reg[0x02] & 0xf8) |
 					      decoder->input);
 				/* bypass chrominance trap for modes 4..7 */
-				saa7111_write(decoder, 0x09,
+				i2c_smbus_write_byte_data(client, 0x09,
 					      (decoder->
 					       reg[0x09] & 0x7f) |
 					      ((decoder->input >
@@ -357,26 +327,26 @@
 //     If output should be enabled, we have to reverse the above.
 
 				if (decoder->enable) {
-					saa7111_write(decoder, 0x02,
+					i2c_smbus_write_byte_data(client, 0x02,
 						      (decoder->
 						       reg[0x02] & 0xf8) |
 						      decoder->input);
-					saa7111_write(decoder, 0x08,
+					i2c_smbus_write_byte_data(client, 0x08,
 						      (decoder->
 						       reg[0x08] & 0xfb));
-					saa7111_write(decoder, 0x11,
+					i2c_smbus_write_byte_data(client, 0x11,
 						      (decoder->
 						       reg[0x11] & 0xf3) |
 						      0x0c);
 				} else {
-					saa7111_write(decoder, 0x02,
+					i2c_smbus_write_byte_data(client, 0x02,
 						      (decoder->
 						       reg[0x02] & 0xf8));
-					saa7111_write(decoder, 0x08,
+					i2c_smbus_write_byte_data(client, 0x08,
 						      (decoder->
 						       reg[0x08] & 0xfb) |
 						      0x04);
-					saa7111_write(decoder, 0x11,
+					i2c_smbus_write_byte_data(client, 0x11,
 						      (decoder->
 						       reg[0x11] & 0xf3));
 				}
@@ -391,25 +361,25 @@
 			if (decoder->bright != pic->brightness) {
 				/* We want 0 to 255 we get 0-65535 */
 				decoder->bright = pic->brightness;
-				saa7111_write(decoder, 0x0a,
+				i2c_smbus_write_byte_data(client, 0x0a,
 					      decoder->bright >> 8);
 			}
 			if (decoder->contrast != pic->contrast) {
 				/* We want 0 to 127 we get 0-65535 */
 				decoder->contrast = pic->contrast;
-				saa7111_write(decoder, 0x0b,
+				i2c_smbus_write_byte_data(client, 0x0b,
 					      decoder->contrast >> 9);
 			}
 			if (decoder->sat != pic->colour) {
 				/* We want 0 to 127 we get 0-65535 */
 				decoder->sat = pic->colour;
-				saa7111_write(decoder, 0x0c,
+				i2c_smbus_write_byte_data(client, 0x0c,
 					      decoder->sat >> 9);
 			}
 			if (decoder->hue != pic->hue) {
 				/* We want -128 to 127 we get 0-65535 */
 				decoder->hue = pic->hue;
-				saa7111_write(decoder, 0x0d,
+				i2c_smbus_write_byte_data(client, 0x0d,
 					      (decoder->hue - 32768) >> 8);
 			}
 		}
@@ -426,22 +396,30 @@
 
 static struct i2c_driver i2c_driver_saa7111 = {
 	"saa7111",		/* name */
-	I2C_DRIVERID_VIDEODECODER,	/* ID */
-	I2C_SAA7111, I2C_SAA7111 + 1,
-
-	saa7111_attach,
+	I2C_DRIVERID_SAA7111,	/* ID */
+	I2C_DF_NOTIFY,
+	saa7111_probe,
 	saa7111_detach,
 	saa7111_command
 };
 
+static struct i2c_client client_template = {
+	"saa7111_client",
+	-1,
+	0,
+	0,
+	NULL,
+	&i2c_driver_saa7111
+};
+
 static int saa7111_init(void)
 {
-	return i2c_register_driver(&i2c_driver_saa7111);
+	return i2c_add_driver(&i2c_driver_saa7111);
 }
 
 static void saa7111_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_saa7111);
+	i2c_del_driver(&i2c_driver_saa7111);
 }
 
 module_init(saa7111_init);
 

