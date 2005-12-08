Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVLHUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVLHUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVLHUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:15:27 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:51610 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932313AbVLHUP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:15:26 -0500
Date: Thu, 8 Dec 2005 14:15:18 -0600
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: axboe@suse.de, akpm@osdl.org, andrew.patterson@hp.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] cciss: adds MSI and MSI-X support
Message-ID: <20051208201518.GB29916@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 1
This patch creates a new function, cciss_interrupt_mode called from
cciss_pci_init. This function determines what type of interrupt vector
to use, i.e., MSI, MSI-X, or IO-APIC.
One noticeable difference is changing the interrupt field of the
controller struct to an array of 4 unsigned ints. The Smart Array HW
is capable of generating 4 distinct interrupts depending on the transport
method in use during operation. These are:

#define DOORBELL_INT 0
Used to notify the contoller of configuration updates. We only use
this feature when in polling mode.

#define PERF_MODE_INT 0
Used when the controller is in Performant Mode.

#define SIMPLE_MODE_INT 2
Used when the controller is in Simple Mode (current Linux implementation).

#define MEMQ_INT_MODE 3
Not used.

When using IO-APIC interrupts these 4 lines are OR'ed together so when
any one fires an interrupt an is generated. In MSI or MSI-X mode this
hardware OR'ing is ignored. We must register for our interrupt depending
on what mode the controller is running. For Linux we use SIMPLE_MODE_INT
exclusively at this time.
Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>
--------------------------------------------------------------------------------
 cciss.c      |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 cciss.h      |    8 +++++
 cciss_scsi.c |    2 -
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index e34104d..ede990f 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -166,7 +166,7 @@ static void cciss_geometry_inquiry(int c
 			unsigned int block_size, InquiryData_struct *inq_buff,
 			drive_info_struct *drv);
 static void cciss_getgeometry(int cntl_num);
-
+static void __devinit cciss_interrupt_mode(ctlr_info_t *, struct pci_dev *, __u32);
 static void start_io( ctlr_info_t *h);
 static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
 	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
@@ -282,7 +282,7 @@ static int cciss_proc_get_info(char *buf
                 h->product_name,
                 (unsigned long)h->board_id,
 		h->firm_ver[0], h->firm_ver[1], h->firm_ver[2], h->firm_ver[3],
-                (unsigned int)h->intr,
+                (unsigned int)h->intr[SIMPLE_MODE_INT],
                 h->num_luns, 
 		h->Qdepth, h->commands_outstanding,
 		h->maxQsinceinit, h->max_outstanding, h->maxSG);
@@ -2659,6 +2659,60 @@ static int find_PCI_BAR_index(struct pci
 	return -1;
 }
 
