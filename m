Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSH0Wvw>; Tue, 27 Aug 2002 18:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSH0Wvv>; Tue, 27 Aug 2002 18:51:51 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:1297 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316541AbSH0Wvq>;
	Tue, 27 Aug 2002 18:51:46 -0400
Date: Tue, 27 Aug 2002 18:48:07 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] repost 2.5.32 : [i2c] drivers/video/media/adv7175.c
Message-ID: <Pine.LNX.4.44.0208271844560.899-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
  The following series of patches (in the next few emails) contain the 
i2c-old --> i2c updates for the drivers located in drivers/video/media/* . 
These patches have been in the 2.5.x-dj series for a while now without any 
problems reported (but haven't been merged yet). The individual driver 
patches were created by either myself or Albert Cranford. Please review for 
inclusion. Thanks.

Regards,
Frank

--- drivers/media/video/adv7175.c.old	Fri Jul  5 11:23:09 2002
+++ drivers/media/video/adv7175.c	Fri Jul  5 11:24:54 2002
@@ -45,7 +45,7 @@
 #include <linux/version.h>
 #include <asm/uaccess.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 
 #include <linux/video_encoder.h>
 
@@ -55,28 +55,15 @@
 #define DEBUG(x...)
 #endif
 
-/* ----------------------------------------------------------------------- */
+#define I2C_ADV7175	0xd4
+#define I2C_ADV7176	0x54
 
-struct adv7175 {
-	struct i2c_bus *bus;
-	int addr;
-	unsigned char reg[128];
-
-	int norm;
-	int input;
-	int enable;
-	int bright;
-	int contrast;
-	int hue;
-	int sat;
-};
-
-#define   I2C_ADV7175        0xd4
-#define   I2C_ADV7176        0x54
+#define IF_NAME		"adv7175"
 
 static char adv7175_name[] = "adv7175";
 static char adv7176_name[] = "adv7176";
 static char unknown_name[] = "UNKNOWN";
+char *dname;
 
 #if (DEBUGLEVEL > 0)
 static char *inputs[] = { "pass_through", "play_back", "color_bar" };
@@ -85,64 +72,34 @@
 
 #define I2C_DELAY   10
 
