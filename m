Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWKVUou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWKVUou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbWKVUou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:44:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:29350 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1754665AbWKVUot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:44:49 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 22 Nov 2006 21:44:34 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] ieee1394: sbp2: convert from PCI DMA to generic DMA
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.b1be9abfb23cf2d0@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee1394: sbp2: convert from PCI DMA to generic DMA

API conversion without change in functionality

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Todo:
  - Collaps all management ORB DMAs into one block.
    They can probably even be compressed into a union.
  - Use streaming DMA instead of coherent DMA for ORB DMAs.
  - Take a target's Unit_Characteristics.ORB_size into account.
  - Collaps the command ORB DMAs into one block.
  - Convert ieee1394 from PCI DMA to generic DMA too,
    thus elimiate its dependency on CONFIG_PCI.


 drivers/ieee1394/Kconfig |    2
 drivers/ieee1394/sbp2.c  |  126 ++++++++++++++++++---------------------
 drivers/ieee1394/sbp2.h  |    2
 3 files changed, 62 insertions(+), 68 deletions(-)

Index: linux/drivers/ieee1394/Kconfig
===================================================================
--- linux.orig/drivers/ieee1394/Kconfig	2006-11-13 21:07:39.000000000 +0100
+++ linux/drivers/ieee1394/Kconfig	2006-11-13 21:12:12.000000000 +0100
@@ -120,7 +120,7 @@ comment "SBP-2 support (for storage devi
 
 config IEEE1394_SBP2
 	tristate "SBP-2 support (Harddisks etc.)"
-	depends on IEEE1394 && SCSI && (PCI || BROKEN)
+	depends on IEEE1394 && SCSI
 	help
 	  This option enables you to use SBP-2 devices connected to an IEEE
 	  1394 bus.  SBP-2 devices include storage devices like harddisks and
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-11-13 21:11:06.000000000 +0100
+++ linux/drivers/ieee1394/sbp2.c	2006-11-13 21:12:12.000000000 +0100
@@ -48,7 +48,6 @@
  *   - make the parameter serialize_io configurable per device
  *   - move all requests to fetch agent registers into non-atomic context,
  *     replace all usages of sbp2util_node_write_no_wait by true transactions
- *   - convert to generic DMA mapping API to eliminate dependency on PCI
  * Grep for inline FIXME comments below.
  */
 
@@ -63,7 +62,6 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
@@ -492,14 +490,14 @@ static int sbp2util_create_command_orb_p
 			spin_unlock_irqrestore(&lu->cmd_orb_lock, flags);
 			return -ENOMEM;
 		}
-		cmd->command_orb_dma = pci_map_single(hi->host->pdev,
+		cmd->command_orb_dma = dma_map_single(&hi->host->device,
 						&cmd->command_orb,
 						sizeof(struct sbp2_command_orb),
-						PCI_DMA_TODEVICE);
-		cmd->sge_dma = pci_map_single(hi->host->pdev,
+						DMA_TO_DEVICE);
+		cmd->sge_dma = dma_map_single(&hi->host->device,
 					&cmd->scatter_gather_element,
 					sizeof(cmd->scatter_gather_element),
-					PCI_DMA_BIDIRECTIONAL);
+					DMA_BIDIRECTIONAL);
 		INIT_LIST_HEAD(&cmd->list);
 		list_add_tail(&cmd->list, &lu->cmd_orb_completed);
 	}
@@ -518,12 +516,12 @@ static void sbp2util_remove_command_orb_
 	if (!list_empty(&lu->cmd_orb_completed))
 		list_for_each_safe(lh, next, &lu->cmd_orb_completed) {
 			cmd = list_entry(lh, struct sbp2_command_info, list);
-			pci_unmap_single(host->pdev, cmd->command_orb_dma,
+			dma_unmap_single(&host->device, cmd->command_orb_dma,
 					 sizeof(struct sbp2_command_orb),
-					 PCI_DMA_TODEVICE);
-			pci_unmap_single(host->pdev, cmd->sge_dma,
+					 DMA_TO_DEVICE);
+			dma_unmap_single(&host->device, cmd->sge_dma,
 					 sizeof(cmd->scatter_gather_element),
-					 PCI_DMA_BIDIRECTIONAL);
+					 DMA_BIDIRECTIONAL);
 			kfree(cmd);
 		}
 	spin_unlock_irqrestore(&lu->cmd_orb_lock, flags);
