Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVJ1OJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVJ1OJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVJ1OJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:09:41 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:30652 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030183AbVJ1OJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:09:39 -0400
Date: Fri, 28 Oct 2005 16:09:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 10/14] s390: dasd diag with block sizes > 512.
Message-ID: <20051028140946.GJ7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 10/14] s390: dasd diag with block sizes > 512.

Access to FBA disks via DIAG fails for block sizes > 512 byte.
The device analysis code of the DIAG discipline does not properly
initialize the DIAG250 device environment after completion of the
analysis. This results in VM only serving 512 bytes per block I/O
request whereas Linux expects larger block sizes.
Add proper device environment setup to end of analysis code.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_diag.c |   50 ++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-10-28 14:04:52.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-10-28 14:04:52.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.50 $
+ * $Revision: 1.51 $
  */
 
 #include <linux/config.h>
@@ -404,37 +404,47 @@ dasd_diag_check_device(struct dasd_devic
 		private->iob.bio_list = &bio;
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
-		if (rc == 0 || rc == 3)
-			break;
+		if (rc == 3) {
+			DEV_MESSAGE(KERN_WARNING, device, "%s",
+				"DIAG call failed");
+			rc = -EOPNOTSUPP;
+			goto out;
+		}
 		mdsk_term_io(device);
+		if (rc == 0)
+			break;
 	}
-	if (rc == 3) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s", "DIAG call failed");
-		rc = -EOPNOTSUPP;
-	} else if (rc != 0) {
+	if (bsize > PAGE_SIZE) {
 		DEV_MESSAGE(KERN_WARNING, device, "device access failed "
 			    "(rc=%d)", rc);
 		rc = -EIO;
+		goto out;
+	}
+	/* check for label block */
+	if (memcmp(label->label_id, DASD_DIAG_CMS1,
+		  sizeof(DASD_DIAG_CMS1)) == 0) {
+		/* get formatted blocksize from label block */
+		bsize = (unsigned int) label->block_size;
+		device->blocks = (unsigned long) label->block_count;
+	} else
+		device->blocks = end_block;
+	device->bp_block = bsize;
+	device->s2b_shift = 0;	/* bits to shift 512 to get a block */
+	for (sb = 512; sb < bsize; sb = sb << 1)
+		device->s2b_shift++;
+	rc = mdsk_init_io(device, device->bp_block, 0, NULL);
+	if (rc) {
+		DEV_MESSAGE(KERN_WARNING, device, "DIAG initialization "
+			"failed (rc=%d)", rc);
+		rc = -EIO;
 	} else {
-		if (memcmp(label->label_id, DASD_DIAG_CMS1,
-			  sizeof(DASD_DIAG_CMS1)) == 0) {
-			/* get formatted blocksize from label block */
-			bsize = (unsigned int) label->block_size;
-			device->blocks = (unsigned long) label->block_count;
-		} else
-			device->blocks = end_block;
-		device->bp_block = bsize;
-		device->s2b_shift = 0;	/* bits to shift 512 to get a block */
-		for (sb = 512; sb < bsize; sb = sb << 1)
-			device->s2b_shift++;
-		
 		DEV_MESSAGE(KERN_INFO, device,
 			    "(%ld B/blk): %ldkB",
 			    (unsigned long) device->bp_block,
 			    (unsigned long) (device->blocks <<
 				device->s2b_shift) >> 1);
-		rc = 0;
 	}
+out:
 	free_page((long) label);
 	return rc;
 }
