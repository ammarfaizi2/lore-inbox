Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752377AbWCFLD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbWCFLD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWCFLDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:03:25 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:22731 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750730AbWCFLDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:03:25 -0500
Date: Mon, 6 Mar 2006 12:03:17 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <Pine.LNX.4.58.0603061133070.2997@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest moving the SG_GET_SCSI_ID ioctl from sg to scsi, since it's 
generally usefull and the alternative function SCSI_IOCTL_GET_IDLUN
is limited in range (in-kernel data types may be larger) and 
functionality (type, ...).

However, I have some questions about that ioctl:

- There is the concept of 8-Byte-LUNs: Are they mapped to integer LUNs?
Should the extra space in the struct sg_scsi_id be used for that?
Or should I abandon the idea and create a new IOCTL instead?

- The original IOCTL will check for sdp->detached. If the moved-to-scsi 
ioctl is called, the check will be done before chaining from sg, but what
will I need to check if it's called on a non-sg device?

- Are there any (planned) changes that will conflict with this patch?


Proof-of-concept-hack (unclean):

diff -pru -x dontdiff 2.6.15.ori/drivers/scsi/scsi_ioctl.c 2.6.15/drivers/scsi/scsi_ioctl.c
--- 2.6.15.ori/drivers/scsi/scsi_ioctl.c	2006-02-08 15:10:48.000000000 +0100
+++ 2.6.15/drivers/scsi/scsi_ioctl.c	2006-03-04 21:24:13.000000000 +0100
@@ -434,6 +434,31 @@ int scsi_ioctl(struct scsi_device *sdev,
 				     START_STOP_TIMEOUT, NORMAL_RETRIES);
         case SCSI_IOCTL_GET_PCI:
                 return scsi_ioctl_get_pci(sdev, arg);
+	case SG_GET_SCSI_ID:
+		if (!access_ok(VERIFY_WRITE, arg, sizeof (sg_scsi_id_t)))
+			return -EFAULT;
+		else {
+			sg_scsi_id_t __user *sg_idp = arg;
+
+//			if (sdp->detached)
+//				return -ENODEV;
+//			is the above covered by !sdev ath the
+//			beginning of this function?
+			__put_user((int) sdev->host->host_no,
+				   &sg_idp->host_no);
+			__put_user((int) sdev->channel,
+				   &sg_idp->channel);
+			__put_user((int) sdev->id, &sg_idp->scsi_id);
+			__put_user((int) sdev->lun, &sg_idp->lun);
+			__put_user((int) sdev->type, &sg_idp->scsi_type);
+			__put_user((short) sdev->host->cmd_per_lun,
+				   &sg_idp->h_cmd_per_lun);
+			__put_user((short) sdev->queue_depth,
+				   &sg_idp->d_queue_depth);
+			__put_user(0, &sg_idp->unused[0]);
+			__put_user(0, &sg_idp->unused[1]);
+			return 0;
+		}
 	default:
 		if (sdev->host->hostt->ioctl)
 			return sdev->host->hostt->ioctl(sdev, cmd, arg);
diff -pru -x dontdiff 2.6.15.ori/drivers/scsi/sg.c 2.6.15/drivers/scsi/sg.c
--- 2.6.15.ori/drivers/scsi/sg.c	2006-02-08 15:10:48.000000000 +0100
+++ 2.6.15/drivers/scsi/sg.c	2006-03-04 22:15:15.000000000 +0100
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
@@ -1072,6 +1049,7 @@ sg_ioctl(struct inode *inode, struct fil
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 	case SCSI_IOCTL_PROBE_HOST:
 	case SG_GET_TRANSFORM:
+	case SG_GET_SCSI_ID:
 		if (sdp->detached)
 			return -ENODEV;
 		return scsi_ioctl(sdp->device, cmd_in, p);
diff -pru -x dontdiff 2.6.15.ori/include/scsi/scsi.h 2.6.15/include/scsi/scsi.h
--- 2.6.15.ori/include/scsi/scsi.h	2006-02-08 15:11:08.000000000 +0100
+++ 2.6.15/include/scsi/scsi.h	2006-03-04 11:11:31.000000000 +0100
@@ -245,6 +245,21 @@ struct scsi_lun {
 	__u8 scsi_lun[8];
 };
 
+// copyed to scsi.h, so don't typedef it twice:
+#ifndef sg_scsi_id_t
+typedef struct sg_scsi_id { /* used by SG_GET_SCSI_ID ioctl() */
+    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
+    int channel;
+    int scsi_id;        /* scsi id of target device */
+    int lun;
+    int scsi_type;      /* TYPE_... defined in scsi/scsi.h */
+    short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
+    short d_queue_depth;/* device (or adapter) maximum queue length */
+    int unused[2];      /* probably find a good use, set 0 for now */
+} sg_scsi_id_t; /* 32 bytes long on i386 */
+#define sg_scsi_id_t sg_scsi_id_t
+#endif
+
 /*
  *  MESSAGE CODES
  */
diff -pru -x dontdiff 2.6.15.ori/include/scsi/sg.h 2.6.15/include/scsi/sg.h
--- 2.6.15.ori/include/scsi/sg.h	2005-06-17 21:48:29.000000000 +0200
+++ 2.6.15/include/scsi/sg.h	2006-03-04 11:11:30.000000000 +0100
@@ -156,6 +156,8 @@ typedef struct sg_io_hdr
 #define SG_INFO_MIXED_IO 0x4    /* part direct, part indirect IO */
 
 
+// copyed to scsi.h, so don't typedef it twice:
+#ifndef sg_scsi_id_t
 typedef struct sg_scsi_id { /* used by SG_GET_SCSI_ID ioctl() */
     int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
     int channel;
@@ -166,6 +168,8 @@ typedef struct sg_scsi_id { /* used by S
     short d_queue_depth;/* device (or adapter) maximum queue length */
     int unused[2];      /* probably find a good use, set 0 for now */
 } sg_scsi_id_t; /* 32 bytes long on i386 */
+#define sg_scsi_id_t sg_scsi_id_t
+#endif
 
 typedef struct sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
     char req_state;     /* 0 -> not used, 1 -> written, 2 -> ready to read */
@@ -196,8 +200,11 @@ typedef struct sg_req_info { /* used by 
 #define SG_GET_RESERVED_SIZE 0x2272  /* actual size of reserved buffer */
 
 /* The following ioctl has a 'sg_scsi_id_t *' object as its 3rd argument. */
+#ifndef SG_GET_SCSI_ID
 #define SG_GET_SCSI_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
-/* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN */
+#endif
+/* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN, *
+ * but that is limited in range (/usurally/ no problem ...)            */
 
 /* Override host setting and always DMA using low memory ( <16MB on i386) */
 #define SG_SET_FORCE_LOW_DMA 0x2279  /* 0-> use adapter setting, 1-> force */
