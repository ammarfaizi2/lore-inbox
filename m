Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRH1Rk2>; Tue, 28 Aug 2001 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271866AbRH1RkX>; Tue, 28 Aug 2001 13:40:23 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:32656 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S271865AbRH1RkD>; Tue, 28 Aug 2001 13:40:03 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F5F@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: The cause of the "VM" performance problem with 2.4.X
Date: Tue, 28 Aug 2001 12:35:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here are some more results with Morton's "2nd" patch,
running 2.4.8,IA64-010815 on 4X IA64 (Lion) with 8GB RAM,
733MHz B3 (4MB) CPUs.  3 Adaptec 39160 channels, each with
8 (18GB) Cheetah drives, create 4 md's using 2 disks from
each channel.  Also using Gibbs' 6.2.0 adaptec driver.
I tried to extract the "important" info to keep this message
relatively small.  Meant to get this out earlier...

It looks like "getblk" could use some additional optimization.
More info to follow, but even doing one "mkfs" at a time,
the lru_list_lock is held over 82% of the time, mostly by
getblk().


SMP test case: 4 parallel mkfs (each on 6-disk md):
===================================================
  "start"
  mkfs /dev/md0 &
  mkfs /dev/md1 &
  mkfs /dev/md2 &
  mkfs /dev/md3
  "stop"

Abbreiated/stripped kernprof/gprof output:
------------------------------------------

Each sample counts as 0.000976562 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 39.46    224.65   224.65                             cg_record_arc
 16.40    318.00    93.34  6722992     0.01     0.02  getblk
  9.02    369.33    51.33 50673121     0.00     0.00  spin_lock_
  6.67    407.27    37.95  6722669     0.01     0.01  _make_request
  4.51    432.97    25.70 13445261     0.00     0.00  blk_get_queue
  2.61    447.83    14.86                             long_copy_user
  2.59    462.56    14.72                             mcount
  2.06    474.27    11.71                             cpu_idle
  1.35    481.97     7.70 26887936     0.00     0.00  _insert_into_lru_list
  1.23    489.00     7.02 12463048     0.00     0.00  write_lock_
  1.08    495.15     6.15 12463047     0.00     0.00  write_unlock_
  0.94    500.52     5.37        7   767.72  2342.72  _invalidate_buffers
  0.89    505.56     5.04    72518     0.07     0.08  scsi_dispatch_cmd
  0.83    510.26     4.70   216716     0.02     0.65  block_write
  0.77    514.63     4.37 20169809     0.00     0.00  _refile_buffer
  0.74    518.82     4.19    68098     0.06     0.08  scsi_init_io_vc
  0.73    522.96     4.15    58177     0.07     0.34  _scsi_end_request
  0.64    526.60     3.64 25304057     0.00     0.00  _remove_from_lru_list
  0.59    529.97     3.36      718     4.68     4.68  si_swapinfo
  0.56    533.17     3.21  5644224     0.00     0.00  end_buffer_io_sync
  0.40    535.46     2.29    43581     0.05     0.06  ahc_linux_isr
  0.36    537.50     2.04   210123     0.01     0.45  write_some_buffers
  0.35    539.52     2.02  6729267     0.00     0.00  _remove_from_free_list
  0.34    541.46     1.94 13445412     0.00     0.00  balance_dirty_state
[misc "interesting" others]
  0.09    557.35     0.49      116     4.22    41.74  wait_for_buffers
  0.06    560.37     0.33    58177     0.01     0.35  scsi_finish_command
  0.02    565.67     0.14       54     2.57  1655.62  sync_old_buffers
  0.01    567.60     0.04       42     1.00    18.82  page_launder
  0.00    569.24     0.00       43     0.05   146.48  write_unlocked_buffers
  0.00    569.29     0.00       42     0.00    19.44  do_try_to_free_pages
  0.00    569.29     0.00       29     0.00   306.44  sync_buffers
  0.00    569.29     0.00       28     0.00    92.44
wait_for_locked_buffers
  0.00    569.29     0.00       15     0.00   306.48  fsync_dev
  0.00    569.29     0.00        8     0.00   574.65  sys_fsync
  0.00    569.29     0.00        7     0.00  2955.64  blkdev_put

index % time    self  children    called     name
[1]     40.5  224.65    0.00                 cg_record_arc [1]

