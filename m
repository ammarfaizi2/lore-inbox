Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbRGKHTl>; Wed, 11 Jul 2001 03:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbRGKHTb>; Wed, 11 Jul 2001 03:19:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50436 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267216AbRGKHTP>;
	Wed, 11 Jul 2001 03:19:15 -0400
Date: Wed, 11 Jul 2001 09:19:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Dipankar Sarma <dipankar@sequent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711091900.C17314@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710172545.A8185@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10 2001, Dipankar Sarma wrote:
> In article <20010709214453.U16505@suse.de> you wrote:
> > On Mon, Jul 09 2001, Jonathan Lahr wrote:
> > It's also interesting to take a look at _why_ there's contention on the
> > io_request_lock. And fix those up first.
> 
> > -- 
> > Jens Axboe
> 
> Here are some lockmeter outputs for tiobench
> (http://sourceforge.net/projects/tiobench), a simple benchmark
> that we tried on ext2 filesystem. 4 concurrent threads doing
> random/sequential read/write on 10MB files on a 4-way pIII 700MHz
> machine with 1MB L2 cache -
> 
> SPINLOCKS         HOLD            WAIT
>   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
> 
>   2.9% 26.7%  7.4us( 706us)   72us( 920us)( 1.9%)   1557496 73.3% 26.7%    0%  io_request_lock
>  0.00% 34.9%  0.5us( 2.8us)   63us( 839us)(0.04%)     29478 65.1% 34.9%    0%    __get_request_wait+0x98
>   2.6%  4.7%   17us( 706us)   69us( 740us)(0.13%)    617741 95.3%  4.7%    0%    __make_request+0x110
>  0.07% 60.2%  0.5us( 4.0us)   72us( 920us)( 1.7%)    610820 39.8% 60.2%    0%    blk_get_queue+0x10
>  0.09%  2.9%  6.6us(  55us)  102us( 746us)(0.01%)     55327 97.1%  2.9%    0%    do_aic7xxx_isr+0x24
>  0.00%  3.7%  0.3us(  22us)   29us( 569us)(0.00%)     22602 96.3%  3.7%    0%    generic_unplug_device+0x10
>  0.02%  4.9%  1.3us(  27us)   54us( 621us)(0.01%)     55382 95.1%  4.9%    0%    scsi_dispatch_cmd+0x12c
>  0.02%  1.3%  1.2us( 8.0us)   23us( 554us)(0.00%)     55382 98.7%  1.3%    0%    scsi_old_done+0x5b8
>  0.04%  3.2%  2.8us(  31us)  200us( 734us)(0.02%)     55382 96.8%  3.2%    0%    scsi_queue_next_request+0x18
>  0.02%  1.4%  1.1us( 7.8us)   46us( 638us)(0.00%)     55382 98.6%  1.4%    0%    scsi_request_fn+0x350
> 
> 1557496*26.7%*72us makes it about 30 seconds of time waiting for 
> io_request_lock. That is nearly one-third of the total system time 
> (about 98 seconds). As number of CPUs increase, this will likely
> worsen.

Auch! That's pretty bad.

> It also seems that __make_request() holds the lock for the largest
> amount of time. This hold time isn't likely to change significantly

__make_request -> elevator merge/insertion scan. This is what is taking
all the time, not __make_request itself. With the bio-XX patches I have
completely eliminated merge scans, so that can be done in O(1) time. For
now insertion is still a O(N) scan, maybe that will change too [1].

> for a per-queue lock, but atleast it will not affect queueing i/o
> requests to other devices. Besides, I am not sure if blk_get_queue()
> really needs to grab the io_request_lock. blk_dev[] entries aren't

Funny, this is one thing I've been looking at too. blk_get_queue _will_
die, don't worry. And yes, ie at open we can assign the queue. Or simply
map it and protect it otherwise. It all ties in with being able to up or
down a queue too, currently grabbing io_request_lock from blk_get_queue
accomplishes exactly nothing and may as well be removed. If you do that,
does it change the contention numbers significantly?

[1] Appropriate data structures that both allow barriers and quick
insertion sorts are needed.

-- 
Jens Axboe

