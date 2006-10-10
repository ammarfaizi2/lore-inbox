Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWJJHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWJJHAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWJJHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:00:18 -0400
Received: from havoc.gtf.org ([69.61.125.42]:9358 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965049AbWJJHAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:00:16 -0400
Date: Tue, 10 Oct 2006 03:00:15 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH] drivers/dma: handle sysfs errors
Message-ID: <20061010070015.GA21882@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where is a MAINTAINER entry for drivers/dma, or even an email address in
the code?

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/dma/dmaengine.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

08fb6a514ca6a9cdb07388e36d7f22cc2c0375e8
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
