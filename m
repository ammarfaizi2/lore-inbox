Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTDNR4e (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTDNR4d (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:56:33 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:62663 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S263598AbTDNRpd (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:33 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (9/16): dasd driver coding style - part 2.
Date: Mon, 14 Apr 2003 19:51:15 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141951.15417.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 dasd driver:
 - Coding style adaptions. Removed almost all typedefs from the dasd driver.

diffstat:
 dasd_eckd.c  |  328 ++++++++++++++++++++++++++++-------------------------------
 dasd_eckd.h  |   59 +++++-----
 dasd_erp.c   |   57 ++++------
 dasd_fba.c   |   84 +++++++--------
 dasd_fba.h   |   26 +---
 dasd_genhd.c |   33 -----
 dasd_int.h   |  205 +++++++++++++++++-------------------
 dasd_ioctl.c |   66 +++++------
 dasd_proc.c  |   15 +-
 9 files changed, 403 insertions(+), 470 deletions(-)

diff -urN linux-2.5.67/drivers/s390/block/dasd_eckd.c linux-2.5.67-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.67/drivers/s390/block/dasd_eckd.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_eckd.c	Mon Apr 14 19:11:54 2003
@@ -7,23 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.38 $
- *
- * History of changes (starts July 2000)
- * 07/11/00 Enabled rotational position sensing
- * 07/14/00 Reorganized the format process for better ERP
- * 07/20/00 added experimental support for 2105 control unit (ESS)
- * 07/24/00 increased expiration time and added the missing zero
- * 08/07/00 added some bits to define_extent for ESS support
- * 09/20/00 added reserve and release ioctls
- * 10/04/00 changed RW-CCWS to R/W Key and Data
- * 10/10/00 reverted last change according to ESS exploitation
- * 10/10/00 now dequeuing init_cqr before freeing *ouch*
- * 26/10/00 fixed ITPM20144ASC (problems when accessing a device formatted by VIF)
- * 01/23/01 fixed kmalloc statement in dump_sense to be GFP_ATOMIC
- *	    fixed partition handling and HDIO_GETGEO
- * 2002/01/04 Created 2.4-2.5 compatibility mode
- * 05/04/02 code restructuring.
+ * $Revision: 1.42 $
  */
 
 #include <linux/config.h>
@@ -64,16 +48,16 @@
 
 MODULE_LICENSE("GPL");
 
-static dasd_discipline_t dasd_eckd_discipline;
+static struct dasd_discipline dasd_eckd_discipline;
 
-typedef struct dasd_eckd_private_t {
-	dasd_eckd_characteristics_t rdc_data;
-	dasd_eckd_confdata_t conf_data;
-	eckd_count_t count_area[5];
+struct dasd_eckd_private {
+	struct dasd_eckd_characteristics rdc_data;
+	struct dasd_eckd_confdata conf_data;
+	struct eckd_count count_area[5];
 	int init_cqr_status;
 	int uses_cdl;
-	attrib_data_t attrib;	/* e.g. cache operations */
-} dasd_eckd_private_t;
+	struct attrib_data_t attrib;	/* e.g. cache operations */
+};
 
 /* The ccw bus type uses this table to find devices that it sends to
  * dasd_eckd_probe */
@@ -132,7 +116,7 @@
 }
 
 static inline int
-bytes_per_record(dasd_eckd_characteristics_t *rdc, int kl, int dl)
+bytes_per_record(struct dasd_eckd_characteristics *rdc, int kl, int dl)
 {
 	unsigned int fl1, fl2, int1, int2;
 	int bpr;
@@ -164,13 +148,13 @@
 }
 
 static inline unsigned int
-bytes_per_track(dasd_eckd_characteristics_t *rdc)
+bytes_per_track(struct dasd_eckd_characteristics *rdc)
 {
 	return *(unsigned int *) (rdc->byte_per_track) >> 8;
 }
 
 static inline unsigned int
-recs_per_track(dasd_eckd_characteristics_t * rdc,
+recs_per_track(struct dasd_eckd_characteristics * rdc,
 	       unsigned int kl, unsigned int dl)
 {
 	int dn, kn;
@@ -204,12 +188,12 @@
 
 static inline void
 check_XRC (struct ccw1         *de_ccw,
-           DE_eckd_data_t *data,
-           dasd_device_t  *device)
+           struct DE_eckd_data *data,
+           struct dasd_device  *device)
 {
-        dasd_eckd_private_t *private;
+        struct dasd_eckd_private *private;
 
-        private = (dasd_eckd_private_t *) device->private;
+        private = (struct dasd_eckd_private *) device->private;
 
         /* switch on System Time Stamp - needed for XRC Support */
         if (private->rdc_data.facilities.XRC_supported) {
@@ -219,7 +203,7 @@
                 
                 data->ep_sys_time = get_clock ();
                 
-                de_ccw->count = sizeof (DE_eckd_data_t);
+                de_ccw->count = sizeof (struct DE_eckd_data);
                 de_ccw->flags = CCW_FLAG_SLI;  
         }
 
@@ -228,20 +212,20 @@
 } /* end check_XRC */
 
 static inline void
-define_extent(struct ccw1 * ccw, DE_eckd_data_t * data, int trk, int totrk,
-	      int cmd, dasd_device_t * device)
+define_extent(struct ccw1 * ccw, struct DE_eckd_data * data, int trk,
+	      int totrk, int cmd, struct dasd_device * device)
 {
-	dasd_eckd_private_t *private;
-	ch_t geo, beg, end;
+	struct dasd_eckd_private *private;
+	struct ch_t geo, beg, end;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = 0;
 	ccw->count = 16;
 	ccw->cda = (__u32) __pa(data);
 
-	memset(data, 0, sizeof (DE_eckd_data_t));
+	memset(data, 0, sizeof (struct DE_eckd_data));
 	switch (cmd) {
 	case DASD_ECKD_CCW_READ_HOME_ADDRESS:
 	case DASD_ECKD_CCW_READ_RECORD_ZERO:
@@ -319,15 +303,15 @@
 }
 
 static inline void
-locate_record(struct ccw1 *ccw, LO_eckd_data_t *data, int trk,
+locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, int trk,
 	      int rec_on_trk, int no_rec, int cmd,
-	      dasd_device_t * device, int reclen)
+	      struct dasd_device * device, int reclen)
 {
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 	int sector;
 	int dn, d;
 				
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 
 	DBF_EVENT(DBF_INFO,
 		  "Locate: trk %d, rec %d, no_rec %d, cmd %d, reclen %d",
@@ -338,7 +322,7 @@
 	ccw->count = 16;
 	ccw->cda = (__u32) __pa(data);
 
-	memset(data, 0, sizeof (LO_eckd_data_t));
+	memset(data, 0, sizeof (struct LO_eckd_data));
 	sector = 0;
 	if (rec_on_trk) {
 		switch (private->rdc_data.dev_type) {
@@ -456,17 +440,17 @@
 }
 
 static int
-dasd_eckd_check_characteristics(dasd_device_t *device)
+dasd_eckd_check_characteristics(struct dasd_device *device)
 {
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 	void *rdc_data;
 	void *conf_data;
 	int conf_len;
 	int rc;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(dasd_eckd_private_t),
+		private = kmalloc(sizeof(struct dasd_eckd_private),
 				  GFP_KERNEL | GFP_DMA);
 		if (private == NULL) {
 			MESSAGE(KERN_WARNING, "%s",
@@ -511,14 +495,15 @@
 		MESSAGE(KERN_WARNING, "%s", "No configuration data retrieved");
 		return 0;	/* no errror */
 	}
-	if (conf_len != sizeof (dasd_eckd_confdata_t)) {
+	if (conf_len != sizeof (struct dasd_eckd_confdata)) {
 		MESSAGE(KERN_WARNING,
 			"sizes of configuration data mismatch"
 			"%d (read) vs %ld (expected)",
-			conf_len, sizeof (dasd_eckd_confdata_t));
+			conf_len, sizeof (struct dasd_eckd_confdata));
 		return 0;	/* no errror */
 	}
-	memcpy(&private->conf_data, conf_data, sizeof (dasd_eckd_confdata_t));
+	memcpy(&private->conf_data, conf_data,
+	       sizeof (struct dasd_eckd_confdata));
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "%04X/%02X(CU:%04X/%02X): Configuration data read",
@@ -528,27 +513,28 @@
 		    private->rdc_data.cu_model.model);
 	return 0;
 
-        /* get characteristis via diag to determine the kind of minidisk under VM */
-        /* needed beacause XRC is not support by VM (jet)                         */
-        /* Can be removed as soon as VM supports XRC                              */
-	// TBD ??? HUM
+        /* get characteristis via diag to determine the kind of
+	 * minidisk under VM needed beacause XRC is not support
+	 * by VM (jet). Can be removed as soon as VM supports XRC
+	 * FIXME: TBD ??? HUM
+	 */
 }
 
-static dasd_ccw_req_t *
-dasd_eckd_analysis_ccw(struct dasd_device_t *device)
-{
-	dasd_eckd_private_t *private;
-	eckd_count_t *count_data;
-	LO_eckd_data_t *LO_data;
-	dasd_ccw_req_t *cqr;
+static struct dasd_ccw_req *
+dasd_eckd_analysis_ccw(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	struct eckd_count *count_data;
+	struct LO_eckd_data *LO_data;
+	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 	int cplength, datasize;
 	int i;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 
 	cplength = 8;
-	datasize = sizeof(DE_eckd_data_t) + 2*sizeof(LO_eckd_data_t);
+	datasize = sizeof(struct DE_eckd_data) + 2*sizeof(struct LO_eckd_data);
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   cplength, datasize, device);
 	if (IS_ERR(cqr))
@@ -557,7 +543,7 @@
 	/* Define extent for the first 3 tracks. */
 	define_extent(ccw++, cqr->data, 0, 2,
 		      DASD_ECKD_CCW_READ_COUNT, device);
-	LO_data = cqr->data + sizeof (DE_eckd_data_t);
+	LO_data = cqr->data + sizeof (struct DE_eckd_data);
 	/* Locate record for the first 4 records on track 0. */
 	ccw[-1].flags |= CCW_FLAG_CC;
 	locate_record(ccw++, LO_data++, 0, 0, 4,
@@ -600,25 +586,25 @@
  * for deletion in the meantime).
  */
 static void
-dasd_eckd_analysis_callback(dasd_ccw_req_t *init_cqr, void *data)
+dasd_eckd_analysis_callback(struct dasd_ccw_req *init_cqr, void *data)
 {
-	dasd_eckd_private_t *private;
-	dasd_device_t *device;
+	struct dasd_eckd_private *private;
+	struct dasd_device *device;
 
 	device = init_cqr->device;
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	private->init_cqr_status = init_cqr->status;
 	dasd_sfree_request(init_cqr, device);
 	dasd_kick_device(device);
 }
 
 static int
-dasd_eckd_start_analysis(struct dasd_device_t *device)
+dasd_eckd_start_analysis(struct dasd_device *device)
 {
-	dasd_eckd_private_t *private;
-	dasd_ccw_req_t *init_cqr;
+	struct dasd_eckd_private *private;
+	struct dasd_ccw_req *init_cqr;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	init_cqr = dasd_eckd_analysis_ccw(device);
 	if (IS_ERR(init_cqr))
 		return PTR_ERR(init_cqr);
@@ -630,14 +616,14 @@
 }
 
 static int
-dasd_eckd_end_analysis(struct dasd_device_t *device)
+dasd_eckd_end_analysis(struct dasd_device *device)
 {
-	dasd_eckd_private_t *private;
-	eckd_count_t *count_area;
+	struct dasd_eckd_private *private;
+	struct eckd_count *count_area;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	status = private->init_cqr_status;
 	private->init_cqr_status = -1;
 	if (status != DASD_CQR_DONE) {
@@ -708,11 +694,11 @@
 }
 
 static int
-dasd_eckd_do_analysis(struct dasd_device_t *device)
+dasd_eckd_do_analysis(struct dasd_device *device)
 {
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	if (private->init_cqr_status < 0)
 		return dasd_eckd_start_analysis(device);
 	else
@@ -720,34 +706,34 @@
 }
 
 static int
-dasd_eckd_fill_geometry(struct dasd_device_t *device, struct hd_geometry *geo)
+dasd_eckd_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
 {
-	int rc = 0;
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	if (dasd_check_blocksize(device->bp_block) == 0) {
 		geo->sectors = recs_per_track(&private->rdc_data,
 					      0, device->bp_block);
 	}
 	geo->cylinders = private->rdc_data.no_cyl;
 	geo->heads = private->rdc_data.trk_per_cyl;
-	return rc;
+	return 0;
 }
 
-static dasd_ccw_req_t *
-dasd_eckd_format_device(dasd_device_t * device, format_data_t * fdata)
-{
-	dasd_eckd_private_t *private;
-	dasd_ccw_req_t *fcp;
-	eckd_count_t *ect;
+static struct dasd_ccw_req *
+dasd_eckd_format_device(struct dasd_device * device,
+			struct format_data_t * fdata)
+{
+	struct dasd_eckd_private *private;
+	struct dasd_ccw_req *fcp;
+	struct eckd_count *ect;
 	struct ccw1 *ccw;
 	void *data;
 	int rpt, cyl, head;
 	int cplength, datasize;
 	int i;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	rpt = recs_per_track(&private->rdc_data, 0, fdata->blksize);
 	cyl = fdata->start_unit / private->rdc_data.trk_per_cyl;
 	head = fdata->start_unit % private->rdc_data.trk_per_cyl;
@@ -782,20 +768,24 @@
 	case 0x00:	/* Normal format */
 	case 0x08:	/* Normal format, use cdl. */
 		cplength = 2 + rpt;
-		datasize = sizeof(DE_eckd_data_t) + sizeof(LO_eckd_data_t) +
-			rpt * sizeof(eckd_count_t);
+		datasize = sizeof(struct DE_eckd_data) +
+			sizeof(struct LO_eckd_data) +
+			rpt * sizeof(struct eckd_count);
 		break;
 	case 0x01:	/* Write record zero and format track. */
 	case 0x09:	/* Write record zero and format track, use cdl. */
 		cplength = 3 + rpt;
-		datasize = sizeof(DE_eckd_data_t) + sizeof(LO_eckd_data_t) +
-			sizeof(eckd_count_t) + rpt * sizeof(eckd_count_t);
+		datasize = sizeof(struct DE_eckd_data) +
+			sizeof(struct LO_eckd_data) +
+			sizeof(struct eckd_count) +
+			rpt * sizeof(struct eckd_count);
 		break;
 	case 0x04:	/* Invalidate track. */
 	case 0x0c:	/* Invalidate track, use cdl. */
 		cplength = 3;
-		datasize = sizeof(DE_eckd_data_t) + sizeof(LO_eckd_data_t) +
-			sizeof(eckd_count_t);
+		datasize = sizeof(struct DE_eckd_data) +
+			sizeof(struct LO_eckd_data) +
+			sizeof(struct eckd_count);
 		break;
 	default:
 		MESSAGE(KERN_WARNING, "Invalid flags 0x%x.", fdata->intensity);
@@ -812,45 +802,45 @@
 
 	switch (fdata->intensity & ~0x08) {
 	case 0x00: /* Normal format. */
-		define_extent(ccw++, (DE_eckd_data_t *) data,
+		define_extent(ccw++, (struct DE_eckd_data *) data,
 			      fdata->start_unit, fdata->start_unit,
 			      DASD_ECKD_CCW_WRITE_CKD, device);
-		data += sizeof(DE_eckd_data_t);
+		data += sizeof(struct DE_eckd_data);
 		ccw[-1].flags |= CCW_FLAG_CC;
-		locate_record(ccw++, (LO_eckd_data_t *) data,
+		locate_record(ccw++, (struct LO_eckd_data *) data,
 			      fdata->start_unit, 0, rpt,
 			      DASD_ECKD_CCW_WRITE_CKD, device,
 			      fdata->blksize);
-		data += sizeof(LO_eckd_data_t);
+		data += sizeof(struct LO_eckd_data);
 		break;
 	case 0x01: /* Write record zero + format track. */
-		define_extent(ccw++, (DE_eckd_data_t *) data,
+		define_extent(ccw++, (struct DE_eckd_data *) data,
 			      fdata->start_unit, fdata->start_unit,
 			      DASD_ECKD_CCW_WRITE_RECORD_ZERO,
 			      device);
-		data += sizeof(DE_eckd_data_t);
+		data += sizeof(struct DE_eckd_data);
 		ccw[-1].flags |= CCW_FLAG_CC;
-		locate_record(ccw++, (LO_eckd_data_t *) data,
+		locate_record(ccw++, (struct LO_eckd_data *) data,
 			      fdata->start_unit, 0, rpt + 1,
 			      DASD_ECKD_CCW_WRITE_RECORD_ZERO, device,
 			      device->bp_block);
-		data += sizeof(LO_eckd_data_t);
+		data += sizeof(struct LO_eckd_data);
 		break;
 	case 0x04: /* Invalidate track. */
-		define_extent(ccw++, (DE_eckd_data_t *) data,
+		define_extent(ccw++, (struct DE_eckd_data *) data,
 			      fdata->start_unit, fdata->start_unit,
 			      DASD_ECKD_CCW_WRITE_CKD, device);
-		data += sizeof(DE_eckd_data_t);
+		data += sizeof(struct DE_eckd_data);
 		ccw[-1].flags |= CCW_FLAG_CC;
-		locate_record(ccw++, (LO_eckd_data_t *) data,
+		locate_record(ccw++, (struct LO_eckd_data *) data,
 			      fdata->start_unit, 0, 1,
 			      DASD_ECKD_CCW_WRITE_CKD, device, 8);
-		data += sizeof(LO_eckd_data_t);
+		data += sizeof(struct LO_eckd_data);
 		break;
 	}
 	if (fdata->intensity & 0x01) {	/* write record zero */
-		ect = (eckd_count_t *) data;
-		data += sizeof(eckd_count_t);
+		ect = (struct eckd_count *) data;
+		data += sizeof(struct eckd_count);
 		ect->cyl = cyl;
 		ect->head = head;
 		ect->record = 0;
@@ -863,8 +853,8 @@
 		ccw->cda = (__u32)(addr_t) ect;
 	}
 	if (fdata->intensity & 0x04) {	/* erase track */
-		ect = (eckd_count_t *) data;
-		data += sizeof(eckd_count_t);
+		ect = (struct eckd_count *) data;
+		data += sizeof(struct eckd_count);
 		ect->cyl = cyl;
 		ect->head = head;
 		ect->record = 1;
@@ -877,8 +867,8 @@
 		ccw->cda = (__u32)(addr_t) ect;
 	} else {		/* write remaining records */
 		for (i = 0; i < rpt; i++) {
-			ect = (eckd_count_t *) data;
-			data += sizeof(eckd_count_t);
+			ect = (struct eckd_count *) data;
+			data += sizeof(struct eckd_count);
 			ect->cyl = cyl;
 			ect->head = head;
 			ect->record = i + 1;
@@ -912,9 +902,9 @@
 }
 
 static dasd_era_t
-dasd_eckd_examine_error(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_eckd_examine_error(struct dasd_ccw_req * cqr, struct irb * irb)
 {
-	dasd_device_t *device = (dasd_device_t *) cqr->device;
+	struct dasd_device *device = (struct dasd_device *) cqr->device;
 	struct ccw_device *cdev = device->cdev;
 
 	if (irb->scsw.cstat == 0x00 &&
@@ -936,9 +926,9 @@
 }
 
 static dasd_erp_fn_t
-dasd_eckd_erp_action(dasd_ccw_req_t * cqr)
+dasd_eckd_erp_action(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device = (dasd_device_t *) cqr->device;
+	struct dasd_device *device = (struct dasd_device *) cqr->device;
 	struct ccw_device *cdev = device->cdev;
 
 	switch (cdev->id.cu_type) {
@@ -954,18 +944,18 @@
 }
 
 static dasd_erp_fn_t
-dasd_eckd_erp_postaction(dasd_ccw_req_t * cqr)
+dasd_eckd_erp_postaction(struct dasd_ccw_req * cqr)
 {
 	return dasd_default_erp_postaction;
 }
 
-static dasd_ccw_req_t *
-dasd_eckd_build_cp(dasd_device_t * device, struct request *req)
+static struct dasd_ccw_req *
+dasd_eckd_build_cp(struct dasd_device * device, struct request *req)
 {
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 	unsigned long *idaws;
-	LO_eckd_data_t *LO_data;
-	dasd_ccw_req_t *cqr;
+	struct LO_eckd_data *LO_data;
+	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 	struct bio *bio;
 	struct bio_vec *bv;
@@ -978,7 +968,7 @@
 	unsigned char cmd, rcmd;
 	int i;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	if (rq_data_dir(req) == READ)
 		cmd = DASD_ECKD_CCW_READ_MT;
 	else if (rq_data_dir(req) == WRITE)
@@ -991,7 +981,8 @@
 	/* Calculate record id of first and last block. */
 	first_rec = first_trk = req->sector >> device->s2b_shift;
 	first_offs = sector_div(first_trk, blk_per_trk);
-	last_rec = last_trk = (req->sector + req->nr_sectors - 1) >> device->s2b_shift;
+	last_rec = last_trk =
+		(req->sector + req->nr_sectors - 1) >> device->s2b_shift;
 	last_offs = sector_div(last_trk, blk_per_trk);
 	/* Check struct bio and count the number of blocks for the request. */
 	count = 0;
@@ -1014,14 +1005,14 @@
 	/* 1x define extent + 1x locate record + number of blocks */
 	cplength = 2 + count;
 	/* 1x define extent + 1x locate record + cidaws*sizeof(long) */
-	datasize = sizeof(DE_eckd_data_t) + sizeof(LO_eckd_data_t) +
+	datasize = sizeof(struct DE_eckd_data) + sizeof(struct LO_eckd_data) +
 		cidaw * sizeof(unsigned long);
 	/* Find out the number of additional locate record ccws for cdl. */
 	if (private->uses_cdl && first_rec < 2*blk_per_trk) {
 		if (last_rec >= 2*blk_per_trk)
 			count = 2*blk_per_trk - first_rec;
 		cplength += count;
-		datasize += count*sizeof(LO_eckd_data_t);
+		datasize += count*sizeof(struct LO_eckd_data);
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
@@ -1032,8 +1023,8 @@
 	/* First ccw is define extent. */
 	define_extent(ccw++, cqr->data, first_trk, last_trk, cmd, device);
 	/* Build locate_record+read/write/ccws. */
-	idaws = (unsigned long *) (cqr->data + sizeof(DE_eckd_data_t));
-	LO_data = (LO_eckd_data_t *) (idaws + cidaw);
+	idaws = (unsigned long *) (cqr->data + sizeof(struct DE_eckd_data));
+	LO_data = (struct LO_eckd_data *) (idaws + cidaw);
 	recid = first_rec;
 	if (private->uses_cdl == 0 || recid > 2*blk_per_trk) {
 		/* Only standard blocks so there is just one locate record. */
@@ -1097,20 +1088,21 @@
 }
 
 static int
-dasd_eckd_fill_info(dasd_device_t * device, dasd_information2_t * info)
+dasd_eckd_fill_info(struct dasd_device * device,
+		    struct dasd_information2_t * info)
 {
-	dasd_eckd_private_t *private;
+	struct dasd_eckd_private *private;
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 	info->label_block = 2;
 	info->FBA_layout = private->uses_cdl ? 0 : 1;
 	info->format = private->uses_cdl ? DASD_FORMAT_CDL : DASD_FORMAT_LDL;
-	info->characteristics_size = sizeof(dasd_eckd_characteristics_t);
+	info->characteristics_size = sizeof(struct dasd_eckd_characteristics);
 	memcpy(info->characteristics, &private->rdc_data,
-	       sizeof(dasd_eckd_characteristics_t));
-	info->confdata_size = sizeof (dasd_eckd_confdata_t);
+	       sizeof(struct dasd_eckd_characteristics));
+	info->confdata_size = sizeof (struct dasd_eckd_confdata);
 	memcpy(info->configuration_data, &private->conf_data,
-	       sizeof (dasd_eckd_confdata_t));
+	       sizeof (struct dasd_eckd_confdata));
 	return 0;
 }
 
@@ -1126,8 +1118,8 @@
 static int
 dasd_eckd_release(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1166,8 +1158,8 @@
 static int
 dasd_eckd_reserve(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1210,8 +1202,8 @@
 static int
 dasd_eckd_steal_lock(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1251,10 +1243,10 @@
 static int
 dasd_eckd_performance(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_psf_prssd_data_t *prssdp;
-	dasd_rssd_perf_stats_t *stats;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_rssd_perf_stats_t *stats;
+	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 	int rc;
 
@@ -1264,8 +1256,9 @@
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1 /* PSF */  + 1 /* RSSD */ ,
-				   (sizeof (dasd_psf_prssd_data_t) +
-				    sizeof (dasd_rssd_perf_stats_t)), device);
+				   (sizeof (struct dasd_psf_prssd_data) +
+				    sizeof (struct dasd_rssd_perf_stats_t)),
+				   device);
 	if (cqr == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"No memory to allocate initialization request");
@@ -1276,24 +1269,24 @@
 	cqr->expires = 10 * HZ;
 
 	/* Prepare for Read Subsystem Data */
-	prssdp = (dasd_psf_prssd_data_t *) cqr->data;
-	memset(prssdp, 0, sizeof (dasd_psf_prssd_data_t));
+	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+	memset(prssdp, 0, sizeof (struct dasd_psf_prssd_data));
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = 0x01;	/* Perfomance Statistics */
 	prssdp->varies[1] = 0x01;	/* Perf Statistics for the Subsystem */
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->count = sizeof (dasd_psf_prssd_data_t);
+	ccw->count = sizeof (struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->cda = (__u32)(addr_t) prssdp;
 
 	/* Read Subsystem Data - Performance Statistics */
-	stats = (dasd_rssd_perf_stats_t *) (prssdp + 1);
-	memset(stats, 0, sizeof (dasd_rssd_perf_stats_t));
+	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
+	memset(stats, 0, sizeof (struct dasd_rssd_perf_stats_t));
 
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
-	ccw->count = sizeof (dasd_rssd_perf_stats_t);
+	ccw->count = sizeof (struct dasd_rssd_perf_stats_t);
 	ccw->cda = (__u32)(addr_t) stats;
 
 	cqr->buildclk = get_clock();
@@ -1301,10 +1294,10 @@
 	rc = dasd_sleep_on(cqr);
 	if (rc == 0) {
 		/* Prepare for Read Subsystem Data */
-		prssdp = (dasd_psf_prssd_data_t *) cqr->data;
-		stats = (dasd_rssd_perf_stats_t *) (prssdp + 1);
+		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+		stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
 		rc = copy_to_user((long *) args, (long *) stats,
-				  sizeof(dasd_rssd_perf_stats_t));
+				  sizeof(struct dasd_rssd_perf_stats_t));
 	}
 	dasd_sfree_request(cqr, cqr->device);
 	return rc;
@@ -1317,9 +1310,9 @@
 static int
 dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_eckd_private_t *private;
-	attrib_data_t attrib;
+	struct dasd_device *device;
+	struct dasd_eckd_private *private;
+	struct attrib_data_t attrib;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1330,11 +1323,12 @@
 	if (device == NULL)
 		return -ENODEV;
 
-	if (copy_from_user(&attrib, (void *) args, sizeof (attrib_data_t))) {
+	if (copy_from_user(&attrib, (void *) args,
+			   sizeof (struct attrib_data_t))) {
 		return -EFAULT;
 	}
 
-	private = (dasd_eckd_private_t *) device->private;
+	private = (struct dasd_eckd_private *) device->private;
 
 	DBF_DEV_EVENT(DBF_ERR, device,
 		      "cache operation mode got "
@@ -1351,7 +1345,7 @@
 }
 
 static void
-dasd_eckd_dump_sense(struct dasd_device_t *device, dasd_ccw_req_t * req,
+dasd_eckd_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		     struct irb *irb)
 {
 
@@ -1422,7 +1416,7 @@
  * max_blocks is dependent on the amount of storage that is available
  * in the static io buffer for each device. Currently each device has
  * 8192 bytes (=2 pages). For 64 bit one dasd_mchunkt_t structure has
- * 24 bytes, the dasd_ccw_req_t has 136 bytes and each block can use
+ * 24 bytes, the struct dasd_ccw_req has 136 bytes and each block can use
  * up to 16 bytes (8 for the ccw and 8 for the idal pointer). In
  * addition we have one define extent ccw + 16 bytes of data and one
  * locate record ccw + 16 bytes of data. That makes:
@@ -1431,7 +1425,7 @@
  * start the next request if one finishes off. That makes 249.5 blocks
  * for one request. Give a little safety and the result is 240.
  */
-static dasd_discipline_t dasd_eckd_discipline = {
+static struct dasd_discipline dasd_eckd_discipline = {
 	.owner = THIS_MODULE,
 	.name = "ECKD",
 	.ebcname = "ECKD",
diff -urN linux-2.5.67/drivers/s390/block/dasd_eckd.h linux-2.5.67-s390/drivers/s390/block/dasd_eckd.h
--- linux-2.5.67/drivers/s390/block/dasd_eckd.h	Mon Apr  7 19:31:05 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_eckd.h	Mon Apr 14 19:11:54 2003
@@ -5,10 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.6 $
- *
- * History of changes 
- * 
+ * $Revision: 1.8 $
  */
 
 #ifndef DASD_ECKD_H
@@ -52,49 +49,49 @@
  * SECTION: Type Definitions
  ******************************************************************************/
 
-typedef struct eckd_count_t {
+struct eckd_count {
 	__u16 cyl;
 	__u16 head;
 	__u8 record;
 	__u8 kl;
 	__u16 dl;
-} __attribute__ ((packed)) eckd_count_t;
+} __attribute__ ((packed));
 
-typedef struct ch_t {
+struct ch_t {
 	__u16 cyl;
 	__u16 head;
-} __attribute__ ((packed)) ch_t;
+} __attribute__ ((packed));
 
-typedef struct chs_t {
+struct chs_t {
 	__u16 cyl;
 	__u16 head;
 	__u32 sector;
-} __attribute__ ((packed)) chs_t;
+} __attribute__ ((packed));
 
-typedef struct chr_t {
+struct chr_t {
 	__u16 cyl;
 	__u16 head;
 	__u8 record;
-} __attribute__ ((packed)) chr_t;
+} __attribute__ ((packed));
 
-typedef struct geom_t {
+struct geom_t {
 	__u16 cyl;
 	__u16 head;
 	__u32 sector;
-} __attribute__ ((packed)) geom_t;
+} __attribute__ ((packed));
 
-typedef struct eckd_home_t {
+struct eckd_home {
 	__u8 skip_control[14];
 	__u16 cell_number;
 	__u8 physical_addr[3];
 	__u8 flag;
-	ch_t track_addr;
+	struct ch_t track_addr;
 	__u8 reserved;
 	__u8 key_length;
 	__u8 reserved2[2];
-} __attribute__ ((packed)) eckd_home_t;
+} __attribute__ ((packed));
 
-typedef struct DE_eckd_data_t {
+struct DE_eckd_data {
 	struct {
 		unsigned char perm:2;	/* Permissions on this extent */
 		unsigned char reserved:1;
@@ -113,15 +110,15 @@
 	__u16 fast_write_id;
 	__u8 ga_additional;	/* Global Attributes Additional */
 	__u8 ga_extended;	/* Global Attributes Extended	*/
-	ch_t beg_ext;
-	ch_t end_ext;
+	struct ch_t beg_ext;
+	struct ch_t end_ext;
 	unsigned long long ep_sys_time; /* Extended Parameter - System Time Stamp */
 	__u8 ep_format;        /* Extended Parameter format byte       */
 	__u8 ep_prio;          /* Extended Parameter priority I/O byte */
 	__u8 ep_reserved[6];   /* Extended Parameter Reserved          */
-} __attribute__ ((packed)) DE_eckd_data_t;
+} __attribute__ ((packed));
 
-typedef struct LO_eckd_data_t {
+struct LO_eckd_data {
 	struct {
 		unsigned char orientation:2;
 		unsigned char operation:6;
@@ -133,13 +130,13 @@
 	} __attribute__ ((packed)) auxiliary;
 	__u8 unused;
 	__u8 count;
-	ch_t seek_addr;
-	chr_t search_arg;
+	struct ch_t seek_addr;
+	struct chr_t search_arg;
 	__u8 sector;
 	__u16 length;
-} __attribute__ ((packed)) LO_eckd_data_t;
+} __attribute__ ((packed));
 
-typedef struct dasd_eckd_characteristics_t {
+struct dasd_eckd_characteristics {
 	__u16 cu_type;
 	struct {
 		unsigned char support:2;
@@ -210,9 +207,9 @@
 	__u8 factor8;
 	__u8 reserved2[3];
 	__u8 reserved3[10];
-} __attribute__ ((packed)) dasd_eckd_characteristics_t;
+} __attribute__ ((packed));
 
-typedef struct dasd_eckd_confdata_t {
+struct dasd_eckd_confdata {
 	struct {
 		struct {
 			unsigned char identifier:2;
@@ -327,17 +324,17 @@
 		__u8 log_dev_address;
 		unsigned char reserved2[12];
 	} __attribute__ ((packed)) neq;
-} __attribute__ ((packed)) dasd_eckd_confdata_t;
+} __attribute__ ((packed));
 
 /*
  * Perform Subsystem Function - Prepare for Read Subsystem Data	 
  */
-typedef struct dasd_psf_prssd_data_t {
+struct dasd_psf_prssd_data {
 	unsigned char order;
 	unsigned char flags;
 	unsigned char reserved[4];
 	unsigned char suborder;
 	unsigned char varies[9];
-} __attribute__ ((packed)) dasd_psf_prssd_data_t;
+} __attribute__ ((packed));
 
 #endif				/* DASD_ECKD_H */
diff -urN linux-2.5.67/drivers/s390/block/dasd_erp.c linux-2.5.67-s390/drivers/s390/block/dasd_erp.c
--- linux-2.5.67/drivers/s390/block/dasd_erp.c	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_erp.c	Mon Apr 14 19:11:54 2003
@@ -7,14 +7,10 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.6 $
- *
- * History of changes
- * 05/04/02 split from dasd.c, code restructuring.
+ * $Revision: 1.9 $
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
 
@@ -27,12 +23,12 @@
 
 #include "dasd_int.h"
 
-dasd_ccw_req_t *
+struct dasd_ccw_req *
 dasd_alloc_erp_request(char *magic, int cplength, int datasize,
-		       dasd_device_t * device)
+		       struct dasd_device * device)
 {
 	unsigned long flags;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	char *data;
 	int size;
 
@@ -45,18 +41,19 @@
 	debug_int_event ( dasd_debug_area, 1, cplength);
 	debug_int_event ( dasd_debug_area, 1, datasize);
 
-	size = (sizeof(dasd_ccw_req_t) + 7L) & -8L;
+	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
 		size += cplength * sizeof(struct ccw1);
 	if (datasize > 0)
 		size += datasize;
 	spin_lock_irqsave(&device->mem_lock, flags);
-	cqr = (dasd_ccw_req_t *) dasd_alloc_chunk(&device->erp_chunks, size);
+	cqr = (struct dasd_ccw_req *)
+		dasd_alloc_chunk(&device->erp_chunks, size);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	if (cqr == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(dasd_ccw_req_t));
-	data = (char *) cqr + ((sizeof(dasd_ccw_req_t) + 7L) & -8L);
+	memset(cqr, 0, sizeof(struct dasd_ccw_req));
+	data = (char *) cqr + ((sizeof(struct dasd_ccw_req) + 7L) & -8L);
 	cqr->cpaddr = NULL;
 	if (cplength > 0) {
 		cqr->cpaddr = (struct ccw1 *) data;
@@ -75,7 +72,7 @@
 }
 
 void
-dasd_free_erp_request(dasd_ccw_req_t * cqr, dasd_device_t * device)
+dasd_free_erp_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
 {
 	unsigned long flags;
 
@@ -91,8 +88,8 @@
 
 /*
  * DESCRIPTION
- *   sets up the default-ERP dasd_ccw_req_t, namely one, which performs a TIC
- *   to the original channel program with a retry counter of 16
+ *   sets up the default-ERP struct dasd_ccw_req, namely one, which performs
+ *   a TIC to the original channel program with a retry counter of 16
  *
  * PARAMETER
  *   cqr		failed CQR
@@ -100,11 +97,11 @@
  * RETURN VALUES
  *   erp		CQR performing the ERP
  */
-dasd_ccw_req_t *
-dasd_default_erp_action(dasd_ccw_req_t * cqr)
+struct dasd_ccw_req *
+dasd_default_erp_action(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device;
-	dasd_ccw_req_t *erp;
+	struct dasd_device *device;
+	struct dasd_ccw_req *erp;
 
 	MESSAGE(KERN_DEBUG, "%s", "Default ERP called... ");
 	device = cqr->device;
@@ -147,10 +144,10 @@
  * RETURN VALUES
  *   cqr		pointer to the original CQR
  */
-dasd_ccw_req_t *
-dasd_default_erp_postaction(dasd_ccw_req_t * cqr)
+struct dasd_ccw_req *
+dasd_default_erp_postaction(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int success;
 
 	if (cqr->refers == NULL || cqr->function == NULL)
@@ -161,7 +158,7 @@
 
 	/* free all ERPs - but NOT the original cqr */
 	while (cqr->refers != NULL) {
-		dasd_ccw_req_t *refers;
+		struct dasd_ccw_req *refers;
 
 		refers = cqr->refers;
 		/* remove the request from the device queue */
@@ -189,7 +186,7 @@
  * real request.
  */
 static inline void
-hex_dump_memory(dasd_device_t *device, void *data, int len)
+hex_dump_memory(struct dasd_device *device, void *data, int len)
 {
 	int *pint;
 
@@ -203,9 +200,9 @@
 }
 
 void
-dasd_log_sense(dasd_ccw_req_t *cqr, struct irb *irb)
+dasd_log_sense(struct dasd_ccw_req *cqr, struct irb *irb)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = cqr->device;
 	/* dump sense data */
@@ -214,10 +211,10 @@
 }
 
 void
-dasd_log_ccw(dasd_ccw_req_t * cqr, int caller, __u32 cpa)
+dasd_log_ccw(struct dasd_ccw_req * cqr, int caller, __u32 cpa)
 {
-	dasd_device_t *device;
-	dasd_ccw_req_t *lcqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *lcqr;
 	struct ccw1 *ccw;
 	int cplength;
 
@@ -227,7 +224,7 @@
 		DEV_MESSAGE(KERN_ERR, device,
 			    "(%s) ERP chain report for req: %p",
 			    caller == 0 ? "EXAMINE" : "ACTION", lcqr);
-		hex_dump_memory(device, lcqr, sizeof(dasd_ccw_req_t));
+		hex_dump_memory(device, lcqr, sizeof(struct dasd_ccw_req));
 
 		cplength = 1;
 		ccw = lcqr->cpaddr;
diff -urN linux-2.5.67/drivers/s390/block/dasd_fba.c linux-2.5.67-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.67/drivers/s390/block/dasd_fba.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_fba.c	Mon Apr 14 19:11:54 2003
@@ -4,12 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.27 $
- *
- * History of changes
- *	    fixed partition handling and HDIO_GETGEO
- * 2002/01/04 Created 2.4-2.5 compatibility mode
- * 05/04/02 code restructuring.
+ * $Revision: 1.29 $
  */
 
 #include <linux/config.h>
@@ -44,11 +39,11 @@
 
 MODULE_LICENSE("GPL");
 
-static dasd_discipline_t dasd_fba_discipline;
+static struct dasd_discipline dasd_fba_discipline;
 
-typedef struct dasd_fba_private_t {
-	dasd_fba_characteristics_t rdc_data;
-} dasd_fba_private_t;
+struct dasd_fba_private {
+	struct dasd_fba_characteristics rdc_data;
+};
 
 static struct ccw_device_id dasd_fba_ids[] = {
 	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), driver_info: 0x1},
@@ -82,14 +77,14 @@
 };
 
 static inline void
-define_extent(struct ccw1 * ccw, DE_fba_data_t *data, int rw,
+define_extent(struct ccw1 * ccw, struct DE_fba_data *data, int rw,
 	      int blksize, int beg, int nr)
 {
 	ccw->cmd_code = DASD_FBA_CCW_DEFINE_EXTENT;
 	ccw->flags = 0;
 	ccw->count = 16;
 	ccw->cda = (__u32) __pa(data);
-	memset(data, 0, sizeof (DE_fba_data_t));
+	memset(data, 0, sizeof (struct DE_fba_data));
 	if (rw == WRITE)
 		(data->mask).perm = 0x0;
 	else if (rw == READ)
@@ -102,14 +97,14 @@
 }
 
 static inline void
-locate_record(struct ccw1 * ccw, LO_fba_data_t *data, int rw,
+locate_record(struct ccw1 * ccw, struct LO_fba_data *data, int rw,
 	      int block_nr, int block_ct)
 {
 	ccw->cmd_code = DASD_FBA_CCW_LOCATE;
 	ccw->flags = 0;
 	ccw->count = 8;
 	ccw->cda = (__u32) __pa(data);
-	memset(data, 0, sizeof (LO_fba_data_t));
+	memset(data, 0, sizeof (struct LO_fba_data));
 	if (rw == WRITE)
 		data->operation.cmd = 0x5;
 	else if (rw == READ)
@@ -121,16 +116,16 @@
 }
 
 static int
-dasd_fba_check_characteristics(struct dasd_device_t *device)
+dasd_fba_check_characteristics(struct dasd_device *device)
 {
-	dasd_fba_private_t *private;
+	struct dasd_fba_private *private;
 	struct ccw_device *cdev = device->cdev;	
 	void *rdc_data;
 	int rc;
 
-	private = (dasd_fba_private_t *) device->private;
+	private = (struct dasd_fba_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(dasd_fba_private_t), GFP_KERNEL);
+		private = kmalloc(sizeof(struct dasd_fba_private), GFP_KERNEL);
 		if (private == NULL) {
 			MESSAGE(KERN_WARNING, "%s",
 				"memory allocation failed for private data");
@@ -160,12 +155,12 @@
 }
 
 static int
-dasd_fba_do_analysis(struct dasd_device_t *device)
+dasd_fba_do_analysis(struct dasd_device *device)
 {
-	dasd_fba_private_t *private;
+	struct dasd_fba_private *private;
 	int sb, rc;
 
-	private = (dasd_fba_private_t *) device->private;
+	private = (struct dasd_fba_private *) device->private;
 	rc = dasd_check_blocksize(private->rdc_data.blk_size);
 	if (rc) {
 		DEV_MESSAGE(KERN_INFO, device, "unknown blocksize %d",
@@ -181,7 +176,7 @@
 }
 
 static int
-dasd_fba_fill_geometry(struct dasd_device_t *device, struct hd_geometry *geo)
+dasd_fba_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
 {
 	if (dasd_check_blocksize(device->bp_block) != 0)
 		return -EINVAL;
@@ -192,12 +187,12 @@
 }
 
 static dasd_era_t
-dasd_fba_examine_error(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_fba_examine_error(struct dasd_ccw_req * cqr, struct irb * irb)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	struct ccw_device *cdev;
 
-	device = (dasd_device_t *) cqr->device;
+	device = (struct dasd_device *) cqr->device;
 	if (irb->scsw.cstat == 0x00 &&
 	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
 		return dasd_era_none;
@@ -214,13 +209,13 @@
 }
 
 static dasd_erp_fn_t
-dasd_fba_erp_action(dasd_ccw_req_t * cqr)
+dasd_fba_erp_action(struct dasd_ccw_req * cqr)
 {
 	return dasd_default_erp_action;
 }
 
 static dasd_erp_fn_t
-dasd_fba_erp_postaction(dasd_ccw_req_t * cqr)
+dasd_fba_erp_postaction(struct dasd_ccw_req * cqr)
 {
 	if (cqr->function == dasd_default_erp_action)
 		return dasd_default_erp_postaction;
@@ -230,13 +225,13 @@
 	return NULL;
 }
 
-static dasd_ccw_req_t *
-dasd_fba_build_cp(dasd_device_t * device, struct request *req)
+static struct dasd_ccw_req *
+dasd_fba_build_cp(struct dasd_device * device, struct request *req)
 {
-	dasd_fba_private_t *private;
+	struct dasd_fba_private *private;
 	unsigned long *idaws;
-	LO_fba_data_t *LO_data;
-	dasd_ccw_req_t *cqr;
+	struct LO_fba_data *LO_data;
+	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 	struct bio *bio;
 	struct bio_vec *bv;
@@ -247,7 +242,7 @@
 	unsigned char cmd;
 	int i;
 
-	private = (dasd_fba_private_t *) device->private;
+	private = (struct dasd_fba_private *) device->private;
 	if (rq_data_dir(req) == READ) {
 		cmd = DASD_FBA_CCW_READ;
 	} else if (rq_data_dir(req) == WRITE) {
@@ -279,7 +274,7 @@
 	/* 1x define extent + 1x locate record + number of blocks */
 	cplength = 2 + count;
 	/* 1x define extent + 1x locate record */
-	datasize = sizeof(DE_fba_data_t) + sizeof(LO_fba_data_t) +
+	datasize = sizeof(struct DE_fba_data) + sizeof(struct LO_fba_data) +
 		cidaw * sizeof(unsigned long);
 	/*
 	 * Find out number of additional locate record ccws if the device
@@ -287,7 +282,7 @@
 	 */
 	if (private->rdc_data.mode.bits.data_chain == 0) {
 		cplength += count - 1;
-		datasize += (count - 1)*sizeof(LO_fba_data_t);
+		datasize += (count - 1)*sizeof(struct LO_fba_data);
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(dasd_fba_discipline.name,
@@ -299,8 +294,8 @@
 	define_extent(ccw++, cqr->data, rq_data_dir(req),
 		      device->bp_block, req->sector, req->nr_sectors);
 	/* Build locate_record + read/write ccws. */
-	idaws = (unsigned long *) (cqr->data + sizeof(DE_fba_data_t));
-	LO_data = (LO_fba_data_t *) (idaws + cidaw);
+	idaws = (unsigned long *) (cqr->data + sizeof(struct DE_fba_data));
+	LO_data = (struct LO_fba_data *) (idaws + cidaw);
 	/* Locate record for all blocks for smart devices. */
 	if (private->rdc_data.mode.bits.data_chain != 0) {
 		ccw[-1].flags |= CCW_FLAG_CC;
@@ -346,21 +341,22 @@
 }
 
 static int
-dasd_fba_fill_info(dasd_device_t * device, dasd_information2_t * info)
+dasd_fba_fill_info(struct dasd_device * device,
+		   struct dasd_information2_t * info)
 {
 	info->label_block = 1;
 	info->FBA_layout = 1;
 	info->format = DASD_FORMAT_LDL;
-	info->characteristics_size = sizeof(dasd_fba_characteristics_t);
+	info->characteristics_size = sizeof(struct dasd_fba_characteristics);
 	memcpy(info->characteristics,
-	       &((dasd_fba_private_t *) device->private)->rdc_data,
-	       sizeof (dasd_fba_characteristics_t));
+	       &((struct dasd_fba_private *) device->private)->rdc_data,
+	       sizeof (struct dasd_fba_characteristics));
 	info->confdata_size = 0;
 	return 0;
 }
 
 static void
-dasd_fba_dump_sense(struct dasd_device_t *device, dasd_ccw_req_t * req,
+dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		    struct irb *irb)
 {
 	char *page;
@@ -383,7 +379,7 @@
  * max_blocks is dependent on the amount of storage that is available
  * in the static io buffer for each device. Currently each device has
  * 8192 bytes (=2 pages). For 64 bit one dasd_mchunkt_t structure has
- * 24 bytes, the dasd_ccw_req_t has 136 bytes and each block can use
+ * 24 bytes, the struct dasd_ccw_req has 136 bytes and each block can use
  * up to 16 bytes (8 for the ccw and 8 for the idal pointer). In
  * addition we have one define extent ccw + 16 bytes of data and a 
  * locate record ccw for each block (stupid devices!) + 16 bytes of data.
@@ -393,7 +389,7 @@
  * start the next request if one finishes off. That makes 100.1 blocks
  * for one request. Give a little safety and the result is 96.
  */
-static dasd_discipline_t dasd_fba_discipline = {
+static struct dasd_discipline dasd_fba_discipline = {
 	.owner = THIS_MODULE,
 	.name = "FBA ",
 	.ebcname = "FBA ",
diff -urN linux-2.5.67/drivers/s390/block/dasd_fba.h linux-2.5.67-s390/drivers/s390/block/dasd_fba.h
--- linux-2.5.67/drivers/s390/block/dasd_fba.h	Mon Apr  7 19:33:02 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_fba.h	Mon Apr 14 19:11:54 2003
@@ -4,17 +4,13 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.4 $
- *
- * History of changes 
- * 
+ * $Revision: 1.6 $
  */
 
 #ifndef DASD_FBA_H
 #define DASD_FBA_H
 
-typedef
-    struct DE_fba_data_t {
+struct DE_fba_data {
 	struct {
 		unsigned char perm:2;	/* Permissions on this extent */
 		unsigned char zero:2;	/* Must be zero */
@@ -27,12 +23,9 @@
 	__u32 ext_loc;		/* Extent locator */
 	__u32 ext_beg;		/* logical number of block 0 in extent */
 	__u32 ext_end;		/* logocal number of last block in extent */
-} __attribute__ ((packed))
-
-    DE_fba_data_t;
+} __attribute__ ((packed));
 
-typedef
-    struct LO_fba_data_t {
+struct LO_fba_data {
 	struct {
 		unsigned char zero:4;
 		unsigned char cmd:4;
@@ -40,12 +33,9 @@
 	__u8 auxiliary;
 	__u16 blk_ct;
 	__u32 blk_nr;
-} __attribute__ ((packed))
+} __attribute__ ((packed));
 
-    LO_fba_data_t;
-
-typedef
-    struct dasd_fba_characteristics_t {
+struct dasd_fba_characteristics {
 	union {
 		__u8 c;
 		struct {
@@ -78,8 +68,6 @@
 	__u16 blk_ce;
 	__u32 reserved2;
 	__u16 reserved3;
-} __attribute__ ((packed))
-
-    dasd_fba_characteristics_t;
+} __attribute__ ((packed));
 
 #endif				/* DASD_FBA_H */
diff -urN linux-2.5.67/drivers/s390/block/dasd_genhd.c linux-2.5.67-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.67/drivers/s390/block/dasd_genhd.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_genhd.c	Mon Apr 14 19:11:54 2003
@@ -9,10 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.24 $
- *
- * History of changes
- * 05/04/02 split from dasd.c, code restructuring.
+ * $Revision: 1.29 $
  */
 
 #include <linux/config.h>
@@ -162,30 +159,6 @@
 }
 
 /*
- * Return devindex of first device using a specific major number.
- */
-static int dasd_gendisk_major_index(int major)
-{
-	struct list_head *l;
-	struct major_info *mi;
-	int devindex, rc;
-
-	spin_lock(&dasd_major_lock);
-	rc = -EINVAL;
-	devindex = 0;
-	list_for_each(l, &dasd_major_info) {
-		mi = list_entry(l, struct major_info, list);
-		if (mi->major == major) {
-			rc = devindex;
-			break;
-		}
-		devindex += DASD_PER_MAJOR;
-	}
-	spin_unlock(&dasd_major_lock);
-	return rc;
-}
-
-/*
  * Return major number for device with device index devindex.
  */
 int dasd_gendisk_index_major(int devindex)
@@ -210,7 +183,7 @@
  * Register disk to genhd. This will trigger a partition detection.
  */
 void
-dasd_setup_partitions(dasd_device_t * device)
+dasd_setup_partitions(struct dasd_device * device)
 {
 	/* Make the disk known. */
 	set_capacity(device->gdp, device->blocks << device->s2b_shift);
@@ -225,7 +198,7 @@
  * partitions unusable by setting their size to zero.
  */
 void
-dasd_destroy_partitions(dasd_device_t * device)
+dasd_destroy_partitions(struct dasd_device * device)
 {
 	del_gendisk(device->gdp);
 	put_disk(device->gdp);
diff -urN linux-2.5.67/drivers/s390/block/dasd_int.h linux-2.5.67-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.67/drivers/s390/block/dasd_int.h	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_int.h	Mon Apr 14 19:11:54 2003
@@ -6,12 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.38 $
- *
- * History of changes (starts July 2000)
- * 02/01/01 added dynamic registration of ioctls
- * 2002/01/04 Created 2.4-2.5 compatibility mode
- * 05/04/02 code restructuring.
+ * $Revision: 1.40 $
  */
 
 #ifndef DASD_INT_H
@@ -24,7 +19,7 @@
 
 /*
  * States a dasd device can have:
- *   new: the dasd_device_t structure is allocated.
+ *   new: the dasd_device structure is allocated.
  *   known: the discipline for the device is identified.
  *   basic: the device can do basic i/o.
  *   accept: the device is analysed (format is known).
@@ -70,16 +65,16 @@
 /*
  * SECTION: Type definitions
  */
-struct dasd_device_t;
+struct dasd_device;
 
 typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
 
-typedef struct {
+struct dasd_ioctl {
 	struct list_head list;
 	struct module *owner;
 	int no;
 	dasd_ioctl_fn_t handler;
-} dasd_ioctl_list_t;
+};
 
 typedef enum {
 	dasd_era_fatal = -1,	/* no chance to recover		     */
@@ -154,12 +149,12 @@
 	DBF_EVENT(DBF_ALERT, d_string, d_args); \
 } while(0)
 
-typedef struct dasd_ccw_req_t {
+struct dasd_ccw_req {
 	unsigned int magic;		/* Eye catcher */
         struct list_head list;		/* list_head for request queueing. */
 
 	/* Where to execute what... */
-	struct dasd_device_t *device;	/* device the request is for */
+	struct dasd_device *device;	/* device the request is for */
 	struct ccw1 *cpaddr;		/* address of channel program */
 	char status;	        	/* status of this request */
 	short retries;			/* A retry counter */
@@ -171,7 +166,7 @@
 
 	/* these are important for recovering erroneous requests          */
 	struct irb *dstat;		/* device status in case of an error */
-	struct dasd_ccw_req_t *refers;	/* ERP-chain queueing. */
+	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
 	void *function; 		/* originating ERP action */
 
 	unsigned long long buildclk;	/* TOD-clock of request generation */
@@ -180,12 +175,12 @@
 	unsigned long long endclk;	/* TOD-clock of request termination */
 
         /* Callback that is called after reaching final status. */
-        void (*callback)(struct dasd_ccw_req_t *, void *data);
+        void (*callback)(struct dasd_ccw_req *, void *data);
         void *callback_data;
-} dasd_ccw_req_t;
+};
 
 /* 
- * dasd_ccw_req_t -> status can be:
+ * dasd_ccw_req -> status can be:
  */
 #define DASD_CQR_FILLED   0x00	/* request is ready to be processed */
 #define DASD_CQR_QUEUED   0x01	/* request is queued to be processed */
@@ -196,15 +191,15 @@
 #define DASD_CQR_PENDING  0x06  /* request is waiting for interrupt - ERP only */ 
 
 /* Signature for error recovery functions. */
-typedef dasd_ccw_req_t *(*dasd_erp_fn_t) (dasd_ccw_req_t * cqr);
+typedef struct dasd_ccw_req *(*dasd_erp_fn_t) (struct dasd_ccw_req *);
 
 /*
- * the dasd_discipline_t is
+ * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
  * inheriting dasd...
  * no, currently we are not planning to reimplement the driver in C++
  */
-typedef struct dasd_discipline_t {
+struct dasd_discipline {
 	struct module *owner;
 	char ebcname[8];	/* a name used for tagging and printks */
 	char name[8];		/* a name used for tagging and printks */
@@ -223,8 +218,8 @@
          * -EAGAIN if do_analysis started a ccw that needs to complete
          * before the analysis may be repeated.
          */
-        int (*check_device)(struct dasd_device_t *);
-	int (*do_analysis) (struct dasd_device_t *);
+        int (*check_device)(struct dasd_device *);
+	int (*do_analysis) (struct dasd_device *);
 
         /*
          * Device operation functions. build_cp creates a ccw chain for
@@ -232,11 +227,12 @@
          * term_IO cancels it (e.g. in case of a timeout). format_device
          * returns a ccw chain to be used to format the device.
          */
-	dasd_ccw_req_t *(*build_cp) (struct dasd_device_t *, struct request *);
-	int (*start_IO) (dasd_ccw_req_t *);
-	int (*term_IO) (dasd_ccw_req_t *);
-	dasd_ccw_req_t *(*format_device) (struct dasd_device_t *,
-                                          struct format_data_t *);
+	struct dasd_ccw_req *(*build_cp) (struct dasd_device *,
+					  struct request *);
+	int (*start_IO) (struct dasd_ccw_req *);
+	int (*term_IO) (struct dasd_ccw_req *);
+	struct dasd_ccw_req *(*format_device) (struct dasd_device *,
+					       struct format_data_t *);
 
         /*
          * Error recovery functions. examine_error() returns a value that
@@ -247,25 +243,25 @@
          * is called for every error condition to print the sense data
          * to the console.
          */
-	dasd_era_t(*examine_error) (dasd_ccw_req_t *, struct irb *);
-	dasd_erp_fn_t(*erp_action) (dasd_ccw_req_t *);
-	dasd_erp_fn_t(*erp_postaction) (dasd_ccw_req_t *);
-	void (*dump_sense) (struct dasd_device_t *, dasd_ccw_req_t *,
+	dasd_era_t(*examine_error) (struct dasd_ccw_req *, struct irb *);
+	dasd_erp_fn_t(*erp_action) (struct dasd_ccw_req *);
+	dasd_erp_fn_t(*erp_postaction) (struct dasd_ccw_req *);
+	void (*dump_sense) (struct dasd_device *, struct dasd_ccw_req *,
 			    struct irb *);
 
         /* i/o control functions. */
-	int (*fill_geometry) (struct dasd_device_t *, struct hd_geometry *);
-	int (*fill_info) (struct dasd_device_t *, dasd_information2_t *);
-} dasd_discipline_t;
+	int (*fill_geometry) (struct dasd_device *, struct hd_geometry *);
+	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
+};
 
-extern dasd_discipline_t dasd_diag_discipline;
+extern struct dasd_discipline dasd_diag_discipline;
 #ifdef CONFIG_DASD_DIAG
 #define dasd_diag_discipline_pointer (&dasd_diag_discipline)
 #else
 #define dasd_diag_discipline_pointer (0)
 #endif
 
-typedef struct dasd_device_t {
+struct dasd_device {
 	/* Block device stuff. */
 	struct gendisk *gdp;
 	devfs_handle_t devfs_entry;
@@ -279,7 +275,7 @@
 
 
 	/* Device discipline stuff. */
-	dasd_discipline_t *discipline;
+	struct dasd_discipline *discipline;
 	char *private;
 
 	/* Device state and target state. */
@@ -307,23 +303,23 @@
 	struct ccw_device *cdev;
 
 #ifdef CONFIG_DASD_PROFILE
-	dasd_profile_info_t profile;
+	struct dasd_profile_info_t profile;
 #endif
-} dasd_device_t;
+};
 
-void dasd_put_device_wake(dasd_device_t *);
+void dasd_put_device_wake(struct dasd_device *);
 
 /*
  * Reference count inliners
  */
 static inline void
-dasd_get_device(dasd_device_t *device)
+dasd_get_device(struct dasd_device *device)
 {
 	atomic_inc(&device->ref_count);
 }
 
 static inline void
-dasd_put_device(dasd_device_t *device)
+dasd_put_device(struct dasd_device *device)
 {
 	if (atomic_dec_return(&device->ref_count) == 0)
 		dasd_put_device_wake(device);
@@ -333,40 +329,38 @@
  * The static memory in ccw_mem and erp_mem is managed by a sorted
  * list of free memory chunks.
  */
-typedef struct dasd_mchunk_t
+struct dasd_mchunk
 {
 	struct list_head list;
 	unsigned long size;
-} __attribute__ ((aligned(8))) dasd_mchunk_t;
+} __attribute__ ((aligned(8)));
 
 static inline void
 dasd_init_chunklist(struct list_head *chunk_list, void *mem,
 		    unsigned long size)
 {
-	dasd_mchunk_t *chunk;
+	struct dasd_mchunk *chunk;
 
 	INIT_LIST_HEAD(chunk_list);
-	chunk = (dasd_mchunk_t *) mem;
-	chunk->size = size - sizeof(dasd_mchunk_t);
+	chunk = (struct dasd_mchunk *) mem;
+	chunk->size = size - sizeof(struct dasd_mchunk);
 	list_add(&chunk->list, chunk_list);
 }
 
 static inline void *
 dasd_alloc_chunk(struct list_head *chunk_list, unsigned long size)
 {
-	dasd_mchunk_t *chunk, *tmp;
-	struct list_head *l;
+	struct dasd_mchunk *chunk, *tmp;
 
 	size = (size + 7L) & -8L;
-	list_for_each(l, chunk_list) {
-		chunk = list_entry(l, dasd_mchunk_t, list);
+	list_for_each_entry(chunk, chunk_list, list) {
 		if (chunk->size < size)
 			continue;
-		if (chunk->size > size + sizeof(dasd_mchunk_t)) {
+		if (chunk->size > size + sizeof(struct dasd_mchunk)) {
 			char *endaddr = (char *) (chunk + 1) + chunk->size;
-			tmp = (dasd_mchunk_t *) (endaddr - size) - 1;
+			tmp = (struct dasd_mchunk *) (endaddr - size) - 1;
 			tmp->size = size;
-			chunk->size -= size + sizeof(dasd_mchunk_t);
+			chunk->size -= size + sizeof(struct dasd_mchunk);
 			chunk = tmp;
 		} else
 			list_del(&chunk->list);
@@ -378,30 +372,31 @@
 static inline void
 dasd_free_chunk(struct list_head *chunk_list, void *mem)
 {
-	dasd_mchunk_t *chunk, *tmp;
+	struct dasd_mchunk *chunk, *tmp;
 	struct list_head *p, *left;
 
-	chunk = (dasd_mchunk_t *)((char *) mem - sizeof(dasd_mchunk_t));
+	chunk = (struct dasd_mchunk *)
+		((char *) mem - sizeof(struct dasd_mchunk));
 	/* Find out the left neighbour in chunk_list. */
 	left = chunk_list;
 	list_for_each(p, chunk_list) {
-		if (list_entry(p, dasd_mchunk_t, list) > chunk)
+		if (list_entry(p, struct dasd_mchunk, list) > chunk)
 			break;
 		left = p;
 	}
 	/* Try to merge with right neighbour = next element from left. */
 	if (left->next != chunk_list) {
-		tmp = list_entry(left->next, dasd_mchunk_t, list);
+		tmp = list_entry(left->next, struct dasd_mchunk, list);
 		if ((char *) (chunk + 1) + chunk->size == (char *) tmp) {
 			list_del(&tmp->list);
-			chunk->size += tmp->size + sizeof(dasd_mchunk_t);
+			chunk->size += tmp->size + sizeof(struct dasd_mchunk);
 		}
 	}
 	/* Try to merge with left neighbour. */
 	if (left != chunk_list) {
-		tmp = list_entry(left, dasd_mchunk_t, list);
+		tmp = list_entry(left, struct dasd_mchunk, list);
 		if ((char *) (tmp + 1) + tmp->size == (char *) chunk) {
-			tmp->size += chunk->size + sizeof(dasd_mchunk_t);
+			tmp->size += chunk->size + sizeof(struct dasd_mchunk);
 			return;
 		}
 	}
@@ -424,44 +419,44 @@
 #define DASD_PROFILE_OFF 0
 
 extern debug_info_t *dasd_debug_area;
-extern dasd_profile_info_t dasd_global_profile;
+extern struct dasd_profile_info_t dasd_global_profile;
 extern unsigned int dasd_profile_level;
 extern struct block_device_operations dasd_device_operations;
 
-dasd_ccw_req_t *dasd_kmalloc_request(char *, int, int, dasd_device_t *); /* unused */
-dasd_ccw_req_t *dasd_smalloc_request(char *, int, int, dasd_device_t *);
-void dasd_kfree_request(dasd_ccw_req_t *, dasd_device_t *);
-void dasd_sfree_request(dasd_ccw_req_t *, dasd_device_t *);
+struct dasd_ccw_req *
+dasd_kmalloc_request(char *, int, int, struct dasd_device *);
+struct dasd_ccw_req *
+dasd_smalloc_request(char *, int, int, struct dasd_device *);
+void dasd_kfree_request(struct dasd_ccw_req *, struct dasd_device *);
+void dasd_sfree_request(struct dasd_ccw_req *, struct dasd_device *);
 
 static inline int
-dasd_kmalloc_set_cda(struct ccw1 *ccw, void *cda, dasd_device_t *device)
+dasd_kmalloc_set_cda(struct ccw1 *ccw, void *cda, struct dasd_device *device)
 {
 	return set_normalized_cda(ccw, cda);
 }
 
-dasd_device_t *dasd_alloc_device(unsigned int devindex);
-void dasd_free_device(dasd_device_t *);
+struct dasd_device *dasd_alloc_device(unsigned int devindex);
+void dasd_free_device(struct dasd_device *);
 
-void dasd_enable_device(dasd_device_t *);
-void dasd_set_target_state(dasd_device_t *, int);
-void dasd_kick_device(dasd_device_t *);
-
-void dasd_add_request_head(dasd_ccw_req_t *);
-void dasd_add_request_tail(dasd_ccw_req_t *); /* unused */
-int  dasd_start_IO(dasd_ccw_req_t *);
-int  dasd_term_IO(dasd_ccw_req_t *);
-void dasd_schedule_bh(dasd_device_t *);
-int  dasd_sleep_on(dasd_ccw_req_t *);
-int  dasd_sleep_on_immediatly(dasd_ccw_req_t *);
-int  dasd_sleep_on_interruptible(dasd_ccw_req_t *);
-void dasd_set_timer(dasd_device_t *, int);
-void dasd_clear_timer(dasd_device_t *);
-int  dasd_cancel_req(dasd_ccw_req_t *); /* unused */
-int dasd_generic_probe (struct ccw_device *cdev, 
-			dasd_discipline_t *discipline);
+void dasd_enable_device(struct dasd_device *);
+void dasd_set_target_state(struct dasd_device *, int);
+void dasd_kick_device(struct dasd_device *);
+
+void dasd_add_request_head(struct dasd_ccw_req *);
+void dasd_add_request_tail(struct dasd_ccw_req *);
+int  dasd_start_IO(struct dasd_ccw_req *);
+int  dasd_term_IO(struct dasd_ccw_req *);
+void dasd_schedule_bh(struct dasd_device *);
+int  dasd_sleep_on(struct dasd_ccw_req *);
+int  dasd_sleep_on_immediatly(struct dasd_ccw_req *);
+int  dasd_sleep_on_interruptible(struct dasd_ccw_req *);
+void dasd_set_timer(struct dasd_device *, int);
+void dasd_clear_timer(struct dasd_device *);
+int  dasd_cancel_req(struct dasd_ccw_req *);
+int dasd_generic_probe (struct ccw_device *, struct dasd_discipline *);
 int dasd_generic_remove (struct ccw_device *cdev);
-int dasd_generic_set_online(struct ccw_device *cdev, 
-			    dasd_discipline_t *discipline);
+int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
 int dasd_generic_set_offline (struct ccw_device *cdev);
 void dasd_generic_auto_online (struct ccw_driver *);
 
@@ -473,11 +468,11 @@
 int dasd_devmap_init(void);
 void dasd_devmap_exit(void);
 
-dasd_device_t *dasd_create_device(struct ccw_device *);
-void dasd_delete_device(dasd_device_t *);
+struct dasd_device *dasd_create_device(struct ccw_device *);
+void dasd_delete_device(struct dasd_device *);
 
-kdev_t dasd_get_kdev(dasd_device_t *);
-dasd_device_t *dasd_device_from_devindex(int);
+kdev_t dasd_get_kdev(struct dasd_device *);
+struct dasd_device *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
 int dasd_add_range(int, int, int);
@@ -488,8 +483,8 @@
 void dasd_gendisk_exit(void);
 int  dasd_gendisk_index_major(int);
 struct gendisk *dasd_gendisk_alloc(int);
-void dasd_setup_partitions(dasd_device_t *);
-void dasd_destroy_partitions(dasd_device_t *);
+void dasd_setup_partitions(struct dasd_device *);
+void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
 int  dasd_ioctl_init(void);
@@ -503,26 +498,26 @@
 void dasd_proc_exit(void);
 
 /* externals in dasd_erp.c */
-dasd_ccw_req_t *dasd_default_erp_action(dasd_ccw_req_t *);
-dasd_ccw_req_t *dasd_default_erp_postaction(dasd_ccw_req_t *);
-dasd_ccw_req_t *dasd_alloc_erp_request(char *, int, int, dasd_device_t *);
-void dasd_free_erp_request(dasd_ccw_req_t *, dasd_device_t *);
-void dasd_log_sense(dasd_ccw_req_t *, struct irb *);
-void dasd_log_ccw(dasd_ccw_req_t *, int, __u32);
+struct dasd_ccw_req *dasd_default_erp_action(struct dasd_ccw_req *);
+struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *);
+struct dasd_ccw_req *dasd_alloc_erp_request(char *, int, int, struct dasd_device *);
+void dasd_free_erp_request(struct dasd_ccw_req *, struct dasd_device *);
+void dasd_log_sense(struct dasd_ccw_req *, struct irb *);
+void dasd_log_ccw(struct dasd_ccw_req *, int, __u32);
 
 /* externals in dasd_3370_erp.c */
-dasd_era_t dasd_3370_erp_examine(dasd_ccw_req_t *, struct irb *);
+dasd_era_t dasd_3370_erp_examine(struct dasd_ccw_req *, struct irb *);
 
 /* externals in dasd_3990_erp.c */
-dasd_era_t dasd_3990_erp_examine(dasd_ccw_req_t *, struct irb *);
-dasd_ccw_req_t *dasd_3990_erp_action(dasd_ccw_req_t *);
+dasd_era_t dasd_3990_erp_examine(struct dasd_ccw_req *, struct irb *);
+struct dasd_ccw_req *dasd_3990_erp_action(struct dasd_ccw_req *);
 
 /* externals in dasd_9336_erp.c */
-dasd_era_t dasd_9336_erp_examine(dasd_ccw_req_t *, struct irb *);
+dasd_era_t dasd_9336_erp_examine(struct dasd_ccw_req *, struct irb *);
 
 /* externals in dasd_9336_erp.c */
-dasd_era_t dasd_9343_erp_examine(dasd_ccw_req_t *, struct irb *);
-dasd_ccw_req_t *dasd_9343_erp_action(dasd_ccw_req_t *);
+dasd_era_t dasd_9343_erp_examine(struct dasd_ccw_req *, struct irb *);
+struct dasd_ccw_req *dasd_9343_erp_action(struct dasd_ccw_req *);
 
 #endif				/* __KERNEL__ */
 
diff -urN linux-2.5.67/drivers/s390/block/dasd_ioctl.c linux-2.5.67-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.67/drivers/s390/block/dasd_ioctl.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_ioctl.c	Mon Apr 14 19:11:54 2003
@@ -8,8 +8,6 @@
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
  * i/o controls for the dasd driver.
- *
- * 05/04/02 split from dasd.c, code restructuring.
  */
 #include <linux/config.h>
 #include <linux/interrupt.h>
@@ -34,15 +32,14 @@
 /*
  * Find the ioctl with number no.
  */
-static dasd_ioctl_list_t *
+static struct dasd_ioctl *
 dasd_find_ioctl(int no)
 {
-	struct list_head *curr;
-	list_for_each (curr, &dasd_ioctl_list) {
-		if (list_entry (curr, dasd_ioctl_list_t, list)->no == no) {
-			return list_entry (curr, dasd_ioctl_list_t, list);
-		}
-	}
+	struct dasd_ioctl *ioctl;
+
+	list_for_each_entry (ioctl, &dasd_ioctl_list, list)
+		if (ioctl->no == no)
+			return ioctl;
 	return NULL;
 }
 
@@ -52,10 +49,10 @@
 int
 dasd_ioctl_no_register(struct module *owner, int no, dasd_ioctl_fn_t handler)
 {
-	dasd_ioctl_list_t *new;
+	struct dasd_ioctl *new;
 	if (dasd_find_ioctl(no))
 		return -EBUSY;
-	new = kmalloc(sizeof (dasd_ioctl_list_t), GFP_KERNEL);
+	new = kmalloc(sizeof (struct dasd_ioctl), GFP_KERNEL);
 	if (new == NULL)
 		return -ENOMEM;
 	new->owner = owner;
@@ -72,7 +69,7 @@
 int
 dasd_ioctl_no_unregister(struct module *owner, int no, dasd_ioctl_fn_t handler)
 {
-	dasd_ioctl_list_t *old = dasd_find_ioctl(no);
+	struct dasd_ioctl *old = dasd_find_ioctl(no);
 	if (old == NULL)
 		return -ENOENT;
 	if (old->no != no || old->handler != handler || owner != old->owner)
@@ -88,9 +85,8 @@
 	   unsigned int no, unsigned long data)
 {
 	struct block_device *bdev = inp->i_bdev;
-	dasd_device_t *device = bdev->bd_disk->private_data;
-	dasd_ioctl_list_t *ioctl;
-	struct list_head *l;
+	struct dasd_device *device = bdev->bd_disk->private_data;
+	struct dasd_ioctl *ioctl;
 	const char *dir;
 	int rc;
 
@@ -106,8 +102,7 @@
 		      "ioctl 0x%08x %s'0x%x'%d(%d) with data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
 	/* Search for ioctl no in the ioctl list. */
-	list_for_each(l, &dasd_ioctl_list) {
-		ioctl = list_entry(l, dasd_ioctl_list_t, list);
+	list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
 		if (ioctl->no == no) {
 			/* Found a matching ioctl. Call it. */
 			if (!try_module_get(ioctl->owner))
@@ -139,7 +134,7 @@
 static int
 dasd_ioctl_enable(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -156,7 +151,7 @@
 static int
 dasd_ioctl_disable(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -182,9 +177,9 @@
  * devices this means CCWs are generated to format a single track.
  */
 static int
-dasd_format(dasd_device_t * device, format_data_t * fdata)
+dasd_format(struct dasd_device * device, struct format_data_t * fdata)
 {
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (device->discipline->format_device == NULL)
@@ -226,8 +221,8 @@
 static int
 dasd_ioctl_format(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	format_data_t fdata;
+	struct dasd_device *device;
+	struct format_data_t fdata;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -240,7 +235,8 @@
 		return -ENODEV;
 	if (device->ro_flag)
 		return -EROFS;
-	if (copy_from_user(&fdata, (void *) args, sizeof (format_data_t)))
+	if (copy_from_user(&fdata, (void *) args,
+			   sizeof (struct format_data_t)))
 		return -EFAULT;
 	if (bdev != bdev->bd_contains) {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
@@ -257,7 +253,7 @@
 static int
 dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -266,7 +262,7 @@
 	if (device == NULL)
 		return -ENODEV;
 
-	memset(&device->profile, 0, sizeof (dasd_profile_info_t));
+	memset(&device->profile, 0, sizeof (struct dasd_profile_info_t));
 	return 0;
 }
 
@@ -276,14 +272,14 @@
 static int
 dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = bdev->bd_disk->private_data;
 	if (device == NULL)
 		return -ENODEV;
 
 	if (copy_to_user((long *) args, (long *) &device->profile,
-			 sizeof (dasd_profile_info_t)))
+			 sizeof (struct dasd_profile_info_t)))
 		return -EFAULT;
 	return 0;
 }
@@ -307,8 +303,8 @@
 static int
 dasd_ioctl_information(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
-	dasd_information2_t *dasd_info;
+	struct dasd_device *device;
+	struct dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
 	struct ccw_device *cdev;
@@ -320,7 +316,7 @@
 	if (!device->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
+	dasd_info = kmalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
 	if (dasd_info == NULL)
 		return -ENOMEM;
 
@@ -379,8 +375,8 @@
 	rc = 0;
 	if (copy_to_user((long *) args, (long *) dasd_info,
 			 ((no == (unsigned int) BIODASDINFO2) ?
-			  sizeof (dasd_information2_t) :
-			  sizeof (dasd_information_t))))
+			  sizeof (struct dasd_information2_t) :
+			  sizeof (struct dasd_information_t))))
 		rc = -EFAULT;
 	kfree(dasd_info);
 	return rc;
@@ -392,7 +388,7 @@
 static int
 dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int intval;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -417,7 +413,7 @@
 dasd_ioctl_getgeo(struct block_device *bdev, int no, long args)
 {
 	struct hd_geometry geo = { 0, };
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device =  bdev->bd_disk->private_data;
 	if (device == NULL)
diff -urN linux-2.5.67/drivers/s390/block/dasd_proc.c linux-2.5.67-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.67/drivers/s390/block/dasd_proc.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_proc.c	Mon Apr 14 19:11:54 2003
@@ -9,14 +9,10 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.18 $
- *
- * History of changes
- * 05/04/02 split from dasd.c, code restructuring.
+ * $Revision: 1.21 $
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
@@ -56,7 +52,7 @@
 static int
 dasd_devices_show(struct seq_file *m, void *v)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	char *substr;
 
 	device = dasd_device_from_devindex((unsigned long) v - 1);
@@ -186,7 +182,7 @@
 {
 	unsigned long len;
 #ifdef CONFIG_DASD_PROFILE
-	dasd_profile_info_t *prof;
+	struct dasd_profile_info_t *prof;
 	char *str;
 	int shift;
 
@@ -263,14 +259,15 @@
 		} else if (strcmp(str, "off") == 0) {
 			/* switch off and reset statistics profiling */
 			memset(&dasd_global_profile,
-			       0, sizeof (dasd_profile_info_t));
+			       0, sizeof (struct dasd_profile_info_t));
 			dasd_profile_level = DASD_PROFILE_OFF;
 			MESSAGE(KERN_INFO, "%s", "Statictics switched off");
 		} else
 			goto out_error;
 	} else if (strncmp(str, "reset", 5) == 0) {
 		/* reset the statistics */
-		memset(&dasd_global_profile, 0, sizeof (dasd_profile_info_t));
+		memset(&dasd_global_profile, 0,
+		       sizeof (struct dasd_profile_info_t));
 		MESSAGE(KERN_INFO, "%s", "Statictics reset");
 	} else
 		goto out_error;

