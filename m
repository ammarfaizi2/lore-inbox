Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBGJQx>; Thu, 7 Feb 2002 04:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSBGJQp>; Thu, 7 Feb 2002 04:16:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5645 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286647AbSBGJQa>;
	Thu, 7 Feb 2002 04:16:30 -0500
Date: Thu, 7 Feb 2002 10:16:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide-scsi + sg scatterlist fixup
Message-ID: <20020207101624.G16105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following is a patch to make ide-scsi and sg work again. Of course
people can just bk pull the latest changes by now...

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.224   -> 1.225  
#	drivers/scsi/ide-scsi.c	1.15    -> 1.16   
#	   drivers/scsi/sg.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/07	axboe@burns.home.kernel.dk	1.225
# scatterlist address fixup
# --------------------------------------------
#
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	Thu Feb  7 10:14:35 2002
+++ b/drivers/scsi/ide-scsi.c	Thu Feb  7 10:14:35 2002
@@ -130,6 +130,7 @@
 static void idescsi_input_buffers (ide_drive_t *drive, idescsi_pc_t *pc, unsigned int bcount)
 {
 	int count;
+	char *buf;
 
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -138,7 +139,8 @@
 			return;
 		}
 		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_input_bytes (drive, pc->sg->address + pc->b_count, count);
+		buf = page_address(pc->sg->page) + pc->sg->offset;
+		atapi_input_bytes (drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -150,6 +152,7 @@
 static void idescsi_output_buffers (ide_drive_t *drive, idescsi_pc_t *pc, unsigned int bcount)
 {
 	int count;
+	char *buf;
 
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -158,7 +161,8 @@
 			return;
 		}
 		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_output_bytes (drive, pc->sg->address + pc->b_count, count);
+		buf = page_address(pc->sg->page) + pc->sg->offset;
+		atapi_output_bytes (drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -750,25 +754,11 @@
 		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
-			struct page *page = sg->page;
-			int offset = sg->offset;
-
-			if (!page) {
-				BUG_ON(!sg->address);
-				page = virt_to_page(sg->address);
-				offset = (unsigned long) sg->address & ~PAGE_MASK;
-			}
-				
-			bh->bi_io_vec[0].bv_page = page;
+			bh->bi_io_vec[0].bv_page = sg->page;
 			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = offset;
+			bh->bi_io_vec[0].bv_offset = sg->offset;
 			bh->bi_size = sg->length;
 			bh = bh->bi_next;
-			/*
-			 * just until scsi_merge is fixed up...
-			 */
-			BUG_ON(PageHighMem(page));
-			sg->address = page_address(page) + offset;
 			sg++;
 		}
 	} else {
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Thu Feb  7 10:14:35 2002
+++ b/drivers/scsi/sg.c	Thu Feb  7 10:14:35 2002
@@ -76,8 +76,6 @@
 #include <linux/version.h>
 #endif /* LINUX_VERSION_CODE */
 
-#define SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
-
 #define SG_ALLOW_DIO_DEF 0
 #define SG_ALLOW_DIO_CODE	/* compile out be commenting this define */
 #ifdef SG_ALLOW_DIO_CODE
@@ -1714,9 +1712,6 @@
 						rem_sz;
 	sclp->page = kp->maplist[k];
 	sclp->offset = offset;
-#ifdef SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
-	sclp->address = page_address(kp->maplist[k]) + offset;
-#endif
 	sclp->length = num;
 	mem_src_arr[k] = SG_USER_MEM;
 	rem_sz -= num;
@@ -1804,9 +1799,6 @@
             }
             sclp->page = virt_to_page(p);
             sclp->offset = (unsigned long)p & ~PAGE_MASK;
-#ifdef SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
-            sclp->address = p;
-#endif
             sclp->length = ret_sz;
 	    mem_src_arr[k] = mem_src;
 
@@ -1967,9 +1959,6 @@
             sg_free(sg_scatg2virt(sclp), sclp->length, mem_src);
 	    sclp->page = NULL;
             sclp->offset = 0;
-#ifdef SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
-	    sclp->address = 0;
-#endif
             sclp->length = 0;
         }
 	sg_free(schp->buffer, schp->sglist_len, schp->buffer_mem_src);

-- 
Jens Axboe

