Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTA0XO5>; Mon, 27 Jan 2003 18:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbTA0XO5>; Mon, 27 Jan 2003 18:14:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58515 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263977AbTA0XO4>;
	Mon, 27 Jan 2003 18:14:56 -0500
Date: Tue, 28 Jan 2003 00:24:12 +0100
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127232412.GF17791@suse.de>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz> <20030127192327.GD889@suse.de> <20030127231819.GA1651@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127231819.GA1651@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

