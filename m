Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbTA1V5J>; Tue, 28 Jan 2003 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbTA1V5J>; Tue, 28 Jan 2003 16:57:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38575 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261409AbTA1V5I>;
	Tue, 28 Jan 2003 16:57:08 -0500
Date: Tue, 28 Jan 2003 23:06:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Larry Sendlosky <Larry.Sendlosky@storigen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030128220607.GF31566@suse.de>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28 2003, Larry Sendlosky wrote:
> I was glad to see the physical page support in 2.4.20.
> (and also noticed that the current BK tree clobbered it
> on a patch set from Alan).
> 
> One question, 
> 
> +		lastdataend = bh_phys(bh) + bh->b_size;
> 
> bh_phys(x) uses bh->b_page. Does it make a difference
> if bh->b_page is zero? What if someone combines virt and phys
> buffer addresses in bh list?

Yes good catch! New version attached.

===== drivers/ide/ide-dma.c 1.7 vs edited =====
--- 1.7/drivers/ide/ide-dma.c	Wed Nov 20 18:46:24 2002
+++ edited/drivers/ide/ide-dma.c	Tue Jan 28 23:04:32 2003
@@ -249,6 +249,7 @@
 {
 	struct buffer_head *bh;
 	struct scatterlist *sg = hwif->sg_table;
+	unsigned long lastdataend = ~0UL;
 	int nents = 0;
 
 	if (hwif->sg_dma_active)
@@ -256,24 +257,42 @@
 
 	bh = rq->bh;
 	do {
-		unsigned char *virt_addr = bh->b_data;
-		unsigned int size = bh->b_size;
+		int contig = 0;
+
+		if (bh->b_page) {
+			if (bh_phys(bh) == lastdataend)
+				contig = 1;
+		} else {
+			if ((unsigned long) bh->b_data == lastdataend)
+				contig = 1;
+		}
+
+		if (contig) {
+			sg[nents - 1].length += bh->b_size;
+			lastdataend += bh->b_size;
+			continue;
+		}
 
 		if (nents >= PRD_ENTRIES)
 			return 0;
 
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
-		}
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
-		if(size == 0)
-			BUG();
+
+		if (bh->b_page) {
+			sg[nents].page = bh->b_page;
+			sg[nents].offset = bh_offset(bh);
+			lastdataend = bh_phys(bh) + bh->b_size;
+		} else {
+			if ((unsigned long) bh->b_data < PAGE_SIZE)
+				BUG();
+
+			sg[nents].address = bh->b_data;
+			lastdataend = (unsigned long) bh->b_data + bh->b_size;
+		}
+
+		sg[nents].length = bh->b_size;
 		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
 	if(nents == 0)
 		BUG();

-- 
Jens Axboe

