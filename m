Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264761AbUEOW1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbUEOW1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUEOW1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:27:33 -0400
Received: from [212.57.15.61] ([212.57.15.61]:64012 "EHLO smtp10.turk.net")
	by vger.kernel.org with ESMTP id S264761AbUEOW0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:26:41 -0400
Date: Sun, 16 May 2004 01:26:32 +0300
From: Faik Uygur <faikuygur@tnn.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c
Message-ID: <20040515222632.GA7218@dsl.ttnet.net.tr>
Mail-Followup-To: greg@kroah.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
X-Editor: GNU Emacs 21.3.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch uses idr_get_new to allocate a bus id while registering
a new adapter.


--- a/drivers/i2c/i2c-core.c	Sat May 15 23:19:11 2004
+++ b/drivers/i2c/i2c-core.c	Sat May 15 23:19:11 2004
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
@@ -113,13 +115,17 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	static int nr = 0;
+	int id;
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
+	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
+		return -ENOMEM;
+
 	down(&core_lists);
 
-	adap->nr = nr++;
+	id = idr_get_new(&i2c_adapter_idr, NULL);
+	adap->nr =  id & MAX_ID_MASK;
 	init_MUTEX(&adap->bus_lock);
 	init_MUTEX(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
@@ -207,6 +213,9 @@
 	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 	wait_for_completion(&adap->class_dev_released);
+
+	/* free dynamically allocated bus id */
+	idr_remove(&i2c_adapter_idr, adap->nr);
 
 	dev_dbg(&adap->dev, "adapter unregistered\n");
 


