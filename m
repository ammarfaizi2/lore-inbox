Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbRLILgs>; Sun, 9 Dec 2001 06:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283343AbRLILgj>; Sun, 9 Dec 2001 06:36:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49417 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283340AbRLILg3>;
	Sun, 9 Dec 2001 06:36:29 -0500
Date: Sun, 9 Dec 2001 12:36:13 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: lnz@dandelion.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch(?): linux-2.5.1-pre7/drivers/block/DAC960.c compilation fixes
Message-ID: <20011209113613.GG20061@suse.de>
In-Reply-To: <20011208211232.A7241@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011208211232.A7241@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08 2001, Adam J. Richter wrote:
> 	The following patch makes linux-2.5.1-pre7/drivers/block/DAC960.c
> compile.  I'm not confident in my understanding of the new "bio" system,
> so it would be helpful if someone more knowledgeable about bio could
> check it.  The changes are:
> 
> 	1. Delete references the nonexistant MaxSectorsPerRequest field.
> 	   The code already sets RequestQueue->max_sectors.
> 
> 	2. Replace the undefined bio_size(BufferHead) with BufferHead->bi_size
> 	   (in many places, which is why the diff is big).
> 
> 	3. Add a missing parameter in one place, changing
> 		BufferHeader->bi_end_io(BufferHeader)
> 	   to
> 		BufferHeader->bi_end_io(BufferHeader, bio_sectors(BufferHeader))
> 
> 
> 	#3 is the one that I have the most doubts about.

It's not as easy as this. Note that you can have more than one page
entry in a bio, so if you simply use bio_data() on each bio and then
jump to the next through bi_next, then you are discarding every page but
the first one.

You want to do something like this:

	rq_for_each_bio(bio, rq)
		bio_for_each_segment(bio_vec, bio, i)
			/* handle each bio_vec */

DAC960 needs a huge cleanup to support highmem as well, Virtual_to_Bus32
and Virtual_to_Bus64, yuck, chest pains.

As a reference, read drivers/block/cciss.c for example which I've
converted to use the blk_rq_map_sg interface. Basically you don't have
to worry about any of this. You can check ide-dma.c too, note how easy
it is to setup a scatterlist mapping for DMA from a request now:

	/*
	 * map the request into a scatterlist
	 */
	nr_sg_entries = blk_rq_map_sg(q, rq, sg_table);

	/*
	 * map the scatterlist pages for streaming dma
	 */
	sg_nents = pci_map_sg(dev, sg_table, nr_sg_entries, data_dir);

-- 
Jens Axboe

