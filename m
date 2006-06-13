Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWFMSUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWFMSUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFMSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:20:18 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:6465 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932208AbWFMSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:20:15 -0400
X-IronPort-AV: i="4.06,128,1149490800"; 
   d="scan'208"; a="293977423:sNHT35215176"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 13 Jun 2006 11:19:13 -0700
Message-ID: <aday7w03om6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jun 2006 18:19:14.0500 (UTC) FILETIME=[E0308840:01C68F15]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This has a couple of mthca driver bug fixes:

Michael S. Tsirkin:
      IB/mthca: restore missing PCI registers after reset
      IB/mthca: memfree completion with error FW bug workaround

 drivers/infiniband/hw/mthca/mthca_cq.c    |   11 +++++
 drivers/infiniband/hw/mthca/mthca_reset.c |   59 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletions(-)


diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 205854e..87a8f11 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -540,8 +540,17 @@ static inline int mthca_poll_one(struct 
 		entry->wr_id = srq->wrid[wqe_index];
 		mthca_free_srq_wqe(srq, wqe);
 	} else {
+		s32 wqe;
 		wq = &(*cur_qp)->rq;
-		wqe_index = be32_to_cpu(cqe->wqe) >> wq->wqe_shift;
+		wqe = be32_to_cpu(cqe->wqe);
+		wqe_index = wqe >> wq->wqe_shift;
+               /*
+		* WQE addr == base - 1 might be reported in receive completion
+		* with error instead of (rq size - 1) by Sinai FW 1.0.800 and
+		* Arbel FW 5.1.400.  This bug should be fixed in later FW revs.
+		*/
+		if (unlikely(wqe_index < 0))
+			wqe_index = wq->max - 1;
 		entry->wr_id = (*cur_qp)->wrid[wqe_index];
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
index df5e494..f4fddd5 100644
--- a/drivers/infiniband/hw/mthca/mthca_reset.c
+++ b/drivers/infiniband/hw/mthca/mthca_reset.c
@@ -49,6 +49,12 @@ int mthca_reset(struct mthca_dev *mdev)
 	u32 *hca_header    = NULL;
 	u32 *bridge_header = NULL;
 	struct pci_dev *bridge = NULL;
+	int bridge_pcix_cap = 0;
+	int hca_pcie_cap = 0;
+	int hca_pcix_cap = 0;
+
+	u16 devctl;
+	u16 linkctl;
 
 #define MTHCA_RESET_OFFSET 0xf0010
 #define MTHCA_RESET_VALUE  swab32(1)
@@ -110,6 +116,9 @@ #define MTHCA_RESET_VALUE  swab32(1)
 		}
 	}
 
+	hca_pcix_cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX);
+	hca_pcie_cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP);
+
 	if (bridge) {
 		bridge_header = kmalloc(256, GFP_KERNEL);
 		if (!bridge_header) {
@@ -129,6 +138,13 @@ #define MTHCA_RESET_VALUE  swab32(1)
 				goto out;
 			}
 		}
+		bridge_pcix_cap = pci_find_capability(bridge, PCI_CAP_ID_PCIX);
+		if (!bridge_pcix_cap) {
+				err = -ENODEV;
+				mthca_err(mdev, "Couldn't locate HCA bridge "
+					  "PCI-X capability, aborting.\n");
+				goto out;
+		}
 	}
 
 	/* actually hit reset */
@@ -178,6 +194,20 @@ #define MTHCA_RESET_VALUE  swab32(1)
 good:
 	/* Now restore the PCI headers */
 	if (bridge) {
+		if (pci_write_config_dword(bridge, bridge_pcix_cap + 0x8,
+				 bridge_header[(bridge_pcix_cap + 0x8) / 4])) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA bridge Upstream "
+				  "split transaction control, aborting.\n");
+			goto out;
+		}
+		if (pci_write_config_dword(bridge, bridge_pcix_cap + 0xc,
+				 bridge_header[(bridge_pcix_cap + 0xc) / 4])) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA bridge Downstream "
+				  "split transaction control, aborting.\n");
+			goto out;
+		}
 		/*
 		 * Bridge control register is at 0x3e, so we'll
 		 * naturally restore it last in this loop.
@@ -203,6 +233,35 @@ good:
 		}
 	}
 
+	if (hca_pcix_cap) {
+		if (pci_write_config_dword(mdev->pdev, hca_pcix_cap,
+				 hca_header[hca_pcix_cap / 4])) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA PCI-X "
+				  "command register, aborting.\n");
+			goto out;
+		}
+	}
+
+	if (hca_pcie_cap) {
+		devctl = hca_header[(hca_pcie_cap + PCI_EXP_DEVCTL) / 4];
+		if (pci_write_config_word(mdev->pdev, hca_pcie_cap + PCI_EXP_DEVCTL,
+					   devctl)) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA PCI Express "
+				  "Device Control register, aborting.\n");
+			goto out;
+		}
+		linkctl = hca_header[(hca_pcie_cap + PCI_EXP_LNKCTL) / 4];
+		if (pci_write_config_word(mdev->pdev, hca_pcie_cap + PCI_EXP_LNKCTL,
+					   linkctl)) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA PCI Express "
+				  "Link control register, aborting.\n");
+			goto out;
+		}
+	}
+
 	for (i = 0; i < 16; ++i) {
 		if (i * 4 == PCI_COMMAND)
 			continue;
