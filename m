Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWAaApg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWAaApg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWAaApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:45:36 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:27024 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965051AbWAaApg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:45:36 -0500
X-IronPort-AV: i="4.01,236,1136188800"; 
   d="scan'208"; a="252465845:sNHT29445392"
Subject: [git patch review 1/4] IB/mthca: Relax UAR size check
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 31 Jan 2006 00:45:32 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1138668332064-a06b57921710eb35@cisco.com>
X-OriginalArrivalTime: 31 Jan 2006 00:45:34.0896 (UTC) FILETIME=[A56DC300:01C625FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cards around that have UAR (user access region) size
different from 8 MB.  Relax our sanity check to make sure that the PCI
BAR is big enough to access the UAR size reported by the device
firmware instead.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_main.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

cbd2981a97cb628431a987a8abd1731c74bcc32e
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 8b00d9a..9c849d2 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -155,6 +155,13 @@ static int __devinit mthca_dev_lim(struc
 		return -ENODEV;
 	}
 
+	if (dev_lim->uar_size > pci_resource_len(mdev->pdev, 2)) {
+		mthca_err(mdev, "HCA reported UAR size of 0x%x bigger than "
+			  "PCI resource 2 size of 0x%lx, aborting.\n",
+			  dev_lim->uar_size, pci_resource_len(mdev->pdev, 2));
+		return -ENODEV;
+	}
+
 	mdev->limits.num_ports      	= dev_lim->num_ports;
 	mdev->limits.vl_cap             = dev_lim->max_vl;
 	mdev->limits.mtu_cap            = dev_lim->max_mtu;
@@ -976,8 +983,7 @@ static int __devinit mthca_init_one(stru
 		err = -ENODEV;
 		goto err_disable_pdev;
 	}
-	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM) ||
-	    pci_resource_len(pdev, 2) != 1 << 23) {
+	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "Missing UAR, aborting.\n");
 		err = -ENODEV;
 		goto err_disable_pdev;
-- 
1.1.3
