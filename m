Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUH3Qjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUH3Qjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUH3Qjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:39:48 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:20485 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268536AbUH3QiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:38:21 -0400
Date: Mon, 30 Aug 2004 11:31:11 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-Id: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [patch] libata: add ioctls to support SMART
Cc: jgarzik@pobox.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
supporting SMART w/ unmodified smartctl and smartd userland binaries.

Not happy w/ loop after failed ata_qc_new_init(), but needed because smartctl
and smartd did not retry after failure.  Likely need an option to wait for
available qc?  Also not sure all the error return codes are correct...

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-core.c |  179 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   11 ++
 drivers/scsi/libata.h      |    4 +
 3 files changed, 194 insertions(+)

diff -urNp linux-2.6.orig/drivers/scsi/libata-core.c linux-2.6/drivers/scsi/libata-core.c
--- linux-2.6.orig/drivers/scsi/libata-core.c	2004-08-30 09:48:23.000000000 -0400
+++ linux-2.6/drivers/scsi/libata-core.c	2004-08-30 12:10:38.000000000 -0400
@@ -41,12 +41,15 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/hdreg.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
 #include "libata.h"
 
+#define SECTOR_SIZE	512
+
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
@@ -2897,6 +2900,182 @@ err_out:
 	ata_qc_complete(qc, ATA_ERR);
 }
 
+/**
+ *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ */
+
+int ata_task_ioctl(struct ata_port *ap, struct ata_device *dev,
+		   void __user *arg)
+{
+	unsigned long flags;
+	int rc;
+	int err = 0;
+	u8 status;
+	u8 args[7], *argbuf = args;
+	int argsize = sizeof(args);
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (!ata_dev_present(dev))
+		return -ENODEV;
+
+	if (copy_from_user(argbuf, arg, argsize))
+		return -EFAULT;
+
+	/* Execute command... */
+	qc = ata_qc_new_init(ap, dev);
+#if 0
+	BUG_ON(qc == NULL);
+#else /* I know this is wrong, still thinking on what else to do... */
+	while (qc == NULL) {
+		msleep(150);
+		qc = ata_qc_new_init(ap, dev);
+	}
+#endif
+
+	qc->tf.protocol = ATA_PROT_NODATA;
+	qc->tf.feature = args[1];
+	qc->tf.nsect = args[2];
+	qc->tf.lbal = args[3];
+	qc->tf.lbam = args[4];
+	qc->tf.lbah = args[5];
+	qc->tf.command = args[0];
+	qc->tf.flags |= ATA_TFLAG_ISADDR;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc) {
+		err = -EIO; /* right rc? */
+		goto error;
+	}
+	else
+		wait_for_completion(&wait);
+
+	status = ata_chk_status(ap);
+	if (!ata_ok(status)) {
+		err = -EIO;
+		goto error;
+	}
+
+	if (copy_to_user(arg, argbuf, argsize))
+		err = -EFAULT;
+
+error:
+	return err;
+}
+
+/**
+ *	ata_task_ioctl - Handler for HDIO_DRIVE_CMD ioctl
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ */
+
+int ata_cmd_ioctl(struct ata_port *ap, struct ata_device *dev,
+		  void __user *arg)
+{
+	unsigned long flags;
+	int rc;
+	int err = 0;
+	u8 status;
+	u8 args[4], *argbuf = args;
+	int argsize = sizeof(args);
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (!ata_dev_present(dev))
+		return -ENODEV;
+
+	if (copy_from_user(args, arg, argsize))
+		return -EFAULT;
+
+	/* Execute command... */
+	qc = ata_qc_new_init(ap, dev);
+#if 0
+	BUG_ON(qc == NULL);
+#else /* I know this is wrong, still thinking on what else to do... */
+	while (qc == NULL) {
+		msleep(150);
+		qc = ata_qc_new_init(ap, dev);
+	}
+#endif
+
+	if (args[3]) {
+		argsize = sizeof(args) + (SECTOR_SIZE * args[3]);
+		argbuf = kmalloc(argsize, GFP_KERNEL);
+		if (argbuf == NULL)
+			return -ENOMEM;
+		memcpy(argbuf, args, sizeof(args)); /* is this necessary? */
+
+		ata_sg_init_one(qc, (argbuf + sizeof(args)),
+				(argsize - sizeof(args)));
+
+		qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+		qc->tf.protocol = ATA_PROT_PIO;
+	} else {
+		qc->tf.protocol = ATA_PROT_NODATA;
+	}
+
+	qc->nsect = args[3];
+	qc->tf.feature = args[2];
+	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
+		qc->tf.nsect = args[3];
+		qc->tf.lbal = args[1];
+		qc->tf.lbam = 0x4f;
+		qc->tf.lbah = 0xc2;
+	} else {
+		qc->tf.nsect = args[1];
+	}
+	qc->tf.command = args[0];
+	qc->tf.flags |= ATA_TFLAG_ISADDR;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc) {
+		err = -EIO; /* right rc? */
+		goto error;
+	}
+	else
+		wait_for_completion(&wait);
+
+	status = ata_chk_status(ap);
+	if (!ata_ok(status)) {
+		err = -EIO;
+		goto error;
+	}
+
+	if (copy_to_user((void *)arg, argbuf, argsize))
+		err = -EFAULT;
+error:
+	if (argsize > sizeof(args))
+		kfree(argbuf);
+
+	return err;
+}
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct pci_dev *pdev = ap->host_set->pdev;
diff -urNp linux-2.6.orig/drivers/scsi/libata.h linux-2.6/drivers/scsi/libata.h
--- linux-2.6.orig/drivers/scsi/libata.h	2004-08-30 09:49:09.000000000 -0400
+++ linux-2.6/drivers/scsi/libata.h	2004-08-30 09:59:12.000000000 -0400
@@ -43,6 +43,10 @@ extern void ata_dev_select(struct ata_po
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_task_ioctl(struct ata_port *ap, struct ata_device *dev,
+			  void __user *arg);
+extern int ata_cmd_ioctl(struct ata_port *ap, struct ata_device *dev,
+			 void __user *arg);
 
 
 /* libata-scsi.c */
diff -urNp linux-2.6.orig/drivers/scsi/libata-scsi.c linux-2.6/drivers/scsi/libata-scsi.c
--- linux-2.6.orig/drivers/scsi/libata-scsi.c	2004-08-30 09:49:50.000000000 -0400
+++ linux-2.6/drivers/scsi/libata-scsi.c	2004-08-30 09:59:12.000000000 -0400
@@ -29,6 +29,7 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/hdreg.h>
 #include <asm/uaccess.h>
 
 #include "libata.h"
@@ -99,6 +100,16 @@ int ata_scsi_ioctl(struct scsi_device *s
 			return -EINVAL;
 		return 0;
 
+	case HDIO_DRIVE_CMD:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_cmd_ioctl(ap, dev, arg);
+
+	case HDIO_DRIVE_TASK:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_task_ioctl(ap, dev, arg);
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;
