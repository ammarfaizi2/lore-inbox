Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423479AbWJZNFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423479AbWJZNFA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423484AbWJZNE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:04:59 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:56417 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423479AbWJZNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:04:58 -0400
Date: Thu, 26 Oct 2006 15:04:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>
Subject: [patch 5/5] scsi: fix uaccess handling
Message-ID: <20061026130452.GF7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/scsi/scsi_ioctl.c |   17 +++++++++-------
 drivers/scsi/sg.c         |   47 ++++++++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/scsi/scsi_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_ioctl.c	2006-10-26 14:40:55.000000000 +0200
+++ linux-2.6/drivers/scsi/scsi_ioctl.c	2006-10-26 14:42:14.000000000 +0200
@@ -217,13 +217,16 @@
 		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
 			return -EFAULT;
 
-		__put_user((sdev->id & 0xff)
-			 + ((sdev->lun & 0xff) << 8)
-			 + ((sdev->channel & 0xff) << 16)
-			 + ((sdev->host->host_no & 0xff) << 24),
-			 &((struct scsi_idlun __user *)arg)->dev_id);
-		__put_user(sdev->host->unique_id,
-			 &((struct scsi_idlun __user *)arg)->host_unique_id);
+		if (__put_user((sdev->id & 0xff)
+			       + ((sdev->lun & 0xff) << 8)
+			       + ((sdev->channel & 0xff) << 16)
+			       + ((sdev->host->host_no & 0xff) << 24),
+			       &((struct scsi_idlun __user *)arg)->dev_id))
+			return -EFAULT;
+
+		if(__put_user(sdev->host->unique_id,
+			&((struct scsi_idlun __user *)arg)->host_unique_id))
+			return -EFAULT;
 		return 0;
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		return put_user(sdev->host->host_no, (int __user *)arg);
Index: linux-2.6/drivers/scsi/sg.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sg.c	2006-10-26 14:40:55.000000000 +0200
+++ linux-2.6/drivers/scsi/sg.c	2006-10-26 14:42:14.000000000 +0200
@@ -556,7 +556,8 @@
 		return -EDOM;
 	}
 	buf += SZ_SG_HEADER;
-	__get_user(opcode, buf);
+	if (__get_user(opcode, buf))
+		return -EFAULT;
 	if (sfp->next_cmd_len > 0) {
 		if (sfp->next_cmd_len > MAX_COMMAND_SIZE) {
 			SCSI_LOG_TIMEOUT(1, printk("sg_write: command length too long\n"));
@@ -779,6 +780,7 @@
 	Sg_fd *sfp;
 	Sg_request *srp;
 	unsigned long iflags;
+	sg_scsi_id_t __user *sg_idp;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
@@ -860,26 +862,25 @@
 	case SG_GET_SCSI_ID:
 		if (!access_ok(VERIFY_WRITE, p, sizeof (sg_scsi_id_t)))
 			return -EFAULT;
-		else {
-			sg_scsi_id_t __user *sg_idp = p;
+		sg_idp = p;
 
-			if (sdp->detached)
-				return -ENODEV;
-			__put_user((int) sdp->device->host->host_no,
-				   &sg_idp->host_no);
-			__put_user((int) sdp->device->channel,
-				   &sg_idp->channel);
-			__put_user((int) sdp->device->id, &sg_idp->scsi_id);
-			__put_user((int) sdp->device->lun, &sg_idp->lun);
-			__put_user((int) sdp->device->type, &sg_idp->scsi_type);
-			__put_user((short) sdp->device->host->cmd_per_lun,
-				   &sg_idp->h_cmd_per_lun);
-			__put_user((short) sdp->device->queue_depth,
-				   &sg_idp->d_queue_depth);
-			__put_user(0, &sg_idp->unused[0]);
-			__put_user(0, &sg_idp->unused[1]);
-			return 0;
-		}
+		if (sdp->detached)
+			return -ENODEV;
+		if (__put_user((int) sdp->device->host->host_no,
+			       &sg_idp->host_no) ||
+		    __put_user((int) sdp->device->channel,
+			       &sg_idp->channel) ||
+		    __put_user((int) sdp->device->id, &sg_idp->scsi_id) ||
+		    __put_user((int) sdp->device->lun, &sg_idp->lun) ||
+		    __put_user((int) sdp->device->type, &sg_idp->scsi_type) ||
+		    __put_user((short) sdp->device->host->cmd_per_lun,
+			       &sg_idp->h_cmd_per_lun) ||
+		    __put_user((short) sdp->device->queue_depth,
+			       &sg_idp->d_queue_depth) ||
+		    __put_user(0, &sg_idp->unused[0]) ||
+		    __put_user(0, &sg_idp->unused[1]))
+			return -EFAULT;
+		return 0;
 	case SG_SET_FORCE_PACK_ID:
 		result = get_user(val, ip);
 		if (result)
@@ -894,12 +895,14 @@
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
 				read_unlock_irqrestore(&sfp->rq_list_lock,
 						       iflags);
-				__put_user(srp->header.pack_id, ip);
+				if (__put_user(srp->header.pack_id, ip))
+					return -EFAULT;
 				return 0;
 			}
 		}
 		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-		__put_user(-1, ip);
+		if (__put_user(-1, ip))
+			return -EFAULT;
 		return 0;
 	case SG_GET_NUM_WAITING:
 		read_lock_irqsave(&sfp->rq_list_lock, iflags);
