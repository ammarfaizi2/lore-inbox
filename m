Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVJ1OJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVJ1OJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVJ1OJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:09:27 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:54656 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030182AbVJ1OJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:09:24 -0400
Date: Fri, 28 Oct 2005 16:09:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 9/14] s390: dasd diag inline assembly.
Message-ID: <20051028140930.GI7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 9/14] s390: dasd diag inline assembly.

Future versions of gcc may remove initialization code for control
blocks used by the diag250 inline assembly due to incompletely
specified constraints. This may lead to erratic behavior.
Fix the diag250 inline assembly constraints.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_diag.c |   16 ++++++++--------
 drivers/s390/block/dasd_diag.h |   10 +++++-----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-10-28 14:04:51.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.49 $
+ * $Revision: 1.50 $
  */
 
 #include <linux/config.h>
@@ -67,9 +67,9 @@ static const u8 DASD_DIAG_CMS1[] = { 0xc
 static __inline__ int
 dia250(void *iob, int cmd)
 {
-	typedef struct {
-		char _[max(sizeof (struct dasd_diag_init_io),
-			   sizeof (struct dasd_diag_rw_io))];
+	typedef union {
+		struct dasd_diag_init_io init_io;
+		struct dasd_diag_rw_io rw_io;
 	} addr_type;
 	int rc;
 
@@ -190,7 +190,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	private->iob.flags = DASD_DIAG_RWFLAG_ASYNC;
 	private->iob.block_count = dreq->block_count;
 	private->iob.interrupt_params = (addr_t) cqr;
-	private->iob.bio_list = __pa(dreq->bio);
+	private->iob.bio_list = dreq->bio;
 	private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 
 	cqr->startclk = get_clock();
@@ -394,14 +394,14 @@ dasd_diag_check_device(struct dasd_devic
 		memset(&bio, 0, sizeof (struct dasd_diag_bio));
 		bio.type = MDSK_READ_REQ;
 		bio.block_number = private->pt_block + 1;
-		bio.buffer = __pa(label);
+		bio.buffer = label;
 		memset(&private->iob, 0, sizeof (struct dasd_diag_rw_io));
 		private->iob.dev_nr = rdc_data->dev_nr;
 		private->iob.key = 0;
 		private->iob.flags = 0;	/* do synchronous io */
 		private->iob.block_count = 1;
 		private->iob.interrupt_params = 0;
-		private->iob.bio_list = __pa(&bio);
+		private->iob.bio_list = &bio;
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
 		if (rc == 0 || rc == 3)
@@ -529,7 +529,7 @@ dasd_diag_build_cp(struct dasd_device * 
 				memset(dbio, 0, sizeof (struct dasd_diag_bio));
 				dbio->type = rw_cmd;
 				dbio->block_number = recid + 1;
-				dbio->buffer = __pa(dst);
+				dbio->buffer = dst;
 				dbio++;
 				dst += blksize;
 				recid++;
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2005-10-28 14:04:51.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.7 $
+ * $Revision: 1.8 $
  */
 
 #define MDSK_WRITE_REQ 0x01
@@ -78,7 +78,7 @@ struct dasd_diag_bio {
 	u8 spare1[2];
 	u32 alet;
 	blocknum_t block_number;
-	u64 buffer;
+	void *buffer;
 } __attribute__ ((packed, aligned(8)));
 
 struct dasd_diag_init_io {
@@ -104,7 +104,7 @@ struct dasd_diag_rw_io {
 	u32 alet;
 	u8  spare3[4];
 	u64 interrupt_params;
-	u64 bio_list;
+	struct dasd_diag_bio *bio_list;
 	u8  spare4[8];
 } __attribute__ ((packed, aligned(8)));
 #else /* CONFIG_ARCH_S390X */
@@ -119,7 +119,7 @@ struct dasd_diag_bio {
 	u16 spare1;
 	blocknum_t block_number;
 	u32 alet;
-	u32 buffer;
+	void *buffer;
 } __attribute__ ((packed, aligned(8)));
 
 struct dasd_diag_init_io {
@@ -142,7 +142,7 @@ struct dasd_diag_rw_io {
 	u8 spare2[2];
 	u32 block_count;
 	u32 alet;
-	u32 bio_list;
+	struct dasd_diag_bio *bio_list;
 	u32 interrupt_params;
 	u8 spare3[20];
 } __attribute__ ((packed, aligned(8)));