-/* ----------------------------------------------------------------------- */
-
-static int adv7175_write(struct adv7175 *dev, unsigned char subaddr, unsigned char data)
-{
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
-}
+static unsigned short normal_i2c[] = {I2C_ADV7175, I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+static unsigned short probe[2] = {I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short probe_range[2] = {I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short ignore[2] = {I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short ignore_range[2] = {I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short force[2] = {I2C_CLIENT_END, I2C_CLIENT_END};
+
+static struct i2c_client_address_data addr_data = {
+						normal_i2c, normal_i2c_range,
+						probe, probe_range,
+						ignore, ignore_range,
+						force};
+static struct i2c_client client_template;
 
-static unsigned char adv7175_read(struct adv7175 *dev, unsigned char subaddr)
-{
-	unsigned char data;
-
-	LOCK_I2C_BUS(dev->bus);
-
-	i2c_start(dev->bus);
-	i2c_sendbyte(dev->bus, dev->addr, I2C_DELAY);
-	i2c_sendbyte(dev->bus, subaddr, I2C_DELAY);
-	i2c_sendbyte(dev->bus, dev->addr + 1, I2C_DELAY);
-	data = i2c_readbyte(dev->bus, 1);
-	dev->reg[subaddr] = data;
-	i2c_stop(dev->bus);
-	UNLOCK_I2C_BUS(dev->bus);
-	return data;
-}
-
-static int adv7175_write_block(struct adv7175 *dev,
-			       unsigned const char *data, unsigned int len)
-{
-	int ack = 0;
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
+struct adv7175 {
+	struct i2c_client 	*client;
+	int 			addr;
+	unsigned char 		reg[128];
+	struct semaphore	lock;
+	int 			norm;
+	int 			input;
+	int 			enable;
+	int 			bright;
+	int 			contrast;
+	int 			hue;
+	int 			sat;
+};
 
 /* ----------------------------------------------------------------------- */
 // Output filter:  S-Video  Composite
@@ -203,65 +160,90 @@
 	0x06, 0x1a,		/* subc. phase */
 };
 
-static int adv7175_attach(struct i2c_device *device)
+static int adv717x_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
 {
-	int i;
 	struct adv7175 *encoder;
-	char *dname;
+	struct	i2c_client	*client;
+	int rv, i, x_common=39; /* x is number entries init_common - 1 */
 
-	MOD_INC_USE_COUNT;
+	printk(KERN_INFO "adv717x: video chip found.\n");
+	client=kmalloc(sizeof(*client), GFP_KERNEL);
+	if(client == NULL)
+		return -ENOMEM;
 
-	device->data = encoder = kmalloc(sizeof(struct adv7175), GFP_KERNEL);
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));
+
+	encoder = kmalloc(sizeof(*encoder), GFP_KERNEL);
 	if (encoder == NULL) {
-		MOD_DEC_USE_COUNT;
+		kfree(client);
 		return -ENOMEM;
 	}
 
-
-	memset(encoder, 0, sizeof(struct adv7175));
-	if ((device->addr == I2C_ADV7175) || (device->addr == (I2C_ADV7175 + 2))) {
+	memset(encoder, 0, sizeof(*encoder));
+	if ((encoder->addr == I2C_ADV7175) || (encoder->addr == (I2C_ADV7175 + 2))) {
 		dname = adv7175_name;
-	} else if ((device->addr == I2C_ADV7176) || (device->addr == (I2C_ADV7176 + 2))) {
+	} else if ((encoder->addr == I2C_ADV7176) || (encoder->addr == (I2C_ADV7176 + 2))) {
 		dname = adv7176_name;
 	} else {
 		// We should never get here!!!
 		dname = unknown_name;
 	}
-	strcpy(device->name, dname);
-	encoder->bus = device->bus;
-	encoder->addr = device->addr;
+	strcpy(client->name, dname);
+	init_MUTEX(&encoder->lock);
+	encoder->client = client;
+	client->data = encoder;
+	encoder->addr = addr;
 	encoder->norm = VIDEO_MODE_PAL;
 	encoder->input = 0;
 	encoder->enable = 1;
 
-	i = adv7175_write_block(encoder, init_common, sizeof(init_common));
-	if (i >= 0) {
-		i = adv7175_write(encoder, 0x07, TR0MODE | TR0RST);
-		i = adv7175_write(encoder, 0x07, TR0MODE);
-		i = adv7175_read(encoder, 0x12);
-		printk(KERN_INFO "%s_attach: %s rev. %d at 0x%02x\n",
-		       device->name, dname, i & 1, device->addr);
+	for (i=1; i<x_common; i++) {
+		rv = i2c_smbus_write_byte(client,init_common[i]);
+		if (rv < 0) {
+			printk(KERN_ERR "%s_attach: init error %d\n", client->name, rv);
+			break;
+		}
 	}
-	if (i < 0) {
-		printk(KERN_ERR "%s_attach: init error %d\n", device->name,
-		       i);
+
+	if (rv >= 0) {
+		i2c_smbus_write_byte_data(client,0x07, TR0MODE | TR0RST);
+		i2c_smbus_write_byte_data(client,0x07, TR0MODE);
+		i2c_smbus_read_byte_data(client,0x12);
+		printk(KERN_INFO "%s_attach: %s rev. %d at 0x%02x\n",
+		       client->name, dname, rv & 1, client->addr);
 	}
 
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
+
 	return 0;
 }
 
+static
+int adv717x_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, adv717x_attach);
+}
 
-static int adv7175_detach(struct i2c_device *device)
+
+static int adv717x_detach(struct i2c_client *client)
 {
-	kfree(device->data);
+	i2c_detach_client(client);
+	kfree(client->data);
+	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int adv7175_command(struct i2c_device *device, unsigned int cmd,
+static int adv717x_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct adv7175 *encoder = device->data;
+	struct adv7175 *encoder = client->data;
+	int i, x_ntsc=13, x_pal=13; 
+		/* x_ntsc is number of entries in init_ntsc -1 */
+		/* x_pal is number of entries in init_pal -1 */
 
 	switch (cmd) {
 
@@ -286,29 +268,21 @@
 				switch (iarg) {
 
 				case VIDEO_MODE_NTSC:
-					adv7175_write_block(encoder,
-							    init_ntsc,
-							    sizeof
-							    (init_ntsc));
+					for (i=1; i< x_ntsc; i++)
+						i2c_smbus_write_byte(client, init_ntsc[i]);
 					if (encoder->input == 0)
-						adv7175_write(encoder, 0x0d, 0x4f);	// Enable genlock
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+						i2c_smbus_write_byte_data(client,0x0d, 0x4f); // Enable genlock
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 					break;
 
 				case VIDEO_MODE_PAL:
-					adv7175_write_block(encoder,
-							    init_pal,
-							    sizeof
-							    (init_pal));
+					for (i=1; i< x_pal; i++)
+						i2c_smbus_write_byte(client, init_pal[i]);
 					if (encoder->input == 0)
-						adv7175_write(encoder, 0x0d, 0x4f);	// Enable genlock
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+						i2c_smbus_write_byte_data(client,0x0d, 0x4f); // Enable genlock
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 					break;
 
 				case VIDEO_MODE_SECAM:	// WARNING! ADV7176 does not support SECAM.
@@ -316,27 +290,23 @@
 					// it does not work due to genlock: when decoder
 					// is in SECAM and encoder in in PAL the subcarrier
 					// can not be syncronized with horizontal frequency)
-					adv7175_write_block(encoder,
-							    init_pal,
-							    sizeof
-							    (init_pal));
+					for (i=1; i< x_pal; i++)
+						i2c_smbus_write_byte(client, init_pal[i]);
 					if (encoder->input == 0)
-						adv7175_write(encoder, 0x0d, 0x49);	// Disable genlock
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+						i2c_smbus_write_byte_data(client,0x0d, 0x49); // Disable genlock
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 					break;
 				default:
 					printk(KERN_ERR
 					       "%s: illegal norm: %d\n",
-					       device->name, iarg);
+					       client->name, iarg);
 					return -EINVAL;
 
 				}
 				DEBUG(printk
 				      (KERN_INFO "%s: switched to %s\n",
-				       device->name, norms[iarg]));
+				       client->name, norms[iarg]));
 				encoder->norm = iarg;
 			}
 		}
@@ -354,51 +324,45 @@
 				switch (iarg) {
 
 				case 0:
-					adv7175_write(encoder, 0x01, 0x00);
-					adv7175_write(encoder, 0x0c, TR1CAPT);	/* TR1 */
+					i2c_smbus_write_byte_data(client, 0x01, 0x00);
+					i2c_smbus_write_byte_data(client, 0x0c, TR1CAPT);	/* TR1 */
 					if (encoder->norm ==
 					    VIDEO_MODE_SECAM)
-						adv7175_write(encoder, 0x0d, 0x49);	// Disable genlock
+						i2c_smbus_write_byte_data(client, 0x0d, 0x49);	// Disable genlock
 					else
-						adv7175_write(encoder, 0x0d, 0x4f);	// Enable genlock
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+						i2c_smbus_write_byte_data(client, 0x0d, 0x4f);	// Enable genlock
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE);
 					//udelay(10);
 					break;
 
 				case 1:
-					adv7175_write(encoder, 0x01, 0x00);
-					adv7175_write(encoder, 0x0c, TR1PLAY);	/* TR1 */
-					adv7175_write(encoder, 0x0d, 0x49);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+					i2c_smbus_write_byte_data(client, 0x01, 0x00);
+					i2c_smbus_write_byte_data(client, 0x0c, TR1PLAY);	/* TR1 */
+					i2c_smbus_write_byte_data(client, 0x0d, 0x49);
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE);
 					//udelay(10);
 					break;
 
 				case 2:
-					adv7175_write(encoder, 0x01, 0x80);
-					adv7175_write(encoder, 0x0d, 0x49);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE | TR0RST);
-					adv7175_write(encoder, 0x07,
-						      TR0MODE);
+					i2c_smbus_write_byte_data(client, 0x01, 0x80);
+					i2c_smbus_write_byte_data(client, 0x0d, 0x49);
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE | TR0RST);
+					i2c_smbus_write_byte_data(client, 0x07, TR0MODE);
 					//udelay(10);
 					break;
 
 				default:
 					printk(KERN_ERR
 					       "%s: illegal input: %d\n",
-					       device->name, iarg);
+					       client->name, iarg);
 					return -EINVAL;
 
 				}
 				DEBUG(printk
 				      (KERN_INFO "%s: switched to %s\n",
-				       device->name, inputs[iarg]));
+				       client->name, inputs[iarg]));
 				encoder->input = iarg;
 			}
 		}
