Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVBBWjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVBBWjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVBBVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:20:28 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:59084 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S262921AbVBBVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:09:19 -0500
Date: Thu, 3 Feb 2005 00:08:57 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Vasily Averin <vvs@sw.ru>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050202210857.GH19453@kmv.ru>
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru> <20050202190626.GB18763@lists.us.dell.com> <42012ACC.4090806@sw.ru> <20050202201914.GC18763@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202201914.GC18763@lists.us.dell.com>
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XXRslwHt:5970@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt Domsch!
 On Wed, Feb 02, 2005 at 02:19:14PM -0600, Matt Domsch wrote next:

> On Wed, Feb 02, 2005 at 10:32:28PM +0300, Vasily Averin wrote:
> > >As a hack, one could #define inline /*nothing*/ in megaraid2.h to
> > >avoid this, but it would be nice if the functions could all get
> > >reordered such that inlining works properly, and the need for function
> > >declarations in megaraid2.h would disappear completely.
> > 
> > 
> > Could you fix it by additional patch? Or you going to prepare a new one?
> 
> Here's the hack patch (will apply after yours).

Reorder inline functions
Uninline big mega_cmd_done() function

Signed-off-by: <temnota+kernel@kmv.ru>

--- drivers/scsi/megaraid2.c.orig	Wed Feb  2 23:30:04 2005
+++ drivers/scsi/megaraid2.c	Wed Feb  2 23:57:15 2005
@@ -989,6 +989,268 @@
 }
 
 
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
+ * mega_get_ldrv_num()
+ * @adapter - pointer to our soft state
+ * @cmd - scsi mid layer command
+ * @channel - channel on the controller
+ *
+ * Calculate the logical drive number based on the information in scsi command
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
+
+/**
+ * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped HBAs
+ * @adapter	- controller's soft state
+ *
+ * Interrupt ackrowledgement sequence for IO mapped HBAs
+ */
+static inline void
+megaraid_iombox_ack_sequence(adapter_t *adapter)
+{
+	u8	status;
+	u8	nstatus;
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
+
 /*
  * megaraid_queue()
  * @scmd - Issue this scsi command
@@ -1601,145 +1863,6 @@
 
 
 /**
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
  * issue_scb_block()
  * @adapter - pointer to our soft state
  * @raw_mbox - the mailbox
@@ -1807,145 +1930,51 @@
 		WRINDOOR(adapter, adapter->mbox_dma | 0x2);
 
 		while(RDINDOOR(adapter) & 0x2)
-			cpu_relax();
-	}
-	else {
-		irq_disable(adapter);
-		issue_command(adapter);
-
-		while (!((byte = irq_state(adapter)) & INTR_VALID))
-			cpu_relax();
-
-		status = mbox->status;
-		mbox->numstatus = 0xFF;
-		mbox->status = 0xFF;
-
-		set_irq_state(adapter, byte);
-		irq_enable(adapter);
-		irq_ack(adapter);
-	}
-
-	// invalidate the completed command id array. After command
-	// completion, firmware would write the valid id.
-	for (i = 0; i < MAX_FIRMWARE_STATUS; i++) {
-		mbox->completed[i] = 0xFF;
-	}
-
-	return status;
-
-bug_blocked_mailbox:
-	printk(KERN_WARNING "megaraid: Blocked mailbox......!!\n");
-	udelay (1000);
-	return -1;
-}
-
-
-/**
- * megaraid_isr_iomapped()
- * @irq - irq
- * @devp - pointer to our soft state
- * @regs - unused
- *
- * Interrupt service routine for io-mapped controllers.
- * Find out if our device is interrupting. If yes, acknowledge the interrupt
- * and service the completed commands.
- */
-static void
-megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
-{
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-
-
-	spin_lock_irqsave(adapter->host_lock, flags);
-
-	megaraid_iombox_ack_sequence(adapter);
-
-	/* Loop through any pending requests */
-	if( atomic_read(&adapter->quiescent ) == 0) {
-		mega_runpendq(adapter);
-	}
-
-	spin_unlock_irqrestore(adapter->host_lock, flags);
-
-	return;
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
+			cpu_relax();
+	}
+	else {
+		irq_disable(adapter);
+		issue_command(adapter);
 
-		// we must read the valid status now
-		if ((status = adapter->mbox->status) == 0xFF) {
-			printk(KERN_WARNING
-			"megaraid critical: status 0xFF from firmware.\n");
-		}
-		adapter->mbox->status = 0xFF;
+		while (!((byte = irq_state(adapter)) & INTR_VALID))
+			cpu_relax();
 
-		/*
-		 * decrement the pending queue counter
-		 */
-		atomic_sub(nstatus, &adapter->pend_cmds);
+		status = mbox->status;
+		mbox->numstatus = 0xFF;
+		mbox->status = 0xFF;
 
-		/* Acknowledge interrupt */
+		set_irq_state(adapter, byte);
+		irq_enable(adapter);
 		irq_ack(adapter);
+	}
 
-		mega_cmd_done(adapter, completed, nstatus, status);
+	// invalidate the completed command id array. After command
+	// completion, firmware would write the valid id.
+	for (i = 0; i < MAX_FIRMWARE_STATUS; i++) {
+		mbox->completed[i] = 0xFF;
+	}
 
-	} while(1);
+	return status;
+
+bug_blocked_mailbox:
+	printk(KERN_WARNING "megaraid: Blocked mailbox......!!\n");
+	udelay (1000);
+	return -1;
 }
 
 
 /**
- * megaraid_isr_memmapped()
+ * megaraid_isr_iomapped()
  * @irq - irq
  * @devp - pointer to our soft state
  * @regs - unused
  *
- * Interrupt service routine for memory-mapped controllers.
+ * Interrupt service routine for io-mapped controllers.
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
  * and service the completed commands.
  */
 static void
-megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
+megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
 {
 	adapter_t	*adapter = devp;
 	unsigned long	flags;
@@ -1953,10 +1982,10 @@
 
 	spin_lock_irqsave(adapter->host_lock, flags);
 
-	megaraid_memmbox_ack_sequence(adapter);
+	megaraid_iombox_ack_sequence(adapter);
 
 	/* Loop through any pending requests */
-	if(atomic_read(&adapter->quiescent) == 0) {
+	if( atomic_read(&adapter->quiescent ) == 0) {
 		mega_runpendq(adapter);
 	}
 
@@ -2034,6 +2063,37 @@
 
 
 /**
+ * megaraid_isr_memmapped()
+ * @irq - irq
+ * @devp - pointer to our soft state
+ * @regs - unused
+ *
+ * Interrupt service routine for memory-mapped controllers.
+ * Find out if our device is interrupting. If yes, acknowledge the interrupt
+ * and service the completed commands.
+ */
+static void
+megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
+{
+	adapter_t	*adapter = devp;
+	unsigned long	flags;
+
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
+/**
  * mega_cmd_done()
  * @adapter - pointer to our soft state
  * @completed - array of ids of completed commands
@@ -2042,7 +2102,7 @@
  *
  * Complete the comamnds and call the scsi mid-layer callback hooks.
  */
-static inline void
+static void
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 {
 	mega_ext_passthru	*epthru = NULL;
@@ -2344,18 +2404,6 @@
 	list_add(&scb->list, &adapter->free_list);
 }
 
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
 static int
 __mega_busywait_mbox (adapter_t *adapter)
 {
@@ -2513,6 +2561,43 @@
 		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
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
+			pci_free_consistent(adapter->dev, sizeof(mega_passthru),
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
 
 /*
  * Release the controller's resources
@@ -2650,44 +2735,6 @@
 	return 0;
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
-			pci_free_consistent(adapter->dev, sizeof(mega_passthru),
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
-
 /*
  * Get information about the card/driver
  */
@@ -3153,6 +3200,26 @@
 	return len;
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
+	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), dma_handle);
+}
+
+
+static inline void
+mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
+{
+	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
+}
+
 
 /**
  * proc_rebuild_rate()
@@ -5112,55 +5179,6 @@
 }
 
 
-
-/**
- * mega_get_ldrv_num()
- * @adapter - pointer to our soft state
- * @cmd - scsi mid layer command
- * @channel - channel on the controller
- *
- * Calculate the logical drive number based on the information in scsi command
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
-
 /**
  * mega_reorder_hosts()
  *
@@ -5374,26 +5392,6 @@
 	return 0;
 }
 
-
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
-	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), dma_handle);
-}
-
-
-static inline void
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
-{
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
-}
 
 
 /** mega_internal_dev_inquiry()
--- drivers/scsi/megaraid2.h.orig	Wed Feb  2 23:30:04 2005
+++ drivers/scsi/megaraid2.h	Wed Feb  2 23:49:09 2005
@@ -1128,7 +1128,7 @@
 			      u32 *buffer, u32 *length);
 static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
-static inline void mega_cmd_done(adapter_t *, u8 [], int, int);
+static void mega_cmd_done(adapter_t *, u8 [], int, int);
 static inline void mega_free_sgl (adapter_t *adapter);
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

