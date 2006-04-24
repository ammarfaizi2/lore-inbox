Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWDXV3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWDXV3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWDXVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:45 -0400
Received: from mx.pathscale.com ([64.160.42.68]:29123 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751112AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
X-Mercurial-Node: 1906950392f7ef8c7d071cc8cb3b93be5db60b93
Message-Id: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:22:58 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems do not set up 64-bit maps on systems with 2GB or less of
memory installed, so we have to fall back to trying a 32-bit setup.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 61819d2519e0 -r 1906950392f7 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Apr 19 15:24:36 2006 -0700
@@ -418,9 +418,19 @@ static int __devinit ipath_init_one(stru
 
 	ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (ret) {
-		dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
-			 "fails: %d\n", dd->ipath_unit, ret);
-		goto bail_regions;
+		/*
+		 * if the 64 bit setup fails, try 32 bit.  Some systems
+		 * do not setup 64 bit maps on systems with 2GB or less
+		 * memory installed.
+		 */
+		ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (ret) {
+			dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
+				 "fails: %d\n", dd->ipath_unit, ret);
+			goto bail_regions;
+		}
+		else
+			ipath_dbg("No 64bit DMA mask, used 32 bit mask\n");
 	}
 
 	pci_set_master(pdev);
