Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUE1WIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUE1WIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUE1WIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:08:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:36030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264103AbUE1WBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:31 -0400
Subject: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <20040528215908.GA13626@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <1085781643100@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.23, 2004/05/19 00:24:54-07:00, faikuygur@tnn.net

[PATCH] I2C: use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c


 drivers/i2c/i2c-core.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri May 28 14:52:36 2004
+++ b/drivers/i2c/i2c-core.c	Fri May 28 14:52:36 2004
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/idr.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 
@@ -35,6 +36,7 @@
 static LIST_HEAD(adapters);
 static LIST_HEAD(drivers);
 static DECLARE_MUTEX(core_lists);
+static DEFINE_IDR(i2c_adapter_idr);
 
 int i2c_device_probe(struct device *dev)
 {
@@ -113,13 +115,19 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	static int nr = 0;
+	int id, res = 0;
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
 	down(&core_lists);
 
-	adap->nr = nr++;
+	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0) {
+		res = -ENOMEM;
+		goto out_unlock;
+	}
+
+	id = idr_get_new(&i2c_adapter_idr, NULL);
+	adap->nr =  id & MAX_ID_MASK;
 	init_MUTEX(&adap->bus_lock);
 	init_MUTEX(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
@@ -151,10 +159,12 @@
 			/* We ignore the return code; if it fails, too bad */
 			driver->attach_adapter(adap);
 	}
-	up(&core_lists);
 
 	dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr);
-	return 0;
+
+ out_unlock:
+	up(&core_lists);
+	return res;
 }
 
 
@@ -207,6 +217,9 @@
 	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 	wait_for_completion(&adap->class_dev_released);
+
+	/* free dynamically allocated bus id */
+	idr_remove(&i2c_adapter_idr, adap->nr);
 
 	dev_dbg(&adap->dev, "adapter unregistered\n");
 

