Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRK2StP>; Thu, 29 Nov 2001 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283267AbRK2StE>; Thu, 29 Nov 2001 13:49:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17424 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283389AbRK2SsQ>;
	Thu, 29 Nov 2001 13:48:16 -0500
Date: Thu, 29 Nov 2001 19:47:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Dirk Pritsch <dirk@enterprise.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.5.1-pre3 in ide-scsi module
Message-ID: <20011129194752.T10601@suse.de>
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de> <20011129193956.S10601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129193956.S10601@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Jens Axboe wrote:
> Hmm, I bet the problem is not really bio but the fact that someone is
> still sending down a scatterlist with ->address set instead of
> ->page/offset.
> 
> Let me hack a quick fix up for you to test... 2 minutes.

Please try this, and check for oops and "jens was right" in dmesg. Let
me know how it goes, thanks.

--- /opt/kernel/linux-2.5.1-pre3/drivers/scsi/ide-scsi.c	Thu Nov 29 06:07:21 2001
+++ drivers/scsi/ide-scsi.c	Thu Nov 29 13:44:04 2001
@@ -708,16 +708,30 @@
 		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
-			bh->bi_io_vec[0].bv_page = sg->page;
+			struct page *page = sg->page;
+			int offset = sg->offset;
+			static int foo;
+
+			if (!page) {
+				BUG_ON(!sg->address);
+				if (!foo) {
+					printk("jens was right\n");
+					foo = 1;
+				}
+				page = virt_to_page(sg->address);
+				offset = (unsigned long) sg->address & ~PAGE_MASK;
+			}
+				
+			bh->bi_io_vec[0].bv_page = page;
 			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = sg->offset;
+			bh->bi_io_vec[0].bv_offset = offset;
 			bh->bi_size = sg->length;
 			bh = bh->bi_next;
 			/*
 			 * just until scsi_merge is fixed up...
 			 */
-			BUG_ON(PageHighMem(sg->page));
-			sg->address = page_address(sg->page) + sg->offset;
+			BUG_ON(PageHighMem(page));
+			sg->address = page_address(page) + offset;
 			sg++;
 		}
 	} else {

-- 
Jens Axboe

