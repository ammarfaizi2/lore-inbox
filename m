Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVCJFk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVCJFk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVCJFh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:37:27 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:59922 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262449AbVCIWZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:25:52 -0500
Date: Wed, 9 Mar 2005 16:25:58 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] cciss: support for more than 8 controllers
Message-ID: <20050309222558.GB32723@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for more than 8 controllers. If we run out of preallocated major numbers we dynamically allocate more.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |   36 +++++++++++++++++++++++++++---------
 cciss.h |    3 +++
 2 files changed, 30 insertions(+), 9 deletions(-)
-------------------------------------------------------------------------------
diff -burNp lx2611-p001/drivers/block/cciss.c lx2611-p002/drivers/block/cciss.c
--- lx2611-p001/drivers/block/cciss.c	2005-03-08 16:39:01.650427392 -0600
+++ lx2611-p002/drivers/block/cciss.c	2005-03-08 16:50:47.149175280 -0600
@@ -120,7 +120,11 @@ static struct board_type products[] = {
 
 #define READ_AHEAD 	 1024
 #define NR_CMDS		 384 /* #commands that can be outstanding */
-#define MAX_CTLR 8
+#define MAX_CTLR	32 
+
+/* Originally cciss driver only supports 8 major numbers */
+#define MAX_CTLR_ORIG 	8
+
 
 #define CCISS_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
 
@@ -2650,7 +2654,7 @@ static int alloc_cciss_hba(void)
 		}
 	}
 	printk(KERN_WARNING "cciss: This driver supports a maximum"
-		" of 8 controllers.\n");
+		" of %d controllers.\n", MAX_CTLR);
 	goto out;
 Enomem:
 	printk(KERN_ERR "cciss: out of memory.\n");
@@ -2682,13 +2686,14 @@ static int __devinit cciss_init_one(stru
 	request_queue_t *q;
 	int i;
 	int j;
+	int rc;
 
 	printk(KERN_DEBUG "cciss: Device 0x%x has been found at"
 			" bus %d dev %d func %d\n",
 		pdev->device, pdev->bus->number, PCI_SLOT(pdev->devfn),
 			PCI_FUNC(pdev->devfn));
 	i = alloc_cciss_hba();
-	if( i < 0 ) 
+	if(i < 0) 
 		return (-1);
 	if (cciss_pci_init(hba[i], pdev) != 0)
 		goto clean1;
@@ -2707,11 +2712,24 @@ static int __devinit cciss_init_one(stru
 		goto clean1;
 	}
 
-	if (register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname)) {
-		printk(KERN_ERR "cciss: Unable to register device %s\n",
-				hba[i]->devname);
+	/* 
+	 * register with the major number, or get a dynamic major number
+	 * by passing 0 as argument.  This is done for greater than
+	 * 8 controller support.
+	 */
+	if (i < MAX_CTLR_ORIG)
+		hba[i]->major = MAJOR_NR + i;
+	rc = register_blkdev(hba[i]->major, hba[i]->devname);
+	if(rc == -EBUSY || rc == -EINVAL) {
+		printk(KERN_ERR
+			"cciss:  Unable to get major number %d for %s "
+			"on hba %d\n", hba[i]->major, hba[i]->devname, i);
 		goto clean1;
 	}
+	else {
+		if (i >= MAX_CTLR_ORIG)
+			hba[i]->major = rc;
+	}
 
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
@@ -2782,7 +2800,7 @@ static int __devinit cciss_init_one(stru
 
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
 		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
-		disk->major = COMPAQ_CISS_MAJOR + i;
+		disk->major = hba[i]->major;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
 		disk->queue = hba[i]->queue;
@@ -2811,7 +2829,7 @@ clean4:
 			hba[i]->errinfo_pool_dhandle);
 	free_irq(hba[i]->intr, hba[i]);
 clean2:
-	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
+	unregister_blkdev(hba[i]->major, hba[i]->devname);
 clean1:
 	release_io_mem(hba[i]);
 	free_hba(i);
@@ -2853,7 +2871,7 @@ static void __devexit cciss_remove_one (
 	pci_set_drvdata(pdev, NULL);
 	iounmap(hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
-	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
+	unregister_blkdev(hba[i]->major, hba[i]->devname);
 	remove_proc_entry(hba[i]->devname, proc_cciss);	
 	
 	/* remove it from the disk list */
diff -burNp lx2611-p001/drivers/block/cciss.h lx2611-p002/drivers/block/cciss.h
--- lx2611-p001/drivers/block/cciss.h	2004-12-24 15:33:48.000000000 -0600
+++ lx2611-p002/drivers/block/cciss.h	2005-03-08 16:50:47.150175128 -0600
@@ -13,6 +13,8 @@
 #define IO_OK		0
 #define IO_ERROR	1
 
+#define MAJOR_NR COMPAQ_CISS_MAJOR
+
 struct ctlr_info;
 typedef struct ctlr_info ctlr_info_t;
 
@@ -50,6 +52,7 @@ struct ctlr_info 
 	CfgTable_struct __iomem *cfgtable;
 	unsigned int intr;
 	int	interrupts_enabled;
+	int	major;
 	int 	max_commands;
 	int	commands_outstanding;
 	int 	max_outstanding; /* Debug */ 
