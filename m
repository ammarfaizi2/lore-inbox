Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWHAHXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWHAHXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHAHXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:23:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54898 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932575AbWHAHXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:23:07 -0400
Date: Tue, 1 Aug 2006 09:23:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801072315.GH31908@suse.de>
References: <20060801030443.GA2221@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801030443.GA2221@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2006, Herbert Xu wrote:
> Hi Andrew:
> 
> [BLOCK] bh: Ensure bh fits within a page
> 
> There is a bug in jbd with slab debugging enabled where it was submitting
> a bh obtained via jbd_rep_kmalloc which crossed a page boundary.  A lot
> of time was spent on tracking this down because the symptoms were far off
> from where the problem was.
> 
> This patch adds a sanity check to submit_bh so we can immediately spot
> anyone doing similar things in future.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> While you're at it, could you fix that jbd bug for us :)
> 
> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> --
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 71649ef..b998f08 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
>  	BUG_ON(!bh->b_end_io);
> +	WARN_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);

That looks really dangerous, I'd prefer that to be a BUG_ON() as well to
prevent nastiness further down.

-- 
Jens Axboe

