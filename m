Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUK2M2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUK2M2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUK2M12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:27:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40722 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261698AbUK2M03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:29 -0500
Date: Mon, 29 Nov 2004 13:26:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Subject: [2.6 patch] misc drivers/block/cciss* cleanups
Message-ID: <20041129122627.GG9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes:
- make some needlessly global code static
- fold init_cciss_module into init_cciss (there's no need for two
  separate functions)
- remove the unused global function cciss_scsi_info


 drivers/block/cciss.c      |   18 +++++++-----------
 drivers/block/cciss_scsi.c |   35 ++++-------------------------------
 drivers/block/cciss_scsi.h |    1 -
 3 files changed, 11 insertions(+), 43 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss.c.old	2004-11-06 19:45:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss.c	2004-11-06 20:23:11.000000000 +0100
@@ -61,7 +61,7 @@
 #include <linux/cciss_ioctl.h>
 
 /* define the PCI info for the cards we can control */
-const struct pci_device_id cciss_pci_device_id[] = {
+static const struct pci_device_id cciss_pci_device_id[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
 			0x0E11, 0x4070, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
@@ -2908,21 +2908,17 @@
  *  This is it.  Register the PCI driver information for the cards we control
  *  the OS will call our registered routines when it finds one of our cards. 
  */
-int __init cciss_init(void)
+static int __init init_cciss(void)
 {
+	register_cciss_ioctl32();
+
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for our PCI devices */
 	return pci_module_init(&cciss_pci_driver);
 }
 
-static int __init init_cciss_module(void)
-{
-	register_cciss_ioctl32();
-	return ( cciss_init());
-}
-
-static void __exit cleanup_cciss_module(void)
+static void __exit cleanup_cciss(void)
 {
 	int i;
 
@@ -2941,5 +2937,5 @@
 	remove_proc_entry("cciss", proc_root_driver);
 }
 
-module_init(init_cciss_module);
-module_exit(cleanup_cciss_module);
+module_init(init_cciss);
+module_exit(cleanup_cciss);
--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.c.old	2004-11-06 19:48:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.c	2004-11-06 20:30:38.000000000 +0100
@@ -53,9 +53,7 @@
 	int cmd_type);
 
 
-const char *cciss_scsi_info(struct Scsi_Host *sa);
-
-int cciss_scsi_proc_info(
+static int cciss_scsi_proc_info(
 		struct Scsi_Host *sh,
 		char *buffer, /* data buffer */
 		char **start, 	   /* where data in buffer starts */
@@ -63,7 +61,7 @@
 		int length, 	   /* length of data in buffer */
 		int func);	   /* 0 == read, 1 == write */
 
-int cciss_scsi_queue_command (struct scsi_cmnd *cmd, 
+static int cciss_scsi_queue_command (struct scsi_cmnd *cmd, 
 		void (* done)(struct scsi_cmnd *));
 
 static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
@@ -712,8 +710,6 @@
 	return 1;
 }
 
-static void __exit cleanup_cciss_module(void);
-
 static void
 cciss_unmap_one(struct pci_dev *pdev,
 		CommandList_struct *cp,
@@ -1114,7 +1110,7 @@
 }
 
 
-int
+static int
 cciss_scsi_proc_info(struct Scsi_Host *sh,
 		char *buffer, /* data buffer */
 		char **start, 	   /* where data in buffer starts */
@@ -1149,29 +1145,6 @@
 			buffer, length);	
 } 
 
-/* this is via the generic proc support */
-const char *
-cciss_scsi_info(struct Scsi_Host *sa)
-{
-	static char buf[300];
-	ctlr_info_t *ci;
-
-	/* probably need to work on putting a bit more info in here... */
-	/* this is output via the /proc filesystem. */
-
-	ci = (ctlr_info_t *) sa->hostdata[0];
-
-	sprintf(buf, "%s %c%c%c%c\n",
-		ci->product_name, 
-		ci->firm_ver[0],
-		ci->firm_ver[1],
-		ci->firm_ver[2],
-		ci->firm_ver[3]);
-
-	return buf; 
-}
-
-
 /* cciss_scatter_gather takes a struct scsi_cmnd, (cmd), and does the pci 
    dma mapping  and fills in the scatter gather entries of the 
    cciss command, cp. */
@@ -1225,7 +1198,7 @@
 }
 
 
-int 
+static int 
 cciss_scsi_queue_command (struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
 	ctlr_info_t **c;
--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.h.old	2004-11-06 19:54:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.h	2004-11-06 19:54:41.000000000 +0100
@@ -39,7 +39,6 @@
 #define SCSI_CCISS_CAN_QUEUE 2
 
 /* 
-	info:           	cciss_scsi_info,		\
 
 Note, cmd_per_lun could give us some trouble, so I'm setting it very low.
 Likewise, SCSI_CCISS_CAN_QUEUE is set very conservatively.

