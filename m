Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271934AbRHVFcJ>; Wed, 22 Aug 2001 01:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271931AbRHVFcA>; Wed, 22 Aug 2001 01:32:00 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:56303 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S271932AbRHVFbr>; Wed, 22 Aug 2001 01:31:47 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F24@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: The cause of the "VM" performance problem with 2.4.X
Date: Wed, 22 Aug 2001 00:31:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There has been quite a bit of discussion on VM-related problems on the list
(but I haven't been able to follow all of it); hopefully I can add some
clarity
to the problem.  Unfortunatly, I haven't fixed it yet (give me some
time...or
fix it and send me a patch ;-)

I've been running Linux on IA64 (4 CPU LION, 8GB RAM).  2.4.4+IA64 patches
through
2.4.8+IA64 patches all exhibit "horiffic" I/O behavior [disks are basically
inactive,
with occasional flickers, but the CPUs are pegged at 100% system time] when
writing
to multiple disks using multiple CPUs.  The easiest way for me to reproduce
the
problem is to run parallel "mkfs" processes (I use 4 SCSI disks).

First thing to do is to profile the kernel, to see why all 4 of my fast IA64
processors are pegged at 99%+ in the kernel (and see what they are doing).
So I get the kernel profile patches from SGI
(http://oss.sgi.com/projects/kernprof/)
and patch my kernel.  Profile 30 seconds during the "mkfs" process on 4
disks
(plus a "sync" part way through for kicks).  Below is the "interesting" part
of the output (truncated for brevity):

Flat profile:
  
 Each sample counts as 0.000976562 seconds.
   %   cumulative   self              self     total
  time   seconds   seconds    calls  ms/call  ms/call  name
  57.49     69.66    69.66        4 17414.79 25262.34
write_unlocked_buffers
  22.92     97.43    27.78    15115     1.84     2.39  write_some_buffers
   4.77    103.22     5.78        4  1445.31  2624.65  sync_old_buffers
   3.64    107.62     4.41   483617     0.01     0.01  _make_request
   3.30    111.62     4.00                             cg_record_arc
   2.92    115.17     3.54   483618     0.01     0.01  blk_get_queue
   1.62    117.13     1.96     2975     0.66     0.66  getblk
   1.55    119.00     1.88     2910     0.65     0.65  refile_buffer
 [. . .]
  
 index % time    self  children    called     name
                                                  <spontaneous>
 [1]     86.9    0.00  105.12                 ia64_ret_from_syscall [1]
                 0.00   75.79       3/3           sys_fsync [5]
                 0.00   25.26       1/1           sys_sync [7]
                 0.00    3.77    1195/1195        sys_write [15]
                 0.00    0.14    2306/2306        sys_read [38]
                 0.00    0.07    2088/2088        sys_open [43]
 [. . .]
 -----------------------------------------------
                 0.00   25.26       1/4           sys_sync [7]
                 0.00   75.79       3/4           sys_fsync [5]
 [2]     83.5    0.00  101.05       4         fsync_dev [2]
                 0.00  101.05       4/4           sync_buffers [3]
 -----------------------------------------------
                 0.00  101.05       4/4           fsync_dev [2]
 [3]     83.5    0.00  101.05       4         sync_buffers [3]
                69.66   31.39       4/4           write_unlocked_buffers [4]
 -----------------------------------------------
                69.66   31.39       4/4           sync_buffers [3]
 [4]     83.5   69.66   31.39       4         write_unlocked_buffers [4]
                24.18    7.21   13157/15115       write_some_buffers [6]
 -----------------------------------------------
                 0.00   75.79       3/3           ia64_ret_from_syscall [1]
 [5]     62.7    0.00   75.79       3         sys_fsync [5]
                 0.00   75.79       3/4           fsync_dev [2]
                 0.00    0.00       3/5429        fget [354]
                 0.00    0.00       3/38          filemap_fdatasync [479]
                 0.00    0.00       3/3           block_fsync [577]
 -----------------------------------------------
                 3.60    1.07    1958/15115       sync_old_buffers [9]
                24.18    7.21   13157/15115       write_unlocked_buffers [4]
 [6]     29.8   27.78    8.29   15115         write_some_buffers [6]
                 0.01    8.16   15115/15115       write_locked_buffers [10]
                 0.04    0.04  483680/567312      _refile_buffer [41]
                 0.04    0.00  483680/570200      _insert_into_lru_list [57]
 -----------------------------------------------
                 0.00   25.26       1/1           ia64_ret_from_syscall [1]
 [7]     20.9    0.00   25.26       1         sys_sync [7]
                 0.00   25.26       1/4           fsync_dev [2]
 -----------------------------------------------
                                                  <spontaneous>
 [8]      8.7    0.01   10.52                 kupdate [8]
                 5.78    4.72       4/4           sync_old_buffers [9]
                 0.00    0.02       3/3           wait_for_buffers [70]
                 0.00    0.00       3/115         schedule_timeout [123]
 -----------------------------------------------
                 5.78    4.72       4/4           kupdate [8]
 [9]      8.7    5.78    4.72       4         sync_old_buffers [9]
                 3.60    1.07    1958/15115       write_some_buffers [6]
                 0.00    0.05       4/4           sync_unlocked_inodes [53]
                 0.00    0.00       4/4           sync_supers [575]
 -----------------------------------------------
                 0.01    8.16   15115/15115       write_some_buffers [6]
 [10]     6.8    0.01    8.16   15115         write_locked_buffers [10]
                 0.14    8.02  483617/483618      submit_bh [11]
 -----------------------------------------------
                 0.00    0.00       1/483618      ll_rw_block [269]
                 0.14    8.02  483617/483618      write_locked_buffers [10]
 [11]     6.7    0.14    8.02  483618         submit_bh [11]
                 0.06    7.96  483618/483618      generic_make_request [12]
 -----------------------------------------------
                 0.06    7.96  483618/483618      submit_bh [11]
 [12]     6.6    0.06    7.96  483618         generic_make_request [12]
                 4.41    0.01  483617/483617      _make_request [13]
                 3.54    0.00  483618/483618      blk_get_queue [17]
 -----------------------------------------------
 

Okay, that was helpful.  But Yikes!  Why would write_unlocked_buffers take
so long?
It MUST be a locking problem: all it does it acquire a lock and
write_some_buffers().
That's fine, I'll profile the locks using SGI's handy-dandy lockmeter lock
profiling code (http://oss.sgi.com/projects/lockmeter/).  Hack it up to
apply
to my hacked 2.4.8 kernel, and away we go.  Run over 30 seconds of 4*mkfs.
Goes noticably faster than when I was profiling the whole kernel...

Dumping all locks that have > 1% "utilization" gives:
____________________________________________________________________________
_______________
System: Linux vanmaren.slc.unisys.com 2.4.8 #5 SMP Tue Aug 21 21:27:10 UTC
2001 ia64
Total counts

All (4) CPUs
Selecting locks that meet ALL of the following:
        utilization :   >  1.00%


Start time: Tue Aug 21 22:05:45 2001
End   time: Tue Aug 21 22:06:16 2001
Delta Time: 30.19 sec.
Hash table slots in use:      228.
Global read lock slots in use: 71.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT  NAME

       26.9%   24us(  49ms)  241us(  59ms)(71.4%)   1338023 73.1% 26.8%
0.09%  *TOTAL*

  2.4%  3.3%   19us(2035us)    0us                    37909 96.7%    0%
3.3%  global_bh_lock
  2.4%  3.3%   19us(2035us)    0us                    37909 96.7%    0%
3.3%    bh_action+0x40

  5.2% 32.1%  1.5us(  69us)  9.4us( 228us)( 2.7%)   1072409 67.9% 32.1%
0%  io_request_lock
 0.00% 59.9%  0.9us( 2.7us)   13us( 115us)(0.00%)       322 40.1% 59.9%
0%    __get_request_wait+0xb0
  4.0% 19.9%  2.3us(  69us)  4.9us( 196us)(0.42%)    525687 80.1% 19.9%
0%    __make_request+0x270
 0.03% 18.5%  2.3us(  10us)   12us( 105us)(0.01%)      3531 81.5% 18.5%
0%    ahc_linux_isr+0x3d0
 0.92% 44.9%  0.5us( 3.9us)   11us( 228us)( 2.2%)    525536 55.1% 44.9%
0%    blk_get_queue+0x50
 0.00% 16.5%  2.6us(  18us)  7.7us(  42us)(0.00%)       243 83.5% 16.5%
0%    generic_unplug_device+0x40
 0.20% 21.3%   14us(  43us)   13us( 111us)(0.01%)      4399 78.7% 21.3%
0%    scsi_dispatch_cmd+0x2b0
 0.01% 16.0%  0.5us( 3.5us)   14us( 166us)(0.01%)      4146 84.0% 16.0%
0%    scsi_finish_command+0x60
 0.03% 16.8%  1.8us(  44us)   13us( 104us)(0.01%)      4146 83.2% 16.8%
0%    scsi_queue_next_request+0x40
 0.04%  6.4%  2.9us(  26us)  4.6us(  72us)(0.00%)      4399 93.6%  6.4%
0%    scsi_request_fn+0x510

 97.0% 60.3% 1253us(  49ms) 5886us(  59ms)(68.7%)     23383 39.7% 60.3%
0%  lru_list_lock
 0.00%    0%  1.0us( 1.0us)    0us                        1  100%    0%
0%    buffer_insert_inode_queue+0x30
 0.15% 11.4%   13us(  22us) 4396us(  30ms)( 1.5%)      3503 88.6% 11.4%
0%    getblk+0x40
 0.33% 33.3%   33ms(  49ms)  131us( 131us)(0.00%)         3 66.7% 33.3%
0%    kupdate+0x190
 0.00% 14.6%  0.4us( 2.8us) 3865us(  30ms)( 1.6%)      3447 85.4% 14.6%
0%    refile_buffer+0x30
 0.05% 60.8%   15us(  26us) 1256us(8562us)(0.66%)      1037 39.2% 60.8%
0%    sync_old_buffers+0x100
 0.00%    0%  6.6us(  11us)    0us                        2  100%    0%
0%    try_to_free_buffers+0x90
 96.5% 81.6% 1893us(9616us) 6247us(  59ms)(65.0%)     15390 18.4% 81.6%
0%    write_unlocked_buffers+0x40

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL
NOWAIT SPIN  NAME

       0.01%                               1.2us( 1.2us)(0.00%)     14867
100% 0.01%  *TOTAL*

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL
NOWAIT SPIN(  WW )  NAME

          0%  0.8us(  39us)    0us                   0us             72355
100%    0%(   0%)  *TOTAL*
____________________________________________________________________________
_____________________________________________
Number of read locks found=0


Yep, lru_list_lock is the problem, and it is exacerbated by
write_unlocked_buffers holding it
for SO long.

The code in question (2.4.8 that I was testing with) is:

  
 static void write_unlocked_buffers(kdev_t dev)
 {
         do {
                 spin_lock(&lru_list_lock);
         } while (write_some_buffers(dev));
         run_task_queue(&tq_disk);
 }
  
 /*
  * Write some buffers from the head of the dirty queue.
  *
  * This must be called with the LRU lock held, and will
  * return without it!
  */
 #define NRSYNC (32)
 static int write_some_buffers(kdev_t dev)
 {
         struct buffer_head *next;
         struct buffer_head *array[NRSYNC];
         unsigned int count;
         int nr;
  
         next = lru_list[BUF_DIRTY];
         nr = nr_buffers_type[BUF_DIRTY] * 2;
         count = 0;
         while (next && --nr >= 0) {
                 struct buffer_head * bh = next;
                 next = bh->b_next_free;
  
                 if (dev && bh->b_dev != dev)
                         continue;
                 if (test_and_set_bit(BH_Lock, &bh->b_state))
                         continue;
                 if (atomic_set_buffer_clean(bh)) {
                         __refile_buffer(bh);
                         get_bh(bh);
                         array[count++] = bh;
                         if (count < NRSYNC)
                                 continue;
  
                         spin_unlock(&lru_list_lock);
                         write_locked_buffers(array, count);
                         return -EAGAIN;
                 }
                 unlock_buffer(bh);
                 __refile_buffer(bh);
         }
         spin_unlock(&lru_list_lock);
  
         if (count)
                 write_locked_buffers(array, count);
         return 0;
 }


It looks like more investigation is in order, but it appears that the
lru_list_lock
is held for too long, and that write_some_buffers() is a good candidate for
SMP
improvement.  Tomorrow, I'll track down where the time is going in
write_some_buffers().


Kevin Van Maren
