Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263329AbVGOPd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbVGOPd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVGOPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:32:30 -0400
Received: from mail0.lsil.com ([147.145.40.20]:44944 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261957AbVGOPcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:32:21 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662A58@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Kolli, Neela Syam" <knsyam@lsil.com>
Subject: [PATCH 2.4.31 1/1] scsi/megaraid2: add 64-bit application support
Date: Fri, 15 Jul 2005 11:32:08 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C58952.5C5F4C00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C58952.5C5F4C00
Content-Type: text/plain

This patch contains accumulated changes over the time.

Description of the changes.
### Version 2.10.10.1
Thu Jan 27 15:59:59 EDT 2005 - Seokmann Ju <sju@lsil.com>
1.	There was a bug in the 'megadev_ioctl()' function that cause random
	deletion error and has been fixed.

### Version 2.10.10.0
Fri Jan 21 15:59:59 EDT 2005 - Seokmann Ju <sju@lsil.com>
1.	Fixed Tape drive issue : For any Direct CDB command to physical
device
	including tape, timeout value set by driver was 10 minutes. With
this
	value, most of command will return within timeout. However, for
those
	command like ERASE or FORMAT, it takes more than an hour depends on
	capacity of the device and the command could be terminated before it
	completes.
	To address this issue, the 'timeout' field in the DCDB command will
	have NO TIMEOUT (i.e., 4) value as its timeout on DCDB command.
2.	Added NEC ROMB support : NEC MegaRAID PCI Express ROMB controller

### Version 2.10.9.0
Fri Aug 13 15:59:59 EDT 2004 - Rajesh Prabhakaran <rajeshpr@lsil.com>
1.	Added Support for 64-applications : mega_ioctl function and
	nitioctl_t struct where changed to accomadate 64-bit addressing.

Signed-off-by: Seokmann Ju <seokmann.ju@lsil.com>

---
diff -Naur old/drivers/scsi/megaraid2.c new/drivers/scsi/megaraid2.c
--- old/drivers/scsi/megaraid2.c	2005-07-15 07:52:27.555937432 -0400
+++ new/drivers/scsi/megaraid2.c	2005-07-15 07:52:18.564304368 -0400
@@ -14,7 +14,7 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.10.8.2 (July 26, 2004)
+ * Version : v2.10.10.1 (January 27, 2005)
  *
  * Authors:	Atul Mukker <Atul.Mukker@lsil.com>
  *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
@@ -46,7 +46,7 @@
 
 #include "megaraid2.h"
 
-#if defined(__x86_64__)
+#ifdef LSI_CONFIG_COMPAT
 #include <asm/ioctl32.h>
 #endif
 
@@ -233,7 +233,7 @@
 				"MegaRAID Shutdown routine not
registered!!\n");
 		}
 
-#if defined(__x86_64__)
+#ifdef LSI_CONFIG_COMPAT
 		/*
 		 * Register the 32-bit ioctl conversion
 		 */
@@ -341,6 +341,7 @@
 				(subsysvid != INTEL_SUBSYS_VID) &&
 				(subsysvid != FSC_SUBSYS_VID) &&
 				(subsysvid != ACER_SUBSYS_VID) &&
+				(subsysvid != NEC_SUBSYS_VID) &&
 				(subsysvid != LSI_SUBSYS_VID) ) continue;
 
 
@@ -989,268 +990,6 @@
 }
 
 
-/**
- * issue_scb()
- * @adapter - pointer to our soft state
- * @scb - scsi control block
- *
- * Post a command to the card if the mailbox is available, otherwise return
- * busy. We also take the scb from the pending list if the mailbox is
- * available.
- */
-static inline int
-issue_scb(adapter_t *adapter, scb_t *scb)
-{
-	volatile mbox64_t	*mbox64 = adapter->mbox64;
-	volatile mbox_t		*mbox = adapter->mbox;
-	unsigned int	i = 0;
-
-	if(unlikely(mbox->busy)) {
-		do {
-			udelay(1);
-			i++;
-		} while( mbox->busy && (i < max_mbox_busy_wait) );
-
-		if(mbox->busy) return -1;
-	}
-
-	/* Copy mailbox data into host structure */
-	memcpy((char *)mbox, (char *)scb->raw_mbox, 16);
-
-	mbox->cmdid = scb->idx;	/* Set cmdid */
-	mbox->busy = 1;		/* Set busy */
-
-
-	/*
-	 * Increment the pending queue counter
-	 */
-	atomic_inc(&adapter->pend_cmds);
-
-	switch (mbox->cmd) {
-	case MEGA_MBOXCMD_EXTPTHRU:
-		if( !adapter->has_64bit_addr ) break;
-		// else fall through
-	case MEGA_MBOXCMD_LREAD64:
-	case MEGA_MBOXCMD_LWRITE64:
-	case MEGA_MBOXCMD_PASSTHRU64:
-		mbox64->xfer_segment_lo = mbox->xferaddr;
-		mbox64->xfer_segment_hi = 0;
-		mbox->xferaddr = 0xFFFFFFFF;
-		break;
-	default:
-		mbox64->xfer_segment_lo = 0;
-		mbox64->xfer_segment_hi = 0;
-	}
-
-	/*
-	 * post the command
-	 */
-	scb->state |= SCB_ISSUED;
-
-	if( likely(adapter->flag & BOARD_MEMMAP) ) {
-		mbox->poll = 0;
-		mbox->ack = 0;
-		WRINDOOR(adapter, adapter->mbox_dma | 0x1);
-	}
-	else {
-		irq_enable(adapter);
-		issue_command(adapter);
-	}
-
-	return 0;
-}
-
-
-/**
- * mega_runpendq()
- * @adapter - pointer to our soft state
- *
- * Runs through the list of pending requests.
- */
-static inline void
-mega_runpendq(adapter_t *adapter)
-{
-	if(!list_empty(&adapter->pending_list))
-		__mega_runpendq(adapter);
-}
-
-
-static void
-__mega_runpendq(adapter_t *adapter)
-{
-	scb_t *scb;
-	struct list_head *pos, *next;
-
-	/* Issue any pending commands to the card */
-	list_for_each_safe(pos, next, &adapter->pending_list) {
-
-		scb = list_entry(pos, scb_t, list);
-
-		if( !(scb->state & SCB_ISSUED) ) {
-
-			if( issue_scb(adapter, scb) != 0 )
-				return;
-		}
-	}
-
-	return;
-}
-
-
-/**
- * mega_allocate_scb()
- * @adapter - pointer to our soft state
- * @cmd - scsi command from the mid-layer
- *
- * Allocate a SCB structure. This is the central structure for controller
- * commands.
- */
-static inline scb_t *
-mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)
-{
-	struct list_head *head = &adapter->free_list;
-	scb_t	*scb;
-
-	/* Unlink command from Free List */
-	if( !list_empty(head) ) {
-
-		scb = list_entry(head->next, scb_t, list);
-
-		list_del_init(head->next);
-
-		scb->state = SCB_ACTIVE;
-		scb->cmd = cmd;
-		scb->dma_type = MEGA_DMA_TYPE_NONE;
-
-		return scb;
-	}
-
-	return NULL;
-}
-
-
-/**
- * mega_get_ldrv_num()
- * @adapter - pointer to our soft state
- * @cmd - scsi mid layer command
- * @channel - channel on the controller
- *
- * Calculate the logical drive number based on the information in scsi
command
- * and the channel number.
- */
-static inline int
-mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)
-{
-	int		tgt;
-	int		ldrv_num;
-
-	tgt = cmd->target;
-
-	if ( tgt > adapter->this_id )
-		tgt--;	/* we do not get inquires for initiator id */
-
-	ldrv_num = (channel * 15) + tgt;
-
-
-	/*
-	 * If we have a logical drive with boot enabled, project it first
-	 */
-	if( adapter->boot_ldrv_enabled ) {
-		if( ldrv_num == 0 ) {
-			ldrv_num = adapter->boot_ldrv;
-		}
-		else {
-			if( ldrv_num <= adapter->boot_ldrv ) {
-				ldrv_num--;
-			}
-		}
-	}
-
-	/*
-	 * If "delete logical drive" feature is enabled on this controller,
-	 * the value returned should be 0x80+logical drive id.
-	 */
-	if (adapter->support_random_del)
-		ldrv_num += 0x80;
-
-	return ldrv_num;
-}
-
-/*
- * Wait until the controller's mailbox is available
- */
-static inline int
-mega_busywait_mbox (adapter_t *adapter)
-{
-	if (adapter->mbox->busy)
-		return __mega_busywait_mbox(adapter);
-	return 0;
-}
-
-
-/**
- * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped HBAs
- * @adapter	- controller's soft state
- *
- * Interrupt ackrowledgement sequence for IO mapped HBAs
- */
-static inline void
-megaraid_iombox_ack_sequence(adapter_t *adapter)
-{
-	u8	status;
-	u8	nstatus;
-	u8	completed[MAX_FIRMWARE_STATUS];
-	u8	byte;
-	int	i;
-
-
-	/*
-	 * loop till F/W has more commands for us to complete.
-	 */
-	do {
-		/* Check if a valid interrupt is pending */
-		byte = irq_state(adapter);
-		if( (byte & VALID_INTR_BYTE) == 0 ) {
-			return;
-		}
-		set_irq_state(adapter, byte);
-
-		while ((nstatus = adapter->mbox->numstatus) == 0xFF) {
-			cpu_relax();
-		}
-		adapter->mbox->numstatus = 0xFF;
-
-		for (i = 0; i < nstatus; i++) {
-			while ((completed[i] = adapter->mbox->completed[i])
-					== 0xFF) {
-				cpu_relax();
-			}
-
-			adapter->mbox->completed[i] = 0xFF;
-		}
-
-		// we must read the valid status now
-		if ((status = adapter->mbox->status) == 0xFF) {
-			printk(KERN_WARNING
-			"megaraid critical: status 0xFF from firmware.\n");
-		}
-		adapter->mbox->status = 0xFF;
-
-		/*
-		 * decrement the pending queue counter
-		 */
-		atomic_sub(nstatus, &adapter->pend_cmds);
-
-		/* Acknowledge interrupt */
-		irq_ack(adapter);
-
-		mega_cmd_done(adapter, completed, nstatus, status);
-
-	} while(1);
-}
-
-
-
 /*
  * megaraid_queue()
  * @scmd - Issue this scsi command
@@ -1755,8 +1494,8 @@
 	pthru = scb->pthru;
 	memset(pthru, 0, sizeof (mega_passthru));
 
-	/* 0=6sec/1=60sec/2=10min/3=3hrs */
-	pthru->timeout = 2;
+	/* 0=6sec/1=60sec/2=10min/3=3hrs/4=NO timeout */
+	pthru->timeout = 4;
 
 	pthru->ars = 1;
 	pthru->reqsenselen = 14;
@@ -1819,8 +1558,8 @@
 	epthru = scb->epthru;
 	memset(epthru, 0, sizeof(mega_ext_passthru));
 
-	/* 0=6sec/1=60sec/2=10min/3=3hrs */
-	epthru->timeout = 2;
+	/* 0=6sec/1=60sec/2=10min/3=3hrs/4=NO timeout */
+	epthru->timeout = 4;
 
 	epthru->ars = 1;
 	epthru->reqsenselen = 14;
