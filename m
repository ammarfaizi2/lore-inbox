Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHGF1F>; Wed, 7 Aug 2002 01:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSHGF1F>; Wed, 7 Aug 2002 01:27:05 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:62704 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317024AbSHGFZw>; Wed, 7 Aug 2002 01:25:52 -0400
Message-ID: <3D50B034.A1DF2AE@attbi.com>
Date: Wed, 07 Aug 2002 01:29:24 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH]2.5.30 i2c updates 4/4 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please apply the following four patches that update
2.5.30 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New algorithm-i2c-algo-8xxx for MPC8XXX
o New algorithm-i2c-algo-ibm_ocp for IBM PPC 405
o New adapter-i2c-adap-ibm_ocp for IBM PPC 405
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-pcf-epp for PCF8584
o New adapter-i2c-pport for parallel port
o New adapter-i2c-rpx for embeded MPC8XX
o Replace depreciated cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- linux/Documentation/i2c/dev-interface.old   2002-07-20 15:11:08.000000000 -0400
+++ linux/Documentation/i2c/dev-interface       2002-06-15 13:11:28.000000000 -0400
@@ -87,7 +87,12 @@
 
 ioctl(file,I2C_TENBIT,long select)
   Selects ten bit addresses if select not equals 0, selects normal 7 bit
