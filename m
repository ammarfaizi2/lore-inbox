Return-Path: <linux-kernel-owner+w=401wt.eu-S932255AbWLPE5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWLPE5d (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 23:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbWLPE5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 23:57:32 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:10976 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbWLPE5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 23:57:31 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 15 Dec 2006 20:57:29 -0800
Message-ID: <adawt4sigjq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Dec 2006 04:57:30.0061 (UTC) FILETIME=[B08B27D0:01C720CE]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

A couple of fixes for semi-nasty bugs on 32-bit architectures, plus
one small mthca driver update:

Leonid Arsh (1):
      IB/mthca: Add HCA profile module parameters

Roland Dreier (3):
      IB: Fix ib_dma_alloc_coherent() wrapper
      IB/srp: Fix FMR mapping for 32-bit kernels and addresses above 4G
      IB/mthca: Use DEFINE_MUTEX() instead of mutex_init()

 drivers/infiniband/hw/mthca/mthca_main.c |  113 +++++++++++++++++++++++++----
 drivers/infiniband/ulp/srp/ib_srp.c      |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.h      |    2 +-
 include/rdma/ib_verbs.h                  |    9 ++-
 4 files changed, 107 insertions(+), 19 deletions(-)


diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 0491ec7..44bc6cc 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -80,24 +80,61 @@ static int tune_pci = 0;
 module_param(tune_pci, int, 0444);
 MODULE_PARM_DESC(tune_pci, "increase PCI burst from the default set by BIOS if nonzero");
 
-struct mutex mthca_device_mutex;
+DEFINE_MUTEX(mthca_device_mutex);
+
+#define MTHCA_DEFAULT_NUM_QP            (1 << 16)
+#define MTHCA_DEFAULT_RDB_PER_QP        (1 << 2)
+#define MTHCA_DEFAULT_NUM_CQ            (1 << 16)
+#define MTHCA_DEFAULT_NUM_MCG           (1 << 13)
+#define MTHCA_DEFAULT_NUM_MPT           (1 << 17)
+#define MTHCA_DEFAULT_NUM_MTT           (1 << 20)
+#define MTHCA_DEFAULT_NUM_UDAV          (1 << 15)
+#define MTHCA_DEFAULT_NUM_RESERVED_MTTS (1 << 18)
+#define MTHCA_DEFAULT_NUM_UARC_SIZE     (1 << 18)
+
+static struct mthca_profile hca_profile = {
+	.num_qp             = MTHCA_DEFAULT_NUM_QP,
+	.rdb_per_qp         = MTHCA_DEFAULT_RDB_PER_QP,
+	.num_cq             = MTHCA_DEFAULT_NUM_CQ,
+	.num_mcg            = MTHCA_DEFAULT_NUM_MCG,
+	.num_mpt            = MTHCA_DEFAULT_NUM_MPT,
+	.num_mtt            = MTHCA_DEFAULT_NUM_MTT,
+	.num_udav           = MTHCA_DEFAULT_NUM_UDAV,          /* Tavor only */
+	.fmr_reserved_mtts  = MTHCA_DEFAULT_NUM_RESERVED_MTTS, /* Tavor only */
+	.uarc_size          = MTHCA_DEFAULT_NUM_UARC_SIZE,     /* Arbel only */
+};
+
+module_param_named(num_qp, hca_profile.num_qp, int, 0444);
+MODULE_PARM_DESC(num_qp, "maximum number of QPs per HCA");
+
+module_param_named(rdb_per_qp, hca_profile.rdb_per_qp, int, 0444);
+MODULE_PARM_DESC(rdb_per_qp, "number of RDB buffers per QP");
+
+module_param_named(num_cq, hca_profile.num_cq, int, 0444);
+MODULE_PARM_DESC(num_cq, "maximum number of CQs per HCA");
+
+module_param_named(num_mcg, hca_profile.num_mcg, int, 0444);
+MODULE_PARM_DESC(num_mcg, "maximum number of multicast groups per HCA");
+
+module_param_named(num_mpt, hca_profile.num_mpt, int, 0444);
+MODULE_PARM_DESC(num_mpt,
+		"maximum number of memory protection table entries per HCA");
+
+module_param_named(num_mtt, hca_profile.num_mtt, int, 0444);
+MODULE_PARM_DESC(num_mtt,
+		 "maximum number of memory translation table segments per HCA");
+
+module_param_named(num_udav, hca_profile.num_udav, int, 0444);
+MODULE_PARM_DESC(num_udav, "maximum number of UD address vectors per HCA");
+
+module_param_named(fmr_reserved_mtts, hca_profile.fmr_reserved_mtts, int, 0444);
+MODULE_PARM_DESC(fmr_reserved_mtts,
+		 "number of memory translation table segments reserved for FMR");
 
 static const char mthca_version[] __devinitdata =
 	DRV_NAME ": Mellanox InfiniBand HCA driver v"
 	DRV_VERSION " (" DRV_RELDATE ")\n";
 
-static struct mthca_profile default_profile = {
-	.num_qp		   = 1 << 16,
-	.rdb_per_qp	   = 4,
-	.num_cq		   = 1 << 16,
-	.num_mcg	   = 1 << 13,
-	.num_mpt	   = 1 << 17,
-	.num_mtt	   = 1 << 20,
-	.num_udav	   = 1 << 15,	/* Tavor only */
-	.fmr_reserved_mtts = 1 << 18,	/* Tavor only */
-	.uarc_size	   = 1 << 18,	/* Arbel only */
-};
-
 static int mthca_tune_pci(struct mthca_dev *mdev)
 {
 	int cap;
@@ -303,7 +340,7 @@ static int mthca_init_tavor(struct mthca_dev *mdev)
 		goto err_disable;
 	}
 
-	profile = default_profile;
+	profile = hca_profile;
 	profile.num_uar   = dev_lim.uar_size / PAGE_SIZE;
 	profile.uarc_size = 0;
 	if (mdev->mthca_flags & MTHCA_FLAG_SRQ)
@@ -621,7 +658,7 @@ static int mthca_init_arbel(struct mthca_dev *mdev)
 		goto err_stop_fw;
 	}
 
