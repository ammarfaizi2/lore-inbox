Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVDLSka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVDLSka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDLSjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:39:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:3275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262300AbVDLKeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:01 -0400
Message-Id: <200504121033.j3CAXZEZ005918@shell0.pdx.osdl.net>
Subject: [patch 189/198] IB/mthca: add support for new MT25204 HCA
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Decouple table of HCA features from exact HCA device type.  Add a current FW
version field so we can warn when someone is using old FW.  Add support for
new MT25204 HCA.

Remove the warning about mem-free support, since it should be pretty solid at
this point.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h      |   13 +--
 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c     |   67 +++++++++++++++----
 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |   17 +++-
 25-akpm/drivers/infiniband/hw/mthca/mthca_reset.c    |    2 
 4 files changed, 73 insertions(+), 26 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-add-support-for-new-mt25204-hca drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-add-support-for-new-mt25204-hca	2005-04-12 03:21:48.431774152 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:48.439772936 -0700
@@ -49,20 +49,15 @@
 #define DRV_VERSION	"0.06-pre"
 #define DRV_RELDATE	"November 8, 2004"
 
-/* Types of supported HCA */
-enum {
-	TAVOR,			/* MT23108                        */
-	ARBEL_COMPAT,		/* MT25208 in Tavor compat mode   */
-	ARBEL_NATIVE		/* MT25208 with extended features */
-};
-
 enum {
 	MTHCA_FLAG_DDR_HIDDEN = 1 << 1,
 	MTHCA_FLAG_SRQ        = 1 << 2,
 	MTHCA_FLAG_MSI        = 1 << 3,
 	MTHCA_FLAG_MSI_X      = 1 << 4,
 	MTHCA_FLAG_NO_LAM     = 1 << 5,
-	MTHCA_FLAG_FMR        = 1 << 6
+	MTHCA_FLAG_FMR        = 1 << 6,
+	MTHCA_FLAG_MEMFREE    = 1 << 7,
+	MTHCA_FLAG_PCIE       = 1 << 8
 };
 
 enum {
@@ -473,7 +468,7 @@ static inline struct mthca_dev *to_mdev(
 
 static inline int mthca_is_memfree(struct mthca_dev *dev)
 {
-	return dev->hca_type == ARBEL_NATIVE;
+	return dev->mthca_flags & MTHCA_FLAG_MEMFREE;
 }
 
 #endif /* MTHCA_DEV_H */
diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-support-for-new-mt25204-hca drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-support-for-new-mt25204-hca	2005-04-12 03:21:48.433773848 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:48.440772784 -0700
@@ -103,7 +103,7 @@ static int __devinit mthca_tune_pci(stru
 				  "aborting.\n");
 			return -ENODEV;
 		}
-	} else if (mdev->hca_type == TAVOR)
+	} else if (!(mdev->mthca_flags & MTHCA_FLAG_PCIE))
 		mthca_info(mdev, "No PCI-X capability, not setting RBC.\n");
 
 	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP);
@@ -119,8 +119,7 @@ static int __devinit mthca_tune_pci(stru
 				  "register, aborting.\n");
 			return -ENODEV;
 		}
-	} else if (mdev->hca_type == ARBEL_NATIVE ||
-		   mdev->hca_type == ARBEL_COMPAT)
+	} else if (mdev->mthca_flags & MTHCA_FLAG_PCIE)
 		mthca_info(mdev, "No PCI Express capability, "
 			   "not setting Max Read Request Size.\n");
 
