Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261248AbVCFAB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCFAB5 (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 19:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCFAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:00:54 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:52637 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261248AbVCEXkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:40:19 -0500
Date: Sat, 05 Mar 2005 17:40:13 -0600 (CST)
Date-warning: Date header was inserted by vms044.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 12/13] sddr09: Clean up printk()'s in
 drivers/usb/storage/sddr09.c
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305234012.7656.36862.69150@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up debug printk()s and macros in drivers/usb/storage/sddr09.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/storage/sddr09.c linux-2.6.11-mm1/drivers/usb/storage/sddr09.c
--- linux-2.6.11-mm1-original/drivers/usb/storage/sddr09.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/storage/sddr09.c	2005-03-05 17:42:15.000000000 -0500
@@ -41,6 +41,10 @@
  * EF: compute checksum (?)
  */
 
+#ifdef CONFIG_USB_DEBUG
+#define DEBUG
+#endif /*DEBUG*/
+
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -54,13 +58,13 @@
 #include "debug.h"
 #include "sddr09.h"
 
+#define PFX "sddr09: "
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s(): ", fmt, __FUNCTION__, ## args)
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
 #define LSB_of(s) ((s)&0xFF)
 #define MSB_of(s) ((s)>>8)
 
-/* #define US_DEBUGP printk */
-
 /*
  * First some stuff that does not belong here:
  * data on SmartMedia and other cards, completely
@@ -286,7 +290,7 @@ sddr09_test_unit_ready(struct us_data *u
 
 	result = sddr09_send_scsi_command(us, command, 6);
 
-	US_DEBUGP("sddr09_test_unit_ready returns %d\n", result);
+	DPRINTK("returns %d\n", result);
 
 	return result;
 }
@@ -309,17 +313,17 @@ sddr09_request_sense(struct us_data *us,
 
 	result = sddr09_send_scsi_command(us, command, 12);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("request sense failed\n");
+		DPRINTK("request sense failed\n");
 		return result;
 	}
 
 	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
 			sensebuf, buflen, NULL);
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("request sense bulk in failed\n");
+		DPRINTK("request sense bulk in failed\n");
 		return USB_STOR_TRANSPORT_ERROR;
 	} else {
-		US_DEBUGP("request sense worked\n");
+		DPRINTK("request sense worked\n");
 		return USB_STOR_TRANSPORT_GOOD;
 	}
 }
@@ -370,7 +374,7 @@ sddr09_readX(struct us_data *us, int x, 
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_read2%d %d\n",
+		DPRINTK("result for send_control in sddr09_read2%d %d\n",
 			  x, result);
 		return result;
 	}
@@ -379,7 +383,7 @@ sddr09_readX(struct us_data *us, int x, 
 				       buf, bulklen, use_sg, NULL);
 
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_read2%d %d\n",
+		DPRINTK("result for bulk_transfer in sddr09_read2%d %d\n",
 			  x, result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -441,8 +445,7 @@ sddr09_read22(struct us_data *us, unsign
 	      int nr_of_pages, int pageshift, unsigned char *buf, int use_sg) {
 
 	int bulklen = (nr_of_pages << pageshift) + (nr_of_pages << CONTROL_SHIFT);
-	US_DEBUGP("sddr09_read22: reading %d pages, %d bytes\n",
-		  nr_of_pages, bulklen);
+	DPRINTK("reading %d pages, %d bytes\n", nr_of_pages, bulklen);
 	return sddr09_readX(us, 2, fromaddress, nr_of_pages, bulklen,
 			    buf, use_sg);
 }
@@ -485,7 +488,7 @@ sddr09_erase(struct us_data *us, unsigne
 	unsigned char *command = us->iobuf;
 	int result;
 
-	US_DEBUGP("sddr09_erase: erase address %lu\n", Eaddress);
+	DPRINTK("erase address %lu\n", Eaddress);
 
 	memset(command, 0, 12);
 	command[0] = 0xEA;
@@ -498,7 +501,7 @@ sddr09_erase(struct us_data *us, unsigne
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD)
-		US_DEBUGP("Result for send_control in sddr09_erase %d\n",
+		DPRINTK("result for send_control in sddr09_erase %d\n",
 			  result);
 
 	return result;
@@ -556,7 +559,7 @@ sddr09_writeX(struct us_data *us,
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_writeX %d\n",
+		DPRINTK("result for send_control in sddr09_writeX %d\n",
 			  result);
 		return result;
 	}
@@ -565,7 +568,7 @@ sddr09_writeX(struct us_data *us,
 				       buf, bulklen, use_sg, NULL);
 
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_writeX %d\n",
+		DPRINTK("result for bulk_transfer in sddr09_writeX %d\n",
 			  result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -634,7 +637,7 @@ sddr09_read_sg_test_only(struct us_data 
 	result = sddr09_send_scsi_command(us, command, 4*nsg+3);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_read_sg %d\n",
+		DPRINTK("result for send_control in sddr09_read_sg %d\n",
 			  result);
 		return result;
 	}
@@ -647,7 +650,7 @@ sddr09_read_sg_test_only(struct us_data 
 				       buf, bulklen, NULL);
 	kfree(buf);
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_read_sg %d\n",
+		DPRINTK("result for bulk_transfer in sddr09_read_sg %d\n",
 			  result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -674,7 +677,7 @@ sddr09_read_status(struct us_data *us, u
 	unsigned char *data = us->iobuf;
 	int result;
 
-	US_DEBUGP("Reading status...\n");
+	DPRINTK("enter\n");
 
 	memset(command, 0, 12);
 	command[0] = 0xEC;
@@ -710,7 +713,7 @@ sddr09_read_data(struct us_data *us,
 	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL) {
-		printk("sddr09_read_data: Out of memory\n");
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
@@ -733,7 +736,7 @@ sddr09_read_data(struct us_data *us,
 
 		/* Not overflowing capacity? */
 		if (lba >= maxlba) {
-			US_DEBUGP("Error: Requested lba %u exceeds "
+			DPRINTK("error: requested lba %u exceeds "
 				  "maximum %u\n", lba, maxlba);
 			result = USB_STOR_TRANSPORT_ERROR;
 			break;
@@ -744,7 +747,7 @@ sddr09_read_data(struct us_data *us,
 
 		if (pba == UNDEF) {	/* this lba was never written */
 
-			US_DEBUGP("Read %d zero pages (LBA %d) page %d\n",
+			DPRINTK("read %d zero pages (LBA %d) page %d\n",
 				  pages, lba, page);
 
 			/* This is not really an error. It just means
@@ -755,7 +758,7 @@ sddr09_read_data(struct us_data *us,
 			memset(buffer, 0, len);
 
 		} else {
-			US_DEBUGP("Read %d pages, from PBA %d"
+			DPRINTK("read %d pages, from PBA %d"
 				  " (LBA %d) page %d\n",
 				  pages, pba, lba, page);
 
@@ -829,7 +832,7 @@ sddr09_write_lba(struct us_data *us, uns
 	if (pba == UNDEF) {
 		pba = sddr09_find_unused_pba(info, lba);
 		if (!pba) {
-			printk("sddr09_write_lba: Out of unused blocks\n");
+			printk(KERN_ERR PFX "%s(): out of unused blocks\n", __FUNCTION__);
 			return USB_STOR_TRANSPORT_ERROR;
 		}
 		info->pba_to_lba[pba] = lba;
@@ -840,7 +843,7 @@ sddr09_write_lba(struct us_data *us, uns
 	if (pba == 1) {
 		/* Maybe it is impossible to write to PBA 1.
 		   Fake success, but don't do anything. */
-		printk("sddr09: avoid writing to pba 1\n");
+		printk(KERN_NOTICE PFX "avoid writing to pba 1\n");
 		return USB_STOR_TRANSPORT_GOOD;
 	}
 
@@ -859,13 +862,13 @@ sddr09_write_lba(struct us_data *us, uns
 		cptr = bptr + info->pagesize;
 		nand_compute_ecc(bptr, ecc);
 		if (!nand_compare_ecc(cptr+13, ecc)) {
-			US_DEBUGP("Warning: bad ecc in page %d- of pba %d\n",
+			DPRINTK("warning: bad ecc in page %d- of pba %d\n",
 				  i, pba);
 			nand_store_ecc(cptr+13, ecc);
 		}
 		nand_compute_ecc(bptr+(info->pagesize / 2), ecc);
 		if (!nand_compare_ecc(cptr+8, ecc)) {
-			US_DEBUGP("Warning: bad ecc in page %d+ of pba %d\n",
+			DPRINTK("warning: bad ecc in page %d+ of pba %d\n",
 				  i, pba);
 			nand_store_ecc(cptr+8, ecc);
 		}
@@ -886,21 +889,21 @@ sddr09_write_lba(struct us_data *us, uns
 		nand_store_ecc(cptr+8, ecc);
 	}
 
-	US_DEBUGP("Rewrite PBA %d (LBA %d)\n", pba, lba);
+	DPRINTK("rewrite PBA %d (LBA %d)\n", pba, lba);
 
 	result = sddr09_write_inplace(us, address>>1, info->blocksize,
 				      info->pageshift, blockbuffer, 0);
 
-	US_DEBUGP("sddr09_write_inplace returns %d\n", result);
+	DPRINTK("sddr09_write_inplace returns %d\n", result);
 
 #if 0
 	{
 		unsigned char status = 0;
 		int result2 = sddr09_read_status(us, &status);
 		if (result2 != USB_STOR_TRANSPORT_GOOD)
-			US_DEBUGP("sddr09_write_inplace: cannot read status\n");
+			DPRINTK("sddr09_write_inplace: cannot read status\n");
 		else if (status != 0xc0)
-			US_DEBUGP("sddr09_write_inplace: status after write: 0x%x\n",
+			DPRINTK("sddr09_write_inplace: status after write: 0x%x\n",
 				  status);
 	}
 #endif
@@ -937,7 +940,7 @@ sddr09_write_data(struct us_data *us,
 	blocklen = (pagelen << info->blockshift);
 	blockbuffer = kmalloc(blocklen, GFP_NOIO);
 	if (!blockbuffer) {
-		printk("sddr09_write_data: Out of memory\n");
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
@@ -948,7 +951,7 @@ sddr09_write_data(struct us_data *us,
 	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL) {
-		printk("sddr09_write_data: Out of memory\n");
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		kfree(blockbuffer);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -994,7 +997,7 @@ sddr09_read_control(struct us_data *us,
 		unsigned char *content,
 		int use_sg) {
 
-	US_DEBUGP("Read control address %lu, blocks %d\n",
+	DPRINTK("read control address %lu, blocks %d\n",
 		address, blocks);
 
 	return sddr09_read21(us, address, blocks,
@@ -1042,21 +1045,23 @@ sddr09_get_wp(struct us_data *us, struct
 
 	result = sddr09_read_status(us, &status);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("sddr09_get_wp: read_status fails\n");
+		DPRINTK("read_status fails\n");
 		return result;
 	}
-	US_DEBUGP("sddr09_get_wp: status 0x%02X", status);
+#ifdef DEBUG
+	DPRINTK("status 0x%02X", status);
 	if ((status & 0x80) == 0) {
 		info->flags |= SDDR09_WP;	/* write protected */
-		US_DEBUGP(" WP");
+		printk(" WP");
 	}
 	if (status & 0x40)
-		US_DEBUGP(" Ready");
+		printk(" Ready");
 	if (status & LUNBITS)
-		US_DEBUGP(" Suspended");
+		printk(" Suspended");
 	if (status & 0x1)
-		US_DEBUGP(" Error");
-	US_DEBUGP("\n");
+		printk(" Error");
+	printk("\n");
+#endif /*DEBUG*/
 	return USB_STOR_TRANSPORT_GOOD;
 }
 
@@ -1085,17 +1090,17 @@ sddr09_get_cardinfo(struct us_data *us, 
 	char blurbtxt[256];
 	int result;
 
-	US_DEBUGP("Reading capacity...\n");
+	DPRINTK("reading capacity...\n");
 
 	result = sddr09_read_deviceID(us, deviceID);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result of read_deviceID is %d\n", result);
-		printk("sddr09: could not read card info\n");
+		DPRINTK("result of read_deviceID is %d\n", result);
+		printk(KERN_ERR PFX "could not read card info\n");
 		return NULL;
 	}
 
-	sprintf(blurbtxt, "sddr09: Found Flash card, ID = %02X %02X %02X %02X",
+	sprintf(blurbtxt, "found Flash card, ID = %02X %02X %02X %02X",
 		deviceID[0], deviceID[1], deviceID[2], deviceID[3]);
 
 	/* Byte 0 is the manufacturer */
@@ -1132,7 +1137,7 @@ sddr09_get_cardinfo(struct us_data *us, 
 		sprintf(blurbtxt + strlen(blurbtxt),
 			", WP");
 
-	printk("%s\n", blurbtxt);
+	pr_info(PFX "%s\n", blurbtxt);
 
 	return cardinfo;
 }
@@ -1163,7 +1168,7 @@ sddr09_read_map(struct us_data *us) {
 	alloc_len = (alloc_blocks << CONTROL_SHIFT);
 	buffer = kmalloc(alloc_len, GFP_NOIO);
 	if (buffer == NULL) {
-		printk("sddr09_read_map: out of memory\n");
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		result = -1;
 		goto done;
 	}
@@ -1177,7 +1182,7 @@ sddr09_read_map(struct us_data *us) {
 	info->pba_to_lba = kmalloc(numblocks*sizeof(int), GFP_NOIO);
 
 	if (info->lba_to_pba == NULL || info->pba_to_lba == NULL) {
-		printk("sddr09_read_map: out of memory\n");
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		result = -1;
 		goto done;
 	}
@@ -1217,7 +1222,7 @@ sddr09_read_map(struct us_data *us) {
 			if (ptr[j] != 0)
 				goto nonz;
 		info->pba_to_lba[i] = UNUSABLE;
-		printk("sddr09: PBA %d has no logical mapping\n", i);
+		printk(KERN_WARNING PFX "PBA %d has no logical mapping\n", i);
 		continue;
 
 	nonz:
@@ -1230,7 +1235,7 @@ sddr09_read_map(struct us_data *us) {
 	nonff:
 		/* normal PBAs start with six FFs */
 		if (j < 6) {
-			printk("sddr09: PBA %d has no logical mapping: "
+			printk(KERN_WARNING PFX "PBA %d has no logical mapping: "
 			       "reserved area = %02X%02X%02X%02X "
 			       "data status %02X block status %02X\n",
 			       i, ptr[0], ptr[1], ptr[2], ptr[3],
@@ -1240,7 +1245,7 @@ sddr09_read_map(struct us_data *us) {
 		}
 
 		if ((ptr[6] >> 4) != 0x01) {
-			printk("sddr09: PBA %d has invalid address field "
+			printk(KERN_WARNING PFX "PBA %d has invalid address field "
 			       "%02X%02X/%02X%02X\n",
 			       i, ptr[6], ptr[7], ptr[11], ptr[12]);
 			info->pba_to_lba[i] = UNUSABLE;
@@ -1249,7 +1254,7 @@ sddr09_read_map(struct us_data *us) {
 
 		/* check even parity */
 		if (parity[ptr[6] ^ ptr[7]]) {
-			printk("sddr09: Bad parity in LBA for block %d"
+			printk(KERN_WARNING PFX "bad parity in LBA for block %d"
 			       " (%02X %02X)\n", i, ptr[6], ptr[7]);
 			info->pba_to_lba[i] = UNUSABLE;
 			continue;
@@ -1268,7 +1273,7 @@ sddr09_read_map(struct us_data *us) {
 		 */
 
 		if (lba >= 1000) {
-			printk("sddr09: Bad low LBA %d for block %d\n",
+			printk(KERN_WARNING PFX "bad low LBA %d for block %d\n",
 			       lba, i);
 			goto possibly_erase;
 		}
@@ -1276,7 +1281,7 @@ sddr09_read_map(struct us_data *us) {
 		lba += 1000*(i/0x400);
 
 		if (info->lba_to_pba[lba] != UNDEF) {
-			printk("sddr09: LBA %d seen for PBA %d and %d\n",
+			pr_info(PFX "LBA %d seen for PBA %d and %d\n",
 			       lba, info->lba_to_pba[lba], i);
 			goto possibly_erase;
 		}
@@ -1317,7 +1322,7 @@ sddr09_read_map(struct us_data *us) {
 		lbact += ct;
 	}
 	info->lbact = lbact;
-	US_DEBUGP("Found %d LBA's\n", lbact);
+	DPRINTK("found %d LBA's\n", lbact);
 	result = 0;
 
  done:
@@ -1365,25 +1370,27 @@ sddr09_init(struct us_data *us) {
 
 	result = sddr09_send_command(us, 0x01, USB_DIR_IN, data, 2);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("sddr09_init: send_command fails\n");
+		DPRINTK("send_command fails\n");
 		return result;
 	}
 
-	US_DEBUGP("SDDR09init: %02X %02X\n", data[0], data[1]);
+	DPRINTK("data[0] = %02X, data[1] = %02X\n", data[0], data[1]);
 	// get 07 02
 
 	result = sddr09_send_command(us, 0x08, USB_DIR_IN, data, 2);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("sddr09_init: 2nd send_command fails\n");
+		DPRINTK("2nd send_command fails\n");
 		return result;
 	}
 
-	US_DEBUGP("SDDR09init: %02X %02X\n", data[0], data[1]);
+	DPRINTK("data[0] = %02X, data[1] = %02X\n", data[0], data[1]);
 	// get 07 00
 
 	result = sddr09_request_sense(us, data, 18);
 	if (result == USB_STOR_TRANSPORT_GOOD && data[2] != 0) {
+#ifdef DEBUG
 		int j;
+		DPRINTK("data[] =");
 		for (j=0; j<18; j++)
 			printk(" %02X", data[j]);
 		printk("\n");
@@ -1394,6 +1401,7 @@ sddr09_init(struct us_data *us) {
 		// Or: 70 00 06 00 00 00 00 0b 00 00 00 00 28 00 00 00 00 00
 		// sense key 06, sense code 28: unit attention,
 		// not ready to ready transition
+#endif /*DEBUG*/
 	}
 
 	// test unit ready
@@ -1506,8 +1514,7 @@ int sddr09_transport(struct scsi_cmnd *s
 		   or for all pages. */
 		/* %% We should check DBD %% */
 		if (modepage == 0x01 || modepage == 0x3F) {
-			US_DEBUGP("SDDR09: Dummy up request for "
-				  "mode page 0x%x\n", modepage);
+			DPRINTK("dummy up request for mode page 0x%x\n", modepage);
 
 			memcpy(ptr, mode_page_01, sizeof(mode_page_01));
 			((__be16*)ptr)[0] = cpu_to_be16(sizeof(mode_page_01) - 2);
@@ -1533,7 +1540,7 @@ int sddr09_transport(struct scsi_cmnd *s
 		page |= short_pack(srb->cmnd[5], srb->cmnd[4]);
 		pages = short_pack(srb->cmnd[8], srb->cmnd[7]);
 
-		US_DEBUGP("READ_10: read page %d pagect %d\n",
+		DPRINTK("READ_10: read page %d pagect %d\n",
 			  page, pages);
 
 		return sddr09_read_data(us, page, pages);
@@ -1546,7 +1553,7 @@ int sddr09_transport(struct scsi_cmnd *s
 		page |= short_pack(srb->cmnd[5], srb->cmnd[4]);
 		pages = short_pack(srb->cmnd[8], srb->cmnd[7]);
 
-		US_DEBUGP("WRITE_10: write page %d pagect %d\n",
+		DPRINTK("WRITE_10: write page %d pagect %d\n",
 			  page, pages);
 
 		return sddr09_write_data(us, page, pages);
@@ -1572,12 +1579,11 @@ int sddr09_transport(struct scsi_cmnd *s
 	for (i=0; i<12; i++)
 		sprintf(ptr+strlen(ptr), "%02X ", srb->cmnd[i]);
 
-	US_DEBUGP("SDDR09: Send control for command %s\n", ptr);
+	DPRINTK("send control for command %s\n", ptr);
 
 	result = sddr09_send_scsi_command(us, srb->cmnd, 12);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("sddr09_transport: sddr09_send_scsi_command "
-			  "returns %d\n", result);
+		DPRINTK("sddr09_send_scsi_command returns %d\n", result);
 		return result;
 	}
 
@@ -1589,10 +1595,9 @@ int sddr09_transport(struct scsi_cmnd *s
 		unsigned int pipe = (srb->sc_data_direction == DMA_TO_DEVICE)
 				? us->send_bulk_pipe : us->recv_bulk_pipe;
 
-		US_DEBUGP("SDDR09: %s %d bytes\n",
-			  (srb->sc_data_direction == DMA_TO_DEVICE) ?
-			  "sending" : "receiving",
-			  srb->request_bufflen);
+		DPRINTK("%s %d bytes\n",
+			(srb->sc_data_direction == DMA_TO_DEVICE) ?
+			"sending" : "receiving", srb->request_bufflen);
 
 		result = usb_stor_bulk_transfer_sg(us, pipe,
 					srb->request_buffer,
