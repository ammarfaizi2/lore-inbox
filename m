Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVDAVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVDAVPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVDAVNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:13:17 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262914AbVDAUvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:25 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][24/27] IB/mthca: encapsulate mem-free check into mthca_is_memfree()
In-Reply-To: <2005411249.5GDmFAellTSOT0Ai@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:54 -0800
Message-Id: <2005411249.qaesrlpuSaCRRPRE@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:54.0200 (UTC) FILETIME=[5B56C980:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up mem-free mode support by introducing mthca_is_memfree() function,
which encapsulates the logic of deciding if a device is mem-free.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_av.c	2005-04-01 12:38:26.648176093 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_av.c	2005-04-01 12:38:30.803274137 -0800
@@ -62,7 +62,7 @@
 
 	ah->type = MTHCA_AH_PCI_POOL;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		ah->av   = kmalloc(sizeof *ah->av, GFP_ATOMIC);
 		if (!ah->av)
 			return -ENOMEM;
@@ -192,7 +192,7 @@
 {
 	int err;
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		return 0;
 
 	err = mthca_alloc_init(&dev->av_table.alloc,
@@ -231,7 +231,7 @@
 
 void __devexit mthca_cleanup_av_table(struct mthca_dev *dev)
 {
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		return;
 
 	if (dev->av_table.av_map)
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:30.084430178 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:30.790276958 -0800
@@ -651,7 +651,7 @@
 	mthca_dbg(dev, "FW version %012llx, max commands %d\n",
 		  (unsigned long long) dev->fw_ver, dev->cmd.max_cmds);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		MTHCA_GET(dev->fw.arbel.fw_pages,       outbox, QUERY_FW_SIZE_OFFSET);
 		MTHCA_GET(dev->fw.arbel.clr_int_base,   outbox, QUERY_FW_CLR_INT_BASE_OFFSET);
 		MTHCA_GET(dev->fw.arbel.eq_arm_base,    outbox, QUERY_FW_EQ_ARM_BASE_OFFSET);
@@ -984,7 +984,7 @@
 
 	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSZ_SRQ_OFFSET);
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
@@ -1148,7 +1148,7 @@
 	/* TPT attributes */
 
 	MTHCA_PUT(inbox, param->mpt_base,   INIT_HCA_MPT_BASE_OFFSET);
-	if (dev->hca_type != ARBEL_NATIVE)
+	if (!mthca_is_memfree(dev))
 		MTHCA_PUT(inbox, param->mtt_seg_sz, INIT_HCA_MTT_SEG_SZ_OFFSET);
 	MTHCA_PUT(inbox, param->log_mpt_sz, INIT_HCA_LOG_MPT_SZ_OFFSET);
 	MTHCA_PUT(inbox, param->mtt_base,   INIT_HCA_MTT_BASE_OFFSET);
@@ -1161,7 +1161,7 @@
 
 	MTHCA_PUT(inbox, param->uar_scratch_base, INIT_HCA_UAR_SCATCH_BASE_OFFSET);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		MTHCA_PUT(inbox, param->log_uarc_sz, INIT_HCA_UARC_SZ_OFFSET);
 		MTHCA_PUT(inbox, param->log_uar_sz,  INIT_HCA_LOG_UAR_SZ_OFFSET);
 		MTHCA_PUT(inbox, param->uarc_base,   INIT_HCA_UAR_CTX_BASE_OFFSET);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-01 12:38:26.177278312 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-01 12:38:30.794276090 -0800
@@ -180,7 +180,7 @@
 {
 	u32 doorbell[2];
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		*cq->set_ci_db = cpu_to_be32(cq->cons_index);
 		wmb();
 	} else {
@@ -760,7 +760,7 @@
 	if (cq->cqn == -1)
 		return -ENOMEM;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		cq->arm_sn = 1;
 
 		err = mthca_table_get(dev, dev->cq_table.table, cq->cqn);
@@ -811,7 +811,7 @@
 	cq_context->lkey            = cpu_to_be32(cq->mr.ibmr.lkey);
 	cq_context->cqn             = cpu_to_be32(cq->cqn);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		cq_context->ci_db    = cpu_to_be32(cq->set_ci_db_index);
 		cq_context->state_db = cpu_to_be32(cq->arm_db_index);
 	}
@@ -851,11 +851,11 @@
 err_out_mailbox:
 	kfree(mailbox);
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
 err_out_ci:
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 
 err_out_icm:
@@ -916,7 +916,7 @@
 	mthca_free_mr(dev, &cq->mr);
 	mthca_free_cq_buf(dev, cq);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 		mthca_table_put(dev, dev->cq_table.table, cq->cqn);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:29.460565601 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:30.772280864 -0800
@@ -470,4 +470,9 @@
 	return container_of(ibdev, struct mthca_dev, ib_dev);
 }
 
+static inline int mthca_is_memfree(struct mthca_dev *dev)
+{
+	return dev->hca_type == ARBEL_NATIVE;
+}
+
 #endif /* MTHCA_DEV_H */
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-04-01 12:38:24.575625986 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-04-01 12:38:30.799275005 -0800
@@ -198,7 +198,7 @@
 
 static inline void set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
 {
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		arbel_set_eq_ci(dev, eq, ci);
 	else
 		tavor_set_eq_ci(dev, eq, ci);
@@ -223,7 +223,7 @@
 
 static inline void disarm_cq(struct mthca_dev *dev, int eqn, int cqn)
 {
-	if (dev->hca_type != ARBEL_NATIVE) {
+	if (!mthca_is_memfree(dev)) {
 		u32 doorbell[2];
 
 		doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_DISARM_CQ | eqn);
@@ -535,11 +535,11 @@
 						  MTHCA_EQ_OWNER_HW    |
 						  MTHCA_EQ_STATE_ARMED |
 						  MTHCA_EQ_FLAG_TR);
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		eq_context->flags  |= cpu_to_be32(MTHCA_EQ_STATE_ARBEL);
 
 	eq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24);
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		eq_context->arbel_pd = cpu_to_be32(dev->driver_pd.pd_num);
 	} else {
 		eq_context->logsize_usrpage |= cpu_to_be32(dev->driver_uar.index);
@@ -686,7 +686,7 @@
 
 	mthca_base = pci_resource_start(dev->pdev, 0);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		/*
 		 * We assume that the EQ arm and EQ set CI registers
 		 * fall within the first BAR.  We can't trust the
@@ -756,7 +756,7 @@
 
 static void __devexit mthca_unmap_eq_regs(struct mthca_dev *dev)
 {
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
 				dev->fw.arbel.eq_set_ci_base,
 				MTHCA_EQ_SET_CI_SIZE,
@@ -880,7 +880,7 @@
 
 		for (i = 0; i < MTHCA_NUM_EQ; ++i) {
 			err = request_irq(dev->eq_table.eq[i].msi_x_vector,
-					  dev->hca_type == ARBEL_NATIVE ?
+					  mthca_is_memfree(dev) ?
 					  mthca_arbel_msi_x_interrupt :
 					  mthca_tavor_msi_x_interrupt,
 					  0, eq_name[i], dev->eq_table.eq + i);
@@ -890,7 +890,7 @@
 		}
 	} else {
 		err = request_irq(dev->pdev->irq,
-				  dev->hca_type == ARBEL_NATIVE ?
+				  mthca_is_memfree(dev) ?
 				  mthca_arbel_interrupt :
 				  mthca_tavor_interrupt,
 				  SA_SHIRQ, DRV_NAME, dev);
@@ -918,7 +918,7 @@
 			   dev->eq_table.eq[MTHCA_EQ_CMD].eqn, status);
 
 	for (i = 0; i < MTHCA_EQ_CMD; ++i)
-		if (dev->hca_type == ARBEL_NATIVE)
+		if (mthca_is_memfree(dev))
 			arbel_eq_req_not(dev, dev->eq_table.eq[i].eqn_mask);
 		else
 			tavor_eq_req_not(dev, dev->eq_table.eq[i].eqn);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:29.466564299 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:30.776279996 -0800
@@ -601,7 +601,7 @@
 
 static int __devinit mthca_init_hca(struct mthca_dev *mdev)
 {
-	if (mdev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(mdev))
 		return mthca_init_arbel(mdev);
 	else
 		return mthca_init_tavor(mdev);
@@ -835,7 +835,7 @@
 
 	mthca_CLOSE_HCA(mdev, 0, &status);
 
-	if (mdev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(mdev)) {
 		mthca_free_icm_table(mdev, mdev->cq_table.table);
 		mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 		mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
@@ -939,7 +939,7 @@
 	mdev->pdev     = pdev;
 	mdev->hca_type = id->driver_data;
 
-	if (mdev->hca_type == ARBEL_NATIVE && !mthca_memfree_warned++)
+	if (mthca_is_memfree(mdev) && !mthca_memfree_warned++)
 		mthca_warn(mdev, "Warning: native MT25208 mode support is incomplete.  "
 			   "Your HCA may not work properly.\n");
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:28.285820606 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:30.831268060 -0800
@@ -472,7 +472,7 @@
 {
 	int i;
 
-	if (dev->hca_type != ARBEL_NATIVE)
+	if (!mthca_is_memfree(dev))
 		return 0;
 
 	dev->db_tab = kmalloc(sizeof *dev->db_tab, GFP_KERNEL);
@@ -504,7 +504,7 @@
 	int i;
 	u8 status;
 
-	if (dev->hca_type != ARBEL_NATIVE)
+	if (!mthca_is_memfree(dev))
 		return;
 
 	/*
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:29.493558440 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:30.822270013 -0800
@@ -181,7 +181,7 @@
 	if (seg == -1)
 		return -1;
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		if (mthca_table_get_range(dev, dev->mr_table.mtt_table, seg,
 					  seg + (1 << order) - 1)) {
 			mthca_buddy_free(buddy, seg, order);
@@ -196,7 +196,7 @@
 {
 	mthca_buddy_free(buddy, seg, order);
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_table_put_range(dev, dev->mr_table.mtt_table, seg,
 				      seg + (1 << order) - 1);
 }
@@ -223,7 +223,7 @@
 
 static inline u32 hw_index_to_key(struct mthca_dev *dev, u32 ind)
 {
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		return arbel_hw_index_to_key(ind);
 	else
 		return tavor_hw_index_to_key(ind);
@@ -231,7 +231,7 @@
 
 static inline u32 key_to_hw_index(struct mthca_dev *dev, u32 key)
 {
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		return arbel_key_to_hw_index(key);
 	else
 		return tavor_key_to_hw_index(key);
@@ -254,7 +254,7 @@
 		return -ENOMEM;
 	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
 		if (err)
 			goto err_out_mpt_free;
@@ -299,7 +299,7 @@
 	return err;
 
 err_out_table:
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
@@ -329,7 +329,7 @@
 		return -ENOMEM;
 	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
 		if (err)
 			goto err_out_mpt_free;
@@ -437,7 +437,7 @@
 	mthca_free_mtt(dev, mr->first_seg, mr->order, &dev->mr_table.mtt_buddy);
 
 err_out_table:
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
@@ -452,7 +452,7 @@
 	if (order >= 0)
 		mthca_free_mtt(dev, first_seg, order, buddy);
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_table_put(dev, dev->mr_table.mpt_table,
 				arbel_key_to_hw_index(lkey));
 
@@ -498,7 +498,7 @@
 		return -EINVAL;
 
 	/* For Arbel, all MTTs must fit in the same page. */
-	if (dev->hca_type == ARBEL_NATIVE &&
+	if (mthca_is_memfree(dev) &&
 	    mr->attr.max_pages * sizeof *mr->mem.arbel.mtts > PAGE_SIZE)
 		return -EINVAL;
 
@@ -511,7 +511,7 @@
 	idx = key & (dev->limits.num_mpts - 1);
 	mr->ibmr.rkey = mr->ibmr.lkey = hw_index_to_key(dev, key);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		err = mthca_table_get(dev, dev->mr_table.mpt_table, key);
 		if (err)
 			goto err_out_mpt_free;
@@ -534,7 +534,7 @@
 
 	mtt_seg = mr->first_seg * MTHCA_MTT_SEG_SIZE;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		mr->mem.arbel.mtts = mthca_table_find(dev->mr_table.mtt_table,
 						      mr->first_seg);
 		BUG_ON(!mr->mem.arbel.mtts);
@@ -596,7 +596,7 @@
 		       dev->mr_table.fmr_mtt_buddy);
 
 err_out_table:
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
@@ -765,7 +765,7 @@
 	if (err)
 		return err;
 
-	if (dev->hca_type != ARBEL_NATIVE &&
+	if (!mthca_is_memfree(dev) &&
 	    (dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN))
 		dev->limits.fmr_reserved_mtts = 0;
 	else
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-01 12:38:29.480561261 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-01 12:38:30.785278043 -0800
@@ -116,11 +116,11 @@
 		profile[i].type     = i;
 		profile[i].log_num  = max(ffs(profile[i].num) - 1, 0);
 		profile[i].size    *= profile[i].num;
-		if (dev->hca_type == ARBEL_NATIVE)
+		if (mthca_is_memfree(dev))
 			profile[i].size = max(profile[i].size, (u64) PAGE_SIZE);
 	}
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		mem_base  = 0;
 		mem_avail = dev_lim->hca.arbel.max_icm_sz;
 	} else {
@@ -165,7 +165,7 @@
 				  (unsigned long long) profile[i].size);
 	}
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		mthca_dbg(dev, "HCA context memory: reserving %d KB\n",
 			  (int) (total_size >> 10));
 	else
@@ -267,7 +267,7 @@
 	 * out of the MR pool. They don't use additional memory, but
 	 * we assign them as part of the HCA profile anyway.
 	 */
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		dev->limits.fmr_reserved_mtts = 0;
 	else
 		dev->limits.fmr_reserved_mtts = request->fmr_reserved_mtts;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:29.471563214 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:30.780279128 -0800
@@ -625,7 +625,7 @@
 	if (!mdev)
 		return 0;
 
-	if (mdev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(mdev)) {
 		list_for_each_entry(fmr, fmr_list, list)
 			mthca_arbel_fmr_unmap(mdev, to_mfmr(fmr));
 
@@ -710,7 +710,7 @@
 		dev->ib_dev.alloc_fmr            = mthca_alloc_fmr;
 		dev->ib_dev.unmap_fmr            = mthca_unmap_fmr;
 		dev->ib_dev.dealloc_fmr          = mthca_dealloc_fmr;
-		if (dev->hca_type == ARBEL_NATIVE)
+		if (mthca_is_memfree(dev))
 			dev->ib_dev.map_phys_fmr = mthca_arbel_map_phys_fmr;
 		else
 			dev->ib_dev.map_phys_fmr = mthca_tavor_map_phys_fmr;
@@ -720,7 +720,7 @@
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
 		dev->ib_dev.post_send     = mthca_arbel_post_send;
 		dev->ib_dev.post_recv     = mthca_arbel_post_receive;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:26.181277444 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:30.827268928 -0800
@@ -639,7 +639,7 @@
 	else if (attr_mask & IB_QP_PATH_MTU)
 		qp_context->mtu_msgmax = (attr->path_mtu << 5) | 31;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		qp_context->rq_size_stride =
 			((ffs(qp->rq.max) - 1) << 3) | (qp->rq.wqe_shift - 4);
 		qp_context->sq_size_stride =
@@ -731,7 +731,7 @@
 		qp_context->next_send_psn = cpu_to_be32(attr->sq_psn);
 	qp_context->cqn_snd = cpu_to_be32(to_mcq(ibqp->send_cq)->cqn);
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		qp_context->snd_wqe_base_l = cpu_to_be32(qp->send_wqe_offset);
 		qp_context->snd_db_index   = cpu_to_be32(qp->sq.db_index);
 	}
@@ -822,7 +822,7 @@
 
 	qp_context->cqn_rcv = cpu_to_be32(to_mcq(ibqp->recv_cq)->cqn);
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		qp_context->rcv_db_index   = cpu_to_be32(qp->rq.db_index);
 
 	if (attr_mask & IB_QP_QKEY) {
@@ -897,7 +897,7 @@
 		size += 2 * sizeof (struct mthca_data_seg);
 		break;
 	case UD:
-		if (dev->hca_type == ARBEL_NATIVE)
+		if (mthca_is_memfree(dev))
 			size += sizeof (struct mthca_arbel_ud_seg);
 		else
 			size += sizeof (struct mthca_tavor_ud_seg);
@@ -1016,7 +1016,7 @@
 {
 	int ret = 0;
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		ret = mthca_table_get(dev, dev->qp_table.qp_table, qp->qpn);
 		if (ret)
 			return ret;
@@ -1057,7 +1057,7 @@
 static void mthca_free_memfree(struct mthca_dev *dev,
 			       struct mthca_qp *qp)
 {
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
 		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
@@ -1104,7 +1104,7 @@
 		return ret;
 	}
 
-	if (dev->hca_type == ARBEL_NATIVE) {
+	if (mthca_is_memfree(dev)) {
 		for (i = 0; i < qp->rq.max; ++i) {
 			wqe = get_recv_wqe(qp, i);
 			wqe->nda_op = cpu_to_be32(((i + 1) & (qp->rq.max - 1)) <<
@@ -1127,7 +1127,7 @@
 {
 	int i;
 
-	if (dev->hca_type != ARBEL_NATIVE)
+	if (!mthca_is_memfree(dev))
 		return;
 
 	for (i = 0; 1 << i < qp->rq.max; ++i)
@@ -2011,7 +2011,7 @@
 	else
 		next = get_recv_wqe(qp, index);
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (mthca_is_memfree(dev))
 		*dbd = 1;
 	else
 		*dbd = !!(next->ee_nds & cpu_to_be32(MTHCA_NEXT_DBD));

