Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWH0LcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWH0LcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWH0LcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:32:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9966 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750981AbWH0LcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:32:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 27 Aug 2006 13:28:56 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4 3/5] ieee1394: sbp2: safer last_orb and next_ORB
 handling
To: Linus Torvalds <torvalds@osdl.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
Message-ID: <tkrat.08afd1289ed91652@s5r6.in-berlin.de>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sbp2 initiator has two ways to tell a target's fetch agent about new
command ORBs:
 - Write the ORB's address to the ORB_POINTER register.  This must not
   be done while the fetch agent is active.
 - Put the ORB's address into the previously submitted ORB's next_ORB
   field and write to the DOORBELL register.  This may be done while the
   fetch agent is active or suspended.  It must not be done while the
   fetch agent is in reset state.
Sbp2 has a last_orb pointer which indicates in what way a new command
should be announced.  That pointer is concurrently accessed at various
occasions.  Furthermore, initiator and target are accessing the next_ORB
field of ORBs concurrently and asynchronously.

This patch does:
 - Protect all initiator accesses to last_orb by sbp2_command_orb_lock.
 - Add pci_dma_sync_single_for_device before a previously submitted
   ORB's next_ORB field is overwritten.
 - Insert a memory barrier between when next_ORB_lo and next_ORB_hi are
   overwritten.  Next_ORB_hi must not be updated before next_ORB_lo.
 - Remove the rather unspecific and now superfluous qualifier "volatile"
   from the next_ORB fields.
 - Add comments on how last_orb is connected with what is known about
   the target's fetch agent's state.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.h	2006-08-27 12:35:40.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.h	2006-08-27 12:37:13.000000000 +0200
