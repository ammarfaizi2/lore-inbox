Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWGQQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWGQQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWGQQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:44475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750956AbWGQQc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:56 -0400
Date: Mon, 17 Jul 2006 09:25:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/45] IB/mthca: restore missing PCI registers after reset
Message-ID: <20060717162531.GC4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ib-mthca-restore-missing-pci-registers-after-reset.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
mthca does not restore the following PCI-X/PCI Express registers after reset:
  PCI-X device: PCI-X command register
  PCI-X bridge: upstream and downstream split transaction registers
  PCI Express : PCI Express device control and link control registers

This causes instability and/or bad performance on systems where one of
these registers is set to a non-default value by BIOS.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/infiniband/hw/mthca/mthca_reset.c |   59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

--- linux-2.6.17.2.orig/drivers/infiniband/hw/mthca/mthca_reset.c
+++ linux-2.6.17.2/drivers/infiniband/hw/mthca/mthca_reset.c
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
@@ -110,6 +116,9 @@ int mthca_reset(struct mthca_dev *mdev)
 		}
 	}
 
+	hca_pcix_cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX);
+	hca_pcie_cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP);
+
 	if (bridge) {
 		bridge_header = kmalloc(256, GFP_KERNEL);
 		if (!bridge_header) {
@@ -129,6 +138,13 @@ int mthca_reset(struct mthca_dev *mdev)
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
@@ -178,6 +194,20 @@ int mthca_reset(struct mthca_dev *mdev)
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
