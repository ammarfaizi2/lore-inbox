Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVBATQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVBATQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVBATQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:16:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:18156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261409AbVBATQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:16:15 -0500
Date: Tue, 1 Feb 2005 11:16:10 -0800
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, agk@sourceware.org, dm-devel@redhat.com
Subject: Re: [dm-devel] Re: [RFC] [PATCH] bio-set patch on latest bk source tree
Message-ID: <20050201191610.GA5112@osdl.org>
References: <20050201010431.GA4244@osdl.org> <20050201075551.GC4137@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201075551.GC4137@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

Thanks for the review!  Your comments are quite
right on all counts.  Can't imagine how I
slipped on that test for non-Null.

I'll reduce the 512 bioset allocation sizes to 16,
give it a test see where that goes. I think I'll
need to change the scale to 4 as well.

I'll apply your fixes, and submit to Andrew today.

Dave

On Tue, Feb 01, 2005 at 08:55:52AM +0100, Jens Axboe wrote:
> On Mon, Jan 31 2005, Dave Olien wrote:
> > 
> > Hi, Jens,
> > 
> > I sent you a patch for review about a week ago.  Here is that same
> > patch, applied to the latest bk kernel.  Thanks in advance for the review
> 
> Thanks Dave, I think we should queue this up with Andrew soonish. A few
> minor things need fixing, though:
> 
> > ===== drivers/md/dm.c 1.61 vs edited =====
> > --- 1.61/drivers/md/dm.c	2005-01-25 13:50:21 -08:00
> > +++ edited/drivers/md/dm.c	2005-01-31 11:37:27 -08:00
> > @@ -96,10 +96,16 @@ struct mapped_device {
> >  static kmem_cache_t *_io_cache;
> >  static kmem_cache_t *_tio_cache;
> >  
> > +static struct bio_set *dm_set;
> > +
> >  static int __init local_init(void)
> >  {
> >  	int r;
> >  
> > +	dm_set = bioset_create(512, 512, 1);
> > +	if (!dm_set)
> > +		return -ENOMEM;
> > +
> 
> You consistently use 512, that's a _lot_ of reserved bio's/vecs! For the
> full range of bio_vec pools, that will eat quite a large piece of memory
> per bio_set allocated. The idea with a mempool isn't to have a huge free
> number of elements, but rather just a few to maintain progress with
> memory pressure. I think this 512 should be heavily reduced.
> 
> >  static int zero_map(struct dm_target *ti, struct bio *bio,
> > ===== fs/bio.c 1.73 vs edited =====
> > --- 1.73/fs/bio.c	2005-01-20 21:02:13 -08:00
> > +++ edited/fs/bio.c	2005-01-31 14:50:37 -08:00
> > @@ -28,7 +28,6 @@
> >  
> >  #define BIO_POOL_SIZE 256
> >  
> > -static mempool_t *bio_pool;
> >  static kmem_cache_t *bio_slab;
> >  
> >  #define BIOVEC_NR_POOLS 6
> > @@ -40,11 +39,10 @@ static kmem_cache_t *bio_slab;
> >  #define BIO_SPLIT_ENTRIES 8	
> >  mempool_t *bio_split_pool;
> >  
> > -struct biovec_pool {
> > +struct biovec_slab {
> >  	int nr_vecs;
> >  	char *name; 
> >  	kmem_cache_t *slab;
> > -	mempool_t *pool;
> >  };
> >  
> >  /*
> > @@ -54,15 +52,32 @@ struct biovec_pool {
> >   */
> >  
> >  #define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
> > -static struct biovec_pool bvec_array[BIOVEC_NR_POOLS] = {
> > +static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] = {
> >  	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
> >  };
> >  #undef BV
> >  
> > -static inline struct bio_vec *bvec_alloc(int gfp_mask, int nr, unsigned long *idx)
> > +/*
> > + * bio_set is used to allow other portions of the IO system to
> > + * allocate their own private memory pools for bio and iovec structures.
> > + * These memory pools in turn all allocate from the bio_slab
> > + * and the bvec_slabs[].
> > + */
> > +struct bio_set {
> > +	mempool_t *bio_pool;
> > +	mempool_t *bvec_pools[BIOVEC_NR_POOLS];
> > +};
> > +
> > +/*
> > + * fs_bio_set is the bio_set containing bio and iovec memory pools used by
> > + * IO code that does not need private memory pools.
> > + */
> > +static struct bio_set *fs_bio_set;
> > +
> > +static inline struct bio_vec *bvec_alloc_bs(int gfp_mask, int nr, unsigned long *idx, struct bio_set *bs)
> >  {
> > -	struct biovec_pool *bp;
> >  	struct bio_vec *bvl;
> > +	struct biovec_slab *bp;
> >  
> >  	/*
> >  	 * see comment near bvec_array define!
> > @@ -80,26 +95,27 @@ static inline struct bio_vec *bvec_alloc
> >  	/*
> >  	 * idx now points to the pool we want to allocate from
> >  	 */
> > -	bp = bvec_array + *idx;
> >  
> > -	bvl = mempool_alloc(bp->pool, gfp_mask);
> > +	bp = bvec_slabs + *idx;
> > +	bvl = mempool_alloc(bs->bvec_pools[*idx], gfp_mask);
> >  	if (bvl)
> >  		memset(bvl, 0, bp->nr_vecs * sizeof(struct bio_vec));
> > +
> >  	return bvl;
> >  }
> >  
> >  /*
> > - * default destructor for a bio allocated with bio_alloc()
> > + * default destructor for a bio allocated with bio_alloc_bs()
> >   */
> >  static void bio_destructor(struct bio *bio)
> >  {
> >  	const int pool_idx = BIO_POOL_IDX(bio);
> > -	struct biovec_pool *bp = bvec_array + pool_idx;
> > +	struct bio_set *bs = bio->bi_set;
> >  
> >  	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
> >  
> > -	mempool_free(bio->bi_io_vec, bp->pool);
> > -	mempool_free(bio, bio_pool);
> > +	mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
> > +	mempool_free(bio, bs->bio_pool);
> >  }
> >  
> >  inline void bio_init(struct bio *bio)
> > @@ -121,18 +137,21 @@ inline void bio_init(struct bio *bio)
> >  }
> >  
> >  /**
> > - * bio_alloc - allocate a bio for I/O
> > + * bio_alloc_bs - allocate a bio for I/O
> >   * @gfp_mask:   the GFP_ mask given to the slab allocator
> >   * @nr_iovecs:	number of iovecs to pre-allocate
> 
> bs is awefully close to 'block size' when it comes to acronyms in this
> area, I would prefer if you just called it bio_alloc_bioset() instead.
> 
> > +void bioset_free(struct bio_set *bs)
> > +{
> > +	if (!bs->bio_pool)
> > +		mempool_destroy(bs->bio_pool);
> 
> That check looks suspect, surely you mean to check for non-NULL.
> 
> > +
> > +	biovec_free_pools(bs);
> > +
> > +	kfree(bs);
> > +}
> > +
> > +struct bio_set *bioset_create(int bio_pool_size, int bvec_pool_size, int scale)
> > +{
> > +	struct bio_set *bs = kmalloc(sizeof(*bs), GFP_KERNEL);
> > +
> > +	if (!bs)
> > +		return NULL;
> > +
> > +	memset(bs, 0, sizeof(*bs));
> > +	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
> > +			mempool_free_slab, bio_slab);
> > +
> > +	if (!bs->bio_pool) 
> > +		goto bad;
> > +	
> > +	if (biovec_create_pools(bs, bvec_pool_size, scale))
> > +		goto bad;
> > +
> > +	return bs;
> > +
> > +bad:
> > +	bioset_free(bs);
> > +	return NULL;
> > +}
> 
> Please drop the last goto
> 
>         if (!biovec_create_pools(bs, bvec_pool_size, scale))
>                 return bs;
> 
> is nicer.
> 
> -- 
> Jens Axboe
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
