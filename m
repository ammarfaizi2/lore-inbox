Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSFKFIB>; Tue, 11 Jun 2002 01:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFKFIB>; Tue, 11 Jun 2002 01:08:01 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:4358 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316826AbSFKFH7>;
	Tue, 11 Jun 2002 01:07:59 -0400
Date: Tue, 11 Jun 2002 00:46:06 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.21 : drivers/media/video/saa7110.c , convert to new i2c
Message-ID: <Pine.LNX.4.33.0206110036560.927-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch takes the first step to convert the saa7110.c 
driver from the old i2c interface to the current one. The next step 
will be to modify the *_read() and *_write() and *write_block() functions 
to fit the current API. Please review. Thanks. 

Regards,
Frank 

--- drivers/media/video/saa7110.c.old	Sun May 26 14:07:36 2002
+++ drivers/media/video/saa7110.c	Fri Jun  7 13:03:21 2002
@@ -26,7 +26,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
 #include <linux/videodev.h>
 #include "linux/video_decoder.h"
 
@@ -37,10 +37,28 @@
 
 #define	I2C_SAA7110		0x9C	/* or 0x9E */
 
+#define IF_NAME	"saa7110"
 #define	I2C_DELAY		10	/* 10 us or 100khz */
 
+static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	normal_i2c, normal_i2c_range,
+	probe, probe_range,
+	ignore, ignore_range,
+	force
+};
+
+static struct i2c_client client_template;
+
 struct saa7110 {
-	struct	i2c_bus	*bus;
+	struct i2c_client *client;
 	int		addr;
 	unsigned char	reg[36];
 
@@ -114,7 +132,7 @@
 /* SAA7110 functions							   */
 /* ----------------------------------------------------------------------- */
 static
-int saa7110_selmux(struct i2c_device *device, int chan)
+int saa7110_selmux(struct i2c_client *client, int chan)
 {
 static	const unsigned char modes[9][8] = {
 /* mode 0 */	{ 0x00, 0xD9, 0x17, 0x40, 0x03, 0x44, 0x75, 0x16 },
@@ -126,7 +144,7 @@
 /* mode 6 */	{ 0x80, 0x59, 0x17, 0x42, 0xA3, 0x44, 0x75, 0x12 },
 /* mode 7 */	{ 0x80, 0x9A, 0x17, 0xB1, 0x13, 0x60, 0xB5, 0x14 },
 /* mode 8 */	{ 0x80, 0x3C, 0x27, 0xC1, 0x23, 0x44, 0x75, 0x21 } };
-	struct saa7110* decoder = device->data;
+	struct saa7110* decoder = client->data;
 	const unsigned char* ptr = modes[chan];
 
 	saa7110_write(decoder,0x06,ptr[0]);	/* Luminance control	*/
@@ -142,9 +160,9 @@
 }
 
 static
-int determine_norm(struct i2c_device* dev)
+int determine_norm(struct i2c_client* client)
 {
-	struct	saa7110* decoder = dev->data;
+	struct	saa7110* decoder = client->data;
 	int	status;
 
 	/* mode changed, start automatic detection */
@@ -152,18 +170,18 @@
 	if ((status & 3) == 0) {
 		saa7110_write(decoder,0x06,0x80);
 		if (status & 0x20) {
-			DEBUG(printk(KERN_INFO "%s: norm=bw60\n",dev->name));
+			DEBUG(printk(KERN_INFO "%s: norm=bw60\n",adp->name));
 			saa7110_write(decoder,0x2E,0x81);
 			return VIDEO_MODE_NTSC;
 		}
-		DEBUG(printk(KERN_INFO "%s: norm=bw50\n",dev->name));
+		DEBUG(printk(KERN_INFO "%s: norm=bw50\n",adp->name));
 		saa7110_write(decoder,0x2E,0x9A);
 		return VIDEO_MODE_PAL;
 	}
 
 	saa7110_write(decoder,0x06,0x00);
 	if (status & 0x20) {	/* 60Hz */
-		DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",dev->name));
+		DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",adp->name));
 		saa7110_write(decoder,0x0D,0x06);
 		saa7110_write(decoder,0x11,0x2C);
 		saa7110_write(decoder,0x2E,0x81);
@@ -188,7 +206,7 @@
 }
 
 static
-int saa7110_attach(struct i2c_device *device)
+int saa7110_attach(struct i2c_adapter *adap, int  addr, unsigned short flags, int kind)
 {
 static	const unsigned char initseq[] = {
 	     0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF0, 0x00, 0x00,
@@ -198,20 +216,27 @@
 		0xD9, 0x17, 0x40, 0x41, 0x80, 0x41, 0x80, 0x4F,
 		0xFE, 0x01, 0xCF, 0x0F, 0x03, 0x01, 0x81, 0x03,
 		0x40, 0x75, 0x01, 0x8C, 0x03};
-	struct	saa7110*	decoder;
+	struct	saa7110	*decoder;
+	struct i2c_client *client;
 	int			rv;
-
-	device->data = decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
-	if (device->data == 0)
+	client=kmalloc(sizeof(*client), GPF_KERNEL);
+	if(client == NULL) 
 		return -ENOMEM;
-
-	MOD_INC_USE_COUNT;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+	memcpy(client, &client_template, sizeof(*client));
+
+	decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
+	if (decoder == NULL) {
+		kfree(client);
+		return -ENOMEM;
+		}
 
 	/* clear our private data */
-	memset(decoder, 0, sizeof(struct saa7110));
-	strcpy(device->name, "saa7110");
-	decoder->bus = device->bus;
-	decoder->addr = device->addr;
+	memset(decoder, 0, sizeof(*decoder));
+	strcpy(client->name, IF_NAME);
+	decoder->client = client;
+	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_PAL;
 	decoder->input = 0;
 	decoder->enable = 1;
@@ -230,28 +255,39 @@
 		saa7110_write(decoder,0x0D,0x06);
 	}
 
+	i2c_attach_client(client);
+	MOD_INC_USE_COUNT;
 	/* setup and implicit mode 0 select has been performed */
 	return 0;
 }
 
+static 
+int saa_7110_probe(struct i2c_adapter *adap) 
+{
+	return i2c_probe(adap, &addr_data, saa7110_attach);
+}
+
 static
-int saa7110_detach(struct i2c_device *device)
+int saa7110_detach(struct i2c_client *client)
 {
-	struct saa7110* decoder = device->data;
+	struct saa7110* decoder = client->data;
 
-	DEBUG(printk(KERN_INFO "%s_detach\n",device->name));
+	i2c_detach_client(client);
+
+	DEBUG(printk(KERN_INFO "%s_detach\n",client->name));
 
 	/* stop further output */
 	saa7110_write(decoder,0x0E,0x00);
 
-	kfree(device->data);
+	kfree(decoder);
+	kfree(client);
 
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 static
-int saa7110_command(struct i2c_device *device, unsigned int cmd, void *arg)
+int saa7110_command(struct i2c_client *device, unsigned int cmd, void *arg)
 {
 	struct saa7110* decoder = device->data;
 	int	v;
@@ -402,24 +438,30 @@
 
 static struct i2c_driver i2c_driver_saa7110 =
 {
-	"saa7110",			/* name */
-
+	IF_NAME,			/* name */
 	I2C_DRIVERID_VIDEODECODER,	/* in i2c.h */
-	I2C_SAA7110, I2C_SAA7110+1,	/* Addr range */
-
-	saa7110_attach,
+	I2C_DF_NOTIFY,	/* Addr range */
+	saa7110_probe,
 	saa7110_detach,
 	saa7110_command
 };
+static struct i2c_client client_template = {
+	"saa7110_client",
+	-1,
+	0,
+	0,
+	NULL,
+	&i2c_driver_saa7110
+};
 
 static int saa7110_init(void)
 {
-	return i2c_register_driver(&i2c_driver_saa7110);
+	return i2c_add_driver(&i2c_driver_saa7110);
 }
 
 static void saa7110_exit(void)
 {
-	i2c_unregister_driver(&i2c_driver_saa7110);
+	i2c_del_driver(&i2c_driver_saa7110);
 }
 
 

