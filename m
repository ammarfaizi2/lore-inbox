Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWDZFUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWDZFUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDZFUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:20:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14166 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932373AbWDZFUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:20:12 -0400
Date: Wed, 26 Apr 2006 07:20:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Hua Zhong <hzhong@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Message-ID: <20060426052049.GV4102@suse.de>
References: <20060425183026.GR4102@suse.de> <004d01c668b0$a9c79540$853d010a@nuitysystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004d01c668b0$a9c79540$853d010a@nuitysystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2006, Hua Zhong wrote:
> It seems that new BIOs do not have BIO_SEG_VALID set. So when you do
> sequential IO, the IO being back-merged should always have not had
> valid segments.
> 
> I ran bonnie++ and it shows the same thing.

But blk_recount_segments() sets the BIO_SEG_VALID flag. Ugh ok
__bio_add_page() basically kills the flag. James, I think you are the
author of that addition, does it really need to be so restrictive?

        /* If we may be able to merge these biovecs, force a recount */
        if (bio->bi_vcnt && (BIOVEC_PHYS_MERGEABLE(bvec-1, bvec) ||
            BIOVEC_VIRT_MERGEABLE(bvec-1, bvec)))
                bio->bi_flags &= ~(1 << BIO_SEG_VALID);

with that in place, we may as well just remove ->bi_phys_segments
and ->bi_hw_segments since we'll be calculating the values over and over
again while building up a bio.

-- 
Jens Axboe