@@ -603,17 +601,17 @@ static void sbp2util_mark_command_comple
 
 	if (cmd->cmd_dma) {
 		if (cmd->dma_type == CMD_DMA_SINGLE)
-			pci_unmap_single(host->pdev, cmd->cmd_dma,
+			dma_unmap_single(&host->device, cmd->cmd_dma,
 					 cmd->dma_size, cmd->dma_dir);
 		else if (cmd->dma_type == CMD_DMA_PAGE)
-			pci_unmap_page(host->pdev, cmd->cmd_dma,
+			dma_unmap_page(&host->device, cmd->cmd_dma,
 				       cmd->dma_size, cmd->dma_dir);
 		/* XXX: Check for CMD_DMA_NONE bug */
 		cmd->dma_type = CMD_DMA_NONE;
 		cmd->cmd_dma = 0;
 	}
 	if (cmd->sge_buffer) {
-		pci_unmap_sg(host->pdev, cmd->sge_buffer,
+		dma_unmap_sg(&host->device, cmd->sge_buffer,
 			     cmd->dma_size, cmd->dma_dir);
 		cmd->sge_buffer = NULL;
 	}
@@ -838,39 +836,39 @@ static int sbp2_start_device(struct sbp2
 	struct sbp2_fwhost_info *hi = lu->hi;
 	int error;
 
-	lu->login_response = pci_alloc_consistent(hi->host->pdev,
+	lu->login_response = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_login_response),
-				     &lu->login_response_dma);
+				     &lu->login_response_dma, GFP_KERNEL);
 	if (!lu->login_response)
 		goto alloc_fail;
 
-	lu->query_logins_orb = pci_alloc_consistent(hi->host->pdev,
+	lu->query_logins_orb = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_query_logins_orb),
-				     &lu->query_logins_orb_dma);
+				     &lu->query_logins_orb_dma, GFP_KERNEL);
 	if (!lu->query_logins_orb)
 		goto alloc_fail;
 
-	lu->query_logins_response = pci_alloc_consistent(hi->host->pdev,
+	lu->query_logins_response = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_query_logins_response),
-				     &lu->query_logins_response_dma);
+				     &lu->query_logins_response_dma, GFP_KERNEL);
 	if (!lu->query_logins_response)
 		goto alloc_fail;
 
-	lu->reconnect_orb = pci_alloc_consistent(hi->host->pdev,
+	lu->reconnect_orb = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_reconnect_orb),
-				     &lu->reconnect_orb_dma);
+				     &lu->reconnect_orb_dma, GFP_KERNEL);
 	if (!lu->reconnect_orb)
 		goto alloc_fail;
 
-	lu->logout_orb = pci_alloc_consistent(hi->host->pdev,
+	lu->logout_orb = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_logout_orb),
-				     &lu->logout_orb_dma);
+				     &lu->logout_orb_dma, GFP_KERNEL);
 	if (!lu->logout_orb)
 		goto alloc_fail;
 
-	lu->login_orb = pci_alloc_consistent(hi->host->pdev,
+	lu->login_orb = dma_alloc_coherent(&hi->host->device,
 				     sizeof(struct sbp2_login_orb),
-				     &lu->login_orb_dma);
+				     &lu->login_orb_dma, GFP_KERNEL);
 	if (!lu->login_orb)
 		goto alloc_fail;
 
@@ -931,32 +929,32 @@ static void sbp2_remove_device(struct sb
 	list_del(&lu->lu_list);
 
 	if (lu->login_response)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_login_response),
 				    lu->login_response,
 				    lu->login_response_dma);
 	if (lu->login_orb)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_login_orb),
 				    lu->login_orb,
 				    lu->login_orb_dma);
 	if (lu->reconnect_orb)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_reconnect_orb),
 				    lu->reconnect_orb,
 				    lu->reconnect_orb_dma);
 	if (lu->logout_orb)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_logout_orb),
 				    lu->logout_orb,
 				    lu->logout_orb_dma);
 	if (lu->query_logins_orb)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_query_logins_orb),
 				    lu->query_logins_orb,
 				    lu->query_logins_orb_dma);
 	if (lu->query_logins_response)
