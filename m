Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSH0XHW>; Tue, 27 Aug 2002 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSH0XHW>; Tue, 27 Aug 2002 19:07:22 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:527 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316853AbSH0XHR>;
	Tue, 27 Aug 2002 19:07:17 -0400
Date: Tue, 27 Aug 2002 18:50:12 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.32 (repost) : [i2c] drivers/media/video/bt819.c 
Message-ID: <Pine.LNX.4.44.0208271849260.899-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
  Here's the bt819 i2c-old --> i2c patch. Please review for inclusion.

Regards,
Frank

--- drivers/media/video/bt819.c.old	Sun May 26 14:07:35 2002
+++ drivers/media/video/bt819.c	Thu Jul  4 16:41:25 2002
@@ -39,15 +39,32 @@
 
 #include <linux/videodev.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 #include <linux/video_decoder.h>
 
 #define DEBUG(x)       x	/* Debug driver */
 
 /* ----------------------------------------------------------------------- */
 
+static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };	
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
 struct bt819 {
-	struct i2c_bus *bus;
+	struct i2c_client *client;
 	int addr;
 	unsigned char reg[32];
 
@@ -59,6 +76,7 @@
 	int contrast;
 	int hue;
 	int sat;
+	struct semaphore lock;
 };
 
 struct timing {
@@ -82,71 +100,17 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt819_write(struct bt819 *dev, unsigned char subaddr,
-		       unsigned char data)
+static int bt819_probe(struct i2c_adapter *adap)
 {
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
+	return i2c_probe(adap, &addr_data, bt819_attach);
 }
 
 static int bt819_setbit(struct bt819 *dev, int subaddr, int bit, int data)
 {
-	return bt819_write(dev, subaddr, (dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
-}
-
-static int bt819_write_block(struct bt819 *dev, unsigned const char *data,
-			     unsigned int len)
-{
-	int ack;
-	unsigned subaddr;
-
-	ack = 0;
-	while (len > 1) {
-		LOCK_I2C_BUS(dev->bus);
-		i2c_start(dev->bus);
-		i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-		ack = i2c_sendbyte(dev->bus, (subaddr = *data++), I2C_DELAY);
-		ack = i2c_sendbyte(dev->bus, (dev->reg[subaddr] = *data++),
-				 I2C_DELAY);
-		len -= 2;
-		while (len > 1 && *data == ++subaddr) {
-			data++;
-			ack =
-			    i2c_sendbyte(dev->bus, (dev->reg[subaddr] = *data++), I2C_DELAY);
-			len -= 2;
-		}
-		i2c_stop(dev->bus);
-		UNLOCK_I2C_BUS(dev->bus);
-	}
-	return ack;
-}
-
-static int bt819_read(struct bt819 *dev, unsigned char subaddr)
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
+	return i2c_smbus_write_byte_data(dev->client, subaddr, (dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
 }
 
-static int bt819_init(struct i2c_device *device)
+static int bt819_init(struct i2c_client *client)
 {
 	struct bt819 *decoder;
 
@@ -178,7 +142,7 @@
 
 	struct timing *timing;
 
-	decoder = device->data;
+	decoder = client->data;
 	timing = &timing_data[decoder->norm];
 
 	init[3 * 2 - 1] = (((timing->vdelay >> 8) & 0x03) << 6) |
@@ -192,31 +156,38 @@
 	init[8 * 2 - 1] = timing->hscale >> 8;
 	init[9 * 2 - 1] = timing->hscale & 0xff;
 
-	bt819_write(decoder, 0x1f, 0x00);
+	i2c_smbus_write_byte_data(client, 0x1f, 0x00);
 	mdelay(1);
-	return bt819_write_block(decoder, init, sizeof(init));
+	return i2c_master_send(client, init, sizeof(init));
 
 }
 
 /* ----------------------------------------------------------------------- */
 
-static int bt819_attach(struct i2c_device *device)
+static int bt819_attach(struct i2c_adapter *adap, int addr , unsigned long flags, int kind)
 {
 	int i;
 	struct bt819 *decoder;
+	struct i2c_client *client;
 
-	MOD_INC_USE_COUNT;
-
-	device->data = decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if(client == NULL)
+		return -ENOMEM;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));
+	
+	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
 	if (decoder == NULL) {
 		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
 	memset(decoder, 0, sizeof(struct bt819));
-	strcpy(device->name, "bt819");
-	decoder->bus = device->bus;
-	decoder->addr = device->addr;
+	strcpy(client->name, "bt819");
+	client->data = decoder;
+	decoder->client = client;
+	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
@@ -226,34 +197,39 @@
 	decoder->sat = 32768;
 	decoder->initialized = 0;
 
-	i = bt819_init(device);
+	i = bt819_init(client);
 	if (i < 0) {
 		printk(KERN_ERR "%s: bt819_attach: init status %d\n",
-		       decoder->bus->name, i);
+		       decoder->client->name, i);
 	} else {
 		printk(KERN_INFO "%s: bt819_attach: chip version %x\n",
-		       decoder->bus->name, bt819_read(decoder,
+		       decoder->client->name, i2c_smbus_read_byte_data(client,
 						      0x17) & 0x0f);
 	}
+	init_MUTEX(&decoder->lock);
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
 	return 0;
 }
 
-static int bt819_detach(struct i2c_device *device)
+static int bt819_detach(struct i2c_client *client)
 {
-	kfree(device->data);
+	i2c_detach_client(client);
+	kfree(client->data);
+	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int bt819_command(struct i2c_device *device, unsigned int cmd, void *arg)
+static int bt819_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	int temp;
 
-	struct bt819 *decoder = device->data;
+	struct bt819 *decoder = client->data;
 	//return 0;
 
 	if (!decoder->initialized) {	// First call to bt819_init could be
-		bt819_init(device);	// without #FRST = 0
+		bt819_init(client);	// without #FRST = 0
 		decoder->initialized = 1;
 	}
 
@@ -277,7 +253,7 @@
 			int status;
 			int res;
 
-			status = bt819_read(decoder, 0x00);
+			status = i2c_smbus_read_byte_data(client, 0x00);
 			res = 0;
 			if ((status & 0x80)) {
 				res |= DECODER_STATUS_GOOD;
@@ -302,7 +278,7 @@
 			*iarg = res;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: get status %x\n",
-				     decoder->bus->name, *iarg));
+				     decoder->client->name, *iarg));
 		}
 		break;
 