-  addresses if select equals 0.
+  addresses if select equals 0. Default 0.
+
+ioctl(file,I2C_PEC,long select)
+  Selects SMBus PEC (packet error checking) generation and verification
+  if select not equals 0, disables if select equals 0. Default 0.
+  Used only for SMBus transactions.
 
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/Documentation/i2c/i2c-old-porting     2002-07-11 19:46:11.000000000 -0400
@@ -0,0 +1,626 @@
+I2C Conversion Guide for I2C-old to the current I2C API
+July 2002
+For Linux Kernel v2.5.x
+Frank Davis <fdavis@si.rr.com>
+-------------------------------------------------------
+
+There exists several kernel drivers that are using an old version of the I2C
+API. These drivers need to be converted to the current (kernel 2.5.x) version.
+The following document provides a guideline to make the appropriate changes to
+the affected drivers. There maybe slight modifications to this guide that are 
+specific to the driver you are working on. If you see {driver_name}, replace 
+that with the respective name of the driver, such as saa7110.c , {driver_name} 
+= saa7110.
+
+-------------------------------------------------------
+
+Step 1: Include the right header file
+ 
+Perform the following change within the driver
+ 
+#include <linux/i2c-old.h> --> #include <linux/i2c.h>
+
+Step 2: Add and set the i2c modes
+
+Add the following code near the top of the driver
+
+static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned short probe[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short probe_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };    
+static unsigned short ignore[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data  = {
+       normal_i2c , normal_i2c_range,
+       probe , probe_range,
+       ignore , ignore_range,
+       force
+};
+
+static struct i2c_client client_template;
+
+Step 3: Modify the driver info struct
+
+Within the struct for the driver , such as struct {driver_name}  ,  make the 
+following change ,
+struct i2c_bus *bus --> struct i2c_client *client
+
+Make changes where this change affects references within the file.
+
+Add a semaphore to the driver struct (as above)
+
+struct semaphore lock 
+
+Step 5: Remove specific read and write functions
+
+Remove the driver specific write and read functions, usually in the form:
+{driver_name}_write , {driver_name}_read , {driver_name}_write_block , etc.
+
+Step 6: Update the write and read functions for the current I2C API
+
+Replace all references of {driver_name}_write with i2c_smbus_write_byte_data
+Replace all references of {driver_name}_read with i2c_smbus_read_byte_data or
+i2c_smbus_read_byte , depending on args passed in.
+
+** Ensure that these functions pass in the i2c_client *client , NOT the
+decoder/encoder that was passed in the driver specific write and read
+functions. 
+ 
+Step 7: Modify the driver's attach function
+
+Change the driver attach function prototype :
+{driver_name}_attach(struct i2c_device *device) --> {driver_name}_attach(struct 
+i2c_adapter *adap, int addr , unsigned short flags, int kind)
+
+Create a i2c_client client...
+Add the following (where "decoder" is a reference to a struct for the driver
+info:
+
+struct i2c_client *client;
+client = kmalloc(sizeof(*client), GFP_KERNEL);
+if(client == NULL)
+       return -ENOMEM;
+client_template.adapter = adap;
+client_template.addr  = addr;
+memcpy(client, &client_template, sizeof(*client));
+strcpy(client->name , "{driver_name}");
+decoder->client = client;
+client->data = decoder;
+decoder->addr = addr;
+
+Towards the end of the function, add:
+
+init_MUTEX(&decoder->lock);
+i2c_attach_client(client);
+
+
+Step 8: Modify the driver's detach function
+
+Change the driver detach function prototype :
+{driver_name}_detach(struct i2c_device *device) --> {driver_name}_detach(struct 
+i2c_client *client)
+
+In the beginning of the detach function, add:
+i2c_detach_client(client);
+
+Towards the end of the detach function, add:
+kfree(client->data);
+kfree(client);
+
+Step 9: Modify the driver's command function
+
+Change the driver command function prototype :
+
+Step 10: Add the probe function after the driver's attach function.
+
+Add the following code:
+
+static int {driver_name}_probe(struct i2c_adapter *adap)
+{
+       return i2c_probe(adap, &addr_data, {driver_name}_attach);
+
+}
+
+Step 11: Modify the driver's i2c_driver
+
+Find the i2c_driver , such as
+static struct i2c_driver i2c_driver_saa7110
+It is usually located towards the end of the driver 
+Replace the values from I2C_DRIVERID_{something} to {driver_name}_attach, and 
+add the following
+I2C_DRIVERID_{driver_name} , // verify by looking in include/linux/i2c-id.h 
+I2C_DF_NOTIFY,
+{driver_name}_probe, 
+....
+
+Step 12: Adding the i2c_client 
+
+Add the i2c_client to the driver. Add the following code:
+
+static struct i2c_client client_template = {
+       "{driver_name}_client",
+       -1,
+       0,
+       0,
+       NULL,
+       {i2c_driver reference}
+};
+
+Step 13: Registering and Unregistering
+
+Replace i2c_register_driver with i2c_add_driver
+Replace i2c_unregister_driver with i2c_del_driver
+
+-------------------------------------------------------
+
+Example:
+
+The following patch provides the i2c coversion patch for the saa7110 driver
+based on the above guide (for clarity).
+
+
+--- drivers/media/video/saa7110.c.old  Fri Jun 28 10:22:52 2002
++++ drivers/media/video/saa7110.c      Thu Jul  4 16:51:08 2002
+@@ -26,7 +26,7 @@
+ #include <asm/io.h>
+ #include <asm/uaccess.h>
+ 
+-#include <linux/i2c-old.h>
++#include <linux/i2c.h>
+ #include <linux/videodev.h>
+ #include "linux/video_decoder.h"
+ 
+@@ -37,13 +37,31 @@
+ 
+ #define       I2C_SAA7110             0x9C    /* or 0x9E */
+ 
++#define IF_NAME       "saa7110"
+ #define       I2C_DELAY               10      /* 10 us or 100khz */
+ 
++static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
++static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
++static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
++static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
++static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
++static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
++static unsigned short force[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
++
++static struct i2c_client_address_data addr_data = {
++      normal_i2c, normal_i2c_range,
++      probe, probe_range,
++      ignore, ignore_range,
++      force
++};
++
++static struct i2c_client client_template;
++
+ struct saa7110 {
+-      struct  i2c_bus *bus;
++      struct i2c_client *client;
+       int             addr;
+       unsigned char   reg[36];
+-
++      struct semaphore lock;
+       int             norm;
+       int             input;
+       int             enable;
+@@ -54,67 +72,10 @@
+ };
+ 
+ /* ----------------------------------------------------------------------- */
+-/* I2C support functions                                                 */
+-/* ----------------------------------------------------------------------- */
+-static
+-int saa7110_write(struct saa7110 *decoder, unsigned char subaddr, unsigned char data)
+-{
+-      int ack;
+-
+-      LOCK_I2C_BUS(decoder->bus);
+-      i2c_start(decoder->bus);
+-      i2c_sendbyte(decoder->bus, decoder->addr, I2C_DELAY);
+-      i2c_sendbyte(decoder->bus, subaddr, I2C_DELAY);
+-      ack = i2c_sendbyte(decoder->bus, data, I2C_DELAY);
+-      i2c_stop(decoder->bus);
+-      decoder->reg[subaddr] = data;
+-      UNLOCK_I2C_BUS(decoder->bus);
+-      return ack;
+-}
+-
+-static
+-int saa7110_write_block(struct saa7110* decoder, unsigned const char *data, unsigned int len)
+-{
+-      unsigned subaddr = *data;
+-
+-      LOCK_I2C_BUS(decoder->bus);
+-        i2c_start(decoder->bus);
+-        i2c_sendbyte(decoder->bus,decoder->addr,I2C_DELAY);
+-      while (len-- > 0) {
+-                if (i2c_sendbyte(decoder->bus,*data,0)) {
+-                        i2c_stop(decoder->bus);
+-                        UNLOCK_I2C_BUS(decoder->bus);
+-                        return -EAGAIN;
+-                }
+-              decoder->reg[subaddr++] = *data++;
+-        }
+-      i2c_stop(decoder->bus);
+-      UNLOCK_I2C_BUS(decoder->bus);
+-
+-      return 0;
+-}
+-
+-static
+-int saa7110_read(struct saa7110* decoder)
+-{
+-      int data;
+-
+-      LOCK_I2C_BUS(decoder->bus);
+-      i2c_start(decoder->bus);
+-      i2c_sendbyte(decoder->bus, decoder->addr, I2C_DELAY);
+-      i2c_start(decoder->bus);
+-      i2c_sendbyte(decoder->bus, decoder->addr | 1, I2C_DELAY);
+-      data = i2c_readbyte(decoder->bus, 1);
+-      i2c_stop(decoder->bus);
+-      UNLOCK_I2C_BUS(decoder->bus);
+-      return data;
+-}
+-
+-/* ----------------------------------------------------------------------- */
+ /* SAA7110 functions                                                     */
+ /* ----------------------------------------------------------------------- */
+ static
+-int saa7110_selmux(struct i2c_device *device, int chan)
++int saa7110_selmux(struct i2c_client *client, int chan)
+ {
+ static        const unsigned char modes[9][8] = {
+ /* mode 0 */  { 0x00, 0xD9, 0x17, 0x40, 0x03, 0x44, 0x75, 0x16 },
+@@ -126,61 +87,59 @@
+ /* mode 6 */  { 0x80, 0x59, 0x17, 0x42, 0xA3, 0x44, 0x75, 0x12 },
+ /* mode 7 */  { 0x80, 0x9A, 0x17, 0xB1, 0x13, 0x60, 0xB5, 0x14 },
+ /* mode 8 */  { 0x80, 0x3C, 0x27, 0xC1, 0x23, 0x44, 0x75, 0x21 } };
+-      struct saa7110* decoder = device->data;
+       const unsigned char* ptr = modes[chan];
+ 
+-      saa7110_write(decoder,0x06,ptr[0]);     /* Luminance control    */
+-      saa7110_write(decoder,0x20,ptr[1]);     /* Analog Control #1    */
+-      saa7110_write(decoder,0x21,ptr[2]);     /* Analog Control #2    */
+-      saa7110_write(decoder,0x22,ptr[3]);     /* Mixer Control #1     */
+-      saa7110_write(decoder,0x2C,ptr[4]);     /* Mixer Control #2     */
+-      saa7110_write(decoder,0x30,ptr[5]);     /* ADCs gain control    */
+-      saa7110_write(decoder,0x31,ptr[6]);     /* Mixer Control #3     */
+-      saa7110_write(decoder,0x21,ptr[7]);     /* Analog Control #2    */
++      i2c_smbus_write_byte_data(client,0x06,ptr[0]);  /* Luminance control    */
++      i2c_smbus_write_byte_data(client,0x20,ptr[1]);  /* Analog Control #1    */
++      i2c_smbus_write_byte_data(client,0x21,ptr[2]);  /* Analog Control #2    */
++      i2c_smbus_write_byte_data(client,0x22,ptr[3]);  /* Mixer Control #1     */
++      i2c_smbus_write_byte_data(client,0x2C,ptr[4]);  /* Mixer Control #2     */
++      i2c_smbus_write_byte_data(client,0x30,ptr[5]);  /* ADCs gain control    */
++      i2c_smbus_write_byte_data(client,0x31,ptr[6]);  /* Mixer Control #3     */
++      i2c_smbus_write_byte_data(client,0x21,ptr[7]);  /* Analog Control #2    */
+ 
+       return 0;
+ }
+ 
+ static
+-int determine_norm(struct i2c_device* dev)
++int determine_norm(struct i2c_client* client)
+ {
+-      struct  saa7110* decoder = dev->data;
+       int     status;
+ 
+       /* mode changed, start automatic detection */
+-      status = saa7110_read(decoder);
++      status = i2c_smbus_read_byte(client);
+       if ((status & 3) == 0) {
+-              saa7110_write(decoder,0x06,0x80);
++              i2c_smbus_write_byte_data(client,0x06,0x80);
+               if (status & 0x20) {
+-                      DEBUG(printk(KERN_INFO "%s: norm=bw60\n",dev->name));
+-                      saa7110_write(decoder,0x2E,0x81);
++                      DEBUG(printk(KERN_INFO "%s: norm=bw60\n",adp->name));
++                      i2c_smbus_write_byte_data(client,0x2E,0x81);
+                       return VIDEO_MODE_NTSC;
+               }
+-              DEBUG(printk(KERN_INFO "%s: norm=bw50\n",dev->name));
+-              saa7110_write(decoder,0x2E,0x9A);
++              DEBUG(printk(KERN_INFO "%s: norm=bw50\n",adp->name));
++              i2c_smbus_write_byte_data(client,0x2E,0x9A);
+               return VIDEO_MODE_PAL;
+       }
+ 
+-      saa7110_write(decoder,0x06,0x00);
++      i2c_smbus_write_byte_data(client,0x06,0x00);
+       if (status & 0x20) {    /* 60Hz */
+-              DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",dev->name));
+-              saa7110_write(decoder,0x0D,0x06);
+-              saa7110_write(decoder,0x11,0x2C);
+-              saa7110_write(decoder,0x2E,0x81);
++              DEBUG(printk(KERN_INFO "%s: norm=ntsc\n",adp->name));
++              i2c_smbus_write_byte_data(client,0x0D,0x06);
++              i2c_smbus_write_byte_data(client,0x11,0x2C);
++              i2c_smbus_write_byte_data(client,0x2E,0x81);
+               return VIDEO_MODE_NTSC;
+       }
+ 
+       /* 50Hz -> PAL/SECAM */
+-      saa7110_write(decoder,0x0D,0x06);
+-      saa7110_write(decoder,0x11,0x59);
+-      saa7110_write(decoder,0x2E,0x9A);
++      i2c_smbus_write_byte_data(client,0x0D,0x06);
++      i2c_smbus_write_byte_data(client,0x11,0x59);
++      i2c_smbus_write_byte_data(client,0x2E,0x9A);
+ 
+       mdelay(150);    /* pause 150 ms */
+ 
+-      status = saa7110_read(decoder);
++      status = i2c_smbus_read_byte(client);
+       if ((status & 0x03) == 0x01) {
+               DEBUG(printk(KERN_INFO "%s: norm=secam\n",dev->name));
+-              saa7110_write(decoder,0x0D,0x07);
++              i2c_smbus_write_byte_data(client,0x0D,0x07);
+               return VIDEO_MODE_SECAM;
+       }
+       DEBUG(printk(KERN_INFO "%s: norm=pal\n",dev->name));
+@@ -188,7 +147,7 @@
+ }
+ 
+ static
+-int saa7110_attach(struct i2c_device *device)
++int saa7110_attach(struct i2c_adapter *adap, int  addr, unsigned short flags, int kind)
+ {
+ static        const unsigned char initseq[] = {
+            0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF0, 0x00, 0x00,
+@@ -198,20 +157,28 @@
+               0xD9, 0x17, 0x40, 0x41, 0x80, 0x41, 0x80, 0x4F,
+               0xFE, 0x01, 0xCF, 0x0F, 0x03, 0x01, 0x81, 0x03,
+               0x40, 0x75, 0x01, 0x8C, 0x03};
+-      struct  saa7110*        decoder;
++      struct  saa7110 *decoder;
++      struct i2c_client *client;
+       int                     rv;
+-
+-      device->data = decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
+-      if (device->data == 0)
++      client=kmalloc(sizeof(*client), GFP_KERNEL);
++      if(client == NULL) 
+               return -ENOMEM;
+-
+-      MOD_INC_USE_COUNT;
++      client_template.adapter = adap;
++      client_template.addr = addr;
++      memcpy(client, &client_template, sizeof(*client));
++
++      decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
++      if (decoder == NULL) {
++              kfree(client);
++              return -ENOMEM;
++              }
+ 
+       /* clear our private data */
+-      memset(decoder, 0, sizeof(struct saa7110));
+-      strcpy(device->name, "saa7110");
+-      decoder->bus = device->bus;
+-      decoder->addr = device->addr;
++      memset(decoder, 0, sizeof(*decoder));
++      strcpy(client->name, IF_NAME);
++      decoder->client = client;
++      client->data = decoder;
++      decoder->addr = addr;
+       decoder->norm = VIDEO_MODE_PAL;
+       decoder->input = 0;
+       decoder->enable = 1;
+@@ -220,40 +187,52 @@
+       decoder->hue = 32768;
+       decoder->sat = 32768;
+ 
+-      rv = saa7110_write_block(decoder, initseq, sizeof(initseq));
++      rv = i2c_master_send(client, initseq, sizeof(initseq));
+       if (rv < 0)
+-              printk(KERN_ERR "%s_attach: init status %d\n", device->name, rv);
++              printk(KERN_ERR "%s_attach: init status %d\n", client->name, rv);
+       else {
+-              saa7110_write(decoder,0x21,0x16);
+-              saa7110_write(decoder,0x0D,0x04);
+-              DEBUG(printk(KERN_INFO "%s_attach: chip version %x\n", device->name, saa7110_read(decoder)));
+-              saa7110_write(decoder,0x0D,0x06);
++              i2c_smbus_write_byte_data(client,0x21,0x16);
++              i2c_smbus_write_byte_data(client,0x0D,0x04);
++              DEBUG(printk(KERN_INFO "%s_attach: chip version %x\n", client->name, i2c_smbus_read_byte(client)));
++              i2c_smbus_write_byte_data(client,0x0D,0x06);
+       }
+ 
++      init_MUTEX(&decoder->lock);
++      i2c_attach_client(client);
++      MOD_INC_USE_COUNT;
+       /* setup and implicit mode 0 select has been performed */
+       return 0;
+ }
+ 
++static 
++int saa7110_probe(struct i2c_adapter *adap) 
++{
++      return i2c_probe(adap, &addr_data, saa7110_attach);
++}
++
+ static
+-int saa7110_detach(struct i2c_device *device)
++int saa7110_detach(struct i2c_client *client)
+ {
+-      struct saa7110* decoder = device->data;
++      struct saa7110* decoder = client->data;
+ 
+-      DEBUG(printk(KERN_INFO "%s_detach\n",device->name));
++      i2c_detach_client(client);
++
++      DEBUG(printk(KERN_INFO "%s_detach\n",client->name));
+ 
+       /* stop further output */
+-      saa7110_write(decoder,0x0E,0x00);
++      i2c_smbus_write_byte_data(client,0x0E,0x00);
+ 
+-      kfree(device->data);
++      kfree(decoder);
++      kfree(client);
+ 
+       MOD_DEC_USE_COUNT;
+       return 0;
+ }
+ 
+ static
+-int saa7110_command(struct i2c_device *device, unsigned int cmd, void *arg)
++int saa7110_command(struct i2c_client *client, unsigned int cmd, void *arg)
+ {
+-      struct saa7110* decoder = device->data;
++      struct saa7110* decoder = client->data;
+       int     v;
+ 
+       switch (cmd) {
+@@ -272,11 +251,11 @@
+ 
+        case DECODER_GET_STATUS:
+               {
+-                      struct saa7110* decoder = device->data;
++                      struct saa7110* decoder = client->data;
+                       int status;
+                       int res = 0;
+ 
+-                      status = i2c_read(device->bus,device->addr|1);
++                      status = i2c_smbus_read_byte(client);
+                       if (status & 0x40)
+                               res |= DECODER_STATUS_GOOD;
+                       if (status & 0x03)
+@@ -301,26 +280,26 @@
+               v = *(int*)arg;
+               if (decoder->norm != v) {
+                       decoder->norm = v;
+-                      saa7110_write(decoder, 0x06, 0x00);
++                      i2c_smbus_write_byte_data(client, 0x06, 0x00);
+                       switch (v) {
+                        case VIDEO_MODE_NTSC:
+-                              saa7110_write(decoder, 0x0D, 0x06);
+-                              saa7110_write(decoder, 0x11, 0x2C);
+-                              saa7110_write(decoder, 0x30, 0x81);
+-                              saa7110_write(decoder, 0x2A, 0xDF);
++                              i2c_smbus_write_byte_data(client, 0x0D, 0x06);
++                              i2c_smbus_write_byte_data(client, 0x11, 0x2C);
++                              i2c_smbus_write_byte_data(client, 0x30, 0x81);
++                              i2c_smbus_write_byte_data(client, 0x2A, 0xDF);
+                               break;
+                        case VIDEO_MODE_PAL:
+-                              saa7110_write(decoder, 0x0D, 0x06);
+-                              saa7110_write(decoder, 0x11, 0x59);
+-                              saa7110_write(decoder, 0x2E, 0x9A);
++                              i2c_smbus_write_byte_data(client, 0x0D, 0x06);
++                              i2c_smbus_write_byte_data(client, 0x11, 0x59);
++                              i2c_smbus_write_byte_data(client, 0x2E, 0x9A);
+                               break;
+                        case VIDEO_MODE_SECAM:
+-                              saa7110_write(decoder, 0x0D, 0x07);
+-                              saa7110_write(decoder, 0x11, 0x59);
+-                              saa7110_write(decoder, 0x2E, 0x9A);
++                              i2c_smbus_write_byte_data(client, 0x0D, 0x07);
++                              i2c_smbus_write_byte_data(client, 0x11, 0x59);
++                              i2c_smbus_write_byte_data(client, 0x2E, 0x9A);
+                               break;
+                        case VIDEO_MODE_AUTO:
+-                              *(int*)arg = determine_norm(device);
++                              *(int*)arg = determine_norm(client);
+                               break;
+                        default:
+                               return -EPERM;
+@@ -334,7 +313,7 @@
+                       return -EINVAL;
+               if (decoder->input != v) {
+                       decoder->input = v;
+-                      saa7110_selmux(device, v);
++                      saa7110_selmux(client, v);
+               }
+               break;
+ 
+@@ -349,7 +328,7 @@
+               v = *(int*)arg;
+               if (decoder->enable != v) {
+                       decoder->enable = v;
+-                      saa7110_write(decoder,0x0E, v ? 0x18 : 0x00);
++                      i2c_smbus_write_byte_data(client,0x0E, v ? 0x18 : 0x00);
+               }
+               break;
+ 
+@@ -360,22 +339,22 @@
+                       if (decoder->bright != pic->brightness) {
+                               /* We want 0 to 255 we get 0-65535 */
+                               decoder->bright = pic->brightness;
+-                              saa7110_write(decoder, 0x19, decoder->bright >> 8);
++                              i2c_smbus_write_byte_data(client, 0x19, decoder->bright >> 8);
+                       }
+                       if (decoder->contrast != pic->contrast) {
+                               /* We want 0 to 127 we get 0-65535 */
+                               decoder->contrast = pic->contrast;
+-                              saa7110_write(decoder, 0x13, decoder->contrast >> 9);
++                              i2c_smbus_write_byte_data(client, 0x13, decoder->contrast >> 9);
+                       }
+                       if (decoder->sat != pic->colour) {
+                               /* We want 0 to 127 we get 0-65535 */
+                               decoder->sat = pic->colour;
+-                              saa7110_write(decoder, 0x12, decoder->sat >> 9);
++                              i2c_smbus_write_byte_data(client, 0x12, decoder->sat >> 9);
+                       }
+                       if (decoder->hue != pic->hue) {
+                               /* We want -128 to 127 we get 0-65535 */
+                               decoder->hue = pic->hue;
+-                              saa7110_write(decoder, 0x07, (decoder->hue>>8)-128);
++                              i2c_smbus_write_byte_data(client, 0x07, (decoder->hue>>8)-128);
+                       }
+               }
+               break;
+@@ -383,7 +362,7 @@
+        case DECODER_DUMP:
+               for (v=0; v<34; v+=16) {
+                       int j;
+-                      DEBUG(printk(KERN_INFO "%s: %03x\n",device->name,v));
++                      DEBUG(printk(KERN_INFO "%s: %03x\n",client->name,v));
+                       for (j=0; j<16; j++) {
+                               DEBUG(printk(KERN_INFO " %02x",decoder->reg[v+j]));
+                       }
+@@ -402,24 +381,30 @@
+ 
+ static struct i2c_driver i2c_driver_saa7110 =
+ {
+-      "saa7110",                      /* name */
+-
+-      I2C_DRIVERID_VIDEODECODER,      /* in i2c.h */
+-      I2C_SAA7110, I2C_SAA7110+1,     /* Addr range */
+-
+-      saa7110_attach,
++      IF_NAME,                        /* name */
++      I2C_DRIVERID_SAA7110,   /* in i2c.h */
++      I2C_DF_NOTIFY,  /* Addr range */
++      saa7110_probe,
+       saa7110_detach,
+       saa7110_command
+ };
++static struct i2c_client client_template = {
++      "saa7110_client",
++      -1,
++      0,
++      0,
++      NULL,
++      &i2c_driver_saa7110
++};
+ 
+ static int saa7110_init(void)
+ {
+-      return i2c_register_driver(&i2c_driver_saa7110);
++      return i2c_add_driver(&i2c_driver_saa7110);
+ }
+ 
+ static void saa7110_exit(void)
+ {
+-      i2c_unregister_driver(&i2c_driver_saa7110);
++      i2c_del_driver(&i2c_driver_saa7110);
+ }
+ 
+ 
+ 
+
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/Documentation/i2c/i2c-pport   2001-08-14 22:17:54.000000000 -0400
@@ -0,0 +1,45 @@
+Primitive parallel port is driver for i2c bus, which exploits 
+features of modern bidirectional parallel ports. 
+
+Bidirectional ports have particular bits connected in following way:
+   
+                        |
+            /-----|     R
+         --o|     |-----|
+      read  \-----|     /------- Out pin
+                      |/
+                   - -|\
+                write   V
+                        |
+                       ---  
+
+
+It means when output is set to 1 we can read the port. Therefore 
+we can use 2 pins of parallel port as SDA and SCL for i2c bus. It 
+is not necessary to add any external - additional parts, we can 
+read and write the same port simultaneously.
+       I only use register base+2 so it is possible to use all 
+8 data bits of parallel port for other applications (I have 
+connected EEPROM and LCD display). I do not use bit Enable Bi-directional
+ Port. The only disadvantage is we can only support 5V chips.
+
+Layout:
+
+Cannon 25 pin
+
+SDA - connect to pin 14 (Auto Linefeed)
+SCL - connect to pin 16 (Initialize Printer)
+GND - connect to pin 18-25
++5V - use external supply (I use 5V from 3.5" floppy connector)
+      
+no pullups  requied
+
+Module parameters:
+
+base = 0xXXX
+XXX - 278 or 378
+
+That's all.
+
+Daniel Smolik
+marvin@sitour.cz
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/Documentation/i2c/i2c-velleman        2002-02-16 10:24:45.000000000 -0500
@@ -0,0 +1,27 @@
+i2c-velleman driver
+-------------------
+This is a driver for i2c-hw access for Velleman K9000 and other adapters.
+
+Useful links
+------------
+Velleman:
+       http://www.velleman.be/
+
+Velleman K8000 Howto:
+       http://howto.htlw16.ac.at/k8000-howto.html
+
+
+K8000 and K8005 libraries
+-------------------------
+The project has lead to new libs for the Velleman K8000 and K8005..
+LIBK8000 v1.99.1 and LIBK8005 v0.21
+
+With these libs you can control the K8000 and K8005 with the original
+simple commands which are in the original Velleman software.
+Like SetIOchannel, ReadADchannel, SendStepCCWFull and many more.
+Via i2c kernel device /dev/velleman
+
+The libs can be found on http://groups.yahoo.com/group/k8000/files/linux/
+
+The Velleman K8000 interface card on http://www.velleman.be/kits/k8000.htm
+The Velleman K8005 steppermotorcard on http://www.velleman.be/kits/k8005.htm
--- linux/Documentation/i2c/smbus-protocol.old  2002-07-20 15:11:16.000000000 -0400
+++ linux/Documentation/i2c/smbus-protocol      2002-07-09 22:06:41.000000000 -0400
@@ -1,3 +1,10 @@
+SMBus Protocol Summary
+======================
+The following is a summary of the SMBus protocol. It applies to
+all revisions of the protocol (1.0, 1.1, and 2.0).
+Certain protocol features which are not supported by
+this package are briefly described at the end of this document.
+
 Some adapters understand only the SMBus (System Management Bus) protocol,
 which is a subset from the I2C protocol. Fortunately, many devices use
 only the same subset, which makes it possible to put them on an SMBus.
@@ -6,7 +13,7 @@
 I2C protocol). This makes it possible to use the device driver on both
 SMBus adapters and I2C adapters (the SMBus command set is automatically
 translated to I2C on I2C adapters, but plain I2C commands can not be
-handled at all on a pure SMBus adapter).
+handled at all on most pure SMBus adapters).
 
 Below is a list of SMBus commands.
 
@@ -109,7 +116,7 @@
 SMBus Block Read
 ================
 
-This command reads a block of upto 32 bytes from a device, from a 
+This command reads a block of up to 32 bytes from a device, from a 
 designated register that is specified through the Comm byte. The amount
 of data is specified by the device in the Count byte.
 
@@ -120,8 +127,90 @@
 SMBus Block Write
 =================
 
-The opposite of the Block Read command, this writes upto 32 bytes to 
+The opposite of the Block Read command, this writes up to 32 bytes to 
 a device, to a designated register that is specified through the
 Comm byte. The amount of data is specified in the Count byte.
 
 S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
+
+
+SMBus Block Process Call
+========================
+
+SMBus Block Process Call was introduced in Revision 2.0 of the specification.
+
+This command selects a device register (through the Comm byte), sends
+1 to 31 bytes of data to it, and reads 1 to 31 bytes of data in return.
+
+S Addr Wr [A] Comm [A] Count [A] Data [A] ...
+                             S Addr Rd [A] [Count] A [Data] ... A P
+
+
+SMBus Host Notify
+=================
+
+This command is sent from a SMBus device acting as a master to the
+SMBus host acting as a slave.
+It is the same form as Write Word, with the command code replaced by the
+alerting device's address.
+
+[S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
+
+
+Packet Error Checking (PEC)
+===========================
+Packet Error Checking was introduced in Revision 1.1 of the specification.
+
+PEC adds a CRC-8 error-checking byte to all transfers.
+
+
+Address Resolution Protocol (ARP)
+=================================
+The Address Resolution Protocol was introduced in Revision 2.0 of
+the specification. It is a higher-layer protocol which uses the
+messages above.
+
+ARP adds device enumeration and dynamic address assignment to
+the protocol. All ARP communications use slave address 0x61 and
+require PEC checksums.
+
+
+I2C Block Transactions
+======================
+The following I2C block transactions are supported by the
+SMBus layer and are described here for completeness.
+I2C block transactions do not limit the number of bytes transferred
+but the SMBus layer places a limit of 32 bytes.
+
+
+I2C Block Read
+==============
+
+This command reads a block of bytes from a device, from a 
+designated register that is specified through the Comm byte.
+
+S Addr Wr [A] Comm [A] 
+           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
+
+
+I2C Block Read (2 Comm bytes)
+=============================
+
+This command reads a block of bytes from a device, from a 
+designated register that is specified through the two Comm bytes.
+
+S Addr Wr [A] Comm1 [A] Comm2 [A] 
+           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
+
+
+I2C Block Write
+===============
+
+The opposite of the Block Read command, this writes bytes to 
+a device, to a designated register that is specified through the
+Comm byte. Note that command lengths of 0, 2, or more bytes are
+supported as they are indistinguishable from data.
+
+S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
+
+
--- linux/Documentation/i2c/summary.old 2002-07-20 15:11:07.000000000 -0400
+++ linux/Documentation/i2c/summary     2002-07-03 21:00:38.000000000 -0400
@@ -59,16 +59,16 @@
 i2c-algo-8xx:    An algorithm for CPM's I2C device in Motorola 8xx processors (NOT BUILT BY DEFAULT)
 i2c-algo-bit:    A bit-banging algorithm
 i2c-algo-pcf:    A PCF 8584 style algorithm
-i2c-algo-ppc405: An algorithm for the I2C device in IBM 405xx processors (NOT BUILT BY DEFAULT)
+i2c-algo-ibmocp: An algorithm for the I2C device in IBM 4xx processors (NOT BUILT BY DEFAULT)
 
 Adapter drivers
 ---------------
 
 i2c-elektor:     Elektor ISA card (uses i2c-algo-pcf)
 i2c-elv:         ELV parallel port adapter (uses i2c-algo-bit)
-i2c-pcf-epp:     PCF8584 on a EPP parallel port (uses i2c-algo-pcf) (BROKEN - missing i2c-pcf-epp.h)
+i2c-pcf-epp:     PCF8584 on a EPP parallel port (uses i2c-algo-pcf) (NOT mkpatched)
 i2c-philips-par: Philips style parallel port adapter (uses i2c-algo-bit)
-i2c-ppc405:      IBM 405xx processor I2C device (uses i2c-algo-ppc405) (NOT BUILT BY DEFAULT)
+i2c-adap_ibmocp:      IBM 4xx processor I2C device (uses i2c-algo-ibmocp) (NOT BUILT BY DEFAULT)
 i2c-pport:       Primitive parallel port adapter (uses i2c-algo-bit)
 i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx) (NOT BUILT BY DEFAULT)
 i2c-velleman:    Velleman K9000 parallel port adapter (uses i2c-algo-bit)
--- linux/Documentation/i2c/writing-clients.old 2002-07-20 15:11:10.000000000 -0400
+++ linux/Documentation/i2c/writing-clients     2001-11-11 18:03:40.000000000 -0500
@@ -365,7 +365,7 @@
 
 The detect client function is called by i2c_probe or i2c_detect.
 The `kind' parameter contains 0 if this call is due to a `force'
-parameter, and 0 otherwise (for i2c_detect, it contains 0 if
+parameter, and -1 otherwise (for i2c_detect, it contains 0 if
 this call is due to the generic `force' parameter, and the chip type
 number if it is due to a specific `force' parameter).
 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
