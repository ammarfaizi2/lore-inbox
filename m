Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVAHJem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVAHJem (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVAHJdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:33:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:27525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261825AbVAHFsE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:04 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632594155@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <1105163259922@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.7, 2004/12/16 13:19:24-08:00, greg@kroah.com

USB: convert uhci-hcd driver to use debugfs.

Look, we saved 24 lines of code...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/uhci-debug.c |   36 +++++++++++--------------
 drivers/usb/host/uhci-hcd.c   |   60 ++++++++++++++----------------------------
 drivers/usb/host/uhci-hcd.h   |    6 +---
 3 files changed, 39 insertions(+), 63 deletions(-)


diff -Nru a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
--- a/drivers/usb/host/uhci-debug.c	2005-01-07 15:47:27 -08:00
+++ b/drivers/usb/host/uhci-debug.c	2005-01-07 15:47:27 -08:00
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <linux/smp_lock.h>
 #include <asm/io.h>
 
@@ -496,19 +496,18 @@
 
 #define MAX_OUTPUT	(64 * 1024)
 
-static struct proc_dir_entry *uhci_proc_root = NULL;
+static struct dentry *uhci_debugfs_root = NULL;
 
-struct uhci_proc {
+struct uhci_debug {
 	int size;
 	char *data;
 	struct uhci_hcd *uhci;
 };
 
-static int uhci_proc_open(struct inode *inode, struct file *file)
+static int uhci_debug_open(struct inode *inode, struct file *file)
 {
-	const struct proc_dir_entry *dp = PDE(inode);
-	struct uhci_hcd *uhci = dp->data;
-	struct uhci_proc *up;
+	struct uhci_hcd *uhci = inode->u.generic_ip;
+	struct uhci_debug *up;
 	int ret = -ENOMEM;
 
 	lock_kernel();
@@ -532,9 +531,9 @@
 	return ret;
 }
 
-static loff_t uhci_proc_lseek(struct file *file, loff_t off, int whence)
+static loff_t uhci_debug_lseek(struct file *file, loff_t off, int whence)
 {
-	struct uhci_proc *up;
+	struct uhci_debug *up;
 	loff_t new = -1;
 
 	lock_kernel();
@@ -556,16 +555,16 @@
 	return (file->f_pos = new);
 }
 
-static ssize_t uhci_proc_read(struct file *file, char __user *buf,
+static ssize_t uhci_debug_read(struct file *file, char __user *buf,
 				size_t nbytes, loff_t *ppos)
 {
-	struct uhci_proc *up = file->private_data;
+	struct uhci_debug *up = file->private_data;
 	return simple_read_from_buffer(buf, nbytes, ppos, up->data, up->size);
 }
 
-static int uhci_proc_release(struct inode *inode, struct file *file)
+static int uhci_debug_release(struct inode *inode, struct file *file)
 {
-	struct uhci_proc *up = file->private_data;
+	struct uhci_debug *up = file->private_data;
 
 	kfree(up->data);
 	kfree(up);
@@ -573,11 +572,10 @@
 	return 0;
 }
 
-static struct file_operations uhci_proc_operations = {
-	.open =		uhci_proc_open,
-	.llseek =	uhci_proc_lseek,
-	.read =		uhci_proc_read,
-//	write:		uhci_proc_write,
-	.release =	uhci_proc_release,
+static struct file_operations uhci_debug_operations = {
+	.open =		uhci_debug_open,
+	.llseek =	uhci_debug_lseek,
+	.read =		uhci_debug_read,
+	.release =	uhci_debug_release,
 };
 #endif
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2005-01-07 15:47:27 -08:00
+++ b/drivers/usb/host/uhci-hcd.c	2005-01-07 15:47:27 -08:00
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
@@ -2192,13 +2182,10 @@
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
 
@@ -2405,11 +2392,9 @@
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
@@ -2427,12 +2412,9 @@
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
--- a/drivers/usb/host/uhci-hcd.h	2005-01-07 15:47:27 -08:00
+++ b/drivers/usb/host/uhci-hcd.h	2005-01-07 15:47:27 -08:00
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

