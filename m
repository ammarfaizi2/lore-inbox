Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVA2NoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVA2NoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVA2Nle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:41:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11788 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262915AbVA2Nib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:38:31 -0500
Date: Sat, 29 Jan 2005 14:38:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mike.miller@hp.com
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/cciss*: misc cleanups
Message-ID: <20050129133825.GY28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlesly global code static
- cciss_scsi.c: remove the unused global function cciss_scsi_info
- cciss.c:
  - init_cciss_module -> cciss_init
  - cleanup_cciss_module -> cciss_cleanup

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/cciss.c      |   15 +++++----------
 drivers/block/cciss_scsi.c |   35 ++++-------------------------------
 drivers/block/cciss_scsi.h |    1 -
 3 files changed, 9 insertions(+), 42 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/block/cciss_scsi.h.old	2005-01-29 13:50:28.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/cciss_scsi.h	2005-01-29 13:51:05.000000000 +0100
@@ -39,7 +39,6 @@
 #define SCSI_CCISS_CAN_QUEUE 2
 
 /* 
-	info:           	cciss_scsi_info,		\
 
 Note, cmd_per_lun could give us some trouble, so I'm setting it very low.
 Likewise, SCSI_CCISS_CAN_QUEUE is set very conservatively.
--- linux-2.6.11-rc2-mm1-full/drivers/block/cciss_scsi.c.old	2005-01-29 13:50:40.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/cciss_scsi.c	2005-01-29 13:51:05.000000000 +0100
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
--- linux-2.6.11-rc2-mm1-full/drivers/block/cciss.c.old	2005-01-29 13:50:55.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/cciss.c	2005-01-29 14:25:31.000000000 +0100
@@ -61,7 +61,7 @@
 #include <linux/cciss_ioctl.h>
 
 /* define the PCI info for the cards we can control */
-const struct pci_device_id cciss_pci_device_id[] = {
+static const struct pci_device_id cciss_pci_device_id[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
 			0x0E11, 0x4070, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
@@ -2878,7 +2878,7 @@
  *  This is it.  Register the PCI driver information for the cards we control
  *  the OS will call our registered routines when it finds one of our cards. 
  */
-int __init cciss_init(void)
+static int __init cciss_init(void)
 {
 	printk(KERN_INFO DRIVER_NAME "\n");
 
@@ -2886,12 +2886,7 @@
 	return pci_module_init(&cciss_pci_driver);
 }
 
-static int __init init_cciss_module(void)
-{
-	return ( cciss_init());
-}
-
-static void __exit cleanup_cciss_module(void)
+static void __exit cciss_cleanup(void)
 {
 	int i;
 
@@ -2909,5 +2904,5 @@
 	remove_proc_entry("cciss", proc_root_driver);
 }
 
-module_init(init_cciss_module);
-module_exit(cleanup_cciss_module);
+module_init(cciss_init);
+module_exit(cciss_cleanup);

