Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSEUMvT>; Tue, 21 May 2002 08:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSEUMvS>; Tue, 21 May 2002 08:51:18 -0400
Received: from imladris.infradead.org ([194.205.184.45]:8717 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314456AbSEUMvR>; Tue, 21 May 2002 08:51:17 -0400
Date: Tue, 21 May 2002 13:51:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible fix for broken floppy driver since 2.5.13
Message-ID: <20020521135108.A14298@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205201701.TAA04143@harpo.it.uu.se> <20020521132451.A13419@infradead.org> <15594.16140.857729.697091@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 02:35:24PM +0200, Mikael Pettersson wrote:
> I haven't got a clue on how to program Linux' block I/O interfaces.
> Show me how to do a modern equivalent of getblk(dev,0,1024) + waiting
> for the operation to complete and I'll update the patch ASAP.

I think something like the following should do it.
(WARNING: entirely untested)



static void io_done(struct bio *bio)
{
	complete((struct completion *)bio->bi_private);
}

static int doio(struct block_device *bdev, size_t size)
{
	struct completion comp;
	struct page * page;
	struct bio * bio;

	bio = bio_alloc(GFP_KERNEL, 1);
	if (!bio)
		return -ENOMEM;

	page = alloc_page(GFP_KERNEL);
	if (!page) {
		bio_put(bio);
		return -ENOMEM;
	}

	bio->bi_sector = 0;
	bio->bi_bdev = bdev;
	bio->bi_io_vec[0].bv_page = page;
	bio->bi_io_vec[0].bv_len = size;
	bio->bi_io_vec[0].bv_offset = 0;

	bio->bi_vcnt = 1;
	bio->bi_idx = 0;
	bio->bi_size = LOGPSIZE;

	bio->bi_end_io = io_done;
	bio->bi_private = &complete;

	submit_bio(READ, bio);
	run_task_queue(&tq_disk);

	wait_for_completion(&comp);

	bio_put(bio);
	__free_page(page);

	return 0;
}

