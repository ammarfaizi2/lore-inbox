Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276843AbRJCCpo>; Tue, 2 Oct 2001 22:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276842AbRJCCpa>; Tue, 2 Oct 2001 22:45:30 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:5242
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S276840AbRJCCpH>; Tue, 2 Oct 2001 22:45:07 -0400
Message-Id: <200110030244.f932ikI10190@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 53c700 update for 2.4.10-ac3
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-4667027150"
Date: Tue, 02 Oct 2001 21:44:45 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-4667027150
Content-Type: text/plain; charset=us-ascii

This updates the driver to version 2.6.  The main changes are:

- Updated README describing better how to use the chip driver.
- Now uses coherent pci memory on parisc.
- 64 bit i/o mapping support should be complete (for 64 bit parisc).

It's been tested on a variety of parisc and x86 microchannel hardware.  
Richard Hirst is still running the 64 bit version of the driver through its 
paces, but it seems OK so far.

James Bottomley


--==_Exmh_-4667027150
Content-Type: text/plain ; name="53c700-2.6.diff"; charset=us-ascii
Content-Description: 53c700-2.6.diff
Content-Disposition: attachment; filename="53c700-2.6.diff"

Index: linux/2.4/Makefile
diff -u linux/2.4/Makefile:1.1.1.30 linux/2.4/Makefile:1.1.1.30.2.1
--- linux/2.4/Makefile:1.1.1.30	Mon Oct  1 19:57:48 2001
+++ linux/2.4/Makefile	Mon Oct  1 22:33:19 2001
@@ -211,7 +211,7 @@
 	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
 	drivers/scsi/aic7xxx/aicasm/aicasm \
-	drivers/scsi/53c700-mem.c \
+	drivers/scsi/53c700_d.h \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*
Index: linux/2.4/drivers/scsi/53c700.c
diff -u linux/2.4/drivers/scsi/53c700.c:1.1.1.4 linux/2.4/drivers/scsi/53c700.c:1.1.1.4.2.2
--- linux/2.4/drivers/scsi/53c700.c:1.1.1.4	Tue Sep 25 18:58:28 2001
+++ linux/2.4/drivers/scsi/53c700.c	Tue Oct  2 20:47:11 2001
@@ -51,6 +51,12 @@
 
 /* CHANGELOG
  *
+ * Version 2.6
+ *
+ * Following test of the 64 bit parisc kernel by Richard Hirst,
+ * several problems have now been corrected.  Also adds support for
+ * consistent memory allocation.
+ *
  * Version 2.5
  * 
  * More Compatibility changes for 710 (now actually works).  Enhanced
@@ -90,7 +96,7 @@
  * Initial modularisation from the D700.  See NCR_D700.c for the rest of
  * the changelog.
  * */
