Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSGDH41>; Thu, 4 Jul 2002 03:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSGDH40>; Thu, 4 Jul 2002 03:56:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59026 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317363AbSGDH4Z>;
	Thu, 4 Jul 2002 03:56:25 -0400
Date: Thu, 4 Jul 2002 09:58:30 +0200
From: Jens Axboe <axboe@kernel.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020704075830.GQ21568@suse.de>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15651.54044.557070.109158@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04 2002, Neil Brown wrote:
> On Wednesday July 3, axboe@suse.de wrote:
> > 
> > Now we are in a grey area. The 'usual' stacked drivers work like this:
> > 
> > some fs path
> > 	submit_bh(bh_orig);
> > 
> > ...
> > 
> > stacked driver make_request_fn:
> > 	bh_new = alloc_bh
> > 	bh_new->b_private = bh_orig;
> > 	...
> > 	submit_bh(bh_new);
> > 
> > if you are just modifying b_private, how exactly is your stacking
> > working? ie what about lvm2 on lvm2?
> 
> I think this can work sanely and is something I have considered for
> raid1-read and multipath in md.
> 
> struct privatebit {
>   bio_end_io_t  *oldend;
>   void          *oldprivate;
>   ...other...stuff;
> };
> 
> make_request(struct request_queue_t *q, struct buffer_head *bh, int rw)
> {
> 
>  struct privatebit *pb = kmalloc(...);
> 
>   pb->oldend = bh->b_end_io;
>   pb->oldprivate = bh->b_private;
>   bh->b_private = pb;
>   bh->b_end_io = my_end_handler;
> 
>   ..remap b_rdev, b_rsector ...
> 
>   generic_make_request(bh, rw);
> 
> }

Yes this works fine, as long as you assert that stacking is an entity of
the b_end_io functions, ie you dont rely on the state of the buffer_head
before i/o completion. But it breaks for ext3.

I'm inclined to say that I think 2.4 mappers should go the full length
like I did in loop, which is always safe (although it does eat more
memory, of course, buffer_heads aren't exactly lite :)

int make_request(struct request_queue_t *q, struct buffer_head *bh, int rw)
{
	struct buffer_head *stack_bh = some_pool_alloc(...);

	stack_bh->b_private = bh;
	stack_bh->b_end_io = my_end_handler;

	/* setup b_rdev and b_rsector, etc */
	generic_make_request(stack_bh, rw);
	return 0;
}

> We just want ext3/jbd to make sure that it only calls bh2jh on
> an unlocked buffer... is that easy?

That's the question indeed, someone with a good grasp of jbd should make
that call. If that is the only 'violator' (depending on your point of
view), then yes lets just fix that up and say that the above is pb
private is valid.

> Ofcourse this ceases to be an issue in 2.5 because the filesys uses 
> pages or buffer_heads and the device driver uses bios.

Yep, no such problem in 2.5

-- 
Jens Axboe

