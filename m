Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbUJ0GV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUJ0GV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUJ0GSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:18:36 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:23463 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262302AbUJ0GQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:16:29 -0400
Date: Tue, 26 Oct 2004 23:09:10 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@taniwha.stupidest.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: [RFC] Rename SECTOR_SIZE to FTL_SECTOR_SIZE
Message-ID: <20041027060910.GC32396@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The token SECTOR_SIZE is used in multiple places that have (almost)
the same defintion everywhere.

How do people feel about rename this vague token?



===== drivers/mtd/ftl.c 1.52 vs edited =====
--- 1.52/drivers/mtd/ftl.c	2004-08-10 07:30:08 -07:00
+++ edited/drivers/mtd/ftl.c	2004-10-26 17:10:27 -07:00
@@ -105,7 +105,7 @@ MODULE_PARM(shuffle_freq, "i");
 #define MAX_ERASE	8
 
 /* Sector size -- shouldn't need to change */
-#define SECTOR_SIZE	512
+#define FTL_SECTOR_SIZE	512
 
 
 /* Each memory region corresponds to a minor device */
@@ -438,7 +438,7 @@ static int prepare_xfer(partition_t *par
 
     /* Write the BAM stub */
     nbam = (part->BlocksPerUnit * sizeof(u_int32_t) +
-	    le32_to_cpu(part->header.BAMOffset) + SECTOR_SIZE - 1) / SECTOR_SIZE;
+	    le32_to_cpu(part->header.BAMOffset) + FTL_SECTOR_SIZE - 1) / FTL_SECTOR_SIZE;
 
     offset = xfer->Offset + le32_to_cpu(part->header.BAMOffset);
     ctl = cpu_to_le32(BLOCK_CONTROL);
