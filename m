Return-Path: <linux-kernel-owner+w=401wt.eu-S1030187AbWL2Wrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWL2Wrl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbWL2Wrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:47:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41385 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbWL2Wrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:47:40 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 29 Dec 2006 23:47:04 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@ozlabs.org,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1167429171.23340.125.camel@localhost.localdomain>
Message-ID: <tkrat.f159c58fec599d72@s5r6.in-berlin.de>
References: <je7iwa1l8a.fsf@sykes.suse.de>
 <1167429171.23340.125.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>> Bisecting has identified this commit:
>> 
>> commit 9b7d9c096dd4e4baacc21b2588662bbb56f36c4e
>> Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
>> Date:   Wed Nov 22 21:44:34 2006 +0100
>> 
>>     ieee1394: sbp2: convert from PCI DMA to generic DMA
>>     
>>     API conversion without change in functionality
>>     
>>     Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
>> 
>> 
>> I'm only seeing this on ppc64, ppc32 seems to be working fine.
> 
> The patch looks totally bogus to me. It's passing a random struct device
> from the hbsp host data structure to the dma_map_* routines. which they
> can't do anything about.
[...]
> So if you are to pass a struct device pointer to dma_map_*, use the one
> inside the pci_dev of the host. Or have the host driver provide you with
> the struct device pointer (which is the one from the pci_dev * for PCI
> implementations, and others give you what they are on, assuming the
> platform can do dma-* on that device).
[...]

The parent device of my bogus fw-host device should do the trick. Alas I
can't test on ppc64 or with anything else than ohci1394 driven
controllers...


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: sbp2: fix bogus dma mapping

Need to use a PCI device, not a FireWire host device.  Problem found by
Andreas Schwab, mistake pointed out by Benjamin Herrenschmidt.
http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029595.html

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   73 +++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

Index: linux-2.6.20-rc2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.20-rc2.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.20-rc2/drivers/ieee1394/sbp2.c
@@ -490,11 +490,11 @@ static int sbp2util_create_command_orb_p
 			spin_unlock_irqrestore(&lu->cmd_orb_lock, flags);
 			return -ENOMEM;
 		}
