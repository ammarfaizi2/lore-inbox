Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWDXV33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWDXV33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDXVXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28611 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750971AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 13] ipath - fix race with exposing reset file
X-Mercurial-Node: 61819d2519e0603795bf97a8d6cea9ad62261b57
Message-Id: <61819d2519e0603795bf.1145913777@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:22:57 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were accidentally exposing the "reset" sysfs file more than once
per device.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 8cc21848a9bb -r 61819d2519e0 drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Wed Apr 19 15:24:35 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Wed Apr 19 15:24:36 2006 -0700
@@ -277,12 +277,13 @@ static int ipath_diag_open(struct inode 
 
 bail:
 	spin_unlock_irqrestore(&ipath_devs_lock, flags);
-	mutex_unlock(&ipath_mutex);
 
 	/* Only expose a way to reset the device if we
 	   make it into diag mode. */
 	if (ret == 0)
 		ipath_expose_reset(&dd->pcidev->dev);
+
+	mutex_unlock(&ipath_mutex);
 
 	return ret;
 }
diff -r 8cc21848a9bb -r 61819d2519e0 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Wed Apr 19 15:24:35 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Wed Apr 19 15:24:36 2006 -0700
@@ -711,10 +711,22 @@ static struct attribute_group dev_attr_g
  * enters diag mode.  A device reset is quite likely to crash the
  * machine entirely, so we don't want to normally make it
  * available.
+ *
+ * Called with ipath_mutex held.
  */
 int ipath_expose_reset(struct device *dev)
 {
-	return device_create_file(dev, &dev_attr_reset);
+	static int exposed;
+	int ret;
+
+	if (!exposed) {
+		ret = device_create_file(dev, &dev_attr_reset);
+		exposed = 1;
+	}
+	else
+		ret = 0;
+
+	return ret;
 }
 
 int ipath_driver_create_group(struct device_driver *drv)