@@ -312,37 +288,38 @@
 			struct timing *timing;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set norm %x\n",
-				     decoder->bus->name, *iarg));
+				     decoder->client->name, *iarg));
 
 			if (*iarg == VIDEO_MODE_NTSC) {
 				bt819_setbit(decoder, 0x01, 0, 1);
 				bt819_setbit(decoder, 0x01, 1, 0);
-				bt819_write(decoder, 0x18, 0x68);
-				bt819_write(decoder, 0x19, 0x5d);
+				i2c_smbus_write_byte_data(client, 0x18, 0x68);
+				i2c_smbus_write_byte_data(client, 0x19, 0x5d);
 				//bt819_setbit(decoder, 0x1a,  5, 1);
 				timing = &timing_data[VIDEO_MODE_NTSC];
 			} else {
 				bt819_setbit(decoder, 0x01, 0, 1);
 				bt819_setbit(decoder, 0x01, 1, 1);
-				bt819_write(decoder, 0x18, 0x7f);
-				bt819_write(decoder, 0x19, 0x72);
+				i2c_smbus_write_byte_data(client, 0x18, 0x7f);
+				i2c_smbus_write_byte_data(client, 0x19, 0x72);
 				//bt819_setbit(decoder, 0x1a,  5, 0);
 				timing = &timing_data[VIDEO_MODE_PAL];
 			}
 
-			bt819_write(decoder, 0x03,
+			i2c_smbus_write_byte_data(client, 0x03,
 				    (((timing->vdelay >> 8) & 0x03) << 6) |
 				    (((timing->
 				       vactive >> 8) & 0x03) << 4) |
 				    (((timing->
 				       hdelay >> 8) & 0x03) << 2) |
 				    ((timing->hactive >> 8) & 0x03));
-			bt819_write(decoder, 0x04, timing->vdelay & 0xff);
-			bt819_write(decoder, 0x05, timing->vactive & 0xff);
-			bt819_write(decoder, 0x06, timing->hdelay & 0xff);
-			bt819_write(decoder, 0x07, timing->hactive & 0xff);
-			bt819_write(decoder, 0x08, timing->hscale >> 8);
-			bt819_write(decoder, 0x09, timing->hscale & 0xff);
+
+			i2c_smbus_write_byte_data(client, 0x04, timing->vdelay & 0xff);
+			i2c_smbus_write_byte_data(client, 0x05, timing->vactive & 0xff);
+			i2c_smbus_write_byte_data(client, 0x06, timing->hdelay & 0xff);
+			i2c_smbus_write_byte_data(client, 0x07, timing->hactive & 0xff);
+			i2c_smbus_write_byte_data(client, 0x08, timing->hscale >> 8);
+			i2c_smbus_write_byte_data(client, 0x09, timing->hscale & 0xff);
 			decoder->norm = *iarg;
 		}
 		break;
