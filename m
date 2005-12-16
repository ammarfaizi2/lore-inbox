Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVLPAbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVLPAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLPAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:58 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:4036 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751219AbVLPAak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:40 -0500
Message-ID: <43A20AAB.5060303@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:35 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] I2O: Optimizing
Content-Type: multipart/mixed;
 boundary="------------070905090704080200060108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905090704080200060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- make i2o_iop_free() static inline (from Adrian Bunk)
- changed kmalloc() + memset(0) into kzalloc()

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------070905090704080200060108
Content-Type: text/x-patch;
 name="i2o-optimizing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-optimizing.patch"

Index: linux-2.6/drivers/message/i2o/core.h
===================================================================
--- linux-2.6.orig/drivers/message/i2o/core.h
+++ linux-2.6/drivers/message/i2o/core.h
@@ -40,7 +40,16 @@ extern int i2o_device_parse_lct(struct i
 
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
-extern void i2o_iop_free(struct i2o_controller *);
+
+/**
+ *	i2o_iop_free - Free the i2o_controller struct
+ *	@c: I2O controller to free
+ */
+static inline void i2o_iop_free(struct i2o_controller *c)
+{
+	i2o_pool_free(&c->in_msg);
+	kfree(c);
+}
 
 extern int i2o_iop_add(struct i2o_controller *);
 extern void i2o_iop_remove(struct i2o_controller *);
Index: linux-2.6/drivers/message/i2o/iop.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/iop.c
+++ linux-2.6/drivers/message/i2o/iop.c
@@ -32,7 +32,7 @@
 #include "core.h"
 
 #define OSM_NAME	"i2o"
-#define OSM_VERSION	"1.316"
+#define OSM_VERSION	"1.325"
 #define OSM_DESCRIPTION	"I2O subsystem"
 
 /* global I2O controller list */
@@ -838,12 +838,11 @@ static int i2o_systab_build(void)
 	i2o_systab.len = sizeof(struct i2o_sys_tbl) + num_controllers *
 	    sizeof(struct i2o_sys_tbl_entry);
 
-	systab = i2o_systab.virt = kmalloc(i2o_systab.len, GFP_KERNEL);
+	systab = i2o_systab.virt = kzalloc(i2o_systab.len, GFP_KERNEL);
 	if (!systab) {
 		osm_err("unable to allocate memory for System Table\n");
 		return -ENOMEM;
 	}
-	memset(systab, 0, i2o_systab.len);
 
 	systab->version = I2OVERSION;
 	systab->change_ind = change_ind + 1;
@@ -1020,16 +1019,6 @@ static int i2o_hrt_get(struct i2o_contro
 }
 
 /**
- *	i2o_iop_free - Free the i2o_controller struct
- *	@c: I2O controller to free
- */
-void i2o_iop_free(struct i2o_controller *c)
-{
-	i2o_pool_free(&c->in_msg);
-	kfree(c);
-};
-
-/**
  *	i2o_iop_release - release the memory for a I2O controller
  *	@dev: I2O controller which should be released
  *
@@ -1058,13 +1047,12 @@ struct i2o_controller *i2o_iop_alloc(voi
 	struct i2o_controller *c;
 	char poolname[32];
 
-	c = kmalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c) {
 		osm_err("i2o: Insufficient memory to allocate a I2O controller."
 			"\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(c, 0, sizeof(*c));
 
 	c->unit = unit++;
 	sprintf(c->name, "iop%d", c->unit);
Index: linux-2.6/drivers/message/i2o/config-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/config-osm.c
+++ linux-2.6/drivers/message/i2o/config-osm.c
@@ -22,7 +22,7 @@
 #include <asm/uaccess.h>
 
 #define OSM_NAME	"config-osm"
-#define OSM_VERSION	"1.317"
+#define OSM_VERSION	"1.323"
 #define OSM_DESCRIPTION	"I2O Configuration OSM"
 
 /* access mode user rw */
Index: linux-2.6/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/device.c
+++ linux-2.6/drivers/message/i2o/device.c
@@ -195,12 +195,10 @@ static struct i2o_device *i2o_device_all
 {
 	struct i2o_device *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	memset(dev, 0, sizeof(*dev));
-
 	INIT_LIST_HEAD(&dev->list);
 	init_MUTEX(&dev->lock);
 
Index: linux-2.6/drivers/message/i2o/driver.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/driver.c
+++ linux-2.6/drivers/message/i2o/driver.c
@@ -217,10 +217,9 @@ int i2o_driver_dispatch(struct i2o_contr
 		/* cut of header from message size (in 32-bit words) */
 		size = (le32_to_cpu(msg->u.head[0]) >> 16) - 5;
 
-		evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
+		evt = kzalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
 		if (!evt)
 			return -ENOMEM;
-		memset(evt, 0, size * 4 + sizeof(*evt));
 
 		evt->size = size;
 		evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
@@ -348,12 +347,10 @@ int __init i2o_driver_init(void)
 	osm_info("max drivers = %d\n", i2o_max_drivers);
 
 	i2o_drivers =
-	    kmalloc(i2o_max_drivers * sizeof(*i2o_drivers), GFP_KERNEL);
+	    kzalloc(i2o_max_drivers * sizeof(*i2o_drivers), GFP_KERNEL);
 	if (!i2o_drivers)
 		return -ENOMEM;
 
-	memset(i2o_drivers, 0, i2o_max_drivers * sizeof(*i2o_drivers));
-
 	rc = bus_register(&i2o_bus_type);
 
 	if (rc < 0)
Index: linux-2.6/drivers/message/i2o/exec-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/exec-osm.c
+++ linux-2.6/drivers/message/i2o/exec-osm.c
@@ -75,12 +75,10 @@ static struct i2o_exec_wait *i2o_exec_wa
 {
 	struct i2o_exec_wait *wait;
 
-	wait = kmalloc(sizeof(*wait), GFP_KERNEL);
+	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait)
 		return NULL;
 
-	memset(wait, 0, sizeof(*wait));
-
 	INIT_LIST_HEAD(&wait->list);
 
 	return wait;
Index: linux-2.6/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_block.c
+++ linux-2.6/drivers/message/i2o/i2o_block.c
@@ -64,7 +64,7 @@
 #include "i2o_block.h"
 
 #define OSM_NAME	"block-osm"
-#define OSM_VERSION	"1.316"
+#define OSM_VERSION	"1.325"
 #define OSM_DESCRIPTION	"I2O Block Device OSM"
 
 static struct i2o_driver i2o_block_driver;
@@ -981,13 +981,12 @@ static struct i2o_block_device *i2o_bloc
 	struct request_queue *queue;
 	int rc;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		osm_err("Insufficient memory to allocate I2O Block disk.\n");
 		rc = -ENOMEM;
 		goto exit;
 	}
-	memset(dev, 0, sizeof(*dev));
 
 	INIT_LIST_HEAD(&dev->open_queue);
 	spin_lock_init(&dev->lock);
Index: linux-2.6/drivers/message/i2o/i2o_config.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_config.c
+++ linux-2.6/drivers/message/i2o/i2o_config.c
@@ -583,13 +583,12 @@ static int i2o_cfg_passthru32(struct fil
 	reply_size >>= 16;
 	reply_size <<= 2;
 
-	reply = kmalloc(reply_size, GFP_KERNEL);
+	reply = kzalloc(reply_size, GFP_KERNEL);
 	if (!reply) {
 		printk(KERN_WARNING "%s: Could not allocate reply buffer\n",
 		       c->name);
 		return -ENOMEM;
 	}
-	memset(reply, 0, reply_size);
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 
@@ -817,13 +816,12 @@ static int i2o_cfg_passthru(unsigned lon
 	reply_size >>= 16;
 	reply_size <<= 2;
 
-	reply = kmalloc(reply_size, GFP_KERNEL);
+	reply = kzalloc(reply_size, GFP_KERNEL);
 	if (!reply) {
 		printk(KERN_WARNING "%s: Could not allocate reply buffer\n",
 		       c->name);
 		return -ENOMEM;
 	}
-	memset(reply, 0, reply_size);
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 

--------------070905090704080200060108--
