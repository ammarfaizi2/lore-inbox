Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSFLQue>; Wed, 12 Jun 2002 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSFLQud>; Wed, 12 Jun 2002 12:50:33 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:23045 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317304AbSFLQu0>;
	Wed, 12 Jun 2002 12:50:26 -0400
Message-ID: <3D077C26.1090800@si.rr.com>
Date: Wed, 12 Jun 2002 12:51:50 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mds@paradyne.com, alan@lxorguk.linux.org.uk
Subject: [PATCH] 2.5.21: i2c conversion for drivers/media/video/saa7110.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   Here's what I propose as a complete conversion from the old i2c-old 
interface to the current one (against 2.5.21). I used 
drivers/media/video/saa5249.c as a basis for the conversion, as well as 
reviewing the i2c documentation. Let me know what you think.
Regards,
Frank

--- drivers/media/video/saa7110.c.old	Sun May 26 14:07:36 2002
+++ drivers/media/video/saa7110.c	Wed Jun 12 01:58:52 2002
@@ -26,7 +26,7 @@
  #include <asm/io.h>
  #include <asm/uaccess.h>

-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
  #include <linux/videodev.h>
  #include "linux/video_decoder.h"

@@ -37,13 +37,31 @@

  #define	I2C_SAA7110 
	0x9C	/* or 0x9E */

+#define IF_NAME	"saa7110"
  #define	I2C_DELAY 
	10	/* 10 us or 100khz */

+static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+ 
normal_i2c, normal_i2c_range,
+ 
probe, probe_range,
+ 
ignore, ignore_range,
+ 
force
+};
+
+static struct i2c_client client_template;
+
  struct saa7110 {
- 
struct 
i2c_bus 
*bus;
+ 
struct i2c_client *client;
  	int 
	addr;
  	unsigned char	reg[36];
-
+ 
struct semaphore lock;
  	int 
	norm;
  	int 
	input;
  	int 
	enable;
@@ -54,67 +72,10 @@
  };

  /* 
----------------------------------------------------------------------- */
-/* I2C support functions						   */
-/* 
----------------------------------------------------------------------- */
-static
-int saa7110_write(struct saa7110 *decoder, unsigned char subaddr, 
unsigned char data)
-{
- 
int ack;
-
- 
LOCK_I2C_BUS(decoder->bus);
- 
i2c_start(decoder->bus);
- 
i2c_sendbyte(decoder->bus, decoder->addr, I2C_DELAY);
- 
i2c_sendbyte(decoder->bus, subaddr, I2C_DELAY);
- 
ack = i2c_sendbyte(decoder->bus, data, I2C_DELAY);
- 
i2c_stop(decoder->bus);
- 
decoder->reg[subaddr] = data;
- 
UNLOCK_I2C_BUS(decoder->bus);
- 
return ack;
-}
-
-static
-int saa7110_write_block(struct saa7110* decoder, unsigned const char 
*data, unsigned int len)
-{
- 
unsigned subaddr = *data;
-
- 
LOCK_I2C_BUS(decoder->bus);
-        i2c_start(decoder->bus);
-        i2c_sendbyte(decoder->bus,decoder->addr,I2C_DELAY);
- 
while (len-- > 0) {
-                if (i2c_sendbyte(decoder->bus,*data,0)) {
-                        i2c_stop(decoder->bus);
-                        UNLOCK_I2C_BUS(decoder->bus);
-                        return -EAGAIN;
-                }
- 
	decoder->reg[subaddr++] = *data++;
-        }
- 
i2c_stop(decoder->bus);
- 
UNLOCK_I2C_BUS(decoder->bus);
-
- 
return 0;
-}
-
-static
-int saa7110_read(struct saa7110* decoder)
-{
- 
int data;
-
- 
LOCK_I2C_BUS(decoder->bus);
- 
i2c_start(decoder->bus);
- 
i2c_sendbyte(decoder->bus, decoder->addr, I2C_DELAY);
- 
i2c_start(decoder->bus);
- 
i2c_sendbyte(decoder->bus, decoder->addr | 1, I2C_DELAY);
- 
data = i2c_readbyte(decoder->bus, 1);
- 
i2c_stop(decoder->bus);
- 
UNLOCK_I2C_BUS(decoder->bus);
- 
return data;
-}
-
-/* 
----------------------------------------------------------------------- */
  /* SAA7110 functions							   */
  /* 
----------------------------------------------------------------------- */
  static