+/* If MSI/MSI-X is supported by the kernel we will try to enable it on
+ * controllers that are capable. If not, we use IO-APIC mode.
+ */
+
+static void __devinit cciss_interrupt_mode(ctlr_info_t *c, struct pci_dev *pdev, __u32 board_id)
+{
+#ifdef CONFIG_PCI_MSI
+        int err;
+        struct msix_entry cciss_msix_entries[4] = {{0,0}, {0,1},
+						   {0,2}, {0,3}};
+
+	/* Some boards advertise MSI but don't really support it */
+	if ((board_id == 0x40700E11) ||
+		(board_id == 0x40800E11) ||
+		(board_id == 0x40820E11) ||
+		(board_id == 0x40830E11))
+		goto default_int_mode;
+
+        if (pci_find_capability(pdev, PCI_CAP_ID_MSIX)) {
+                err = pci_enable_msix(pdev, cciss_msix_entries, 4);
+                if (!err) {
+                        c->intr[0] = cciss_msix_entries[0].vector;
+                        c->intr[1] = cciss_msix_entries[1].vector;
+                        c->intr[2] = cciss_msix_entries[2].vector;
+                        c->intr[3] = cciss_msix_entries[3].vector;
+                        c->msix_vector = 1;
+                        return;
+                }
+                if (err > 0) {
+                        printk(KERN_WARNING "cciss: only %d MSI-X vectors "
+                                        "available\n", err);
+                } else {
+                        printk(KERN_WARNING "cciss: MSI-X init failed %d\n",
+						err);
+                }
+        }
+        if (pci_find_capability(pdev, PCI_CAP_ID_MSI)) {
+                if (!pci_enable_msi(pdev)) {
+                        c->intr[SIMPLE_MODE_INT] = pdev->irq;
+                        c->msi_vector = 1;
+                        return;
+                } else {
+                        printk(KERN_WARNING "cciss: MSI init failed\n");
+        		c->intr[SIMPLE_MODE_INT] = pdev->irq;
+                        return;
+                }
+        }
+#endif /* CONFIG_PCI_MSI */
+	/* if we get here we're going to use the default interrupt mode */
+default_int_mode:
+        c->intr[SIMPLE_MODE_INT] = pdev->irq;
+	return;
+}
+
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort subsystem_vendor_id, subsystem_device_id, command;
@@ -2719,7 +2773,10 @@ static int cciss_pci_init(ctlr_info_t *c
 	printk("board_id = %x\n", board_id);
 #endif /* CCISS_DEBUG */ 
 
-	c->intr = pdev->irq;
+/* If the kernel supports MSI/MSI-X we will try to enable that functionality,
+ * else we use the IO-APIC interrupt assigned to us by system ROM.
+ */
+	cciss_interrupt_mode(c, pdev, board_id);
 
 	/*
 	 * Memory base addr is first addr , the second points to the config
@@ -3073,11 +3130,11 @@ static int __devinit cciss_init_one(stru
 
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
-	if( request_irq(hba[i]->intr, do_cciss_intr, 
+	if( request_irq(hba[i]->intr[SIMPLE_MODE_INT], do_cciss_intr, 
 		SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
 			hba[i]->devname, hba[i])) {
 		printk(KERN_ERR "cciss: Unable to get irq %d for %s\n",
-			hba[i]->intr, hba[i]->devname);
+			hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
 		goto clean2;
 	}
 	hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
@@ -3183,7 +3240,7 @@ clean4:
 			NR_CMDS * sizeof( ErrorInfo_struct),
 			hba[i]->errinfo_pool,
 			hba[i]->errinfo_pool_dhandle);
-	free_irq(hba[i]->intr, hba[i]);
+	free_irq(hba[i]->intr[SIMPLE_MODE_INT], hba[i]);
 clean2:
 	unregister_blkdev(hba[i]->major, hba[i]->devname);
 clean1:
@@ -3224,7 +3281,15 @@ static void __devexit cciss_remove_one (
 		printk(KERN_WARNING "Error Flushing cache on controller %d\n", 
 			i);
 	}
-	free_irq(hba[i]->intr, hba[i]);
+	free_irq(hba[i]->intr[2], hba[i]);
+
+#ifdef CONFIG_PCI_MSI
+        if (hba[i]->msix_vector)
+                pci_disable_msix(hba[i]->pdev);
+        else if (hba[i]->msi_vector)
+                pci_disable_msi(hba[i]->pdev);
+#endif /* CONFIG_PCI_MSI */
+
 	pci_set_drvdata(pdev, NULL);
 	iounmap(hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
diff --git a/drivers/block/cciss.h b/drivers/block/cciss.h
index 3b0858c..ad45e58 100644
--- a/drivers/block/cciss.h
+++ b/drivers/block/cciss.h
@@ -65,7 +65,6 @@ struct ctlr_info 
 	unsigned long io_mem_addr;
 	unsigned long io_mem_length;
 	CfgTable_struct __iomem *cfgtable;
-	unsigned int intr;
 	int	interrupts_enabled;
 	int	major;
 	int 	max_commands;
@@ -74,6 +73,13 @@ struct ctlr_info 
 	int	num_luns;
 	int 	highest_lun;
 	int	usage_count;  /* number of opens all all minor devices */
+#	define DOORBELL_INT	0
+#	define PERF_MODE_INT	1
+#	define SIMPLE_MODE_INT	2
+#	define MEMQ_MODE_INT	3
+	unsigned int intr[4];
+	unsigned int msix_vector;
+	unsigned int msi_vector;
 
 	// information about each logical volume
 	drive_info_struct drv[CISS_MAX_LUN];
diff --git a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
index 2942d32..9e35de0 100644
--- a/drivers/block/cciss_scsi.c
+++ b/drivers/block/cciss_scsi.c
@@ -714,7 +714,7 @@ cciss_scsi_detect(int ctlr)
 	((struct cciss_scsi_adapter_data_t *) 
 		hba[ctlr]->scsi_ctlr)->scsi_host = (void *) sh;
 	sh->hostdata[0] = (unsigned long) hba[ctlr];
-	sh->irq = hba[ctlr]->intr;
+	sh->irq = hba[ctlr]->intr[SIMPLE_MODE_INT];
 	sh->unique_id = sh->irq;
 	error = scsi_add_host(sh, &hba[ctlr]->pdev->dev);
 	if (error)
