Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUC0L4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 06:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUC0L4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 06:56:04 -0500
Received: from mail.convergence.de ([212.84.236.4]:52662 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261690AbUC0Lzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 06:55:54 -0500
Message-ID: <40656BC4.4020601@convergence.de>
Date: Sat, 27 Mar 2004 12:55:48 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: greg@kroah.com
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client isolation
Content-Type: multipart/mixed;
 boundary="------------020801040504040000030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020801040504040000030502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Greg,

I've implemented the idea of an additional i2c adapter flag in order to 
be able to keep i2c drivers away from certain i2c adapters.

Here is what I did:

First of all I was surprised that "struct i2c_adapter" already contained 
a "flags" field. It doesn't seem to be used anywhere, though -- please 
correct me if I'm wrong.

I added one flag named "I2C_ADAP_FLAG_CLASS_MATCH" which adapters can 
set if they want the type of the i2c driver match the type of the i2c 
adapter.

Next I added a "class" member to "struct i2c_driver". I decided to use 
the same flags as for the "struct i2c_adapter" here, although the are 
all named I2C_ADAP_CLASS_* and are a bit misleading now when used for in 
the i2c driver.

There are two places in i2c-core where drivers are informed of new adapters.

At both places, the flags field is checked against the newly introduced 
flags I2C_ADAP_FLAG_CLASS_MATCH. If this flag is set and the adapter 
class and the driver class don't match, the driver is not probed on the bus.

All "old" drivers don't have this flag set, so everything works just 
like before this change.

"i2c-mxb.diff" is an example of what needs to be done to "port" drivers 
to this new scheme. The MXB driver is based on the saa7146 driver which 
provides the necessary i2c adapter. The adapter is exported with the new 
flag mentionened above and all slave i2c drivers (tea6420, tea6415c, 
tuner, tda9840, saa7111) have the class type set accordingly.

Now it's only possible to load these 5 i2c drivers against the MXB 
saa7146 i2c bus -- all other i2c drivers don't get the chance to probe, 
which is exactly what I wanted.

Todo list:
- check if "flags" member in "struct i2c_adapter" is really unused -- 
can any of the i2c experts commment on this?

- Should the I2C_ADAP_CLASS_* be renamed to I2C_CLASS_*, so they can be 
used by both i2c adapters and i2c drivers?

Comments welcome.

CU
Michael.

--------------020801040504040000030502
Content-Type: text/plain;
 name="i2c-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-update.diff"

diff -ura linux-2.6.4-i2c/drivers/i2c/i2c-core.c linux-2.6.4/drivers/i2c/i2c-core.c
--- linux-2.6.4-i2c/drivers/i2c/i2c-core.c	2004-03-21 20:01:10.000000000 +0100
+++ linux-2.6.4/drivers/i2c/i2c-core.c	2004-03-21 20:06:52.000000000 +0100
@@ -151,6 +151,13 @@
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
+		if ((adap->flags & I2C_ADAP_FLAG_CLASS_MATCH) != 0) {
+			if ((adap->class & driver->class) == 0) {
+				pr_debug("i2c-core: adapter '%s' enforces strict class type match."
+					 "driver '%s' not probed.\n",adap->name,driver->name);
+				continue;
+			}
+		}
 		if (driver->flags & I2C_DF_NOTIFY)
 			/* We ignore the return code; if it fails, too bad */
 			driver->attach_adapter(adap);
@@ -251,6 +258,13 @@
 	if (driver->flags & I2C_DF_NOTIFY) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
+			if ((adapter->flags & I2C_ADAP_FLAG_CLASS_MATCH) != 0) {
+				if ((adapter->class & driver->class) == 0) {
+					pr_debug("i2c-core: adapter '%s' enforces strict class type match."
+						 "driver '%s' not probed.\n",adap->name,driver->name);
+					continue;
+				}
+			}
 			driver->attach_adapter(adapter);
 		}
 	}
diff -ura linux-2.6.4-i2c/include/linux/i2c.h linux-2.6.4/include/linux/i2c.h
--- linux-2.6.4-i2c/include/linux/i2c.h	2004-03-21 19:58:31.000000000 +0100
+++ linux-2.6.4/include/linux/i2c.h	2004-03-21 20:12:04.000000000 +0100
@@ -114,6 +114,7 @@
 	char name[32];
 	int id;
 	unsigned int flags;		/* div., see below		*/
+	unsigned int class;
 
 	/* Notifies the driver that a new bus has appeared. This routine
 	 * can be used by the driver to test if the bus meets its conditions
@@ -226,7 +227,10 @@
 	struct module *owner;
 	unsigned int id;/* == is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
+
 	unsigned int class;
+	unsigned int flags;	/* div., see below */
+
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
@@ -237,7 +241,6 @@
 	/* data fields that are valid for all devices	*/
 	struct semaphore bus_lock;
 	struct semaphore clist_lock;
-	unsigned int flags;/* flags specifying div. data		*/
 
 	int timeout;
 	int retries;
@@ -285,10 +288,13 @@
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */
 
