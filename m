Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVBBSyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVBBSyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVBBSyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:54:11 -0500
Received: from asplinux.ru ([195.133.213.194]:10245 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262734AbVBBSnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:43:43 -0500
Message-ID: <42011EFA.10109@sw.ru>
Date: Wed, 02 Feb 2005 21:42:02 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021224
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrey Melnikov <temnota+kernel@kmv.ru>, linux-kernel@vger.kernel.org,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet>
In-Reply-To: <20050131231752.GA17126@logos.cnet>
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050809090306080803050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809090306080803050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> On Tue, Jan 25, 2005 at 11:00:22AM +0300, Vasily Averin wrote:
>>You should unlock io_request_lock before msleep, like in latest versions
>>of megaraid2 drivers.
> 
> Andrey, 
> 
> Can you please update your patch to unlock io_request_lock before sleeping
> and locking after coming back? 
> 
> What the driver is doing is indeed wrong.

Marcelo,

This is megaraid2 driver update (2.10.8.2 version, latest 2.4-compatible
version that I've seen), taken from latest RHEL3 kernel update. I
believe it should prevent NMI in abort/reset handler.

Thank you,
	Vasily Averin, SWSoft Linux Kernel Team

--------------050809090306080803050803
Content-Type: text/plain;
 name="linux-2.4.29-megaraid2-2.10.8.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.29-megaraid2-2.10.8.2.patch"

--- ./drivers/scsi/megaraid2.c.mr2	Wed Feb  2 08:27:13 2005
+++ ./drivers/scsi/megaraid2.c	Wed Feb  2 10:28:52 2005
@@ -14,7 +14,7 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.10.3 (Apr 08, 2004)
+ * Version : v2.10.8.2 (July 26, 2004)
  *
  * Authors:	Atul Mukker <Atul.Mukker@lsil.com>
  *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
@@ -46,7 +46,7 @@
 
 #include "megaraid2.h"
 
-#ifdef LSI_CONFIG_COMPAT
+#if defined(__x86_64__)
 #include <asm/ioctl32.h>
 #endif
 
@@ -90,10 +90,15 @@ static struct notifier_block mega_notifi
 static struct mega_hbas mega_hbas[MAX_CONTROLLERS];
 
 /*
+ * Lock to protect access to IOCTL
+ */
+static struct semaphore megaraid_ioc_mtx;
+
+/*
  * The File Operations structure for the serial/ioctl interface of the driver
  */
 static struct file_operations megadev_fops = {
-	.ioctl		= megadev_ioctl,
+	.ioctl		= megadev_ioctl_entry,
 	.open		= megadev_open,
 	.release	= megadev_close,
 	.owner		= THIS_MODULE,
@@ -107,7 +112,7 @@ static struct file_operations megadev_fo
 static struct mcontroller mcontroller[MAX_CONTROLLERS];
 
 /* The current driver version */
-static u32 driver_ver = 0x02100000;
+static u32 driver_ver = 0x02104000;
 
 /* major number used by the device for character interface */
 static int major;
@@ -189,6 +194,11 @@ megaraid_detect(Scsi_Host_Template *host
 		 */
 		mega_reorder_hosts();
 
+		/*
+		 * Initialize the IOCTL lock
+		 */
+		init_MUTEX( &megaraid_ioc_mtx );
+
 #ifdef CONFIG_PROC_FS
 		mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
 
@@ -223,7 +233,7 @@ megaraid_detect(Scsi_Host_Template *host
 				"MegaRAID Shutdown routine not registered!!\n");
 		}
 
-#ifdef LSI_CONFIG_COMPAT
+#if defined(__x86_64__)
 		/*
 		 * Register the 32-bit ioctl conversion
 		 */
@@ -273,6 +283,8 @@ mega_find_card(Scsi_Host_Template *host_
 	unsigned long	tbase;
 	unsigned long	flag = 0;
 	int	i, j;
+	u8	did_int_pthru_f	= 0;
+	u8	did_int_data_f	= 0;
 
 	while((pdev = pci_find_device(pci_vendor, pci_device, pdev))) {
 
@@ -328,6 +340,7 @@ mega_find_card(Scsi_Host_Template *host_
 				(subsysvid != HP_SUBSYS_VID) &&
 				(subsysvid != INTEL_SUBSYS_VID) &&
 				(subsysvid != FSC_SUBSYS_VID) &&
+				(subsysvid != ACER_SUBSYS_VID) &&
 				(subsysvid != LSI_SUBSYS_VID) ) continue;
 
 
@@ -465,6 +478,33 @@ mega_find_card(Scsi_Host_Template *host_
 
 		alloc_scb_f = 1;
 
+		/*
+		 * Allocate memory for ioctls
+		 */
+		adapter->int_pthru = pci_alloc_consistent ( 
+					adapter->dev,
+					sizeof(mega_passthru),
+					&adapter->int_pthru_dma_hndl );
+
+		if( adapter->int_pthru == NULL ) {
+			printk(KERN_WARNING "megaraid: out of RAM.\n");
+			goto fail_attach;
+		}
+		else
+			did_int_pthru_f = 1;
+
+		adapter->int_data = pci_alloc_consistent (
+					adapter->dev,
+					INT_MEMBLK_SZ,
+					&adapter->int_data_dma_hndl );
+
+		if( adapter->int_data == NULL ) {
+			printk(KERN_WARNING "megaraid: out of RAM.\n");
+			goto fail_attach;
+		}
+		else
+			did_int_data_f = 1;
+
 		/* Request our IRQ */
 		if( adapter->flag & BOARD_MEMMAP ) {
 			if(request_irq(irq, megaraid_isr_memmapped, SA_SHIRQ,
@@ -676,6 +716,19 @@ mega_find_card(Scsi_Host_Template *host_
 		continue;
 
 fail_attach:
+		if( did_int_data_f ) {
+			pci_free_consistent(
+				adapter->dev, INT_MEMBLK_SZ, adapter->int_data, 
+				adapter->int_data_dma_hndl );
+		}
+
+		if( did_int_pthru_f ) {
+			pci_free_consistent(
+				adapter->dev, sizeof(mega_passthru),
+				(void*) adapter->int_pthru,
+				adapter->int_pthru_dma_hndl );
+		}
+
 		if( did_setup_mbox_f ) {
 			pci_free_consistent(adapter->dev, sizeof(mbox64_t),
 					(void *)adapter->una_mbox64,
@@ -936,19 +989,6 @@ mega_query_adapter(adapter_t *adapter)
 }
 
 
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
 /*
  * megaraid_queue()
  * @scmd - Issue this scsi command
@@ -999,98 +1039,6 @@ megaraid_queue(Scsi_Cmnd *scmd, void (*d
 
 
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
-	 * If "delete logical drive" feature is enabled on this controller.
-	 * Do only if at least one delete logical drive operation was done.
-	 *
-	 * Also, after logical drive deletion, instead of logical drive number,
-	 * the value returned should be 0x80+logical drive id.
-	 *
-	 * These is valid only for IO commands.
-	 */
-
-	if (adapter->support_random_del && adapter->read_ldidmap )
-		switch (cmd->cmnd[0]) {
-		case READ_6:	/* fall through */
-		case WRITE_6:	/* fall through */
-		case READ_10:	/* fall through */
-		case WRITE_10:
-			ldrv_num += 0x80;
-		}
-
-	return ldrv_num;
-}
-
-
-/**
  * mega_build_cmd()
  * @adapter - pointer to our soft state
  * @cmd - Prepare using this scsi command
@@ -1112,7 +1060,6 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 	mbox_t	*mbox;
 	long	seg;
 	char	islogical;
-	int	max_ldrv_num;
 	int	channel = 0;
 	int	target = 0;
 	int	ldrv_num = 0;   /* logical drive number */
@@ -1184,24 +1131,6 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 		}
 
 		ldrv_num = mega_get_ldrv_num(adapter, cmd, channel);
-
-
-		max_ldrv_num = (adapter->flag & BOARD_40LD) ?
-			MAX_LOGICAL_DRIVES_40LD : MAX_LOGICAL_DRIVES_8LD;
-
-		/*
-		 * max_ldrv_num increases by 0x80 if some logical drive was
-		 * deleted.
-		 */
-		if(adapter->read_ldidmap)
-			max_ldrv_num += 0x80;
-
-		if(ldrv_num > max_ldrv_num ) {
-			cmd->result = (DID_BAD_TARGET << 16);
-			cmd->scsi_done(cmd);
-			return NULL;
-		}
-
 	}
 	else {
 		if( cmd->lun > 7) {
@@ -1671,6 +1600,51 @@ mega_prepare_extpassthru(adapter_t *adap
 }
 
 
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
 static void
 __mega_runpendq(adapter_t *adapter)
 {
@@ -1702,7 +1676,7 @@ __mega_runpendq(adapter_t *adapter)
  * busy. We also take the scb from the pending list if the mailbox is
  * available.
  */
-static int
+static inline int
 issue_scb(adapter_t *adapter, scb_t *scb)
 {
 	volatile mbox64_t	*mbox64 = adapter->mbox64;
@@ -1765,17 +1739,6 @@ issue_scb(adapter_t *adapter, scb_t *scb
 }
 
 
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
 /**
  * issue_scb_block()
  * @adapter - pointer to our soft state
@@ -1878,6 +1841,38 @@ bug_blocked_mailbox:
 
 
 /**
+ * megaraid_isr_iomapped()
+ * @irq - irq
+ * @devp - pointer to our soft state
+ * @regs - unused
+ *
+ * Interrupt service routine for io-mapped controllers.
+ * Find out if our device is interrupting. If yes, acknowledge the interrupt
+ * and service the completed commands.
+ */
+static void
+megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
+{
+	adapter_t	*adapter = devp;
+	unsigned long	flags;
+
+
+	spin_lock_irqsave(adapter->host_lock, flags);
+
+	megaraid_iombox_ack_sequence(adapter);
+
+	/* Loop through any pending requests */
+	if( atomic_read(&adapter->quiescent ) == 0) {
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
  * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped HBAs
  * @adapter	- controller's soft state
  *
@@ -1940,6 +1935,38 @@ megaraid_iombox_ack_sequence(adapter_t *
 
 
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
+
+/**
  * megaraid_memmbox_ack_sequence - interrupt ack sequence for memory mapped HBAs
  * @adapter	- controller's soft state
  *
@@ -2007,70 +2034,6 @@ megaraid_memmbox_ack_sequence(adapter_t 
 
 
 /**
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
- * megaraid_isr_memmapped()
- * @irq - irq
- * @devp - pointer to our soft state
- * @regs - unused
- *
- * Interrupt service routine for memory-mapped controllers.
- * Find out if our device is interrupting. If yes, acknowledge the interrupt
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
-
-/**
  * mega_cmd_done()
  * @adapter - pointer to our soft state
  * @completed - array of ids of completed commands
@@ -2079,7 +2042,7 @@ megaraid_isr_memmapped(int irq, void *de
  *
  * Complete the comamnds and call the scsi mid-layer callback hooks.
  */
-static void
+static inline void
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 {
 	mega_ext_passthru	*epthru = NULL;
@@ -2382,6 +2345,17 @@ mega_free_scb(adapter_t *adapter, scb_t 
 }
 
 
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
@@ -2412,6 +2386,10 @@ mega_build_sglist(adapter_t *adapter, sc
 
 	cmd = scb->cmd;
 
+	/* return 0 elements if no data transfer */
+	if (!cmd->request_buffer || !cmd->request_bufflen)
+		return 0;
+
 	/* Scatter-gather not used */
 	if( !cmd->use_sg ) {
 
@@ -2519,58 +2497,20 @@ mega_8_to_40ld(mraid_inquiry *inquiry, m
 			inquiry->adapter_info.bios_version[i];
 	}
 	enquiry3->cache_flush_interval =
-		inquiry->adapter_info.cache_flush_interval;
-
-	product_info->dram_size = inquiry->adapter_info.dram_size;
-
-	enquiry3->num_ldrv = inquiry->logdrv_info.num_ldrv;
-
-	for (i = 0; i < MAX_LOGICAL_DRIVES_8LD; i++) {
-		enquiry3->ldrv_size[i] = inquiry->logdrv_info.ldrv_size[i];
-		enquiry3->ldrv_prop[i] = inquiry->logdrv_info.ldrv_prop[i];
-		enquiry3->ldrv_state[i] = inquiry->logdrv_info.ldrv_state[i];
-	}
-
-	for (i = 0; i < (MAX_PHYSICAL_DRIVES); i++)
-		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
-}
-
-
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
+		inquiry->adapter_info.cache_flush_interval;
 
-			scb->epthru = NULL;
-		}
+	product_info->dram_size = inquiry->adapter_info.dram_size;
 
+	enquiry3->num_ldrv = inquiry->logdrv_info.num_ldrv;
+
+	for (i = 0; i < MAX_LOGICAL_DRIVES_8LD; i++) {
+		enquiry3->ldrv_size[i] = inquiry->logdrv_info.ldrv_size[i];
+		enquiry3->ldrv_prop[i] = inquiry->logdrv_info.ldrv_prop[i];
+		enquiry3->ldrv_state[i] = inquiry->logdrv_info.ldrv_state[i];
 	}
+
+	for (i = 0; i < (MAX_PHYSICAL_DRIVES); i++)
+		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
 }
 
 
@@ -2666,6 +2606,13 @@ megaraid_release(struct Scsi_Host *host)
 	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
 			(void *)adapter->una_mbox64, adapter->una_mbox64_dma);
 
+	pci_free_consistent( adapter->dev, sizeof(mega_passthru),
+				(void*) adapter->int_pthru, 
+				adapter->int_pthru_dma_hndl );
+
+	pci_free_consistent( adapter->dev, INT_MEMBLK_SZ, adapter->int_data,
+				adapter->int_data_dma_hndl );
+
 	hba_count--;
 
 	if( hba_count == 0 ) {
@@ -2694,7 +2641,7 @@ megaraid_release(struct Scsi_Host *host)
 	 */
 	scsi_unregister(host);
 
-#ifdef LSI_CONFIG_COMPAT
+#if defined(__x86_64__)
 	unregister_ioctl32_conversion(MEGAIOCCMD);
 #endif
 
@@ -2703,6 +2650,44 @@ megaraid_release(struct Scsi_Host *host)
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
+
 /*
  * Get information about the card/driver
  */
@@ -2736,30 +2721,36 @@ megaraid_command (Scsi_Cmnd *cmd)
 }
 
 
-/**
- * megaraid_abort - abort the scsi command
- * @scp	- command to be aborted
- *
- * Abort a previous SCSI request. Only commands on the pending list can be
- * aborted. All the commands issued to the F/W must complete.
- */
 static int
 megaraid_abort(Scsi_Cmnd *scp)
 {
 	adapter_t		*adapter;
 	struct list_head	*pos, *next;
 	scb_t			*scb;
-	long			iter;
-	int			rval = SUCCESS;
+
+	printk("megaraid: aborting-%ld cmd=%x <c=%d t=%d l=%d>\n",
+		scp->serial_number, scp->cmnd[0], scp->channel,
+		scp->target, scp->lun);
 
 	adapter = (adapter_t *)scp->host->hostdata;
 
-	ASSERT( spin_is_locked(adapter->host_lock) );
+	/*
+	 * Check if hw_error flag was set in previous RESET call. If it was,
+	 * then FW is hanging and unlikely to function. We can return FAILURE
+	 * from here and expect the RESET handler to be called.
+	 */
 
-	printk("megaraid: aborting-%ld cmd=%x <c=%d t=%d l=%d>\n",
-		scp->serial_number, scp->cmnd[0], scp->channel, scp->target,
-		scp->lun);
+	if (adapter->hw_error) {
+		printk("megaraid: hw error, cannot abort\n");
+		return FAILED;
+	}
+
+	ASSERT( spin_is_locked(adapter->host_lock) );
 
+	/*
+	 * If cmd is waiting to be issued to FW, ABORT it with SUCEESS. If it
+	 * has already been issued, return FAILURE and expect RESET later.
+	 */
 
 	list_for_each_safe( pos, next, &adapter->pending_list ) {
 
@@ -2769,15 +2760,11 @@ megaraid_abort(Scsi_Cmnd *scp)
 
 			scb->state |= SCB_ABORT;
 
-			/*
-			 * Check if this command was never issued. If this is
-			 * the case, take it off from the pending list and
-			 * complete.
-			 */
 			if( !(scb->state & SCB_ISSUED) ) {
 
-				printk(KERN_WARNING
-				"megaraid: %ld:%d, driver owner.\n",
+				/* Not issued to the FW yet; ABORT it */
+
+				printk( "megaraid: %ld:%d, driver owner.\n",
 					scp->serial_number, scb->idx);
 
 				scp->result = (DID_ABORT << 16);
@@ -2786,67 +2773,31 @@ megaraid_abort(Scsi_Cmnd *scp)
 
 				scp->scsi_done(scp);
 
-				break;
+				return SUCCESS;
+			}
+			else {
+				/* Issued to the FW; can do nothing */
+				return FAILED;
 			}
 		}
 	}
 
 	/*
-	 * By this time, either all commands are completed or aborted by
-	 * mid-layer. Do not return until all the commands are actually
-	 * completed by the firmware
+	 * cmd is _not_ in our pending_list. Most likely we completed the cmd
 	 */
-	iter = 0;
-	while( atomic_read(&adapter->pend_cmds) > 0 ) {
-		/*
-		 * Perform the ack sequence, since interrupts are not
-		 * available right now!
-		 */
-		if( adapter->flag & BOARD_MEMMAP ) {
-			megaraid_memmbox_ack_sequence(adapter);
-		}
-		else {
-			megaraid_iombox_ack_sequence(adapter);
-		}
-
-		/*
-		 * print a message once every second only
-		 */
-		if( !(iter % 1000) ) {
-			printk(
-			"megaraid: Waiting for %d commands to flush: iter:%ld\n",
-				atomic_read(&adapter->pend_cmds), iter);
-		}
-
-		if( iter++ < MBOX_ABORT_SLEEP*1000 ) {
-			mdelay(1);
-		}
-		else {
-			printk(KERN_WARNING
-				"megaraid: critical hardware error!\n");
-
-			rval = FAILED;
-
-			break;
-		}
-	}
-
-	if( rval == SUCCESS ) {
-		printk(KERN_INFO
-			"megaraid: abort sequence successfully completed.\n");
-	}
-
-	return rval;
+	return SUCCESS;
 }
 
 
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
-	adapter_t	*adapter;
-	megacmd_t	mc;
-	long		iter;
-	int		rval = SUCCESS;
+	DECLARE_WAIT_QUEUE_HEAD(wq);
+	int			i;
+	scb_t			*scb;
+	adapter_t		*adapter;
+	struct list_head	*pos, *next;
+	int			rval;
 
 	adapter = (adapter_t *)cmd->host->hostdata;
 
@@ -2856,31 +2807,54 @@ megaraid_reset(Scsi_Cmnd *cmd)
 		cmd->serial_number, cmd->cmnd[0], cmd->channel, cmd->target,
 		cmd->lun);
 
+	/*
+	 * Check if hw_error flag was set in previous RESET call. If it was,
+	 * then we needn't do any handling here. The controller will be marked
+	 * offline soon
+	 */
 
-#if MEGA_HAVE_CLUSTERING
-	mc.cmd = MEGA_CLUSTER_CMD;
-	mc.opcode = MEGA_RESET_RESERVATIONS;
-
-	spin_unlock_irq(adapter->host_lock);
-	if( mega_internal_command(adapter, LOCK_INT, &mc, NULL) != 0 ) {
-		printk(KERN_WARNING
-				"megaraid: reservation reset failed.\n");
+	if (adapter->hw_error) {
+		printk("megaraid: hw error, cannot reset\n");
+		return FAILED;
 	}
-	else {
-		printk(KERN_INFO "megaraid: reservation reset.\n");
+
+	/*
+	 * Return all the pending cmds to the mid-layer with the cmd result
+	 * DID_RESET. Make sure you don't return the cmds ISSUED to FW.
+	 */
+	list_for_each_safe( pos, next, &adapter->pending_list ) {
+
+		scb		= list_entry(pos, scb_t, list);
+		scb->state	|= SCB_RESET;
+
+		if( !(scb->state & SCB_ISSUED) ) {
+
+			/* Not issued to the FW; return with RESET */
+			cmd->result = (DID_RESET << 16);
+
+			mega_free_scb(adapter, scb);
+			cmd->scsi_done(cmd);
+		}
 	}
-	spin_lock_irq(adapter->host_lock);
-#endif
 
 	/*
-	 * Do not return until all the commands are actually completed by the
-	 * firmware
+	 * Under exceptional conditions, FW may take up to 3 mins to complete
+	 * processing all pending commands. We'll wait for maximum 3 mins to
+	 * see if all outstanding commands are completed.
 	 */
-	iter = 0;
-	while( atomic_read(&adapter->pend_cmds) > 0 ) {
+
+	if (atomic_read(&adapter->pend_cmds) == 0)
+		return SUCCESS;
+
+	printk("megaraid: %d pending cmds; max wait %d seconds\n",
+		atomic_read(&adapter->pend_cmds), MBOX_RESET_WAIT );
+
+	for(i=0; (i<MBOX_RESET_WAIT)&&(atomic_read(&adapter->pend_cmds)); i++){
+
+		ASSERT( spin_is_locked(adapter->host_lock) );
+
 		/*
-		 * Perform the ack sequence, since interrupts are not
-		 * available right now!
+		 * Perform the ack sequence, since interrupts are unavailable
 		 */
 		if( adapter->flag & BOARD_MEMMAP ) {
 			megaraid_memmbox_ack_sequence(adapter);
@@ -2889,55 +2863,35 @@ megaraid_reset(Scsi_Cmnd *cmd)
 			megaraid_iombox_ack_sequence(adapter);
 		}
 
-		/*
-		 * print a message once every second only
-		 */
-		if( !(iter % 1000) ) {
-			printk(
-			"megaraid: Waiting for %d commands to flush: iter:%ld\n",
-				atomic_read(&adapter->pend_cmds), iter);
-		}
+		spin_unlock(adapter->host_lock);
 
-		if( iter++ < MBOX_RESET_SLEEP*1000 ) {
-			mdelay(1);
+		/* Print a message once every 5 seconds */
+		if (!(i % 5)) {
+			printk("megaraid: pending %d; remaining %d seconds\n",
+				atomic_read(&adapter->pend_cmds),
+				MBOX_RESET_WAIT - i);
 		}
-		else {
-			printk(KERN_WARNING
-				"megaraid: critical hardware error!\n");
 
-			rval = FAILED;
+		sleep_on_timeout(&wq, HZ);
 
-			break;
-		}
-	}
-
-	if( rval == SUCCESS ) {
-		printk(KERN_INFO
-			"megaraid: reset sequence successfully completed.\n");
+		spin_lock(adapter->host_lock);
 	}
 
-	return rval;
-}
-
+	/*
+	 * If after 3 mins there are still outstanding cmds, set the hw_error
+	 * flag so that we can return from subsequent ABORT/RESET handlers
+	 * without any processing
+	 */
 
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
+	rval = SUCCESS;
+	if (atomic_read(&adapter->pend_cmds)) {
 
+		adapter->hw_error = 1;
+		printk("megaraid: critical hardware error!\n" );
+		rval = FAILED;
+	}
 
-static inline void
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
-{
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
+	return rval;
 }
 
 
@@ -3988,6 +3942,7 @@ static int
 megaraid_reboot_notify (struct notifier_block *this, unsigned long code,
 		void *unused)
 {
+	DECLARE_WAIT_QUEUE_HEAD(wq);
 	adapter_t *adapter;
 	struct Scsi_Host *host;
 	u8 raw_mbox[sizeof(mbox_t)];
@@ -4040,10 +3995,10 @@ megaraid_reboot_notify (struct notifier_
 	printk(KERN_INFO "megaraid: cache flush delay:   ");
 	for( i = 9; i >= 0; i-- ) {
 		printk("\b\b\b[%d]", i);
-		mdelay(1000);
+		sleep_on_timeout(&wq, HZ);
 	}
 	printk("\b\b\b[done]\n");
-	mdelay(1000);
+	sleep_on_timeout(&wq, HZ);
 
 	return NOTIFY_DONE;
 }
@@ -4150,17 +4105,27 @@ megadev_open (struct inode *inode, struc
 }
 
 
-#ifdef LSI_CONFIG_COMPAT
+#if defined(__x86_64__)
 static int
 megadev_compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
 		struct file *filep)
 {
 	struct inode *inode = filep->f_dentry->d_inode;
 
-	return megadev_ioctl(inode, filep, cmd, arg);
+	return megadev_ioctl_entry(inode, filep, cmd, arg);
 }
 #endif
 
+static int
+megadev_ioctl_entry(struct inode *inode, struct file *filep, unsigned int cmd,
+		unsigned long arg)
+{
+	int rval;
+	down( &megaraid_ioc_mtx );
+	rval = megadev_ioctl( inode, filep, cmd, arg );
+	up( &megaraid_ioc_mtx );
+	return rval;
+}
 
 /**
  * megadev_ioctl()
@@ -4184,9 +4149,8 @@ megadev_ioctl(struct inode *inode, struc
 	int		rval;
 	mega_passthru	*upthru;	/* user address for passthru */
 	mega_passthru	*pthru;		/* copy user passthru here */
-	dma_addr_t	pthru_dma_hndl;
 	void		*data = NULL;	/* data to be transferred */
-	dma_addr_t	data_dma_hndl;	/* dma handle for data xfer area */
+	dma_addr_t	data_dma_hndl = 0;
 	megacmd_t	mc;
 	megastat_t	*ustats;
 	int		num_ldrv;
@@ -4302,7 +4266,7 @@ megadev_ioctl(struct inode *inode, struc
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
+		if( (adapno = GETADAP(uioc.adapno)) >= hba_count ) 
 			return (-ENODEV);
 
 		adapter = hba_soft_state[adapno];
@@ -4358,13 +4322,7 @@ megadev_ioctl(struct inode *inode, struc
 		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
 			/* Passthru commands */
 
-			pthru = pci_alloc_consistent(pdev,
-					sizeof(mega_passthru),
-					&pthru_dma_hndl);
-
-			if( pthru == NULL ) {
-				return (-ENOMEM);
-			}
+			pthru = adapter->int_pthru;
 
 			/*
 			 * The user passthru structure
@@ -4376,29 +4334,27 @@ megadev_ioctl(struct inode *inode, struc
 			 */
 			if( copy_from_user(pthru, (char *)upthru,
 						sizeof(mega_passthru)) ) {
-
-				pci_free_consistent(pdev,
-						sizeof(mega_passthru), pthru,
-						pthru_dma_hndl);
-
 				return (-EFAULT);
 			}
 
 			/*
-			 * Is there a data transfer
+			 * Is there a data transfer; If the data transfer
+			 * length is <= INT_MEMBLK_SZ, usr the buffer 
+			 * allocated at the load time. Otherwise, allocate it 
+			 * here.
 			 */
-			if( pthru->dataxferlen ) {
-				data = pci_alloc_consistent(pdev,
-						pthru->dataxferlen,
-						&data_dma_hndl);
-
-				if( data == NULL ) {
-					pci_free_consistent(pdev,
-							sizeof(mega_passthru),
-							pthru,
-							pthru_dma_hndl);
+			if (pthru->dataxferlen) {
+				if (pthru->dataxferlen > INT_MEMBLK_SZ) {
+					data = pci_alloc_consistent (
+							pdev,
+							pthru->dataxferlen,
+							&data_dma_hndl );
 
-					return (-ENOMEM);
+					if (data == NULL)
+						return (-ENOMEM);
+				}
+				else {
+					data = adapter->int_data;
 				}
 
 				/*
@@ -4406,7 +4362,11 @@ megadev_ioctl(struct inode *inode, struc
 				 * address at just allocated memory
 				 */
 				uxferaddr = pthru->dataxferaddr;
-				pthru->dataxferaddr = data_dma_hndl;
+				if (data_dma_hndl)
+					pthru->dataxferaddr = data_dma_hndl;
+				else
+					pthru->dataxferaddr = 
+						adapter->int_data_dma_hndl;
 			}
 
 
@@ -4421,14 +4381,14 @@ megadev_ioctl(struct inode *inode, struc
 						(char *)((ulong)uxferaddr),
 						pthru->dataxferlen) ) {
 					rval = (-EFAULT);
-					goto freemem_and_return;
+					goto freedata_and_return;
 				}
 			}
 
 			memset(&mc, 0, sizeof(megacmd_t));
 
 			mc.cmd = MEGA_MBOXCMD_PASSTHRU;
-			mc.xferaddr = (u32)pthru_dma_hndl;
+			mc.xferaddr = (u32)adapter->int_pthru_dma_hndl;
 
 			/*
 			 * Issue the command
@@ -4437,7 +4397,7 @@ megadev_ioctl(struct inode *inode, struc
 
 			rval = mega_n_to_m((void *)arg, &mc);
 
-			if( rval ) goto freemem_and_return;
+			if( rval ) goto freedata_and_return;
 
 
 			/*
@@ -4456,18 +4416,14 @@ megadev_ioctl(struct inode *inode, struc
 			 */
 			copy_to_user(upthru->reqsensearea,
 					pthru->reqsensearea, 14);
-
-freemem_and_return:
-			if( pthru->dataxferlen ) {
-				pci_free_consistent(pdev,
-						pthru->dataxferlen, data,
-						data_dma_hndl);
+freedata_and_return:
+			if (data_dma_hndl) {
+				pci_free_consistent( pdev, pthru->dataxferlen,
+							data, data_dma_hndl );
 			}
 
-			pci_free_consistent(pdev, sizeof(mega_passthru),
-					pthru, pthru_dma_hndl);
-
 			return rval;
+
 		}
 		else {
 			/* DCMD commands */
@@ -4476,13 +4432,18 @@ freemem_and_return:
 			 * Is there a data transfer
 			 */
 			if( uioc.xferlen ) {
-				data = pci_alloc_consistent(pdev,
-						uioc.xferlen, &data_dma_hndl);
+				if (uioc.xferlen > INT_MEMBLK_SZ) {
+					data = pci_alloc_consistent(
+							pdev,
+							uioc.xferlen,
+							&data_dma_hndl );
 
-				if( data == NULL ) {
-					return (-ENOMEM);
+					if (data == NULL)
+						return (-ENOMEM);
+				}
+				else {
+					data = adapter->int_data;
 				}
-
 				uxferaddr = MBOX(uioc)->xferaddr;
 			}
 
@@ -4497,9 +4458,9 @@ freemem_and_return:
 						(char *)((ulong)uxferaddr),
 						uioc.xferlen) ) {
 
-					pci_free_consistent(pdev,
-						uioc.xferlen, data,
-						data_dma_hndl);
+					pci_free_consistent(
+						pdev, uioc.xferlen,
+						data, data_dma_hndl );
 
 					return (-EFAULT);
 				}
@@ -4507,7 +4468,10 @@ freemem_and_return:
 
 			memcpy(&mc, MBOX(uioc), sizeof(megacmd_t));
 
-			mc.xferaddr = (u32)data_dma_hndl;
+			if (data_dma_hndl )
+				mc.xferaddr = (u32)data_dma_hndl;
+			else
+				mc.xferaddr = (u32)(adapter->int_data_dma_hndl);
 
 			/*
 			 * Issue the command
@@ -4517,12 +4481,10 @@ freemem_and_return:
 			rval = mega_n_to_m((void *)arg, &mc);
 
 			if( rval ) {
-				if( uioc.xferlen ) {
-					pci_free_consistent(pdev,
-							uioc.xferlen, data,
-							data_dma_hndl);
+				if (data_dma_hndl) {
+					pci_free_consistent( pdev, uioc.xferlen,
+							data, data_dma_hndl );
 				}
-
 				return rval;
 			}
 
@@ -4537,10 +4499,9 @@ freemem_and_return:
 				}
 			}
 
-			if( uioc.xferlen ) {
-				pci_free_consistent(pdev,
-						uioc.xferlen, data,
-						data_dma_hndl);
+			if (data_dma_hndl) {
+				pci_free_consistent( pdev, uioc.xferlen,
+							data, data_dma_hndl );
 			}
 
 			return rval;
@@ -4725,19 +4686,22 @@ mega_n_to_m(void *arg, megacmd_t *mc)
 	else {
 		uioc_mimd = (struct uioctl_t *)arg;
 
-		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) )
+		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) ) {
 			return (-EFAULT);
+		}
 
 		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {
 
 			umc = (megacmd_t *)uioc_mimd->mbox;
-			if (copy_from_user(&kmc, umc, sizeof(megacmd_t)))
+			if (copy_from_user(&kmc, umc, sizeof(megacmd_t))) {
 				return -EFAULT;
+			}
 
 			upthru = (mega_passthru *)((ulong)kmc.xferaddr);
 
-			if( put_user(mc->status, (u8 *)&upthru->scsistatus) )
+			if( put_user(mc->status, (u8 *)&upthru->scsistatus) ){
 				return (-EFAULT);
+			}
 		}
 	}
 
@@ -5150,6 +5114,54 @@ mega_support_cluster(adapter_t *adapter)
 
 
 /**
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
+
+/**
  * mega_reorder_hosts()
  *
  * Hack: reorder the scsi hosts in mid-layer so that the controller with the
@@ -5363,6 +5375,27 @@ mega_adapinq(adapter_t *adapter, dma_add
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
+
 /** mega_internal_dev_inquiry()
  * @adapter - pointer to our soft state
  * @ch - channel for this device
--- ./drivers/scsi/megaraid2.h.mr2	Wed Feb  2 08:27:20 2005
+++ ./drivers/scsi/megaraid2.h	Wed Feb  2 10:31:16 2005
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.10.3 (Release Date: Thu Apr  8 16:16:05 EDT 2004)\n"
+	"v2.10.8.2 (Release Date: Mon Jul 26 12:15:51 EDT 2004)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -82,6 +82,7 @@
 #define LSI_SUBSYS_VID			0x1000
 #define INTEL_SUBSYS_VID		0x8086
 #define FSC_SUBSYS_VID			0x1734
+#define ACER_SUBSYS_VID			0x1025
 
 #define HBA_SIGNATURE	      		0x3344
 #define HBA_SIGNATURE_471	  	0xCCCC
@@ -978,6 +979,15 @@ typedef struct {
 						 cmds */
 
 	int	has_cluster;	/* cluster support on this HBA */
+
+#define INT_MEMBLK_SZ		(28*1024)
+	mega_passthru		*int_pthru;		/*internal pthru*/
+	dma_addr_t		int_pthru_dma_hndl;
+	caddr_t			int_data;		/*internal data*/
+	dma_addr_t		int_data_dma_hndl;
+
+	int			hw_error;
+
 }adapter_t;
 
 
@@ -1085,18 +1095,21 @@ typedef enum { LOCK_INT, LOCK_EXT } lock
 
 #define MBOX_ABORT_SLEEP	60
 #define MBOX_RESET_SLEEP	30
+#define MBOX_RESET_WAIT		180
 
 const char *megaraid_info (struct Scsi_Host *);
 
 static int megaraid_detect(Scsi_Host_Template *);
 static void mega_find_card(Scsi_Host_Template *, u16, u16);
 static int mega_query_adapter(adapter_t *);
-static int issue_scb(adapter_t *, scb_t *);
+static inline int issue_scb(adapter_t *, scb_t *);
 static int mega_setup_mailbox(adapter_t *);
 
 static int megaraid_queue (Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
 static scb_t * mega_build_cmd(adapter_t *, Scsi_Cmnd *, int *);
+static inline scb_t *mega_allocate_scb(adapter_t *, Scsi_Cmnd *);
 static void __mega_runpendq(adapter_t *);
+static inline void mega_runpendq(adapter_t *);
 static int issue_scb_block(adapter_t *, u_char *);
 
 static void megaraid_isr_memmapped(int, void *, struct pt_regs *);
@@ -1113,8 +1126,9 @@ static int megaraid_reset(Scsi_Cmnd *);
 
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
 			      u32 *buffer, u32 *length);
+static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
-static void mega_cmd_done(adapter_t *, u8 [], int, int);
+static inline void mega_cmd_done(adapter_t *, u8 [], int, int);
 static inline void mega_free_sgl (adapter_t *adapter);
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);
@@ -1123,15 +1137,13 @@ static int megaraid_reboot_notify (struc
 				   unsigned long, void *);
 static int megadev_open (struct inode *, struct file *);
 
-#if defined(CONFIG_COMPAT) || defined( __x86_64__) || defined(IA32_EMULATION)
-#define LSI_CONFIG_COMPAT
-#endif
-
-#ifdef LSI_CONFIG_COMPAT
+#if defined(__x86_64__)
 static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned long,
 	struct file *);
 #endif
 
+static int megadev_ioctl_entry (struct inode *, struct file *, unsigned int,
+		unsigned long);
 static int megadev_ioctl (struct inode *, struct file *, unsigned int,
 		unsigned long);
 static int mega_m_to_n(void *, nitioctl_t *);
@@ -1164,6 +1176,8 @@ static int proc_rdrv(adapter_t *, char *
 
 static int mega_adapinq(adapter_t *, dma_addr_t);
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
+static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *);
+static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev *);
 static int mega_print_inquiry(char *, char *);
 #endif
 
@@ -1174,6 +1188,7 @@ static mega_ext_passthru* mega_prepare_e
 		scb_t *, Scsi_Cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
 static void mega_get_boot_drv(adapter_t *);
+static inline int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
 static int mega_support_random_del(adapter_t *);
 static int mega_del_logdrv(adapter_t *, int);
 static int mega_do_del_logdrv(adapter_t *, int);

--------------050809090306080803050803--