@@ -1863,6 +1602,145 @@
 
 
 /**
+ * mega_allocate_scb()
+ * @adapter - pointer to our soft state
+ * @cmd - scsi command from the mid-layer
+ *
+ * Allocate a SCB structure. This is the central structure for controller
+ * commands.
+ */
+static inline scb_t *
+mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)
+{
+	struct list_head *head = &adapter->free_list;
+	scb_t	*scb;
+
+	/* Unlink command from Free List */
+	if( !list_empty(head) ) {
+
+		scb = list_entry(head->next, scb_t, list);
+
+		list_del_init(head->next);
+
+		scb->state = SCB_ACTIVE;
+		scb->cmd = cmd;
+		scb->dma_type = MEGA_DMA_TYPE_NONE;
+
+		return scb;
+	}
+
+	return NULL;
+}
+
+
+/**
+ * mega_runpendq()
+ * @adapter - pointer to our soft state
+ *
+ * Runs through the list of pending requests.
+ */
+static inline void
+mega_runpendq(adapter_t *adapter)
+{
+	if(!list_empty(&adapter->pending_list))
+		__mega_runpendq(adapter);
+}
+
+static void
+__mega_runpendq(adapter_t *adapter)
+{
+	scb_t *scb;
+	struct list_head *pos, *next;
+
+	/* Issue any pending commands to the card */
+	list_for_each_safe(pos, next, &adapter->pending_list) {
+
+		scb = list_entry(pos, scb_t, list);
+
+		if( !(scb->state & SCB_ISSUED) ) {
+
+			if( issue_scb(adapter, scb) != 0 )
+				return;
+		}
+	}
+
+	return;
+}
+
+
+/**
+ * issue_scb()
+ * @adapter - pointer to our soft state
+ * @scb - scsi control block
+ *
+ * Post a command to the card if the mailbox is available, otherwise return
+ * busy. We also take the scb from the pending list if the mailbox is
+ * available.
+ */
+static inline int
+issue_scb(adapter_t *adapter, scb_t *scb)
+{
+	volatile mbox64_t	*mbox64 = adapter->mbox64;
+	volatile mbox_t		*mbox = adapter->mbox;
+	unsigned int	i = 0;
+
+	if(unlikely(mbox->busy)) {
+		do {
+			udelay(1);
+			i++;
+		} while( mbox->busy && (i < max_mbox_busy_wait) );
+
+		if(mbox->busy) return -1;
+	}
+
+	/* Copy mailbox data into host structure */
+	memcpy((char *)mbox, (char *)scb->raw_mbox, 16);
+
+	mbox->cmdid = scb->idx;	/* Set cmdid */
+	mbox->busy = 1;		/* Set busy */
+
+
+	/*
+	 * Increment the pending queue counter
+	 */
+	atomic_inc(&adapter->pend_cmds);
+
+	switch (mbox->cmd) {
+	case MEGA_MBOXCMD_EXTPTHRU:
+		if( !adapter->has_64bit_addr ) break;
+		// else fall through
+	case MEGA_MBOXCMD_LREAD64:
+	case MEGA_MBOXCMD_LWRITE64:
+	case MEGA_MBOXCMD_PASSTHRU64:
+		mbox64->xfer_segment_lo = mbox->xferaddr;
+		mbox64->xfer_segment_hi = 0;
+		mbox->xferaddr = 0xFFFFFFFF;
+		break;
+	default:
+		mbox64->xfer_segment_lo = 0;
+		mbox64->xfer_segment_hi = 0;
+	}
+
+	/*
+	 * post the command
+	 */
+	scb->state |= SCB_ISSUED;
+
+	if( likely(adapter->flag & BOARD_MEMMAP) ) {
+		mbox->poll = 0;
+		mbox->ack = 0;
+		WRINDOOR(adapter, adapter->mbox_dma | 0x1);
+	}
+	else {
+		irq_enable(adapter);
+		issue_command(adapter);
+	}
+
+	return 0;
+}
+
+
+/**
  * issue_scb_block()
  * @adapter - pointer to our soft state
  * @raw_mbox - the mailbox
@@ -1979,7 +1857,6 @@
 	adapter_t	*adapter = devp;
 	unsigned long	flags;
 
-
 	spin_lock_irqsave(adapter->host_lock, flags);
 
 	megaraid_iombox_ack_sequence(adapter);
@@ -1996,6 +1873,99 @@
 
 
 /**
+ * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped HBAs
+ * @adapter	- controller's soft state
+ *
+ * Interrupt ackrowledgement sequence for IO mapped HBAs
+ */
+static inline void
+megaraid_iombox_ack_sequence(adapter_t *adapter)
+{
+	u8	status;
+	int	nstatus;
+	u8	completed[MAX_FIRMWARE_STATUS];
+	u8	byte;
+	int	i;
+
+
+	/*
+	 * loop till F/W has more commands for us to complete.
+	 */
+	do {
+		/* Check if a valid interrupt is pending */
+		byte = irq_state(adapter);
+		if( (byte & VALID_INTR_BYTE) == 0 ) {
+			return;
+		}
+		set_irq_state(adapter, byte);
+
+		while ((nstatus = adapter->mbox->numstatus) == 0xFF) {
+			cpu_relax();
+		}
+		adapter->mbox->numstatus = 0xFF;
+
+		for (i = 0; i < nstatus; i++) {
+			while ((completed[i] = adapter->mbox->completed[i])
+					== 0xFF) {
+				cpu_relax();
+			}
+
+			adapter->mbox->completed[i] = 0xFF;
+		}
+
+		// we must read the valid status now
+		if ((status = adapter->mbox->status) == 0xFF) {
+			printk(KERN_WARNING
+			"megaraid critical: status 0xFF from firmware.\n");
+		}
+		adapter->mbox->status = 0xFF;
+
+		/*
+		 * decrement the pending queue counter
+		 */
+		atomic_sub(nstatus, &adapter->pend_cmds);
+
+		/* Acknowledge interrupt */
+		irq_ack(adapter);
+
+		mega_cmd_done(adapter, completed, nstatus, status);
+
+	} while(1);
+}
+
+
+/**
+ * megaraid_isr_memmapped()
+ * @irq - irq
+ * @devp - pointer to our soft state
+ * @regs - unused
+ *
+ * Interrupt service routine for memory-mapped controllers.
+ * Find out if our device is interrupting. If yes, acknowledge the
interrupt
+ * and service the completed commands.
+ */
+static void
+megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
+{
+	adapter_t	*adapter = devp;
+	unsigned long	flags;
+
+	spin_lock_irqsave(adapter->host_lock, flags);
+
+	megaraid_memmbox_ack_sequence(adapter);
+
+	/* Loop through any pending requests */
+	if(atomic_read(&adapter->quiescent) == 0) {
+		mega_runpendq(adapter);
+	}
+
+	spin_unlock_irqrestore(adapter->host_lock, flags);
+
+	return;
+}
+
+
+/**
  * megaraid_memmbox_ack_sequence - interrupt ack sequence for memory mapped
HBAs
  * @adapter	- controller's soft state
  *
@@ -2006,7 +1976,7 @@
 {
 	u8	status;
 	u32	dword = 0;
-	u8	nstatus;
+	int	nstatus;
 	u8	completed[MAX_FIRMWARE_STATUS];
 	int	i;
 
@@ -2063,37 +2033,6 @@
 
 
 /**
- * megaraid_isr_memmapped()
- * @irq - irq
- * @devp - pointer to our soft state
- * @regs - unused
- *
- * Interrupt service routine for memory-mapped controllers.
- * Find out if our device is interrupting. If yes, acknowledge the
interrupt
- * and service the completed commands.
- */
-static void
-megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
-{
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-
-
-	spin_lock_irqsave(adapter->host_lock, flags);
-
-	megaraid_memmbox_ack_sequence(adapter);
-
-	/* Loop through any pending requests */
-	if(atomic_read(&adapter->quiescent) == 0) {
-		mega_runpendq(adapter);
-	}
-
-	spin_unlock_irqrestore(adapter->host_lock, flags);
-
-	return;
-}
-
-/**
  * mega_cmd_done()
  * @adapter - pointer to our soft state
  * @completed - array of ids of completed commands
@@ -2102,7 +2041,7 @@
  *
  * Complete the comamnds and call the scsi mid-layer callback hooks.
  */
-static void
+static inline void
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 {
 	mega_ext_passthru	*epthru = NULL;
@@ -2404,6 +2343,18 @@
 	list_add(&scb->list, &adapter->free_list);
 }
 
+
+/*
+ * Wait until the controller's mailbox is available
+ */
+static inline int
+mega_busywait_mbox (adapter_t *adapter)
+{
+	if (adapter->mbox->busy)
+		return __mega_busywait_mbox(adapter);
+	return 0;
+}
+
 static int
 __mega_busywait_mbox (adapter_t *adapter)
 {
@@ -2434,7 +2385,7 @@
 
 	cmd = scb->cmd;
 
-	/* return 0 elements if no data transfer */
+	// return 0 elements if no data transfer
 	if (!cmd->request_buffer || !cmd->request_bufflen)
 		return 0;
 
@@ -2561,43 +2512,6 @@
 		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
 }
 
-static inline void
-mega_free_sgl(adapter_t *adapter)
-{
-	scb_t	*scb;
-	int	i;
-
-	for(i = 0; i < adapter->max_cmds; i++) {
-
-		scb = &adapter->scb_list[i];
-
-		if( scb->sgl64 ) {
-			pci_free_consistent(adapter->dev,
-				sizeof(mega_sgl64) * adapter->sglen,
-				scb->sgl64,
-				scb->sgl_dma_addr);
-
-			scb->sgl64 = NULL;
-		}
-
-		if( scb->pthru ) {
-			pci_free_consistent(adapter->dev,
sizeof(mega_passthru),
-				scb->pthru, scb->pthru_dma_addr);
-
-			scb->pthru = NULL;
-		}
-
-		if( scb->epthru ) {
-			pci_free_consistent(adapter->dev,
-				sizeof(mega_ext_passthru),
-				scb->epthru, scb->epthru_dma_addr);
-
-			scb->epthru = NULL;
-		}
-
-	}
-}
-
 
 /*
  * Release the controller's resources
@@ -2726,7 +2640,7 @@
 	 */
 	scsi_unregister(host);
 
-#if defined(__x86_64__)
+#ifdef LSI_CONFIG_COMPAT
 	unregister_ioctl32_conversion(MEGAIOCCMD);
 #endif
 
@@ -2735,6 +2649,44 @@
 	return 0;
 }
 
+static inline void
+mega_free_sgl(adapter_t *adapter)
+{
+	scb_t	*scb;
+	int	i;
+
+	for(i = 0; i < adapter->max_cmds; i++) {
+
+		scb = &adapter->scb_list[i];
+
+		if( scb->sgl64 ) {
+			pci_free_consistent(adapter->dev,
+				sizeof(mega_sgl64) * adapter->sglen,
+				scb->sgl64,
+				scb->sgl_dma_addr);
+
+			scb->sgl64 = NULL;
+		}
+
+		if( scb->pthru ) {
+			pci_free_consistent(adapter->dev,
sizeof(mega_passthru),
+				scb->pthru, scb->pthru_dma_addr);
+
+			scb->pthru = NULL;
+		}
+
+		if( scb->epthru ) {
+			pci_free_consistent(adapter->dev,
+				sizeof(mega_ext_passthru),
+				scb->epthru, scb->epthru_dma_addr);
+
+			scb->epthru = NULL;
+		}
+
+	}
+}
+
+
 /*
  * Get information about the card/driver
  */
@@ -2835,7 +2787,6 @@
 	return SUCCESS;
 }
 
-
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
@@ -2903,12 +2854,10 @@
 		/*
 		 * Perform the ack sequence, since interrupts are
unavailable
 		 */
-		if( adapter->flag & BOARD_MEMMAP ) {
+		if (adapter->flag & BOARD_MEMMAP)
 			megaraid_memmbox_ack_sequence(adapter);
-		}
-		else {
+		else
 			megaraid_iombox_ack_sequence(adapter);
-		}
 
 		spin_unlock(adapter->host_lock);
 
@@ -2941,7 +2890,6 @@
 	return rval;
 }
 