-#define NCR_700_VERSION "2.5"
+#define NCR_700_VERSION "2.6"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -217,18 +223,39 @@
 NCR_700_detect(Scsi_Host_Template *tpnt,
 	       struct NCR_700_Host_Parameters *hostdata)
 {
-	dma_addr_t pScript, pSlots;
+	dma_addr_t pScript, pMemory, pSlots;
+	__u8 *memory;
 	__u32 *script;
 	struct Scsi_Host *host;
 	static int banner = 0;
 	int j;
 
-	/* This separation of pScript and script is not strictly
-	 * necessay, but may be useful in architectures which can
-	 * allocate consistent memory on which virt_to_bus will not
-	 * work */
-	script = kmalloc(sizeof(SCRIPT), GFP_KERNEL);
-	pScript = virt_to_bus(script);
+#ifdef CONFIG_53C700_USE_CONSISTENT
+	memory = pci_alloc_consistent(hostdata->pci_dev, TOTAL_MEM_SIZE,
+				      &pMemory);
+	hostdata->consistent = 1;
+	if(memory == NULL ) {
+		printk(KERN_WARNING "53c700: consistent memory allocation failed\n");
+#endif
+		memory = kmalloc(TOTAL_MEM_SIZE, GFP_KERNEL);
+		if(memory == NULL) {
+			printk(KERN_ERR "53c700: Failed to allocate memory for driver, detatching\n");
+			return NULL;
+		}
+		pMemory = pci_map_single(hostdata->pci_dev, memory,
+					 TOTAL_MEM_SIZE, PCI_DMA_BIDIRECTIONAL);
+#ifdef CONFIG_53C700_USE_CONSISTENT
+		hostdata->consistent = 0;
+	}
+#endif
+	script = (__u32 *)memory;
+	pScript = pMemory;
+	hostdata->msgin = memory + MSGIN_OFFSET;
+	hostdata->msgout = memory + MSGOUT_OFFSET;
+	hostdata->status = memory + STATUS_OFFSET;
+	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
+		
+	pSlots = pMemory + SLOTS_OFFSET;
 
 	/* Fill in the missing routines from the host template */
 	tpnt->queuecommand = NCR_700_queuecommand;
@@ -251,29 +278,6 @@
 
 	if((host = scsi_register(tpnt, 4)) == NULL)
 		return NULL;
-	if(script == NULL) {
-		printk(KERN_ERR "53c700: Failed to allocate script, detatching\n");
-		scsi_unregister(host);
-		return NULL;
-	}
-
-	/* This separation of slots and pSlots may facilitate later
-	 * migration to consistent memory on architectures which
-	 * support it */
-	hostdata->slots = kmalloc(sizeof(struct NCR_700_command_slot)
-				  * NCR_700_COMMAND_SLOTS_PER_HOST,
-				  GFP_KERNEL);
-	pSlots = virt_to_bus(hostdata->slots);
-
-	hostdata->msgin = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
-	hostdata->msgout = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
-	hostdata->status = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
-	if(hostdata->slots == NULL || hostdata->msgin == NULL
-	   || hostdata->msgout == NULL || hostdata->status==NULL) {
-		printk(KERN_ERR "53c700: Failed to allocate command slots or message buffers, detatching\n");
-		scsi_unregister(host);
-		return NULL;
-	}
 	memset(hostdata->slots, 0, sizeof(struct NCR_700_command_slot)
 	       * NCR_700_COMMAND_SLOTS_PER_HOST);
 	for(j = 0; j < NCR_700_COMMAND_SLOTS_PER_HOST; j++) {
@@ -295,19 +299,17 @@
 	for(j = 0; j < PATCHES; j++) {
 		script[LABELPATCHES[j]] = bS_to_host(pScript + SCRIPT[LABELPATCHES[j]]);
 	}
-	/* now patch up fixed addresses. 
-	 * NOTE: virt_to_bus may be wrong if consistent memory is used
-	 * for these in the future */
+	/* now patch up fixed addresses. */
 	script_patch_32(script, MessageLocation,
-			virt_to_bus(&hostdata->msgout[0]));
+			pScript + MSGOUT_OFFSET);
 	script_patch_32(script, StatusAddress,
-			virt_to_bus(&hostdata->status[0]));
+			pScript + STATUS_OFFSET);
 	script_patch_32(script, ReceiveMsgAddress,
-			virt_to_bus(&hostdata->msgin[0]));
+			pScript + MSGIN_OFFSET);
 
 	hostdata->script = script;
 	hostdata->pScript = pScript;
-	dma_cache_wback((unsigned long)script, sizeof(SCRIPT));
+	NCR_700_dma_cache_wback((unsigned long)script, sizeof(SCRIPT));
 	hostdata->state = NCR_700_HOST_FREE;
 	spin_lock_init(&hostdata->lock);
 	hostdata->cmd = NULL;
@@ -344,13 +346,18 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
-	/* NOTE: these may be NULL if we weren't fully initialised before
-	 * the scsi_unregister was called */
-	kfree(hostdata->script);
-	kfree(hostdata->slots);
-	kfree(hostdata->msgin);
-	kfree(hostdata->msgout);
-	kfree(hostdata->status);
+#ifdef CONFIG_53C700_USE_CONSISTENT
+	if(hostdata->consistent) {
+		pci_free_consistent(hostdata->pci_dev, TOTAL_MEM_SIZE,
+				    hostdata->script, hostdata->pScript);
+	} else {
+#endif
+		pci_unmap_single(hostdata->pci_dev, hostdata->pScript,
+				 TOTAL_MEM_SIZE, PCI_DMA_BIDIRECTIONAL);
+		kfree(hostdata->script);
+#ifdef CONFIG_53C700_USE_CONSISTENT
+	}
+#endif
 	return 1;
 }
 
@@ -620,9 +627,27 @@
 	}
 	return (offset & 0x0f) | (XFERP & 0x07)<<4;
 }
-	
 
 STATIC inline void