[2]     32.3    0.02  179.06                 ia64_ret_from_syscall [2]
                0.10  150.24  232733/232733      sys_write [3]

                0.10  150.24  232733/232733      ia64_ret_from_syscall [2]
[3]     27.1    0.10  150.24  232733         sys_write [3]
                4.70  136.37  216716/216716      block_write [4]

                4.70  136.37  216716/216716      sys_write [3]
[4]     25.4    4.70  136.37  216716         block_write [4]
               93.34   26.66 6722748/6722992     getblk [5]
                1.16   11.57 6722748/6723007     mark_buffer_dirty [30]
                0.32    2.90 13445336/13445412     balance_dirty [54]
                0.40    0.00 6722748/6736794     _brelse [112]

                0.00    0.00      32/6722992     block_read [391]
                0.00    0.00     212/6722992     bread [298]
               93.34   26.66 6722748/6722992     block_write [4]
[5]     21.6   93.34   26.66 6722992         getblk [5]
               13.67    0.00 13492508/50673121     spin_lock_ [12]
                3.80    0.00 6747334/12463048     write_lock_ [40]
                3.33    0.00 6747334/12463047     write_unlock_ [42]
                2.02    0.00 6720832/6729267     _remove_from_free_list [69]
                1.93    0.00 6720832/26887936     _insert_into_lru_list [37]
                0.00    0.76   24342/24342       refill_freelist [90]
                0.74    0.00 6720832/6720832     _insert_into_queues [92]
                0.26    0.00 13492508/51086468     spin_unlock_ [78]
                0.16    0.00 6720832/6720832     init_buffer [144]

                0.13    6.15   13845/210123      write_unlocked_buffers [41]
                1.91   87.15  196278/210123      sync_old_buffers [8]
[6]     17.2    2.04   93.30  210123         write_some_buffers [6]
                0.13   88.77  210087/210087      write_locked_buffers [9]
                1.46    0.97 6722667/20169809     _refile_buffer [39]
                1.93    0.00 6722665/26887936     _insert_into_lru_list [37]

[7]     16.5    0.00   91.66                 kupdate [7]
                0.14   89.26      54/54          sync_old_buffers [8]
                0.23    2.03      54/116         wait_for_buffers [46]

                0.14   89.26      54/54          kupdate [7]
[8]     16.1    0.14   89.26      54         sync_old_buffers [8]
                1.91   87.15  196278/210123      write_some_buffers [6]
                0.20    0.00  196385/50673121     spin_lock_ [12]

                0.13   88.77  210087/210087      write_some_buffers [6]
[9]     16.0    0.13   88.77  210087         write_locked_buffers [9]
                1.10   87.67 6722665/6722669     submit_bh [10]

                0.00    0.00       4/6722669     ll_rw_block [478]
                1.10   87.67 6722665/6722669     write_locked_buffers [9]
[10]    16.0    1.10   87.67 6722669         submit_bh [10]
                0.97   86.70 6722669/6722669     generic_make_request [11]

                0.97   86.70 6722669/6722669     submit_bh [10]
[11]    15.8    0.97   86.70 6722669         generic_make_request [11]
               37.95    6.98 6722669/6722669     _make_request [13]
               25.70   13.88 13445261/13445261     blk_get_queue [14]
                0.62    1.58 6722592/6722592     md_make_request [67]

                0.11    0.00  108665/50673121     _wake_up [113]
                0.16    0.00  156642/50673121     real_lookup [71]
                0.16    0.00  156651/50673121     d_rehash [143]
                0.16    0.00  156653/50673121     d_alloc [138]
                0.16    0.00  156656/50673121     d_instantiate [142]
                0.16    0.00  156661/50673121     get_empty_inode [136]
                0.20    0.00  196385/50673121     sync_old_buffers [8]
                0.22    0.00  218577/50673121     sys_lseek [38]
                0.37    0.00  360440/50673121     timer_bh [87]
                0.39    0.00  389480/50673121     get_unused_buffer_head
[103]
                0.41    0.00  405522/50673121     d_lookup [105]
                0.81    0.00  800334/50673121     atomic_dec_and_lock [83]
                4.81    0.00 4749700/50673121     put_last_free [45]
                6.81    0.00 6722665/50673121     refile_buffer [34]
                6.81    0.00 6722816/50673121     _make_request [13]
               13.62    0.00 13445261/50673121     blk_get_queue [14]
               13.67    0.00 13492508/50673121     getblk [5]