-
 #ifdef CONFIG_PROC_FS
 /* Following code handles /proc fs  */
 
@@ -3200,26 +3148,6 @@
 	return len;
 }
 
-/**
- * mega_allocate_inquiry()
- * @dma_handle - handle returned for dma address
- * @pdev - handle to pci device
- *
- * allocates memory for inquiry structure
- */
-static inline caddr_t
-mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
-{
-	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3),
dma_handle);
-}
-
-
-static inline void
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev
*pdev)
-{
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry,
dma_handle);
-}
-
 
 /**
  * proc_rebuild_rate()
@@ -4172,7 +4100,7 @@
 }
 
 
-#if defined(__x86_64__)
+#ifdef LSI_CONFIG_COMPAT
 static int
 megadev_compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
 		struct file *filep)
@@ -4221,7 +4149,7 @@
 	megacmd_t	mc;
 	megastat_t	*ustats;
 	int		num_ldrv;
-	u32		uxferaddr = 0;
+	caddr_t		uxferaddr=NULL;
 	struct pci_dev	*pdev;
 
 	ustats = NULL; /* avoid compilation warnings */
@@ -4251,13 +4179,13 @@
 	switch( uioc.opcode ) {
 
 	case GET_DRIVER_VER:
-		if( put_user(driver_ver, (u32 *)uioc.uioc_uaddr) )
+		if( put_user(driver_ver, (u32 *)uioc.u_dataaddr) )
 			return (-EFAULT);
 
 		break;
 
 	case GET_N_ADAP:
-		if( put_user(hba_count, (u32 *)uioc.uioc_uaddr) )
+		if( put_user(hba_count, (u32 *)uioc.u_dataaddr) )
 			return (-EFAULT);
 
 		/*
@@ -4275,7 +4203,7 @@
 		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
 			return (-ENODEV);
 
-		if( copy_to_user(uioc.uioc_uaddr, mcontroller+adapno,
+		if( copy_to_user(uioc.u_dataaddr, mcontroller+adapno,
 				sizeof(struct mcontroller)) )
 			return (-EFAULT);
 		break;
@@ -4291,7 +4219,7 @@
 
 		adapter = hba_soft_state[adapno];
 
-		ustats = (megastat_t *)uioc.uioc_uaddr;
+		ustats = (megastat_t *)uioc.u_dataaddr;
 
 		if( copy_from_user(&num_ldrv, &ustats->num_ldrv,
sizeof(int)) )
 			return (-EFAULT);
@@ -4333,7 +4261,7 @@
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count ) 
+		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
 			return (-ENODEV);
 
 		adapter = hba_soft_state[adapno];
@@ -4342,37 +4270,37 @@
 		 * Deletion of logical drive is a special case. The adapter
 		 * should be quiescent before this command is issued.
 		 */
-		if( uioc.uioc_rmbox[0] == FC_DEL_LOGDRV &&
-				uioc.uioc_rmbox[2] == OP_DEL_LOGDRV ) {
+		if( RMBOX(uioc)[0] == FC_DEL_LOGDRV ) {
+			if ( RMBOX(uioc)[2] == OP_DEL_LOGDRV ) {
+				/*
+				 * Do we support this feature
+				 */
+				if( !adapter->support_random_del ) {
+					printk(KERN_WARNING "megaraid:
logdrv ");
+					printk("delete on non-supporting
F/W.\n");
 
-			/*
-			 * Do we support this feature
-			 */
-			if( !adapter->support_random_del ) {
-				printk(KERN_WARNING "megaraid: logdrv ");
-				printk("delete on non-supporting F/W.\n");
+					return (-EINVAL);
+				}
 
-				return (-EINVAL);
-			}
+				rval = mega_del_logdrv( adapter,
RMBOX(uioc)[3] );
 
-			rval = mega_del_logdrv( adapter, uioc.uioc_rmbox[3]
);
+				if( rval == 0 ) {
+					memset(&mc, 0, sizeof(megacmd_t));
 
-			if( rval == 0 ) {
-				memset(&mc, 0, sizeof(megacmd_t));
+					mc.status = rval;
 
-				mc.status = rval;
+					rval = mega_n_to_m((void *)arg,
&mc);
+				}
 
-				rval = mega_n_to_m((void *)arg, &mc);
+				return rval;
 			}
-
-			return rval;
 		}
 		/*
 		 * This interface only support the regular passthru
commands.
 		 * Reject extended passthru and 64-bit passthru
 		 */
-		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU64 ||
-			uioc.uioc_rmbox[0] == MEGA_MBOXCMD_EXTPTHRU ) {
+		if( RMBOX(uioc)[0] == MEGA_MBOXCMD_PASSTHRU64 ||
+			RMBOX(uioc)[0] == MEGA_MBOXCMD_EXTPTHRU ) {
 
 			printk(KERN_WARNING "megaraid: rejected
passthru.\n");
 
@@ -4386,7 +4314,7 @@
 		pdev = adapter->dev;
 
 		/* Is it a passthru command or a DCMD */
-		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
+		if( RMBOX(uioc)[0] == MEGA_MBOXCMD_PASSTHRU ) {
 			/* Passthru commands */
 
 			pthru = adapter->int_pthru;
@@ -4394,20 +4322,12 @@
 			/*
 			 * The user passthru structure
 			 */
-			upthru = (mega_passthru *)
-					((ulong)(MBOX(uioc)->xferaddr));
-			/*
-			 * Copy in the user passthru here.
-			 */
-			if( copy_from_user(pthru, (char *)upthru,
-						sizeof(mega_passthru)) ) {
-				return (-EFAULT);
-			}
-
+			 upthru = &uioc.pthru;
+			 memcpy(pthru, (char
*)upthru,sizeof(mega_passthru));
 			/*
 			 * Is there a data transfer; If the data transfer
-			 * length is <= INT_MEMBLK_SZ, usr the buffer 
-			 * allocated at the load time. Otherwise, allocate
it 
+			 * length is <= INT_MEMBLK_SZ, usr the buffer
+			 * allocated at the load time. Otherwise, allocate
it
 			 * here.
 			 */
 			if (pthru->dataxferlen) {
@@ -4417,8 +4337,9 @@
 							pthru->dataxferlen,
 							&data_dma_hndl );
 
-					if (data == NULL)
+					if (data == NULL) {
 						return (-ENOMEM);
+					}
 				}
 				else {
 					data = adapter->int_data;
@@ -4428,11 +4349,11 @@
 				 * Save the user address and point the
kernel
 				 * address at just allocated memory
 				 */
-				uxferaddr = pthru->dataxferaddr;
+				uxferaddr = (caddr_t) uioc.u_dataaddr;
 				if (data_dma_hndl)
 					pthru->dataxferaddr = data_dma_hndl;
 				else
-					pthru->dataxferaddr = 
+					pthru->dataxferaddr =
 						adapter->int_data_dma_hndl;
 			}
 
@@ -4440,12 +4361,12 @@
 			/*
 			 * Is data coming down-stream
 			 */
-			if( pthru->dataxferlen && (uioc.flags & UIOC_WR) ) {
+			if(pthru->dataxferlen  && (uioc.flags & UIOC_WR) ) {
 				/*
 				 * Get the user data
 				 */
 				if( copy_from_user(data,
-						(char *)((ulong)uxferaddr),
+						(char *)uxferaddr,
 						pthru->dataxferlen) ) {
 					rval = (-EFAULT);
 					goto freedata_and_return;
@@ -4471,7 +4392,7 @@
 			 * Is data going up-stream
 			 */
 			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char *)((ulong)uxferaddr),
+				if( copy_to_user((char *)uxferaddr,
 						data, pthru->dataxferlen) )
{
 					rval = (-EFAULT);
 				}
@@ -4511,7 +4432,7 @@
 				else {
 					data = adapter->int_data;
 				}
-				uxferaddr = MBOX(uioc)->xferaddr;
+				uxferaddr = uioc.u_dataaddr;
 			}
 
 			/*
@@ -4559,7 +4480,7 @@
 			 * Is data going up-stream
 			 */
 			if( uioc.xferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char *)((ulong)uxferaddr),
+				if( copy_to_user((char *)uxferaddr,
 						data, uioc.xferlen) ) {
 
 					rval = (-EFAULT);
@@ -4648,18 +4569,18 @@
 
 		case MEGAIOC_QDRVRVER:	/* Query driver version */
 			uioc->opcode = GET_DRIVER_VER;
-			uioc->uioc_uaddr = uioc_mimd.data;
+			uioc->u_dataaddr = uioc_mimd.data;
 			break;
 
 		case MEGAIOC_QNADAP:	/* Get # of adapters */
 			uioc->opcode = GET_N_ADAP;
-			uioc->uioc_uaddr = uioc_mimd.data;
+			uioc->u_dataaddr = uioc_mimd.data;
 			break;
 
 		case MEGAIOC_QADAPINFO:	/* Get adapter information */
 			uioc->opcode = GET_ADAP_INFO;
 			uioc->adapno = uioc_mimd.ui.fcs.adapno;
-			uioc->uioc_uaddr = uioc_mimd.data;
+			uioc->u_dataaddr = uioc_mimd.data;
 			break;
 
 		default:
@@ -4674,9 +4595,16 @@
 		uioc->opcode = MBOX_CMD;
 		uioc->adapno = uioc_mimd.ui.fcs.adapno;
 
-		memcpy(uioc->uioc_rmbox, uioc_mimd.mbox, 18);
+		memcpy(&uioc->u_mbox, uioc_mimd.mbox, 18);
 
 		uioc->xferlen = uioc_mimd.ui.fcs.length;
+		uioc->u_dataaddr = uioc_mimd.ui.fcs.buffer;
+
+		if (uioc_mimd.mbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
+			memcpy(&uioc->pthru,&uioc_mimd.pthru,
+				sizeof(mega_passthru));
+
+		}
 
 		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
 		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
@@ -4688,13 +4616,20 @@
 		uioc->opcode = MBOX_CMD;
 		uioc->adapno = uioc_mimd.ui.fcs.adapno;
 
-		memcpy(uioc->uioc_rmbox, uioc_mimd.mbox, 18);
+		memcpy(&uioc->u_mbox, uioc_mimd.mbox, 18);
 
 		/*
 		 * Choose the xferlen bigger of input and output data
 		 */
 		uioc->xferlen = uioc_mimd.outlen > uioc_mimd.inlen ?
 			uioc_mimd.outlen : uioc_mimd.inlen;
+		uioc->u_dataaddr = uioc_mimd.data;
+
+		if (uioc_mimd.mbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
+			memcpy(&uioc->pthru,&uioc_mimd.pthru,
+				sizeof(mega_passthru));
+
+		}
 
 		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
 		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
@@ -4735,20 +4670,14 @@
 
 	if( memcmp(signature, "MEGANIT", 7) == 0 ) {
 
-		uiocp = (nitioctl_t *)arg;
-
-		if( put_user(mc->status, (u8 *)&MBOX_P(uiocp)->status) )
-			return (-EFAULT);
-
-		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {
-
-			umc = MBOX_P(uiocp);
-
-			upthru = (mega_passthru *)((ulong)(umc->xferaddr));
 
-			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
)
-				return (-EFAULT);
-		}
+		/*
+		 * NOTE: The nit ioctl is still under flux because of
+		 * change of mailbox definition, in HPE. No applications yet
+		 * use this interface and let's not have applications use
this
+		 * interface till the new specifitions are in place.
+		 */
+		return -EINVAL;
 	}
 	else {
 		uioc_mimd = (struct uioctl_t *)arg;
@@ -4763,8 +4692,7 @@
 			if (copy_from_user(&kmc, umc, sizeof(megacmd_t))) {
 				return -EFAULT;
 			}
-
-			upthru = (mega_passthru *)((ulong)kmc.xferaddr);
+			upthru = (mega_passthru
*)((ulong)&uioc_mimd->pthru);
 
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
){
 				return (-EFAULT);
@@ -5179,6 +5107,55 @@
 }
 
 
+
+/**
+ * mega_get_ldrv_num()
+ * @adapter - pointer to our soft state
+ * @cmd - scsi mid layer command
+ * @channel - channel on the controller
+ *
+ * Calculate the logical drive number based on the information in scsi
command
+ * and the channel number.
+ */
+static inline int
+mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)
+{
+	int		tgt;
+	int		ldrv_num;
+
+	tgt = cmd->target;
+
+	if ( tgt > adapter->this_id )
+		tgt--;	/* we do not get inquires for initiator id */
+
+	ldrv_num = (channel * 15) + tgt;
+
+
+	/*
+	 * If we have a logical drive with boot enabled, project it first
+	 */
+	if( adapter->boot_ldrv_enabled ) {
+		if( ldrv_num == 0 ) {
+			ldrv_num = adapter->boot_ldrv;
+		}
+		else {
+			if( ldrv_num <= adapter->boot_ldrv ) {
+				ldrv_num--;
+			}
+		}
+	}
+
+	/*
+	 * If "delete logical drive" feature is enabled on this controller,
+	 * the value returned should be 0x80+logical drive id.
+	 */
+	if (adapter->support_random_del)
+		ldrv_num += 0x80;
+
+	return ldrv_num;
+}
+
+
 /**
  * mega_reorder_hosts()
  *
@@ -5393,6 +5370,26 @@
 }
 
 
+/**
+ * mega_allocate_inquiry()
+ * @dma_handle - handle returned for dma address
+ * @pdev - handle to pci device
+ *
+ * allocates memory for inquiry structure
+ */
+static inline caddr_t
+mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
+{
+	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3),
dma_handle);
+}
+
+
+static inline void
+mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev
*pdev)
+{
+	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry,
dma_handle);
+}
+
 
 /** mega_internal_dev_inquiry()
  * @adapter - pointer to our soft state
diff -Naur old/drivers/scsi/megaraid2.h new/drivers/scsi/megaraid2.h
--- old/drivers/scsi/megaraid2.h	2005-07-15 07:52:27.558936976 -0400
+++ new/drivers/scsi/megaraid2.h	2005-07-15 07:52:18.566304064 -0400
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.10.8.2 (Release Date: Mon Jul 26 12:15:51 EDT 2004)\n"
+	"v2.10.10.1 (Release Date: Thu Jan 27 16:19:44 EDT 2005)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -83,6 +83,7 @@
 #define INTEL_SUBSYS_VID		0x8086
 #define FSC_SUBSYS_VID			0x1734
 #define ACER_SUBSYS_VID			0x1025
+#define NEC_SUBSYS_VID			0x1033
 
 #define HBA_SIGNATURE	      		0x3344
 #define HBA_SIGNATURE_471	  	0xCCCC
@@ -143,7 +144,8 @@
 	.eh_device_reset_handler =	megaraid_reset,		\
 	.eh_bus_reset_handler =		megaraid_reset,		\
 	.eh_host_reset_handler =	megaraid_reset,		\
-	.highmem_io =			1			\
+	.highmem_io =			1,			\
+	.vary_io =			1			\
 }
 
 
@@ -707,15 +709,15 @@
 	char		signature[8];	/* Must contain "MEGANIT" */
 	u32		opcode;		/* opcode for the command */
 	u32		adapno;		/* adapter number */
-	union {
-		u8	__raw_mbox[18];
-		caddr_t	__uaddr; /* xferaddr for non-mbox cmds */
-	}__ua;
-
-#define uioc_rmbox	__ua.__raw_mbox
-#define MBOX(uioc)	((megacmd_t *)&((uioc).__ua.__raw_mbox[0]))
-#define MBOX_P(uioc)	((megacmd_t *)&((uioc)->__ua.__raw_mbox[0]))
-#define uioc_uaddr	__ua.__uaddr
+	mbox_t  	u_mbox;		/* user mailbox */
+	caddr_t		u_dataaddr;	/* xferaddr for DCMD and non-mbox
+					   commands */
+	mega_passthru	pthru;
+
+#define RMBOX(uioc) 	((u8 *)&(uioc).u_mbox)
+#define MBOX(uioc)	((megacmd_t *)&(uioc).u_mbox)
+#define MBOX_P(uioc) 	((megacmd_t *)&(uioc)->u_mbox)
+
 
 	u32		xferlen;	/* xferlen for DCMD and non-mbox
 					   commands */
@@ -1128,7 +1130,7 @@
 			      u32 *buffer, u32 *length);
 static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
-static void mega_cmd_done(adapter_t *, u8 [], int, int);
+static inline void mega_cmd_done(adapter_t *, u8 [], int, int);
 static inline void mega_free_sgl (adapter_t *adapter);
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);
@@ -1137,7 +1139,14 @@
 				   unsigned long, void *);
 static int megadev_open (struct inode *, struct file *);
 
