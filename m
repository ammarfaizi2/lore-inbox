Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUABKqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUABKqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:46:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20157 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265504AbUABKql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:46:41 -0500
Date: Fri, 2 Jan 2004 11:46:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Move bv_offset/bv_len update after bio_endio in __end_that_request_first
Message-ID: <20040102104637.GN5523@suse.de>
References: <20040101173214.GA4496@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101173214.GA4496@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01 2004, Christophe Saout wrote:
> Hi!
> 
> Can we move the update of bio_index(bio)->bv_offset and bv_len after the
> bio_endio call in __end_that_request_first please (if a bvec is partially
> completed)?
> 
> The bi_idx is currently also updated after the bio_endio call.
> 
> Currently the bi_end_io function cannot exactly determine whether a bvec
> was completed or not.
> 
> Think of the following situation:
> 
> bv_offset is 0 and bv_len is 4096, now the driver completes 2048 bytes of
> that bvec.
> 
> At the moment bv_offset and bv_len are set to 2048 first. The bi_end_io
> function can't distinguish between this situation and the situation where
> bv_offset and bv_len were 2048 before and that bvec was completed (because
> bi_idx is incremented afterwards).
> 
> This shouldn't break any user since most users are waiting for the whole
> bio to complete with if (bio->bi_size > 0) return 1;.
> 
> I need this because I want to release buffers as soon as possible. The
> incoming bio can get split by my driver due to problems allocating buffers.
> If the partial bio returns and can't release its buffers immediately the
> whole thing might deadlock.
> 
> That's why I need to know exactly how many and which  bvecs were completed
> in my bi_end_io function.
> 
> Or do you think it is safer to count backwards using bi_vcnt and bi_size?

I'm inclined to thinking that, indeed. Those two fields have a more well
established usage, so I think you'll be better off doing that in the
long run.

-- 
Jens Axboe

