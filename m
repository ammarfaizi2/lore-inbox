Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTKCMZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 07:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTKCMZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 07:25:49 -0500
Received: from ns.suse.de ([195.135.220.2]:18086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261336AbTKCMZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 07:25:47 -0500
Date: Mon, 3 Nov 2003 13:25:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031103122500.GA6963@suse.de>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101100543.GA16682@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01 2003, Herbert Xu wrote:
> On Sat, Nov 01, 2003 at 03:46:19PM +1100, herbert wrote:
> > 
> > Currently bio_add_page will allow segments to be counted as merged
> > before they've been bounced.  This can create bio's that exceed
> > limits set by the driver/hardware.  This bug can be triggered on
> > HIGHMEM machines as well as ISA block devices such as AHA1542.
> > 
> > Here is a hack that works around it by bouncing the queue before
> > recounting the segments.
> 
> That patch chained bio's together which is prone to deadlock.  I've
> modified __blk_queue_bounce to only allocate a new bio if it hasn't
> been bounced already.  Unfortunately it has to allocate one with the
> maximum number of bvecs so it's even more of a hack.
> 
> Hopefully someone else can come up with a better fix.

I think the best fix would be to simply not allow more than one page
that needs to be bounced to a bio. The problem is that the whole bio and
bio_vec allocations needs to be duplicated for highmem bouncing, and
that really doesn't thrill me. So a single mempool for bio, and single
entry bio_vec would be a lot leaner. I'll see if I can squeeze out a
prototype today.

I totally agree with your analysis of the problem, though.

-- 
Jens Axboe

