Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271207AbRHTNse>; Mon, 20 Aug 2001 09:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271203AbRHTNsY>; Mon, 20 Aug 2001 09:48:24 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:15848 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271180AbRHTNsL>; Mon, 20 Aug 2001 09:48:11 -0400
Date: Mon, 20 Aug 2001 06:48:23 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: arrays@compaq.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.9/drivers/block/cpqarray.c to new module_{init,exit} interface
Message-ID: <20010820064823.A30153@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch moves linux-2.4.9/drivers/block/cpqarray.c
to the new module_{init,exit} interface and adds a pci_device_id table.
The advantages are as follows:

	1. The pci_device_id table facilitates automatic module loading
	   with the pcimodules program (or something similar).

	2. The user of module_{init,exit} removes the cpqarray reference
	   from drivers/block/genhd.c, a step toward eliminating the
	   genhd.c file.

	3. #1 and #2 are simplify upgrading cpqarray to the new PCI
	   driver format.

	arrays@compaq.com: Please examine these changes.  If they
meet with your approval, please forward them to Linus.

	Alan: please feel free to incorporate this patch into the
-ac kernels.  I have eliminated drivers/block/genhd.c by changing the
few remaining drivers to use module_{init,exit}.  If you would
like me send you all of the changes that implement that as a group
to you please let me know.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpqarray.diffs"

--- linux-2.4.9/drivers/block/cpqarray.c	Wed Jul 25 14:12:01 2001
+++ linux/drivers/block/cpqarray.c	Sun Aug 19 06:22:08 2001
@@ -49,6 +49,16 @@
 MODULE_AUTHOR("Compaq Computer Corporation");
 MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers");
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) && defined(MODULE)
+static struct pci_device_id cpqarray_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_DEC,    PCI_DEVICE_ID_COMPAQ_42XX,   PCI_ANY_ID, PCI_ANY_ID},
+  { PCI_VENDOR_ID_NCR,    PCI_DEVICE_ID_NCR_53C1510,   PCI_ANY_ID, PCI_ANY_ID},
+  { PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,PCI_ANY_ID, PCI_ANY_ID},
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, cpqarray_pci_tbl);
+#endif
+
 #define MAJOR_NR COMPAQ_SMART2_MAJOR
 #include <linux/blk.h>
 #include <linux/blkdev.h>
@@ -295,20 +305,18 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
-
 MODULE_PARM(eisa, "1-8i");
 EXPORT_NO_SYMBOLS;
 
 /* This is a bit of a hack... */
-int __init init_module(void)
+static int __init cpqarray_do_init(void)
 {
 	if (cpqarray_init() == 0) /* all the block dev numbers already used */
 		return -EIO;	  /* or no controllers were found */
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit cpqarray_exit(void)
 {
 	int i;
 	struct gendisk *g;
@@ -352,7 +360,6 @@
 	kfree(ida_hardsizes);
 	kfree(ida_blocksizes);
 }
-#endif /* MODULE */
 
 static inline int cpq_new_segment(request_queue_t *q, struct request *rq,
 				  int max_segments)
@@ -1918,3 +1925,6 @@
 	return;
 
 }
+
+module_init(cpqarray_do_init);
+module_exit(cpqarray_exit);
--- linux-2.4.9/drivers/block/genhd.c	Thu Jul 19 17:48:15 2001
+++ linux/drivers/block/genhd.c	Mon Aug 20 06:38:37 2001
@@ -29,7 +29,6 @@
 extern int soc_probe(void);
 extern int atmdev_init(void);
 extern int i2o_init(void);
-extern int cpqarray_init(void);
 
 int __init device_init(void)
 {
@@ -47,9 +46,6 @@
 #ifdef CONFIG_FC4_SOC
 	/* This has to be done before scsi_dev_init */
 	soc_probe();
-#endif
-#ifdef CONFIG_BLK_CPQ_DA
-	cpqarray_init();
 #endif
 #ifdef CONFIG_NET
 	net_dev_init();

--bg08WKrSYDhXBjb5--