-	profile = default_profile;
+	profile = hca_profile;
 	profile.num_uar  = dev_lim.uar_size / PAGE_SIZE;
 	profile.num_udav = 0;
 	if (mdev->mthca_flags & MTHCA_FLAG_SRQ)
@@ -1278,11 +1315,55 @@ static struct pci_driver mthca_driver = {
 	.remove		= __devexit_p(mthca_remove_one)
 };
 
+static void __init __mthca_check_profile_val(const char *name, int *pval,
+					     int pval_default)
+{
+	/* value must be positive and power of 2 */
+	int old_pval = *pval;
+
+	if (old_pval <= 0)
+		*pval = pval_default;
+	else
+		*pval = roundup_pow_of_two(old_pval);
+
+	if (old_pval != *pval) {
+		printk(KERN_WARNING PFX "Invalid value %d for %s in module parameter.\n",
+		       old_pval, name);
+		printk(KERN_WARNING PFX "Corrected %s to %d.\n", name, *pval);
+	}
+}
+
+#define mthca_check_profile_val(name, default)				\
+	__mthca_check_profile_val(#name, &hca_profile.name, default)
+
+static void __init mthca_validate_profile(void)
+{
+	mthca_check_profile_val(num_qp,            MTHCA_DEFAULT_NUM_QP);
+	mthca_check_profile_val(rdb_per_qp,        MTHCA_DEFAULT_RDB_PER_QP);
+	mthca_check_profile_val(num_cq,            MTHCA_DEFAULT_NUM_CQ);
+	mthca_check_profile_val(num_mcg, 	   MTHCA_DEFAULT_NUM_MCG);
+	mthca_check_profile_val(num_mpt, 	   MTHCA_DEFAULT_NUM_MPT);
+	mthca_check_profile_val(num_mtt, 	   MTHCA_DEFAULT_NUM_MTT);
+	mthca_check_profile_val(num_udav,          MTHCA_DEFAULT_NUM_UDAV);
+	mthca_check_profile_val(fmr_reserved_mtts, MTHCA_DEFAULT_NUM_RESERVED_MTTS);
+
+	if (hca_profile.fmr_reserved_mtts >= hca_profile.num_mtt) {
+		printk(KERN_WARNING PFX "Invalid fmr_reserved_mtts module parameter %d.\n",
+		       hca_profile.fmr_reserved_mtts);
+		printk(KERN_WARNING PFX "(Must be smaller than num_mtt %d)\n",
+		       hca_profile.num_mtt);
+		hca_profile.fmr_reserved_mtts = hca_profile.num_mtt / 2;
+		printk(KERN_WARNING PFX "Corrected fmr_reserved_mtts to %d.\n",
+		       hca_profile.fmr_reserved_mtts);
+	}
+}
+
 static int __init mthca_init(void)
 {
 	int ret;
 
-	mutex_init(&mthca_device_mutex);
+	mthca_validate_profile();
+
 	ret = mthca_catas_init();
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index e9b6a6f..cdecbf5 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1898,7 +1898,7 @@ static void srp_add_one(struct ib_device *device)
 	 */
 	srp_dev->fmr_page_shift = max(9, ffs(dev_attr->page_size_cap) - 1);
 	srp_dev->fmr_page_size  = 1 << srp_dev->fmr_page_shift;
-	srp_dev->fmr_page_mask  = ~((unsigned long) srp_dev->fmr_page_size - 1);
+	srp_dev->fmr_page_mask  = ~((u64) srp_dev->fmr_page_size - 1);
 
 	INIT_LIST_HEAD(&srp_dev->dev_list);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 868a540..c217723 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -87,7 +87,7 @@ struct srp_device {
 	struct ib_fmr_pool     *fmr_pool;
 	int			fmr_page_shift;
 	int			fmr_page_size;
-	unsigned long		fmr_page_mask;
+	u64			fmr_page_mask;
 };
 
 struct srp_host {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3c2e105..0bfa332 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1639,7 +1639,14 @@ static inline void *ib_dma_alloc_coherent(struct ib_device *dev,
 {
 	if (dev->dma_ops)
 		return dev->dma_ops->alloc_coherent(dev, size, dma_handle, flag);
-	return dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
+	else {
+		dma_addr_t handle;
+		void *ret;
+
+		ret = dma_alloc_coherent(dev->dma_device, size, &handle, flag);
+		*dma_handle = handle;
+		return ret;
+	}
 }
 
 /**