+NCR_700_unmap(struct NCR_700_Host_Parameters *hostdata, Scsi_Cmnd *SCp,
+	      struct NCR_700_command_slot *slot)
+{
+	if(SCp->sc_data_direction != SCSI_DATA_NONE &&
+	   SCp->sc_data_direction != SCSI_DATA_UNKNOWN) {
+		int pci_direction = scsi_to_pci_dma_dir(SCp->sc_data_direction);
+		if(SCp->use_sg) {
+			pci_unmap_sg(hostdata->pci_dev, SCp->buffer,
+				     SCp->use_sg, pci_direction);
+		} else {
+			pci_unmap_single(hostdata->pci_dev,
+					 slot->dma_handle,
+					 SCp->request_bufflen,
+					 pci_direction);
+		}
+	}
+}
+
+STATIC inline void
 NCR_700_scsi_done(struct NCR_700_Host_Parameters *hostdata,
 	       Scsi_Cmnd *SCp, int result)
 {
@@ -632,31 +657,22 @@
 	if(SCp != NULL) {
 		struct NCR_700_command_slot *slot = 
 			(struct NCR_700_command_slot *)SCp->host_scribble;
-
+		
+		NCR_700_unmap(hostdata, SCp, slot);
+		pci_unmap_single(hostdata->pci_dev, slot->pCmd,
+				 sizeof(SCp->cmnd), PCI_DMA_TODEVICE);
 		if(SCp->cmnd[0] == REQUEST_SENSE && SCp->cmnd[6] == NCR_700_INTERNAL_SENSE_MAGIC) {
 #ifdef NCR_700_DEBUG
 			printk(" ORIGINAL CMD %p RETURNED %d, new return is %d sense is\n",
 			       SCp, SCp->cmnd[7], result);
 			print_sense("53c700", SCp);
+
 #endif
+			SCp->use_sg = SCp->cmnd[8];
 			if(result == 0)
 				result = SCp->cmnd[7];
 		}
 
-		if(SCp->sc_data_direction != SCSI_DATA_NONE &&
-		   SCp->sc_data_direction != SCSI_DATA_UNKNOWN) {
-			int pci_direction = scsi_to_pci_dma_dir(SCp->sc_data_direction);
-			if(SCp->use_sg) {
-				pci_unmap_sg(hostdata->pci_dev, SCp->buffer,
-					     SCp->use_sg, pci_direction);
-			} else {
-				pci_unmap_single(hostdata->pci_dev,
-						 slot->dma_handle,
-						 SCp->request_bufflen,
-						 pci_direction);
-			}
-		}
-
 		free_slot(slot, hostdata);
 
 		SCp->host_scribble = NULL;
@@ -850,7 +866,7 @@
 			printk(KERN_WARNING "scsi%d Unexpected SDTR msg\n",
 			       host->host_no);
 			hostdata->msgout[0] = A_REJECT_MSG;
-			dma_cache_wback((unsigned long)hostdata->msgout, 1);
+			NCR_700_dma_cache_wback((unsigned long)hostdata->msgout, 1);
 			script_patch_16(hostdata->script, MessageCount, 1);
 			/* SendMsgOut returns, so set up the return
 			 * address */
@@ -862,7 +878,7 @@
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, 1);
+		NCR_700_dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 
@@ -876,7 +892,7 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, 1);
+		NCR_700_dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
@@ -954,7 +970,7 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, 1);
+		NCR_700_dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
@@ -964,7 +980,7 @@
 	}
 	NCR_700_writel(temp, host, TEMP_REG);
 	/* set us up to receive another message */
-	dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
+	NCR_700_dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
 	return resume_offset;
 }
 
@@ -1002,10 +1018,15 @@
 				printk("  cmd %p has status %d, requesting sense\n",
 				       SCp, hostdata->status[0]);
 #endif
-				/* we can destroy the command here because the
-				 * contingent allegiance condition will cause a 
-				 * retry which will re-copy the command from the
-				 * saved data_cmnd */
+				/* we can destroy the command here
+				 * because the contingent allegiance
+				 * condition will cause a retry which
+				 * will re-copy the command from the
+				 * saved data_cmnd.  We also unmap any
+				 * data associated with the command
+				 * here */
+				NCR_700_unmap(hostdata, SCp, slot);
+
 				SCp->cmnd[0] = REQUEST_SENSE;
 				SCp->cmnd[1] = (SCp->lun & 0x7) << 5;
 				SCp->cmnd[2] = 0;
@@ -1013,21 +1034,29 @@
 				SCp->cmnd[4] = sizeof(SCp->sense_buffer);
 				SCp->cmnd[5] = 0;
 				SCp->cmd_len = 6;
