Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSFQGhF>; Mon, 17 Jun 2002 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFQGhE>; Mon, 17 Jun 2002 02:37:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59874 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316766AbSFQGhD>;
	Mon, 17 Jun 2002 02:37:03 -0400
Date: Mon, 17 Jun 2002 08:36:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020617063645.GP1359@suse.de>
References: <200206151030.DAA01140@adam.yggdrasil.com> <3D0B9A74.5872B63B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D0B9A74.5872B63B@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, Andrew Morton wrote:
> "Adam J. Richter" wrote:
> > 
> > ...
> >         newbio = q->one_more_bvec(q, bio, page, offset, len);
> > 
> 
> That's a comfortable interface.  Or maybe just:
> 
> 	struct bio *bio_add_bvec(bio, page, offset, len);

I agree, that's the interface that I want.

> Couple of points:
> 
> - It's tricky to determine how many bvecs are available in
>   a bio.  There is no straightforward "how big is it" field
>   in struct bio.

That's true. It's trivial for bios coming out of bio pools, for
privately allocated ones it gets a bit worse. Should not be hard to
clean up, though.

> - AFAIK, there are no established conventions for BIO assembly.
>   We have conventions which state what the various fields do
>   while the BIO is being processed by the block layer, but not
>   for when the client is assembling the BIO.
> 
> What I did, and what I'd suggest as a convention is:
> 
> During BIO assembly, bi_vcnt indicates the maximum number of
> bvecs which the BIO can hold. And bi_idx indexes the next-free
> bvec within the BIO.

Hmm I don't like that too much. For reference, bi_vcnt from the block
layer is the number of bio_vecs in the bio. And bi_idx is the index into
the 'current' bio_vec. To tie that in with the above, how about just
changing bi_max to be a real number. Internal bio can still find the
pool from that, and private bios can just fill it out.

-- 
Jens Axboe

