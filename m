Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319230AbSH2SP6>; Thu, 29 Aug 2002 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319251AbSH2SP6>; Thu, 29 Aug 2002 14:15:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:999 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319230AbSH2SP4>;
	Thu, 29 Aug 2002 14:15:56 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208291820.g7TIKHA19433@eng2.beaverton.ibm.com>
Subject: 2.5.32 IO performance issues
To: linux-kernel@vger.kernel.org
Date: Thu, 29 Aug 2002 11:20:17 -0700 (PDT)
Cc: akpm@zip.com.au, gerrit@us.ibm.com (Gerrit Huizenga),
       hjt@us.ibm.com (Hans-J Tannenberger),
       janetmor@us.ibm.com (Janet Morgan), andmike@us.ibm.com (Mike Anderson),
       mjbligh@us.ibm.com (Martin Bligh)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having severe IO performance problems with 2.5.32 (2.5.31 works fine).
I was wondering what caused this. 

As you can see, IO rate went from 

		384MB/sec with 6% CPU utilization on 2.5.31 
			to
		120MB/sec with 19% CPU utilization on 2.5.32

Any idea ?

Thanks,
Badari

Hardware: 8x 700MHz P-III, 4 Qlogic FC controllers, 40 disks
Test: 40 dds on 40 raw devices (40 disks).

2.5.32 vmstat output: 
---------------------

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3 36  0      0 3803972      0  23392   0   0 119962    24 1939  3592   0  18  81
 2 37  0      0 3804144      0  23392   0   0 121024     0 1938  3611   0  19  81
 0 39  0      0 3804776      0  23392   0   0 119834     0 1925  3553   0  19  81
 0 39  0      0 3804172      0  23392   0   0 120128     0 1932  3584   0  19  81
 1 38  0      0 3804680      0  23392   0   0 120346     0 1932  3585   0  19  81
 4 35  0      0 3804536      0  23392   0   0 120806     0 1940  3625   0  18  81
 1 38  1      0 3804212      0  23392   0   0 120512     0 1938  3607   0  19  81
 0 39  0      0 3804592      0  23392   0   0 120282     0 1931  3572   0  19  81
 0 39  0      0 3803944      0  23392   0   0 120755     0 1936  3617   0  19  81

2.5.31 vmstat output: 
---------------------
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 39  0      0 3803732      0  32080   0   0 384141    13 3966  6232   0   5  95
 0 39  0      0 3803700      0  32080   0   0 384230     3 3962  6248   0   6  94
 0 39  0      0 3803696      0  32080   0   0 384256     2 3966  6226   0   5  95
 0 39  0      0 3803696      0  32080   0   0 384179     0 3961  6236   0   5  95
 1 38  0      0 3803684      0  32080   0   0 384230     0 3967  6229   0   5  95
 0 39  0      0 3803680      0  32080   0   0 383782     0 3958  6233   0   6  94
 0 39  0      0 3803680      0  32080   0   0 384154     0 3964  6225   0   5  95
 0 39  0      0 3803676      0  32080   0   0 384077     7 3968  6252   0   5  95

Profile=2 optput for 2.5.32:
---------------------------
# readprofile | sort -nr +2

151712 default_idle                             2370.5000
21622 __scsi_end_request                       122.8523
  4491 do_softirq                                23.3906
  2543 scsi_dispatch_cmd                          4.1826
   306 dio_bio_complete                           1.7386
  1798 __make_request                             1.5608
   756 rmqueue                                    0.9265
   198 scsi_queue_next_request                    0.6513
   100 dio_await_one                              0.6250
    25 __wake_up                                  0.5208
   499 scsi_request_fn                            0.4873
    15 scsi_sense_valid                           0.4688
    14 page_pool_alloc                            0.4375
   167 blk_rq_map_sg                              0.4349
   381 schedule                                   0.4252
   132 __set_page_dirty_buffers                   0.3750
    51 generic_unplug_device                      0.3542
    17 bio_put                                    0.3542
    78 scsi_finish_command                        0.3482
     5 cap_file_permission                        0.3125
   112 mempool_alloc                              0.2917
    23 bio_destructor                             0.2875
   215 get_user_pages                             0.2859
   117 bio_alloc                                  0.2812
    21 fget                                       0.2625
    12 dio_prep_bio                               0.2500
   194 blk_queue_bounce                           0.2497
   165 do_direct_IO                               0.2398
    25 cpu_idle                                   0.2232
     7 _alloc_pages                               0.2188
     2 syscall_exit                               0.1818
    23 kmem_cache_free                            0.1797
    44 __scsi_release_command                     0.1654
    13 dio_get_page                               0.1625
     5 __get_free_pages                           0.1562
     5 fput                                       0.1562
    32 add_timer                                  0.1429
    20 blk_run_queues                             0.1389
    42 kmem_cache_alloc                           0.1382
    23 add_entropy_words                          0.1307
    63 __alloc_pages                              0.1270
     8 scsi_free_sgtable                          0.1250
     8 dio_new_bio                                0.1250
     4 slab_pool_alloc                            0.1250
    25 scsi_init_cmd_errh                         0.1116
    10 mempool_free                               0.1111