-		cmd->command_orb_dma = dma_map_single(&hi->host->device,
+		cmd->command_orb_dma = dma_map_single(hi->host->device.parent,
 						&cmd->command_orb,
 						sizeof(struct sbp2_command_orb),
 						DMA_TO_DEVICE);
-		cmd->sge_dma = dma_map_single(&hi->host->device,
+		cmd->sge_dma = dma_map_single(hi->host->device.parent,
 					&cmd->scatter_gather_element,
 					sizeof(cmd->scatter_gather_element),
 					DMA_BIDIRECTIONAL);
@@ -516,10 +516,11 @@ static void sbp2util_remove_command_orb_
 	if (!list_empty(&lu->cmd_orb_completed))
 		list_for_each_safe(lh, next, &lu->cmd_orb_completed) {
 			cmd = list_entry(lh, struct sbp2_command_info, list);
-			dma_unmap_single(&host->device, cmd->command_orb_dma,
+			dma_unmap_single(host->device.parent,
+					 cmd->command_orb_dma,
 					 sizeof(struct sbp2_command_orb),
 					 DMA_TO_DEVICE);
-			dma_unmap_single(&host->device, cmd->sge_dma,
+			dma_unmap_single(host->device.parent, cmd->sge_dma,
 					 sizeof(cmd->scatter_gather_element),
 					 DMA_BIDIRECTIONAL);
 			kfree(cmd);
@@ -601,17 +602,17 @@ static void sbp2util_mark_command_comple
 
 	if (cmd->cmd_dma) {
 		if (cmd->dma_type == CMD_DMA_SINGLE)
-			dma_unmap_single(&host->device, cmd->cmd_dma,
+			dma_unmap_single(host->device.parent, cmd->cmd_dma,
 					 cmd->dma_size, cmd->dma_dir);
 		else if (cmd->dma_type == CMD_DMA_PAGE)
-			dma_unmap_page(&host->device, cmd->cmd_dma,
+			dma_unmap_page(host->device.parent, cmd->cmd_dma,
 				       cmd->dma_size, cmd->dma_dir);
 		/* XXX: Check for CMD_DMA_NONE bug */
 		cmd->dma_type = CMD_DMA_NONE;
 		cmd->cmd_dma = 0;
 	}
 	if (cmd->sge_buffer) {
-		dma_unmap_sg(&host->device, cmd->sge_buffer,
+		dma_unmap_sg(host->device.parent, cmd->sge_buffer,
 			     cmd->dma_size, cmd->dma_dir);
 		cmd->sge_buffer = NULL;
 	}
@@ -836,37 +837,37 @@ static int sbp2_start_device(struct sbp2
 	struct sbp2_fwhost_info *hi = lu->hi;
 	int error;
 
-	lu->login_response = dma_alloc_coherent(&hi->host->device,
+	lu->login_response = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_login_response),
 				     &lu->login_response_dma, GFP_KERNEL);
 	if (!lu->login_response)
 		goto alloc_fail;
 
-	lu->query_logins_orb = dma_alloc_coherent(&hi->host->device,
+	lu->query_logins_orb = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_query_logins_orb),
 				     &lu->query_logins_orb_dma, GFP_KERNEL);
 	if (!lu->query_logins_orb)
 		goto alloc_fail;
 
-	lu->query_logins_response = dma_alloc_coherent(&hi->host->device,
+	lu->query_logins_response = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_query_logins_response),
 				     &lu->query_logins_response_dma, GFP_KERNEL);
 	if (!lu->query_logins_response)
 		goto alloc_fail;
 
-	lu->reconnect_orb = dma_alloc_coherent(&hi->host->device,
+	lu->reconnect_orb = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_reconnect_orb),
 				     &lu->reconnect_orb_dma, GFP_KERNEL);
 	if (!lu->reconnect_orb)
 		goto alloc_fail;
 
-	lu->logout_orb = dma_alloc_coherent(&hi->host->device,
+	lu->logout_orb = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_logout_orb),
 				     &lu->logout_orb_dma, GFP_KERNEL);
 	if (!lu->logout_orb)
 		goto alloc_fail;
 
-	lu->login_orb = dma_alloc_coherent(&hi->host->device,
+	lu->login_orb = dma_alloc_coherent(hi->host->device.parent,
 				     sizeof(struct sbp2_login_orb),
 				     &lu->login_orb_dma, GFP_KERNEL);
 	if (!lu->login_orb)
@@ -929,32 +930,32 @@ static void sbp2_remove_device(struct sb
 	list_del(&lu->lu_list);
 
 	if (lu->login_response)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_login_response),
 				    lu->login_response,
 				    lu->login_response_dma);
 	if (lu->login_orb)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_login_orb),
 				    lu->login_orb,
 				    lu->login_orb_dma);
 	if (lu->reconnect_orb)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_reconnect_orb),
 				    lu->reconnect_orb,
 				    lu->reconnect_orb_dma);
 	if (lu->logout_orb)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_logout_orb),
 				    lu->logout_orb,
 				    lu->logout_orb_dma);
 	if (lu->query_logins_orb)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_query_logins_orb),
 				    lu->query_logins_orb,
 				    lu->query_logins_orb_dma);
 	if (lu->query_logins_response)