@@ -438,7 +437,7 @@ static int __devinit mthca_init_icm(stru
 	if (!mdev->qp_table.rdb_table) {
 		mthca_err(mdev, "Failed to map RDB context memory, aborting\n");
 		err = -ENOMEM;
-		goto err_unmap_eqp;
+		goto err_unmap_rdb;
 	}
 
        mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
@@ -593,6 +592,7 @@ static int __devinit mthca_init_arbel(st
 
 err_free_icm:
 	mthca_free_icm_table(mdev, mdev->cq_table.table);
+	mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
 	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 	mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
 	mthca_free_icm_table(mdev, mdev->mr_table.mpt_table);
@@ -851,6 +851,7 @@ static void mthca_close_hca(struct mthca
 
 	if (mthca_is_memfree(mdev)) {
 		mthca_free_icm_table(mdev, mdev->cq_table.table);
+		mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
 		mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 		mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
 		mthca_free_icm_table(mdev, mdev->mr_table.mpt_table);
@@ -869,11 +870,32 @@ static void mthca_close_hca(struct mthca
 		mthca_SYS_DIS(mdev, &status);
 }
 
+/* Types of supported HCA */
+enum {
+	TAVOR,			/* MT23108                        */
+	ARBEL_COMPAT,		/* MT25208 in Tavor compat mode   */
+	ARBEL_NATIVE,		/* MT25208 with extended features */
+	SINAI			/* MT25204 */
+};
+
+#define MTHCA_FW_VER(major, minor, subminor) \
+	(((u64) (major) << 32) | ((u64) (minor) << 16) | (u64) (subminor))
+
+static struct {
+	u64 latest_fw;
+	int is_memfree;
+	int is_pcie;
+} mthca_hca_table[] = {
+	[TAVOR]        = { .latest_fw = MTHCA_FW_VER(3, 3, 2), .is_memfree = 0, .is_pcie = 0 },
+	[ARBEL_COMPAT] = { .latest_fw = MTHCA_FW_VER(4, 6, 2), .is_memfree = 0, .is_pcie = 1 },
+	[ARBEL_NATIVE] = { .latest_fw = MTHCA_FW_VER(5, 0, 1), .is_memfree = 1, .is_pcie = 1 },
+	[SINAI]        = { .latest_fw = MTHCA_FW_VER(1, 0, 1), .is_memfree = 1, .is_pcie = 1 }
+};
+
 static int __devinit mthca_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *id)
 {
 	static int mthca_version_printed = 0;
-	static int mthca_memfree_warned = 0;
 	int ddr_hidden = 0;
 	int err;
 	struct mthca_dev *mdev;
@@ -886,6 +908,12 @@ static int __devinit mthca_init_one(stru
 	printk(KERN_INFO PFX "Initializing %s (%s)\n",
 	       pci_pretty_name(pdev), pci_name(pdev));
 
+	if (id->driver_data >= ARRAY_SIZE(mthca_hca_table)) {
+		printk(KERN_ERR PFX "%s (%s) has invalid driver data %lx\n",
+		       pci_pretty_name(pdev), pci_name(pdev), id->driver_data);
+		return -ENODEV;
+	}
+
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot enable PCI device, "
@@ -950,15 +978,14 @@ static int __devinit mthca_init_one(stru
 		goto err_free_res;
 	}
 
-	mdev->pdev     = pdev;
-	mdev->hca_type = id->driver_data;
-
-	if (mthca_is_memfree(mdev) && !mthca_memfree_warned++)
-		mthca_warn(mdev, "Warning: native MT25208 mode support is incomplete.  "
-			   "Your HCA may not work properly.\n");
+	mdev->pdev = pdev;
 
 	if (ddr_hidden)
 		mdev->mthca_flags |= MTHCA_FLAG_DDR_HIDDEN;
+	if (mthca_hca_table[id->driver_data].is_memfree)
+		mdev->mthca_flags |= MTHCA_FLAG_MEMFREE;
+	if (mthca_hca_table[id->driver_data].is_pcie)
+		mdev->mthca_flags |= MTHCA_FLAG_PCIE;
 
 	/*
 	 * Now reset the HCA before we touch the PCI capabilities or
@@ -997,6 +1024,16 @@ static int __devinit mthca_init_one(stru
 	if (err)
 		goto err_iounmap;
 
+	if (mdev->fw_ver < mthca_hca_table[id->driver_data].latest_fw) {
+		mthca_warn(mdev, "HCA FW version %x.%x.%x is old (%x.%x.%x is current).\n",
+			   (int) (mdev->fw_ver >> 32), (int) (mdev->fw_ver >> 16) & 0xffff,
+			   (int) (mdev->fw_ver & 0xffff),
+			   (int) (mthca_hca_table[id->driver_data].latest_fw >> 32),
+			   (int) (mthca_hca_table[id->driver_data].latest_fw >> 16) & 0xffff,
+			   (int) (mthca_hca_table[id->driver_data].latest_fw & 0xffff));
+		mthca_warn(mdev, "If you have problems, try updating your HCA FW.\n");
+	}
+
 	err = mthca_setup_hca(mdev);
 	if (err)
 		goto err_close;
@@ -1112,6 +1149,14 @@ static struct pci_device_id mthca_pci_ta
 	  .driver_data = ARBEL_NATIVE },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_ARBEL),
 	  .driver_data = ARBEL_NATIVE },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SINAI),
+	  .driver_data = SINAI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_SINAI),
+	  .driver_data = SINAI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SINAI_OLD),
+	  .driver_data = SINAI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_SINAI_OLD),
+	  .driver_data = SINAI },
 	{ 0, }
 };
 
diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-add-support-for-new-mt25204-hca drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-add-support-for-new-mt25204-hca	2005-04-12 03:21:48.434773696 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:48.441772632 -0700
@@ -659,11 +659,18 @@ static ssize_t show_fw_ver(struct class_
 static ssize_t show_hca(struct class_device *cdev, char *buf)
 {
 	struct mthca_dev *dev = container_of(cdev, struct mthca_dev, ib_dev.class_dev);
-	switch (dev->hca_type) {
-	case TAVOR:        return sprintf(buf, "MT23108\n");
-	case ARBEL_COMPAT: return sprintf(buf, "MT25208 (MT23108 compat mode)\n");
-	case ARBEL_NATIVE: return sprintf(buf, "MT25208\n");
-	default:           return sprintf(buf, "unknown\n");
+	switch (dev->pdev->device) {
+	case PCI_DEVICE_ID_MELLANOX_TAVOR:
+		return sprintf(buf, "MT23108\n");
+	case PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT:
+		return sprintf(buf, "MT25208 (MT23108 compat mode)\n");
+	case PCI_DEVICE_ID_MELLANOX_ARBEL:
+		return sprintf(buf, "MT25208\n");
+	case PCI_DEVICE_ID_MELLANOX_SINAI:
+	case PCI_DEVICE_ID_MELLANOX_SINAI_OLD:
+		return sprintf(buf, "MT25204\n");
+	default:
+		return sprintf(buf, "unknown\n");
 	}
 }
 
diff -puN drivers/infiniband/hw/mthca/mthca_reset.c~ib-mthca-add-support-for-new-mt25204-hca drivers/infiniband/hw/mthca/mthca_reset.c
--- 25/drivers/infiniband/hw/mthca/mthca_reset.c~ib-mthca-add-support-for-new-mt25204-hca	2005-04-12 03:21:48.435773544 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_reset.c	2005-04-12 03:21:48.442772480 -0700
@@ -63,7 +63,7 @@ int mthca_reset(struct mthca_dev *mdev)
 	 * header as well.
 	 */
 
-	if (mdev->hca_type == TAVOR) {
+	if (!(mdev->mthca_flags & MTHCA_FLAG_PCIE)) {
 		/* Look for the bridge -- its device ID will be 2 more
 		   than HCA's device ID. */
 		while ((bridge = pci_get_device(mdev->pdev->vendor,
_
