Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWJJPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWJJPQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWJJPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:16:48 -0400
Received: from havoc.gtf.org ([69.61.125.42]:8858 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750840AbWJJPQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:16:48 -0400
Date: Tue, 10 Oct 2006 11:16:47 -0400
From: Jeff Garzik <jeff@garzik.org>
To: jejb@steeleye.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/mca: handle sysfs errors
Message-ID: <20061010151647.GA15678@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also includes a kmalloc->kzalloc cleanup.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/mca/mca-bus.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/mca/mca-bus.c b/drivers/mca/mca-bus.c
index 09baa43..da862e4 100644
--- a/drivers/mca/mca-bus.c
+++ b/drivers/mca/mca-bus.c
@@ -100,6 +100,7 @@ static DEVICE_ATTR(pos, S_IRUGO, mca_sho
 int __init mca_register_device(int bus, struct mca_device *mca_dev)
 {
 	struct mca_bus *mca_bus = mca_root_busses[bus];
+	int rc;
 
 	mca_dev->dev.parent = &mca_bus->dev;
 	mca_dev->dev.bus = &mca_bus_type;
@@ -108,13 +109,23 @@ int __init mca_register_device(int bus, 
 	mca_dev->dev.dma_mask = &mca_dev->dma_mask;
 	mca_dev->dev.coherent_dma_mask = mca_dev->dma_mask;
 
-	if (device_register(&mca_dev->dev))
-		return 0;
+	rc = device_register(&mca_dev->dev);
+	if (rc)
+		goto err_out;
 
-	device_create_file(&mca_dev->dev, &dev_attr_id);
-	device_create_file(&mca_dev->dev, &dev_attr_pos);
+	rc = device_create_file(&mca_dev->dev, &dev_attr_id);
+	if (rc) goto err_out_devreg;
+	rc = device_create_file(&mca_dev->dev, &dev_attr_pos);
+	if (rc) goto err_out_id;
 
 	return 1;
+
+err_out_id:
+	device_remove_file(&mca_dev->dev, &dev_attr_id);
+err_out_devreg:
+	device_unregister(&mca_dev->dev);
+err_out:
+	return 0;
 }
 
 /* */
@@ -130,13 +141,16 @@ struct mca_bus * __devinit mca_attach_bu
 		return NULL;
 	}
 
-	mca_bus = kmalloc(sizeof(struct mca_bus), GFP_KERNEL);
+	mca_bus = kzalloc(sizeof(struct mca_bus), GFP_KERNEL);
 	if (!mca_bus)
 		return NULL;
-	memset(mca_bus, 0, sizeof(struct mca_bus));
+
 	sprintf(mca_bus->dev.bus_id,"mca%d",bus);
 	sprintf(mca_bus->name,"Host %s MCA Bridge", bus ? "Secondary" : "Primary");
-	device_register(&mca_bus->dev);
+	if (device_register(&mca_bus->dev)) {
+		kfree(mca_bus);
+		return NULL;
+	}
 
 	mca_root_busses[bus] = mca_bus;
 