-		dma_free_coherent(&hi->host->device,
+		dma_free_coherent(hi->host->device.parent,
 				    sizeof(struct sbp2_query_logins_response),
 				    lu->query_logins_response,
 				    lu->query_logins_response_dma);
@@ -1445,7 +1446,7 @@ static void sbp2_prep_command_orb_sg(str
 
 		cmd->dma_size = sgpnt[0].length;
 		cmd->dma_type = CMD_DMA_PAGE;
-		cmd->cmd_dma = dma_map_page(&hi->host->device,
+		cmd->cmd_dma = dma_map_page(hi->host->device.parent,
 					    sgpnt[0].page, sgpnt[0].offset,
 					    cmd->dma_size, cmd->dma_dir);
 
@@ -1457,8 +1458,8 @@ static void sbp2_prep_command_orb_sg(str
 						&cmd->scatter_gather_element[0];
 		u32 sg_count, sg_len;
 		dma_addr_t sg_addr;
-		int i, count = dma_map_sg(&hi->host->device, sgpnt, scsi_use_sg,
-					  dma_dir);
+		int i, count = dma_map_sg(hi->host->device.parent, sgpnt,
+					  scsi_use_sg, dma_dir);
 
 		cmd->dma_size = scsi_use_sg;
 		cmd->sge_buffer = sgpnt;
@@ -1508,7 +1509,8 @@ static void sbp2_prep_command_orb_no_sg(
 	cmd->dma_dir = dma_dir;
 	cmd->dma_size = scsi_request_bufflen;
 	cmd->dma_type = CMD_DMA_SINGLE;
-	cmd->cmd_dma = dma_map_single(&hi->host->device, scsi_request_buffer,
+	cmd->cmd_dma = dma_map_single(hi->host->device.parent,
+				      scsi_request_buffer,
 				      cmd->dma_size, cmd->dma_dir);
 	orb->data_descriptor_hi = ORB_SET_NODE_ID(hi->host->node_id);
 	orb->misc |= ORB_SET_DIRECTION(orb_direction);
@@ -1626,10 +1628,11 @@ static void sbp2_link_orb_command(struct
 	size_t length;
 	unsigned long flags;
 
-	dma_sync_single_for_device(&hi->host->device, cmd->command_orb_dma,
+	dma_sync_single_for_device(hi->host->device.parent,
+				   cmd->command_orb_dma,
 				   sizeof(struct sbp2_command_orb),
 				   DMA_TO_DEVICE);
-	dma_sync_single_for_device(&hi->host->device, cmd->sge_dma,
+	dma_sync_single_for_device(hi->host->device.parent, cmd->sge_dma,
 				   sizeof(cmd->scatter_gather_element),
 				   DMA_BIDIRECTIONAL);
 
@@ -1655,14 +1658,15 @@ static void sbp2_link_orb_command(struct
 		 * The target's fetch agent may or may not have read this
 		 * previous ORB yet.
 		 */
-		dma_sync_single_for_cpu(&hi->host->device, last_orb_dma,
+		dma_sync_single_for_cpu(hi->host->device.parent, last_orb_dma,
 					sizeof(struct sbp2_command_orb),
 					DMA_TO_DEVICE);
 		last_orb->next_ORB_lo = cpu_to_be32(cmd->command_orb_dma);
 		wmb();
 		/* Tells hardware that this pointer is valid */
 		last_orb->next_ORB_hi = 0;
-		dma_sync_single_for_device(&hi->host->device, last_orb_dma,
+		dma_sync_single_for_device(hi->host->device.parent,
+					   last_orb_dma,
 					   sizeof(struct sbp2_command_orb),
 					   DMA_TO_DEVICE);
 		addr += SBP2_DOORBELL_OFFSET;
@@ -1790,10 +1794,11 @@ static int sbp2_handle_status_write(stru
 	else
 		cmd = sbp2util_find_command_for_orb(lu, sb->ORB_offset_lo);
 	if (cmd) {
-		dma_sync_single_for_cpu(&hi->host->device, cmd->command_orb_dma,
+		dma_sync_single_for_cpu(hi->host->device.parent,
+					cmd->command_orb_dma,
 					sizeof(struct sbp2_command_orb),
 					DMA_TO_DEVICE);
-		dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
+		dma_sync_single_for_cpu(hi->host->device.parent, cmd->sge_dma,
 					sizeof(cmd->scatter_gather_element),
 					DMA_BIDIRECTIONAL);
 		/* Grab SCSI command pointers and check status. */
@@ -1931,10 +1936,11 @@ static void sbp2scsi_complete_all_comman
 	while (!list_empty(&lu->cmd_orb_inuse)) {
 		lh = lu->cmd_orb_inuse.next;
 		cmd = list_entry(lh, struct sbp2_command_info, list);
-		dma_sync_single_for_cpu(&hi->host->device, cmd->command_orb_dma,
+		dma_sync_single_for_cpu(hi->host->device.parent,
+				        cmd->command_orb_dma,
 					sizeof(struct sbp2_command_orb),
 					DMA_TO_DEVICE);
-		dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
+		dma_sync_single_for_cpu(hi->host->device.parent, cmd->sge_dma,
 					sizeof(cmd->scatter_gather_element),
 					DMA_BIDIRECTIONAL);
 		sbp2util_mark_command_completed(lu, cmd);
@@ -2059,11 +2065,12 @@ static int sbp2scsi_abort(struct scsi_cm
 		spin_lock_irqsave(&lu->cmd_orb_lock, flags);
 		cmd = sbp2util_find_command_for_SCpnt(lu, SCpnt);
 		if (cmd) {
-			dma_sync_single_for_cpu(&hi->host->device,
+			dma_sync_single_for_cpu(hi->host->device.parent,
 					cmd->command_orb_dma,
 					sizeof(struct sbp2_command_orb),
 					DMA_TO_DEVICE);
-			dma_sync_single_for_cpu(&hi->host->device, cmd->sge_dma,
+			dma_sync_single_for_cpu(hi->host->device.parent,
+					cmd->sge_dma,
 					sizeof(cmd->scatter_gather_element),
 					DMA_BIDIRECTIONAL);
 			sbp2util_mark_command_completed(lu, cmd);



-- 
Stefan Richter
-=====-=-==- ==-- ===-=
http://arcgraph.de/sr/

