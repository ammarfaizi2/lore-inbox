Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWF1R1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWF1R1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWF1R1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:27:09 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:41092 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751263AbWF1R1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:27:07 -0400
Date: Wed, 28 Jun 2006 20:14:28 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: stable@kernel.org, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland Dreier <rolandd@cisco.com>
Subject: [PATCH -stable] IB/mthca: restore missing PCI registers after reset
Message-ID: <20060628171428.GF19300@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 28 Jun 2006 17:19:16.0062 (UTC) FILETIME=[FB8CB7E0:01C69AD6]
X-Spam: [F=0.0189329261; S=0.018(2006062301)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, stable team!
The pull of the following fix was requested by Roland Dreier just a couple of
days before 2.6.17 came out, and so it seems it missed 2.6.17 by a narrow
margin:

http://lkml.org/lkml/2006/6/13/164

It is now upsteam:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=13aa6ecb47990cfc78e20e347fdd3f1df6189426

As I hear from users about systems where mthca does not work at all without this
patch, please consider it for -stable.

Note: Roland Dreier is currently unavailable, and said he will be for a while.
I am assuming since he ACKed this for 2.6.17 it's good for -stable as well
as far as he's concerned.

---

mthca does not restore the following PCI-X/PCI Express registers after reset:
  PCI-X device: PCI-X command register
  PCI-X bridge: upstream and downstream split transaction registers
  PCI Express : PCI Express device control and link control registers

This causes instability and/or bad performance on systems where one of
these registers is set to a non-default value by BIOS.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

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


-- 
MST
