Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWGWU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWGWU7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGWU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:59:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43969 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751319AbWGWU7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:59:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 22:57:52 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 3/6] ieee1394: sbp2: optimize DMA direction of
 command ORBs
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
Message-ID: <tkrat.77f108a4473ed590@s5r6.in-berlin.de>
References: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.334) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only the driver writes ORBs, the device just reads them.  Therefore
PCI_DMA_BIDIRECTIONAL can be replaced by PCI_DMA_TODEVICE which may be
cheaper on some architectures.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

TODO:
Convert sbp2 from PCI DMA to generic DMA mapping.

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-23 10:16:57.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-23 10:19:29.000000000 +0200
@@ -492,7 +492,7 @@ static int sbp2util_create_command_orb_p
 		command->command_orb_dma =
 		    pci_map_single(hi->host->pdev, &command->command_orb,
 				   sizeof(struct sbp2_command_orb),
-				   PCI_DMA_BIDIRECTIONAL);
+				   PCI_DMA_TODEVICE);
 		SBP2_DMA_ALLOC("single command orb DMA");
 		command->sge_dma =
 		    pci_map_single(hi->host->pdev,
@@ -525,7 +525,7 @@ static void sbp2util_remove_command_orb_
 			/* Release our generic DMA's */
 			pci_unmap_single(host->pdev, command->command_orb_dma,
 					 sizeof(struct sbp2_command_orb),
-					 PCI_DMA_BIDIRECTIONAL);
+					 PCI_DMA_TODEVICE);
 			SBP2_DMA_FREE("single command orb DMA");
 			pci_unmap_single(host->pdev, command->sge_dma,
 					 sizeof(command->scatter_gather_element),
@@ -1982,7 +1982,7 @@ static void sbp2_link_orb_command(struct
 
 	pci_dma_sync_single_for_device(hi->host->pdev, command->command_orb_dma,
 				       sizeof(struct sbp2_command_orb),
-				       PCI_DMA_BIDIRECTIONAL);
+				       PCI_DMA_TODEVICE);
 	pci_dma_sync_single_for_device(hi->host->pdev, command->sge_dma,
 				       sizeof(command->scatter_gather_element),
 				       PCI_DMA_BIDIRECTIONAL);
@@ -2012,14 +2012,14 @@ static void sbp2_link_orb_command(struct
 		 */
 		pci_dma_sync_single_for_cpu(hi->host->pdev, last_orb_dma,
 					    sizeof(struct sbp2_command_orb),
-					    PCI_DMA_BIDIRECTIONAL);
+					    PCI_DMA_TODEVICE);
 		last_orb->next_ORB_lo = cpu_to_be32(command->command_orb_dma);
 		wmb();
 		/* Tells hardware that this pointer is valid */
 		last_orb->next_ORB_hi = 0;
 		pci_dma_sync_single_for_device(hi->host->pdev, last_orb_dma,
 					       sizeof(struct sbp2_command_orb),
-					       PCI_DMA_BIDIRECTIONAL);
+					       PCI_DMA_TODEVICE);
 		addr += SBP2_DOORBELL_OFFSET;
 		data[0] = 0;
 		length = 4;
@@ -2176,7 +2176,7 @@ static int sbp2_handle_status_write(stru
 		SBP2_DEBUG("Found status for command ORB");
 		pci_dma_sync_single_for_cpu(hi->host->pdev, command->command_orb_dma,
 					    sizeof(struct sbp2_command_orb),
-					    PCI_DMA_BIDIRECTIONAL);
+					    PCI_DMA_TODEVICE);
 		pci_dma_sync_single_for_cpu(hi->host->pdev, command->sge_dma,
 					    sizeof(command->scatter_gather_element),
 					    PCI_DMA_BIDIRECTIONAL);
@@ -2365,7 +2365,7 @@ static void sbp2scsi_complete_all_comman
 		command = list_entry(lh, struct sbp2_command_info, list);
 		pci_dma_sync_single_for_cpu(hi->host->pdev, command->command_orb_dma,
 					    sizeof(struct sbp2_command_orb),
-					    PCI_DMA_BIDIRECTIONAL);
+					    PCI_DMA_TODEVICE);
 		pci_dma_sync_single_for_cpu(hi->host->pdev, command->sge_dma,
 					    sizeof(command->scatter_gather_element),
 					    PCI_DMA_BIDIRECTIONAL);
@@ -2548,7 +2548,7 @@ static int sbp2scsi_abort(struct scsi_cm
 			pci_dma_sync_single_for_cpu(hi->host->pdev,
 						    command->command_orb_dma,
 						    sizeof(struct sbp2_command_orb),
-						    PCI_DMA_BIDIRECTIONAL);
+						    PCI_DMA_TODEVICE);
 			pci_dma_sync_single_for_cpu(hi->host->pdev,
 						    command->sge_dma,
 						    sizeof(command->scatter_gather_element),