-				/* Here's a quiet hack: the REQUEST_SENSE command is
-				 * six bytes, so store a flag indicating that this
-				 * was an internal sense request and the original
-				 * status at the end of the command */
+				/* Here's a quiet hack: the
+				 * REQUEST_SENSE command is six bytes,
+				 * so store a flag indicating that
+				 * this was an internal sense request
+				 * and the original status at the end
+				 * of the command */
 				SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
 				SCp->cmnd[7] = hostdata->status[0];
+				SCp->cmnd[8] = SCp->use_sg;
+				SCp->use_sg = 0;
 				SCp->sc_data_direction = SCSI_DATA_READ;
-				dma_cache_wback((unsigned long)SCp->cmnd, SCp->cmd_len);
+				pci_dma_sync_single(hostdata->pci_dev,
+						    slot->pCmd,
+						    SCp->cmd_len,
+						    PCI_DMA_TODEVICE);
+				slot->dma_handle = pci_map_single(hostdata->pci_dev, SCp->sense_buffer, sizeof(SCp->sense_buffer), PCI_DMA_FROMDEVICE);
 				slot->SG[0].ins = bS_to_host(SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer));
-				slot->SG[0].pAddr = bS_to_host(virt_to_bus(SCp->sense_buffer));
+				slot->SG[0].pAddr = bS_to_host(slot->dma_handle);
 				slot->SG[1].ins = bS_to_host(SCRIPT_RETURN);
 				slot->SG[1].pAddr = 0;
 				slot->resume_offset = hostdata->pScript;
-				dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG[0])*2);
-				dma_cache_inv((unsigned long)SCp->sense_buffer, sizeof(SCp->sense_buffer));
+				NCR_700_dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG[0])*2);
+				NCR_700_dma_cache_inv((unsigned long)SCp->sense_buffer, sizeof(SCp->sense_buffer));
 				
 				/* queue the command for reissue */
 				slot->state = NCR_700_SLOT_QUEUED;