[12]     9.3   51.33    0.00 50673121         spin_lock_ [12]

               37.95    6.98 6722669/6722669     generic_make_request [11]
[13]     8.1   37.95    6.98 6722669         _make_request [13]
                6.81    0.00 6722816/50673121     spin_lock_ [12]
                0.13    0.00 6722816/51086468     spin_unlock_ [78]
                0.00    0.03     147/147         _get_request_wait [187]

               25.70   13.88 13445261/13445261     generic_make_request [11]
[14]     7.1   25.70   13.88 13445261         blk_get_queue [14]
               13.62    0.00 13445261/50673121     spin_lock_ [12]
                0.26    0.00 13445261/51086468     spin_unlock_ [78]

[15]     4.5    0.05   24.67                 ia64_leave_kernel [15]
                0.00   24.28 1479060/1479060     ia64_handle_irq [17]
                0.31    0.05   26208/30536       schedule [111]
                0.00    0.03    3629/3629        ia64_do_page_fault [186]

                0.00   24.28 1492630/1492630     ia64_handle_irq [17]
[16]     4.4    0.00   24.28 1492630         do_IRQ [16]
                0.13   20.78  403703/444995      do_softirq [18]
                0.39    2.89 1492630/1492630     handle_IRQ_event [53]


Lockmeter output (stripped -- holds lock for 1ms+, or 3%+):
-----------------------------------------------------------
System: Linux vanmaren.slc.unisys.com 2.4.8 #23 SMP Fri Aug 24 22:10:04 UTC
2001 ia64
Total counts

All (4) CPUs
Selecting locks that meet ALL of the following:
        utilization :   >  1.00%


Start time: Fri Aug 24 22:23:05 2001
End   time: Fri Aug 24 22:28:43 2001
Delta Time: 337.74 sec.
Hash table slots in use:      388.
Global read lock slots in use: 245.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT  NAME

       25.1%  6.1us(5450ms)   59us(5817ms)(65.4%)  60013220 74.9% 25.1%
0.00%  *TOTAL*

  3.1% 0.06%   25us(  14ms)    0us                   414766  100%    0%
0.06%  global_bh_lock
  3.1% 0.06%   25us(  14ms)    0us                   414766  100%    0%
0.06%    bh_action+0x60

  6.6%  3.9%  1.1us( 201us)   11us( 223us)(0.63%)  20495246 96.1%  3.9%
0%  io_request_lock

  3.1% 0.44%   28us(5450ms)   16ms(5817ms)( 2.0%)    381041 99.6% 0.44%
0%  kernel_flag
  2.7% 57.1% 1280ms(5450ms)   96us( 183us)(0.00%)         7 42.9% 57.1%
0%    blkdev_put+0xf0
 0.26% 0.19%  6.5us(2393us)   33ms(5450ms)(0.65%)    136598 99.8% 0.19%
0%    real_lookup+0x220
 0.12% 0.56%   27us(1026us)   28us( 709us)(0.00%)     15118 99.4% 0.56%
0%    tty_write+0x4c0
 0.03% 0.38%   29us(5251us)  485ms(5817ms)(0.43%)      3153 99.6% 0.38%
0%    vfs_readdir+0x1e0

 87.8% 95.5%   21us(5450ms)   62us(5450ms)(62.1%)  14241646  4.5% 95.5%
0%  lru_list_lock
  2.7% 14.3% 1280ms(5450ms)  2.6us( 2.6us)(0.00%)         7 85.7% 14.3%
0%    __invalidate_buffers+0x60
 0.03%  100% 4320us(  43ms)   45us( 102us)(0.00%)        20    0%  100%
0%    bdflush+0x1d0
 78.1% 96.9%   37us(  12ms)   62us( 256ms)(31.6%)   7143220  3.1% 96.9%
0%    getblk+0x60
  1.3% 63.0%   80ms( 261ms)   65us( 436us)(0.00%)        54 37.0% 63.0%
0%    kupdate+0x1b0
  4.1% 94.5%  2.0us(2945us)   61us(5450ms)(28.6%)   6725777  5.5% 94.5%
0%    refile_buffer+0x50
  1.0% 95.9%   18us(6871us)   66us(  12ms)(0.92%)    195148  4.1% 95.9%
