Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933008AbWF2WBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbWF2WBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbWF2V6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:25 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34703 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932877AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 39] IB/ipath - print better debug info when handling
	32/64-bit DMA mask problems
X-Mercurial-Node: 125471ee6c6863fbfa35d5f89fbac1cbfca4a9a8
Message-Id: <125471ee6c6863fbfa35.1151617266@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:06 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r e43b4df874a9 -r 125471ee6c68 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
@@ -425,12 +425,29 @@ static int __devinit ipath_init_one(stru
 		 */
 		ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (ret) {
-			dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
-				 "fails: %d\n", dd->ipath_unit, ret);
+			dev_info(&pdev->dev,
+				"Unable to set DMA mask for unit %u: %d\n",
+				dd->ipath_unit, ret);
 			goto bail_regions;
 		}
-		else
+		else {
 			ipath_dbg("No 64bit DMA mask, used 32 bit mask\n");
+			ret = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (ret)
+				dev_info(&pdev->dev,
+					"Unable to set DMA consistent mask "
+					"for unit %u: %d\n",
+					dd->ipath_unit, ret);
+
+		}
+	}
+	else {
+		ret = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+		if (ret)
+			dev_info(&pdev->dev,
+				"Unable to set DMA consistent mask "
+				"for unit %u: %d\n",
+				dd->ipath_unit, ret);
 	}
 
 	pci_set_master(pdev);