@@ -1136,7 +1165,7 @@
 
 			/* re-patch for this command */
 			script_patch_32_abs(hostdata->script, CommandAddress, 
-					    virt_to_bus(slot->cmnd->cmnd));
+					    slot->pCmd);
 			script_patch_16(hostdata->script,
 					CommandCount, slot->cmnd->cmd_len);
 			script_patch_32_abs(hostdata->script, SGScriptStartAddress,
@@ -1149,13 +1178,13 @@
 			 * should therefore always clear ACK */
 			NCR_700_writeb(NCR_700_get_SXFER(hostdata->cmd->device),
 				       host, SXFER_REG);
-			dma_cache_inv((unsigned long)hostdata->msgin,
+			NCR_700_dma_cache_inv((unsigned long)hostdata->msgin,
 				      MSG_ARRAY_SIZE);
-			dma_cache_wback((unsigned long)hostdata->msgout,
+			NCR_700_dma_cache_wback((unsigned long)hostdata->msgout,
 					MSG_ARRAY_SIZE);
 			/* I'm just being paranoid here, the command should
 			 * already have been flushed from the cache */
-			dma_cache_wback((unsigned long)slot->cmnd->cmnd,
+			NCR_700_dma_cache_wback((unsigned long)slot->cmnd->cmnd,
 					slot->cmnd->cmd_len);
 
 
@@ -1219,7 +1248,8 @@
 		hostdata->reselection_id = reselection_id;
 		/* just in case we have a stale simple tag message, clear it */
 		hostdata->msgin[1] = 0;
-		dma_cache_wback_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
+		NCR_700_dma_cache_wback_inv((unsigned long)hostdata->msgin,
+					    MSG_ARRAY_SIZE);
 		if(hostdata->tag_negotiated & (1<<reselection_id)) {
 			resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
 		} else {
@@ -1334,7 +1364,7 @@
 	hostdata->cmd = NULL;
 	/* clear any stale simple tag message */
 	hostdata->msgin[1] = 0;
-	dma_cache_wback_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
+	NCR_700_dma_cache_wback_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
 
 	if(id == 0xff) {
 		/* Selected as target, Ignore */
@@ -1404,7 +1434,7 @@
 	 * set up so we cannot take a selection interrupt */
 
 	hostdata->msgout[0] = NCR_700_identify(SCp->cmnd[0] != REQUEST_SENSE,
-					    SCp->lun);
+					       SCp->lun);
 	/* for INQUIRY or REQUEST_SENSE commands, we cannot be sure
 	 * if the negotiated transfer parameters still hold, so
 	 * always renegotiate them */
@@ -1437,7 +1467,7 @@
 			Device_ID, 1<<SCp->target);
 
 	script_patch_32_abs(hostdata->script, CommandAddress, 
-			virt_to_bus(SCp->cmnd));
+			    slot->pCmd);
 	script_patch_16(hostdata->script, CommandCount, SCp->cmd_len);
 	/* finally plumb the beginning of the SG list into the script
 	 * */
@@ -1448,10 +1478,10 @@
 	if(slot->resume_offset == 0)
 		slot->resume_offset = hostdata->pScript;
 	/* now perform all the writebacks and invalidates */
-	dma_cache_wback((unsigned long)hostdata->msgout, count);
-	dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
-	dma_cache_wback((unsigned long)SCp->cmnd, SCp->cmd_len);
-	dma_cache_inv((unsigned long)hostdata->status, 1);
+	NCR_700_dma_cache_wback((unsigned long)hostdata->msgout, count);
+	NCR_700_dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
+	NCR_700_dma_cache_wback((unsigned long)SCp->cmnd, SCp->cmd_len);
+	NCR_700_dma_cache_inv((unsigned long)hostdata->status, 1);
 
 	/* set the synchronous period/offset */
 	NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
@@ -1519,7 +1549,7 @@
 
 		DEBUG(("scsi%d: istat %02x sstat0 %02x dstat %02x dsp %04x[%08x] dsps 0x%x\n",
 		       host->host_no, istat, sstat0, dstat,
-		       (dsp - (__u32)virt_to_bus(hostdata->script))/4,
+		       (dsp - (__u32)(hostdata->pScript))/4,
 		       dsp, dsps));
 
 		if(SCp != NULL) {
@@ -1632,7 +1662,7 @@
 					slot->SG[i].ins = bS_to_host(SCRIPT_NOP);
 					slot->SG[i].pAddr = 0;
 				}
-				dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
+				NCR_700_dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
 				/* and pretend we disconnected after
 				 * the command phase */
 				resume_offset = hostdata->pScript + Ent_MsgInDuringData;
@@ -1847,7 +1877,13 @@
 #endif
 		
 		if(old != NULL && old->tag == SCp->device->current_tag) {
-			printk(KERN_WARNING "scsi%d (%d:%d) Tag clock back to current, queueing\n", SCp->host->host_no, SCp->target, SCp->lun);
+			/* On some badly starving drives, this can be
+			 * a frequent occurance, so print the message
+			 * only once */
+			if(NCR_700_is_flag_clear(SCp->device, NCR_700_DEV_TAG_STARVATION_WARNED)) {
+				printk(KERN_WARNING "scsi%d (%d:%d) Target is suffering from tag starvation.\n", SCp->host->host_no, SCp->target, SCp->lun);
+				NCR_700_set_flag(SCp->device, NCR_700_DEV_TAG_STARVATION_WARNED);
+			}
 			return 1;
 		}
 		slot->tag = SCp->device->current_tag++;
@@ -1900,6 +1936,18 @@
 		hostdata->ITL_Hash_back[hash] = slot;
 	slot->ITL_back = NULL;
 
+	/* sanity check: some of the commands generated by the mid-layer
+	 * have an eccentric idea of their sc_data_direction */
+	if(!SCp->use_sg && !SCp->request_bufflen 
+	   && SCp->sc_data_direction != SCSI_DATA_NONE) {
+#ifdef NCR_700_DEBUG
+		printk("53c700: Command");
+		print_command(SCp->cmnd);
+		printk("Has wrong data direction %d\n", SCp->sc_data_direction);
+#endif
+		SCp->sc_data_direction = SCSI_DATA_NONE;
+	}
+
 	switch (SCp->cmnd[0]) {
 	case REQUEST_SENSE:
 		/* clear the internal sense magic */
@@ -1965,12 +2013,14 @@
 		}
 		slot->SG[i].ins = bS_to_host(SCRIPT_RETURN);
 		slot->SG[i].pAddr = 0;
-		dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
+		NCR_700_dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
 		DEBUG((" SETTING %08lx to %x\n",
-		       virt_to_bus(&slot->SG[i].ins), 
+		       (&slot->pSG[i].ins), 
 		       slot->SG[i].ins));
 	}
 	slot->resume_offset = 0;
+	slot->pCmd = pci_map_single(hostdata->pci_dev, SCp->cmnd,
+				    sizeof(SCp->cmnd), PCI_DMA_TODEVICE);
 	NCR_700_start_command(SCp);
 	return 0;
 }
Index: linux/2.4/drivers/scsi/53c700.h
diff -u linux/2.4/drivers/scsi/53c700.h:1.1.1.3 linux/2.4/drivers/scsi/53c700.h:1.1.1.3.2.2
--- linux/2.4/drivers/scsi/53c700.h:1.1.1.3	Tue Sep 25 18:58:28 2001
+++ linux/2.4/drivers/scsi/53c700.h	Tue Oct  2 20:47:11 2001
@@ -40,7 +40,25 @@
 #error "Config.in must define either CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi core."
 #endif
 
+/* macros for consistent memory allocation */
 
+#ifdef CONFIG_53C700_USE_CONSISTENT
+#define NCR_700_dma_cache_wback(mem, size) \
+	if(!hostdata->consistent) \
+		dma_cache_wback(mem, size)
+#define NCR_700_dma_cache_inv(mem, size) \
+	if(!hostdata->consistent) \
+		dma_cache_inv(mem, size)
+#define NCR_700_dma_cache_wback_inv(mem, size) \
+	if(!hostdata->consistent) \
+		dma_cache_wback_inv(mem, size)
+#else
+#define NCR_700_dma_cache_wback(mem, size) dma_cache_wback(mem,size)
+#define NCR_700_dma_cache_inv(mem, size) dma_cache_inv(mem,size)
+#define NCR_700_dma_cache_wback_inv(mem, size) dma_cache_wback_inv(mem,size)
+#endif
+
+
 struct NCR_700_Host_Parameters;
 
 /* These are the externally used routines */
@@ -86,6 +104,7 @@
 #define NCR_700_DEV_NEGOTIATED_SYNC	(1<<16)
 #define NCR_700_DEV_BEGIN_SYNC_NEGOTIATION	(1<<17)
 #define NCR_700_DEV_BEGIN_TAG_QUEUEING	(1<<18)
+#define NCR_700_DEV_TAG_STARVATION_WARNED (1<<19)
 
 static inline void
 NCR_700_set_SXFER(Scsi_Device *SDp, __u8 sxfer)
@@ -174,6 +193,8 @@
 	__u16	tag;
 	__u32	resume_offset;
 	Scsi_Cmnd	*cmnd;
+	/* The pci_mapped address of the actual command in cmnd */
+	dma_addr_t	pCmd;
 	__u32		temp;
 	/* if this command is a pci_single mapping, holds the dma address
 	 * for later unmapping in the done routine */
@@ -191,19 +212,22 @@
 	int	clock;			/* board clock speed in MHz */
 	__u32	base;			/* the base for the port (copied to host) */
 	struct pci_dev	*pci_dev;
-	__u8	dmode_extra;	/* adjustable bus settings */
-	__u8	differential:1;	/* if we are differential */
+	__u32	dmode_extra;	/* adjustable bus settings */
+	__u32	differential:1;	/* if we are differential */
 #ifdef CONFIG_53C700_LE_ON_BE
 	/* This option is for HP only.  Set it if your chip is wired for
 	 * little endian on this platform (which is big endian) */
-	__u8	force_le_on_be:1;
+	__u32	force_le_on_be:1;
 #endif
-	__u8	chip710:1;	/* set if really a 710 not 700 */
-	__u8	burst_disable:1;	/* set to 1 to disable 710 bursting */
+	__u32	chip710:1;	/* set if really a 710 not 700 */
+	__u32	burst_disable:1;	/* set to 1 to disable 710 bursting */
 
 	/* NOTHING BELOW HERE NEEDS ALTERING */
-	__u8	fast:1;		/* if we can alter the SCSI bus clock
+	__u32	fast:1;		/* if we can alter the SCSI bus clock
                                    speed (so can negiotiate sync) */
+#ifdef CONFIG_53C700_USE_CONSISTENT
+	__u32	consistent:1;
+#endif
 
 	int	sync_clock;	/* The speed of the SYNC core */
 
@@ -216,15 +240,23 @@
 	spinlock_t lock;
 	enum NCR_700_Host_State state; /* protected by state lock */
 	Scsi_Cmnd *cmd;
-
+	/* Note: pScript contains the single consistent block of
+	 * memory.  All the msgin, msgout and status are allocated in
+	 * this memory too (at separate cache lines).  TOTAL_MEM_SIZE
+	 * represents the total size of this area */
+#define	MSG_ARRAY_SIZE	8
+#define	MSGOUT_OFFSET	(L1_CACHE_ALIGN(sizeof(SCRIPT)))
 	__u8	*msgout;
-#define	MSG_ARRAY_SIZE	16
-	__u8	tag_negotiated;
-	__u8	*status;
+#define MSGIN_OFFSET	(MSGOUT_OFFSET + L1_CACHE_ALIGN(MSG_ARRAY_SIZE))
 	__u8	*msgin;
+#define STATUS_OFFSET	(MSGIN_OFFSET + L1_CACHE_ALIGN(MSG_ARRAY_SIZE))
+	__u8	*status;
+#define SLOTS_OFFSET	(STATUS_OFFSET + L1_CACHE_ALIGN(MSG_ARRAY_SIZE))
 	struct NCR_700_command_slot	*slots;
+#define	TOTAL_MEM_SIZE	(SLOTS_OFFSET + L1_CACHE_ALIGN(sizeof(struct NCR_700_command_slot) * NCR_700_COMMAND_SLOTS_PER_HOST))
 	int	saved_slot_position;
 	int	command_slot_count; /* protected by state lock */
+	__u8	tag_negotiated;
 	__u8	rev;
 	__u8	reselection_id;
 	/* flags for the host */
Index: linux/2.4/drivers/scsi/Config.in
diff -u linux/2.4/drivers/scsi/Config.in:1.1.1.19 linux/2.4/drivers/scsi/Config.in:1.1.1.19.2.2
--- linux/2.4/drivers/scsi/Config.in:1.1.1.19	Tue Sep 25 18:58:12 2001
+++ linux/2.4/drivers/scsi/Config.in	Tue Oct  2 20:47:11 2001
@@ -122,10 +122,11 @@
    fi
 fi
 if [ "$CONFIG_PARISC" = "y" ]; then
-   dep_tristate 'HP LASI SCSI support for 53c700' CONFIG_SCSI_LASI700 $CONFIG_SCSI
+   dep_tristate 'HP LASI SCSI support for 53c700/710' CONFIG_SCSI_LASI700 $CONFIG_SCSI
    if [ "$CONFIG_SCSI_LASI700" != "n" ]; then
       define_bool CONFIG_53C700_MEM_MAPPED y
       define_bool CONFIG_53C700_LE_ON_BE y
+      define_bool CONFIG_53C700_USE_CONSISTENT y
    fi
 fi
 dep_tristate 'NCR53c7,8xx SCSI support'  CONFIG_SCSI_NCR53C7xx $CONFIG_SCSI $CONFIG_PCI
Index: linux/2.4/drivers/scsi/README.53c700
diff -u linux/2.4/drivers/scsi/README.53c700:1.1.1.1 linux/2.4/drivers/scsi/README.53c700:1.1.1.1.22.1
--- linux/2.4/drivers/scsi/README.53c700:1.1.1.1	Mon May 14 18:48:23 2001
+++ linux/2.4/drivers/scsi/README.53c700	Mon Oct  1 22:26:31 2001
@@ -1,17 +1,154 @@
-This driver supports the 53c700 and 53c700-66 chips only.  It is full
-featured and does sync (-66 only), disconnects and tag command
-queueing.
+General Description
+===================
 
+This driver supports the 53c700 and 53c700-66 chips.  It also supports
+the 53c710 but only in 53c700 emulation mode.  It is full featured and
+does sync (-66 and 710 only), disconnects and tag command queueing.
+
 Since the 53c700 must be interfaced to a bus, you need to wrapper the
 card detector around this driver.  For an example, see the
-NCR_D700.[ch] files.
+NCR_D700.[ch] or lasi700.[ch] files.
 
 The comments in the 53c700.[ch] files tell you which parts you need to
 fill in to get the driver working.
+
+
+Compile Time Flags
+==================
+
+The driver may be either io mapped or memory mapped.  This is
+selectable by configuration flags:
+
+CONFIG_53C700_MEM_MAPPED
+
+define if the driver is memory mapped.
+
+CONFIG_53C700_IO_MAPPED
+
+define if the driver is to be io mapped.
+
+One or other of the above flags *must* be defined.
+
+Other flags are:
+
+CONFIG_53C700_LE_ON_BE
+
+define if the chipset must be supported in little endian mode on a big
+endian architecture (used for the 700 on parisc).
+
+CONFIG_53C700_USE_CONSISTENT
+
+allocate consistent memory (should only be used if your architecture
+has a mixture of consistent and inconsistent memory).  Fully
+consistent or fully inconsistent architectures should not define this.
+
+
+Using the Chip Core Driver
+==========================
+
+In order to plumb the 53c700 chip core driver into a working SCSI
+driver, you need to know three things about the way the chip is wired
+into your system (or expansion card).
+
+1. The clock speed of the SCSI core
+2. The interrupt line used
+3. The memory (or io space) location of the 53c700 registers.
+
+Optionally, you may also need to know other things, like how to read
+the SCSI Id from the card bios or whether the chip is wired for
+differential operation.
+
+Usually you can find items 2. and 3. from general spec. documents or
+even by examining the configuration of a working driver under another
+operating system.
+
+The clock speed is usually buried deep in the technical literature.
+It is required because it is used to set up both the synchronous and
+asynchronous dividers for the chip.  As a general rule of thumb,
+manufacturers set the clock speed at the lowest possible setting
+consistent with the best operation of the chip (although some choose
+to drive it off the CPU or bus clock rather than going to the expense
+of an extra clock chip).  The best operation clock speeds are:
+
+53c700 - 25MHz
+53c700-66 - 50MHz
+53c710 - 40Mhz
+
+Writing Your Glue Driver
+========================
+
+This will be a standard SCSI driver (I don't know of a good document
+describing this, just copy from some other driver) with at least a
+detect and release entry.
+
+In the detect routine, you need to allocate a struct
+NCR_700_Host_Parameters sized memory area and clear it (so that the
+default values for everything are 0).  Then you must fill in the
+parameters that matter to you (see below), plumb the NCR_700_intr
+routine into the interrupt line and call NCR_700_detect with the host
+template and the new parameters as arguments.  You should also call
+the relevant request_*_region function and place the register base
+address into the `base' pointer of the host parameters.
+
+In the release routine, you must free the NCR_700_Host_Parameters that
+you allocated, call the corresponding release_*_region and free the
+interrupt.
+
+Handling Interrupts
+-------------------
+
+In general, you should just plumb the card's interrupt line in with 
+
+request_irq(irq, NCR_700_intr, <irq flags>, <driver name>, host);
+
+where host is the return from the relevant NCR_700_detect() routine.
+
+You may also write your own interrupt handling routine which calls
+NCR_700_intr() directly.  However, you should only really do this if
+you have a card with more than one chip on it and you can read a
+register to tell which set of chips wants the interrupt.
+
+Settable NCR_700_Host_Parameters
+--------------------------------
+
+The following are a list of the user settable parameters:
+
+clock: (MANDATORY)
+
+Set to the clock speed of the chip in MHz.
+
+base: (MANDATORY)
+
+set to the base of the io or mem region for the register set. On 64
+bit architectures this is only 32 bits wide, so the registers must be
+mapped into the low 32 bits of memory.
+
+pci_dev: (OPTIONAL)
+
+set to the PCI board device.  Leave NULL for a non-pci board.  This is
+used for the pci_alloc_consistent() and pci_map_*() functions.
+
+dmode_extra: (OPTIONAL, 53c710 only)
+
+extra flags for the DMODE register.  These are used to control bus
+output pins on the 710.  The settings should be a combination of
+DMODE_FC1 and DMODE_FC2.  What these pins actually do is entirely up
+to the board designer.  Usually it is safe to ignore this setting.
+
+differential: (OPTIONAL)
+
+set to 1 if the chip drives a differential bus.
+
+force_le_on_be: (OPTIONAL, only if CONFIG_53C700_LE_ON_BE is set)
+
+set to 1 if the chip is operating in little endian mode on a big
+endian architecture.
+
+chip710: (OPTIONAL)
+
+set to 1 if the chip is a 53c710.
+
+burst_disable: (OPTIONAL, 53c710 only)
 
-The driver is currently I/O mapped only, but it should be easy enough
-to memory map (just make the port reads #defines with MEM_MAPPED for
-memory mapping or nothing for I/O mapping, specify an extra rule for
-53c700-mem.o with the -DMEM_MAPPED flag and make your driver use it,
-that way the make rules will generate the correct version).
+disable 8 byte bursting for DMA transfers.
 

--==_Exmh_-4667027150--


