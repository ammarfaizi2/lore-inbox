Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbTA1QcL>; Tue, 28 Jan 2003 11:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbTA1QcL>; Tue, 28 Jan 2003 11:32:11 -0500
Received: from [65.193.106.66] ([65.193.106.66]:56336 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id <S267382AbTA1QcH> convert rfc822-to-8bit; Tue, 28 Jan 2003 11:32:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.4.21-pre3 kernel crash
Date: Tue, 28 Jan 2003 11:41:21 -0500
Message-ID: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.21-pre3 kernel crash
Thread-Index: AcLGW57lTKVtMtjzSpe32dTwQEo/XgAj87Wg
From: "Larry Sendlosky" <Larry.Sendlosky@storigen.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was glad to see the physical page support in 2.4.20.
(and also noticed that the current BK tree clobbered it
on a patch set from Alan).

One question, 

+		lastdataend = bh_phys(bh) + bh->b_size;

bh_phys(x) uses bh->b_page. Does it make a difference
if bh->b_page is zero? What if someone combines virt and phys
buffer addresses in bh list?

thanks
larry


-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Monday, January 27, 2003 6:24 PM
To: J.A. Magallon
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash


On Tue, Jan 28 2003, J.A. Magallon wrote:
> 
> On 2003.01.27 Jens Axboe wrote:
> > On Mon, Jan 27 2003, Martin MOKREJ? wrote:
> > > On Mon, 27 Jan 2003, Ross Biro wrote:
> > > 
> > > > This looks like the same problem I ran into with IDE and highmem not
> > > > getting along.  Try compiling your kernel with out highmem enabled and
> > > > see what happenes.
> > > 
> > > Yes, that "fixes" it. Any "better solution"? ;-)
> > > 
> > > > >Trace; c024dfc1 <ide_build_sglist+181/1a0>
> > > > >Trace; c024e1b4 <ide_build_dmatable+54/1a0>
> > > > >Trace; c024e6df <__ide_dma_read+3f/150>
> > 
> > Someone completely lost the highmem capable scatterlist setup, *boggle*.
> > This should fix it.
> > 
> 
> Applied on top of 2.4.21-pre3-aa (no highmem), it makes my box hang on drive
> detection:
> 
> PIIX4: IDE controller at PCI slot 00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: 
> 
> <hangs here>
> 
> normal startup says:
> 
> hda: Conner Peripherals 1080MB - CFS1081A, ATA DISK drive
> hdb: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
> blk: queue 403386e0, I/O limit 4095Mb (mask 0xffffffff)
> hdc: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
> hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: 2114180 sectors (1082 MB), CHS=524/64/63, DMA

Reviewing the patch, it did have a nasty bug, didn't iterate
buffer_heads at all so a clustered request will fail. Attached version
should work.

===== drivers/ide/ide-dma.c 1.7 vs edited =====
--- 1.7/drivers/ide/ide-dma.c	Wed Nov 20 18:46:24 2002
+++ edited/drivers/ide/ide-dma.c	Tue Jan 28 00:23:45 2003
@@ -249,6 +249,7 @@
 {
 	struct buffer_head *bh;
 	struct scatterlist *sg = hwif->sg_table;
+	unsigned long lastdataend = ~0UL;
 	int nents = 0;
 
 	if (hwif->sg_dma_active)
@@ -256,24 +257,30 @@
 
 	bh = rq->bh;
 	do {
-		unsigned char *virt_addr = bh->b_data;
-		unsigned int size = bh->b_size;
+		if (bh_phys(bh) == lastdataend) {
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
+		if (bh->b_page) {
+			sg[nents].page = bh->b_page;
+			sg[nents].offset = bh_offset(bh);
+		} else {
+			if (((unsigned long) bh->b_data) < PAGE_SIZE)
+				BUG();
+
+			sg[nents].address = bh->b_data;
+		}
+
+		sg[nents].length = bh->b_size;
+		lastdataend = bh_phys(bh) + bh->b_size;
 		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
 	if(nents == 0)
 		BUG();

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

