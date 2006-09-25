Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWIYJRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWIYJRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIYJRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:17:15 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:30909 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750763AbWIYJRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:17:14 -0400
Subject: [PATCH] Handcrafted MIN/MAX removal
From: Amol Lad <amol@verismonetworks.com>
To: kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:50:31 +0530
Message-Id: <1159176031.25016.44.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending to lkml also

Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
macros are changed to use macros in kernel.h

Tested for allmodconfig

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 drivers/isdn/hardware/eicon/debug.c    |    4 +--
 drivers/isdn/hardware/eicon/di.c       |    8 +++----
 drivers/isdn/hardware/eicon/io.c       |    2 -
 drivers/isdn/hardware/eicon/istream.c  |    4 +--
 drivers/isdn/hardware/eicon/platform.h |    8 -------
 drivers/scsi/aic7xxx/aic79xx.h         |    8 -------
 drivers/scsi/aic7xxx/aic79xx_core.c    |   22 ++++++++++-----------
 drivers/scsi/aic7xxx/aic79xx_osm.c     |    6 ++---
 drivers/scsi/aic7xxx/aic7xxx.h         |    8 -------
 drivers/scsi/aic7xxx/aic7xxx_core.c    |   18 ++++++++---------
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |    4 +--
 fs/xfs/xfs_btree.h                     |   34 +++++++++------------------------
 fs/xfs/xfs_rtalloc.c                   |   20 +++++++++----------
 fs/xfs/xfs_rtalloc.h                   |    3 --
 14 files changed, 54 insertions(+), 95 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/isdn/hardware/eicon/debug.c linux-2.6.18/drivers/isdn/hardware/eicon/debug.c
