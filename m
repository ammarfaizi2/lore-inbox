Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRGJLvV>; Tue, 10 Jul 2001 07:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbRGJLvL>; Tue, 10 Jul 2001 07:51:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57318 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262355AbRGJLvF>; Tue, 10 Jul 2001 07:51:05 -0400
Date: Tue, 10 Jul 2001 17:25:45 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010710172545.A8185@in.ibm.com>
Reply-To: dipankar@sequent.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

In article <20010709214453.U16505@suse.de> you wrote:
> On Mon, Jul 09 2001, Jonathan Lahr wrote:
> It's also interesting to take a look at _why_ there's contention on the
> io_request_lock. And fix those up first.

> -- 
> Jens Axboe

Here are some lockmeter outputs for tiobench
(http://sourceforge.net/projects/tiobench), a simple benchmark
that we tried on ext2 filesystem. 4 concurrent threads doing
random/sequential read/write on 10MB files on a 4-way pIII 700MHz
machine with 1MB L2 cache -

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

  2.9% 26.7%  7.4us( 706us)   72us( 920us)( 1.9%)   1557496 73.3% 26.7%    0%  io_request_lock
 0.00% 34.9%  0.5us( 2.8us)   63us( 839us)(0.04%)     29478 65.1% 34.9%    0%    __get_request_wait+0x98
  2.6%  4.7%   17us( 706us)   69us( 740us)(0.13%)    617741 95.3%  4.7%    0%    __make_request+0x110
 0.07% 60.2%  0.5us( 4.0us)   72us( 920us)( 1.7%)    610820 39.8% 60.2%    0%    blk_get_queue+0x10
 0.09%  2.9%  6.6us(  55us)  102us( 746us)(0.01%)     55327 97.1%  2.9%    0%    do_aic7xxx_isr+0x24
 0.00%  3.7%  0.3us(  22us)   29us( 569us)(0.00%)     22602 96.3%  3.7%    0%    generic_unplug_device+0x10
 0.02%  4.9%  1.3us(  27us)   54us( 621us)(0.01%)     55382 95.1%  4.9%    0%    scsi_dispatch_cmd+0x12c
 0.02%  1.3%  1.2us( 8.0us)   23us( 554us)(0.00%)     55382 98.7%  1.3%    0%    scsi_old_done+0x5b8
 0.04%  3.2%  2.8us(  31us)  200us( 734us)(0.02%)     55382 96.8%  3.2%    0%    scsi_queue_next_request+0x18
 0.02%  1.4%  1.1us( 7.8us)   46us( 638us)(0.00%)     55382 98.6%  1.4%    0%    scsi_request_fn+0x350

1557496*26.7%*72us makes it about 30 seconds of time waiting for 
io_request_lock. That is nearly one-third of the total system time 
(about 98 seconds). As number of CPUs increase, this will likely
worsen.

It also seems that __make_request() holds the lock for the largest
amount of time. This hold time isn't likely to change significantly
for a per-queue lock, but atleast it will not affect queueing i/o
requests to other devices. Besides, I am not sure if blk_get_queue()
really needs to grab the io_request_lock. blk_dev[] entries aren't
likely to be updated in an open device and hence it should be
safe to look up the queue of an open device. For mutual
exclusion in the device-specific queue() function, it might be
better to leave it to the driver instead of forcing the mutual
exclusion. For example, a driver might want to use a reader/writer
lock to lookup its device table for the queue. It also might make sense to
have separate mutual exclusion mechanism for block device
and scsi device level queues.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
