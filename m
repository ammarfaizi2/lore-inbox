Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUEPJNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUEPJNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 05:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUEPJNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 05:13:42 -0400
Received: from [212.57.15.61] ([212.57.15.61]:34573 "EHLO smtp10.turk.net")
	by vger.kernel.org with ESMTP id S263389AbUEPJNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 05:13:38 -0400
Date: Sun, 16 May 2004 12:13:13 +0300
From: Faik Uygur <faikuygur@tnn.net>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c
Message-ID: <20040516091312.GA2052@tnn.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20040515222632.GA7218@dsl.ttnet.net.tr> <20040515165812.7e771f20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
In-Reply-To: <20040515165812.7e771f20.akpm@osdl.org>
X-Editor: GNU Emacs 21.3.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004, Andrew Morton wrote:

> The IDR interface is a bit cumbersome.  Even though you called
> idr_pre_get(), there's no guarantee that the memory which it preallocated
> is still present when you call idr_get_new().

Thanks for the correction.

> Is the kernel likely to ever have so many bus IDs that we actually need
> this patch?  Or do you specifically want first-fit-from-zero for some
> reason?

Actually there is no special need for this. It is just what i think would
be the expected behaviour. There was a thread two weeks ago about this issue:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108370586601550&w=2

here is the updated patch:

diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Sun May 16 11:55:29 2004
+++ b/drivers/i2c/i2c-core.c	Sun May 16 11:55:29 2004
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

