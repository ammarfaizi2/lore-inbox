Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbUCTKSG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbUCTKSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:18:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37093 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263313AbUCTKSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:18:01 -0500
Date: Sat, 20 Mar 2004 11:17:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Russell Cattelan <cattelan@xfs.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Small bug in bio_clone?
Message-ID: <20040320101750.GE2711@suse.de>
References: <1079734269.3373.42.camel@naboo.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079734269.3373.42.camel@naboo.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Russell Cattelan wrote:
> Shouldn't __bio_clone be checking the state flags
> of the src bio?
> 
> --- /usr/tmp/TmpDir.29150-0/fs/bio.c_1.3        2004-03-19
> 16:07:12.000000000 -0600
> +++ fs/bio.c    2004-03-19 16:06:24.348491070 -0600
> @@ -225,7 +225,7 @@
>          */
>         bio->bi_vcnt = bio_src->bi_vcnt;
>         bio->bi_idx = bio_src->bi_idx;
> -       if (bio_flagged(bio, BIO_SEG_VALID)) {
> +       if (bio_flagged(bio_src, BIO_SEG_VALID)) {
>                 bio->bi_phys_segments = bio_src->bi_phys_segments;
>                 bio->bi_hw_segments = bio_src->bi_hw_segments;
>                 bio->bi_flags |= (1 << BIO_SEG_VALID);

Yes, in theory. What is done now is for sure a mistake, however I'm
thinking it's probably safer to just delete the check and setting of
segments, and do it on-demand the next time (if ever) someone calls
bio_*_segments(bio). Hmm, should be done every time someone assigns
->bi_bdev(), maybe it would be a good idea to add something like that.

static inline void bio_set_bdev(struct bio *bio, struct block_device *bdev)
{
	bio->bi_bdev = bdev;
	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
}

-- 
Jens Axboe

