Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSEZQrq>; Sun, 26 May 2002 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316215AbSEZQrp>; Sun, 26 May 2002 12:47:45 -0400
Received: from [195.39.17.254] ([195.39.17.254]:48539 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316214AbSEZQrn>;
	Sun, 26 May 2002 12:47:43 -0400
Date: Sun, 26 May 2002 16:19:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Mikael Pettersson <mikpe@csd.uu.se>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible fix for broken floppy driver since 2.5.13
Message-ID: <20020526141922.GA4756@elf.ucw.cz>
In-Reply-To: <200205201701.TAA04143@harpo.it.uu.se> <20020521132451.A13419@infradead.org> <15594.16140.857729.697091@kim.it.uu.se> <20020521135108.A14298@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I haven't got a clue on how to program Linux' block I/O interfaces.
> > Show me how to do a modern equivalent of getblk(dev,0,1024) + waiting
> > for the operation to complete and I'll update the patch ASAP.
> 
> I think something like the following should do it.
> (WARNING: entirely untested)

This looks pretty complicated... Maybe bread() is worth being put back
for 2.5?
								Pavel

> static void io_done(struct bio *bio)
> {
> 	complete((struct completion *)bio->bi_private);
> }
> 
> static int doio(struct block_device *bdev, size_t size)
> {
> 	struct completion comp;
> 	struct page * page;
> 	struct bio * bio;
> 
> 	bio = bio_alloc(GFP_KERNEL, 1);
> 	if (!bio)
> 		return -ENOMEM;
> 
> 	page = alloc_page(GFP_KERNEL);
> 	if (!page) {
> 		bio_put(bio);
> 		return -ENOMEM;
> 	}
> 
> 	bio->bi_sector = 0;
> 	bio->bi_bdev = bdev;
> 	bio->bi_io_vec[0].bv_page = page;
> 	bio->bi_io_vec[0].bv_len = size;
> 	bio->bi_io_vec[0].bv_offset = 0;
> 
> 	bio->bi_vcnt = 1;
> 	bio->bi_idx = 0;
> 	bio->bi_size = LOGPSIZE;
> 
> 	bio->bi_end_io = io_done;
> 	bio->bi_private = &complete;
> 
> 	submit_bio(READ, bio);
> 	run_task_queue(&tq_disk);
> 
> 	wait_for_completion(&comp);
> 
> 	bio_put(bio);
> 	__free_page(page);
> 
> 	return 0;
> }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
