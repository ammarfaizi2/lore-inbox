Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWJRJug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWJRJug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWJRJug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:50:36 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:54217 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932108AbWJRJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:50:34 -0400
Subject: [PATCH] drivers/scsi: Handcrafted MIN/MAX macro removal
From: Amol Lad <amol@verismonetworks.com>
To: James.Bottomley@steeleye.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:23:55 +0530
Message-Id: <1161165235.20400.139.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
macros are changed to use macros in kernel.h

Tested using allmodconfig

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 aic79xx.h      |    8 --------
 aic79xx_core.c |   22 +++++++++++-----------
 aic79xx_osm.c  |    6 +++---
 aic7xxx.h      |    8 --------
 aic7xxx_core.c |   18 +++++++++---------
 aic7xxx_osm.c  |    4 ++--
 6 files changed, 25 insertions(+), 41 deletions(-)
---
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx_core.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx_core.c	2006-10-18 11:25:46.000000000 +0530
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
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx.h linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx.h
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx.h	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx.h	2006-10-18 11:25:46.000000000 +0530
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
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-10-18 09:29:10.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-10-18 11:25:46.000000000 +0530
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
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-10-18 11:25:46.000000000 +0530
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
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx.h linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx.h	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx.h	2006-10-18 11:25:46.000000000 +0530
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
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.19-rc2-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2006-10-18 09:29:10.000000000 +0530
+++ linux-2.6.19-rc2/drivers/scsi/aic7xxx/aic7xxx_osm.c	2006-10-18 11:25:46.000000000 +0530
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


