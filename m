Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHBMiR>; Fri, 2 Aug 2002 08:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHBMiR>; Fri, 2 Aug 2002 08:38:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51852 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312560AbSHBMiP>;
	Fri, 2 Aug 2002 08:38:15 -0400
Date: Fri, 2 Aug 2002 14:41:39 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
Message-ID: <20020802124139.GR3010@suse.de>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com> <20020802114713.GD1055@suse.de> <3D4A7178.7050307@evision.ag> <1028289940.1123.19.camel@laptop.americas.sgi.com> <3D4A771A.9020308@evision.ag> <20020802123055.GQ3010@suse.de> <3D4A7BBE.90104@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4A7BBE.90104@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02 2002, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> 
> >>*/
> >>+	ch->max_segment_size = (1<<16) - 512;
> >>
> >>
> >>I would in esp. like to see the result of setting  ch->max_segment_size 
> >>= (1 << 15).
> >
> >
> >This might not be such a good idea, since the limit-bio-size etc stuff
> >isn't in yet, depending on _exactly_ how big the bio's xfs are building
> >are. If they are max 8 pages (I seem to recall so), then yeah the above
> >test would be nice to see. If they are bigger than 8 pages, then the
> >above would be a meaningless test.
> 
> Sure. I'm aware of this. And I haven't looked at the XFS code
> yet, so I can only guess about it.
> 
> What I can do myself is just pushing this limit even lower just to
> see at which point my own system (ext3) starts to turn tits up ...
> 
> >I'll hack up a rq_dump() function to slap in pcidma.c as well.
> 
> Yes that would be a "nice to have too".
> But it is a request for actual data as far as I can see.

Yeah it's a request for data, what else could it be? That's the only
place where we call blk_rq_map_sg().

Stephen, please provoke with this patch applied. I hope it works, it's
untested :-)

--- drivers/ide/pcidma.c~	2002-08-02 14:32:14.000000000 +0200
+++ drivers/ide/pcidma.c	2002-08-02 14:39:21.000000000 +0200
@@ -58,6 +58,24 @@
 	return ata_error(drive, rq, __FUNCTION__);
 }
 
+static void rq_dump(struct request *rq, int build_segments)
+{
+	struct bio_vec *bvec;
+	struct bio *bio;
+	int i = 0, ibio = 0;
+
+	printk("pcidma: build %d segments, supplied %d/%d, sectors %ld/%d\n", build_segments, rq->nr_phys_segments, rq->nr_hw_segments, rq->nr_sectors, rq->current_nr_sectors);
+
+	rq_for_each_bio(bio, rq) {
+		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
+		printk("bio %d: phys %d, hw %d\n", ibio, bio_phys_segments(rq->q, bio), bio_hw_segments(rq->q, bio));
+		bio_for_each_segment(bvec, bio, i) {
+			printk("segment %d: phys %lu, size %u\n", i, bvec_to_phys(bvec), bvec->bv_len);
+		}
+		ibio++;
+	}
+}
+
 /*
  * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
  * FIXME: I agree with Jens --mdcki!
@@ -107,7 +125,7 @@
 		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
 
 		if (rq->q && nents > rq->nr_phys_segments)
-			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+			rq_dump(rq, nents);
 
 		if (rq_data_dir(rq) == READ)
 			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;

-- 
Jens Axboe

