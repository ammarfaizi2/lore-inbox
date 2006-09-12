Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWILLZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWILLZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWILLZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:25:53 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:32224 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965161AbWILLZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:25:52 -0400
Date: Tue, 12 Sep 2006 13:25:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, melissah@us.ibm.com
Subject: [S390] Linux API for writing z/VM APPLDATA Monitor records.
Message-ID: <20060912112550.GA2826@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Howland <melissah@us.ibm.com>

[S390] Linux API for writing z/VM APPLDATA Monitor records.

This patch delivers a new Linux API in the form of a misc char
device that is useable from user space and allows write access
to the z/VM APPLDATA Monitor Records collected by the *MONITOR 
System Service of z/VM.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig           |    1 
 drivers/s390/Kconfig          |    6 
 drivers/s390/char/Makefile    |    1 
 drivers/s390/char/monwriter.c |  288 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/Kbuild       |    2 
 include/asm-s390/monwriter.h  |   32 ++++
 6 files changed, 329 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-09-12 10:57:17.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2006-09-12 10:57:55.000000000 +0200
@@ -428,6 +428,7 @@ CONFIG_S390_TAPE_34XX=m
 # CONFIG_VMLOGRDR is not set
 # CONFIG_VMCP is not set
 # CONFIG_MONREADER is not set
+CONFIG_MONWRITER=m
 
 #
 # Cryptographic devices
diff -urpN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/Makefile	2006-09-12 10:57:55.000000000 +0200
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_TAPE) += tape.o tape_c
 obj-$(CONFIG_S390_TAPE_34XX) += tape_34xx.o
 obj-$(CONFIG_S390_TAPE_3590) += tape_3590.o
 obj-$(CONFIG_MONREADER) += monreader.o
