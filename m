Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUGJAui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUGJAui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUGJAui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:50:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37870 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266038AbUGJAtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:49:31 -0400
Date: Sat, 10 Jul 2004 02:49:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-megaraid-devel@dell.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [2.6 patch] SCSI megaraid: fix inlines
Message-ID: <20040710004916.GW28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/scsi/megaraid.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/scsi/megaraid.o
drivers/scsi/megaraid.c: In function `megaraid_queue':
drivers/scsi/megaraid.h:1000: sorry, unimplemented: inlining failed in call to 'mega_runpendq': function body not available
drivers/scsi/megaraid.c:379: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/megaraid.o] Error 1

<--  snip  -->


The patch below fixes these issues by:
- removing some inlines
- moving some functions
- replacing free_local_pdev() with calls to kfree()


diffstat output:
 drivers/scsi/megaraid.c |  320 +++++++++++++++++++---------------------
 drivers/scsi/megaraid.h |    7 
 2 files changed, 161 insertions(+), 166 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/scsi/megaraid.h.old	2004-07-10 02:33:28.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/scsi/megaraid.h	2004-07-10 02:40:31.000000000 +0200
@@ -990,7 +990,7 @@
 const char *megaraid_info (struct Scsi_Host *);
 
 static int mega_query_adapter(adapter_t *);
-static inline int issue_scb(adapter_t *, scb_t *);
+static int issue_scb(adapter_t *, scb_t *);
 static int mega_setup_mailbox(adapter_t *);
 
 static int megaraid_queue (Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
@@ -1017,7 +1017,7 @@
 static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
 static void mega_rundoneq (adapter_t *);
-static inline void mega_cmd_done(adapter_t *, u8 [], int, int);
+static void mega_cmd_done(adapter_t *, u8 [], int, int);
 static inline void mega_free_sgl (adapter_t *adapter);
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);
@@ -1056,7 +1056,6 @@
 static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *);
 static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev *);
 static inline int make_local_pdev(adapter_t *, struct pci_dev **);
-static inline void free_local_pdev(struct pci_dev *);
 
 static int mega_support_ext_cdb(adapter_t *);
 static mega_passthru* mega_prepare_passthru(adapter_t *, scb_t *,
@@ -1065,7 +1064,7 @@
 		scb_t *, Scsi_Cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
 static void mega_get_boot_drv(adapter_t *);
-static inline int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
+static int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
 static int mega_support_random_del(adapter_t *);
 static int mega_del_logdrv(adapter_t *, int);
 static int mega_do_del_logdrv(adapter_t *, int);
--- linux-2.6.7-mm7-full-gcc3.4/drivers/scsi/megaraid.c.old	2004-07-10 02:29:23.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/scsi/megaraid.c	2004-07-10 02:42:30.000000000 +0200
@@ -336,6 +336,42 @@
 }
 
 
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
 /*
  * megaraid_queue()
  * @scmd - Issue this scsi command
@@ -386,6 +422,38 @@
 
 
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
  * mega_build_cmd()
  * @adapter - pointer to our soft state
  * @cmd - Prepare using this scsi command
@@ -968,73 +1036,6 @@
 
 
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
  * issue_scb()
  * @adapter - pointer to our soft state
  * @scb - scsi control block
@@ -1043,7 +1044,7 @@
  * busy. We also take the scb from the pending list if the mailbox is
  * available.
  */
-static inline int
+static int
 issue_scb(adapter_t *adapter, scb_t *scb)
 {
 	volatile mbox64_t	*mbox64 = adapter->mbox64;
@@ -1105,6 +1106,31 @@
 }
 
 
+/*
+ * Wait until the controller's mailbox is available
+ */
+static inline int
+mega_busywait_mbox (adapter_t *adapter)
+{
+	if (adapter->mbox->m_in.busy)
+		return __mega_busywait_mbox(adapter);
+	return 0;
+}
+
+static int
+__mega_busywait_mbox (adapter_t *adapter)
+{
+	volatile mbox_t *mbox = adapter->mbox;
+	long counter;
+
+	for (counter = 0; counter < 10000; counter++) {
+		if (!mbox->m_in.busy)
+			return 0;
+		udelay(100); yield();
+	}
+	return -1;		/* give up after 1 second */
+}
+
 /**
  * issue_scb_block()
  * @adapter - pointer to our soft state
@@ -1350,7 +1376,7 @@
  *
  * Complete the comamnds and call the scsi mid-layer callback hooks.
  */
-static inline void
+static void
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 {
 	mega_ext_passthru	*epthru = NULL;
@@ -1672,31 +1698,6 @@
 
 
 /*
- * Wait until the controller's mailbox is available
- */
-static inline int
-mega_busywait_mbox (adapter_t *adapter)
-{
-	if (adapter->mbox->m_in.busy)
-		return __mega_busywait_mbox(adapter);
-	return 0;
-}
-
-static int
-__mega_busywait_mbox (adapter_t *adapter)
-{
-	volatile mbox_t *mbox = adapter->mbox;
-	long counter;
-
-	for (counter = 0; counter < 10000; counter++) {
-		if (!mbox->m_in.busy)
-			return 0;
-		udelay(100); yield();
-	}
-	return -1;		/* give up after 1 second */
-}
-
-/*
  * Copies data to SGLIST
  * Note: For 64 bit cards, we need a minimum of one SG element for read/write
  */
@@ -2285,6 +2286,45 @@
 }
 
 
+static inline int
+make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
+{
+	*pdev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
+
+	if( *pdev == NULL ) return -1;
+
+	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));
+
+	if( pci_set_dma_mask(*pdev, 0xffffffff) != 0 ) {
+		kfree(*pdev);
+		return -1;
+	}
+
+	return 0;
+}
+
+
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
 /**
  * proc_rebuild_rate()
  * @page - buffer to write the data in
@@ -2312,7 +2352,7 @@
 	}
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
-		free_local_pdev(pdev);
+		kfree(pdev);
 		*eof = 1;
 		return len;
 	}
@@ -2325,7 +2365,7 @@
 
 		mega_free_inquiry(inquiry, dma_handle, pdev);
 
-		free_local_pdev(pdev);
+		kfree(pdev);
 
 		*eof = 1;
 
@@ -2345,7 +2385,7 @@
 
 	mega_free_inquiry(inquiry, dma_handle, pdev);
 
-	free_local_pdev(pdev);
+	kfree(pdev);
 
 	*eof = 1;
 
@@ -2382,7 +2422,7 @@
 	}
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
-		free_local_pdev(pdev);
+		kfree(pdev);
 		*eof = 1;
 		return len;
 	}
@@ -2395,7 +2435,7 @@
 
 		mega_free_inquiry(inquiry, dma_handle, pdev);
 
-		free_local_pdev(pdev);
+		kfree(pdev);
 
 		*eof = 1;
 
@@ -2444,7 +2484,7 @@
 
 	mega_free_inquiry(inquiry, dma_handle, pdev);
 
-	free_local_pdev(pdev);
+	kfree(pdev);
 
 	*eof = 1;
 
@@ -2674,7 +2714,7 @@
 free_inquiry:
 	mega_free_inquiry(inquiry, dma_handle, pdev);
 free_pdev:
-	free_local_pdev(pdev);
+	kfree(pdev);
 
 	return len;
 }
@@ -2849,7 +2889,7 @@
 	}
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
-		free_local_pdev(pdev);
+		kfree(pdev);
 		return len;
 	}
 
@@ -2861,7 +2901,7 @@
 
 		mega_free_inquiry(inquiry, dma_handle, pdev);
 
-		free_local_pdev(pdev);
+		kfree(pdev);
 
 		return len;
 	}
@@ -2893,7 +2933,7 @@
 
 		mega_free_inquiry(inquiry, dma_handle, pdev);
 
-		free_local_pdev(pdev);
+		kfree(pdev);
 
 		return len;
 	}
@@ -2913,7 +2953,7 @@
 			pci_free_consistent(pdev, array_sz, disk_array,
 					disk_array_dma_handle);
 
-			free_local_pdev(pdev);
+			kfree(pdev);
 
 			return len;
 		}
@@ -2938,7 +2978,7 @@
 						disk_array,
 						disk_array_dma_handle);
 
-				free_local_pdev(pdev);
+				kfree(pdev);
 
 				return len;
 			}
@@ -3064,7 +3104,7 @@
 	pci_free_consistent(pdev, array_sz, disk_array,
 			disk_array_dma_handle);
 
-	free_local_pdev(pdev);
+	kfree(pdev);
 
 	return len;
 }
@@ -3451,7 +3491,7 @@
 					&pthru_dma_hndl);
 
 			if( pthru == NULL ) {
-				free_local_pdev(pdev);
+				kfree(pdev);
 				return (-ENOMEM);
 			}
 
@@ -3470,7 +3510,7 @@
 						sizeof(mega_passthru), pthru,
 						pthru_dma_hndl);
 
-				free_local_pdev(pdev);
+				kfree(pdev);
 
 				return (-EFAULT);
 			}
@@ -3489,7 +3529,7 @@
 							pthru,
 							pthru_dma_hndl);
 
-					free_local_pdev(pdev);
+					kfree(pdev);
 
 					return (-ENOMEM);
 				}
@@ -3559,7 +3599,7 @@
 			pci_free_consistent(pdev, sizeof(mega_passthru),
 					pthru, pthru_dma_hndl);
 
-			free_local_pdev(pdev);
+			kfree(pdev);
 
 			return rval;
 		}
@@ -3574,7 +3614,7 @@
 						uioc.xferlen, &data_dma_hndl);
 
 				if( data == NULL ) {
-					free_local_pdev(pdev);
+					kfree(pdev);
 					return (-ENOMEM);
 				}
 
@@ -3595,7 +3635,7 @@
 							uioc.xferlen,
 							data, data_dma_hndl);
 
-					free_local_pdev(pdev);
+					kfree(pdev);
 
 					return (-EFAULT);
 				}
@@ -3619,7 +3659,7 @@
 							data_dma_hndl);
 				}
 
-				free_local_pdev(pdev);
+				kfree(pdev);
 
 				return rval;
 			}
@@ -3641,7 +3681,7 @@
 						data_dma_hndl);
 			}
 
-			free_local_pdev(pdev);
+			kfree(pdev);
 
 			return rval;
 		}
@@ -4243,7 +4283,7 @@
  * Calculate the logical drive number based on the information in scsi command
  * and the channel number.
  */
-static inline int
+static int
 mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)
 {
 	int		tgt;
@@ -4329,27 +4369,6 @@
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
-	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), dma_handle);
-}
-
-
-static inline void
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
-{
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
-}
-
-
 /** mega_internal_dev_inquiry()
  * @adapter - pointer to our soft state
  * @ch - channel for this device
@@ -4379,7 +4398,7 @@
 			&pthru_dma_handle);
 
 	if( pthru == NULL ) {
-		free_local_pdev(pdev);
+		kfree(pdev);
 		return -1;
 	}
 
@@ -4415,7 +4434,7 @@
 	pci_free_consistent(pdev, sizeof(mega_passthru), pthru,
 			pthru_dma_handle);
 
-	free_local_pdev(pdev);
+	kfree(pdev);
 
 	return rval;
 }
@@ -4550,29 +4569,6 @@
 }
 
 
-static inline int
-make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
-{
-	*pdev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
-
-	if( *pdev == NULL ) return -1;
-
-	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));
-
-	if( pci_set_dma_mask(*pdev, 0xffffffff) != 0 ) {
-		kfree(*pdev);
-		return -1;
-	}
-
-	return 0;
-}
-
-static inline void
-free_local_pdev(struct pci_dev *pdev)
-{
-	kfree(pdev);
-}
-
 static struct scsi_host_template megaraid_template = {
 	.module				= THIS_MODULE,
 	.name				= "MegaRAID",


