Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUIOLiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUIOLiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUIOLiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:38:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:56462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265207AbUIOLin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:38:43 -0400
Date: Wed, 15 Sep 2004 04:36:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: Untangle code in bio.c
Message-Id: <20040915043644.4fb58787.akpm@osdl.org>
In-Reply-To: <20040915111802.GA20222@elf.ucw.cz>
References: <20040915111802.GA20222@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> bio.c uses quite ugly code with goto's, completely
> unneccessarily. Please apply,

I wouldn't describe this as an improvement, really.  Multiple return
statements give me hysterics.

> 
> --- clean-mm/fs/bio.c	2004-09-15 12:58:10.000000000 +0200
> +++ linux-mm/fs/bio.c	2004-09-15 13:00:51.000000000 +0200
> @@ -143,7 +143,7 @@
>  
>  	bio = mempool_alloc(bio_pool, gfp_mask);
>  	if (unlikely(!bio))
> -		goto out;
> +		return NULL;
>  
>  	bio_init(bio);
>  
> @@ -157,13 +157,11 @@
>  noiovec:
>  		bio->bi_io_vec = bvl;
>  		bio->bi_destructor = bio_destructor;
> -out:
>  		return bio;
>  	}
>  
>  	mempool_free(bio, bio_pool);
> -	bio = NULL;
> -	goto out;
> +	return NULL;
>  }

How's this look?

struct bio *bio_alloc(int gfp_mask, int nr_iovecs)
{
	struct bio *bio = mempool_alloc(bio_pool, gfp_mask);

	if (likely(bio)) {
		struct bio_vec *bvl = NULL;

		bio_init(bio);
		if (likely(nr_iovecs)) {
			unsigned long idx;

			bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx);
			if (unlikely(!bvl)) {
				mempool_free(bio, bio_pool);
				bio = NULL;
				goto out;
			}
			bio->bi_flags |= idx << BIO_POOL_OFFSET;
		}
		bio->bi_io_vec = bvl;
		bio->bi_destructor = bio_destructor;
	}
out:
	return bio;
}

