Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVAHKuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVAHKuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVAHHuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:50:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:48517 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261873AbVAHFsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:19 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632602286@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632602446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.12, 2004/12/20 15:17:05-08:00, greg@kroah.com

Merge kroah.com:/home/greg/linux/BK/driver-2.6
into kroah.com:/home/greg/linux/BK/usb-2.6


 drivers/usb/host/uhci-hcd.c |   60 ++++++++++++++------------------------------
 drivers/usb/host/uhci-hcd.h |    6 +---
 2 files changed, 22 insertions(+), 44 deletions(-)


diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2005-01-07 15:42:36 -08:00
+++ b/drivers/usb/host/uhci-hcd.c	2005-01-07 15:42:36 -08:00
@@ -46,7 +46,7 @@
 #include <linux/unistd.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
-#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <linux/pm.h>
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
@@ -74,7 +74,7 @@
  * debug = 0, no debugging messages
  * debug = 1, dump failed URB's except for stalls
  * debug = 2, dump all failed URB's (including stalls)
- *            show all queues in /proc/driver/uhci/[pci_addr]
+ *            show all queues in /debug/uhci/[pci_addr]
  * debug = 3, show all TD's in URB's when dumping
  */
 #ifdef DEBUG
@@ -1929,12 +1929,10 @@
 		uhci->fl = NULL;
 	}
 
-#ifdef CONFIG_PROC_FS
-	if (uhci->proc_entry) {
-		remove_proc_entry(uhci->hcd.self.bus_name, uhci_proc_root);
-		uhci->proc_entry = NULL;
+	if (uhci->dentry) {
+		debugfs_remove(uhci->dentry);
+		uhci->dentry = NULL;
 	}
-#endif
 }
 
 static int uhci_reset(struct usb_hcd *hcd)
@@ -1974,25 +1972,17 @@
 	unsigned io_size;
 	dma_addr_t dma_handle;
 	struct usb_device *udev;
-#ifdef CONFIG_PROC_FS
-	struct proc_dir_entry *ent;
-#endif
+	struct dentry *dentry;
 
 	io_size = pci_resource_len(to_pci_dev(uhci_dev(uhci)), hcd->region);
 
-#ifdef CONFIG_PROC_FS
-	ent = create_proc_entry(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_proc_root);
-	if (!ent) {
-		dev_err(uhci_dev(uhci), "couldn't create uhci proc entry\n");
+	dentry = debugfs_create_file(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_debugfs_root, uhci, &uhci_debug_operations);
+	if (!dentry) {
+		dev_err(uhci_dev(uhci), "couldn't create uhci debugfs entry\n");
 		retval = -ENOMEM;
-		goto err_create_proc_entry;
+		goto err_create_debug_entry;
 	}
-
-	ent->data = uhci;
-	ent->proc_fops = &uhci_proc_operations;
-	ent->size = 0;
-	uhci->proc_entry = ent;
-#endif
+	uhci->dentry = dentry;
 
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
@@ -2194,13 +2184,10 @@
 	uhci->fl = NULL;
 
 err_alloc_fl:
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry(hcd->self.bus_name, uhci_proc_root);
-	uhci->proc_entry = NULL;
-
-err_create_proc_entry:
-#endif
+	debugfs_remove(uhci->dentry);
+	uhci->dentry = NULL;
 
+err_create_debug_entry:
 	return retval;
 }
 
@@ -2363,11 +2350,9 @@
 			goto errbuf_failed;
 	}
 
-#ifdef CONFIG_PROC_FS
-	uhci_proc_root = create_proc_entry("driver/uhci", S_IFDIR, NULL);
-	if (!uhci_proc_root)
-		goto proc_failed;
-#endif
+	uhci_debugfs_root = debugfs_create_dir("uhci", NULL);
+	if (!uhci_debugfs_root)
+		goto debug_failed;
 
 	uhci_up_cachep = kmem_cache_create("uhci_urb_priv",
 		sizeof(struct urb_priv), 0, 0, NULL, NULL);
@@ -2385,12 +2370,9 @@
 		warn("not all urb_priv's were freed!");
 
 up_failed:
+	debugfs_remove(uhci_debugfs_root);
 
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("driver/uhci", NULL);
-
-proc_failed:
-#endif
+debug_failed:
 	if (errbuf)
 		kfree(errbuf);
 
@@ -2406,9 +2388,7 @@
 	if (kmem_cache_destroy(uhci_up_cachep))
 		warn("not all urb_priv's were freed!");
 
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("driver/uhci", NULL);
-#endif
+	debugfs_remove(uhci_debugfs_root);
 
 	if (errbuf)
 		kfree(errbuf);
diff -Nru a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
--- a/drivers/usb/host/uhci-hcd.h	2005-01-07 15:42:36 -08:00
+++ b/drivers/usb/host/uhci-hcd.h	2005-01-07 15:42:36 -08:00
@@ -322,10 +322,8 @@
  */
 struct uhci_hcd {
 
-#ifdef CONFIG_PROC_FS
-	/* procfs */
-	struct proc_dir_entry *proc_entry;
-#endif
+	/* debugfs */
+	struct dentry *dentry;
 
 	/* Grabbed from PCI */
 	unsigned long io_addr;

