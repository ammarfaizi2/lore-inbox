Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423156AbWJRXiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423156AbWJRXiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbWJRXiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:38:06 -0400
Received: from [63.64.152.142] ([63.64.152.142]:50190 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423156AbWJRXiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:38:02 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 2/7] drivers/dma: handle sysfs errors
Date: Wed, 18 Oct 2006 16:46:51 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234650.26671.1529.stgit@gitlost.site>
In-Reply-To: <20061018234417.26671.56773.stgit@gitlost.site>
References: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/dmaengine.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1527804..dc65773 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -312,7 +312,7 @@ void dma_async_client_chan_request(struc
 int dma_async_device_register(struct dma_device *device)
 {
 	static int id;
-	int chancnt = 0;
+	int chancnt = 0, rc;
 	struct dma_chan* chan;
 
 	if (!device)
@@ -334,8 +334,15 @@ int dma_async_device_register(struct dma
 		snprintf(chan->class_dev.class_id, BUS_ID_SIZE, "dma%dchan%d",
 		         device->dev_id, chan->chan_id);
 
+		rc = class_device_register(&chan->class_dev);
+		if (rc) {
+			chancnt--;
+			free_percpu(chan->local);
+			chan->local = NULL;
+			goto err_out;
+		}
+
 		kref_get(&device->refcount);
-		class_device_register(&chan->class_dev);
 	}
 
 	mutex_lock(&dma_list_mutex);
@@ -345,6 +352,17 @@ int dma_async_device_register(struct dma
 	dma_chans_rebalance();
 
 	return 0;
+
+err_out:
+	list_for_each_entry(chan, &device->channels, device_node) {
+		if (chan->local == NULL)
+			continue;
+		kref_put(&device->refcount, dma_async_device_cleanup);
+		class_device_unregister(&chan->class_dev);
+		chancnt--;
+		free_percpu(chan->local);
+	}
+	return rc;
 }
 
 /**

