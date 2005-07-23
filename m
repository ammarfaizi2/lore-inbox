Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVGWU76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGWU76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGWU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:59:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261677AbVGWU75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:59:57 -0400
Date: Sat, 23 Jul 2005 22:59:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, dmo@osdl.org
Subject: Re: [PATCH] kill bio->bi_set
Message-ID: <20050723205956.GA17370@suse.de>
References: <20050720222949.GE2548@suse.de> <m34qaljnvd.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qaljnvd.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23 2005, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > Dunno why I didn't notice before, but ->bi_set is totally unnecessary
> > bloat of struct bio. Just define a proper destructor for the bio and it
> > already knows what bio_set it belongs too.
> 
> This causes crashes on my computer.

Did I neglect to mention it was untested? :)

> > +void bio_free(struct bio *bio, struct bio_set *bio_set)
> >  {
> >  	const int pool_idx = BIO_POOL_IDX(bio);
> > -	struct bio_set *bs = bio->bi_set;
> >  
> >  	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
> >  
> > -	mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
> > -	mempool_free(bio, bs->bio_pool);
> > +	mempool_free(bio->bi_io_vec, fs_bio_set->bvec_pools[pool_idx]);
> > +	mempool_free(bio, fs_bio_set->bio_pool);
> > +}
> 
> This function uses fs_bio_set instead of the function parameter
> bio_set.

Clear mistake, thanks.

> > @@ -171,8 +175,6 @@ struct bio *bio_alloc_bioset(unsigned in
> >  			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
> >  		}
> >  		bio->bi_io_vec = bvl;
> > -		bio->bi_destructor = bio_destructor;
> > -		bio->bi_set = bs;
> >  	}
> 
> This change means that all code that calls bio_alloc_bioset() must now

Correct. The alternative was to require a destructor function passed
into bio_alloc_bioset().

> set bi_destructor, but this is forgotten in bio_clone() in bio.c and
> in split_bvec() in dm.c.

Thanks, I'll go over these and submit a fixed version.

-- 
Jens Axboe

