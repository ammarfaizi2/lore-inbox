Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWHCSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWHCSIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHCSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:08:04 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:53596 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932139AbWHCSIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:08:02 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="333810812:sNHT31950864"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 03 Aug 2006 11:07:58 -0700
Message-ID: <adairl9wv41.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Aug 2006 18:08:01.0081 (UTC) FILETIME=[C1DE3290:01C6B727]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

to get a few fixes:

Ishai Rabinovitz:
      IB/srp: Fix crash in srp_reconnect_target
      IB/srp: Work around data corruption bug on Mellanox targets

Jack Morgenstein:
      IB/uverbs: Avoid a crash on device hot remove

Michael S. Tsirkin:
      IB/mthca: Fix mthca_array_clear() thinko

Or Gerlitz:
      IB/ipoib: Remove broken link from Kconfig and documentation

Roland Dreier:
      IB/mthca: Clean up mthca array index mask

Sean Hefty:
      IB/cm: Fix error handling in ib_send_cm_req

 Documentation/infiniband/ipoib.txt            |    2 --
 drivers/infiniband/core/cm.c                  |    4 +++-
 drivers/infiniband/core/uverbs.h              |    2 ++
 drivers/infiniband/core/uverbs_main.c         |    8 +++++++-
 drivers/infiniband/hw/mthca/mthca_allocator.c |   15 ++++++++-------
 drivers/infiniband/ulp/ipoib/Kconfig          |    3 +--
 drivers/infiniband/ulp/srp/ib_srp.c           |   19 +++++++++++++++++--
 7 files changed, 38 insertions(+), 15 deletions(-)


diff --git a/Documentation/infiniband/ipoib.txt b/Documentation/infiniband/ipoib.txt
index 1870355..864ff32 100644
--- a/Documentation/infiniband/ipoib.txt
+++ b/Documentation/infiniband/ipoib.txt
@@ -51,8 +51,6 @@ Debugging Information
 
 References
 