--- linux-2.6.18-orig/drivers/isdn/hardware/eicon/debug.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/isdn/hardware/eicon/debug.c	2006-09-25 14:43:22.000000000 +0530
@@ -756,14 +756,14 @@ int diva_get_driver_info (dword id, byte
 
     data_length -= 9;
 
-    if ((to_copy = MIN(strlen(clients[id].drvName), data_length-1))) {
+    if ((to_copy = min(strlen(clients[id].drvName), (size_t)(data_length-1)))) {
       memcpy (p, clients[id].drvName, to_copy);
       p += to_copy;
       data_length -= to_copy;
       if ((data_length >= 4) && clients[id].hDbg->drvTag[0]) {
         *p++ = '(';
         data_length -= 1;
-        if ((to_copy = MIN(strlen(clients[id].hDbg->drvTag), data_length-2))) {
+        if ((to_copy = min(strlen(clients[id].hDbg->drvTag), (size_t)(data_length-2)))) {
           memcpy (p, clients[id].hDbg->drvTag, to_copy);
           p += to_copy;
           data_length -= to_copy;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/isdn/hardware/eicon/di.c linux-2.6.18/drivers/isdn/hardware/eicon/di.c
--- linux-2.6.18-orig/drivers/isdn/hardware/eicon/di.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/isdn/hardware/eicon/di.c	2006-09-25 14:43:22.000000000 +0530
@@ -133,7 +133,7 @@ void pr_out(ADAPTER * a)
     i = this->XCurrent;
     X = PTR_X(a,this);
     while(i<this->XNum && length<270) {
-      clength = MIN((word)(270-length),X[i].PLength-this->XOffset);
+      clength = min((word)(270-length),(word)(X[i].PLength-this->XOffset));
       a->ram_out_buffer(a,
                         &ReqOut->XBuffer.P[length],
                         PTR_P(a,this,&X[i].P[this->XOffset]),
@@ -622,7 +622,7 @@ byte isdn_ind(ADAPTER * a,
                                                      sizeof(a->stream_buffer),
                                                      &final, NULL, NULL);
         }
-        IoAdapter->RBuffer.length = MIN(MLength, 270);
+        IoAdapter->RBuffer.length = min(MLength, (word)270);
         if (IoAdapter->RBuffer.length != MLength) {
           this->complete = 0;
         } else {
@@ -676,9 +676,9 @@ byte isdn_ind(ADAPTER * a,
         this->RCurrent++;
       }
       if (cma) {
-        clength = MIN(MLength, R[this->RCurrent].PLength-this->ROffset);
+        clength = min(MLength, (word)(R[this->RCurrent].PLength-this->ROffset));
       } else {
-        clength = MIN(a->ram_inw(a, &RBuffer->length)-offset,
+        clength = min(a->ram_inw(a, &RBuffer->length)-offset,
                       R[this->RCurrent].PLength-this->ROffset);
       }
       if(R[this->RCurrent].P) {
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/isdn/hardware/eicon/io.c linux-2.6.18/drivers/isdn/hardware/eicon/io.c
--- linux-2.6.18-orig/drivers/isdn/hardware/eicon/io.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/isdn/hardware/eicon/io.c	2006-09-25 14:43:22.000000000 +0530
@@ -262,7 +262,7 @@ void request(PISDN_ADAPTER IoAdapter, EN
     case IDI_SYNC_REQ_XDI_GET_CAPI_PARAMS: {
        diva_xdi_get_capi_parameters_t prms, *pI = &syncReq->xdi_capi_prms.info;
        memset (&prms, 0x00, sizeof(prms));
-       prms.structure_length = MIN(sizeof(prms), pI->structure_length);
+       prms.structure_length = min(sizeof(prms), pI->structure_length);
        memset (pI, 0x00, pI->structure_length);
        prms.flag_dynamic_l1_down    = (IoAdapter->capi_cfg.cfg_1 & \
          DIVA_XDI_CAPI_CFG_1_DYNAMIC_L1_ON) ? 1 : 0;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/isdn/hardware/eicon/istream.c linux-2.6.18/drivers/isdn/hardware/eicon/istream.c
--- linux-2.6.18-orig/drivers/isdn/hardware/eicon/istream.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/isdn/hardware/eicon/istream.c	2006-09-25 14:43:22.000000000 +0530
@@ -92,7 +92,7 @@ int diva_istream_write (void* context,
     return (-1); /* was not able to write       */
    break;     /* only part of message was written */
   }
-  to_write = MIN(length, DIVA_DFIFO_DATA_SZ);
+  to_write = min(length, DIVA_DFIFO_DATA_SZ);
   if (to_write) {
    a->ram_out_buffer (a,
 #ifdef PLATFORM_GT_32BIT
@@ -176,7 +176,7 @@ int diva_istream_read (void* context,
     return (-1); /* was not able to read */
    break;
   }
-  to_read = MIN(max_length, tmp[1]);
+  to_read = min(max_length, (int)tmp[1]);
   if (to_read) {
    a->ram_in_buffer(a,
 #ifdef PLATFORM_GT_32BIT
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/isdn/hardware/eicon/platform.h linux-2.6.18/drivers/isdn/hardware/eicon/platform.h
--- linux-2.6.18-orig/drivers/isdn/hardware/eicon/platform.h	2006-09-21 10:15:33.000000000 +0530
+++ linux-2.6.18/drivers/isdn/hardware/eicon/platform.h	2006-09-25 14:43:22.000000000 +0530
@@ -83,14 +83,6 @@
 #define	NULL	((void *) 0)
 #endif
 
-#ifndef	MIN
-#define MIN(a,b)	((a)>(b) ? (b) : (a))
-#endif
-
-#ifndef	MAX
-#define MAX(a,b)	((a)>(b) ? (a) : (b))
-#endif
-
 #ifndef	far
 #define far
 #endif
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.18/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx_core.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic79xx_core.c	2006-09-25 14:43:22.000000000 +0530
@@ -2850,14 +2850,14 @@ ahd_devlimited_syncrate(struct ahd_softc
 		transinfo = &tinfo->goal;
 	*ppr_options &= (transinfo->ppr_options|MSG_EXT_PPR_PCOMP_EN);
 	if (transinfo->width == MSG_EXT_WDTR_BUS_8_BIT) {
-		maxsync = MAX(maxsync, AHD_SYNCRATE_ULTRA2);
+		maxsync = max(maxsync, (u_int)AHD_SYNCRATE_ULTRA2);
 		*ppr_options &= ~MSG_EXT_PPR_DT_REQ;
 	}
 	if (transinfo->period == 0) {
 		*period = 0;
 		*ppr_options = 0;
 	} else {
-		*period = MAX(*period, transinfo->period);
+		*period = max(*period, (u_int)transinfo->period);
 		ahd_find_syncrate(ahd, period, ppr_options, maxsync);
 	}
 }
@@ -2924,12 +2924,12 @@ ahd_validate_offset(struct ahd_softc *ah
 			maxoffset = MAX_OFFSET_PACED;
 	} else
 		maxoffset = MAX_OFFSET_NON_PACED;
-	*offset = MIN(*offset, maxoffset);
+	*offset = min(*offset, maxoffset);
 	if (tinfo != NULL) {
 		if (role == ROLE_TARGET)
-			*offset = MIN(*offset, tinfo->user.offset);
+			*offset = min(*offset, (u_int)tinfo->user.offset);
 		else
-			*offset = MIN(*offset, tinfo->goal.offset);
+			*offset = min(*offset, (u_int)tinfo->goal.offset);
 	}
 }
 
@@ -2955,9 +2955,9 @@ ahd_validate_width(struct ahd_softc *ahd
 	}
 	if (tinfo != NULL) {
 		if (role == ROLE_TARGET)
-			*bus_width = MIN(tinfo->user.width, *bus_width);
+			*bus_width = min((u_int)tinfo->user.width, *bus_width);
 		else
-			*bus_width = MIN(tinfo->goal.width, *bus_width);
+			*bus_width = min((u_int)tinfo->goal.width, *bus_width);
 	}
 }
 
@@ -6057,9 +6057,9 @@ ahd_alloc_scbs(struct ahd_softc *ahd)
 #endif
 	}
 
-	newcount = MIN(scb_data->sense_left, scb_data->scbs_left);
-	newcount = MIN(newcount, scb_data->sgs_left);
-	newcount = MIN(newcount, (AHD_SCB_MAX_ALLOC - scb_data->numscbs));
+	newcount = min(scb_data->sense_left, scb_data->scbs_left);
+	newcount = min(newcount, scb_data->sgs_left);
+	newcount = min(newcount, (AHD_SCB_MAX_ALLOC - scb_data->numscbs));
 	for (i = 0; i < newcount; i++) {
 		struct scb_platform_data *pdata;
 		u_int col_tag;
@@ -8668,7 +8668,7 @@ ahd_resolve_seqaddr(struct ahd_softc *ah
 		if (skip_addr > i) {
 			int end_addr;
 
-			end_addr = MIN(address, skip_addr);
+			end_addr = min(address, skip_addr);
 			address_offset += end_addr - i;
 			i = skip_addr;
 		} else {
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx.h linux-2.6.18/drivers/scsi/aic7xxx/aic79xx.h
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx.h	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic79xx.h	2006-09-25 14:43:22.000000000 +0530
@@ -53,14 +53,6 @@ struct ahd_platform_data;
 struct scb_platform_data;
 
 /****************************** Useful Macros *********************************/
-#ifndef MAX
-#define MAX(a,b) (((a) > (b)) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
 #ifndef TRUE
 #define TRUE 1
 #endif
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.18/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-09-25 14:43:22.000000000 +0530
@@ -1813,9 +1813,9 @@ ahd_linux_handle_scsi_status(struct ahd_
 			u_int sense_offset;
 
 			if (scb->flags & SCB_SENSE) {
-				sense_size = MIN(sizeof(struct scsi_sense_data)
+				sense_size = min(sizeof(struct scsi_sense_data)
 					       - ahd_get_sense_residual(scb),
-						 sizeof(cmd->sense_buffer));
+						 (u_long)sizeof(cmd->sense_buffer));
 				sense_offset = 0;
 			} else {
 				/*
@@ -1824,7 +1824,7 @@ ahd_linux_handle_scsi_status(struct ahd_
 				 */
 				siu = (struct scsi_status_iu_header *)
 				    scb->sense_data;
-				sense_size = MIN(scsi_4btoul(siu->sense_length),
+				sense_size = min(scsi_4btoul(siu->sense_length),
 						sizeof(cmd->sense_buffer));
 				sense_offset = SIU_SENSE_OFFSET(siu);
 			}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-09-25 14:43:22.000000000 +0530
@@ -1671,7 +1671,7 @@ ahc_devlimited_syncrate(struct ahc_softc
 		transinfo = &tinfo->goal;
 	*ppr_options &= transinfo->ppr_options;
 	if (transinfo->width == MSG_EXT_WDTR_BUS_8_BIT) {
-		maxsync = MAX(maxsync, AHC_SYNCRATE_ULTRA2);
+		maxsync = max(maxsync, (u_int)AHC_SYNCRATE_ULTRA2);
 		*ppr_options &= ~MSG_EXT_PPR_DT_REQ;
 	}
 	if (transinfo->period == 0) {
@@ -1679,7 +1679,7 @@ ahc_devlimited_syncrate(struct ahc_softc
 		*ppr_options = 0;
 		return (NULL);
 	}
-	*period = MAX(*period, transinfo->period);
+	*period = max(*period, (u_int)transinfo->period);
 	return (ahc_find_syncrate(ahc, period, ppr_options, maxsync));
 }
 
@@ -1804,12 +1804,12 @@ ahc_validate_offset(struct ahc_softc *ah
 		else
 			maxoffset = MAX_OFFSET_8BIT;
 	}
-	*offset = MIN(*offset, maxoffset);
+	*offset = min(*offset, maxoffset);
 	if (tinfo != NULL) {
 		if (role == ROLE_TARGET)
-			*offset = MIN(*offset, tinfo->user.offset);
+			*offset = min(*offset, (u_int)tinfo->user.offset);
 		else
-			*offset = MIN(*offset, tinfo->goal.offset);
+			*offset = min(*offset, (u_int)tinfo->goal.offset);
 	}
 }
 
@@ -1835,9 +1835,9 @@ ahc_validate_width(struct ahc_softc *ahc
 	}
 	if (tinfo != NULL) {
 		if (role == ROLE_TARGET)
-			*bus_width = MIN(tinfo->user.width, *bus_width);
+			*bus_width = min((u_int)tinfo->user.width, *bus_width);
 		else
-			*bus_width = MIN(tinfo->goal.width, *bus_width);
+			*bus_width = min((u_int)tinfo->goal.width, *bus_width);
 	}
 }
 
@@ -4406,7 +4406,7 @@ ahc_alloc_scbs(struct ahc_softc *ahc)
 	physaddr = sg_map->sg_physaddr;
 
 	newcount = (PAGE_SIZE / (AHC_NSEG * sizeof(struct ahc_dma_seg)));
-	newcount = MIN(newcount, (AHC_SCB_MAX_ALLOC - scb_data->numscbs));
+	newcount = min(newcount, (AHC_SCB_MAX_ALLOC - scb_data->numscbs));
 	for (i = 0; i < newcount; i++) {
 		struct scb_platform_data *pdata;
 #ifndef __linux__
@@ -6442,7 +6442,7 @@ ahc_download_instr(struct ahc_softc *ahc
 			if (skip_addr > i) {
 				int end_addr;
 
-				end_addr = MIN(address, skip_addr);
+				end_addr = min(address, skip_addr);
 				address_offset += end_addr - i;
 				i = skip_addr;
 			} else {
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx.h linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx.h	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx.h	2006-09-25 14:43:22.000000000 +0530
@@ -54,14 +54,6 @@ struct scb_platform_data;
 struct seeprom_descriptor;
 
 /****************************** Useful Macros *********************************/
-#ifndef MAX
-#define MAX(a,b) (((a) > (b)) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
 #ifndef TRUE
 #define TRUE 1
 #endif
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.18-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/aic7xxx/aic7xxx_osm.c	2006-09-25 14:43:22.000000000 +0530
@@ -1875,9 +1875,9 @@ ahc_linux_handle_scsi_status(struct ahc_
 		if (scb->flags & SCB_SENSE) {
 			u_int sense_size;
 
-			sense_size = MIN(sizeof(struct scsi_sense_data)
+			sense_size = min(sizeof(struct scsi_sense_data)
 				       - ahc_get_sense_residual(scb),
-					 sizeof(cmd->sense_buffer));
+					 (u_long)sizeof(cmd->sense_buffer));
 			memcpy(cmd->sense_buffer,
 			       ahc_get_sense_buf(ahc, scb), sense_size);
 			if (sense_size < sizeof(cmd->sense_buffer))
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/fs/xfs/xfs_btree.h linux-2.6.18/fs/xfs/xfs_btree.h
--- linux-2.6.18-orig/fs/xfs/xfs_btree.h	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/fs/xfs/xfs_btree.h	2006-09-25 14:43:22.000000000 +0530
@@ -18,6 +18,8 @@
 #ifndef __XFS_BTREE_H__
 #define	__XFS_BTREE_H__
 
+#include <linux/kernel.h>
+
 struct xfs_buf;
 struct xfs_bmap_free;
 struct xfs_inode;
@@ -441,30 +443,14 @@ xfs_btree_setbuf(
 /*
  * Min and max functions for extlen, agblock, fileoff, and filblks types.
  */
-#define	XFS_EXTLEN_MIN(a,b)	\
-	((xfs_extlen_t)(a) < (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_EXTLEN_MAX(a,b)	\
-	((xfs_extlen_t)(a) > (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_AGBLOCK_MIN(a,b)	\
-	((xfs_agblock_t)(a) < (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_AGBLOCK_MAX(a,b)	\
-	((xfs_agblock_t)(a) > (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_FILEOFF_MIN(a,b)	\
-	((xfs_fileoff_t)(a) < (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILEOFF_MAX(a,b)	\
-	((xfs_fileoff_t)(a) > (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILBLKS_MIN(a,b)	\
-	((xfs_filblks_t)(a) < (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
-#define	XFS_FILBLKS_MAX(a,b)	\
-	((xfs_filblks_t)(a) > (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
+#define	XFS_EXTLEN_MIN(a,b)   (min_t(xfs_extlen_t,a,b))
+#define	XFS_EXTLEN_MAX(a,b)	  (max_t(xfs_extlen_t,a,b))
+#define	XFS_AGBLOCK_MIN(a,b)  (min_t(xfs_agblock_t,a,b))
+#define	XFS_AGBLOCK_MAX(a,b)  (max_t(xfs_agblock_t,a,b))
+#define	XFS_FILEOFF_MIN(a,b)  (min_t(xfs_fileoff_t,a,b))
+#define	XFS_FILEOFF_MAX(a,b)  (max_t(xfs_fileoff_t,a,b))
+#define	XFS_FILBLKS_MIN(a,b)  (min_t(xfs_filblks_t,a,b))
+#define	XFS_FILBLKS_MAX(a,b)  (max_t(xfs_filblks_t,a,b))
 
 #define	XFS_FSB_SANITY_CHECK(mp,fsb)	\
 	(XFS_FSB_TO_AGNO(mp, fsb) < mp->m_sb.sb_agcount && \
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/fs/xfs/xfs_rtalloc.c linux-2.6.18/fs/xfs/xfs_rtalloc.c
--- linux-2.6.18-orig/fs/xfs/xfs_rtalloc.c	2006-09-21 10:15:44.000000000 +0530
+++ linux-2.6.18/fs/xfs/xfs_rtalloc.c	2006-09-25 14:43:22.000000000 +0530
@@ -699,8 +699,8 @@ xfs_rtallocate_extent_size(
 			 * this summary level.
 			 */
 			error = xfs_rtallocate_extent_block(mp, tp, i,
-					XFS_RTMAX(minlen, 1 << l),
-					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
+					max(minlen, (xfs_extlen_t)(1 << l)),
+					min(maxlen, (xfs_extlen_t)((1 << (l + 1)) - 1)),
 					len, &n, rbpp, rsb, prod, &r);
 			if (error) {
 				return error;
@@ -1020,7 +1020,7 @@ xfs_rtcheck_range(
 		/*
 		 * Compute first bit not examined.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);
 		/*
 		 * Mask of relevant bits.
 		 */
@@ -1238,7 +1238,7 @@ xfs_rtfind_back(
 		 * Calculate first (leftmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		firstbit = XFS_RTMAX((xfs_srtblock_t)(bit - len + 1), 0);
+		firstbit = max((xfs_srtblock_t)(bit - len + 1), (xfs_srtblock_t)0);
 		mask = (((xfs_rtword_t)1 << (bit - firstbit + 1)) - 1) <<
 			firstbit;
 		/*
@@ -1413,7 +1413,7 @@ xfs_rtfind_forw(
 		 * Calculate last (rightmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_rtblock_t)XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Calculate the difference between the value there
@@ -1724,7 +1724,7 @@ xfs_rtmodify_range(
 		/*
 		 * Compute first bit not changed and mask of relevant bits.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Set/clear the active bits.
@@ -1999,9 +1999,9 @@ xfs_growfs_rt(
 		nsbp->sb_rextsize = in->extsize;
 		nsbp->sb_rbmblocks = bmbno + 1;
 		nsbp->sb_rblocks =
-			XFS_RTMIN(nrblocks,
-				  nsbp->sb_rbmblocks * NBBY *
-				  nsbp->sb_blocksize * nsbp->sb_rextsize);
+			min(nrblocks,
+				  (xfs_drfsbno_t)(nsbp->sb_rbmblocks * NBBY *
+				  nsbp->sb_blocksize * nsbp->sb_rextsize));
 		nsbp->sb_rextents = nsbp->sb_rblocks;
 		do_div(nsbp->sb_rextents, nsbp->sb_rextsize);
 		nsbp->sb_rextslog = xfs_highbit32(nsbp->sb_rextents);
@@ -2430,7 +2430,7 @@ xfs_rtprint_summary(
 			if (c) {
 				if (!p) {
 					cmn_err(CE_DEBUG, "%Ld-%Ld:", 1LL << l,
-						XFS_RTMIN((1LL << l) +
+						min((1LL << l) +
 							  ((1LL << l) - 1LL),
 							 mp->m_sb.sb_rextents));
 					p = 1;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/fs/xfs/xfs_rtalloc.h linux-2.6.18/fs/xfs/xfs_rtalloc.h
--- linux-2.6.18-orig/fs/xfs/xfs_rtalloc.h	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/fs/xfs/xfs_rtalloc.h	2006-09-25 14:43:22.000000000 +0530
@@ -57,9 +57,6 @@ struct xfs_trans;
 #define	XFS_BITTOWORD(mp,bi)	\
 	((int)(((bi) >> XFS_NBWORDLOG) & XFS_BLOCKWMASK(mp)))
 
-#define	XFS_RTMIN(a,b)	((a) < (b) ? (a) : (b))
-#define	XFS_RTMAX(a,b)	((a) > (b) ? (a) : (b))
-
 #define	XFS_RTLOBIT(w)	xfs_lowbit32(w)
 #define	XFS_RTHIBIT(w)	xfs_highbit32(w)