+obj-$(CONFIG_MONWRITER) += monwriter.o
diff -urpN linux-2.6/drivers/s390/char/monwriter.c linux-2.6-patched/drivers/s390/char/monwriter.c
--- linux-2.6/drivers/s390/char/monwriter.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monwriter.c	2006-09-12 10:57:55.000000000 +0200
@@ -0,0 +1,288 @@
+/*
+ * drivers/s390/char/monwriter.c
+ *
+ * Character device driver for writing z/VM *MONITOR service records.
+ *
+ * Copyright (C) IBM Corp. 2006
+ *
+ * Author(s): Melissa Howland <Melissa.Howland@us.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/ctype.h>
+#include <linux/poll.h>
+#include <asm/uaccess.h>
+#include <asm/ebcdic.h>
+#include <asm/io.h>
+#include <asm/appldata.h>
+#include <asm/monwriter.h>
+
+#define MONWRITE_MAX_DATALEN	4024
+
+static int mon_max_bufs = 255;
+
+struct mon_buf {
+	struct list_head list;
+	struct monwrite_hdr hdr;
+	int diag_done;
+	char *data;
+};
+
+struct mon_private {
+	struct list_head list;
+	struct monwrite_hdr hdr;
+	size_t hdr_to_read;
+	size_t data_to_read;
+	struct mon_buf *current_buf;
+	int mon_buf_count;
+};
+
+/*
+ * helper functions
+ */
+
+static int monwrite_diag(struct monwrite_hdr *myhdr, char *buffer, int fcn)
+{
+	struct appldata_product_id id;
+	int rc;
+
+	strcpy(id.prod_nr, "LNXAPPL");
+	id.prod_fn = myhdr->applid;
+	id.record_nr = myhdr->record_num;
+	id.version_nr = myhdr->version;
+	id.release_nr = myhdr->release;
+	id.mod_lvl = myhdr->mod_level;
+	rc = appldata_asm(&id, fcn, (void *) buffer, myhdr->datalen);
+	if (rc <= 0)
+		return rc;
+	if (rc == 5)
+		return -EPERM;
+	printk("DIAG X'DC' error with return code: %i\n", rc);
+	return -EINVAL;
+}
+
+static inline struct mon_buf *monwrite_find_hdr(struct mon_private *monpriv,
+						struct monwrite_hdr *monhdr)
+{
+	struct mon_buf *entry, *next;
+
+	list_for_each_entry_safe(entry, next, &monpriv->list, list)
+		if (memcmp(&entry->hdr, monhdr, sizeof(entry->hdr)) == 0)
+			return entry;
+	return NULL;
+}
+
+static int monwrite_new_hdr(struct mon_private *monpriv)
+{
+	struct monwrite_hdr *monhdr = &monpriv->hdr;
+	struct mon_buf *monbuf;
+	int rc;
+
+	if (monhdr->datalen > MONWRITE_MAX_DATALEN ||
+	    monhdr->mon_function > MONWRITE_START_CONFIG ||
+	    monhdr->hdrlen != sizeof(struct monwrite_hdr))
+		return -EINVAL;
+
+	monbuf = monwrite_find_hdr(monpriv, monhdr);
+	if (monbuf) {
+		if (monhdr->mon_function == MONWRITE_STOP_INTERVAL) {
+			rc = monwrite_diag(monhdr, monbuf->data,
+					   APPLDATA_STOP_REC);
+			list_del(&monbuf->list);
+			monpriv->mon_buf_count--;
+			kfree(monbuf->data);
+			kfree(monbuf);
+			monbuf = NULL;
+		}
+	} else {
+		if (monpriv->mon_buf_count >= mon_max_bufs)
+			return -ENOSPC;
+		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
+		if (!monbuf)
+			return -ENOMEM;
+		monbuf->data = kzalloc(monbuf->hdr.datalen,
+				       GFP_KERNEL | GFP_DMA);
+		if (!monbuf->data) {
+			kfree(monbuf);
+			return -ENOMEM;
+		}
+		monbuf->hdr = *monhdr;
+		list_add_tail(&monbuf->list, &monpriv->list);
+		monpriv->mon_buf_count++;
+	}
+	monpriv->current_buf = monbuf;
+	return 0;
+}
+
+static int monwrite_new_data(struct mon_private *monpriv)
+{
+	struct monwrite_hdr *monhdr = &monpriv->hdr;
+	struct mon_buf *monbuf = monpriv->current_buf;
+	int rc = 0;
+
+	switch (monhdr->mon_function) {
+	case MONWRITE_START_INTERVAL:
+		if (!monbuf->diag_done) {
+			rc = monwrite_diag(monhdr, monbuf->data,
+					   APPLDATA_START_INTERVAL_REC);
+			monbuf->diag_done = 1;
+		}
+		break;
+	case MONWRITE_START_CONFIG:
+		if (!monbuf->diag_done) {
+			rc = monwrite_diag(monhdr, monbuf->data,
+					   APPLDATA_START_CONFIG_REC);
+			monbuf->diag_done = 1;
+		}
+		break;
+	case MONWRITE_GEN_EVENT:
+		rc = monwrite_diag(monhdr, monbuf->data,
+				   APPLDATA_GEN_EVENT_REC);
+		list_del(&monpriv->current_buf->list);
+		kfree(monpriv->current_buf->data);
+		kfree(monpriv->current_buf);
+		monpriv->current_buf = NULL;
+		break;
+	default:
+		/* monhdr->mon_function is checked in monwrite_new_hdr */
+		BUG();
+	}
+	return rc;
+}
+
+/*
+ * file operations
+ */
+
+static int monwrite_open(struct inode *inode, struct file *filp)
+{
+	struct mon_private *monpriv;
+
+	monpriv = kzalloc(sizeof(struct mon_private), GFP_KERNEL);
+	if (!monpriv)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&monpriv->list);
+	monpriv->hdr_to_read = sizeof(monpriv->hdr);
+	filp->private_data = monpriv;
+	return nonseekable_open(inode, filp);
+}
+
+static int monwrite_close(struct inode *inode, struct file *filp)
+{
+	struct mon_private *monpriv = filp->private_data;
+	struct mon_buf *entry, *next;
+
+	list_for_each_entry_safe(entry, next, &monpriv->list, list) {
+		if (entry->hdr.mon_function != MONWRITE_GEN_EVENT)
+			monwrite_diag(&entry->hdr, entry->data,
+				      APPLDATA_STOP_REC);
+		monpriv->mon_buf_count--;
+		list_del(&entry->list);
+		kfree(entry->data);
+		kfree(entry);
+	}
+	kfree(monpriv);
+	return 0;
+}
+
+static ssize_t monwrite_write(struct file *filp, const char __user *data,
+			      size_t count, loff_t *ppos)
+{
+	struct mon_private *monpriv = filp->private_data;
+	size_t len, written;
+	void *to;
+	int rc;
+
+	for (written = 0; written < count; ) {
+		if (monpriv->hdr_to_read) {
+			len = min(count - written, monpriv->hdr_to_read);
+			to = (char *) &monpriv->hdr +
+				sizeof(monpriv->hdr) - monpriv->hdr_to_read;
+			if (copy_from_user(to, data + written, len)) {
+				rc = -EFAULT;
+				goto out_error;
+			}
+			monpriv->hdr_to_read -= len;
+			written += len;
+			if (monpriv->hdr_to_read > 0)
+				continue;
+			rc = monwrite_new_hdr(monpriv);
+			if (rc)
+				goto out_error;
+			monpriv->data_to_read = monpriv->current_buf ?
+				monpriv->current_buf->hdr.datalen : 0;
+		}
+
+		if (monpriv->data_to_read) {
+			len = min(count - written, monpriv->data_to_read);
+			to = monpriv->current_buf->data +
+				monpriv->hdr.datalen - monpriv->data_to_read;
+			if (copy_from_user(to, data + written, len)) {
+				rc = -EFAULT;
+				goto out_error;
+			}
+			monpriv->data_to_read -= len;
+			written += len;
+			if (monpriv->data_to_read > 0)
+				continue;
+			rc = monwrite_new_data(monpriv);
+			if (rc)
+				goto out_error;
+		}
+		monpriv->hdr_to_read = sizeof(monpriv->hdr);
+	}
+	return written;
+
+out_error:
+	monpriv->data_to_read = 0;
+	monpriv->hdr_to_read = sizeof(struct monwrite_hdr);
+	return rc;
+}
+
+static struct file_operations monwrite_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = &monwrite_open,
+	.release = &monwrite_close,
+	.write	 = &monwrite_write,
+};
+
+static struct miscdevice mon_dev = {
+	.name	= "monwriter",
+	.fops	= &monwrite_fops,
+	.minor	= MISC_DYNAMIC_MINOR,
+};
+
+/*
+ * module init/exit
+ */
+
+static int __init mon_init(void)
+{
+	if (MACHINE_IS_VM)
+		return misc_register(&mon_dev);
+	else
+		return -ENODEV;
+}
+
+static void __exit mon_exit(void)
+{
+	WARN_ON(misc_deregister(&mon_dev) != 0);
+}
+
+module_init(mon_init);
+module_exit(mon_exit);
+
+module_param_named(max_bufs, mon_max_bufs, int, 0644);
+MODULE_PARM_DESC(max_bufs, "Maximum number of sample monitor data buffers"
+		 "that can be active at one time");
+
+MODULE_AUTHOR("Melissa Howland <Melissa.Howland@us.ibm.com>");
+MODULE_DESCRIPTION("Character device driver for writing z/VM "
+		   "APPLDATA monitor records.");
+MODULE_LICENSE("GPL");
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2006-09-12 10:57:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	2006-09-12 10:57:55.000000000 +0200
@@ -213,6 +213,12 @@ config MONREADER
 	help
 	  Character device driver for reading z/VM monitor service records
 