-int saa7110_selmux(struct i2c_device *device, int chan)
+int saa7110_selmux(struct i2c_client *client, int chan)
  {
  static	const unsigned char modes[9][8] = {
  /* mode 0 */	{ 0x00, 0xD9, 0x17, 0x40, 0x03, 0x44, 0x75, 0x16 },
@@ -126,61 +87,60 @@
  /* mode 6 */	{ 0x80, 0x59, 0x17, 0x42, 0xA3, 0x44, 0x75, 0x12 },
  /* mode 7 */	{ 0x80, 0x9A, 0x17, 0xB1, 0x13, 0x60, 0xB5, 0x14 },
  /* mode 8 */	{ 0x80, 0x3C, 0x27, 0xC1, 0x23, 0x44, 0x75, 0x21 } };
- 
struct saa7110* decoder = device->data;
  	const unsigned char* ptr = modes[chan];

- 
saa7110_write(decoder,0x06,ptr[0]); 
/* Luminance control	*/
- 
saa7110_write(decoder,0x20,ptr[1]); 
/* Analog Control #1	*/
- 
saa7110_write(decoder,0x21,ptr[2]); 
/* Analog Control #2	*/
- 
saa7110_write(decoder,0x22,ptr[3]); 
/* Mixer Control #1	*/
- 
saa7110_write(decoder,0x2C,ptr[4]); 
/* Mixer Control #2	*/
- 
saa7110_write(decoder,0x30,ptr[5]); 
/* ADCs gain control	*/
- 
saa7110_write(decoder,0x31,ptr[6]); 
/* Mixer Control #3	*/
- 
saa7110_write(decoder,0x21,ptr[7]); 
/* Analog Control #2	*/
+ 
i2c_smbus_write_byte(client,0x06,ptr[0]); 
/* Luminance control	*/
+ 
i2c_smbus_write_byte(client,0x20,ptr[1]); 
/* Analog Control #1	*/
+ 
i2c_smbus_write_byte(client,0x21,ptr[2]); 
/* Analog Control #2	*/
+ 
i2c_smbus_write_byte(client,0x22,ptr[3]); 
/* Mixer Control #1	*/
+ 
i2c_smbus_write_byte(client,0x2C,ptr[4]); 
/* Mixer Control #2	*/
+ 
i2c_smbus_write_byte(client,0x30,ptr[5]); 
/* ADCs gain control	*/
+ 
i2c_smbus_write_byte(client,0x31,ptr[6]); 
/* Mixer Control #3	*/
+ 
i2c_smbus_write_byte(client,0x21,ptr[7]); 
/* Analog Control #2	*/

  	return 0;
  }

  static
