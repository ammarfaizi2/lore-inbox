Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422760AbWHYS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWHYS3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWHYSZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:23 -0400
Received: from mx.pathscale.com ([64.160.42.68]:39810 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422733AbWHYSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:18 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 23] IB/ipath - lock resource limit counters correctly
X-Mercurial-Node: 4326e8fdb03d3ca806c60f958dd8bf9a894311a7
Message-Id: <4326e8fdb03d3ca806c6.1156530267@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:27 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:44 2006 -0700
@@ -776,18 +776,22 @@ static struct ib_pd *ipath_alloc_pd(stru
 	 * we allow allocations of more than we report for this value.
 	 */
 
-	if (dev->n_pds_allocated == ib_ipath_max_pds) {
-		ret = ERR_PTR(-ENOMEM);
-		goto bail;
-	}
-
 	pd = kmalloc(sizeof *pd, GFP_KERNEL);
 	if (!pd) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
 
+	spin_lock(&dev->n_pds_lock);
+	if (dev->n_pds_allocated == ib_ipath_max_pds) {
+		spin_unlock(&dev->n_pds_lock);
+		kfree(pd);
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
 	dev->n_pds_allocated++;
+	spin_unlock(&dev->n_pds_lock);
 
 	/* ib_alloc_pd() will initialize pd->ibpd. */
 	pd->user = udata != NULL;
@@ -803,7 +807,9 @@ static int ipath_dealloc_pd(struct ib_pd
 	struct ipath_pd *pd = to_ipd(ibpd);
 	struct ipath_ibdev *dev = to_idev(ibpd->device);
 
+	spin_lock(&dev->n_pds_lock);
 	dev->n_pds_allocated--;
+	spin_unlock(&dev->n_pds_lock);
 
 	kfree(pd);
 
@@ -824,11 +830,6 @@ static struct ib_ah *ipath_create_ah(str
 	struct ib_ah *ret;
 	struct ipath_ibdev *dev = to_idev(pd->device);
 
-	if (dev->n_ahs_allocated == ib_ipath_max_ahs) {
-		ret = ERR_PTR(-ENOMEM);
-		goto bail;
-	}
-
 	/* A multicast address requires a GRH (see ch. 8.4.1). */
 	if (ah_attr->dlid >= IPATH_MULTICAST_LID_BASE &&
 	    ah_attr->dlid != IPATH_PERMISSIVE_LID &&
@@ -854,7 +855,16 @@ static struct ib_ah *ipath_create_ah(str
 		goto bail;
 	}
 
+	spin_lock(&dev->n_ahs_lock);
+	if (dev->n_ahs_allocated == ib_ipath_max_ahs) {
+		spin_unlock(&dev->n_ahs_lock);
+		kfree(ah);
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
 	dev->n_ahs_allocated++;
+	spin_unlock(&dev->n_ahs_lock);
 
 	/* ib_create_ah() will initialize ah->ibah. */
 	ah->attr = *ah_attr;
@@ -876,7 +886,9 @@ static int ipath_destroy_ah(struct ib_ah
 	struct ipath_ibdev *dev = to_idev(ibah->device);
 	struct ipath_ah *ah = to_iah(ibah);
 
+	spin_lock(&dev->n_ahs_lock);
 	dev->n_ahs_allocated--;
+	spin_unlock(&dev->n_ahs_lock);
 
 	kfree(ah);
 
@@ -963,6 +975,12 @@ static void *ipath_register_ib_device(in
 	dev = &idev->ibdev;
 
 	/* Only need to initialize non-zero fields. */
+	spin_lock_init(&idev->n_pds_lock);
+	spin_lock_init(&idev->n_ahs_lock);
+	spin_lock_init(&idev->n_cqs_lock);
+	spin_lock_init(&idev->n_srqs_lock);
+	spin_lock_init(&idev->n_mcast_grps_lock);
+
 	spin_lock_init(&idev->qp_table.lock);
 	spin_lock_init(&idev->lk_table.lock);
 	idev->sm_lid = __constant_be16_to_cpu(IB_LID_PERMISSIVE);
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:44 2006 -0700
@@ -434,11 +434,18 @@ struct ipath_ibdev {
 	__be64 sys_image_guid;	/* in network order */
 	__be64 gid_prefix;	/* in network order */
 	__be64 mkey;
+
 	u32 n_pds_allocated;	/* number of PDs allocated for device */
+	spinlock_t n_pds_lock;
 	u32 n_ahs_allocated;	/* number of AHs allocated for device */
+	spinlock_t n_ahs_lock;
 	u32 n_cqs_allocated;	/* number of CQs allocated for device */
+	spinlock_t n_cqs_lock;
 	u32 n_srqs_allocated;	/* number of SRQs allocated for device */
+	spinlock_t n_srqs_lock;
 	u32 n_mcast_grps_allocated; /* number of mcast groups allocated */
+	spinlock_t n_mcast_grps_lock;
+
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri Aug 25 11:19:44 2006 -0700
@@ -207,12 +207,15 @@ static int ipath_mcast_add(struct ipath_
 		goto bail;
 	}
 
+	spin_lock(&dev->n_mcast_grps_lock);
 	if (dev->n_mcast_grps_allocated == ib_ipath_max_mcast_grps) {
+		spin_unlock(&dev->n_mcast_grps_lock);
 		ret = ENOMEM;
 		goto bail;
 	}
 
 	dev->n_mcast_grps_allocated++;
+	spin_unlock(&dev->n_mcast_grps_lock);
 
 	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
 
@@ -343,7 +346,9 @@ int ipath_multicast_detach(struct ib_qp 
 		atomic_dec(&mcast->refcount);
 		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
 		ipath_mcast_free(mcast);
+		spin_lock(&dev->n_mcast_grps_lock);
 		dev->n_mcast_grps_allocated--;
+		spin_unlock(&dev->n_mcast_grps_lock);
 	}
 
 	ret = 0;