@@ -420,7 +384,7 @@
 			int *iarg = arg;
 
 			encoder->enable = !!*iarg;
-			adv7175_write(encoder, 0x61,
+			i2c_smbus_write_byte_data(client, 0x61,
 				      (encoder->
 				       reg[0x61] & 0xbf) | (encoder->
 							    enable ? 0x00 :
@@ -439,38 +403,45 @@
 
 static struct i2c_driver i2c_driver_adv7175 = {
 	"adv7175",		/* name */
-	I2C_DRIVERID_VIDEOENCODER,	/* ID */
-	I2C_ADV7175, I2C_ADV7175 + 3,
-
-	adv7175_attach,
-	adv7175_detach,
-	adv7175_command
+	I2C_DRIVERID_ADV717x,	/* ID */
+	I2C_DF_NOTIFY, //I2C_ADV7175, I2C_ADV7175 + 3,
+	adv717x_probe,
+	adv717x_detach,
+	adv717x_command
 };
 
 static struct i2c_driver i2c_driver_adv7176 = {
-	"adv7175",		/* name */
-	I2C_DRIVERID_VIDEOENCODER,	/* ID */
-	I2C_ADV7176, I2C_ADV7176 + 3,
+	"adv7176",		/* name */
+	I2C_DRIVERID_ADV717x,	/* ID */
+	I2C_DF_NOTIFY, //I2C_ADV7176, I2C_ADV7176 + 3,
+	adv717x_probe,
+	adv717x_detach,
+	adv717x_command
+};
 
-	adv7175_attach,
-	adv7175_detach,
-	adv7175_command
+static struct i2c_client client_template = {
+	"adv7175_client",
+	-1,
+	0,
+	0,
+	NULL,
+	&i2c_driver_adv7175
 };
 
-static int adv7175_init(void)
+static int adv717x_init(void)
 {
 	int res_adv7175 = 0, res_adv7176 = 0;
-	res_adv7175 = i2c_register_driver(&i2c_driver_adv7175);
-	res_adv7176 = i2c_register_driver(&i2c_driver_adv7176);
+	res_adv7175 = i2c_add_driver(&i2c_driver_adv7175);
+	res_adv7176 = i2c_add_driver(&i2c_driver_adv7176);
 	return (res_adv7175 | res_adv7176);	// Any idea how to make it better?
 }
 
-static void adv7175_exit(void)
+static void adv717x_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_adv7176);
-	i2c_unregister_driver(&i2c_driver_adv7175);
+	i2c_del_driver(&i2c_driver_adv7176);
+	i2c_del_driver(&i2c_driver_adv7175);
 }
 
-module_init(adv7175_init);
-module_exit(adv7175_exit);
+module_init(adv717x_init);
+module_exit(adv717x_exit);
 MODULE_LICENSE("GPL");
 



