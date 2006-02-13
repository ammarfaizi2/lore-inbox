Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWBMUXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWBMUXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWBMUXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:23:20 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:18468 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964857AbWBMUXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:23:19 -0500
X-IronPort-AV: i="4.02,109,1139212800"; 
   d="scan'208"; a="1775991812:sNHT38071472"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] InfiniBand fixes for 2.6.16-rc3
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Feb 2006 12:23:17 -0800
Message-ID: <ada64nj100a.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Feb 2006 20:23:18.0579 (UTC) FILETIME=[53A2D830:01C630DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Michael S. Tsirkin:
      IPoIB: Don't start send-only joins while multicast thread is stopped
      IPoIB: Fix another send-only join race

Ralph Campbell:
      IB/mad: Handle DR SMPs with a LID routed part

Roland Dreier:
      IB/mthca: Don't print debugging info until we have all values
      IPoIB: Yet another fix for send-only joins
      IB/mthca: bump driver version and release date

 drivers/infiniband/core/mad.c                  |   10 ++++++
 drivers/infiniband/hw/mthca/mthca_cmd.c        |   38 ++++++++++++------------
 drivers/infiniband/hw/mthca/mthca_dev.h        |    4 +--
 drivers/infiniband/ulp/ipoib/ipoib.h           |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   28 +++++++++++++++---
 5 files changed, 55 insertions(+), 26 deletions(-)


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index d393b50..c82f47a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -665,7 +665,15 @@ static int handle_outgoing_dr_smp(struct
 	struct ib_wc mad_wc;
 	struct ib_send_wr *send_wr = &mad_send_wr->send_wr;
 
-	if (!smi_handle_dr_smp_send(smp, device->node_type, port_num)) {
+	/*
+	 * Directed route handling starts if the initial LID routed part of
+	 * a request or the ending LID routed part of a response is empty.
+	 * If we are at the start of the LID routed part, don't update the
+	 * hop_ptr or hop_cnt.  See section 14.2.2, Vol 1 IB spec.
+	 */
+	if ((ib_get_smp_direction(smp) ? smp->dr_dlid : smp->dr_slid) ==
+	     IB_LID_PERMISSIVE &&
+	    !smi_handle_dr_smp_send(smp, device->node_type, port_num)) {
 		ret = -EINVAL;
 		printk(KERN_ERR PFX "Invalid directed route\n");
 		goto out;
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index f9b9b93..2825615 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -1029,25 +1029,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	MTHCA_GET(size, outbox, QUERY_DEV_LIM_UAR_ENTRY_SZ_OFFSET);
 	dev_lim->uar_scratch_entry_sz = size;
 
-	mthca_dbg(dev, "Max QPs: %d, reserved QPs: %d, entry size: %d\n",
-		  dev_lim->max_qps, dev_lim->reserved_qps, dev_lim->qpc_entry_sz);
-	mthca_dbg(dev, "Max SRQs: %d, reserved SRQs: %d, entry size: %d\n",
-		  dev_lim->max_srqs, dev_lim->reserved_srqs, dev_lim->srq_entry_sz);
-	mthca_dbg(dev, "Max CQs: %d, reserved CQs: %d, entry size: %d\n",
-		  dev_lim->max_cqs, dev_lim->reserved_cqs, dev_lim->cqc_entry_sz);
-	mthca_dbg(dev, "Max EQs: %d, reserved EQs: %d, entry size: %d\n",
-		  dev_lim->max_eqs, dev_lim->reserved_eqs, dev_lim->eqc_entry_sz);
-	mthca_dbg(dev, "reserved MPTs: %d, reserved MTTs: %d\n",
-		  dev_lim->reserved_mrws, dev_lim->reserved_mtts);
-	mthca_dbg(dev, "Max PDs: %d, reserved PDs: %d, reserved UARs: %d\n",
-		  dev_lim->max_pds, dev_lim->reserved_pds, dev_lim->reserved_uars);
-	mthca_dbg(dev, "Max QP/MCG: %d, reserved MGMs: %d\n",
-		  dev_lim->max_pds, dev_lim->reserved_mgms);
-	mthca_dbg(dev, "Max CQEs: %d, max WQEs: %d, max SRQ WQEs: %d\n",
-		  dev_lim->max_cq_sz, dev_lim->max_qp_sz, dev_lim->max_srq_sz);
-
-	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
-
 	if (mthca_is_memfree(dev)) {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SRQ_SZ_OFFSET);
 		dev_lim->max_srq_sz = 1 << field;
@@ -1093,6 +1074,25 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
 	}
 
+	mthca_dbg(dev, "Max QPs: %d, reserved QPs: %d, entry size: %d\n",
+		  dev_lim->max_qps, dev_lim->reserved_qps, dev_lim->qpc_entry_sz);
+	mthca_dbg(dev, "Max SRQs: %d, reserved SRQs: %d, entry size: %d\n",
+		  dev_lim->max_srqs, dev_lim->reserved_srqs, dev_lim->srq_entry_sz);
+	mthca_dbg(dev, "Max CQs: %d, reserved CQs: %d, entry size: %d\n",
+		  dev_lim->max_cqs, dev_lim->reserved_cqs, dev_lim->cqc_entry_sz);
+	mthca_dbg(dev, "Max EQs: %d, reserved EQs: %d, entry size: %d\n",
+		  dev_lim->max_eqs, dev_lim->reserved_eqs, dev_lim->eqc_entry_sz);
+	mthca_dbg(dev, "reserved MPTs: %d, reserved MTTs: %d\n",
+		  dev_lim->reserved_mrws, dev_lim->reserved_mtts);
+	mthca_dbg(dev, "Max PDs: %d, reserved PDs: %d, reserved UARs: %d\n",
+		  dev_lim->max_pds, dev_lim->reserved_pds, dev_lim->reserved_uars);
+	mthca_dbg(dev, "Max QP/MCG: %d, reserved MGMs: %d\n",
+		  dev_lim->max_pds, dev_lim->reserved_mgms);
+	mthca_dbg(dev, "Max CQEs: %d, max WQEs: %d, max SRQ WQEs: %d\n",
+		  dev_lim->max_cq_sz, dev_lim->max_qp_sz, dev_lim->max_srq_sz);
+
+	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
+
 out:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 2a165fd..e481037 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -53,8 +53,8 @@
 
 #define DRV_NAME	"ib_mthca"
 #define PFX		DRV_NAME ": "
-#define DRV_VERSION	"0.06"
-#define DRV_RELDATE	"June 23, 2005"
+#define DRV_VERSION	"0.07"
+#define DRV_RELDATE	"February 13, 2006"
 
 enum {
 	MTHCA_FLAG_DDR_HIDDEN = 1 << 1,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index e0a5412..2f85a9a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -78,6 +78,7 @@ enum {
 	IPOIB_FLAG_SUBINTERFACE   = 4,
 	IPOIB_MCAST_RUN 	  = 5,
 	IPOIB_STOP_REAPER         = 6,
+	IPOIB_MCAST_STARTED       = 7,
 
 	IPOIB_MAX_BACKOFF_SECONDS = 16,
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index ccaa0c3..a2408d7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -533,8 +533,10 @@ void ipoib_mcast_join_task(void *dev_ptr
 	}
 
 	if (!priv->broadcast) {
-		priv->broadcast = ipoib_mcast_alloc(dev, 1);
-		if (!priv->broadcast) {
+		struct ipoib_mcast *broadcast;
+
+		broadcast = ipoib_mcast_alloc(dev, 1);
+		if (!broadcast) {
 			ipoib_warn(priv, "failed to allocate broadcast group\n");
 			mutex_lock(&mcast_mutex);
 			if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
@@ -544,10 +546,11 @@ void ipoib_mcast_join_task(void *dev_ptr
 			return;
 		}
 
-		memcpy(priv->broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
+		spin_lock_irq(&priv->lock);
+		memcpy(broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
 		       sizeof (union ib_gid));
+		priv->broadcast = broadcast;
 
-		spin_lock_irq(&priv->lock);
 		__ipoib_mcast_add(dev, priv->broadcast);
 		spin_unlock_irq(&priv->lock);
 	}
@@ -601,6 +604,10 @@ int ipoib_mcast_start_thread(struct net_
 		queue_work(ipoib_workqueue, &priv->mcast_task);
 	mutex_unlock(&mcast_mutex);
 
+	spin_lock_irq(&priv->lock);
+	set_bit(IPOIB_MCAST_STARTED, &priv->flags);
+	spin_unlock_irq(&priv->lock);
+
 	return 0;
 }
 
@@ -611,6 +618,10 @@ int ipoib_mcast_stop_thread(struct net_d
 
 	ipoib_dbg_mcast(priv, "stopping multicast thread\n");
 
+	spin_lock_irq(&priv->lock);
+	clear_bit(IPOIB_MCAST_STARTED, &priv->flags);
+	spin_unlock_irq(&priv->lock);
+
 	mutex_lock(&mcast_mutex);
 	clear_bit(IPOIB_MCAST_RUN, &priv->flags);
 	cancel_delayed_work(&priv->mcast_task);
@@ -693,6 +704,14 @@ void ipoib_mcast_send(struct net_device 
 	 */
 	spin_lock(&priv->lock);
 
+	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags)	||
+	    !priv->broadcast					||
+	    !test_bit(IPOIB_MCAST_FLAG_ATTACHED, &priv->broadcast->flags)) {
+		++priv->stats.tx_dropped;
+		dev_kfree_skb_any(skb);
+		goto unlock;
+	}
+
 	mcast = __ipoib_mcast_find(dev, mgid);
 	if (!mcast) {
 		/* Let's create a new send only group now */
@@ -754,6 +773,7 @@ out:
 		ipoib_send(dev, skb, mcast->ah, IB_MULTICAST_QPN);
 	}
 
+unlock:
 	spin_unlock(&priv->lock);
 }
 