-int determine_norm(struct i2c_device* dev)
+int determine_norm(struct i2c_client* client)
  {
- 
struct 
saa7110* decoder = dev->data;
+ 
struct 
saa7110* decoder = client->data;
  	int	status;

  	/* mode changed, start automatic detection */
- 
status = saa7110_read(decoder);
+ 
status = i2c_smbus_read_byte(client);
  	if ((status & 3) == 0) {
- 
	saa7110_write(decoder,0x06,0x80);
+ 
	i2c_smbus_write_byte(client,0x06,0x80);
  		if (status & 0x20) {
- 
		DEBUG(printk(KERN_INFO "%s: norm=bw60\n",dev->name));
- 
		saa7110_write(decoder,0x2E,0x81);
+ 
		DEBUG(printk(KERN_INFO "%s: norm=bw60\n",adp->name));
+ 
		i2c_smbus_write_byte(client,0x2E,0x81);
  	 
	return VIDEO_MODE_NTSC;
  		}
- 
	DEBUG(printk(KERN_INFO "%s: norm=bw50\n",dev->name));
- 
	saa7110_write(decoder,0x2E,0x9A);
+ 
	DEBUG(printk(KERN_INFO "%s: norm=bw50\n",adp->name));
+ 
	i2c_smbus_write_byte(client,0x2E,0x9A);
  		return VIDEO_MODE_PAL;
  	}

- 
saa7110_write(decoder,0x06,0x00);
+ 
i2c_smbus_write_byte(client,0x06,0x00);
  	if (status & 0x20) {	/* 60Hz */
- 
	DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",dev->name));
- 
	saa7110_write(decoder,0x0D,0x06);
- 
	saa7110_write(decoder,0x11,0x2C);
- 
	saa7110_write(decoder,0x2E,0x81);
+ 
	DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",adp->name));
+ 
	i2c_smbus_write_byte(client,0x0D,0x06);
+ 
	i2c_smbus_write_byte(client,0x11,0x2C);
+ 
	i2c_smbus_write_byte(client,0x2E,0x81);
  		return VIDEO_MODE_NTSC;
  	}

  	/* 50Hz -> PAL/SECAM */
- 
saa7110_write(decoder,0x0D,0x06);
- 
saa7110_write(decoder,0x11,0x59);
- 
saa7110_write(decoder,0x2E,0x9A);
+ 
i2c_smbus_write_byte(client,0x0D,0x06);
+ 
i2c_smbus_write_byte(client,0x11,0x59);
+ 
i2c_smbus_write_byte(client,0x2E,0x9A);

  	mdelay(150);	/* pause 150 ms */

- 
status = saa7110_read(decoder);
+ 
status = i2c_smbus_read_byte(client);
  	if ((status & 0x03) == 0x01) {
  		DEBUG(printk(KERN_INFO "%s: norm=secam\n",dev->name));
- 
	saa7110_write(decoder,0x0D,0x07);
+ 
	i2c_smbus_write_byte(client,0x0D,0x07);
  		return VIDEO_MODE_SECAM;
  	}
  	DEBUG(printk(KERN_INFO "%s: norm=pal\n",dev->name));
@@ -188,7 +148,7 @@
  }

  static
-int saa7110_attach(struct i2c_device *device)
+int saa7110_attach(struct i2c_adapter *adap, int  addr, unsigned short 
flags, int kind)
  {
  static	const unsigned char initseq[] = {
  	     0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF0, 0x00, 0x00,
@@ -198,20 +158,27 @@
  		0xD9, 0x17, 0x40, 0x41, 0x80, 0x41, 0x80, 0x4F,
  		0xFE, 0x01, 0xCF, 0x0F, 0x03, 0x01, 0x81, 0x03,
  		0x40, 0x75, 0x01, 0x8C, 0x03};
- 
struct 
saa7110* 
decoder;
+ 
struct 
saa7110 
*decoder;
+ 
struct i2c_client *client;
  	int 
		rv;
-
- 
device->data = decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
- 
if (device->data == 0)
+ 
client=kmalloc(sizeof(*client), GPF_KERNEL);
+ 
if(client == NULL)
  		return -ENOMEM;
-
- 
MOD_INC_USE_COUNT;
+ 
client_template.adapter = adap;
+ 
client_template.addr = addr;
+ 
memcpy(client, &client_template, sizeof(*client));
+
+ 
decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
+ 
if (decoder == NULL) {
+ 
	kfree(client);
+ 
	return -ENOMEM;
+ 
	}

  	/* clear our private data */
- 
memset(decoder, 0, sizeof(struct saa7110));
- 
strcpy(device->name, "saa7110");
- 
decoder->bus = device->bus;
- 
decoder->addr = device->addr;
+ 
memset(decoder, 0, sizeof(*decoder));
+ 
strcpy(client->name, IF_NAME);
+ 
decoder->client = client;
+ 
decoder->addr = addr;
  	decoder->norm = VIDEO_MODE_PAL;
  	decoder->input = 0;
  	decoder->enable = 1;
@@ -220,38 +187,50 @@
  	decoder->hue = 32768;
  	decoder->sat = 32768;

- 
rv = saa7110_write_block(decoder, initseq, sizeof(initseq));
+ 
rv = i2c_smbus_write_block_data(client, initseq, sizeof(initseq));
  	if (rv < 0)
- 
	printk(KERN_ERR "%s_attach: init status %d\n", device->name, rv);
+ 
	printk(KERN_ERR "%s_attach: init status %d\n", client->name, rv);
  	else {
- 
	saa7110_write(decoder,0x21,0x16);
- 
	saa7110_write(decoder,0x0D,0x04);
- 
	DEBUG(printk(KERN_INFO "%s_attach: chip version %x\n", device->name, 
saa7110_read(decoder)));
- 
	saa7110_write(decoder,0x0D,0x06);
+ 
	i2c_smbus_write_byte(client,0x21,0x16);
+ 
	i2c_smbus_write_byte(client,0x0D,0x04);
+ 
	DEBUG(printk(KERN_INFO "%s_attach: chip version %x\n", client->name, 
i2c_smbus_read_byte(client)));
+ 
	i2c_smbus_write_byte(client,0x0D,0x06);
  	}

+ 
init_MUTEX(&decoder->lock);
+ 
i2c_attach_client(client);
+ 
MOD_INC_USE_COUNT;
  	/* setup and implicit mode 0 select has been performed */
  	return 0;
  }