@@ -352,7 +329,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set input %x\n",
-				     decoder->bus->name, *iarg));
+				     decoder->client->name, *iarg));
 
 			if (*iarg < 0 || *iarg > 7) {
 				return -EINVAL;
@@ -377,7 +354,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set output %x\n",
-				     decoder->bus->name, *iarg));
+				     decoder->client->name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -393,7 +370,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt819: enable output %x\n",
-			       decoder->bus->name, *iarg));
+			       decoder->client->name, *iarg));
 
 			if (decoder->enable != enable) {
 				decoder->enable = enable;
@@ -414,21 +391,21 @@
 			DEBUG(printk
 			      (KERN_INFO
 			       "%s-bt819: set picture brightness %d contrast %d colour %d\n",
-			       decoder->bus->name, pic->brightness,
+			       decoder->client->name, pic->brightness,
 			       pic->contrast, pic->colour));
 
 
 			if (decoder->bright != pic->brightness) {
 				/* We want -128 to 127 we get 0-65535 */
 				decoder->bright = pic->brightness;
-				bt819_write(decoder, 0x0a,
+				i2c_smbus_write_byte_data(client, 0x0a,
 					    (decoder->bright >> 8) - 128);
 			}
 
 			if (decoder->contrast != pic->contrast) {
 				/* We want 0 to 511 we get 0-65535 */
 				decoder->contrast = pic->contrast;
-				bt819_write(decoder, 0x0c,
+				i2c_smbus_write_byte_data(client, 0x0c,
 					    (decoder->
 					     contrast >> 7) & 0xff);
 				bt819_setbit(decoder, 0x0b, 2,
@@ -439,14 +416,14 @@
 			if (decoder->sat != pic->colour) {
 				/* We want 0 to 511 we get 0-65535 */
 				decoder->sat = pic->colour;
-				bt819_write(decoder, 0x0d,
+				i2c_smbus_write_byte_data(client, 0x0d,
 					    (decoder->sat >> 7) & 0xff);
 				bt819_setbit(decoder, 0x0b, 1,
 					     ((decoder->
 					       sat >> 15) & 0x01));
 
 				temp = (decoder->sat * 201) / 237;
-				bt819_write(decoder, 0x0e,
+				i2c_smbus_write_byte_data(client, 0x0e,
 					    (temp >> 7) & 0xff);
 				bt819_setbit(decoder, 0x0b, 0,
 					     (temp >> 15) & 0x01);
@@ -455,7 +432,7 @@
 			if (decoder->hue != pic->hue) {
 				/* We want -128 to 127 we get 0-65535 */
 				decoder->hue = pic->hue;
-				bt819_write(decoder, 0x0f,
+				i2c_smbus_write_byte_data(client, 0x0f,
 					    128 - (decoder->hue >> 8));
 			}
 		}
@@ -472,22 +449,30 @@
 
 static struct i2c_driver i2c_driver_bt819 = {
 	"bt819",		/* name */
-	I2C_DRIVERID_VIDEODECODER,	/* ID */
-	I2C_BT819, I2C_BT819 + 1,
-
-	bt819_attach,
+	I2C_DRIVERID_BT819,	/* ID */
+	I2C_DF_NOTIFY,
+	bt819_probe,
 	bt819_detach,
 	bt819_command
 };
 
+static struct i2c_client client_template = {
+	"bt819_client",
+	-1,
+	0,
+	0,
+	NULL,
+	&i2c_driver_bt819
+};
+
 static int bt819_setup(void)
 {
-	return i2c_register_driver(&i2c_driver_bt819);
+	return i2c_add_driver(&i2c_driver_bt819);
 }
 
 static void bt819_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_bt819);
+	i2c_del_driver(&i2c_driver_bt819);
 }
 
 module_init(bt819_setup);



