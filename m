Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161532AbWJKVvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161532AbWJKVvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161525AbWJKVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:51:12 -0400
Received: from havoc.gtf.org ([69.61.125.42]:59607 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161532AbWJKVvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:51:10 -0400
Date: Wed, 11 Oct 2006 17:51:09 -0400
From: Jeff Garzik <jeff@garzik.org>
To: ambx1@neo.rr.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PNP: handle sysfs errors
Message-ID: <20061011215109.GA22264@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/pnp/card.c      |   30 +++++++++++++++++++++---------
 drivers/pnp/interface.c |   17 ++++++++++++++---
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index 227600c..91c047a 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -164,9 +164,17 @@ static DEVICE_ATTR(card_id,S_IRUGO,pnp_s
 
 static int pnp_interface_attach_card(struct pnp_card *card)
 {
-	device_create_file(&card->dev,&dev_attr_name);
-	device_create_file(&card->dev,&dev_attr_card_id);
+	int rc = device_create_file(&card->dev,&dev_attr_name);
+	if (rc) return rc;
+
+	rc = device_create_file(&card->dev,&dev_attr_card_id);
+	if (rc) goto err_name;
+
 	return 0;
+
+err_name:
+	device_remove_file(&card->dev,&dev_attr_name);
+	return rc;
 }
 
 /**
@@ -306,16 +314,20 @@ found:
 	down_write(&dev->dev.bus->subsys.rwsem);
 	dev->card_link = clink;
 	dev->dev.driver = &drv->link.driver;
-	if (pnp_bus_type.probe(&dev->dev)) {
-		dev->dev.driver = NULL;
-		dev->card_link = NULL;
-		up_write(&dev->dev.bus->subsys.rwsem);
-		return NULL;
-	}
-	device_bind_driver(&dev->dev);
+	if (pnp_bus_type.probe(&dev->dev))
+		goto err_out;
+	if (device_bind_driver(&dev->dev))
+		goto err_out;
+
 	up_write(&dev->dev.bus->subsys.rwsem);
 
 	return dev;
+
+err_out:
+	dev->dev.driver = NULL;
+	dev->card_link = NULL;
+	up_write(&dev->dev.bus->subsys.rwsem);
+	return NULL;
 }
 
 /**
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 9d8b415..ac9fcd4 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -461,8 +461,19 @@ static DEVICE_ATTR(id,S_IRUGO,pnp_show_c
 
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
-	device_create_file(&dev->dev,&dev_attr_options);
-	device_create_file(&dev->dev,&dev_attr_resources);
-	device_create_file(&dev->dev,&dev_attr_id);
+	int rc = device_create_file(&dev->dev,&dev_attr_options);
+	if (rc) goto err;
+	rc = device_create_file(&dev->dev,&dev_attr_resources);
+	if (rc) goto err_opt;
+	rc = device_create_file(&dev->dev,&dev_attr_id);
+	if (rc) goto err_res;
+
 	return 0;
+
+err_res:
+	device_remove_file(&dev->dev,&dev_attr_resources);
+err_opt:
+	device_remove_file(&dev->dev,&dev_attr_options);
+err:
+	return rc;
 }