-		pci_free_consistent(hi->host->pdev,
+		dma_free_coherent(&hi->host->device,
 				    sizeof(struct sbp2_query_logins_response),
 				    lu->query_logins_response,
 				    lu->query_logins_response_dma);
@@ -1447,7 +1445,7 @@ static void sbp2_prep_command_orb_sg(str
 
 		cmd->dma_size = sgpnt[0].length;
 		cmd->dma_type = CMD_DMA_PAGE;
-		cmd->cmd_dma = pci_map_page(hi->host->pdev,
+		cmd->cmd_dma = dma_map_page(&hi->host->device,
 					    sgpnt[0].page, sgpnt[0].offset,
 					    cmd->dma_size, cmd->dma_dir);
 
@@ -1459,7 +1457,7 @@ static void sbp2_prep_command_orb_sg(str
 						&cmd->scatter_gather_element[0];
 		u32 sg_count, sg_len;
 		dma_addr_t sg_addr;
-		int i, count = pci_map_sg(hi->host->pdev, sgpnt, scsi_use_sg,
+		int i, count = dma_map_sg(&hi->host->device, sgpnt, scsi_use_sg,
 					  dma_dir);
 
 		cmd->dma_size = scsi_use_sg;
@@ -1510,7 +1508,7 @@ static void sbp2_prep_command_orb_no_sg(
 	cmd->dma_dir = dma_dir;
 	cmd->dma_size = scsi_request_bufflen;
 	cmd->dma_type = CMD_DMA_SINGLE;
-	cmd->cmd_dma = pci_map_single(hi->host->pdev, scsi_request_buffer,
+	cmd->cmd_dma = dma_map_single(&hi->host->device, scsi_request_buffer,
 				      cmd->dma_size, cmd->dma_dir);
 	orb->data_descriptor_hi = ORB_SET_NODE_ID(hi->host->node_id);
 	orb->misc |= ORB_SET_DIRECTION(orb_direction);
@@ -1628,12 +1626,12 @@ static void sbp2_link_orb_command(struct
 	size_t length;
 	unsigned long flags;
 
-	pci_dma_sync_single_for_device(hi->host->pdev, cmd->command_orb_dma,
-				       sizeof(struct sbp2_command_orb),
-				       PCI_DMA_TODEVICE);
-	pci_dma_sync_single_for_device(hi->host->pdev, cmd->sge_dma,
-				       sizeof(cmd->scatter_gather_element),
-				       PCI_DMA_BIDIRECTIONAL);
+	dma_sync_single_for_device(&hi->host->device, cmd->command_orb_dma,
+				   sizeof(struct sbp2_command_orb),
+				   DMA_TO_DEVICE);
+	dma_sync_single_for_device(&hi->host->device, cmd->sge_dma,
+				   sizeof(cmd->scatter_gather_element),
+				   DMA_BIDIRECTIONAL);
 
 	/* check to see if there are any previous orbs to use */
 	spin_lock_irqsave(&lu->cmd_orb_lock, flags);
@@ -1657,16 +1655,16 @@ static void sbp2_link_orb_command(struct
 		 * The target's fetch agent may or may not have read this
 		 * previous ORB yet.
 		 */
-		pci_dma_sync_single_for_cpu(hi->host->pdev, last_orb_dma,
-					    sizeof(struct sbp2_command_orb),
-					    PCI_DMA_TODEVICE);
+		dma_sync_single_for_cpu(&hi->host->device, last_orb_dma,
+					sizeof(struct sbp2_command_orb),
+					DMA_TO_DEVICE);
 		last_orb->next_ORB_lo = cpu_to_be32(cmd->command_orb_dma);
 		wmb();
 		/* Tells hardware that this pointer is valid */
 		last_orb->next_ORB_hi = 0;
-		pci_dma_sync_single_for_device(hi->host->pdev, last_orb_dma,
-					       sizeof(struct sbp2_command_orb),
-					       PCI_DMA_TODEVICE);
+		dma_sync_single_for_device(&hi->host->device, last_orb_dma,
+					   sizeof(struct sbp2_command_orb),
+					   DMA_TO_DEVICE);
 		addr += SBP2_DOORBELL_OFFSET;
 		data[0] = 0;
 		length = 4;
@@ -1793,14 +1791,12 @@ static int sbp2_handle_status_write(stru
 	else
 		cmd = sbp2util_find_command_for_orb(lu, sb->ORB_offset_lo);
 	if (cmd) {
-		pci_dma_sync_single_for_cpu(hi->host->pdev,
-				cmd->command_orb_dma,
-				sizeof(struct sbp2_command_orb),
-				PCI_DMA_TODEVICE);
-		pci_dma_sync_single_for_cpu(hi->host->pdev,
-				cmd->sge_dma,
-				sizeof(cmd->scatter_gather_element),
-				PCI_DMA_BIDIRECTIONAL);
+		dma_sync_single_for_cpu(&hi->host->device, cmd->command_orb_dma,
+					sizeof(struct sbp2_command_orb),
+					DMA_TO_DEVICE);
+		dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
+					sizeof(cmd->scatter_gather_element),
+					DMA_BIDIRECTIONAL);
 		/* Grab SCSI command pointers and check status. */
 		/*
 		 * FIXME: If the src field in the status is 1, the ORB DMA must
@@ -1936,13 +1932,12 @@ static void sbp2scsi_complete_all_comman
 	while (!list_empty(&lu->cmd_orb_inuse)) {
 		lh = lu->cmd_orb_inuse.next;
 		cmd = list_entry(lh, struct sbp2_command_info, list);
-		pci_dma_sync_single_for_cpu(hi->host->pdev,
-				cmd->command_orb_dma,
-				sizeof(struct sbp2_command_orb),
-				PCI_DMA_TODEVICE);
-		pci_dma_sync_single_for_cpu(hi->host->pdev, cmd->sge_dma,
-				sizeof(cmd->scatter_gather_element),
-				PCI_DMA_BIDIRECTIONAL);
+		dma_sync_single_for_cpu(&hi->host->device, cmd->command_orb_dma,
+					sizeof(struct sbp2_command_orb),
+					DMA_TO_DEVICE);
+		dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
+					sizeof(cmd->scatter_gather_element),
+					DMA_BIDIRECTIONAL);
 		sbp2util_mark_command_completed(lu, cmd);
 		if (cmd->Current_SCpnt) {
 			cmd->Current_SCpnt->result = status << 16;
@@ -2065,14 +2060,13 @@ static int sbp2scsi_abort(struct scsi_cm
 		spin_lock_irqsave(&lu->cmd_orb_lock, flags);
 		cmd = sbp2util_find_command_for_SCpnt(lu, SCpnt);
 		if (cmd) {
-			pci_dma_sync_single_for_cpu(hi->host->pdev,
+			dma_sync_single_for_cpu(&hi->host->device,
 					cmd->command_orb_dma,
 					sizeof(struct sbp2_command_orb),
-					PCI_DMA_TODEVICE);
-			pci_dma_sync_single_for_cpu(hi->host->pdev,
-					cmd->sge_dma,
+					DMA_TO_DEVICE);
+			dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
 					sizeof(cmd->scatter_gather_element),
-					PCI_DMA_BIDIRECTIONAL);
+					DMA_BIDIRECTIONAL);
 			sbp2util_mark_command_completed(lu, cmd);
 			if (cmd->Current_SCpnt) {
 				cmd->Current_SCpnt->result = DID_ABORT << 16;
Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-11-13 21:07:39.000000000 +0100
+++ linux/drivers/ieee1394/sbp2.h	2006-11-13 21:12:12.000000000 +0100
@@ -263,7 +263,7 @@ struct sbp2_command_info {
 	dma_addr_t cmd_dma;
 	enum sbp2_dma_types dma_type;
 	unsigned long dma_size;
-	int dma_dir;
+	enum dma_data_direction dma_dir;
 };
 
 /* Per FireWire host */

-- 
Stefan Richter
-=====-=-==- =-== =-==-
http://arcgraph.de/sr/