+config MONWRITER
+	tristate "API for writing z/VM monitor service records"
+	default "m"
+	help
+	  Character device driver for writing z/VM monitor service records
+
 endmenu
 
 menu "Cryptographic devices"
diff -urpN linux-2.6/include/asm-s390/Kbuild linux-2.6-patched/include/asm-s390/Kbuild
--- linux-2.6/include/asm-s390/Kbuild	2006-09-12 10:57:10.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/Kbuild	2006-09-12 10:57:55.000000000 +0200
@@ -1,4 +1,4 @@
 include include/asm-generic/Kbuild.asm
 
 unifdef-y += cmb.h debug.h
-header-y += dasd.h qeth.h tape390.h ucontext.h vtoc.h z90crypt.h
+header-y += dasd.h monwriter.h qeth.h tape390.h ucontext.h vtoc.h z90crypt.h
diff -urpN linux-2.6/include/asm-s390/monwriter.h linux-2.6-patched/include/asm-s390/monwriter.h
--- linux-2.6/include/asm-s390/monwriter.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/monwriter.h	2006-09-12 10:57:55.000000000 +0200
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2004, 2005 IBM Corporation
+ * Character device driver for writing z/VM APPLDATA monitor records
+ * Version 1.0
+ * Author(s): Melissa Howland <melissah@us.ibm.com>
+ *
+ */
+
+/* mon_function values */
+#define MONWRITE_START_INTERVAL	0x00 /* start interval recording */
+#define MONWRITE_STOP_INTERVAL	0x01 /* stop interval or config recording */
+#define MONWRITE_GEN_EVENT	0x02 /* generate event record */
+#define MONWRITE_START_CONFIG	0x03 /* start configuration recording */
+
+
+/* the header the app uses in its write() data */
+struct monwrite_hdr {
+	unsigned char mon_function;
+	unsigned short applid;
+	unsigned char record_num;
+	unsigned short version;
+	unsigned short release;
+	unsigned short mod_level;
+	unsigned short datalen;
+	unsigned char hdrlen;
+
+} __attribute__((packed));
+
+#define MON_MAX_BUFS		255
+#define MONWRITE_MAX_DATALEN	4024
+#define MON_HDRLEN		sizeof(struct monwrite_hdr)
+#define MON_HDRLEN_MIN		13
