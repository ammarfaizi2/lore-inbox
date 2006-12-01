Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162315AbWLAX3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162315AbWLAX3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162266AbWLAXXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:46 -0500
Received: from ns1.suse.de ([195.135.220.2]:27533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162260AbWLAXXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:20 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/36] Driver core: convert mmc code to use struct device
Date: Fri,  1 Dec 2006 15:21:50 -0800
Message-Id: <11650153891878-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153861854-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mmc/mmc_queue.c  |    4 ++--
 drivers/mmc/mmc_sysfs.c  |   20 ++++++++++----------
 drivers/mmc/wbsd.c       |    6 +++---
 include/linux/mmc/host.h |    8 ++++----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/mmc_queue.c b/drivers/mmc/mmc_queue.c
index 4ccdd82..61a1de8 100644
--- a/drivers/mmc/mmc_queue.c
+++ b/drivers/mmc/mmc_queue.c
@@ -130,8 +130,8 @@ int mmc_init_queue(struct mmc_queue *mq,
 	u64 limit = BLK_BOUNCE_HIGH;
 	int ret;
 
-	if (host->dev->dma_mask && *host->dev->dma_mask)
-		limit = *host->dev->dma_mask;
+	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
+		limit = *mmc_dev(host)->dma_mask;
 
 	mq->card = card;
 	mq->queue = blk_init_queue(mmc_request, lock);
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index 10cc973..ac53296 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -199,7 +199,7 @@ void mmc_init_card(struct mmc_card *card
 	memset(card, 0, sizeof(struct mmc_card));
 	card->host = host;
 	device_initialize(&card->dev);
-	card->dev.parent = card->host->dev;
+	card->dev.parent = mmc_dev(host);
 	card->dev.bus = &mmc_bus_type;
 	card->dev.release = mmc_release_card;
 }
@@ -242,7 +242,7 @@ void mmc_remove_card(struct mmc_card *ca
 }
 
 
-static void mmc_host_classdev_release(struct class_device *dev)
+static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	kfree(host);
@@ -250,7 +250,7 @@ static void mmc_host_classdev_release(st
 
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
-	.release	= mmc_host_classdev_release,
+	.dev_release	= mmc_host_classdev_release,
 };
 
 static DEFINE_IDR(mmc_host_idr);
@@ -267,10 +267,10 @@ struct mmc_host *mmc_alloc_host_sysfs(in
 	if (host) {
 		memset(host, 0, sizeof(struct mmc_host) + extra);
 
-		host->dev = dev;
-		host->class_dev.dev = host->dev;
+		host->parent = dev;
+		host->class_dev.parent = dev;
 		host->class_dev.class = &mmc_host_class;
-		class_device_initialize(&host->class_dev);
+		device_initialize(&host->class_dev);
 	}
 
 	return host;
@@ -292,10 +292,10 @@ int mmc_add_host_sysfs(struct mmc_host *
 	if (err)
 		return err;
 
-	snprintf(host->class_dev.class_id, BUS_ID_SIZE,
+	snprintf(host->class_dev.bus_id, BUS_ID_SIZE,
 		 "mmc%d", host->index);
 
-	return class_device_add(&host->class_dev);
+	return device_add(&host->class_dev);
 }
 
 /*
@@ -303,7 +303,7 @@ int mmc_add_host_sysfs(struct mmc_host *
  */
 void mmc_remove_host_sysfs(struct mmc_host *host)
 {
-	class_device_del(&host->class_dev);
+	device_del(&host->class_dev);
 
 	spin_lock(&mmc_host_lock);
 	idr_remove(&mmc_host_idr, host->index);
@@ -315,7 +315,7 @@ void mmc_remove_host_sysfs(struct mmc_ho
  */
 void mmc_free_host_sysfs(struct mmc_host *host)
 {
-	class_device_put(&host->class_dev);
+	put_device(&host->class_dev);
 }
 
 static struct workqueue_struct *workqueue;
diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index ced309b..682e62b 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1488,7 +1488,7 @@ static void __devinit wbsd_request_dma(s
 	/*
 	 * Translate the address to a physical address.
 	 */
-	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
+	host->dma_addr = dma_map_single(mmc_dev(host->mmc), host->dma_buffer,
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 
 	/*
@@ -1512,7 +1512,7 @@ kfree:
 	 */
 	BUG_ON(1);
 
-	dma_unmap_single(host->mmc->dev, host->dma_addr,
+	dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 	host->dma_addr = (dma_addr_t)NULL;
 
@@ -1530,7 +1530,7 @@ err:
 static void __devexit wbsd_release_dma(struct wbsd_host *host)
 {
 	if (host->dma_addr) {
-		dma_unmap_single(host->mmc->dev, host->dma_addr,
+		dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
 			WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 	}
 	kfree(host->dma_buffer);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 587264a..528e7d3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -74,8 +74,8 @@ struct mmc_card;
 struct device;
 
 struct mmc_host {
-	struct device		*dev;
-	struct class_device	class_dev;
+	struct device		*parent;
+	struct device		class_dev;
 	int			index;
 	const struct mmc_host_ops *ops;
 	unsigned int		f_min;
@@ -125,8 +125,8 @@ static inline void *mmc_priv(struct mmc_
 	return (void *)host->private;
 }
 
-#define mmc_dev(x)	((x)->dev)
-#define mmc_hostname(x)	((x)->class_dev.class_id)
+#define mmc_dev(x)	((x)->parent)
+#define mmc_hostname(x)	((x)->class_dev.bus_id)
 
 extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);
-- 
1.4.4.1

