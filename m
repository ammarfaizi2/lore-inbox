Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSA0Bqu>; Sat, 26 Jan 2002 20:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSA0Bql>; Sat, 26 Jan 2002 20:46:41 -0500
Received: from ns.suse.de ([213.95.15.193]:43281 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287467AbSA0Bqg>;
	Sat, 26 Jan 2002 20:46:36 -0500
Date: Sun, 27 Jan 2002 02:46:31 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make ide-scsi compile in 2.5
Message-ID: <20020127024631.A28936@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ide-scsi doesn't compile currently in 2.5.x. This patch fixes it in a 
rather hackish way by adding some kmap_atomic()s.  It would be 
probably better to kmap earlier in process context in the request 
function instead, but I leave this to the people who know more 
about IDE/block layer than me (but apparently not compile ide-scsi..)
I'm also not totally convinced that it is deadlock free here to use
KM_BOUNCE_READ here, it may be safer to add a new bounce type. 
You have been warned. 

I have only tested it without highmem and it works for me. 

Hopefully there will be eventually a better fix, but for now it 
allows to burn (and mount if you use /dev/scd* for ide) CDs under 2.5 again. 


-Andi



Index: drivers/scsi/ide-scsi.c
===================================================================
RCS file: /cvs/linux/drivers/scsi/ide-scsi.c,v
retrieving revision 1.45
diff -u -u -r1.45 ide-scsi.c
--- drivers/scsi/ide-scsi.c	2002/01/16 20:58:39	1.45
+++ drivers/scsi/ide-scsi.c	2002/01/27 01:40:26
@@ -52,7 +52,7 @@
 #include "sd.h"
 #include <scsi/sg.h>
 
-#define IDESCSI_DEBUG_LOG		0
+/* #define IDESCSI_DEBUG_LOG		0 */
 
 typedef struct idescsi_pc_s {
 	u8 c[12];				/* Actual packet bytes */
@@ -132,13 +132,20 @@
 	int count;
 
 	while (bcount) {
+		void *addr; 
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
 			printk (KERN_ERR "ide-scsi: scatter gather table too small, discarding data\n");
 			idescsi_discard_data (drive, bcount);
 			return;
 		}
 		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_input_bytes (drive, pc->sg->address + pc->b_count, count);
+		/* This kmap should be moved earlier into process context
+		   and use kmap instead of kmap_atomic. Not now. 
+		   It also should use an own KMAP_ type to avoid deadlocks, 
+		   butter better do the first should. b_count is hopefully <= PAGE_SIZE */  
+		addr = kmap_atomic(pc->sg->page, KM_BOUNCE_READ);  
+		atapi_input_bytes (drive, addr + pc->sg->offset + pc->b_count, count);
+		kunmap_atomic(addr, KM_BOUNCE_READ); 
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -152,13 +159,16 @@
 	int count;
 
 	while (bcount) {
+		void *addr;
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
 			printk (KERN_ERR "ide-scsi: scatter gather table too small, padding with zeros\n");
 			idescsi_output_zeros (drive, bcount);
 			return;
 		}
 		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_output_bytes (drive, pc->sg->address + pc->b_count, count);
+		addr = kmap_atomic(pc->sg->page, KM_BOUNCE_READ); 
+		atapi_output_bytes (drive, addr + pc->sg->offset + pc->b_count, count);
+		kunmap_atomic(addr, KM_BOUNCE_READ); 
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -753,22 +763,21 @@
 			struct page *page = sg->page;
 			int offset = sg->offset;
 
+#if 0
 			if (!page) {
 				BUG_ON(!sg->address);
 				page = virt_to_page(sg->address);
 				offset = (unsigned long) sg->address & ~PAGE_MASK;
 			}
+#endif			
 				
 			bh->bi_io_vec[0].bv_page = page;
 			bh->bi_io_vec[0].bv_len = sg->length;
 			bh->bi_io_vec[0].bv_offset = offset;
 			bh->bi_size = sg->length;
 			bh = bh->bi_next;
-			/*
-			 * just until scsi_merge is fixed up...
-			 */
-			BUG_ON(PageHighMem(page));
-			sg->address = page_address(page) + offset;
+			sg->page =  page; 
+			sg->offset = offset; 
 			sg++;
 		}
 	} else {

