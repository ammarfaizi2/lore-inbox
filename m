Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272152AbRHWBs6>; Wed, 22 Aug 2001 21:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272179AbRHWBst>; Wed, 22 Aug 2001 21:48:49 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:9882 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S272152AbRHWBsg>; Wed, 22 Aug 2001 21:48:36 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F2F@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: The cause of the "VM" performance problem with 2.4.X
Date: Wed, 22 Aug 2001 20:48:31 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This (rather hastily tested) patch against 2.4.9 should give O(n)
> behaviour in write_unlocked_buffers().  Does it help?

Yes, it helps quite a bit.  Still not as good as I'd like: I don't
dare try lots of disks yet :-(

Here is the new lockmeter output (8 parallel mkfs processes on 4X
Lion to different disks, entire mkfs execution time).

Looks like blkdev_put() holds kernel_flag for way too long.

Looking under the lru_list_lock, you can see several functions that hold
the spinlock > 300ms.  getblk only holds it for a max of 7ms, but it gets
called so much it dominates the execution time.


____________________________________________________________________________
_______________
System: Linux vanmaren.slc.unisys.com 2.4.8 #13 SMP Wed Aug 22 18:34:15 UTC
2001 ia64
Total counts

All (4) CPUs
Selecting locks that meet ALL of the following:
        utilization :   >  1.00%


Start time: Wed Aug 22 19:10:17 2001
End   time: Wed Aug 22 19:11:30 2001
Delta Time: 72.67 sec.
Hash table slots in use:      254.
Global read lock slots in use: 101.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT  NAME

       29.4%  4.8us(2809ms)   40us(1780ms)(62.4%)  15255259 70.6% 29.4%
0.00%  *TOTAL*

  3.9% 0.06%   29us(5958us)    0us                    96244  100%    0%
0.06%  global_bh_lock
  3.9% 0.06%   29us(5958us)    0us                    96244  100%    0%
0.06%    bh_action+0x40

  6.6%  9.1%  1.3us( 111us)   14us( 234us)( 1.7%)   3773504 90.9%  9.1%
0%  io_request_lock
 0.00% 10.8%  0.5us( 2.6us)   13us(  68us)(0.00%)       655 89.2% 10.8%
0%    __get_request_wait+0xb0
  5.4%  3.4%  2.1us(  77us)  9.8us( 234us)(0.21%)   1846091 96.6%  3.4%
0%    __make_request+0x270
 0.05% 18.6%  2.6us( 111us)  6.2us( 123us)(0.01%)     13228 81.4% 18.6%
0%    ahc_linux_isr+0x3d0
 0.77% 14.4%  0.3us( 3.8us)   16us( 226us)( 1.4%)   1845765 85.6% 14.4%
0%    blk_get_queue+0x50
 0.00% 18.6%  3.7us(  19us)   12us( 117us)(0.00%)       575 81.4% 18.6%
0%    generic_unplug_device+0x40
 0.29% 22.3%   11us(  92us)   11us( 154us)(0.02%)     18488 77.7% 22.3%
0%    scsi_dispatch_cmd+0x2b0
 0.01% 18.5%  0.4us( 3.3us)  5.8us( 132us)(0.01%)     16157 81.5% 18.5%
0%    scsi_finish_command+0x60
 0.05% 17.5%  2.1us(  95us)  6.3us(  95us)(0.01%)     16157 82.5% 17.5%
0%    scsi_queue_next_request+0x40
 0.07% 11.8%  2.9us(  37us)  3.4us( 107us)(0.00%)     16388 88.2% 11.8%
0%    scsi_request_fn+0x510

  8.0% 0.45%   54us(2809ms)   25us(2394us)(0.00%)    107442 99.5% 0.45%
0%  kernel_flag
 0.00%    0%  0.4us( 0.5us)    0us                        3  100%    0%
0%    acct_process+0x140
 0.00% 56.2%  5.1us(  12us)  559us(2394us)(0.00%)        16 43.8% 56.2%
0%    blkdev_open+0xb0
  7.6% 20.0%  553ms(2809ms)   46us(  59us)(0.00%)        10 80.0% 20.0%
0%    blkdev_put+0xd0
 0.00%    0%  2.3us( 3.3us)    0us                        8  100%    0%
0%    chrdev_open+0xc0
 0.00%    0%   52us(  63us)    0us                        3  100%    0%
0%    do_exit+0x1f0
 0.00%    0%  0.5us( 0.9us)    0us                       63  100%    0%
0%    ext2_discard_prealloc+0x50
 0.00% 14.9%  1.9us(  41us)   14us(  28us)(0.00%)        74 85.1% 14.9%
0%    ext2_get_block+0xb0
 0.00%    0%  7.0us( 8.2us)    0us                        6  100%    0%
0%    fsync_dev+0x80
 0.00% 0.40%  1.3us( 9.9us)   20us(  57us)(0.00%)      1260 99.6% 0.40%
0%    posix_lock_file+0x2d0
 0.19% 0.15%  4.9us( 383us)  8.2us(  87us)(0.00%)     27984 99.9% 0.15%
0%    real_lookup+0x200
 0.00% 27.3%  6.4us(  17us)   15us(  20us)(0.00%)        11 72.7% 27.3%
0%    schedule+0x8c0
 0.00%    0%  219us(1031us)    0us                       10  100%    0%
0%    sync_old_buffers+0x50
 0.00% 22.2%  5.4us(  11us)   30us(  34us)(0.00%)         9 77.8% 22.2%
0%    sys_ioctl+0x90
 0.03% 0.54%  0.3us( 176us)   14us( 580us)(0.00%)     73179 99.5% 0.54%
0%    sys_lseek+0xf0
 0.11% 0.48%   20us( 586us)   34us( 172us)(0.00%)      4165 99.5% 0.48%
0%    tty_write+0x4a0
 0.02% 0.16%   24us(  64us)  2.4us( 2.4us)(0.00%)       640 99.8% 0.16%
0%    vfs_readdir+0x1c0
 0.00%    0%   31us(  31us)    0us                        1  100%    0%
0%    vfs_statfs+0xc0

 78.3% 87.2%   12us(1780ms)   43us(1780ms)(60.6%)   4681456 12.8% 87.2%
0%  lru_list_lock
  4.8% 30.0%  350ms(1780ms)   61us(  77us)(0.00%)        10 70.0% 30.0%
0%    __invalidate_buffers+0x40
 50.8% 78.5%   15us(7412us)   34us( 366ms)(21.6%)   2382129 21.5% 78.5%
0%    getblk+0x40
 0.79% 66.7%   64ms( 366ms)   36us(  97us)(0.00%)         9 33.3% 66.7%
0%    kupdate+0x190
  6.8% 97.0%  2.2us(1204us)   34us( 366ms)(25.2%)   2241541  3.0% 97.0%
0%    refile_buffer+0x30
 0.80% 90.9%   15us(3212us)  401us(1780ms)( 4.9%)     38766  9.1% 90.9%
0%    sync_old_buffers+0x100
  3.4% 12.5%   77ms( 327ms)   22us(  54us)(0.00%)        32 87.5% 12.5%
0%    wait_for_locked_buffers+0x40
 11.0% 18.6%  420us( 344ms) 7344us(1780ms)( 8.9%)     18969 81.4% 18.6%
0%    write_unlocked_buffers+0x40

  1.3% 0.45%  0.4us(3859us)  2.0us( 180us)(0.01%)   2381262 99.6% 0.45%
0%  getblk+0x2b0

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL
NOWAIT SPIN  NAME

       0.00%                               1.2us( 1.5us)(0.00%)    229513
100% 0.00%  *TOTAL*

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL
NOWAIT SPIN(  WW )  NAME

 36.6%    0%  9.0us(3880us)    0us                   0us           2942425
100%    0%(   0%)  hash_table_lock
  1.1%    0%  1.4us( 6.5us)    0us                   0us            560296
100%    0%(   0%)    __invalidate_buffers+0x250
 35.5%    0%   11us(3880us)    0us                   0us           2382129
100%    0%(   0%)    getblk+0x60
____________________________________________________________________________
_____________________________________________
Number of read locks found=0
