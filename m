Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271503AbRHPGgA>; Thu, 16 Aug 2001 02:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRHPGfv>; Thu, 16 Aug 2001 02:35:51 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:5904 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S271503AbRHPGfj>; Thu, 16 Aug 2001 02:35:39 -0400
Date: Thu, 16 Aug 2001 08:35:24 +0200
From: Jens Axboe <axboe@suse.de>
To: tpepper@vato.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: create_bounce() in ll_rw_blk.c
Message-ID: <20010816083524.L4352@suse.de>
In-Reply-To: <20010815224604.A3396@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815224604.A3396@cb.vato.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, tpepper@vato.org wrote:
> In ll_rw_blk.c's __make_request() there is a call to create_bounce() if
> CONFIG_HIGHMEM is set.  The commentary in that file indicates that this is a
> temporary fix until 2.5 at which point this would be removed in favour of
> individual drivers handling this on their own.  I've been trying to figure out
> if a driver I'm working on needs to make this call.  That got me wondering...

You _only_ need to make that call if your driver is bypassing the
ll_rw_blk supplied make_request_fn. So if you are not using
blk_init_queue to specify a request_fn but rather blk_queue_make_request
and thus bypassing the I/O scheduler, then you need to make sure that
you bounce buffers when you need it.

> Is there a reason for pushing this down onto the individual driver writer
> instead of placing it once and for all in the ll_rw_block() function like:
> 
> --- linux-2.4.8/drivers/block/ll_rw_blk.c.orig	Wed Aug 15 22:15:55 2001
> +++ linux-2.4.8/drivers/block/ll_rw_blk.c	Wed Aug 15 22:39:55 2001
> @@ -1000,6 +1000,10 @@
>  	/* Verify requested block sizes. */
>  	for (i = 0; i < nr; i++) {
>  		struct buffer_head *bh = bhs[i];
> +#if CONFIG_HIGHMEM
> +		bh = create_bounce(rw, bh);
> +		bhs[i] = &bh;
> +#endif
>  		if (bh->b_size % correct_size) {
>  			printk(KERN_NOTICE "ll_rw_block: device %s: "
>  			       "only %d-char blocks implemented (%u)\n",

You've just incurred a nasty performance hit for a good device driver
that can handle highmem without bouncing. Urk.

> Since the commentary says the driver writer taking HIGHMEM into
> account could call either create_bounce() or bh_kmap() and the latter
> deals with bh->b_data, is this something you need to do only if you're
> accessing bh->b_data?  In that case putting the work on the driver writer

Yes. b_data is the virtual mapping of b_page (+ offset).

> allows for it to only be done when needed, but are there cases were a
> buffer_head would pass down out of ll_rw_block() towards a driver that's
> not ultimately going to read or write the b_data member?

Sure, I can imagine such cases. I could do something like this in my
request function:

	unsigned long bus_addr = page_to_bus(bh->b_page) + bh_offset(bh);

which is perfectly good code, and handles highmem which the typical
construct

	char *ptr = bh_kmap(bh);
	unsigned long bus_addr = virt_to_bus(ptr);

does not.

> I don't know how all the HIGHMEM/PAE stuff actually works, but I'm
> guessing that if the heavy handed create_bounce() exists that is because
> simply doing a bh_kmap() and replacing the bh->b_data at ll_rw_block()
> time doesn't result in a memory address that would work in the drivers'
> context?  So to get the efficiency of bh_kmap() over create_bounce()
> you'd have to put the calls in all the drivers?

The kmap mappings are meant to be short lived. Doing the kmap would work
across I/O though, but typically you are unmapping from irq context and
then you need to resort to the slower kmap_atomic mappings.

> And since create_bounce() stores the original bh in bh->b_private is this
> all magically undone then as nested bh->b_end_io's and bh->b_private's
> unfold themselves with either of bounce_end_io_read() or _write() being
> called somewhere in there?

Yep, it's unfolded nicely from b_end_io. bh_bounce->b_end_io will be
bounce_end_io_read() for example as you note, which will grab the
original bh from bh_bounce->b_private and call the original b_end_io
specificed for that buffer.

-- 
Jens Axboe

