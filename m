Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHRG2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHRG2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHRG2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:28:16 -0400
Received: from brick.kernel.dk ([62.242.22.158]:53569 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750714AbWHRG2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:28:15 -0400
Date: Fri, 18 Aug 2006 08:30:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rq_flag_bits and bio bi_rw flags
Message-ID: <20060818063012.GB798@suse.de>
References: <20060817222752.GA19442@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817222752.GA19442@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17 2006, Matt Domsch wrote:
> Jens, I'm hoping you can clear something up for me.
> 
> ll_rw_blk.c:
> void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct
> bio *bio)
> {
>         /* first three bits are identical in rq->flags and bio->bi_rw
> 	*/
>         rq->flags |= (bio->bi_rw & 7);
> 
> That was recently changed to be the first 2 bits not 3.  But it made
> me look.
> 
> /*
>  * bio bi_rw flags
>  *
>  * bit 0 -- read (not set) or write (set)
>  * bit 1 -- rw-ahead when set
>  * bit 2 -- barrier
>  * bit 3 -- fail fast, don't want low level driver retries
>  * bit 4 -- synchronous I/O hint: the block layer will unplug immediately
>  */
> #define BIO_RW          0
> #define BIO_RW_AHEAD    1
> #define BIO_RW_BARRIER  2
> #define BIO_RW_FAILFAST 3
> #define BIO_RW_SYNC     4
> 
> 
> /*
>  * first three bits match BIO_RW* bits, important
>  */
> enum rq_flag_bits {
>         __REQ_RW,               /* not set, read. set, write */
>         __REQ_FAILFAST,         /* no low level driver retries */
>         __REQ_SORTED,           /* elevator knows about this request
> 	*/
> 
> 
> The first bit matches.  The second doesn't (BIO_RW_AHEAD vs
> __REQ_FAILFAST).  And obviously you just fixed the third bit.
> 
> Should BIO_RW_FAILFAST == __REQ_FAILFAST instead?

It does match, a rw-ahead request implies fail fast since we don't want
to be retrying read-head type IO. Could do with a better comment though,
but it's fully on purpose.

-- 
Jens Axboe

