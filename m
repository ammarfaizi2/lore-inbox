Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbSLKNbX>; Wed, 11 Dec 2002 08:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSLKNbX>; Wed, 11 Dec 2002 08:31:23 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:17605 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267143AbSLKNbT>; Wed, 11 Dec 2002 08:31:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [lvm-devel] Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 06:52:36 -0600
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti>
In-Reply-To: <20021211121749.GA20782@reti>
MIME-Version: 1.0
Message-Id: <02121106523600.29515@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 December 2002 06:17, Joe Thornber wrote:
> Kevin,
>
> On Tue, Dec 10, 2002 at 04:03:47PM -0600, Kevin Corry wrote:
> > Joe, Linus,
> >
> > This patch fixes problems with the device-mapper I/O path in 2.5.51. The
> > existing code does not properly split requests when necessary, and can
> > cause segfaults and/or data corruption. This can easily manifest itself
> > when running XFS on striped LVM volumes.
>
> Many thanks for doing this work, but _please_ split your patches up more.
> There are several changes rolled in here.

Sorry if I included too many changes in one post. I guess I didn't think the 
patch was really that big.

> I've split the patch up, and will post the ones I'm accepting as
> replies to this current mail.
>
> The full set of changes for 2.5.51 is available here:
> http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/
>
> This works for me with xfs and stripes (limited testing).
>
>
> These are the bits of your patch that I have queries about:
>
> --- linux-2.5.51a/drivers/md/dm.c	Tue Dec 10 11:01:13 2002
> +++ linux-2.5.51b/drivers/md/dm.c	Tue Dec 10 11:03:55 2002
> @@ -242,4 +242,4 @@
> -		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
> +		bio_endio(io->bio, io->bio->bi_size, io->error);
>
> You seem to be assuming that io->bio->bi_size will always be zero if
> an error occurs.  I was not aware that this was the case.

I'm simply going by the convention used by the other kernel drivers. Do a
grep for bio_endio and bio_io_error in drivers/. Most drivers (e.g. md, loop, 
rd, umem) call bio_endio() and bio_io_error() with the current bi_size of the 
bio they're completing.


> @@ -261,15 +262,15 @@
>  {
>  	struct dm_io *io = bio->bi_private;
>
> -	/*
> -	 * Only call dec_pending if the clone has completely
> -	 * finished.  If a partial io errors I'm assuming it won't
> -	 * be requeued.  FIXME: check this.
> -	 */
> -	if (error || !bio->bi_size) {
> -		dec_pending(io, error);
> -		bio_put(bio);
> +	if (bio->bi_size)
> +		return 1;
> +
> +	if (error) {
> +		struct gendisk *disk = dm_disk(io->md);
> +		DMWARN("I/O error (%d) on device %s\n", error, disk->disk_name);
>  	}
> +	dec_pending(io, error);
> +	bio_put(bio);
>
>  	return 0;
>  }
>
>
> All you're doing here is adding a warning (which is nice), and making
> the same assumption about bio->bi_size in the case of an error.

Again, I changed this based on conventions used by other drivers. Take a look 
at loop_end_io_transfer() in drivers/block/loop.c, or end_request() and 
end_sync_write() in drivers/md/raid1.c. If a driver doesn't want to bother 
with partion bio completions (and DM shouldn't), it should do a
  if (bio->bi_size) return 1;
statement at the top of its callback. Check out the original comments 
regarding this in the BK tree at:
http://linux.bkbits.net:8080/linux-2.5/cset@1.536.40.4?nav=index.html|ChangeSet@-1y

> @@ -457,13 +483,13 @@
>  		up_read(&md->lock);
>
>  		if (bio_rw(bio) == READA) {
> -			bio_io_error(bio, 0);
> +			bio_io_error(bio, bio->bi_size);
>  			return 0;
>  		}
>
>  		r = queue_io(md, bio);
>  		if (r < 0) {
> -			bio_io_error(bio, 0);
> +			bio_io_error(bio, bio->bi_size);
>  			return 0;
>
>  		} else if (r == 0)
>
> Why is it better to say that all the io was 'done' rather than none?
> It did fail after all.

See comments above.

> @@ -369,24 +369,48 @@
>  {
>  	struct bio *clone, *bio = ci->bio;
>  	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
> -	sector_t len = max_io_len(ci->md, bio->bi_sector, ti);
> +	sector_t bv_len, len = max_io_len(ci->md, ci->sector, ti);
> +	struct bio_vec *bv;
> +	int i, vcnt = bio->bi_vcnt - ci->idx;
>
>  	/* shorter than current target ? */
>  	if (ci->sector_count < len)
>  		len = ci->sector_count;
>
>  	/* create the clone */
> -	clone = bio_clone(ci->bio, GFP_NOIO);
> +	clone = bio_alloc(GFP_NOIO, vcnt);
> +	if (!clone) {
> +		dec_pending(ci->io, -ENOMEM);
> +		return;
> +	}
>  	clone->bi_sector = ci->sector;
> -	clone->bi_idx = ci->idx;
> +	clone->bi_bdev = bio->bi_bdev;
> +	clone->bi_rw = bio->bi_rw;
> +	clone->bi_vcnt = vcnt;
>  	clone->bi_size = len << SECTOR_SHIFT;
>  	clone->bi_end_io = clone_endio;
>  	clone->bi_private = ci->io;
>
> +	/* copy the original vector and adjust if necessary. */
> +	memcpy(clone->bi_io_vec, bio->bi_io_vec + ci->idx,
> +	       vcnt * sizeof(*clone->bi_io_vec));
> +	bv_len = len << SECTOR_SHIFT;
> +	bio_for_each_segment(bv, clone, i) {
> +		if (bv_len >= bv->bv_len) {
> +			bv_len -= bv->bv_len;
> +		} else {
> +			bv->bv_len = bv_len;
> +			clone->bi_vcnt = i + 1;
> +			break;
> +		}
> +	}
> +
> +	/* submit this io */
> +	__map_bio(ti, clone);
> +
>  	/* adjust the remaining io */
>  	ci->sector += len;
>  	ci->sector_count -= len;
> -	__map_bio(ti, clone);
>
>  	/*
>  	 * If we are not performing all remaining io in this
> @@ -395,9 +419,9 @@
>  	 */
>  	if (ci->sector_count) {
>  		while (len) {
> -			struct bio_vec *bv = clone->bi_io_vec + ci->idx;
> -			sector_t bv_len = bv->bv_len >> SECTOR_SHIFT;
> +			bv = bio->bi_io_vec + ci->idx;
> +			bv_len = bv->bv_len >> SECTOR_SHIFT;
>  			if (bv_len <= len)
>  				len -= bv_len;
>
>
> There is no need to use bio_alloc in preference to bio_clone, we're
> not changing the bvec in any way.  All of the above code is redundant.

Yes, we *are* going to have to change the bvec (as I implied in my original 
post). If you split a bio, and that split occurs in the middle of one of the 
bvecs (i.e. in the middle of a page), then the bv_len field in that bvec 
*must* be adjusted accordingly (which is what the bio_for_each_segment loop 
above does). Otherwise when blk_rq_map_sg() in drivers/block/ll_rw_block.c 
processes that bio, it will think that bvec contains a full page. Since that 
page obviously spans a stripe or PE boundary, this is going to cause data 
corruption.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
