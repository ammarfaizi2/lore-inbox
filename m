Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULJAz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULJAz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbULJAz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:55:57 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5766 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261691AbULJAzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:55:24 -0500
Date: Thu, 9 Dec 2004 16:55:14 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [RFC PATCH] convert uhci-hcd to use debugfs
Message-ID: <20041210005514.GB17822@kroah.com>
References: <20041210005055.GA17822@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210005055.GA17822@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the uhci-hcd patch.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

thanks,

greg k-h


-----------------


diff -Nru a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
--- a/drivers/usb/host/uhci-debug.c	2004-12-09 16:32:17 -08:00
+++ b/drivers/usb/host/uhci-debug.c	2004-12-09 16:32:17 -08:00
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <linux/smp_lock.h>
 #include <asm/io.h>
 
@@ -507,7 +496,7 @@
 
 #define MAX_OUTPUT	(64 * 1024)
 
-static struct proc_dir_entry *uhci_proc_root = NULL;
+static struct dentry *uhci_debugfs_root = NULL;
 
 struct uhci_proc {
 	int size;
@@ -517,8 +506,7 @@
 
 static int uhci_proc_open(struct inode *inode, struct file *file)
 {
-	const struct proc_dir_entry *dp = PDE(inode);
-	struct uhci_hcd *uhci = dp->data;
+	struct uhci_hcd *uhci = inode->u.generic_ip;
 	struct uhci_proc *up;
 	int ret = -ENOMEM;
 
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2004-12-09 16:32:31 -08:00
+++ b/drivers/usb/host/uhci-hcd.c	2004-12-09 16:32:31 -08:00
@@ -46,7 +46,7 @@
 #include <linux/unistd.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
-#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <linux/pm.h>
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
@@ -1927,12 +1927,10 @@
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
@@ -1972,25 +1970,17 @@
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
+	dentry = debugfs_create_file(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_debugfs_root, uhci, &uhci_proc_operations);
+	if (!dentry) {
+		dev_err(uhci_dev(uhci), "couldn't create uhci debugfs entry\n");
 		retval = -ENOMEM;
 		goto err_create_proc_entry;
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
@@ -2192,13 +2182,10 @@
 	uhci->fl = NULL;
 
 err_alloc_fl:
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry(hcd->self.bus_name, uhci_proc_root);
-	uhci->proc_entry = NULL;
+	debugfs_remove(uhci->dentry);
+	uhci->dentry = NULL;
 
 err_create_proc_entry:
-#endif
-
 	return retval;
 }
 
@@ -2405,11 +2392,9 @@
 			goto errbuf_failed;
 	}
 
-#ifdef CONFIG_PROC_FS
-	uhci_proc_root = create_proc_entry("driver/uhci", S_IFDIR, NULL);
-	if (!uhci_proc_root)
+	uhci_debugfs_root = debugfs_create_dir("uhci", NULL);
+	if (!uhci_debugfs_root)
 		goto proc_failed;
-#endif
 
 	uhci_up_cachep = kmem_cache_create("uhci_urb_priv",
 		sizeof(struct urb_priv), 0, 0, NULL, NULL);
@@ -2427,12 +2412,9 @@
 		warn("not all urb_priv's were freed!");
 
 up_failed:
-
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("driver/uhci", NULL);
+	debugfs_remove(uhci_debugfs_root);
 
 proc_failed:
-#endif
 	if (errbuf)
 		kfree(errbuf);
 
@@ -2448,9 +2430,7 @@
 	if (kmem_cache_destroy(uhci_up_cachep))
 		warn("not all urb_priv's were freed!");
 
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("driver/uhci", NULL);
-#endif
+	debugfs_remove(uhci_debugfs_root);
 
 	if (errbuf)
 		kfree(errbuf);
diff -Nru a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
--- a/drivers/usb/host/uhci-hcd.h	2004-12-09 16:32:30 -08:00
+++ b/drivers/usb/host/uhci-hcd.h	2004-12-09 16:32:30 -08:00
@@ -326,10 +326,8 @@
 struct uhci_hcd {
 	struct usb_hcd hcd;		/* must come first! */
 
-#ifdef CONFIG_PROC_FS
-	/* procfs */
-	struct proc_dir_entry *proc_entry;
-#endif
+	/* debugfs */
+	struct dentry *dentry;
 
 	/* Grabbed from PCI */
 	unsigned long io_addr;