0%    sync_old_buffers+0x120
 0.47% 85.3%  9.8us(1407us)   81us(  26ms)(0.83%)    162013 14.7% 85.3%
0%    try_to_free_buffers+0xb0
 0.03%  8.7% 1102us(  55ms)   52ms( 199ms)(0.03%)        92 91.3%  8.7%
0%    wait_for_locked_buffers+0x60
 0.19% 27.6%   42us(  20ms)  324us( 253ms)(0.10%)     14915 72.4% 27.6%
0%    write_unlocked_buffers+0x60

  2.1%  9.1%  1.0us(3507us)   11us(  10ms)(0.51%)   6745773 90.9%  9.1%
0%  unused_list_lock
  2.0%  9.1%  1.0us(3507us)   11us(  10ms)(0.50%)   6720952 90.9%  9.1%
0%    get_unused_buffer_head+0x50

  1.0% 0.29%  0.5us(1386us)  2.0us( 712us)(0.00%)   7140899 99.7% 0.29%
0%  getblk+0x2d0

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL
NOWAIT SPIN  NAME

       0.00%                                20us(  45us)(0.00%)    847741
100% 0.00%  *TOTAL*

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL
NOWAIT SPIN(  WW )  NAME

       0.00%   18us(  12ms)  6.1us(  52us)(0.00%)  1.9us( 2.3us)  12941611
100% 0.00%(0.00%)  *TOTAL*

 69.2% 0.00%   19us(  12ms)   11us(  52us)(0.00%)  1.9us( 2.3us)  12058253
100% 0.00%(0.00%)  hash_table_lock
  1.8%    0%  1.3us(  49us)    0us                   0us           4753020
100%    0%(   0%)    __invalidate_buffers+0x270
 67.2% 0.00%   32us(  12ms)   11us(  52us)(0.00%)  1.9us( 2.3us)   7143220
100% 0.00%(0.00%)    getblk+0x80
 0.24%    0%  4.9us(1402us)    0us                   0us            162013
100%    0%(   0%)    try_to_free_buffers+0xd0


