Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVH2RzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVH2RzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVH2RzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:55:06 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:49631 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751201AbVH2Ry7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:54:59 -0400
Date: Mon, 29 Aug 2005 19:54:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/10] s390: 64 bit diag250 support.
Message-ID: <20050829175454.GD6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/10] s390: 64 bit diag250 support.

From: Horst Hummel <horst.hummel@de.ibm.com>

Add support for diag 250 access to dasd devices for 64 bit kernels.
In addition fix detach/attach for diag disks. The VM control block
needs to get recreated by a call to mdsk_init_io.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/Kconfig     |    2 
 drivers/s390/block/dasd_diag.c |  332 ++++++++++++++++++++++++++---------------
 drivers/s390/block/dasd_diag.h |  105 +++++++++++-
 3 files changed, 306 insertions(+), 133 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-08-29 19:18:07.000000000 +0200
@@ -6,17 +6,18 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.42 $
+ * $Revision: 1.49 $
  */
 
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/hdreg.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
@@ -28,58 +29,89 @@
 #include "dasd_int.h"
 #include "dasd_diag.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
 #define PRINTK_HEADER "dasd(diag):"
 
 MODULE_LICENSE("GPL");
 
+/* The maximum number of blocks per request (max_blocks) is dependent on the
+ * amount of storage that is available in the static I/O buffer for each
+ * device. Currently each device gets 2 pages. We want to fit two requests
+ * into the available memory so that we can immediately start the next if one
+ * finishes. */
+#define DIAG_MAX_BLOCKS	(((2 * PAGE_SIZE - sizeof(struct dasd_ccw_req) - \
+			   sizeof(struct dasd_diag_req)) / \
+		           sizeof(struct dasd_diag_bio)) / 2)
+#define DIAG_MAX_RETRIES	32
+#define DIAG_TIMEOUT		50 * HZ
+
 struct dasd_discipline dasd_diag_discipline;
 
 struct dasd_diag_private {
 	struct dasd_diag_characteristics rdc_data;
 	struct dasd_diag_rw_io iob;
 	struct dasd_diag_init_io iib;
-	unsigned int pt_block;
+	blocknum_t pt_block;
 };
 
 struct dasd_diag_req {
-	int block_count;
+	unsigned int block_count;
 	struct dasd_diag_bio bio[0];
 };
 
+static const u8 DASD_DIAG_CMS1[] = { 0xc3, 0xd4, 0xe2, 0xf1 };/* EBCDIC CMS1 */
+
+/* Perform DIAG250 call with block I/O parameter list iob (input and output)
+ * and function code cmd.
+ * In case of an exception return 3. Otherwise return result of bitwise OR of
+ * resulting condition code and DIAG return code. */
 static __inline__ int
 dia250(void *iob, int cmd)
 {
+	typedef struct {
+		char _[max(sizeof (struct dasd_diag_init_io),
+			   sizeof (struct dasd_diag_rw_io))];
+	} addr_type;
 	int rc;
 
-	__asm__ __volatile__("    lhi   %0,3\n"
-			     "	  lr	0,%2\n"
-			     "	  diag	0,%1,0x250\n"
-			     "0:  ipm	%0\n"
-			     "	  srl	%0,28\n"
-			     "	  or	%0,1\n"
-			     "1:\n"
-#ifndef CONFIG_ARCH_S390X
-			     ".section __ex_table,\"a\"\n"
-			     "	  .align 4\n"
-			     "	  .long 0b,1b\n"
-			     ".previous\n"
+	__asm__ __volatile__(
+#ifdef CONFIG_ARCH_S390X
+		"	lghi	%0,3\n"
+		"	lgr	0,%3\n"
+		"	diag	0,%2,0x250\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"	or	%0,1\n"
+		"1:\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 8\n"
+		"	.quad  0b,1b\n"
+		".previous\n"
 #else
-			     ".section __ex_table,\"a\"\n"
-			     "	  .align 8\n"
-			     "	  .quad  0b,1b\n"
-			     ".previous\n"
+		"	lhi	%0,3\n"
+		"	lr	0,%3\n"
+		"	diag	0,%2,0x250\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"	or	%0,1\n"
+		"1:\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 0b,1b\n"
+		".previous\n"
 #endif
-			     : "=&d" (rc)
-			     : "d" (cmd), "d" ((void *) __pa(iob))
-			     : "0", "1", "cc");
+		: "=&d" (rc), "=m" (*(addr_type *) iob)
+		: "d" (cmd), "d" (iob), "m" (*(addr_type *) iob)
+		: "0", "1", "cc");
 	return rc;
 }
 