186646 total                                      0.1034
     6 __generic_copy_to_user                     0.0938
     3 scsi_pool_free                             0.0938
     3 scsi_pool_alloc                            0.0938
     4 system_call                                0.0909
    27 scsi_decide_disposition                    0.0844
     9 submit_bio                                 0.0804
     9 __run_task_queue                           0.0804
    24 vfs_read                                   0.0789
    15 rw_raw_dev                                 0.0781
     6 bh_action                                  0.0750
     8 scsi_add_timer                             0.0714
    11 generic_file_direct_IO                     0.0683
    57 sd_init_command                            0.0660
     6 find_vma                                   0.0625
     6 blkdev_get_blocks                          0.0625
     5 max_block                                  0.0625
     4 dio_await_completion                       0.0625
     3 blkdev_direct_IO                           0.0625
     2 slab_pool_free                             0.0625
    18 vfs_write                                  0.0592
    10 batch_entropy_process                      0.0568
    15 get_more_blocks                            0.0551
    31 scsi_softirq                               0.0538
     4 dio_bio_submit                             0.0500
    35 timer_bh                                   0.0497
    12 scsi_alloc_sgtable                         0.0469
    20 generic_direct_IO                          0.0431
     4 find_extend_vma                            0.0417
     4 dio_bio_alloc                              0.0417
    20 sd_rw_intr                                 0.0368
     7 tasklet_hi_action                          0.0365
     4 dio_bio_reap                               0.0357
     9 generic_make_request                       0.0352
     2 sys_read                                   0.0312
     1 __wake_up_locked                           0.0312
     1 tqueue_bh                                  0.0312
    30 scsi_io_completion                         0.0280
     4 write_profile                              0.0227
     5 scsi_init_io                               0.0223
     5 dio_refill_pages                           0.0208
     1 in_group_p                                 0.0208
     1 credit_entropy_store                       0.0208
     2 .text.lock.mempool                         0.0196
     1 .text.lock.highmem                         0.0182
     4 mod_timer                                  0.0167
     1 atomic_dec_and_lock                        0.0161
     1 sys_write                                  0.0156
     1 free_pages                                 0.0156
     1 fd_install                                 0.0156
     1 strncpy_from_user                          0.0125
     1 scsi_get_request_dev                       0.0125
     2 __d_lookup                                 0.0089
     1 pfifo_fast_enqueue                         0.0089
     1 session_of_pgrp                            0.0078
     7 proc_pid_status                            0.0071
     2 page_remove_rmap                           0.0069
     2 i8042_interrupt                            0.0066
     1 scsi_eh_completed_normally                 0.0063
     4 number                                     0.0057
     1 skb_release_data                           0.0057
     1 tcp_v4_send_check                          0.0052
     1 locks_remove_flock                         0.0052
     1 eth_type_trans                             0.0052
     1 __find_get_block                           0.0048
     1 page_add_rmap                              0.0045
     1 __kfree_skb                                0.0045
     3 proc_pid_stat                              0.0043
     1 bh_lru_install                             0.0042
     4 vsnprintf                                  0.0038
     1 tcp_v4_checksum_init                       0.0037
     1 ksoftirqd                                  0.0037
     1 tcp_poll                                   0.0030
     1 may_open                                   0.0026
     1 dentry_open                                0.0026
     1 sd_open                                    0.0024
     5 link_path_walk                             0.0023
     2 kstat_read_proc                            0.0021
     1 do_anonymous_page                          0.0021
     1 tty_write                                  0.0015
     1 __free_pages_ok                            0.0013
     1 ext3_find_entry                            0.0012
     2 tulip_interrupt                            0.0010