-  IETF IP over InfiniBand (ipoib) Working Group
-    http://ietf.org/html.charters/ipoib-charter.html
   Transmission of IP over InfiniBand (IPoIB) (RFC 4391)
     http://ietf.org/rfc/rfc4391.txt 
   IP over InfiniBand (IPoIB) Architecture (RFC 4392)
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f85c97f..0de335b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -975,8 +975,10 @@ int ib_send_cm_req(struct ib_cm_id *cm_i
 
 	cm_id_priv->timewait_info = cm_create_timewait_info(cm_id_priv->
 							    id.local_id);
-	if (IS_ERR(cm_id_priv->timewait_info))
+	if (IS_ERR(cm_id_priv->timewait_info)) {
+		ret = PTR_ERR(cm_id_priv->timewait_info);
 		goto out;
+	}
 
 	ret = cm_init_av_by_path(param->primary_path, &cm_id_priv->av);
 	if (ret)
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index bb9bee5..102a59c 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -42,6 +42,7 @@ #define UVERBS_H
 #include <linux/kref.h>
 #include <linux/idr.h>
 #include <linux/mutex.h>
+#include <linux/completion.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
@@ -69,6 +70,7 @@ #include <rdma/ib_user_verbs.h>
 
 struct ib_uverbs_device {
 	struct kref				ref;
+	struct completion			comp;
 	int					devnum;
 	struct cdev			       *dev;
 	struct class_device		       *class_dev;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index e725ccc..4e16314 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -122,7 +122,7 @@ static void ib_uverbs_release_dev(struct
 	struct ib_uverbs_device *dev =
 		container_of(ref, struct ib_uverbs_device, ref);
 
-	kfree(dev);
+	complete(&dev->comp);
 }
 
 void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
@@ -740,6 +740,7 @@ static void ib_uverbs_add_one(struct ib_
 		return;
 
 	kref_init(&uverbs_dev->ref);
+	init_completion(&uverbs_dev->comp);
 
 	spin_lock(&map_lock);
 	uverbs_dev->devnum = find_first_zero_bit(dev_map, IB_UVERBS_MAX_DEVICES);
@@ -793,6 +794,8 @@ err_cdev:
 
 err:
 	kref_put(&uverbs_dev->ref, ib_uverbs_release_dev);
+	wait_for_completion(&uverbs_dev->comp);
+	kfree(uverbs_dev);
 	return;
 }
 
@@ -812,7 +815,10 @@ static void ib_uverbs_remove_one(struct 
 	spin_unlock(&map_lock);
 
 	clear_bit(uverbs_dev->devnum, dev_map);
+
 	kref_put(&uverbs_dev->ref, ib_uverbs_release_dev);
+	wait_for_completion(&uverbs_dev->comp);
+	kfree(uverbs_dev);
 }
 
 static int uverbs_event_get_sb(struct file_system_type *fs_type, int flags,
diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index 9ba3211..25157f5 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -108,14 +108,15 @@ void mthca_alloc_cleanup(struct mthca_al
  * serialize access to the array.
  */
 
+#define MTHCA_ARRAY_MASK (PAGE_SIZE / sizeof (void *) - 1)
+
 void *mthca_array_get(struct mthca_array *array, int index)
 {
 	int p = (index * sizeof (void *)) >> PAGE_SHIFT;
 
-	if (array->page_list[p].page) {
-		int i = index & (PAGE_SIZE / sizeof (void *) - 1);
-		return array->page_list[p].page[i];
-	} else
+	if (array->page_list[p].page)
+		return array->page_list[p].page[index & MTHCA_ARRAY_MASK];
+	else
 		return NULL;
 }
 
@@ -130,8 +131,7 @@ int mthca_array_set(struct mthca_array *
 	if (!array->page_list[p].page)
 		return -ENOMEM;
 
-	array->page_list[p].page[index & (PAGE_SIZE / sizeof (void *) - 1)] =
-		value;
+	array->page_list[p].page[index & MTHCA_ARRAY_MASK] = value;
 	++array->page_list[p].used;
 
 	return 0;
@@ -144,7 +144,8 @@ void mthca_array_clear(struct mthca_arra
 	if (--array->page_list[p].used == 0) {
 		free_page((unsigned long) array->page_list[p].page);
 		array->page_list[p].page = NULL;
-	}
+	} else
+		array->page_list[p].page[index & MTHCA_ARRAY_MASK] = NULL;
 
 	if (array->page_list[p].used < 0)
 		pr_debug("Array %p index %d page %d with ref count %d < 0\n",
diff --git a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
index 13d6d01..d74653d 100644
--- a/drivers/infiniband/ulp/ipoib/Kconfig
+++ b/drivers/infiniband/ulp/ipoib/Kconfig
@@ -6,8 +6,7 @@ config INFINIBAND_IPOIB
 	  transports IP packets over InfiniBand so you can use your IB
 	  device as a fancy NIC.
 
-	  The IPoIB protocol is defined by the IETF ipoib working
-	  group: <http://www.ietf.org/html.charters/ipoib-charter.html>.
+	  See Documentation/infiniband/ipoib.txt for more information
 
 config INFINIBAND_IPOIB_DEBUG
 	bool "IP-over-InfiniBand debugging" if EMBEDDED
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 8f472e7..8257d5a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -77,6 +77,14 @@ MODULE_PARM_DESC(topspin_workarounds,
 
 static const u8 topspin_oui[3] = { 0x00, 0x05, 0xad };
 
+static int mellanox_workarounds = 1;
+
+module_param(mellanox_workarounds, int, 0444);
+MODULE_PARM_DESC(mellanox_workarounds,
+		 "Enable workarounds for Mellanox SRP target bugs if != 0");
+
+static const u8 mellanox_oui[3] = { 0x00, 0x02, 0xc9 };
+
 static void srp_add_one(struct ib_device *device);
 static void srp_remove_one(struct ib_device *device);
 static void srp_completion(struct ib_cq *cq, void *target_ptr);
@@ -526,8 +534,10 @@ static int srp_reconnect_target(struct s
 	while (ib_poll_cq(target->cq, 1, &wc) > 0)
 		; /* nothing */
 
+	spin_lock_irq(target->scsi_host->host_lock);
 	list_for_each_entry_safe(req, tmp, &target->req_queue, list)
 		srp_reset_req(target, req);
+	spin_unlock_irq(target->scsi_host->host_lock);
 
 	target->rx_head	 = 0;
 	target->tx_head	 = 0;
@@ -567,7 +577,7 @@ err:
 	return ret;
 }
 
-static int srp_map_fmr(struct srp_device *dev, struct scatterlist *scat,
+static int srp_map_fmr(struct srp_target_port *target, struct scatterlist *scat,
 		       int sg_cnt, struct srp_request *req,
 		       struct srp_direct_buf *buf)
 {
@@ -577,10 +587,15 @@ static int srp_map_fmr(struct srp_device
 	int page_cnt;
 	int i, j;
 	int ret;
+	struct srp_device *dev = target->srp_host->dev;
 
 	if (!dev->fmr_pool)
 		return -ENODEV;
 
+	if ((sg_dma_address(&scat[0]) & ~dev->fmr_page_mask) &&
+	    mellanox_workarounds && !memcmp(&target->ioc_guid, mellanox_oui, 3))
+		return -EINVAL;
+
 	len = page_cnt = 0;
 	for (i = 0; i < sg_cnt; ++i) {
 		if (sg_dma_address(&scat[i]) & ~dev->fmr_page_mask) {
@@ -683,7 +698,7 @@ static int srp_map_data(struct scsi_cmnd
 		buf->va  = cpu_to_be64(sg_dma_address(scat));
 		buf->key = cpu_to_be32(target->srp_host->dev->mr->rkey);
 		buf->len = cpu_to_be32(sg_dma_len(scat));
-	} else if (srp_map_fmr(target->srp_host->dev, scat, count, req,
+	} else if (srp_map_fmr(target, scat, count, req,
 			       (void *) cmd->add_data)) {
 		/*
 		 * FMR mapping failed, and the scatterlist has more