+/* i2c adapter flags (bitmask) */
+#define I2C_ADAP_FLAG_CLASS_MATCH	(1<<0)	/* adapter and driver class must match for device probing */
+
 /* i2c adapter classes (bitmask) */
 #define I2C_ADAP_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
 #define I2C_ADAP_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
-#define I2C_ADAP_CLASS_TV_DIGITAL	(1<<2)	/* dbv cards */
+#define I2C_ADAP_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
 #define I2C_ADAP_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
 #define I2C_ADAP_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
 #define I2C_ADAP_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */

--------------020801040504040000030502
Content-Type: text/plain;
 name="i2c-mxb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-mxb.diff"

diff -ura linux-2.6.4-i2c/drivers/media/common/saa7146_i2c.c linux-2.6.4/drivers/media/common/saa7146_i2c.c
--- linux-2.6.4-i2c/drivers/media/common/saa7146_i2c.c	2004-03-21 19:58:43.000000000 +0100
+++ linux-2.6.4/drivers/media/common/saa7146_i2c.c	2004-03-21 19:56:46.000000000 +0100
@@ -413,20 +413,14 @@
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
 		strcpy(i2c_adapter->name, dev->name);	
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-		i2c_adapter->data = dev;
-#else
 		i2c_set_adapdata(i2c_adapter,dev);
-#endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#else
 		i2c_adapter->class = I2C_ADAP_CLASS_TV_ANALOG;
-#endif
+		i2c_adapter->flags = I2C_ADAP_FLAG_CLASS_MATCH;
 	}
 	
 	return 0;
diff -ura linux-2.6.4-i2c/drivers/media/video/saa7111.c linux-2.6.4/drivers/media/video/saa7111.c
--- linux-2.6.4-i2c/drivers/media/video/saa7111.c	2004-03-21 19:59:29.000000000 +0100
+++ linux-2.6.4/drivers/media/video/saa7111.c	2004-03-21 19:59:31.000000000 +0100
@@ -591,6 +591,7 @@
 
 	.id = I2C_DRIVERID_SAA7111A,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_ADAP_CLASS_TV_ANALOG,
 
 	.attach_adapter = saa7111_attach_adapter,
 	.detach_client = saa7111_detach_client,
diff -ura linux-2.6.4-i2c/drivers/media/video/tda9840.c linux-2.6.4/drivers/media/video/tda9840.c
--- linux-2.6.4-i2c/drivers/media/video/tda9840.c	2004-03-21 19:59:04.000000000 +0100
+++ linux-2.6.4/drivers/media/video/tda9840.c	2004-03-21 19:51:25.000000000 +0100
@@ -263,6 +263,7 @@
 	.name		= "tda9840 driver",
 	.id		= I2C_DRIVERID_TDA9840,
 	.flags		= I2C_DF_NOTIFY,
+	.class 		= I2C_ADAP_CLASS_TV_ANALOG,
         .attach_adapter = tda9840_attach,
         .detach_client	= tda9840_detach,
         .command	= tda9840_command,
diff -ura linux-2.6.4-i2c/drivers/media/video/tea6415c.c linux-2.6.4/drivers/media/video/tea6415c.c
--- linux-2.6.4-i2c/drivers/media/video/tea6415c.c	2004-03-21 19:58:57.000000000 +0100
+++ linux-2.6.4/drivers/media/video/tea6415c.c	2004-03-21 19:18:43.000000000 +0100
@@ -212,6 +212,7 @@
 	.name		= "tea6415c driver",
 	.id		= I2C_DRIVERID_TEA6415C,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_ADAP_CLASS_TV_ANALOG,
         .attach_adapter = tea6415c_attach,
         .detach_client	= tea6415c_detach,
         .command	= tea6415c_command,
diff -ura linux-2.6.4-i2c/drivers/media/video/tea6420.c linux-2.6.4/drivers/media/video/tea6420.c
--- linux-2.6.4-i2c/drivers/media/video/tea6420.c	2004-03-21 19:58:51.000000000 +0100
+++ linux-2.6.4/drivers/media/video/tea6420.c	2004-03-21 19:51:36.000000000 +0100
@@ -192,6 +192,7 @@
 	.name		= "tea6420 driver",
 	.id		= I2C_DRIVERID_TEA6420,
 	.flags		= I2C_DF_NOTIFY,
+	.class 		= I2C_ADAP_CLASS_TV_ANALOG,
         .attach_adapter = tea6420_attach,
         .detach_client	= tea6420_detach,
         .command	= tea6420_command,
diff -ura linux-2.6.4-i2c/drivers/media/video/tuner.c linux-2.6.4/drivers/media/video/tuner.c
--- linux-2.6.4-i2c/drivers/media/video/tuner.c	2004-03-21 19:59:10.000000000 +0100
+++ linux-2.6.4/drivers/media/video/tuner.c	2004-03-21 19:51:50.000000000 +0100
@@ -1180,6 +1180,7 @@
         .name           = "i2c TV tuner driver",
         .id             = I2C_DRIVERID_TUNER,
         .flags          = I2C_DF_NOTIFY,
+	.class 		= I2C_ADAP_CLASS_TV_ANALOG,
         .attach_adapter = tuner_probe,
         .detach_client  = tuner_detach,
         .command        = tuner_command,

--------------020801040504040000030502--
