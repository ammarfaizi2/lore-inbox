Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWCZT2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCZT2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCZT2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:28:47 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:26584 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751483AbWCZT2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:28:46 -0500
Date: Sun, 26 Mar 2006 21:28:28 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having a SCSI ID is a generic SCSI property, therefore reading it should 
not be restricted to sg. The SCSI_IOCTL_GET_IDLUN from scsi is limited 
below the kernel data types, so it isn't an adequate replacement.

This patch moves SG_GET_SCSI_ID from sg to scsi while renaming it to
SCSI_IOCTL_GET_PCI. Additionally, I renamed struct sg_scsi_id to struct
scsi_ioctl_id, since it is no longer restricted to sg. The corresponding 
typedef will be gone.

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

---
This patch applies to 2.6.16. No structural change is made to the struct 
nor the IOCTL number, so userspace will continue to work properly.

Maybe this IOCTL should be extended to return the 64 bit LUN, but I wasn't
able to find out enough details to do the change within reasonable time.

diff -pruN -X dontdiff 2.6.15.ori/drivers/scsi/scsi_ioctl.c 2.6.15/drivers/scsi/scsi_ioctl.c
--- 2.6.15.ori/drivers/scsi/scsi_ioctl.c	2006-02-08 15:10:48.000000000 +0100
+++ 2.6.15/drivers/scsi/scsi_ioctl.c	2006-03-26 20:24:24.000000000 +0200
@@ -434,6 +434,27 @@ int scsi_ioctl(struct scsi_device *sdev,
 				     START_STOP_TIMEOUT, NORMAL_RETRIES);
         case SCSI_IOCTL_GET_PCI:
                 return scsi_ioctl_get_pci(sdev, arg);
+	case SG_GET_SCSI_ID:
+		if (!access_ok(VERIFY_WRITE, arg, sizeof (struct scsi_ioctl_id)))
+			return -EFAULT;
+		else {
+			struct scsi_ioctl_id __user *idp = arg;
+
+			__put_user((int) sdev->host->host_no,
+				   &idp->host_no);
+			__put_user((int) sdev->channel,
+				   &idp->channel);
+			__put_user((int) sdev->id, &idp->scsi_id);
+			__put_user((int) sdev->lun, &idp->lun);
+			__put_user((int) sdev->type, &idp->scsi_type);
+			__put_user((short) sdev->host->cmd_per_lun,
+				   &idp->h_cmd_per_lun);
+			__put_user((short) sdev->queue_depth,
+				   &idp->d_queue_depth);
+			__put_user(0, &idp->unused[0]);
+			__put_user(0, &idp->unused[1]);
+			return 0;
+		}
 	default:
 		if (sdev->host->hostt->ioctl)
 			return sdev->host->hostt->ioctl(sdev, cmd, arg);
