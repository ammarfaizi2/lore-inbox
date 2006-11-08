Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWKHUXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWKHUXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWKHUXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:23:17 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:9366 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1422864AbWKHUXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:23:15 -0500
Subject: [PATCH 1/1] Unitialized pseudo_netdev accessed in
	c2_register_device
From: Tom Tucker <tom@opengridcomputing.com>
To: Adrian Bunk <bunk@stusta.de>, Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general <openib-general@openib.org>,
       Steve Wise <swise@opengridcomputing.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 14:23:22 -0600
Message-Id: <1163017402.8753.13.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland/Adrian:

Reworked some load-time error handling. c2_register_device 
leaked when it failed and the function that called it didn't 
check the return code.

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>

---

 drivers/infiniband/hw/amso1100/c2.c          |    3 +-
 drivers/infiniband/hw/amso1100/c2_provider.c |   39 +++++++++++++-------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/amso1100/c2.c b/drivers/infiniband/hw/amso1100/c2.c
index 9e7bd94..27fe242 100644
--- a/drivers/infiniband/hw/amso1100/c2.c
+++ b/drivers/infiniband/hw/amso1100/c2.c
@@ -1155,7 +1155,8 @@ static int __devinit c2_probe(struct pci
 		goto bail10;
 	}
 
-	c2_register_device(c2dev);
+	if (c2_register_device(c2dev))
+		goto bail10;
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/amso1100/c2_provider.c b/drivers/infiniband/hw/amso1100/c2_provider.c
index da98d9f..fef9727 100644
--- a/drivers/infiniband/hw/amso1100/c2_provider.c
+++ b/drivers/infiniband/hw/amso1100/c2_provider.c
@@ -757,20 +757,17 @@ #endif
 
 int c2_register_device(struct c2_dev *dev)
 {
-	int ret;
+	int ret = -ENOMEM;
 	int i;
 
 	/* Register pseudo network device */
 	dev->pseudo_netdev = c2_pseudo_netdev_init(dev);
-	if (dev->pseudo_netdev) {
-		ret = register_netdev(dev->pseudo_netdev);
-		if (ret) {
-			printk(KERN_ERR PFX
-				"Unable to register netdev, ret = %d\n", ret);
-			free_netdev(dev->pseudo_netdev);
-			return ret;
-		}
-	}
+	if (!dev->pseudo_netdev)
+		goto out3;
+
+	ret = register_netdev(dev->pseudo_netdev);
+	if (ret)
+		goto out2;
 
 	pr_debug("%s:%u\n", __FUNCTION__, __LINE__);
 	strlcpy(dev->ibdev.name, "amso%d", IB_DEVICE_NAME_MAX);
@@ -848,21 +845,25 @@ int c2_register_device(struct c2_dev *de
 
 	ret = ib_register_device(&dev->ibdev);
 	if (ret)
-		return ret;
+		goto out1;
 
 	for (i = 0; i < ARRAY_SIZE(c2_class_attributes); ++i) {
 		ret = class_device_create_file(&dev->ibdev.class_dev,
 					       c2_class_attributes[i]);
-		if (ret) {
-			unregister_netdev(dev->pseudo_netdev);
-			free_netdev(dev->pseudo_netdev);
-			ib_unregister_device(&dev->ibdev);
-			return ret;
-		}
+		if (ret)
+			goto out0;
 	}
+	goto out3;
 
-	pr_debug("%s:%u\n", __FUNCTION__, __LINE__);
-	return 0;
+out0:
+	ib_unregister_device(&dev->ibdev);
+out1:
+	unregister_netdev(dev->pseudo_netdev);
+out2:
+	free_netdev(dev->pseudo_netdev);
+out3:
+	pr_debug("%s:%u ret=%d\n", __FUNCTION__, __LINE__, ret);
+	return ret;
 }
 
 void c2_unregister_device(struct c2_dev *dev)