-#if defined(__x86_64__)
+#if defined(CONFIG_COMPAT) || defined( __x86_64__) ||
defined(IA32_EMULATION)
+#ifndef __ia64__
+#define LSI_CONFIG_COMPAT
+#endif
+#endif
+
+
+#ifdef LSI_CONFIG_COMPAT
 static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned long,
 	struct file *);
 #endif
---


------_=_NextPart_000_01C58952.5C5F4C00
Content-Type: application/octet-stream;
	name="megaraid2_for_2.4.31.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid2_for_2.4.31.patch"

diff -Naur old/drivers/scsi/megaraid2.c new/drivers/scsi/megaraid2.c=0A=
--- old/drivers/scsi/megaraid2.c	2005-07-15 07:52:27.555937432 -0400=0A=
+++ new/drivers/scsi/megaraid2.c	2005-07-15 07:52:18.564304368 -0400=0A=
@@ -14,7 +14,7 @@=0A=
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)=0A=
  *	  - lots of cleanups.=0A=
  *=0A=
- * Version : v2.10.8.2 (July 26, 2004)=0A=
+ * Version : v2.10.10.1 (January 27, 2005)=0A=
  *=0A=
  * Authors:	Atul Mukker <Atul.Mukker@lsil.com>=0A=
  *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>=0A=
@@ -46,7 +46,7 @@=0A=
 =0A=
 #include "megaraid2.h"=0A=
 =0A=
-#if defined(__x86_64__)=0A=
+#ifdef LSI_CONFIG_COMPAT=0A=
 #include <asm/ioctl32.h>=0A=
 #endif=0A=
 =0A=
@@ -233,7 +233,7 @@=0A=
 				"MegaRAID Shutdown routine not registered!!\n");=0A=
 		}=0A=
 =0A=
-#if defined(__x86_64__)=0A=
+#ifdef LSI_CONFIG_COMPAT=0A=
 		/*=0A=
 		 * Register the 32-bit ioctl conversion=0A=
 		 */=0A=
@@ -341,6 +341,7 @@=0A=
 				(subsysvid !=3D INTEL_SUBSYS_VID) &&=0A=
 				(subsysvid !=3D FSC_SUBSYS_VID) &&=0A=
 				(subsysvid !=3D ACER_SUBSYS_VID) &&=0A=
+				(subsysvid !=3D NEC_SUBSYS_VID) &&=0A=
 				(subsysvid !=3D LSI_SUBSYS_VID) ) continue;=0A=
 =0A=
 =0A=
@@ -989,268 +990,6 @@=0A=
 }=0A=
 =0A=
 =0A=