diff -pruN -X dontdiff 2.6.15.ori/drivers/scsi/sg.c 2.6.15/drivers/scsi/sg.c
--- 2.6.15.ori/drivers/scsi/sg.c	2006-02-08 15:10:48.000000000 +0100
+++ 2.6.15/drivers/scsi/sg.c	2006-03-11 11:20:16.000000000 +0100
@@ -871,29 +871,6 @@ sg_ioctl(struct inode *inode, struct fil
 		return 0;
 	case SG_GET_LOW_DMA:
 		return put_user((int) sfp->low_dma, ip);
-	case SG_GET_SCSI_ID:
-		if (!access_ok(VERIFY_WRITE, p, sizeof (sg_scsi_id_t)))
-			return -EFAULT;
-		else {
-			sg_scsi_id_t __user *sg_idp = p;
-
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
 	case SG_SET_FORCE_PACK_ID:
 		result = get_user(val, ip);
 		if (result)
@@ -1071,6 +1048,7 @@ sg_ioctl(struct inode *inode, struct fil
 	case SCSI_IOCTL_GET_IDLUN:
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 	case SCSI_IOCTL_PROBE_HOST:
+	case SCSI_IOCTL_GET_ID:
 	case SG_GET_TRANSFORM:
 		if (sdp->detached)
 			return -ENODEV;
diff -pruN -X dontdiff 2.6.15.ori/include/scsi/scsi.h 2.6.15/include/scsi/scsi.h
--- 2.6.15.ori/include/scsi/scsi.h	2006-02-08 15:11:08.000000000 +0100
+++ 2.6.15/include/scsi/scsi.h	2006-03-26 20:36:54.000000000 +0200
@@ -245,6 +245,17 @@ struct scsi_lun {
 	__u8 scsi_lun[8];
 };
 
+struct scsi_ioctl_id { /* used by SCSI_IOCTL_GET_ID ioctl() */
+    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
+    int channel;
+    int scsi_id;        /* scsi id of target device */
+    int lun;
+    int scsi_type;      /* TYPE_... defined in scsi/scsi.h */
+    short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
+    short d_queue_depth;/* device (or adapter) maximum queue length */
+    int unused[2];      /* unused part should be zero */
+}; /* 32 bytes long on i386 */
+
 /*
  *  MESSAGE CODES
  */
@@ -427,4 +438,11 @@ struct scsi_lun {
 /* Used to obtain the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI		0x5387
 
+/* The following ioctl has a 'struct scsi_ioctl_id *' object as its 3rd argument. */
+/* 'struct scsi_ioctl_id' was renamed from 'sg_scsi_id_t'. */
+#define SCSI_IOCTL_GET_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
+#define SG_GET_SCSI_ID SCSI_IOCTL_GET_ID /* old name */
+/* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN, *
+ * but that is limited in range (/usurally/ no problem ...)            */
+
 #endif /* _SCSI_SCSI_H */
diff -pruN -X dontdiff 2.6.15.ori/include/scsi/sg.h 2.6.15/include/scsi/sg.h
--- 2.6.15.ori/include/scsi/sg.h	2005-06-17 21:48:29.000000000 +0200
+++ 2.6.15/include/scsi/sg.h	2006-03-11 12:10:14.000000000 +0100
@@ -155,18 +155,6 @@ typedef struct sg_io_hdr
 #define SG_INFO_DIRECT_IO 0x2   /* direct IO requested and performed */
 #define SG_INFO_MIXED_IO 0x4    /* part direct, part indirect IO */
 
-
-typedef struct sg_scsi_id { /* used by SG_GET_SCSI_ID ioctl() */
-    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
-    int channel;
-    int scsi_id;        /* scsi id of target device */
-    int lun;
-    int scsi_type;      /* TYPE_... defined in scsi/scsi.h */
-    short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
-    short d_queue_depth;/* device (or adapter) maximum queue length */
-    int unused[2];      /* probably find a good use, set 0 for now */
-} sg_scsi_id_t; /* 32 bytes long on i386 */
-
 typedef struct sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
     char req_state;     /* 0 -> not used, 1 -> written, 2 -> ready to read */
     char orphan;        /* 0 -> normal request, 1 -> from interruped SG_IO */
@@ -195,10 +183,6 @@ typedef struct sg_req_info { /* used by 
 #define SG_SET_RESERVED_SIZE 0x2275  /* request a new reserved buffer size */
 #define SG_GET_RESERVED_SIZE 0x2272  /* actual size of reserved buffer */
 
-/* The following ioctl has a 'sg_scsi_id_t *' object as its 3rd argument. */
-#define SG_GET_SCSI_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
-/* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN */
-
 /* Override host setting and always DMA using low memory ( <16MB on i386) */
 #define SG_SET_FORCE_LOW_DMA 0x2279  /* 0-> use adapter setting, 1-> force */
 #define SG_GET_LOW_DMA 0x227a   /* 0-> use all ram for dma; 1-> low dma ram */

-- 
as appealing as it might seem, it is impossible to patch or upgrade users
	-- Security Warrior