+static
+int saa_7110_probe(struct i2c_adapter *adap)
+{
+ 
return i2c_probe(adap, &addr_data, saa7110_attach);
+}
+
  static
-int saa7110_detach(struct i2c_device *device)
+int saa7110_detach(struct i2c_client *client)
  {
- 
struct saa7110* decoder = device->data;
+ 
struct saa7110* decoder = client->data;

- 
DEBUG(printk(KERN_INFO "%s_detach\n",device->name));
+ 
i2c_detach_client(client);
+
+ 
DEBUG(printk(KERN_INFO "%s_detach\n",client->name));

  	/* stop further output */
- 
saa7110_write(decoder,0x0E,0x00);
+ 
i2c_smbus_write_byte(client,0x0E,0x00);

- 
kfree(device->data);
+ 
kfree(decoder);
+ 
kfree(client);

  	MOD_DEC_USE_COUNT;
  	return 0;
  }

  static
-int saa7110_command(struct i2c_device *device, unsigned int cmd, void *arg)
+int saa7110_command(struct i2c_client *device, unsigned int cmd, void *arg)
  {
  	struct saa7110* decoder = device->data;
  	int	v;
@@ -276,7 +255,7 @@
  	 
	int status;
  	 
	int res = 0;

- 
		status = i2c_read(device->bus,device->addr|1);
+ 
		status = i2c_master_send(device,device->addr|1);
  	 
	if (status & 0x40)
  	 
		res |= DECODER_STATUS_GOOD;
  	 
	if (status & 0x03)
@@ -301,23 +280,23 @@
  		v = *(int*)arg;
  		if (decoder->norm != v) {
  	 
	decoder->norm = v;
- 
		saa7110_write(decoder, 0x06, 0x00);
+ 
		i2c_smbus_write_byte(client, 0x06, 0x00);
  	 
	switch (v) {
  	 
	 case VIDEO_MODE_NTSC:
- 
			saa7110_write(decoder, 0x0D, 0x06);
- 
			saa7110_write(decoder, 0x11, 0x2C);
- 
			saa7110_write(decoder, 0x30, 0x81);
- 
			saa7110_write(decoder, 0x2A, 0xDF);
+ 
			i2c_smbus_write_byte(client, 0x0D, 0x06);
+ 
			i2c_smbus_write_byte(client, 0x11, 0x2C);
+ 
			i2c_smbus_write_byte(client, 0x30, 0x81);
+ 
			i2c_smbus_write_byte(client, 0x2A, 0xDF);
  	 
		break;
  	 
	 case VIDEO_MODE_PAL:
- 
			saa7110_write(decoder, 0x0D, 0x06);
- 
			saa7110_write(decoder, 0x11, 0x59);
- 
			saa7110_write(decoder, 0x2E, 0x9A);
+ 
			i2c_smbus_write_byte(client, 0x0D, 0x06);
+ 
			i2c_smbus_write_byte(client, 0x11, 0x59);
+ 
			i2c_smbus_write_byte(client, 0x2E, 0x9A);
  	 
		break;
  	 
	 case VIDEO_MODE_SECAM:
- 
			saa7110_write(decoder, 0x0D, 0x07);
- 
			saa7110_write(decoder, 0x11, 0x59);
- 
			saa7110_write(decoder, 0x2E, 0x9A);
+ 
			i2c_smbus_write_byte(client, 0x0D, 0x07);
+ 
			i2c_smbus_write_byte(client, 0x11, 0x59);
+ 
			i2c_smbus_write_byte(client, 0x2E, 0x9A);
  	 
		break;
  	 
	 case VIDEO_MODE_AUTO:
  	 
		*(int*)arg = determine_norm(device);
@@ -349,7 +328,7 @@
  		v = *(int*)arg;
  		if (decoder->enable != v) {
  	 
	decoder->enable = v;
- 
		saa7110_write(decoder,0x0E, v ? 0x18 : 0x00);
+ 
		i2c_smbus_write_byte(client,0x0E, v ? 0x18 : 0x00);
  		}
  		break;

@@ -360,22 +339,22 @@
  	 
	if (decoder->bright != pic->brightness) {
  	 
		/* We want 0 to 255 we get 0-65535 */
  	 
		decoder->bright = pic->brightness;
- 
			saa7110_write(decoder, 0x19, decoder->bright >> 8);
+ 
			i2c_smbus_write_byte(client, 0x19, decoder->bright >> 8);
  	 
	}
  	 
	if (decoder->contrast != pic->contrast) {
  	 
		/* We want 0 to 127 we get 0-65535 */
  	 
		decoder->contrast = pic->contrast;
- 
			saa7110_write(decoder, 0x13, decoder->contrast >> 9);
+ 
			i2c_smbus_write_byte(client, 0x13, decoder->contrast >> 9);
  	 
	}
  	 
	if (decoder->sat != pic->colour) {
  	 
		/* We want 0 to 127 we get 0-65535 */
  	 
		decoder->sat = pic->colour;
- 
			saa7110_write(decoder, 0x12, decoder->sat >> 9);
+ 
			i2c_smbus_write_byte(client, 0x12, decoder->sat >> 9);
  	 
	}
  	 
	if (decoder->hue != pic->hue) {
  	 
		/* We want -128 to 127 we get 0-65535 */
  	 
		decoder->hue = pic->hue;
- 
			saa7110_write(decoder, 0x07, (decoder->hue>>8)-128);
+ 
			i2c_smbus_write_byte(client, 0x07, (decoder->hue>>8)-128);
  	 
	}
  		}
  		break;
@@ -402,24 +381,30 @@

  static struct i2c_driver i2c_driver_saa7110 =
  {
- 
"saa7110", 
		/* name */
-
+ 
IF_NAME, 
		/* name */
  	I2C_DRIVERID_VIDEODECODER,	/* in i2c.h */
- 
I2C_SAA7110, I2C_SAA7110+1,	/* Addr range */
-
- 
saa7110_attach,
+ 
I2C_DF_NOTIFY, 
/* Addr range */
+ 
saa7110_probe,
  	saa7110_detach,
  	saa7110_command
  };
+static struct i2c_client client_template = {
+ 
"saa7110_client",
+ 
-1,
+ 
0,
+ 
0,
+ 
NULL,
+ 
&i2c_driver_saa7110
+};

  static int saa7110_init(void)
  {
- 
return i2c_register_driver(&i2c_driver_saa7110);
+ 
return i2c_add_driver(&i2c_driver_saa7110);
  }

  static void saa7110_exit(void)
  {
- 
i2c_unregister_driver(&i2c_driver_saa7110);
+ 
i2c_del_driver(&i2c_driver_saa7110);
  }