@@ -471,7 +471,7 @@ static int prepare_xfer(partition_t *par
 static int copy_erase_unit(partition_t *part, u_int16_t srcunit,
 			   u_int16_t xferunit)
 {
-    u_char buf[SECTOR_SIZE];
+    u_char buf[FTL_SECTOR_SIZE];
     struct eun_info_t *eun;
     struct xfer_info_t *xfer;
     u_int32_t src, dest, free, i;
@@ -530,7 +530,7 @@ static int copy_erase_unit(partition_t *
 	    break;
 	case BLOCK_DATA:
 	case BLOCK_REPLACEMENT:
-	    ret = part->mbd.mtd->read(part->mbd.mtd, src, SECTOR_SIZE,
+	    ret = part->mbd.mtd->read(part->mbd.mtd, src, FTL_SECTOR_SIZE,
                         &retlen, (u_char *) buf);
 	    if (ret) {
 		printk(KERN_WARNING "ftl: Error reading old xfer unit in copy_erase_unit\n");
@@ -538,7 +538,7 @@ static int copy_erase_unit(partition_t *
             }
 
 
-	    ret = part->mbd.mtd->write(part->mbd.mtd, dest, SECTOR_SIZE,
+	    ret = part->mbd.mtd->write(part->mbd.mtd, dest, FTL_SECTOR_SIZE,
                         &retlen, (u_char *) buf);
 	    if (ret)  {
 		printk(KERN_WARNING "ftl: Error writing new xfer unit in copy_erase_unit\n");
@@ -552,8 +552,8 @@ static int copy_erase_unit(partition_t *
 	    free++;
 	    break;
 	}
-	src += SECTOR_SIZE;
-	dest += SECTOR_SIZE;
+	src += FTL_SECTOR_SIZE;
+	dest += FTL_SECTOR_SIZE;
     }
 
     /* Write the BAM to the transfer unit */
@@ -807,17 +807,17 @@ static int ftl_read(partition_t *part, c
     bsize = 1 << part->header.EraseUnitSize;
 
     for (i = 0; i < nblocks; i++) {
-	if (((sector+i) * SECTOR_SIZE) >= le32_to_cpu(part->header.FormattedSize)) {
+	if (((sector+i) * FTL_SECTOR_SIZE) >= le32_to_cpu(part->header.FormattedSize)) {
 	    printk(KERN_NOTICE "ftl_cs: bad read offset\n");
 	    return -EIO;
 	}
 	log_addr = part->VirtualBlockMap[sector+i];
 	if (log_addr == 0xffffffff)
-	    memset(buffer, 0, SECTOR_SIZE);
+	    memset(buffer, 0, FTL_SECTOR_SIZE);
 	else {
 	    offset = (part->EUNInfo[log_addr / bsize].Offset
 			  + (log_addr % bsize));
-	    ret = part->mbd.mtd->read(part->mbd.mtd, offset, SECTOR_SIZE,
+	    ret = part->mbd.mtd->read(part->mbd.mtd, offset, FTL_SECTOR_SIZE,
 			   &retlen, (u_char *) buffer);
 
 	    if (ret) {
@@ -825,7 +825,7 @@ static int ftl_read(partition_t *part, c
 		return ret;
 	    }
 	}
-	buffer += SECTOR_SIZE;
+	buffer += FTL_SECTOR_SIZE;
     }
     return 0;
 } /* ftl_read */
@@ -851,7 +851,7 @@ static int set_bam_entry(partition_t *pa
 	  part, log_addr, virt_addr);
     bsize = 1 << part->header.EraseUnitSize;
     eun = log_addr / bsize;
-    blk = (log_addr % bsize) / SECTOR_SIZE;
+    blk = (log_addr % bsize) / FTL_SECTOR_SIZE;
     offset = (part->EUNInfo[eun].Offset + blk * sizeof(u_int32_t) +
 		  le32_to_cpu(part->header.BAMOffset));
     
@@ -927,7 +927,7 @@ static int ftl_write(partition_t *part, 
     
     bsize = 1 << part->header.EraseUnitSize;
 
-    virt_addr = sector * SECTOR_SIZE | BLOCK_DATA;
+    virt_addr = sector * FTL_SECTOR_SIZE | BLOCK_DATA;
     for (i = 0; i < nblocks; i++) {
 	if (virt_addr >= le32_to_cpu(part->header.FormattedSize)) {
 	    printk(KERN_NOTICE "ftl_cs: bad write offset\n");
@@ -945,15 +945,15 @@ static int ftl_write(partition_t *part, 
 	}
 
 	/* Tag the BAM entry, and write the new block */
-	log_addr = part->bam_index * bsize + blk * SECTOR_SIZE;
+	log_addr = part->bam_index * bsize + blk * FTL_SECTOR_SIZE;
 	part->EUNInfo[part->bam_index].Free--;
 	part->FreeTotal--;
 	if (set_bam_entry(part, log_addr, 0xfffffffe)) 
 	    return -EIO;
 	part->EUNInfo[part->bam_index].Deleted++;
 	offset = (part->EUNInfo[part->bam_index].Offset +
-		      blk * SECTOR_SIZE);
-	ret = part->mbd.mtd->write(part->mbd.mtd, offset, SECTOR_SIZE, &retlen, 
+		      blk * FTL_SECTOR_SIZE);
+	ret = part->mbd.mtd->write(part->mbd.mtd, offset, FTL_SECTOR_SIZE, &retlen, 
                                      buffer);
 
 	if (ret) {
@@ -979,8 +979,8 @@ static int ftl_write(partition_t *part, 
 	part->VirtualBlockMap[sector+i] = log_addr;
 	part->EUNInfo[part->bam_index].Deleted--;
 	
-	buffer += SECTOR_SIZE;
-	virt_addr += SECTOR_SIZE;
+	buffer += FTL_SECTOR_SIZE;
+	virt_addr += FTL_SECTOR_SIZE;
     }
     return 0;
 } /* ftl_write */
@@ -991,7 +991,7 @@ static int ftl_getgeo(struct mtd_blktran
 	u_long sect;
 
 	/* Sort of arbitrary: round size down to 4KiB boundary */
-	sect = le32_to_cpu(part->header.FormattedSize)/SECTOR_SIZE;
+	sect = le32_to_cpu(part->header.FormattedSize)/FTL_SECTOR_SIZE;
 
 	geo->heads = 1;
 	geo->sectors = 8;
@@ -1064,7 +1064,7 @@ static void ftl_add_mtd(struct mtd_blktr
 		       le32_to_cpu(partition->header.FormattedSize) >> 10);
 #endif
 		partition->mbd.size = le32_to_cpu(partition->header.FormattedSize) >> 9;
-		partition->mbd.blksize = SECTOR_SIZE;
+		partition->mbd.blksize = FTL_SECTOR_SIZE;
 		partition->mbd.tr = tr;
 		partition->mbd.devnum = -1;
 		if (add_mtd_blktrans_dev((void *)partition))