@@ -46,8 +46,8 @@
 #define ORB_SET_DIRECTION(value)		((value & 0x1) << 27)
 
 struct sbp2_command_orb {
-	volatile u32 next_ORB_hi;
-	volatile u32 next_ORB_lo;
+	u32 next_ORB_hi;
+	u32 next_ORB_lo;
 	u32 data_descriptor_hi;
 	u32 data_descriptor_lo;
 	u32 misc;
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.c	2006-08-27 12:36:50.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.c	2006-08-27 12:37:13.000000000 +0200
@@ -1715,6 +1715,7 @@ static int sbp2_agent_reset(struct scsi_
 	quadlet_t data;
 	u64 addr;
 	int retval;
+	unsigned long flags;
 
 	SBP2_DEBUG_ENTER();
 
@@ -1734,7 +1735,9 @@ static int sbp2_agent_reset(struct scsi_
 	/*
 	 * Need to make sure orb pointer is written on next command
 	 */
+	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 	scsi_id->last_orb = NULL;
+	spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 	return 0;
 }
@@ -1976,8 +1979,12 @@ static int sbp2_link_orb_command(struct 
 {
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
 	struct sbp2_command_orb *command_orb = &command->command_orb;
-	struct node_entry *ne = scsi_id->ne;
-	u64 addr;
+	struct sbp2_command_orb *last_orb;
+	dma_addr_t last_orb_dma;
+	u64 addr = scsi_id->sbp2_command_block_agent_addr;
+	quadlet_t data[2];
+	size_t length;
+	unsigned long flags;
 
 	outstanding_orb_incr;
 	SBP2_ORB_DEBUG("sending command orb %p, total orbs = %x",
@@ -1992,64 +1999,50 @@ static int sbp2_link_orb_command(struct 
 	/*
 	 * Check to see if there are any previous orbs to use
 	 */
-	if (scsi_id->last_orb == NULL) {
-		quadlet_t data[2];
-
+	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
+	last_orb = scsi_id->last_orb;
+	last_orb_dma = scsi_id->last_orb_dma;
+	if (!last_orb) {
 		/*
-		 * Ok, let's write to the target's management agent register
+		 * last_orb == NULL means: We know that the target's fetch agent
+		 * is not active right now.
 		 */
-		addr = scsi_id->sbp2_command_block_agent_addr + SBP2_ORB_POINTER_OFFSET;
+		addr += SBP2_ORB_POINTER_OFFSET;
 		data[0] = ORB_SET_NODE_ID(hi->host->node_id);
 		data[1] = command->command_orb_dma;
 		sbp2util_cpu_to_be32_buffer(data, 8);
-
-		SBP2_ORB_DEBUG("write command agent, command orb %p", command_orb);
-
-		if (sbp2util_node_write_no_wait(ne, addr, data, 8) < 0) {
-			SBP2_ERR("sbp2util_node_write_no_wait failed.\n");
-			return -EIO;
-		}
-
-		SBP2_ORB_DEBUG("write command agent complete");
-
-		scsi_id->last_orb = command_orb;
-		scsi_id->last_orb_dma = command->command_orb_dma;
-
+		length = 8;
 	} else {
-		quadlet_t data;
-
 		/*
-		 * We have an orb already sent (maybe or maybe not
-		 * processed) that we can append this orb to. So do so,
-		 * and ring the doorbell. Have to be very careful
-		 * modifying these next orb pointers, as they are accessed
-		 * both by the sbp2 device and us.
+		 * last_orb != NULL means: We know that the target's fetch agent
+		 * is (very probably) not dead or in reset state right now.
+		 * We have an ORB already sent that we can append a new one to.
+		 * The target's fetch agent may or may not have read this
+		 * previous ORB yet.
 		 */
-		scsi_id->last_orb->next_ORB_lo =
-		    cpu_to_be32(command->command_orb_dma);
+		pci_dma_sync_single_for_cpu(hi->host->pdev, last_orb_dma,
+					    sizeof(struct sbp2_command_orb),
+					    PCI_DMA_BIDIRECTIONAL);
+		last_orb->next_ORB_lo = cpu_to_be32(command->command_orb_dma);
+		wmb();
 		/* Tells hardware that this pointer is valid */
-		scsi_id->last_orb->next_ORB_hi = 0x0;
-		pci_dma_sync_single_for_device(hi->host->pdev,
-					       scsi_id->last_orb_dma,
+		last_orb->next_ORB_hi = 0;
+		pci_dma_sync_single_for_device(hi->host->pdev, last_orb_dma,
 					       sizeof(struct sbp2_command_orb),
 					       PCI_DMA_BIDIRECTIONAL);
+		addr += SBP2_DOORBELL_OFFSET;
+		data[0] = 0;
+		length = 4;
+	}
+	scsi_id->last_orb = command_orb;
+	scsi_id->last_orb_dma = command->command_orb_dma;
+	spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
-		/*
-		 * Ring the doorbell
-		 */
-		data = cpu_to_be32(command->command_orb_dma);
-		addr = scsi_id->sbp2_command_block_agent_addr + SBP2_DOORBELL_OFFSET;
-
-		SBP2_ORB_DEBUG("ring doorbell, command orb %p", command_orb);
-
-		if (sbp2util_node_write_no_wait(ne, addr, &data, 4) < 0) {
-			SBP2_ERR("sbp2util_node_write_no_wait failed");
-			return -EIO;
-		}
-
-		scsi_id->last_orb = command_orb;
-		scsi_id->last_orb_dma = command->command_orb_dma;
-
+	SBP2_ORB_DEBUG("write to %s register, command orb %p",
+			last_orb ? "DOORBELL" : "ORB_POINTER", command_orb);
+	if (sbp2util_node_write_no_wait(scsi_id->ne, addr, data, length) < 0) {
+		SBP2_ERR("sbp2util_node_write_no_wait failed.\n");
+		return -EIO;
 	}
 	return 0;
 }
@@ -2241,14 +2234,16 @@ static int sbp2_handle_status_write(stru
 		}
 
 		/*
-		 * Check here to see if there are no commands in-use. If there are none, we can
-		 * null out last orb so that next time around we write directly to the orb pointer...
-		 * Quick start saves one 1394 bus transaction.
+		 * Check here to see if there are no commands in-use. If there
+		 * are none, we know that the fetch agent left the active state
+		 * _and_ that we did not reactivate it yet. Therefore clear
+		 * last_orb so that next time we write directly to the
+		 * ORB_POINTER register. That way the fetch agent does not need
+		 * to refetch the next_ORB.
 		 */
 		spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
-		if (list_empty(&scsi_id->sbp2_command_orb_inuse)) {
+		if (list_empty(&scsi_id->sbp2_command_orb_inuse))
 			scsi_id->last_orb = NULL;
-		}
 		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 	} else {