=========================================================
Single CPU/FS test case: 1 mkfs (md of the 4 md's above):
Note that only 16% is "idle" on a 4X.
=========================================================

Kgprof:
-------
Each sample counts as 0.000976562 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 28.88    158.93   158.93                             cg_record_arc
 15.89    246.38    87.44                             cpu_idle
 14.82    327.95    81.58  6723015     0.01     0.02  getblk
 14.42    407.30    79.35 59278971     0.00     0.00  spin_lock_
  5.23    436.10    28.80 20168512     0.00     0.00  blk_get_queue
  4.60    461.44    25.34  6722884     0.00     0.01  _make_request
  2.56    475.53    14.08                             mcount
  2.21    487.71    12.18                             long_copy_user
  0.91    492.72     5.01    87690     0.06     0.06  scsi_dispatch_cmd
  0.78    496.99     4.27    83855     0.05     0.27  _scsi_end_request
  0.75    501.11     4.12    87690     0.05     0.08  scsi_init_io_vc
  0.68    504.85     3.74        2  1870.61  7179.64  _invalidate_buffers
  0.65    508.43     3.57  6398252     0.00     0.00  end_buffer_io_sync
  0.51    511.25     2.82    56707     0.05     0.06  ahc_linux_isr
  0.49    513.97     2.72      666     4.09     4.09  si_swapinfo
  0.44    516.40     2.43    82692     0.03     0.03  scsi_malloc
  0.32    518.17     1.78 26887713     0.00     0.00  _insert_into_lru_list
[other interesting points]
  0.24    522.20     1.33   216677     0.01     0.55  block_write
  0.21    527.01     1.16    87102     0.01     0.16  scsi_request_fn
  0.10    537.63     0.54       47    11.55    31.51  page_launder
  0.04    544.66     0.24       98     2.43    15.73  wait_for_buffers
  0.01    548.49     0.05       47     0.98  1887.26  sync_old_buffers
  0.00    550.42     0.00       47     0.00    32.21  do_try_to_free_pages
  0.00    550.42     0.00       12     0.00   462.33  write_unlocked_buffers
  0.00    550.42     0.00        8     0.00   793.75  sync_buffers
  0.00    550.42     0.00        8     0.00   100.26
wait_for_locked_buffers
  0.00    550.42     0.00        4     0.00   793.75  fsync_dev
  0.00    550.42     0.00        2     0.00  8767.16  blkdev_put
  0.00    550.42     0.00        2     0.00  1587.54  sys_fsync

[1]     29.6  158.93    0.00                 cg_record_arc [1]

[2]     28.3    0.03  152.01                 ia64_ret_from_syscall [2]
                0.09  127.90  231867/231867      sys_write [3]
                0.03    7.21   66165/66165       sys_read [37]
                0.07    6.84  218393/218393      sys_lseek [38]

                0.09  127.90  231867/231867      ia64_ret_from_syscall [2]
[3]     23.9    0.09  127.90  231867         sys_write [3]
                1.33  118.33  216677/216677      block_write [4]

                1.33  118.33  216677/216677      sys_write [3]
[4]     22.3    1.33  118.33  216677         block_write [4]
               81.58   22.81 6722853/6723015     getblk [5]
                0.64   10.42 6722853/6723043     mark_buffer_dirty [31]

                0.00    0.00       8/6723015     block_read [414]
                0.00    0.00     154/6723015     bread [320]
               81.58   22.81 6722853/6723015     block_write [4]
[5]     19.5   81.58   22.81 6723015         getblk [5]
               18.08    0.00 13509844/59278971     spin_lock_ [13]
                0.00    1.17   32955/32955       refill_freelist [76]
                0.87    0.00 6720919/6720919     _insert_into_queues [84]
                0.76    0.00 6720919/6720919     _remove_from_free_list [89]
                0.58    0.00 6755970/14043341     write_unlock_ [75]
                0.47    0.00 6755970/14043341     write_lock_ [83]
                0.44    0.00 6720919/26887713     _insert_into_lru_list [64]
                0.25    0.00 13509844/59693888     spin_unlock_ [78]
                0.18    0.00 6720919/6720919     init_buffer [142]

                0.01    5.52   12374/210102      write_unlocked_buffers [42]
                0.20   88.19  197728/210102      sync_old_buffers [11]
[6]     17.5    0.21   93.71  210102         write_some_buffers [6]
                0.04   92.58  210092/210092      write_locked_buffers [7]
                0.36    0.28 6722899/22499809     _refile_buffer [59]
                0.44    0.00 6722883/26887713     _insert_into_lru_list [64]

                0.04   92.58  210092/210092      write_some_buffers [6]
[7]     17.3    0.04   92.58  210092         write_locked_buffers [7]
                0.30   92.28 6722883/6722884     submit_bh [8]

                0.00    0.00       1/6722884     ll_rw_block [507]
                0.30   92.28 6722883/6722884     write_locked_buffers [7]
[8]     17.3    0.30   92.28 6722884         submit_bh [8]
                0.25   92.02 6722884/6722884     generic_make_request [9]

                0.25   92.02 6722884/6722884     submit_bh [8]
[9]     17.2    0.25   92.02 6722884         generic_make_request [9]
               28.80   27.38 20168512/20168512     blk_get_queue [14]
               25.34    9.16 6722884/6722884     _make_request [15]
                0.33    1.01 13445628/13445628     md_make_request [70]

[10]    16.7    0.00   89.44                 kupdate [10]
                0.05   88.66      47/47          sync_old_buffers [11]
                0.11    0.62      47/98          wait_for_buffers [65]

                0.05   88.66      47/47          kupdate [10]
[11]    16.5    0.05   88.66      47         sync_old_buffers [11]
                0.20   88.19  197728/210102      write_some_buffers [6]
                0.26    0.00  197821/59278971     spin_lock_ [13]
                0.00    0.00      47/47          sync_unlocked_inodes [295]
                0.00    0.00      47/51          sync_supers [424]
                0.00    0.00     187/59693888     spin_unlock_ [78]

[12]    16.3   87.44    0.09                 cpu_idle [12]
                0.06    0.03   10282/31233       schedule [129]

                0.15    0.00  109352/59278971     ahc_linux_isr [50]
                0.15    0.00  113900/59278971     do_IRQ [33]
                0.18    0.00  136509/59278971     real_lookup [63]
                0.18    0.00  136518/59278971     d_alloc [132]
                0.18    0.00  136518/59278971     d_rehash [141]
                0.18    0.00  136521/59278971     d_instantiate [140]
                0.18    0.00  136521/59278971     get_empty_inode [133]
                0.19    0.00  139538/59278971     _wake_up [107]
                0.23    0.00  173973/59278971     try_to_free_buffers [91]
                0.26    0.00  197821/59278971     sync_old_buffers [11]
                0.29    0.00  218393/59278971     sys_lseek [38]
                0.47    0.00  353459/59278971     d_lookup [101]
                0.47    0.00  354202/59278971     timer_bh [99]
                0.71    0.00  527288/59278971     get_unused_buffer_head
[87]
                0.93    0.00  696032/59278971     atomic_dec_and_lock [82]
                8.45    0.00 6310839/59278971     put_last_free [36]
                9.00    0.00 6722880/59278971     refile_buffer [35]
                9.00    0.00 6723070/59278971     _make_request [15]
               18.08    0.00 13509844/59278971     getblk [5]
               27.00    0.00 20168512/59278971     blk_get_queue [14]
[13]    14.8   79.35    0.00 59278971         spin_lock_ [13]

               28.80   27.38 20168512/20168512     generic_make_request [9]
[14]    10.5   28.80   27.38 20168512         blk_get_queue [14]
               27.00    0.00 20168512/59278971     spin_lock_ [13]
                0.38    0.00 20168512/59693888     spin_unlock_ [78]

Lockstat:
---------
System: Linux vanmaren.slc.unisys.com 2.4.8 #23 SMP Fri Aug 24 22:10:04 UTC
2001 ia64
Total counts

All (4) CPUs
Selecting locks that meet ALL of the following:
        utilization :   >  1.00%

Start time: Fri Aug 24 22:43:51 2001
End   time: Fri Aug 24 22:48:34 2001
Delta Time: 283.01 sec.
Hash table slots in use:      297.
Global read lock slots in use: 214.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT  NAME

        1.1%  4.6us( 582ms)   47us(5781ms)( 2.7%)  59050695 98.9%  1.1%
0.02%  *TOTAL*

  1.0%  5.1%   18us( 111us)   35us( 576us)(0.03%)    163560 94.9%  5.1%
0%  allocator_request_lock

  1.4% 0.01%  0.3us( 7.2us)   15us(  41us)(0.00%)  13108126  100% 0.01%
0%  free_list+0x18

  3.8%  2.3%   27us(7193us)    0us                   400694 97.7%    0%
2.3%  global_bh_lock
  3.8%  2.3%   27us(7193us)    0us                   400694 97.7%    0%
2.3%    bh_action+0x60

  5.5% 0.78%  0.6us(  96us)  3.4us(  95us)(0.06%)  27316523 99.2% 0.78%
0%  io_request_lock
  3.6% 0.27%  1.5us(  42us)  3.9us(  45us)(0.01%)   6723632 99.7% 0.27%
0%    __make_request+0x290

 82.4%  3.1%   17us( 582ms)   32us( 582ms)( 1.2%)  13719319 96.9%  3.1%
0%  lru_list_lock
 0.04%    0%   59ms( 117ms)    0us                        2  100%    0%
0%    __invalidate_buffers+0x60
 78.3% 0.26%   33us(  97us)   89us( 296ms)(0.14%)   6746687 99.7% 0.26%
0%    getblk+0x60
  1.5% 18.2%   99ms( 582ms)  5.4us(  29us)(0.00%)        44 81.8% 18.2%
0%    kupdate+0x1b0
 0.01%    0%  603us(  15ms)    0us                       48  100%    0%
0%    wait_for_locked_buffers+0x60

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL
NOWAIT SPIN  NAME

       0.00%                               1.2us( 1.2us)(0.00%)    766789
100% 0.00%  *TOTAL*

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL
NOWAIT SPIN(  WW )  NAME

          0%   16us(  97us)    0us                   0us          13859543
100%    0%(   0%)  *TOTAL*

 79.8%    0%   17us(  97us)    0us                   0us          13125889
100%    0%(   0%)  hash_table_lock
  2.6%    0%  1.2us( 5.4us)    0us                   0us           6339799
100%    0%(   0%)    __invalidate_buffers+0x270
 76.9%    0%   32us(  97us)    0us                   0us           6746687
100%    0%(   0%)    getblk+0x80
