Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUIPGgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUIPGgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUIPGgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:36:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6592 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267685AbUIPGfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:35:52 -0400
Date: Thu, 16 Sep 2004 08:34:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.9-rc2 bio sickness with large writes
Message-ID: <20040916063416.GI2300@suse.de>
References: <4148D2C7.3050007@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148D2C7.3050007@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, Jeff V. Merkey wrote:
> 
> I am posting bio chains each with a total size of 64KB (16 pages each) 
> and of each of
> these I am posting chains of these bio requests in 128MB contiguous sectors
> (i.e.  bio = 16 pages = 64KB + bio =16 pages = 64KB + bio = 16 pages = 
> 64KB, etc.)
> 
> With the subsequent bio requests posted after the first bio is posted 
> the bio requests
> merge together, but I never get all the callbacks from the coaslesced 
> bio requests which
> are posted subsequent to the intial 64KB bio.  The data ends up making 
> it onto the drives
> and I am not seeing any data loss, the 2nd,3rd, .... etc. bios don't 
> seem to callback
> correctly.
> 
> This bug does not manifest itself every time on every bio chain.  It 
> only shows up
> part of the time.  about 1 in every 2-3 bio chains behave this way.  
> This is severely
> BUSTED and I am providing the calling code as an example of what may be 
> happening.
> 
> Attached is the write case and the callback.
> 
> Any ideas?  Also, if I use bio's the way Linus does in his buffer cache 
> code for submit_bh
> ine onesy - twosy mode the interface works just fine.  It is severely 
> broken with multiple pages, however.
> 
> Jeff
> 
> 
> 
> 
> 
> 

> 
> static int end_bio_asynch(struct bio *bio, unsigned int bytes_done, int err)
> {
>     ASYNCH_IO *io = bio->bi_private;
> 

      if (bio->bi_size)
		return 1;

>     if (err)
>     {
>        P_Print("asynch bio error %d\n", (int)err);
>        io->ccode = ASIO_IO_ERROR;
>        datascout_put_bio(io->bio);
>        io->bio = NULL; 
>        return 0;
>     }
> 
>     if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
>        io->ccode = ASIO_IO_ERROR;
> 
>     atomic_inc((atomic_t *)&io->complete);
>     if (io->complete == io->count)
>     {
>        datascout_put_bio(io->bio);
>        io->bio = NULL; 
>        insert_callback(io);
> 
> #if (PROFILE_AIO)
>        profile_complete();
> #endif
>        return 0;
>     }
>     return 1;
> 
> }
> 
> ULONG aWriteDiskSectors(ULONG disk, ULONG StartingLBA, BYTE *Sector,
> 		       ULONG sectors, ULONG readAhead, ASYNCH_IO *io)
> {
>     register ULONG i, bytesWritten = 0;
>     register ULONG bps, lba;
>     register DSDISK *DSDisk;
>     register ULONG rsize, blocks, blocksize, spb;
> 
>     DSDisk = SystemDisk[disk];
>     bps = DSDisk->BytesPerSector;
>     blocksize = DSDisk->DeviceBlockSize;
> 
>     if ((ULONG)(sectors * bps) % blocksize)
>        return 0;
> 
>     rsize = sectors * bps;
>     blocks = rsize / blocksize;
>     if (!blocks)
>        return 0;
>     spb = blocksize / bps;
>     
>     lba = StartingLBA / spb;
>     if (StartingLBA % spb)
>     {
>        P_Print("request not %d block aligned (%d) sectors-%d lba-%d (write)\n",
> 	       (int)blocksize, (int)(StartingLBA % spb), (int)sectors,
> 	       (int)StartingLBA);
>        return 0;
>     }
> 
>     io->bio = datascout_get_bio();
>     if (!io->bio)
>        return 0;
> 
>     if (io->bio->bi_max_vecs < blocks)
>        return 0;
> 
>     io->ccode = 0;
>     io->count = blocks;
>     io->complete = 0;
> 
>     io->bio->bi_bdev = DSDisk->PhysicalDiskHandle;
>     io->bio->bi_sector = StartingLBA;
>     io->bio->bi_idx = 0;
>     io->bio->bi_end_io = end_bio_asynch;
>     io->bio->bi_private = io;
>     io->bio->bi_vcnt = 0;
>     io->bio->bi_phys_segments = 0;
>     io->bio->bi_hw_segments = 0;
>     io->bio->bi_size = 0;
> 
>     for (i=0; i < blocks; i++)
>     {
> #if LINUX_26_BIO_ADDPAGE
>          register struct page *page = virt_to_page(&Sector[i * blocksize]);
>          register ULONG offset = ((ULONG)(&Sector[i * blocksize])) % PAGE_SIZE;
>          register ULONG bytes;
> 
>          bytes = bio_add_page(io->bio, page, 
>                               PAGE_SIZE - (offset % PAGE_SIZE), 0);

offset instead of 0?

>          bytesWritten += bytes;
> #else
>          register struct page *page = virt_to_page(&Sector[i * blocksize]);
>          register ULONG offset = ((ULONG)(&Sector[i * blocksize])) % PAGE_SIZE;
> 
> 	 io->bio->bi_io_vec[i].bv_page = page;
> 	 io->bio->bi_io_vec[i].bv_len = blocksize;
> 	 io->bio->bi_io_vec[i].bv_offset = offset;
> 	 io->bio->bi_vcnt++;
> 	 io->bio->bi_phys_segments++;
> 	 io->bio->bi_hw_segments++;
> 	 io->bio->bi_size += blocksize;
>          bytesWritten += blocksize;
> #endif
>     }

Get rid of this if/else, it's not correct. 2.6 always had
bio_add_page(), and you _must_ use it.

>     // unplug the queue and drain the bathtub
>     bio_get(io->bio);
>     submit_bio(WRITE | (1 << BIO_RW_SYNC), io->bio);
>     bio_put(io->bio);

You don't get to get/put the bio here, you aren't touching it after
submit_bio().

-- 
Jens Axboe