+/* Initialize block I/O to DIAG device using the specified blocksize and
+ * block offset. On success, return zero and set end_block to contain the
+ * number of blocks on the device minus the specified offset. Return non-zero
+ * otherwise. */
 static __inline__ int
-mdsk_init_io(struct dasd_device * device, int blocksize, int offset, int size)
+mdsk_init_io(struct dasd_device *device, unsigned int blocksize,
+	     blocknum_t offset, blocknum_t *end_block)
 {
 	struct dasd_diag_private *private;
 	struct dasd_diag_init_io *iib;
@@ -92,14 +124,18 @@ mdsk_init_io(struct dasd_device * device
 	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	iib->block_size = blocksize;
 	iib->offset = offset;
-	iib->start_block = 0;
-	iib->end_block = size;
+	iib->flaga = DASD_DIAG_FLAGA_DEFAULT;
 
 	rc = dia250(iib, INIT_BIO);
 
-	return rc & 3;
+	if ((rc & 3) == 0 && end_block)
+		*end_block = iib->end_block;
+
+	return rc;
 }
 
+/* Remove block I/O environment for device. Return zero on success, non-zero
+ * otherwise. */
 static __inline__ int
 mdsk_term_io(struct dasd_device * device)
 {
@@ -112,9 +148,25 @@ mdsk_term_io(struct dasd_device * device
 	memset(iib, 0, sizeof (struct dasd_diag_init_io));
 	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	rc = dia250(iib, TERM_BIO);
-	return rc & 3;
+	return rc;
+}
+
+/* Error recovery for failed DIAG requests - try to reestablish the DIAG
+ * environment. */
+static void
+dasd_diag_erp(struct dasd_device *device)
+{
+	int rc;
+
+	mdsk_term_io(device);
+	rc = mdsk_init_io(device, device->bp_block, 0, NULL);
+	if (rc)
+		DEV_MESSAGE(KERN_WARNING, device, "DIAG ERP unsuccessful, "
+			    "rc=%d", rc);
 }
 
+/* Start a given request at the device. Return zero on success, non-zero
+ * otherwise. */
 static int
 dasd_start_diag(struct dasd_ccw_req * cqr)
 {
@@ -124,32 +176,66 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	int rc;
 
 	device = cqr->device;
+	if (cqr->retries < 0) {
+		DEV_MESSAGE(KERN_WARNING, device, "DIAG start_IO: request %p "
+			    "- no retry left)", cqr);
+		cqr->status = DASD_CQR_FAILED;
+		return -EIO;
+	}
 	private = (struct dasd_diag_private *) device->private;
 	dreq = (struct dasd_diag_req *) cqr->data;
 
 	private->iob.dev_nr = _ccw_device_get_device_number(device->cdev);
 	private->iob.key = 0;
-	private->iob.flags = 2;	/* do asynchronous io */
+	private->iob.flags = DASD_DIAG_RWFLAG_ASYNC;
 	private->iob.block_count = dreq->block_count;
-	private->iob.interrupt_params = (u32)(addr_t) cqr;
+	private->iob.interrupt_params = (addr_t) cqr;
 	private->iob.bio_list = __pa(dreq->bio);
+	private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 
 	cqr->startclk = get_clock();
+	cqr->starttime = jiffies;
+	cqr->retries--;
 
 	rc = dia250(&private->iob, RW_BIO);
-	if (rc > 8) {
-		DEV_MESSAGE(KERN_WARNING, device, "dia250 returned CC %d", rc);
-		cqr->status = DASD_CQR_ERROR;
-	} else if (rc == 0) {
+	switch (rc) {
+	case 0: /* Synchronous I/O finished successfully */
+		cqr->stopclk = get_clock();
 		cqr->status = DASD_CQR_DONE;
-		dasd_schedule_bh(device);
-	} else {
+		/* Indicate to calling function that only a dasd_schedule_bh()
+		   and no timer is needed */
+                rc = -EACCES;
+		break;
+	case 8: /* Asynchronous I/O was started */
 		cqr->status = DASD_CQR_IN_IO;
 		rc = 0;
+		break;
+	default: /* Error condition */
+		cqr->status = DASD_CQR_QUEUED;
+		DEV_MESSAGE(KERN_WARNING, device, "dia250 returned rc=%d", rc);
+		dasd_diag_erp(device);
+		rc = -EIO;
+		break;
 	}
 	return rc;
 }
 
+/* Terminate given request at the device. */
+static int
+dasd_diag_term_IO(struct dasd_ccw_req * cqr)
+{
+	struct dasd_device *device;
+
+	device = cqr->device;
+	mdsk_term_io(device);
+	mdsk_init_io(device, device->bp_block, 0, NULL);
+	cqr->status = DASD_CQR_CLEAR;
+	cqr->stopclk = get_clock();
+	dasd_schedule_bh(device);
+	return 0;
+}
+
+/* Handle external interruption. */
 static void
 dasd_ext_handler(struct pt_regs *regs, __u16 code)
 {
@@ -157,25 +243,27 @@ dasd_ext_handler(struct pt_regs *regs, _
 	struct dasd_device *device;
 	unsigned long long expires;
 	unsigned long flags;
-	char status;
-	int ip;
+	u8 int_code, status;
+	addr_t ip;
+	int rc;
 
-	/*
-	 * Get the external interruption subcode. VM stores
-	 * this in the 'cpu address' field associated with
-	 * the external interrupt. For diag 250 the subcode
-	 * needs to be 3.
-	 */
-	if ((S390_lowcore.cpu_addr & 0xff00) != 0x0300)
+	int_code = *((u8 *) DASD_DIAG_LC_INT_CODE);
+	status = *((u8 *) DASD_DIAG_LC_INT_STATUS);
+	switch (int_code) {
+	case DASD_DIAG_CODE_31BIT:
+		ip = (addr_t) *((u32 *) DASD_DIAG_LC_INT_PARM_31BIT);
+		break;
+	case DASD_DIAG_CODE_64BIT:
+		ip = (addr_t) *((u64 *) DASD_DIAG_LC_INT_PARM_64BIT);
+		break;
+	default:
 		return;
-	status = *((char *) &S390_lowcore.ext_params + 5);
-	ip = S390_lowcore.ext_params;
-
+	}
 	if (!ip) {		/* no intparm: unsolicited interrupt */
 		MESSAGE(KERN_DEBUG, "%s", "caught unsolicited interrupt");
 		return;
 	}
-	cqr = (struct dasd_ccw_req *)(addr_t) ip;
+	cqr = (struct dasd_ccw_req *) ip;
 	device = (struct dasd_device *) cqr->device;
 	if (strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
@@ -188,6 +276,15 @@ dasd_ext_handler(struct pt_regs *regs, _
 	/* get irq lock to modify request queue */
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 
+	/* Check for a pending clear operation */
+	if (cqr->status == DASD_CQR_CLEAR) {
+		cqr->status = DASD_CQR_QUEUED;
+		dasd_clear_timer(device);
+		dasd_schedule_bh(device);
+		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+		return;
+	}
+
 	cqr->stopclk = get_clock();
 
 	expires = 0;
@@ -198,16 +295,22 @@ dasd_ext_handler(struct pt_regs *regs, _
 			next = list_entry(device->ccw_queue.next,
 					  struct dasd_ccw_req, list);
 			if (next->status == DASD_CQR_QUEUED) {
-				if (dasd_start_diag(next) == 0)
+				rc = dasd_start_diag(next);
+				if (rc == 0)
 					expires = next->expires;
-				else
+				else if (rc != -EACCES)
 					DEV_MESSAGE(KERN_WARNING, device, "%s",
 						    "Interrupt fastpath "
 						    "failed!");
 			}
 		}
-	} else 
-		cqr->status = DASD_CQR_FAILED;
+	} else {
+		cqr->status = DASD_CQR_QUEUED;
+		DEV_MESSAGE(KERN_WARNING, device, "interrupt status for "
+			    "request %p was %d (%d retries left)", cqr, status,
+			    cqr->retries);
+		dasd_diag_erp(device);
+	}
 
 	if (expires != 0)
 		dasd_set_timer(device, expires);
@@ -218,14 +321,17 @@ dasd_ext_handler(struct pt_regs *regs, _
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 }
 
+/* Check whether device can be controlled by DIAG discipline. Return zero on
+ * success, non-zero otherwise. */
 static int
 dasd_diag_check_device(struct dasd_device *device)
 {
 	struct dasd_diag_private *private;
 	struct dasd_diag_characteristics *rdc_data;
 	struct dasd_diag_bio bio;
-	long *label;
-	int sb, bsize;
+	struct dasd_diag_cms_label *label;
+	blocknum_t end_block;
+	unsigned int sb, bsize;
 	int rc;
 
 	private = (struct dasd_diag_private *) device->private;
@@ -244,8 +350,11 @@ dasd_diag_check_device(struct dasd_devic
 	rdc_data->rdc_len = sizeof (struct dasd_diag_characteristics);
 
 	rc = diag210((struct diag210 *) rdc_data);
-	if (rc)
+	if (rc) {
+		DEV_MESSAGE(KERN_WARNING, device, "failed to retrieve device "
+			    "information (rc=%d)", rc);
 		return -ENOTSUPP;
+	}
 
 	/* Figure out position of label block */
 	switch (private->rdc_data.vdev_class) {
@@ -256,6 +365,8 @@ dasd_diag_check_device(struct dasd_devic
 		private->pt_block = 2;
 		break;
 	default:
+		DEV_MESSAGE(KERN_WARNING, device, "unsupported device class "
+			    "(class=%d)", private->rdc_data.vdev_class);
 		return -ENOTSUPP;
 	}
 
@@ -269,15 +380,17 @@ dasd_diag_check_device(struct dasd_devic
 	mdsk_term_io(device);
 
 	/* figure out blocksize of device */
-	label = (long *) get_zeroed_page(GFP_KERNEL);
+	label = (struct dasd_diag_cms_label *) get_zeroed_page(GFP_KERNEL);
 	if (label == NULL)  {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
 			    "No memory to allocate initialization request");
 		return -ENOMEM;
 	}
+	rc = 0;
+	end_block = 0;
 	/* try all sizes - needed for ECKD devices */
 	for (bsize = 512; bsize <= PAGE_SIZE; bsize <<= 1) {
-		mdsk_init_io(device, bsize, 0, 64);
+		mdsk_init_io(device, bsize, 0, &end_block);
 		memset(&bio, 0, sizeof (struct dasd_diag_bio));
 		bio.type = MDSK_READ_REQ;
 		bio.block_number = private->pt_block + 1;
@@ -289,37 +402,45 @@ dasd_diag_check_device(struct dasd_devic
 		private->iob.block_count = 1;
 		private->iob.interrupt_params = 0;
 		private->iob.bio_list = __pa(&bio);
-		if (dia250(&private->iob, RW_BIO) == 0)
+		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
+		rc = dia250(&private->iob, RW_BIO);
+		if (rc == 0 || rc == 3)
 			break;
 		mdsk_term_io(device);
 	}
-	if (bsize <= PAGE_SIZE && label[0] == 0xc3d4e2f1) {
-		/* get formatted blocksize from label block */
-		bsize = (int) label[3];
-		device->blocks = label[7];
+	if (rc == 3) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s", "DIAG call failed");
+		rc = -EOPNOTSUPP;
+	} else if (rc != 0) {
+		DEV_MESSAGE(KERN_WARNING, device, "device access failed "
+			    "(rc=%d)", rc);
+		rc = -EIO;
+	} else {
+		if (memcmp(label->label_id, DASD_DIAG_CMS1,
+			  sizeof(DASD_DIAG_CMS1)) == 0) {
+			/* get formatted blocksize from label block */
+			bsize = (unsigned int) label->block_size;
+			device->blocks = (unsigned long) label->block_count;
+		} else
+			device->blocks = end_block;
 		device->bp_block = bsize;
 		device->s2b_shift = 0;	/* bits to shift 512 to get a block */
 		for (sb = 512; sb < bsize; sb = sb << 1)
 			device->s2b_shift++;
 		
 		DEV_MESSAGE(KERN_INFO, device,
-			    "capacity (%dkB blks): %ldkB",
-			    (device->bp_block >> 10),
-			    (device->blocks << device->s2b_shift) >> 1);
+			    "(%ld B/blk): %ldkB",
+			    (unsigned long) device->bp_block,
+			    (unsigned long) (device->blocks <<
+				device->s2b_shift) >> 1);
 		rc = 0;
-	} else {
-		if (bsize > PAGE_SIZE)
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "DIAG access failed");
-		else
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "volume is not CMS formatted");
-		rc = -EMEDIUMTYPE;
 	}
 	free_page((long) label);
 	return rc;
 }
 
+/* Fill in virtual disk geometry for device. Return zero on success, non-zero
+ * otherwise. */
 static int
 dasd_diag_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
 {
@@ -349,6 +470,8 @@ dasd_diag_erp_postaction(struct dasd_ccw
 	return dasd_default_erp_postaction;
 }
 
+/* Create DASD request from block device request. Return pointer to new
+ * request on success, ERR_PTR otherwise. */
 static struct dasd_ccw_req *
 dasd_diag_build_cp(struct dasd_device * device, struct request *req)
 {
@@ -358,9 +481,9 @@ dasd_diag_build_cp(struct dasd_device * 
 	struct bio *bio;
 	struct bio_vec *bv;
 	char *dst;
-	int count, datasize;
+	unsigned int count, datasize;
 	sector_t recid, first_rec, last_rec;
-	unsigned blksize, off;
+	unsigned int blksize, off;
 	unsigned char rw_cmd;
 	int i;
 
@@ -413,13 +536,16 @@ dasd_diag_build_cp(struct dasd_device * 
 			}
 		}
 	}
+	cqr->retries = DIAG_MAX_RETRIES;
 	cqr->buildclk = get_clock();
 	cqr->device = device;
-	cqr->expires = 50 * HZ;	/* 50 seconds */
+	cqr->expires = DIAG_TIMEOUT;
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
 }
 
+/* Release DASD request. Return non-zero if request was successful, zero
+ * otherwise. */
 static int
 dasd_diag_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 {
@@ -430,6 +556,7 @@ dasd_diag_free_cp(struct dasd_ccw_req *c
 	return status;
 }
 
+/* Fill in IOCTL data for device. */
 static int
 dasd_diag_fill_info(struct dasd_device * device,
 		    struct dasd_information2_t * info)
@@ -437,7 +564,7 @@ dasd_diag_fill_info(struct dasd_device *
 	struct dasd_diag_private *private;
 
 	private = (struct dasd_diag_private *) device->private;
-	info->label_block = private->pt_block;
+	info->label_block = (unsigned int) private->pt_block;
 	info->FBA_layout = 1;
 	info->format = DASD_FORMAT_LDL;
 	info->characteristics_size = sizeof (struct dasd_diag_characteristics);
@@ -456,26 +583,15 @@ dasd_diag_dump_sense(struct dasd_device 
 		    "dump sense not available for DIAG data");
 }
 
-/*
- * max_blocks is dependent on the amount of storage that is available
- * in the static io buffer for each device. Currently each device has
- * 8192 bytes (=2 pages). dasd diag is only relevant for 31 bit.
- * The struct dasd_ccw_req has 96 bytes, the struct dasd_diag_req has
- * 8 bytes and the struct dasd_diag_bio for each block has 16 bytes. 
- * That makes:
- * (8192 - 96 - 8) / 16 = 505.5 blocks at maximum.
- * We want to fit two into the available memory so that we can immediately
- * start the next request if one finishes off. That makes 252.75 blocks
- * for one request. Give a little safety and the result is 240.
- */
 struct dasd_discipline dasd_diag_discipline = {
 	.owner = THIS_MODULE,
 	.name = "DIAG",
 	.ebcname = "DIAG",
-	.max_blocks = 240,
+	.max_blocks = DIAG_MAX_BLOCKS,
 	.check_device = dasd_diag_check_device,
 	.fill_geometry = dasd_diag_fill_geometry,
 	.start_IO = dasd_start_diag,
+	.term_IO = dasd_diag_term_IO,
 	.examine_error = dasd_diag_examine_error,
 	.erp_action = dasd_diag_erp_action,
 	.erp_postaction = dasd_diag_erp_postaction,
@@ -493,7 +609,7 @@ dasd_diag_init(void)
 			    "Machine is not VM: %s "
 			    "discipline not initializing",
 			    dasd_diag_discipline.name);
-		return -EINVAL;
+		return -ENODEV;
 	}
 	ASCEBC(dasd_diag_discipline.ebcname, 4);
 
@@ -506,13 +622,6 @@ dasd_diag_init(void)
 static void __exit
 dasd_diag_cleanup(void)
 {
-	if (!MACHINE_IS_VM) {
-		MESSAGE_LOG(KERN_INFO,
-			    "Machine is not VM: %s "
-			    "discipline not cleaned",
-			    dasd_diag_discipline.name);
-		return;
-	}
 	unregister_external_interrupt(0x2603, dasd_ext_handler);
 	ctl_clear_bit(0, 9);
 	dasd_diag_discipline_pointer = NULL;
@@ -520,22 +629,3 @@ dasd_diag_cleanup(void)
 
 module_init(dasd_diag_init);
 module_exit(dasd_diag_cleanup);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2005-08-29 19:18:07.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.6 $
+ * $Revision: 1.7 $
  */
 
 #define MDSK_WRITE_REQ 0x01
@@ -19,6 +19,18 @@
 #define DEV_CLASS_FBA	0x01
 #define DEV_CLASS_ECKD	0x04
 
+#define DASD_DIAG_LC_INT_CODE		132
+#define DASD_DIAG_LC_INT_STATUS		133
+#define DASD_DIAG_LC_INT_PARM_31BIT	128
+#define DASD_DIAG_LC_INT_PARM_64BIT	4536
+#define DASD_DIAG_CODE_31BIT		0x03
+#define DASD_DIAG_CODE_64BIT		0x07
+
+#define DASD_DIAG_RWFLAG_ASYNC		0x02
+#define DASD_DIAG_RWFLAG_NOCACHE	0x01
+
+#define DASD_DIAG_FLAGA_FORMAT_64BIT	0x80
+
 struct dasd_diag_characteristics {
 	u16 dev_nr;
 	u16 rdc_len;
@@ -32,35 +44,106 @@ struct dasd_diag_characteristics {
 	u8 rdev_features;
 } __attribute__ ((packed, aligned(4)));
 
+struct dasd_diag_cms_label {
+	u8 label_id[4];
+	u8 vol_id[6];
+	u16 version_id;
+	u32 block_size;
+	u32 origin_ptr;
+	u32 usable_count;
+	u32 formatted_count;
+	u32 block_count;
+	u32 used_count;
+	u32 fst_size;
+	u32 fst_count;
+	u8 format_date[6];
+	u8 reserved1[2];
+	u32 disk_offset;
+	u32 map_block;
+	u32 hblk_disp;
+	u32 user_disp;
+	u8 reserved2[4];
+	u8 segment_name[8];
+} __attribute__ ((packed));
+
+#ifdef CONFIG_ARCH_S390X
+#define DASD_DIAG_FLAGA_DEFAULT		DASD_DIAG_FLAGA_FORMAT_64BIT
+
+typedef u64 blocknum_t;
+typedef s64 sblocknum_t;
+
+struct dasd_diag_bio {
+	u8 type;
+	u8 status;
+	u8 spare1[2];
+	u32 alet;
+	blocknum_t block_number;
+	u64 buffer;
+} __attribute__ ((packed, aligned(8)));
+
+struct dasd_diag_init_io {
+	u16 dev_nr;
+	u8 flaga;
+	u8 spare1[21];
+	u32 block_size;
+	u8 spare2[4];
+	blocknum_t offset;
+	sblocknum_t start_block;
+	blocknum_t end_block;
+	u8  spare3[8];
+} __attribute__ ((packed, aligned(8)));
+
+struct dasd_diag_rw_io {
+	u16 dev_nr;
+	u8  flaga;
+	u8  spare1[21];
+	u8  key;
+	u8  flags;
+	u8  spare2[2];
+	u32 block_count;
+	u32 alet;
+	u8  spare3[4];
+	u64 interrupt_params;
+	u64 bio_list;
+	u8  spare4[8];
+} __attribute__ ((packed, aligned(8)));
+#else /* CONFIG_ARCH_S390X */
+#define DASD_DIAG_FLAGA_DEFAULT		0x0
+
+typedef u32 blocknum_t;
+typedef s32 sblocknum_t;
+
 struct dasd_diag_bio {
 	u8 type;
 	u8 status;
 	u16 spare1;
-	u32 block_number;
+	blocknum_t block_number;
 	u32 alet;
 	u32 buffer;
 } __attribute__ ((packed, aligned(8)));
 
 struct dasd_diag_init_io {
 	u16 dev_nr;
-	u16 spare1[11];
+	u8 flaga;
+	u8 spare1[21];
 	u32 block_size;
-	u32 offset;
-	u32 start_block;
-	u32 end_block;
-	u32 spare2[6];
+	blocknum_t offset;
+	sblocknum_t start_block;
+	blocknum_t end_block;
+	u8 spare2[24];
 } __attribute__ ((packed, aligned(8)));
 
 struct dasd_diag_rw_io {
 	u16 dev_nr;
-	u16 spare1[11];
+	u8 flaga;
+	u8 spare1[21];
 	u8 key;
 	u8 flags;
-	u16 spare2;
+	u8 spare2[2];
 	u32 block_count;
 	u32 alet;
 	u32 bio_list;
 	u32 interrupt_params;
-	u32 spare3[5];
+	u8 spare3[20];
 } __attribute__ ((packed, aligned(8)));
-
+#endif /* CONFIG_ARCH_S390X */
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2005-08-29 19:18:07.000000000 +0200
@@ -49,7 +49,7 @@ config DASD_FBA
 
 config DASD_DIAG
 	tristate "Support for DIAG access to Disks"
-	depends on DASD && ARCH_S390X = 'n'
+	depends on DASD && ( ARCH_S390X = 'n' || EXPERIMENTAL)
 	help
 	  Select this option if you want to use Diagnose250 command to access
 	  Disks under VM.  If you are not running under VM or unsure what it is,
