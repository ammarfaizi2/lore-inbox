Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCAOfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCAOfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWCAOfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:35:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9549 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932222AbWCAOfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:35:07 -0500
Date: Wed, 1 Mar 2006 15:34:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301143438.GX4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com> <200603011505.23222.ak@suse.de> <20060301141848.GW4816@suse.de> <200603011526.39457.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011526.39457.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andi Kleen wrote:
> On Wednesday 01 March 2006 15:18, Jens Axboe wrote:
> > On Wed, Mar 01 2006, Andi Kleen wrote:
> > > On Wednesday 01 March 2006 14:41, Jens Axboe wrote:
> > > > On Wed, Mar 01 2006, Andy Chittenden wrote:
> > > > > with revised patch that does:
> > > > > 
> > > > >                 printk("sg%d: dma=%llx, dma_len=%u/%u, pfn=%lu\n", i,
> > > > > (unsigned long long) sg->dma_address, sg->dma_length, sg->offset,
> > > > > page_to_pfn(sg->page));
> > > > 
> > > > That is correct, thanks!
> > > > 
> > > > > hda: DMA table too small
> > > > > ide dma table, 255 entries, bounce pfn 1310720
> > > > > sg0: dma=81c8800, dma_len=4096/0, pfn=1296369
> > > > 
> > > > Still the same badness here, it's 2kb into a page so straddles two pages
> > > > for one entry.
> > > 
> > > That's normal if it was in the IOMMU and a merged entry. 
> > > 
> > > You can try iommu=nomerge.
> > > 
> > > Or maybe the higher layers are passing in physically continuous pages
> > > that get merged? Not too unlikely at boot.
> > 
> > But that would have to be 1kb or 512b io going in
> 
> Yes. Why not?

It's not totally out of the question, but I would say it's unlikely.
Andy, I have generated a new debug patch that also dumps the request in
question, can you apply that one? It replaces the earlier patch...

> > > > Andi, any idea what is going on here? Why is this throwing up all of a
> > > > sudden??
> > > 
> > > What is throwing up exactly?
> > >
> > > There was a change recently in the merging algorithm, but it shouldn't
> > > cause any bad side effects for correct users of *_map_sg()
> > 
> > That the request we end up passing to blk_rq_map_sg() and then to
> > pci_map_sg() ends up with more entries than the driver advertised. So
> > far I think only Andy reported this, and then only with your
> > blk_queue_bounce_limit() patch applied.
> 
> It shouldn't end up with more, only with less.

Sure yes, but if that 'less' is still more than what the driver can
handle, then there's a problem.

> Does iommu=nomerge make a difference?

Andy?


diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 0523da7..f893f98 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -221,6 +221,37 @@ int ide_build_sglist(ide_drive_t *drive,
 
 EXPORT_SYMBOL_GPL(ide_build_sglist);
 
+static void dump_dma_table(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	request_queue_t *q = drive->queue;
+	struct bio *bio;
+	struct bio_vec *bvec;
+	int i;
+
+	printk("ide dma table, %d entries, bounce pfn %lu\n", hwif->sg_nents, q->bounce_pfn);
+	for (i = 0; i < hwif->sg_nents; i++) {
+		struct scatterlist *sg = &hwif->sg_table[i];
+
+		printk("sg%d: dma=%llx, len=%u/%u, pfn=%lu\n", i, (unsigned long long) sg->dma_address, sg->dma_length, sg->offset, page_to_pfn(sg->page));
+	}
+
+	printk("request: phys seg %d, hw seg %d, nr_sectors %lu\n", rq->nr_phys_segments, rq->nr_hw_segments, rq->nr_sectors);
+	i = 0;
+	rq_for_each_bio(bio, rq) {
+		int j;
+
+		printk("  bio%d: bytes=%u, phys seg %d, hw seg %d\n", i, bio->bi_size, bio->bi_phys_segments, bio->bi_hw_segments);
+		bio_for_each_segment(bvec, bio, j) {
+			void *addr = page_address(bvec->bv_page);
+
+			printk("    bvec%d: addr=%p, size=%u, off=%u\n", j, addr, bvec->bv_len, bvec->bv_offset);
+		}
+		i++;
+	}
+
+}
+
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
@@ -311,6 +342,7 @@ use_pio_instead:
 		     hwif->sg_table,
 		     hwif->sg_nents,
 		     hwif->sg_dma_direction);
+	dump_dma_table(drive, rq);
 	return 0; /* revert to PIO for this request */
 }
 

-- 
Jens Axboe

