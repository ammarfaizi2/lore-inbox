Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVJ1Gm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVJ1Gm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVJ1GmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:42:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:28650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965126AbVJ1GbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:11 -0400
Cc: gregkh@suse.de
Subject: [PATCH] I2O: Clean up some pretty bad driver model abuses in the i2o code
In-Reply-To: <11304810223635@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <1130481022335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2O: Clean up some pretty bad driver model abuses in the i2o code

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3d7eba1bed51352c3bd68b4e507c021ad7db928a
tree 39f070d720ed7ab91e9ebd178e345cdbb2ce5193
parent e12574538ea88cd5e15d7135e9ae6e267d314f2c
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:00 -0700

 drivers/message/i2o/iop.c |   22 ++++++++++------------
 include/linux/i2o.h       |    2 +-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
index 42f8b81..15deb45 100644
--- a/drivers/message/i2o/iop.c
+++ b/drivers/message/i2o/iop.c
@@ -833,6 +833,7 @@ void i2o_iop_remove(struct i2o_controlle
 	list_for_each_entry_safe(dev, tmp, &c->devices, list)
 	    i2o_device_remove(dev);
 
+	class_device_unregister(c->classdev);
 	device_del(&c->device);
 
 	/* Ask the IOP to switch to RESET state */
@@ -1077,9 +1078,7 @@ static void i2o_iop_release(struct devic
 };
 
 /* I2O controller class */
-static struct class i2o_controller_class = {
-	.name = "i2o_controller",
-};
+static struct class *i2o_controller_class;
 
 /**
  *	i2o_iop_alloc - Allocate and initialize a i2o_controller struct
@@ -1110,14 +1109,10 @@ struct i2o_controller *i2o_iop_alloc(voi
 	sprintf(c->name, "iop%d", c->unit);
 
 	device_initialize(&c->device);
-	class_device_initialize(&c->classdev);
 
 	c->device.release = &i2o_iop_release;
-	c->classdev.class = &i2o_controller_class;
-	c->classdev.dev = &c->device;
 
 	snprintf(c->device.bus_id, BUS_ID_SIZE, "iop%d", c->unit);
-	snprintf(c->classdev.class_id, BUS_ID_SIZE, "iop%d", c->unit);
 
 #if BITS_PER_LONG == 64
 	spin_lock_init(&c->context_list_lock);
@@ -1146,7 +1141,9 @@ int i2o_iop_add(struct i2o_controller *c
 		goto iop_reset;
 	}
 
-	if ((rc = class_device_add(&c->classdev))) {
+	c->classdev = class_device_create(i2o_controller_class, 0,
+			&c->device, "iop%d", c->unit);
+	if (IS_ERR(c->classdev)) {
 		osm_err("%s: could not add controller class\n", c->name);
 		goto device_del;
 	}
@@ -1184,7 +1181,7 @@ int i2o_iop_add(struct i2o_controller *c
 	return 0;
 
       class_del:
-	class_device_del(&c->classdev);
+	class_device_unregister(c->classdev);
 
       device_del:
 	device_del(&c->device);
@@ -1250,7 +1247,8 @@ static int __init i2o_iop_init(void)
 	if (rc)
 		goto exit;
 
-	if ((rc = class_register(&i2o_controller_class))) {
+	i2o_controller_class = class_create(THIS_MODULE, "i2o_controller");
+	if (IS_ERR(i2o_controller_class)) {
 		osm_err("can't register class i2o_controller\n");
 		goto device_exit;
 	}
@@ -1273,7 +1271,7 @@ static int __init i2o_iop_init(void)
 	i2o_driver_exit();
 
       class_exit:
-	class_unregister(&i2o_controller_class);
+	class_destroy(i2o_controller_class);
 
       device_exit:
 	i2o_device_exit();
@@ -1292,7 +1290,7 @@ static void __exit i2o_iop_exit(void)
 	i2o_pci_exit();
 	i2o_exec_exit();
 	i2o_driver_exit();
-	class_unregister(&i2o_controller_class);
+	class_destroy(i2o_controller_class);
 	i2o_device_exit();
 };
 
diff --git a/include/linux/i2o.h b/include/linux/i2o.h
index bdc286e..694ea29 100644
--- a/include/linux/i2o.h
+++ b/include/linux/i2o.h
@@ -194,7 +194,7 @@ struct i2o_controller {
 	struct resource mem_resource;	/* Mem resource allocated to the IOP */
 
 	struct device device;
-	struct class_device classdev;	/* I2O controller class */
+	struct class_device *classdev;	/* I2O controller class device */
 	struct i2o_device *exec;	/* Executive */
 #if BITS_PER_LONG == 64
 	spinlock_t context_list_lock;	/* lock for context_list */