-/**=0A=
- * issue_scb()=0A=
- * @adapter - pointer to our soft state=0A=
- * @scb - scsi control block=0A=
- *=0A=
- * Post a command to the card if the mailbox is available, otherwise =
return=0A=
- * busy. We also take the scb from the pending list if the mailbox =
is=0A=
- * available.=0A=
- */=0A=
-static inline int=0A=
-issue_scb(adapter_t *adapter, scb_t *scb)=0A=
-{=0A=
-	volatile mbox64_t	*mbox64 =3D adapter->mbox64;=0A=
-	volatile mbox_t		*mbox =3D adapter->mbox;=0A=
-	unsigned int	i =3D 0;=0A=
-=0A=
-	if(unlikely(mbox->busy)) {=0A=
-		do {=0A=
-			udelay(1);=0A=
-			i++;=0A=
-		} while( mbox->busy && (i < max_mbox_busy_wait) );=0A=
-=0A=
-		if(mbox->busy) return -1;=0A=
-	}=0A=
-=0A=
-	/* Copy mailbox data into host structure */=0A=
-	memcpy((char *)mbox, (char *)scb->raw_mbox, 16);=0A=
-=0A=
-	mbox->cmdid =3D scb->idx;	/* Set cmdid */=0A=
-	mbox->busy =3D 1;		/* Set busy */=0A=
-=0A=
-=0A=
-	/*=0A=
-	 * Increment the pending queue counter=0A=
-	 */=0A=
-	atomic_inc(&adapter->pend_cmds);=0A=
-=0A=
-	switch (mbox->cmd) {=0A=
-	case MEGA_MBOXCMD_EXTPTHRU:=0A=
-		if( !adapter->has_64bit_addr ) break;=0A=
-		// else fall through=0A=
-	case MEGA_MBOXCMD_LREAD64:=0A=
-	case MEGA_MBOXCMD_LWRITE64:=0A=
-	case MEGA_MBOXCMD_PASSTHRU64:=0A=
-		mbox64->xfer_segment_lo =3D mbox->xferaddr;=0A=
-		mbox64->xfer_segment_hi =3D 0;=0A=
-		mbox->xferaddr =3D 0xFFFFFFFF;=0A=
-		break;=0A=
-	default:=0A=
-		mbox64->xfer_segment_lo =3D 0;=0A=
-		mbox64->xfer_segment_hi =3D 0;=0A=
-	}=0A=
-=0A=
-	/*=0A=
-	 * post the command=0A=
-	 */=0A=
-	scb->state |=3D SCB_ISSUED;=0A=
-=0A=
-	if( likely(adapter->flag & BOARD_MEMMAP) ) {=0A=
-		mbox->poll =3D 0;=0A=
-		mbox->ack =3D 0;=0A=
-		WRINDOOR(adapter, adapter->mbox_dma | 0x1);=0A=
-	}=0A=
-	else {=0A=
-		irq_enable(adapter);=0A=
-		issue_command(adapter);=0A=
-	}=0A=
-=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-=0A=
-/**=0A=
- * mega_runpendq()=0A=
- * @adapter - pointer to our soft state=0A=
- *=0A=
- * Runs through the list of pending requests.=0A=
- */=0A=
-static inline void=0A=
-mega_runpendq(adapter_t *adapter)=0A=
-{=0A=
-	if(!list_empty(&adapter->pending_list))=0A=
-		__mega_runpendq(adapter);=0A=
-}=0A=
-=0A=
-=0A=
-static void=0A=
-__mega_runpendq(adapter_t *adapter)=0A=
-{=0A=
-	scb_t *scb;=0A=
-	struct list_head *pos, *next;=0A=
-=0A=
-	/* Issue any pending commands to the card */=0A=
-	list_for_each_safe(pos, next, &adapter->pending_list) {=0A=
-=0A=
-		scb =3D list_entry(pos, scb_t, list);=0A=
-=0A=
-		if( !(scb->state & SCB_ISSUED) ) {=0A=
-=0A=
-			if( issue_scb(adapter, scb) !=3D 0 )=0A=
-				return;=0A=
-		}=0A=
-	}=0A=
-=0A=
-	return;=0A=
-}=0A=
-=0A=
-=0A=
-/**=0A=
- * mega_allocate_scb()=0A=
- * @adapter - pointer to our soft state=0A=
- * @cmd - scsi command from the mid-layer=0A=
- *=0A=
- * Allocate a SCB structure. This is the central structure for =
controller=0A=
- * commands.=0A=
- */=0A=
-static inline scb_t *=0A=
-mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)=0A=
-{=0A=
-	struct list_head *head =3D &adapter->free_list;=0A=
-	scb_t	*scb;=0A=
-=0A=
-	/* Unlink command from Free List */=0A=
-	if( !list_empty(head) ) {=0A=
-=0A=
-		scb =3D list_entry(head->next, scb_t, list);=0A=
-=0A=
-		list_del_init(head->next);=0A=
-=0A=
-		scb->state =3D SCB_ACTIVE;=0A=
-		scb->cmd =3D cmd;=0A=
-		scb->dma_type =3D MEGA_DMA_TYPE_NONE;=0A=
-=0A=
-		return scb;=0A=
-	}=0A=
-=0A=
-	return NULL;=0A=
-}=0A=
-=0A=
-=0A=
-/**=0A=
- * mega_get_ldrv_num()=0A=
- * @adapter - pointer to our soft state=0A=
- * @cmd - scsi mid layer command=0A=
- * @channel - channel on the controller=0A=
- *=0A=
- * Calculate the logical drive number based on the information in scsi =
command=0A=
- * and the channel number.=0A=
- */=0A=
-static inline int=0A=
-mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)=0A=
-{=0A=
-	int		tgt;=0A=
-	int		ldrv_num;=0A=
-=0A=
-	tgt =3D cmd->target;=0A=
-=0A=
-	if ( tgt > adapter->this_id )=0A=
-		tgt--;	/* we do not get inquires for initiator id */=0A=
-=0A=
-	ldrv_num =3D (channel * 15) + tgt;=0A=
-=0A=
-=0A=
-	/*=0A=
-	 * If we have a logical drive with boot enabled, project it first=0A=
-	 */=0A=
-	if( adapter->boot_ldrv_enabled ) {=0A=
-		if( ldrv_num =3D=3D 0 ) {=0A=
-			ldrv_num =3D adapter->boot_ldrv;=0A=
-		}=0A=
-		else {=0A=
-			if( ldrv_num <=3D adapter->boot_ldrv ) {=0A=
-				ldrv_num--;=0A=
-			}=0A=
-		}=0A=
-	}=0A=
-=0A=
-	/*=0A=
-	 * If "delete logical drive" feature is enabled on this =
controller,=0A=
-	 * the value returned should be 0x80+logical drive id.=0A=
-	 */=0A=
-	if (adapter->support_random_del)=0A=
-		ldrv_num +=3D 0x80;=0A=
-=0A=
-	return ldrv_num;=0A=
-}=0A=
-=0A=
-/*=0A=
- * Wait until the controller's mailbox is available=0A=
- */=0A=
-static inline int=0A=
-mega_busywait_mbox (adapter_t *adapter)=0A=
-{=0A=
-	if (adapter->mbox->busy)=0A=
-		return __mega_busywait_mbox(adapter);=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-=0A=
-/**=0A=
- * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped =
HBAs=0A=
- * @adapter	- controller's soft state=0A=
- *=0A=
- * Interrupt ackrowledgement sequence for IO mapped HBAs=0A=
- */=0A=
-static inline void=0A=
-megaraid_iombox_ack_sequence(adapter_t *adapter)=0A=
-{=0A=
-	u8	status;=0A=
-	u8	nstatus;=0A=
-	u8	completed[MAX_FIRMWARE_STATUS];=0A=
-	u8	byte;=0A=
-	int	i;=0A=
-=0A=
-=0A=
-	/*=0A=
-	 * loop till F/W has more commands for us to complete.=0A=
-	 */=0A=
-	do {=0A=
-		/* Check if a valid interrupt is pending */=0A=
-		byte =3D irq_state(adapter);=0A=
-		if( (byte & VALID_INTR_BYTE) =3D=3D 0 ) {=0A=
-			return;=0A=
-		}=0A=
-		set_irq_state(adapter, byte);=0A=
-=0A=
-		while ((nstatus =3D adapter->mbox->numstatus) =3D=3D 0xFF) {=0A=
-			cpu_relax();=0A=
-		}=0A=
-		adapter->mbox->numstatus =3D 0xFF;=0A=
-=0A=
-		for (i =3D 0; i < nstatus; i++) {=0A=
-			while ((completed[i] =3D adapter->mbox->completed[i])=0A=
-					=3D=3D 0xFF) {=0A=
-				cpu_relax();=0A=
-			}=0A=
-=0A=
-			adapter->mbox->completed[i] =3D 0xFF;=0A=
-		}=0A=
-=0A=
-		// we must read the valid status now=0A=
-		if ((status =3D adapter->mbox->status) =3D=3D 0xFF) {=0A=
-			printk(KERN_WARNING=0A=
-			"megaraid critical: status 0xFF from firmware.\n");=0A=
-		}=0A=
-		adapter->mbox->status =3D 0xFF;=0A=
-=0A=
-		/*=0A=
-		 * decrement the pending queue counter=0A=
-		 */=0A=
-		atomic_sub(nstatus, &adapter->pend_cmds);=0A=
-=0A=
-		/* Acknowledge interrupt */=0A=
-		irq_ack(adapter);=0A=
-=0A=
-		mega_cmd_done(adapter, completed, nstatus, status);=0A=
-=0A=
-	} while(1);=0A=
-}=0A=
-=0A=
-=0A=
-=0A=
 /*=0A=
  * megaraid_queue()=0A=
  * @scmd - Issue this scsi command=0A=
@@ -1755,8 +1494,8 @@=0A=
 	pthru =3D scb->pthru;=0A=
 	memset(pthru, 0, sizeof (mega_passthru));=0A=
 =0A=
-	/* 0=3D6sec/1=3D60sec/2=3D10min/3=3D3hrs */=0A=
-	pthru->timeout =3D 2;=0A=
+	/* 0=3D6sec/1=3D60sec/2=3D10min/3=3D3hrs/4=3DNO timeout */=0A=
+	pthru->timeout =3D 4;=0A=
 =0A=
 	pthru->ars =3D 1;=0A=
 	pthru->reqsenselen =3D 14;=0A=
@@ -1819,8 +1558,8 @@=0A=
 	epthru =3D scb->epthru;=0A=
 	memset(epthru, 0, sizeof(mega_ext_passthru));=0A=
 =0A=
-	/* 0=3D6sec/1=3D60sec/2=3D10min/3=3D3hrs */=0A=
-	epthru->timeout =3D 2;=0A=
+	/* 0=3D6sec/1=3D60sec/2=3D10min/3=3D3hrs/4=3DNO timeout */=0A=
+	epthru->timeout =3D 4;=0A=
 =0A=
 	epthru->ars =3D 1;=0A=
 	epthru->reqsenselen =3D 14;=0A=
@@ -1863,6 +1602,145 @@=0A=
 =0A=
 =0A=
 /**=0A=
+ * mega_allocate_scb()=0A=
+ * @adapter - pointer to our soft state=0A=
+ * @cmd - scsi command from the mid-layer=0A=
+ *=0A=
+ * Allocate a SCB structure. This is the central structure for =
controller=0A=
+ * commands.=0A=
+ */=0A=
+static inline scb_t *=0A=
+mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)=0A=
+{=0A=
+	struct list_head *head =3D &adapter->free_list;=0A=
+	scb_t	*scb;=0A=
+=0A=
+	/* Unlink command from Free List */=0A=
+	if( !list_empty(head) ) {=0A=
+=0A=
+		scb =3D list_entry(head->next, scb_t, list);=0A=
+=0A=
+		list_del_init(head->next);=0A=
+=0A=
+		scb->state =3D SCB_ACTIVE;=0A=
+		scb->cmd =3D cmd;=0A=
+		scb->dma_type =3D MEGA_DMA_TYPE_NONE;=0A=
+=0A=
+		return scb;=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * mega_runpendq()=0A=
+ * @adapter - pointer to our soft state=0A=
+ *=0A=
+ * Runs through the list of pending requests.=0A=
+ */=0A=
+static inline void=0A=
+mega_runpendq(adapter_t *adapter)=0A=
+{=0A=
+	if(!list_empty(&adapter->pending_list))=0A=
+		__mega_runpendq(adapter);=0A=
+}=0A=
+=0A=
+static void=0A=
+__mega_runpendq(adapter_t *adapter)=0A=
+{=0A=
+	scb_t *scb;=0A=
+	struct list_head *pos, *next;=0A=
+=0A=
+	/* Issue any pending commands to the card */=0A=
+	list_for_each_safe(pos, next, &adapter->pending_list) {=0A=
+=0A=
+		scb =3D list_entry(pos, scb_t, list);=0A=
+=0A=
+		if( !(scb->state & SCB_ISSUED) ) {=0A=
+=0A=
+			if( issue_scb(adapter, scb) !=3D 0 )=0A=
+				return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * issue_scb()=0A=
+ * @adapter - pointer to our soft state=0A=
+ * @scb - scsi control block=0A=
+ *=0A=
+ * Post a command to the card if the mailbox is available, otherwise =
return=0A=
+ * busy. We also take the scb from the pending list if the mailbox =
is=0A=
+ * available.=0A=
+ */=0A=
+static inline int=0A=
+issue_scb(adapter_t *adapter, scb_t *scb)=0A=
+{=0A=
+	volatile mbox64_t	*mbox64 =3D adapter->mbox64;=0A=
+	volatile mbox_t		*mbox =3D adapter->mbox;=0A=
+	unsigned int	i =3D 0;=0A=
+=0A=
+	if(unlikely(mbox->busy)) {=0A=
+		do {=0A=
+			udelay(1);=0A=
+			i++;=0A=
+		} while( mbox->busy && (i < max_mbox_busy_wait) );=0A=
+=0A=
+		if(mbox->busy) return -1;=0A=
+	}=0A=
+=0A=
+	/* Copy mailbox data into host structure */=0A=
+	memcpy((char *)mbox, (char *)scb->raw_mbox, 16);=0A=
+=0A=
+	mbox->cmdid =3D scb->idx;	/* Set cmdid */=0A=
+	mbox->busy =3D 1;		/* Set busy */=0A=
+=0A=
+=0A=
+	/*=0A=
+	 * Increment the pending queue counter=0A=
+	 */=0A=
+	atomic_inc(&adapter->pend_cmds);=0A=
+=0A=
+	switch (mbox->cmd) {=0A=
+	case MEGA_MBOXCMD_EXTPTHRU:=0A=
+		if( !adapter->has_64bit_addr ) break;=0A=
+		// else fall through=0A=
+	case MEGA_MBOXCMD_LREAD64:=0A=
+	case MEGA_MBOXCMD_LWRITE64:=0A=
+	case MEGA_MBOXCMD_PASSTHRU64:=0A=
+		mbox64->xfer_segment_lo =3D mbox->xferaddr;=0A=
+		mbox64->xfer_segment_hi =3D 0;=0A=
+		mbox->xferaddr =3D 0xFFFFFFFF;=0A=
+		break;=0A=
+	default:=0A=
+		mbox64->xfer_segment_lo =3D 0;=0A=
+		mbox64->xfer_segment_hi =3D 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * post the command=0A=
+	 */=0A=
+	scb->state |=3D SCB_ISSUED;=0A=
+=0A=
+	if( likely(adapter->flag & BOARD_MEMMAP) ) {=0A=
+		mbox->poll =3D 0;=0A=
+		mbox->ack =3D 0;=0A=
+		WRINDOOR(adapter, adapter->mbox_dma | 0x1);=0A=
+	}=0A=
+	else {=0A=
+		irq_enable(adapter);=0A=
+		issue_command(adapter);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
  * issue_scb_block()=0A=
  * @adapter - pointer to our soft state=0A=
  * @raw_mbox - the mailbox=0A=
@@ -1979,7 +1857,6 @@=0A=
 	adapter_t	*adapter =3D devp;=0A=
 	unsigned long	flags;=0A=
 =0A=
-=0A=
 	spin_lock_irqsave(adapter->host_lock, flags);=0A=
 =0A=
 	megaraid_iombox_ack_sequence(adapter);=0A=
@@ -1996,6 +1873,99 @@=0A=
 =0A=
 =0A=
 /**=0A=
+ * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped =
HBAs=0A=
+ * @adapter	- controller's soft state=0A=
+ *=0A=
+ * Interrupt ackrowledgement sequence for IO mapped HBAs=0A=
+ */=0A=
+static inline void=0A=
+megaraid_iombox_ack_sequence(adapter_t *adapter)=0A=
+{=0A=
+	u8	status;=0A=
+	int	nstatus;=0A=
+	u8	completed[MAX_FIRMWARE_STATUS];=0A=
+	u8	byte;=0A=
+	int	i;=0A=
+=0A=
+=0A=
+	/*=0A=
+	 * loop till F/W has more commands for us to complete.=0A=
+	 */=0A=
+	do {=0A=
+		/* Check if a valid interrupt is pending */=0A=
+		byte =3D irq_state(adapter);=0A=
+		if( (byte & VALID_INTR_BYTE) =3D=3D 0 ) {=0A=
+			return;=0A=
+		}=0A=
+		set_irq_state(adapter, byte);=0A=
+=0A=
+		while ((nstatus =3D adapter->mbox->numstatus) =3D=3D 0xFF) {=0A=
+			cpu_relax();=0A=
+		}=0A=
+		adapter->mbox->numstatus =3D 0xFF;=0A=
+=0A=
+		for (i =3D 0; i < nstatus; i++) {=0A=
+			while ((completed[i] =3D adapter->mbox->completed[i])=0A=
+					=3D=3D 0xFF) {=0A=
+				cpu_relax();=0A=
+			}=0A=
+=0A=
+			adapter->mbox->completed[i] =3D 0xFF;=0A=
+		}=0A=
+=0A=
+		// we must read the valid status now=0A=
+		if ((status =3D adapter->mbox->status) =3D=3D 0xFF) {=0A=
+			printk(KERN_WARNING=0A=
+			"megaraid critical: status 0xFF from firmware.\n");=0A=
+		}=0A=
+		adapter->mbox->status =3D 0xFF;=0A=
+=0A=
+		/*=0A=
+		 * decrement the pending queue counter=0A=
+		 */=0A=
+		atomic_sub(nstatus, &adapter->pend_cmds);=0A=
+=0A=
+		/* Acknowledge interrupt */=0A=
+		irq_ack(adapter);=0A=
+=0A=
+		mega_cmd_done(adapter, completed, nstatus, status);=0A=
+=0A=
+	} while(1);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_isr_memmapped()=0A=
+ * @irq - irq=0A=
+ * @devp - pointer to our soft state=0A=
+ * @regs - unused=0A=
+ *=0A=
+ * Interrupt service routine for memory-mapped controllers.=0A=
+ * Find out if our device is interrupting. If yes, acknowledge the =
interrupt=0A=
+ * and service the completed commands.=0A=
+ */=0A=
+static void=0A=
+megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)=0A=
+{=0A=
+	adapter_t	*adapter =3D devp;=0A=
+	unsigned long	flags;=0A=
+=0A=
+	spin_lock_irqsave(adapter->host_lock, flags);=0A=
+=0A=
+	megaraid_memmbox_ack_sequence(adapter);=0A=
+=0A=
+	/* Loop through any pending requests */=0A=
+	if(atomic_read(&adapter->quiescent) =3D=3D 0) {=0A=
+		mega_runpendq(adapter);=0A=
+	}=0A=
+=0A=
+	spin_unlock_irqrestore(adapter->host_lock, flags);=0A=
+=0A=
+	return;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
  * megaraid_memmbox_ack_sequence - interrupt ack sequence for memory =
mapped HBAs=0A=
  * @adapter	- controller's soft state=0A=
  *=0A=
@@ -2006,7 +1976,7 @@=0A=
 {=0A=
 	u8	status;=0A=
 	u32	dword =3D 0;=0A=
-	u8	nstatus;=0A=
+	int	nstatus;=0A=
 	u8	completed[MAX_FIRMWARE_STATUS];=0A=
 	int	i;=0A=
 =0A=
@@ -2063,37 +2033,6 @@=0A=
 =0A=
 =0A=
 /**=0A=
- * megaraid_isr_memmapped()=0A=
- * @irq - irq=0A=
- * @devp - pointer to our soft state=0A=
- * @regs - unused=0A=
- *=0A=
- * Interrupt service routine for memory-mapped controllers.=0A=
- * Find out if our device is interrupting. If yes, acknowledge the =
interrupt=0A=
- * and service the completed commands.=0A=
- */=0A=
-static void=0A=
-megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)=0A=
-{=0A=
-	adapter_t	*adapter =3D devp;=0A=
-	unsigned long	flags;=0A=
-=0A=
-=0A=
-	spin_lock_irqsave(adapter->host_lock, flags);=0A=
-=0A=
-	megaraid_memmbox_ack_sequence(adapter);=0A=
-=0A=
-	/* Loop through any pending requests */=0A=
-	if(atomic_read(&adapter->quiescent) =3D=3D 0) {=0A=
-		mega_runpendq(adapter);=0A=
-	}=0A=
-=0A=
-	spin_unlock_irqrestore(adapter->host_lock, flags);=0A=
-=0A=
-	return;=0A=
-}=0A=
-=0A=
-/**=0A=
  * mega_cmd_done()=0A=
  * @adapter - pointer to our soft state=0A=
  * @completed - array of ids of completed commands=0A=
@@ -2102,7 +2041,7 @@=0A=
  *=0A=
  * Complete the comamnds and call the scsi mid-layer callback =
hooks.=0A=
  */=0A=
-static void=0A=
+static inline void=0A=
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int =
status)=0A=
 {=0A=
 	mega_ext_passthru	*epthru =3D NULL;=0A=
@@ -2404,6 +2343,18 @@=0A=
 	list_add(&scb->list, &adapter->free_list);=0A=
 }=0A=
 =0A=
+=0A=
+/*=0A=
+ * Wait until the controller's mailbox is available=0A=
+ */=0A=
+static inline int=0A=
+mega_busywait_mbox (adapter_t *adapter)=0A=
+{=0A=
+	if (adapter->mbox->busy)=0A=
+		return __mega_busywait_mbox(adapter);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int=0A=
 __mega_busywait_mbox (adapter_t *adapter)=0A=
 {=0A=
@@ -2434,7 +2385,7 @@=0A=
 =0A=
 	cmd =3D scb->cmd;=0A=
 =0A=
-	/* return 0 elements if no data transfer */=0A=
+	// return 0 elements if no data transfer=0A=
 	if (!cmd->request_buffer || !cmd->request_bufflen)=0A=
 		return 0;=0A=
 =0A=
@@ -2561,43 +2512,6 @@=0A=
 		enquiry3->pdrv_state[i] =3D inquiry->pdrv_info.pdrv_state[i];=0A=
 }=0A=
 =0A=
-static inline void=0A=
-mega_free_sgl(adapter_t *adapter)=0A=
-{=0A=
-	scb_t	*scb;=0A=
-	int	i;=0A=
-=0A=
-	for(i =3D 0; i < adapter->max_cmds; i++) {=0A=
-=0A=
-		scb =3D &adapter->scb_list[i];=0A=
-=0A=
-		if( scb->sgl64 ) {=0A=
-			pci_free_consistent(adapter->dev,=0A=
-				sizeof(mega_sgl64) * adapter->sglen,=0A=
-				scb->sgl64,=0A=
-				scb->sgl_dma_addr);=0A=
-=0A=
-			scb->sgl64 =3D NULL;=0A=
-		}=0A=
-=0A=
-		if( scb->pthru ) {=0A=
-			pci_free_consistent(adapter->dev, sizeof(mega_passthru),=0A=
-				scb->pthru, scb->pthru_dma_addr);=0A=
-=0A=
-			scb->pthru =3D NULL;=0A=
-		}=0A=
-=0A=
-		if( scb->epthru ) {=0A=
-			pci_free_consistent(adapter->dev,=0A=
-				sizeof(mega_ext_passthru),=0A=
-				scb->epthru, scb->epthru_dma_addr);=0A=
-=0A=
-			scb->epthru =3D NULL;=0A=
-		}=0A=
-=0A=
-	}=0A=
-}=0A=
-=0A=
 =0A=
 /*=0A=
  * Release the controller's resources=0A=
@@ -2726,7 +2640,7 @@=0A=
 	 */=0A=
 	scsi_unregister(host);=0A=
 =0A=
-#if defined(__x86_64__)=0A=
+#ifdef LSI_CONFIG_COMPAT=0A=
 	unregister_ioctl32_conversion(MEGAIOCCMD);=0A=
 #endif=0A=
 =0A=
@@ -2735,6 +2649,44 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static inline void=0A=
+mega_free_sgl(adapter_t *adapter)=0A=
+{=0A=
+	scb_t	*scb;=0A=
+	int	i;=0A=
+=0A=
+	for(i =3D 0; i < adapter->max_cmds; i++) {=0A=
+=0A=
+		scb =3D &adapter->scb_list[i];=0A=
+=0A=
+		if( scb->sgl64 ) {=0A=
+			pci_free_consistent(adapter->dev,=0A=
+				sizeof(mega_sgl64) * adapter->sglen,=0A=
+				scb->sgl64,=0A=
+				scb->sgl_dma_addr);=0A=
+=0A=
+			scb->sgl64 =3D NULL;=0A=
+		}=0A=
+=0A=
+		if( scb->pthru ) {=0A=
+			pci_free_consistent(adapter->dev, sizeof(mega_passthru),=0A=
+				scb->pthru, scb->pthru_dma_addr);=0A=
+=0A=
+			scb->pthru =3D NULL;=0A=
+		}=0A=
+=0A=
+		if( scb->epthru ) {=0A=
+			pci_free_consistent(adapter->dev,=0A=
+				sizeof(mega_ext_passthru),=0A=
+				scb->epthru, scb->epthru_dma_addr);=0A=
+=0A=
+			scb->epthru =3D NULL;=0A=
+		}=0A=
+=0A=
+	}=0A=
+}=0A=
+=0A=
+=0A=
 /*=0A=
  * Get information about the card/driver=0A=
  */=0A=
@@ -2835,7 +2787,6 @@=0A=
 	return SUCCESS;=0A=
 }=0A=
 =0A=
-=0A=
 static int=0A=
 megaraid_reset(Scsi_Cmnd *cmd)=0A=
 {=0A=
@@ -2903,12 +2854,10 @@=0A=
 		/*=0A=
 		 * Perform the ack sequence, since interrupts are unavailable=0A=
 		 */=0A=
-		if( adapter->flag & BOARD_MEMMAP ) {=0A=
+		if (adapter->flag & BOARD_MEMMAP)=0A=
 			megaraid_memmbox_ack_sequence(adapter);=0A=
-		}=0A=
-		else {=0A=
+		else=0A=
 			megaraid_iombox_ack_sequence(adapter);=0A=
-		}=0A=
 =0A=
 		spin_unlock(adapter->host_lock);=0A=
 =0A=
@@ -2941,7 +2890,6 @@=0A=
 	return rval;=0A=
 }=0A=
 =0A=
-=0A=
 #ifdef CONFIG_PROC_FS=0A=
 /* Following code handles /proc fs  */=0A=
 =0A=
@@ -3200,26 +3148,6 @@=0A=
 	return len;=0A=
 }=0A=
 =0A=
-/**=0A=
- * mega_allocate_inquiry()=0A=
- * @dma_handle - handle returned for dma address=0A=
- * @pdev - handle to pci device=0A=
- *=0A=
- * allocates memory for inquiry structure=0A=
- */=0A=
-static inline caddr_t=0A=
-mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)=0A=
-{=0A=
-	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), =
dma_handle);=0A=
-}=0A=
-=0A=
-=0A=
-static inline void=0A=
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct =
pci_dev *pdev)=0A=
-{=0A=
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, =
dma_handle);=0A=
-}=0A=
-=0A=
 =0A=
 /**=0A=
  * proc_rebuild_rate()=0A=
@@ -4172,7 +4100,7 @@=0A=
 }=0A=
 =0A=
 =0A=
-#if defined(__x86_64__)=0A=
+#ifdef LSI_CONFIG_COMPAT=0A=
 static int=0A=
 megadev_compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long =
arg,=0A=
 		struct file *filep)=0A=
@@ -4221,7 +4149,7 @@=0A=
 	megacmd_t	mc;=0A=
 	megastat_t	*ustats;=0A=
 	int		num_ldrv;=0A=
-	u32		uxferaddr =3D 0;=0A=
+	caddr_t		uxferaddr=3DNULL;=0A=
 	struct pci_dev	*pdev;=0A=
 =0A=
 	ustats =3D NULL; /* avoid compilation warnings */=0A=
@@ -4251,13 +4179,13 @@=0A=
 	switch( uioc.opcode ) {=0A=
 =0A=
 	case GET_DRIVER_VER:=0A=
-		if( put_user(driver_ver, (u32 *)uioc.uioc_uaddr) )=0A=
+		if( put_user(driver_ver, (u32 *)uioc.u_dataaddr) )=0A=
 			return (-EFAULT);=0A=
 =0A=
 		break;=0A=
 =0A=
 	case GET_N_ADAP:=0A=
-		if( put_user(hba_count, (u32 *)uioc.uioc_uaddr) )=0A=
+		if( put_user(hba_count, (u32 *)uioc.u_dataaddr) )=0A=
 			return (-EFAULT);=0A=
 =0A=
 		/*=0A=
@@ -4275,7 +4203,7 @@=0A=
 		if( (adapno =3D GETADAP(uioc.adapno)) >=3D hba_count )=0A=
 			return (-ENODEV);=0A=
 =0A=
-		if( copy_to_user(uioc.uioc_uaddr, mcontroller+adapno,=0A=
+		if( copy_to_user(uioc.u_dataaddr, mcontroller+adapno,=0A=
 				sizeof(struct mcontroller)) )=0A=
 			return (-EFAULT);=0A=
 		break;=0A=
@@ -4291,7 +4219,7 @@=0A=
 =0A=
 		adapter =3D hba_soft_state[adapno];=0A=
 =0A=
-		ustats =3D (megastat_t *)uioc.uioc_uaddr;=0A=
+		ustats =3D (megastat_t *)uioc.u_dataaddr;=0A=
 =0A=
 		if( copy_from_user(&num_ldrv, &ustats->num_ldrv, sizeof(int)) )=0A=
 			return (-EFAULT);=0A=
@@ -4333,7 +4261,7 @@=0A=
 		/*=0A=
 		 * Which adapter=0A=
 		 */=0A=
-		if( (adapno =3D GETADAP(uioc.adapno)) >=3D hba_count ) =0A=
+		if( (adapno =3D GETADAP(uioc.adapno)) >=3D hba_count )=0A=
 			return (-ENODEV);=0A=
 =0A=
 		adapter =3D hba_soft_state[adapno];=0A=
@@ -4342,37 +4270,37 @@=0A=
 		 * Deletion of logical drive is a special case. The adapter=0A=
 		 * should be quiescent before this command is issued.=0A=
 		 */=0A=
-		if( uioc.uioc_rmbox[0] =3D=3D FC_DEL_LOGDRV &&=0A=
-				uioc.uioc_rmbox[2] =3D=3D OP_DEL_LOGDRV ) {=0A=
+		if( RMBOX(uioc)[0] =3D=3D FC_DEL_LOGDRV ) {=0A=
+			if ( RMBOX(uioc)[2] =3D=3D OP_DEL_LOGDRV ) {=0A=
+				/*=0A=
+				 * Do we support this feature=0A=
+				 */=0A=
+				if( !adapter->support_random_del ) {=0A=
+					printk(KERN_WARNING "megaraid: logdrv ");=0A=
+					printk("delete on non-supporting F/W.\n");=0A=
 =0A=
-			/*=0A=
-			 * Do we support this feature=0A=
-			 */=0A=
-			if( !adapter->support_random_del ) {=0A=
-				printk(KERN_WARNING "megaraid: logdrv ");=0A=
-				printk("delete on non-supporting F/W.\n");=0A=
+					return (-EINVAL);=0A=
+				}=0A=
 =0A=
-				return (-EINVAL);=0A=
-			}=0A=
+				rval =3D mega_del_logdrv( adapter, RMBOX(uioc)[3] );=0A=
 =0A=
-			rval =3D mega_del_logdrv( adapter, uioc.uioc_rmbox[3] );=0A=
+				if( rval =3D=3D 0 ) {=0A=
+					memset(&mc, 0, sizeof(megacmd_t));=0A=
 =0A=
-			if( rval =3D=3D 0 ) {=0A=
-				memset(&mc, 0, sizeof(megacmd_t));=0A=
+					mc.status =3D rval;=0A=
 =0A=
-				mc.status =3D rval;=0A=
+					rval =3D mega_n_to_m((void *)arg, &mc);=0A=
+				}=0A=
 =0A=
-				rval =3D mega_n_to_m((void *)arg, &mc);=0A=
+				return rval;=0A=
 			}=0A=
-=0A=
-			return rval;=0A=
 		}=0A=
 		/*=0A=
 		 * This interface only support the regular passthru commands.=0A=
 		 * Reject extended passthru and 64-bit passthru=0A=
 		 */=0A=
-		if( uioc.uioc_rmbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU64 ||=0A=
-			uioc.uioc_rmbox[0] =3D=3D MEGA_MBOXCMD_EXTPTHRU ) {=0A=
+		if( RMBOX(uioc)[0] =3D=3D MEGA_MBOXCMD_PASSTHRU64 ||=0A=
+			RMBOX(uioc)[0] =3D=3D MEGA_MBOXCMD_EXTPTHRU ) {=0A=
 =0A=
 			printk(KERN_WARNING "megaraid: rejected passthru.\n");=0A=
 =0A=
@@ -4386,7 +4314,7 @@=0A=
 		pdev =3D adapter->dev;=0A=
 =0A=
 		/* Is it a passthru command or a DCMD */=0A=
-		if( uioc.uioc_rmbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
+		if( RMBOX(uioc)[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
 			/* Passthru commands */=0A=
 =0A=
 			pthru =3D adapter->int_pthru;=0A=
@@ -4394,20 +4322,12 @@=0A=
 			/*=0A=
 			 * The user passthru structure=0A=
 			 */=0A=
-			upthru =3D (mega_passthru *)=0A=
-					((ulong)(MBOX(uioc)->xferaddr));=0A=
-			/*=0A=
-			 * Copy in the user passthru here.=0A=
-			 */=0A=
-			if( copy_from_user(pthru, (char *)upthru,=0A=
-						sizeof(mega_passthru)) ) {=0A=
-				return (-EFAULT);=0A=
-			}=0A=
-=0A=
+			 upthru =3D &uioc.pthru;=0A=
+			 memcpy(pthru, (char *)upthru,sizeof(mega_passthru));=0A=
 			/*=0A=
 			 * Is there a data transfer; If the data transfer=0A=
-			 * length is <=3D INT_MEMBLK_SZ, usr the buffer =0A=
-			 * allocated at the load time. Otherwise, allocate it =0A=
+			 * length is <=3D INT_MEMBLK_SZ, usr the buffer=0A=
+			 * allocated at the load time. Otherwise, allocate it=0A=
 			 * here.=0A=
 			 */=0A=
 			if (pthru->dataxferlen) {=0A=
@@ -4417,8 +4337,9 @@=0A=
 							pthru->dataxferlen,=0A=
 							&data_dma_hndl );=0A=
 =0A=
-					if (data =3D=3D NULL)=0A=
+					if (data =3D=3D NULL) {=0A=
 						return (-ENOMEM);=0A=
+					}=0A=
 				}=0A=
 				else {=0A=
 					data =3D adapter->int_data;=0A=
@@ -4428,11 +4349,11 @@=0A=
 				 * Save the user address and point the kernel=0A=
 				 * address at just allocated memory=0A=
 				 */=0A=
-				uxferaddr =3D pthru->dataxferaddr;=0A=
+				uxferaddr =3D (caddr_t) uioc.u_dataaddr;=0A=
 				if (data_dma_hndl)=0A=
 					pthru->dataxferaddr =3D data_dma_hndl;=0A=
 				else=0A=
-					pthru->dataxferaddr =3D =0A=
+					pthru->dataxferaddr =3D=0A=
 						adapter->int_data_dma_hndl;=0A=
 			}=0A=
 =0A=
@@ -4440,12 +4361,12 @@=0A=
 			/*=0A=
 			 * Is data coming down-stream=0A=
 			 */=0A=
-			if( pthru->dataxferlen && (uioc.flags & UIOC_WR) ) {=0A=
+			if(pthru->dataxferlen  && (uioc.flags & UIOC_WR) ) {=0A=
 				/*=0A=
 				 * Get the user data=0A=
 				 */=0A=
 				if( copy_from_user(data,=0A=
-						(char *)((ulong)uxferaddr),=0A=
+						(char *)uxferaddr,=0A=
 						pthru->dataxferlen) ) {=0A=
 					rval =3D (-EFAULT);=0A=
 					goto freedata_and_return;=0A=
@@ -4471,7 +4392,7 @@=0A=
 			 * Is data going up-stream=0A=
 			 */=0A=
 			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {=0A=
-				if( copy_to_user((char *)((ulong)uxferaddr),=0A=
+				if( copy_to_user((char *)uxferaddr,=0A=
 						data, pthru->dataxferlen) ) {=0A=
 					rval =3D (-EFAULT);=0A=
 				}=0A=
@@ -4511,7 +4432,7 @@=0A=
 				else {=0A=
 					data =3D adapter->int_data;=0A=
 				}=0A=
-				uxferaddr =3D MBOX(uioc)->xferaddr;=0A=
+				uxferaddr =3D uioc.u_dataaddr;=0A=
 			}=0A=
 =0A=
 			/*=0A=
@@ -4559,7 +4480,7 @@=0A=
 			 * Is data going up-stream=0A=
 			 */=0A=
 			if( uioc.xferlen && (uioc.flags & UIOC_RD) ) {=0A=
-				if( copy_to_user((char *)((ulong)uxferaddr),=0A=
+				if( copy_to_user((char *)uxferaddr,=0A=
 						data, uioc.xferlen) ) {=0A=
 =0A=
 					rval =3D (-EFAULT);=0A=
@@ -4648,18 +4569,18 @@=0A=
 =0A=
 		case MEGAIOC_QDRVRVER:	/* Query driver version */=0A=
 			uioc->opcode =3D GET_DRIVER_VER;=0A=
-			uioc->uioc_uaddr =3D uioc_mimd.data;=0A=
+			uioc->u_dataaddr =3D uioc_mimd.data;=0A=
 			break;=0A=
 =0A=
 		case MEGAIOC_QNADAP:	/* Get # of adapters */=0A=
 			uioc->opcode =3D GET_N_ADAP;=0A=
-			uioc->uioc_uaddr =3D uioc_mimd.data;=0A=
+			uioc->u_dataaddr =3D uioc_mimd.data;=0A=
 			break;=0A=
 =0A=
 		case MEGAIOC_QADAPINFO:	/* Get adapter information */=0A=
 			uioc->opcode =3D GET_ADAP_INFO;=0A=
 			uioc->adapno =3D uioc_mimd.ui.fcs.adapno;=0A=
-			uioc->uioc_uaddr =3D uioc_mimd.data;=0A=
+			uioc->u_dataaddr =3D uioc_mimd.data;=0A=
 			break;=0A=
 =0A=
 		default:=0A=
@@ -4674,9 +4595,16 @@=0A=
 		uioc->opcode =3D MBOX_CMD;=0A=
 		uioc->adapno =3D uioc_mimd.ui.fcs.adapno;=0A=
 =0A=
-		memcpy(uioc->uioc_rmbox, uioc_mimd.mbox, 18);=0A=
+		memcpy(&uioc->u_mbox, uioc_mimd.mbox, 18);=0A=
 =0A=
 		uioc->xferlen =3D uioc_mimd.ui.fcs.length;=0A=
+		uioc->u_dataaddr =3D uioc_mimd.ui.fcs.buffer;=0A=
+=0A=
+		if (uioc_mimd.mbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
+			memcpy(&uioc->pthru,&uioc_mimd.pthru,=0A=
+				sizeof(mega_passthru));=0A=
+=0A=
+		}=0A=
 =0A=
 		if( uioc_mimd.outlen ) uioc->flags =3D UIOC_RD;=0A=
 		if( uioc_mimd.inlen ) uioc->flags |=3D UIOC_WR;=0A=
@@ -4688,13 +4616,20 @@=0A=
 		uioc->opcode =3D MBOX_CMD;=0A=
 		uioc->adapno =3D uioc_mimd.ui.fcs.adapno;=0A=
 =0A=
-		memcpy(uioc->uioc_rmbox, uioc_mimd.mbox, 18);=0A=
+		memcpy(&uioc->u_mbox, uioc_mimd.mbox, 18);=0A=
 =0A=
 		/*=0A=
 		 * Choose the xferlen bigger of input and output data=0A=
 		 */=0A=
 		uioc->xferlen =3D uioc_mimd.outlen > uioc_mimd.inlen ?=0A=
 			uioc_mimd.outlen : uioc_mimd.inlen;=0A=
+		uioc->u_dataaddr =3D uioc_mimd.data;=0A=
+=0A=
+		if (uioc_mimd.mbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
+			memcpy(&uioc->pthru,&uioc_mimd.pthru,=0A=
+				sizeof(mega_passthru));=0A=
+=0A=
+		}=0A=
 =0A=
 		if( uioc_mimd.outlen ) uioc->flags =3D UIOC_RD;=0A=
 		if( uioc_mimd.inlen ) uioc->flags |=3D UIOC_WR;=0A=
@@ -4735,20 +4670,14 @@=0A=
 =0A=
 	if( memcmp(signature, "MEGANIT", 7) =3D=3D 0 ) {=0A=
 =0A=
-		uiocp =3D (nitioctl_t *)arg;=0A=
-=0A=
-		if( put_user(mc->status, (u8 *)&MBOX_P(uiocp)->status) )=0A=
-			return (-EFAULT);=0A=
-=0A=
-		if( mc->cmd =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
-=0A=
-			umc =3D MBOX_P(uiocp);=0A=
-=0A=
-			upthru =3D (mega_passthru *)((ulong)(umc->xferaddr));=0A=
 =0A=
-			if( put_user(mc->status, (u8 *)&upthru->scsistatus) )=0A=
-				return (-EFAULT);=0A=
-		}=0A=
+		/*=0A=
+		 * NOTE: The nit ioctl is still under flux because of=0A=
+		 * change of mailbox definition, in HPE. No applications yet=0A=
+		 * use this interface and let's not have applications use this=0A=
+		 * interface till the new specifitions are in place.=0A=
+		 */=0A=
+		return -EINVAL;=0A=
 	}=0A=
 	else {=0A=
 		uioc_mimd =3D (struct uioctl_t *)arg;=0A=
@@ -4763,8 +4692,7 @@=0A=
 			if (copy_from_user(&kmc, umc, sizeof(megacmd_t))) {=0A=
 				return -EFAULT;=0A=
 			}=0A=
-=0A=
-			upthru =3D (mega_passthru *)((ulong)kmc.xferaddr);=0A=
+			upthru =3D (mega_passthru *)((ulong)&uioc_mimd->pthru);=0A=
 =0A=
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus) ){=0A=
 				return (-EFAULT);=0A=
@@ -5179,6 +5107,55 @@=0A=
 }=0A=
 =0A=
 =0A=
+=0A=
+/**=0A=
+ * mega_get_ldrv_num()=0A=
+ * @adapter - pointer to our soft state=0A=
+ * @cmd - scsi mid layer command=0A=
+ * @channel - channel on the controller=0A=
+ *=0A=
+ * Calculate the logical drive number based on the information in scsi =
command=0A=
+ * and the channel number.=0A=
+ */=0A=
+static inline int=0A=
+mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)=0A=
+{=0A=
+	int		tgt;=0A=
+	int		ldrv_num;=0A=
+=0A=
+	tgt =3D cmd->target;=0A=
+=0A=
+	if ( tgt > adapter->this_id )=0A=
+		tgt--;	/* we do not get inquires for initiator id */=0A=
+=0A=
+	ldrv_num =3D (channel * 15) + tgt;=0A=
+=0A=
+=0A=
+	/*=0A=
+	 * If we have a logical drive with boot enabled, project it first=0A=
+	 */=0A=
+	if( adapter->boot_ldrv_enabled ) {=0A=
+		if( ldrv_num =3D=3D 0 ) {=0A=
+			ldrv_num =3D adapter->boot_ldrv;=0A=
+		}=0A=
+		else {=0A=
+			if( ldrv_num <=3D adapter->boot_ldrv ) {=0A=
+				ldrv_num--;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * If "delete logical drive" feature is enabled on this =
controller,=0A=
+	 * the value returned should be 0x80+logical drive id.=0A=
+	 */=0A=
+	if (adapter->support_random_del)=0A=
+		ldrv_num +=3D 0x80;=0A=
+=0A=
+	return ldrv_num;=0A=
+}=0A=
+=0A=
+=0A=
 /**=0A=
  * mega_reorder_hosts()=0A=
  *=0A=
@@ -5393,6 +5370,26 @@=0A=
 }=0A=
 =0A=
 =0A=
+/**=0A=
+ * mega_allocate_inquiry()=0A=
+ * @dma_handle - handle returned for dma address=0A=
+ * @pdev - handle to pci device=0A=
+ *=0A=
+ * allocates memory for inquiry structure=0A=
+ */=0A=
+static inline caddr_t=0A=
+mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)=0A=
+{=0A=
+	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), =
dma_handle);=0A=
+}=0A=
+=0A=
+=0A=
+static inline void=0A=
+mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct =
pci_dev *pdev)=0A=
+{=0A=
+	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, =
dma_handle);=0A=
+}=0A=
+=0A=
 =0A=
 /** mega_internal_dev_inquiry()=0A=
  * @adapter - pointer to our soft state=0A=
diff -Naur old/drivers/scsi/megaraid2.h new/drivers/scsi/megaraid2.h=0A=
--- old/drivers/scsi/megaraid2.h	2005-07-15 07:52:27.558936976 -0400=0A=
+++ new/drivers/scsi/megaraid2.h	2005-07-15 07:52:18.566304064 -0400=0A=
@@ -6,7 +6,7 @@=0A=
 =0A=
 =0A=
 #define MEGARAID_VERSION	\=0A=
-	"v2.10.8.2 (Release Date: Mon Jul 26 12:15:51 EDT 2004)\n"=0A=
+	"v2.10.10.1 (Release Date: Thu Jan 27 16:19:44 EDT 2005)\n"=0A=
 =0A=
 /*=0A=
  * Driver features - change the values to enable or disable features =
in the=0A=
@@ -83,6 +83,7 @@=0A=
 #define INTEL_SUBSYS_VID		0x8086=0A=
 #define FSC_SUBSYS_VID			0x1734=0A=
 #define ACER_SUBSYS_VID			0x1025=0A=
+#define NEC_SUBSYS_VID			0x1033=0A=
 =0A=
 #define HBA_SIGNATURE	      		0x3344=0A=
 #define HBA_SIGNATURE_471	  	0xCCCC=0A=
@@ -143,7 +144,8 @@=0A=
 	.eh_device_reset_handler =3D	megaraid_reset,		\=0A=
 	.eh_bus_reset_handler =3D		megaraid_reset,		\=0A=
 	.eh_host_reset_handler =3D	megaraid_reset,		\=0A=
-	.highmem_io =3D			1			\=0A=
+	.highmem_io =3D			1,			\=0A=
+	.vary_io =3D			1			\=0A=
 }=0A=
 =0A=
 =0A=
@@ -707,15 +709,15 @@=0A=
 	char		signature[8];	/* Must contain "MEGANIT" */=0A=
 	u32		opcode;		/* opcode for the command */=0A=
 	u32		adapno;		/* adapter number */=0A=
-	union {=0A=
-		u8	__raw_mbox[18];=0A=
-		caddr_t	__uaddr; /* xferaddr for non-mbox cmds */=0A=
-	}__ua;=0A=
-=0A=
-#define uioc_rmbox	__ua.__raw_mbox=0A=
-#define MBOX(uioc)	((megacmd_t *)&((uioc).__ua.__raw_mbox[0]))=0A=
-#define MBOX_P(uioc)	((megacmd_t *)&((uioc)->__ua.__raw_mbox[0]))=0A=
-#define uioc_uaddr	__ua.__uaddr=0A=
+	mbox_t  	u_mbox;		/* user mailbox */=0A=
+	caddr_t		u_dataaddr;	/* xferaddr for DCMD and non-mbox=0A=
+					   commands */=0A=
+	mega_passthru	pthru;=0A=
+=0A=
+#define RMBOX(uioc) 	((u8 *)&(uioc).u_mbox)=0A=
+#define MBOX(uioc)	((megacmd_t *)&(uioc).u_mbox)=0A=
+#define MBOX_P(uioc) 	((megacmd_t *)&(uioc)->u_mbox)=0A=
+=0A=
 =0A=
 	u32		xferlen;	/* xferlen for DCMD and non-mbox=0A=
 					   commands */=0A=
@@ -1128,7 +1130,7 @@=0A=
 			      u32 *buffer, u32 *length);=0A=
 static inline int mega_busywait_mbox (adapter_t *);=0A=
 static int __mega_busywait_mbox (adapter_t *);=0A=
-static void mega_cmd_done(adapter_t *, u8 [], int, int);=0A=
+static inline void mega_cmd_done(adapter_t *, u8 [], int, int);=0A=
 static inline void mega_free_sgl (adapter_t *adapter);=0A=
 static void mega_8_to_40ld (mraid_inquiry *inquiry,=0A=
 		mega_inquiry3 *enquiry3, mega_product_info *);=0A=
@@ -1137,7 +1139,14 @@=0A=
 				   unsigned long, void *);=0A=
 static int megadev_open (struct inode *, struct file *);=0A=
 =0A=
-#if defined(__x86_64__)=0A=
+#if defined(CONFIG_COMPAT) || defined( __x86_64__) || =
defined(IA32_EMULATION)=0A=
+#ifndef __ia64__=0A=
+#define LSI_CONFIG_COMPAT=0A=
+#endif=0A=
+#endif=0A=
+=0A=
+=0A=
+#ifdef LSI_CONFIG_COMPAT=0A=
 static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned =
long,=0A=
 	struct file *);=0A=
 #endif=0A=

------_=_NextPart_000_01C58952.5C5F4C00--
