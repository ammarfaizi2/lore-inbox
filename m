Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVGWT7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVGWT7B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVGWT7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:59:01 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:19090 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261556AbVGWT67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:58:59 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, dmo@osdl.org
Subject: Re: [PATCH] kill bio->bi_set
References: <20050720222949.GE2548@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Jul 2005 21:58:30 +0200
In-Reply-To: <20050720222949.GE2548@suse.de>
Message-ID: <m34qaljnvd.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> Dunno why I didn't notice before, but ->bi_set is totally unnecessary
> bloat of struct bio. Just define a proper destructor for the bio and it
> already knows what bio_set it belongs too.

This causes crashes on my computer.

> +void bio_free(struct bio *bio, struct bio_set *bio_set)
>  {
>  	const int pool_idx = BIO_POOL_IDX(bio);
> -	struct bio_set *bs = bio->bi_set;
>  
>  	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
>  
> -	mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
> -	mempool_free(bio, bs->bio_pool);
> +	mempool_free(bio->bi_io_vec, fs_bio_set->bvec_pools[pool_idx]);
> +	mempool_free(bio, fs_bio_set->bio_pool);
> +}

This function uses fs_bio_set instead of the function parameter
bio_set.

> @@ -171,8 +175,6 @@ struct bio *bio_alloc_bioset(unsigned in
>  			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
>  		}
>  		bio->bi_io_vec = bvl;
> -		bio->bi_destructor = bio_destructor;
> -		bio->bi_set = bs;
>  	}

This change means that all code that calls bio_alloc_bioset() must now
set bi_destructor, but this is forgotten in bio_clone() in bio.c and
in split_bvec() in dm.c.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
