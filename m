Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbTIHTAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIHTAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:00:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35514 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263492AbTIHS7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:59:04 -0400
Importance: Normal
Sensitivity: 
Subject: 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0770DEDD.BEBEF8A2-ON85256D9B.00659B11@us.ibm.com>
From: Mike Sullivan <mksully@us.ibm.com>
Date: Mon, 8 Sep 2003 13:58:36 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 JHEG5P4HSL
 JBONL5L8FGD MIAS5MHLYW|August 26, 2003) at 09/08/2003 14:58:56
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test3 I am seeing a significant slowdown (~40%) during
heavy database workloads when using the default anticipatory
I/O scheduler. When the same kernel is booted with the
elevator=deadline argument the slowdown does not occur.
I've attached excerpts from the database test  for vmstat and
iostat output as well as readprofiles for each of the schedulers.
Is anyone else seeing similiar behaviors?

Hardware: IBM x440 8way with hypertheading enabled, 16GB RAM,
4 QLA2310 FC adapters attached to 2 FastT900 controllers
(112 disks total).

1a. vmstat for anticipatory scheduler
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
14 41      0 3489576   3840 168280    0    0    25     2   70    30  1  2 96  0
 4 103      0 3329760   3860 172160    0    0 233549    97 6606 21284 27  6  0 67
 7 91      0 3327496   3864 172156    0    0 137106    14 7364 32957 20  5  0 75
 2 84      0 3325416   3868 172412    0    0 138979    73 7096 30445 19  5  0 76
 6 78      0 3324528   3868 173192    0    0 143213   444 7328 24901 13  4  0 83
 0 105      0 3316408   3876 173964    0    0 142413   524 7531 26854 12  5  0 83
 7 94      0 3313664   3880 174220    0    0 134939   821 7336 29037 14  5  0 82
 1 110      0 3313560   3884 174216    0    0 114651   923 6990 27063 11  4  0 84
 5 109      0 3313008   3884 174216    0    0 110115   862 6937 26381 11  4  0 85
 3 111      0 3325400   3920 174180    0    0 108664  1030 6892 26721 11  4  0 85


1b. vmstat for deadline scheduler
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
19  0      0 3518364   3104 119096    0    0    43     1   78    62  1  2 97  1
70 23      0 3361380   3776 170684    0    0 351035   538 3521 19435 68 17  9  5
96 25      0 3321060   3816 171684    0    0 588377   349 4973 25000 91  9  0  0
79 41      0 3316492   3824 171676    0    0 621683   831 5037 26853 91  9  0  0
86 48      0 3318684   3836 172964    0    0 609092  3073 4882 27878 91  9  0  0
71 44      0 3310164   3848 173212    0    0 551741  3746 4291 28492 92  8  0  0
91 35      0 3297708   3852 174248    0    0 508096  1425 4410 29533 91  8  0  1


2a. iostat for anticipatory scheduler

Linux 2.6.0-test3lp
Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     1.92   0.00 363.48  0.88 18908.11   29.12  9454.06    14.56    51.98     4.80   13.14   1.22  44.57
/dev/sdi     1.97   0.00 364.65  0.61 18541.72   20.66  9270.86    10.33    50.82     4.86   13.27   1.23  44.75
/dev/sdh     1.95   0.00 361.35  0.85 18901.05   28.30  9450.53    14.15    52.26     4.79   13.20   1.23  44.72
/dev/sdg     1.66   0.00 357.14  0.84 18155.59   28.06  9077.80    14.03    50.79     4.74   13.23   1.25  44.61
/dev/sdf     3.20   0.00 328.57  0.87 17293.65   28.98  8646.82    14.49    52.58     4.73   14.34   1.36  44.74
/dev/sde     3.44   0.00 330.51  0.75 17180.30   18.55  8590.15     9.28    51.92     4.76   14.35   1.36  45.08
/dev/sdd     3.36   0.00 323.76  0.42 16911.58   14.56  8455.79     7.28    52.21     4.80   14.78   1.38  44.75
/dev/sdc     3.04   0.00 325.47  0.93 16665.03   31.01  8332.51    15.50    51.15     4.94   15.13   1.37  44.74

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     4.80   0.00 863.10  2.00 39945.60   64.00 19972.80    32.00    46.25    11.25   13.08   1.16 100.02
/dev/sdi     4.50   0.00 787.50 14.90 34438.40  483.20 17219.20   241.60    43.52    14.13   17.58   1.25 100.02
/dev/sdh     3.40   0.00 851.00  2.10 33180.80   70.40 16590.40    35.20    38.98    11.65   13.60   1.17 100.02
/dev/sdg     5.10   0.00 840.60  9.10 37772.80  288.00 18886.40   144.00    44.79    13.01   15.27   1.18 100.02
/dev/sdf     8.90   0.00 740.70  3.90 33075.20  128.00 16537.60    64.00    44.59    11.66   15.67   1.34 100.02
/dev/sde     8.30   0.00 760.40  2.80 36169.60   96.00 18084.80    48.00    47.52    11.70   15.23   1.31 100.02
/dev/sdd    12.40   0.00 769.70  0.00 30147.20    0.00 15073.60     0.00    39.17    11.05   14.29   1.30 100.02
/dev/sdc     9.20   0.00 746.00  3.00 31568.00   92.80 15784.00    46.40    42.27    11.65   15.59   1.34 100.03

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     5.01   0.00 895.80  0.00 38073.27    0.00 19036.64     0.00    42.50    11.06   12.29   1.12 100.12
/dev/sdi     5.91   0.00 818.02 12.61 32515.72  406.81 16257.86   203.40    39.64    13.84   16.71   1.21 100.12
/dev/sdh     7.41   0.00 862.16  1.80 34652.25   54.45 17326.13    27.23    40.17    11.46   13.31   1.16 100.12
/dev/sdg     4.40   0.00 866.67  2.20 33271.67   70.47 16635.84    35.24    38.37    11.67   13.43   1.15 100.13
/dev/sdf     8.01   0.00 784.28  2.80 33242.84   86.49 16621.42    43.24    42.35    11.52   14.59   1.27 100.13
/dev/sde     6.11   0.20 728.53 17.62 30488.09  576.58 15244.04   288.29    41.63    15.00   20.15   1.34 100.13
/dev/sdd     6.01   0.40 705.51 12.11 29690.49  413.21 14845.25   206.61    41.95    13.73   19.17   1.40 100.13
/dev/sdc     7.41   0.80 738.04  7.61 33338.94  281.88 16669.47   140.94    45.09    12.13   16.17   1.34 100.12

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     4.29   0.00 864.37  0.00 33411.58    0.00 16705.79     0.00    38.65    11.17   12.97   1.15  99.83
/dev/sdi     6.29   0.00 826.35  6.49 35002.00  198.00 17501.00    99.00    42.27    12.34   14.75   1.20  99.83
/dev/sdh     6.69   0.00 844.91  0.90 36563.67   28.74 18281.84    14.37    43.26    10.92   13.03   1.18  99.83
/dev/sdg     3.39   0.00 860.78  0.70 33705.39   22.36 16852.69    11.18    39.15    11.27   13.09   1.16  99.82
/dev/sdf     8.28   0.00 749.40  1.20 32661.08   38.32 16330.54    19.16    43.56    11.24   14.97   1.33  99.82
/dev/sde     5.79   0.00 731.44 13.47 34328.14  427.94 17164.07   213.97    46.66    13.86   18.67   1.34  99.82
/dev/sdd     4.59   0.00 713.77 17.37 31853.09  552.50 15926.55   276.25    44.32    14.61   20.09   1.37  99.82
/dev/sdc    11.88   0.00 699.00 16.07 30914.17  514.17 15457.09   257.09    43.95    14.46   20.26   1.40  99.82


2b. io for deadline
Linux 2.6.0-test3lp

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     0.04   0.00 103.39  1.02 30230.24   36.05 15115.12    18.02   289.87     0.68    6.51   1.60  16.72
/dev/sdi     0.01   0.00 64.93  0.82 18642.75   29.55  9321.38    14.77   283.99     0.50    7.57   1.90  12.49
/dev/sdh     0.02   0.00 109.26  1.02 30215.96   36.05 15107.98    18.02   274.30     0.70    6.37   1.55  17.14
/dev/sdg     0.03   0.00 62.97  0.21 18346.02   10.04  9173.01     5.02   290.50     0.48    7.53   1.92  12.11
/dev/sdf     0.02   0.00 98.78  0.92 27471.17   32.80 13735.58    16.40   275.87     0.75    7.47   1.64  16.37
/dev/sde     1.64   0.00 105.42  1.75 27301.07   41.84 13650.54    20.92   255.15     0.77    7.21   1.63  17.46
/dev/sdd     0.02   0.00 103.89  1.02 28228.90   36.05 14114.45    18.02   269.40     0.77    7.36   1.58  16.54
/dev/sdc     0.05   0.00 108.91  1.63 31749.13   55.56 15874.56    27.78   287.71     0.77    6.94   1.67  18.49

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     0.10   0.00 581.30  0.00 152032.00    0.00 76016.00     0.00   261.54     4.16    7.16   1.62  94.39
/dev/sdi     0.20   0.00 497.70  0.00 152601.60    0.00 76300.80     0.00   306.61     3.75    7.52   1.92  95.35
/dev/sdh     0.20   0.00 552.40  0.00 150166.40    0.00 75083.20     0.00   271.84     3.97    7.18   1.71  94.71
/dev/sdg     0.20   0.00 545.70  0.00 148086.40    0.00 74043.20     0.00   271.37     3.93    7.19   1.74  95.15
/dev/sdf     0.20   0.00 661.90  0.00 160950.40    0.00 80475.20     0.00   243.16     4.97    7.50   1.47  97.56
/dev/sde     0.80   0.00 725.50  0.00 148051.20    0.00 74025.60     0.00   204.07     5.39    7.42   1.31  95.00
/dev/sdd     0.90   0.00 688.60  0.00 158950.40    0.00 79475.20     0.00   230.83     5.12    7.43   1.40  96.40
/dev/sdc     0.70   0.00 644.30 13.80 147622.40  441.60 73811.20   220.80   224.99     4.99    7.58   1.41  92.52

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     0.00   0.00 448.10  0.00 132969.60    0.00 66484.80     0.00   296.74     3.03    6.77   1.88  84.40
/dev/sdi     0.00   0.00 514.20  0.00 141683.20    0.00 70841.60     0.00   275.54     3.53    6.88   1.80  92.70
/dev/sdh     0.20   0.00 537.90  0.00 145718.40    0.00 72859.20     0.00   270.90     3.93    7.31   1.71  91.92
/dev/sdg     0.60   0.00 764.00  0.00 149760.00    0.00 74880.00     0.00   196.02     5.25    6.87   1.30  99.41
/dev/sdf     0.70   0.00 803.10  0.00 138851.20    0.00 69425.60     0.00   172.89     5.94    7.40   1.20  96.11
/dev/sde     1.00   0.00 993.30  0.00 164857.60    0.00 82428.80     0.00   165.97     6.97    7.02   1.01  99.96
/dev/sdd     1.80   0.00 899.70  0.00 166409.60    0.00 83204.80     0.00   184.96     5.93    6.59   1.11  99.49
/dev/sdc     0.20   0.00 445.30  0.00 131558.40    0.00 65779.20     0.00   295.44     3.37    7.57   1.93  85.86

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
/dev/sdj     0.10   0.00 402.60  0.00 154393.60    0.00 77196.80     0.00   383.49     2.77    6.89   2.01  80.84
/dev/sdi     0.00   0.00 506.60  9.20 132547.20  294.40 66273.60   147.20   257.54     3.47    6.73   1.49  76.64
/dev/sdh     0.20   0.00 323.90  0.00 103331.20    0.00 51665.60     0.00   319.02     2.28    7.04   2.04  66.11
/dev/sdg     0.10   0.00 553.00  0.00 174540.80    0.00 87270.40     0.00   315.63     3.56    6.44   1.71  94.53
/dev/sdf     0.00   0.00 447.70  0.00 154179.20    0.00 77089.60     0.00   344.38     3.33    7.44   1.99  88.89
/dev/sde     0.20   0.00 426.20  4.60 155136.00  147.20 77568.00    73.60   360.45     3.21    7.47   2.06  88.80
/dev/sdd     0.10   0.00 448.90  0.00 159312.00    0.00 79656.00     0.00   354.89     3.28    7.30   1.98  88.70
/dev/sdc     0.00   0.00 410.50  0.00 146473.60    0.00 73236.80     0.00   356.82     3.04    7.41   2.16  88.65


3a. readprofile for anticipatory scheduler
1699600 total                                      0.8206
1609934 poll_idle                                27757.4828
 12233 schedule                                  10.1772
 11380 do_softirq                                54.9758
  9795 __make_request                             8.0485
  5708 scsi_request_fn                            8.3450
  5282 scsi_end_request                          28.2460
  3482 qla2x00_start_scsi                         3.4960
  3466 dio_bio_end_io                            28.8833
  2279 dio_await_one                             14.6090
  2065 cpu_idle                                  32.2656
  1706 qla2x00_queuecommand                       1.1685
  1647 add_timer                                 11.6809
  1572 put_io_context                            18.2791
  1503 unlock_page                               17.0795
  1433 follow_hugetlb_page                        3.0042
  1292 sys_msgsnd                                 1.7969
  1260 current_kernel_time                       18.2609
  1081 scsi_dispatch_cmd                          2.8078
   918 qla2x00_get_new_sp                         8.2703
   758 try_to_wake_up                             1.3512
   702 system_call                               15.9545
   691 del_timer_sync                             5.4841
   687 scsi_io_completion                         0.6314
   628 do_no_page                                 0.5004
   589 blk_recount_segments                       0.8951
   577 blk_run_queues                             3.6752
   560 __end_that_request_first                   1.0219
   533 get_io_context                             4.1318
   506 scsi_device_unbusy                         4.0480
   501 set_page_dirty_lock                        5.5055
   493 get_request                                0.7515
   451 direct_io_worker                           0.4275
   450 do_direct_IO                               0.4306
   441 dio_bio_complete                           1.6036
   409 worker_thread                              0.6059
   406 submit_page_section                        0.9442
   386 kmem_cache_alloc                           5.0130
   358 bio_alloc                                  0.8689
   344 add_disk_randomness                        6.6154
   339 kmem_cache_free                            3.8966
   319 dio_bio_add_page                           3.0673
   317 __generic_file_aio_read                    0.5671
   316 ipc_lock                                   4.3288
   296 kfree                                      2.2256
   281 add_timer_randomness                       1.2165
   268 as_work_handler                            3.3924
   236 fsync_buffers_list                         0.6396
   230 get_offset_cyclone                         4.1818
   223 huge_pte_offset                            5.4390
   213 qla2x00_next                               0.2359
   211 io_schedule_timeout                        4.1373
   208 scsi_put_command                           1.4545
   197 mempool_alloc                              0.5988
   186 blockdev_direct_IO                         0.5360
   180 finished_one_bio                           1.5517
   173 testmsg                                    2.4714
   173 batch_entropy_store                        1.1234
   171 sys_msgrcv                                 0.1913
   168 blk_run_queue                              2.3014
   166 mempool_free_slab                          7.9048
   159 dio_refill_pages                           0.5179
   157 generic_make_request                       0.3601
   149 bio_add_page                               0.4357
   140 dnotify_parent                             1.3592
   136 fget_light                                 1.0543
   135 vfs_read                                   0.4576
   122 do_page_fault                              0.1083
   118 update_atime                               0.5315
   116 get_jiffies_64                             2.0000
   113 sd_rw_intr                                 0.2770
   111 scsi_run_queue                             0.5663
   105 .text.lock.util                            4.3750
    97 blkdev_get_blocks                          0.8220
    92 __copy_from_user_ll                        0.7541
    90 generic_file_direct_IO                     0.5172
    88 add_wait_queue                             1.2571
    85 submit_bio                                 0.5556
    84 sys_semtimedop                             0.0635
    84 __copy_to_user_ll                          0.7000
    82 remove_wait_queue                          1.1081
    82 dio_bio_submit                             0.8119
    81 io_schedule                                1.6875
    78 do_gettimeofday                            0.5417
    78 dio_send_cur_page                          0.4561
    77 find_vma                                   0.9506
    75 page_add_rmap                              0.1974
    75 memcpy                                     1.3158
    75 bio_put                                    1.3889
    74 page_waitqueue                             1.5745
    72 scsi_init_cmd_errh                         0.3564
    72 generic_file_read                          0.4186
    71 max_block                                  0.6174
    70 blkdev_direct_IO                           0.6140
    66 sys_ipc                                    0.0965
    65 proc_pid_stat                              0.0543
    64 kmap_atomic                                0.3951
    63 scsi_softirq                               0.2864
    63 del_timer                                  0.6000
    62 default_idle                               1.3778
    60 mempool_free                               0.4878
    60 bio_destructor                             0.6383
    56 get_user_pages                             0.0556
    56 find_extend_vma                            0.4444
    55 task_mem                                   0.2148
    55 __d_lookup                                 0.2000
    52 number                                     0.0692
    51 syscall_exit                               4.6364
    51 dio_await_completion                       0.6220
    50 bio_get_nr_vecs                            0.9434
    49 as_set_request                             0.4375
    48 sys_pread64                                0.3780
    48 dio_get_page                               0.5517
    45 find_get_page                              0.5769
    41 do_anonymous_page                          0.0429
    40 do_getitimer                               0.1455
    38 dio_new_bio                                0.3016
    38 __set_page_dirty_buffers                   0.1279
    36 mempool_alloc_slab                         1.7143
    35 sys_setitimer                              0.1268
    35 do_clock_nanosleep                         0.0448
    35 __kmalloc                                  0.2869
    34 __copy_user_intel                          0.1977
    33 adjust_abs_time                            0.1158
    31 page_remove_rmap                           0.0571
    31 blkdev_writepage                           0.8857
    30 inode_times_differ                         0.4412
    30 get_more_blocks                            0.1911
    29 s_show                                     0.0458
    28 scsi_decide_disposition                    0.0875
    28 link_path_walk                             0.0133
    27 sys_nanosleep                              0.1034
    26 show_regs                                  0.0741
    25 wait_on_page_bit                           0.1196
    25 do_setitimer                               0.0529
    25 bio_endio                                  0.2049
    23 vsnprintf                                  0.0201
    23 queue_delayed_work                         0.1655
    23 ipcperms                                   0.1411
    22 do_readv_writev                            0.0316
    21 zap_pte_range                              0.0297
    21 scsi_finish_command                        0.1167
    20 scsi_add_timer                             0.1980
    20 generic_file_aio_write_nolock              0.0068
    19 update_queue                               0.1652
    19 dio_zero_block                             0.1131
    19 blk_queue_bounce                           0.2468
    18 syscall_call                               1.6364
    18 store_msg                                  0.0783
    17 try_atomic_semop                           0.0570
    17 do_wp_page                                 0.0130
    17 buffered_rmqueue                           0.0489
    16 sys_gettimeofday                           0.0812
    16 handle_mm_fault                            0.0329
    15 scsi_free_sgtable                          0.3333
    15 qla2x00_calc_iocbs_64                      0.2542
    15 free_hot_cold_page                         0.0600
    15 flush_tlb_mm                               0.1136
    15 elv_set_request                            0.2586
    14 kmap_atomic_to_page                        0.0921
    14 .text.lock.direct_io                       0.1386
    13 wake_up_process                            0.3095
    13 dio_bio_alloc                              0.1429
    13 default_llseek                             0.0491
    12 scsi_next_command                          0.2927
    12 pid_revalidate                             0.1121
    11 show_cpuinfo                               0.0162
    11 render_sigset_t                            0.0598
    11 dio_bio_reap                               0.0965
    11 __lookup                                   0.0539
    10 proc_pid_status                            0.0090
    10 path_lookup                                0.0299
    10 get_pid_list                               0.0855
     9 free_msg                                   0.1957
     9 clear_page_tables                          0.0201
     9 atomic_dec_and_lock                        0.1385
     9 __pagevec_lru_add_active                   0.0354
     8 local_bh_enable                            0.0597
     8 load_msg                                   0.0193
     8 __wake_up                                  0.1231
     7 vfs_write                                  0.0237
     7 release_pages                              0.0216
     7 pte_alloc_one                              0.0547
     7 pte_alloc_map                              0.0215
     7 kernel_to_ipc64_perm                       0.1296
     7 ipc_unlock                                 0.8750
     7 fput                                       0.3333
     7 copy_process                               0.0027
     6 vfs_readv                                  0.0600
     6 tstojiffie                                 0.0594
     6 sock_alloc_send_pskb                       0.0117
     6 generic_file_readv                         0.0385
     6 end_that_request_chunk                     1.2000
     6 dio_complete                               0.0800
     5 write_profile                              0.0276
     5 sock_wfree                                 0.0658
     5 radix_tree_lookup                          0.0676
     5 pgd_ctor                                   0.1316
     5 page_address                               0.0289
     5 lru_cache_add_active                       0.0602
     5 get_empty_filp                             0.0209
     5 generic_file_write_nolock                  0.0321
     5 filemap_nopage                             0.0054
     5 bad_range                                  0.0442
     4 zap_pmd_range                              0.0342
     4 vma_link                                   0.0244
     4 unix_stream_recvmsg                        0.0029
     4 unix_stream_data_wait                      0.0134
     4 unix_release_sock                          0.0060
     4 unix_create1                               0.0113
     4 tg3_poll                                   0.0137
     4 sync_mapping_buffers                       0.0889
     4 split_vma                                  0.0137
     4 skb_recv_datagram                          0.0169
     4 qla2x00_blink_led                          0.0214
     4 pte_chain_alloc                            0.0625
     4 get_wchan                                  0.0328
     4 generic_osync_inode                        0.0156
     4 follow_page                                0.0095
     4 follow_mount                               0.0286
     4 flush_scheduled_work                       0.4000
     4 elv_put_request                            0.1212
     4 copy_page_range                            0.0030
     4 __pte_chain_free                           0.0455
     4 __get_user_4                               0.1739
     4 __constant_c_and_count_memset              0.0312
     4 .text.lock.time                            0.1212
     3 unix_stream_sendmsg                        0.0030
     3 tcp_v4_rcv                                 0.0013
     3 tcp_sendmsg                                0.0006
     3 sys_llseek                                 0.0118
     3 sys_fstat64                                0.0526
     3 sys_close                                  0.0265
     3 strncpy_from_user                          0.0303
     3 sock_fasync                                0.0052
     3 scsi_init_io                               0.0095
     3 poll_freewait                              0.0469
     3 may_open                                   0.0068
     3 kmap_high                                  0.0065
     3 ipc_buildid                                0.2500
     3 generic_fillattr                           0.0176
     3 fget                                       0.0476
     3 exit_notify                                0.0016
     3 eth_type_trans                             0.0179
     3 dput                                       0.0074
     3 do_poll                                    0.0152
     3 do_mmap_pgoff                              0.0017
     3 dio_cleanup                                0.0195
     3 bdev_read_only                             0.0517
     3 alloc_ldt                                  0.0071
     3 access_process_vm                          0.0065
     3 __mark_inode_dirty                         0.0123
     3 __filemap_copy_from_user_iovec             0.0171
     3 __alloc_pages                              0.0038
     2 wake_up_process_kick                       0.0476
     2 vsprintf                                   0.0465
     2 vfs_writev                                 0.0200
     2 unmap_region                               0.0058
     2 unix_write_space                           0.0142
     2 unix_poll                                  0.0129
     2 unix_find_socket_byinode                   0.0233
     2 sys_stat64                                 0.0351
     2 sys_readv                                  0.0202
     2 sys_open                                   0.0144
     2 sys_clock_nanosleep                        0.0067
     2 ss_wakeup                                  0.0426
     2 sock_poll                                  0.0408
     2 sock_map_fd                                0.0061
     2 set_page_address                           0.0060
     2 remove_suid                                0.0182
     2 remove_shared_vm_struct                    0.0177
     2 release_task                               0.0049
     2 raw_file_aio_write                         0.0345
     2 prepare_to_wait                            0.0222
     2 pid_alive                                  0.0571
     2 normal_poll                                0.0056
     2 mmput                                      0.0120
     2 iput                                       0.0161
     2 ip_rcv                                     0.0017
     2 get_write_access                           0.0351
     2 fn_hash_lookup                             0.0085
     2 eventpoll_init_file                        0.0741
     2 end_that_request_first                     0.2000
     2 do_sync_read                               0.0109
     2 do_aic7xxx_isr                             0.0129
     2 d_alloc                                    0.0044
     2 cp_new_stat64                              0.0075
     2 copy_files                                 0.0030
     2 change_protection                          0.0035
     2 cache_grow                                 0.0025
     2 __block_prepare_write                      0.0019
     2 __blk_queue_bounce                         0.0034
     1 work_resched                               0.0455
     1 wait_for_packet                            0.0031
     1 vm_acct_memory                             0.0185
     1 vfs_permission                             0.0031
     1 vfs_follow_link                            0.0022
     1 unix_stream_connect                        0.0010
     1 unix_peer_get                              0.0238
     1 unix_accept                                0.0033
     1 tg3_rx                                     0.0011
     1 tcp_transmit_skb                           0.0007
     1 tcp_poll                                   0.0026
     1 sys_timer_settime                          0.0012
     1 sys_select                                 0.0007
     1 sys_pwrite64                               0.0079
     1 sys_munmap                                 0.0098
     1 sys_mprotect                               0.0017
     1 sys_getuid                                 0.0625
     1 sys_getdents64                             0.0048
     1 strnlen_user                               0.0147
     1 sock_wmalloc                               0.0106
     1 sock_destroy_inode                         0.0323
     1 sock_def_readable                          0.0079
     1 sock_create                                0.0027
     1 skip_atoi                                  0.0154
     1 skb_clone                                  0.0030
     1 show_interrupts                            0.0014
     1 shm_get_stat                               0.0064
     1 set_huge_pte                               0.0057
     1 scsi_setup_cmd_retry                       0.0093
     1 schedule_timeout                           0.0053
     1 schedule_delayed_work                      0.0714
     1 restore_fpu                                0.0323
     1 recalc_bh_state                            0.0076
     1 rb_insert_color                            0.0044
     1 qla2x00_build_scsi_iocbs_32                0.0018
     1 pty_write                                  0.0024
     1 pty_chars_in_buffer                        0.0137
     1 profile_exit_task                          0.0132
     1 proc_lookup                                0.0037
     1 proc_calc_metrics                          0.0123
     1 prepare_to_wait_exclusive                  0.0112
     1 prep_new_page                              0.0122
     1 pid_fd_revalidate                          0.0051
     1 path_release                               0.0159
     1 parse_table                                0.0034
     1 page_cache_readahead                       0.0026
     1 old_mmap                                   0.0032
     1 nr_running                                 0.0244
     1 notify_change                              0.0026
     1 next_thread                                0.0127
     1 net_rx_action                              0.0039
     1 monotonic_clock_cyclone                    0.0061
     1 mm_init                                    0.0040
     1 math_state_restore                         0.0152
     1 lru_add_drain                              0.0119
     1 locks_remove_posix                         0.0036
     1 load_elf_binary                            0.0003
     1 kobj_lookup                                0.0034
     1 kill_fasync                                0.0169
     1 kill_bdev                                  0.0147
     1 ipc_checkid                                0.0303
     1 invalidate_inode_buffers                   0.0111
     1 inode_init_once                            0.0027
     1 inet_sendmsg                               0.0112
     1 in_group_p                                 0.0222
     1 i_waitq_head                               0.0455
     1 handle_signal                              0.0032
     1 get_unused_fd                              0.0025
     1 get_signal_to_deliver                      0.0012
     1 generic_file_open                          0.0111
     1 flush_tlb_page                             0.0072
     1 find_lock_page                             0.0036
     1 filp_close                                 0.0083
     1 filldir64                                  0.0032
     1 fd_install                                 0.0179
     1 ext2_update_inode                          0.0013
     1 ext2_get_inode                             0.0033
     1 ext2_alloc_block                           0.0050
     1 dup_task_struct                            0.0050
     1 do_sys_settimeofday                        0.0051
     1 do_select                                  0.0014
     1 do_page_cache_readahead                    0.0027
     1 do_flush_tlb_all                           0.0108
     1 disk_round_stats                           0.0047
     1 device_not_available                       0.0244
     1 dev_seq_printf_stats                       0.0044
     1 detach_vmas_to_be_unmapped                 0.0101
     1 destroy_context                            0.0058
     1 dentry_open                                0.0027
     1 dcache_readdir                             0.0021
     1 d_rehash                                   0.0111
     1 d_lookup                                   0.0125
     1 d_instantiate                              0.0111
     1 csum_partial                               0.0035
     1 create_elf_tables                          0.0011
     1 count_semncnt                              0.0091
     1 copy_strings                               0.0016
     1 copy_mm                                    0.0011
     1 check_unthrottle                           0.0164
     1 can_vma_merge_before                       0.0119
     1 cache_init_objs                            0.0085
     1 c_start                                    0.0278
     1 bd_claim                                   0.0172
     1 batch_entropy_process                      0.0047
     1 alloc_skb                                  0.0045
     1 alloc_inode                                0.0030
     1 add_softcursor                             0.0042
     1 __vma_link                                 0.0063
     1 __unix_remove_socket                       0.0084
     1 __tcp_select_window                        0.0040
     1 __posix_lock_file                          0.0007
     1 __kfree_skb                                0.0046
     1 __fput                                     0.0050
     1 __copy_user_zeroing_intel                  0.0058
     1 __block_commit_write                       0.0068
     1 __alloc_percpu                             0.0047
     1 SHATransform                               0.0033
     1 .text.lock.tty_io                          0.0023
     1 .text.lock.read_write                      0.0192
     1 .text.lock.open                            0.0058
     1 .text.lock.dnotify                         0.0233


3b. readprofile for deadline scheduler
171653 total                                      0.0829
 19968 do_softirq                                96.4638
 18055 schedule                                  15.0208
 14925 scsi_request_fn                           21.8202
 11718 qla2x00_start_scsi                        11.7651
  9323 follow_hugetlb_page                       19.5451
  5626 __make_request                             4.6228
  4567 sys_msgsnd                                 6.3519
  4108 poll_idle                                 70.8276
  4070 dio_bio_end_io                            33.9167
  4044 unlock_page                               45.9545
  3882 do_direct_IO                               3.7148
  3690 scsi_end_request                          19.7326
  3577 submit_page_section                        8.3186
  3146 set_page_dirty_lock                       34.5714
  2502 dio_bio_complete                           9.0982
  2313 qla2x00_queuecommand                       1.5842
  2298 dio_bio_add_page                          22.0962
  2230 system_call                               50.6818
  2163 del_timer_sync                            17.1667
  1905 try_to_wake_up                             3.3957
  1782 get_offset_cyclone                        32.4000
  1721 fsync_buffers_list                         4.6640
  1677 get_request                                2.5564
  1658 bio_add_page                               4.8480
  1394 add_timer                                  9.8865
  1181 dio_await_one                              7.5705
  1159 dio_refill_pages                           3.7752
  1121 scsi_dispatch_cmd                          2.9117
  1056 current_kernel_time                       15.3043
   939 bio_alloc                                  2.2791
   884 qla2x00_get_new_sp                         7.9640
   863 direct_io_worker                           0.8180
   858 ipc_lock                                  11.7534
   812 do_no_page                                 0.6470
   802 put_io_context                             9.3256
   798 blkdev_get_blocks                          6.7627
   765 .text.lock.util                           31.8750
   751 max_block                                  6.5304
   717 __generic_file_aio_read                    1.2826
   691 scsi_io_completion                         0.6351
   683 kmem_cache_alloc                           8.8701
   677 scsi_device_unbusy                         5.4160
   658 kfree                                      4.9474
   644 sys_msgrcv                                 0.7204
   624 kmem_cache_free                            7.1724
   610 get_jiffies_64                            10.5172
   582 blk_run_queue                              7.9726
   581 __end_that_request_first                   1.0602
   563 page_add_rmap                              1.4816
   546 find_vma                                   6.7407
   541 dio_send_cur_page                          3.1637
   517 scsi_put_command                           3.6154
   502 generic_unplug_device                      4.7810
   483 blk_run_queues                             3.0764
   471 testmsg                                    6.7286
   471 page_waitqueue                            10.0213
   461 blk_recount_segments                       0.7006
   455 __copy_from_user_ll                        3.7295
   433 default_llseek                             1.6340
   405 get_user_pages                             0.4018
   379 huge_pte_offset                            9.2439
   360 fget_light                                 2.7907
   348 copy_page_range                            0.2632
   337 add_disk_randomness                        6.4808
   301 get_io_context                             2.3333
   301 do_readv_writev                            0.4325
   301 blockdev_direct_IO                         0.8674
   289 do_page_fault                              0.2564
   280 __copy_to_user_ll                          2.3333
   273 sd_rw_intr                                 0.6691
   266 add_timer_randomness                       1.1515
   258 qla2x00_next                               0.2857
   254 mempool_alloc                              0.7720
   239 generic_make_request                       0.5482
   236 update_atime                               1.0631
   235 batch_entropy_store                        1.5260
   231 __kmalloc                                  1.8934
   227 do_gettimeofday                            1.5764
   223 sys_semtimedop                             0.1687
   219 do_wp_page                                 0.1681
   211 get_more_blocks                            1.3439
   208 sys_ipc                                    0.3041
   198 io_schedule                                4.1250
   186 __set_page_dirty_buffers                   0.6263
   183 finished_one_bio                           1.5776
   183 del_timer                                  1.7429
   182 kmap_atomic                                1.1235
   181 find_extend_vma                            1.4365
   180 wait_on_page_bit                           0.8612
   180 generic_file_direct_IO                     1.0345
   180 dio_get_page                               2.0690
   179 dnotify_parent                             1.7379
   178 io_schedule_timeout                        3.4902
   172 generic_file_readv                         1.1026
   158 blkdev_direct_IO                           1.3860
   152 submit_bio                                 0.9935
   146 sys_llseek                                 0.5748
   144 do_anonymous_page                          0.1506
   137 scsi_run_queue                             0.6990
   137 ipcperms                                   0.8405
   134 bio_destructor                             1.4255
   126 do_getitimer                               0.4582
   120 find_get_page                              1.5385
   118 mempool_free                               0.9593
   116 syscall_exit                              10.5455
   113 do_clock_nanosleep                         0.1445
   112 do_setitimer                               0.2368
   108 scsi_softirq                               0.4909
   108 deadline_set_request                       1.1020
   102 store_msg                                  0.4435
   102 scsi_init_cmd_errh                         0.5050
   101 sys_setitimer                              0.3659
    97 proc_pid_stat                              0.0810
    97 dio_bio_submit                             0.9604
    95 page_remove_rmap                           0.1750
    92 bio_put                                    1.7037
    92 __d_lookup                                 0.3345
    88 dio_await_completion                       1.0732
    85 memcpy                                     1.4912
    80 sys_gettimeofday                           0.4061
    79 wake_up_process                            1.8810
    76 blk_queue_bounce                           0.9870
    73 vfs_read                                   0.2475
    72 pte_alloc_one                              0.5625
    69 load_msg                                   0.1663
    68 task_mem                                   0.2656
    68 scsi_decide_disposition                    0.2125
    65 bio_get_nr_vecs                            1.2264
    64 number                                     0.0852
    63 mempool_alloc_slab                         3.0000
    61 zap_pte_range                              0.0863
    60 handle_mm_fault                            0.1235
    60 dio_new_bio                                0.4762
    58 adjust_abs_time                            0.2035
    57 .text.lock.direct_io                       0.5644
    56 sys_readv                                  0.5657
    54 scsi_finish_command                        0.3000
    53 blkdev_writepage                           1.5143
    52 huge_page_release                          1.2381
    50 vsnprintf                                  0.0436
    49 scsi_next_command                          1.1951
    48 try_atomic_semop                           0.1611
    46 syscall_call                               4.1818
    46 scsi_add_timer                             0.4554
    44 vfs_readv                                  0.4400
    44 inode_times_differ                         0.6471
    43 sys_select                                 0.0318
    42 sys_nanosleep                              0.1609
    42 elv_set_request                            0.7241
    41 find_lock_page                             0.1475
    40 generic_file_read                          0.2326
    39 __copy_user_intel                          0.2267
    37 buffered_rmqueue                           0.1063
    36 update_queue                               0.3130
    36 sys_pread64                                0.2835
    36 radix_tree_lookup                          0.4865
    36 link_path_walk                             0.0171
    36 do_select                                  0.0495
    35 work_resched                               1.5909
    35 qla2x00_calc_iocbs_64                      0.5932
    35 device_not_available                       0.8537
    33 s_show                                     0.0521
    32 dio_bio_alloc                              0.3516
    30 pte_chain_alloc                            0.4688
    28 free_msg                                   0.6087
    27 kmap_atomic_to_page                        0.1776
    27 bio_endio                                  0.2213
    26 free_hot_cold_page                         0.1040
    26 __lookup                                   0.1275
    24 release_pages                              0.0741
    24 pte_alloc_map                              0.0738
    24 flush_tlb_mm                               0.1818
    24 __pte_chain_free                           0.2727
    23 mempool_free_slab                          1.0952
    23 generic_file_aio_write_nolock              0.0078
    23 filemap_nopage                             0.0249
    23 dio_zero_block                             0.1369
    22 ipc_unlock                                 2.7500
    22 dio_complete                               0.2933
    21 tstojiffie                                 0.2079
    20 fget                                       0.3175
    20 clear_page_tables                          0.0446
    20 __alloc_pages                              0.0255
    19 set_huge_pte                               0.1092
    18 dio_bio_reap                               0.1579
    18 bad_range                                  0.1593
    18 __wake_up                                  0.2769
    17 shmem_getpage                              0.0062
    17 fput                                       0.8095
    17 find_vma_prev                              0.2099
    16 local_bh_enable                            0.1194
    16 kstat_read_proc                            0.0175
    16 end_that_request_chunk                     3.2000
    16 copy_files                                 0.0237
    15 queue_delayed_work                         0.1079
    15 pid_revalidate                             0.1402
    15 may_open                                   0.0339
    14 tcp_poll                                   0.0365
    14 scsi_free_sgtable                          0.3111
    14 render_sigset_t                            0.0761
    14 cache_grow                                 0.0175
    14 __pagevec_lru_add_active                   0.0551
    13 shmem_nopage                               0.1204
    13 math_state_restore                         0.1970
    13 copy_mm                                    0.0140
    13 .text.lock.time                            0.3939
    12 pid_alive                                  0.3429
    12 hugetlb_prefault                           0.0327
    12 atomic_dec_and_lock                        0.1846
    11 get_unused_fd                              0.0279
    11 get_pid_list                               0.0940
    11 generic_file_write_nolock                  0.0705
    11 cpu_idle                                   0.1719
    11 __get_user_4                               0.4783
    10 show_interrupts                            0.0136
    10 remove_shared_vm_struct                    0.0885
    10 ipc_checkid                                0.3030
    10 end_that_request_first                     1.0000
     9 vfs_write                                  0.0305
     9 sock_poll                                  0.1837
     9 restore_fpu                                0.2903
     9 qla2x00_build_scsi_iocbs_32                0.0161
     9 generic_osync_inode                        0.0350
     9 d_alloc                                    0.0199
     9 __posix_lock_file                          0.0060
     9 __mark_inode_dirty                         0.0370
     8 sys_close                                  0.0708
     8 strncpy_from_user                          0.0808
     8 qla2x00_blink_led                          0.0428
     8 proc_pid_status                            0.0072
     8 kernel_to_ipc64_perm                       0.1481
     8 ipc_parse_version                          0.2759
     8 flush_scheduled_work                       0.8000
     7 unmap_hugepage_range                       0.0281
     7 schedule_delayed_work                      0.5000
     7 poll_freewait                              0.1094
     7 nr_blockdev_pages                          0.0700
     7 free_pages                                 0.0909
     7 do_sys_settimeofday                        0.0354
     7 copy_process                               0.0027
     7 bdev_read_only                             0.1207
     7 __alloc_percpu                             0.0327
     6 write_profile                              0.0331
     6 vfs_writev                                 0.0600
     6 unix_write_space                           0.0426
     6 sys_shmat                                  0.0083
     6 ss_wakeup                                  0.1277
     6 pgd_ctor                                   0.1579
     6 mark_page_accessed                         0.1154
     6 lru_cache_add_active                       0.0723
     6 ipc_buildid                                0.5000
     6 flush_tlb_page                             0.0432
     6 do_sigaction                               0.0095
     6 do_mmap_pgoff                              0.0034
     6 dio_cleanup                                0.0390
     6 cp_new_stat64                              0.0226
     5 unmap_vmas                                 0.0069
     5 unix_stream_recvmsg                        0.0036
     5 sys_open                                   0.0360
     5 schedule_timeout                           0.0267
     5 path_lookup                                0.0150
     5 locks_remove_posix                         0.0182
     5 do_aic7xxx_isr                             0.0323
     5 chrdev_open                                0.0121
     5 access_process_vm                          0.0108
     5 __pollwait                                 0.0254
     5 __free_pages                               0.0694
     4 unix_stream_data_wait                      0.0134
     4 unix_release_sock                          0.0060
     4 tg3_rx                                     0.0043
     4 show_cpuinfo                               0.0059
     4 setup_sigcontext                           0.0135
     4 setup_rt_frame                             0.0059
     4 remove_wait_queue                          0.0541
     4 proc_lookup                                0.0148
     4 prep_new_page                              0.0488
     4 page_cache_readahead                       0.0105
     4 notify_change                              0.0102
     4 new_inode                                  0.0345
     4 max_select_fd                              0.0177
     4 kill_bdev                                  0.0588
     4 ip_route_input_slow                        0.0018
     4 get_empty_filp                             0.0167
     4 eventpoll_init_file                        0.1481
     4 dput                                       0.0099
     4 do_generic_mapping_read                    0.0031
     4 alloc_skb                                  0.0179
     4 __constant_c_and_count_memset              0.0312
     3 wake_up_process_kick                       0.0714
     3 unix_stream_sendmsg                        0.0030
     3 unix_poll                                  0.0194
     3 tg3_poll                                   0.0103
     3 sys_pwrite64                               0.0236
     3 split_vma                                  0.0103
     3 sock_map_fd                                0.0091
     3 sock_alloc_send_pskb                       0.0059
     3 sigprocmask                                0.0142
     3 scsi_init_io                               0.0095
     3 page_address                               0.0173
     3 open_namei                                 0.0029
     3 lru_add_drain                              0.0357
     3 kmap_high                                  0.0065
     3 hugetlbfs_statfs                           0.0370
     3 generic_fillattr                           0.0176
     3 follow_mount                               0.0214
     3 find_vma_prepare                           0.0297
     3 file_move                                  0.0526
     3 file_kill                                  0.0682
     3 fd_install                                 0.0536
     3 exit_notify                                0.0016
     3 dup_task_struct                            0.0149
     3 do_settimeofday                            0.0099
     3 do_munmap                                  0.0071
     3 disk_stats_read                            0.0041
     3 count_semncnt                              0.0273
     3 calc_crc_errors                            0.0155
     3 alloc_inode                                0.0090
     3 __get_free_pages                           0.0303
     3 __fput                                     0.0151
     3 __copy_user_zeroing_intel                  0.0174
     3 __blk_queue_bounce                         0.0052
     3 .text.lock.read_write                      0.0577
     2 wait_for_packet                            0.0062
     2 vma_link                                   0.0122
     2 vm_acct_memory                             0.0370
     2 unmap_region                               0.0058
     2 unix_accept                                0.0066
     2 task_prio                                  0.1429
     2 sys_fstat64                                0.0351
     2 sys_connect                                0.0113
     2 sys_brk                                    0.0073
     2 sys_alarm                                  0.0241
     2 sys_accept                                 0.0063
     2 sync_mapping_buffers                       0.0444
     2 sock_def_readable                          0.0157
     2 skb_recv_datagram                          0.0084
     2 shmem_swp_alloc                            0.0032
     2 set_page_address                           0.0060
     2 seq_read                                   0.0027
     2 schedule_tail                              0.0130
     2 proc_pident_lookup                         0.0037
     2 old_mmap                                   0.0063
     2 nr_free_pages                              0.0290
     2 memcpy_fromiovec                           0.0118
     2 lookup_mnt                                 0.0192
     2 locks_remove_flock                         0.0103
     2 load_elf_binary                            0.0007
     2 kunmap_atomic                              0.1667
     2 kobj_lookup                                0.0069
     2 kfree_skbmem                               0.0455
     2 invalidate_vcache                          0.0139
     2 init_new_context                           0.0085
     2 get_signal_to_deliver                      0.0024
     2 free_pages_and_swap_cache                  0.0153
     2 fn_hash_lookup                             0.0085
     2 filp_close                                 0.0165
     2 file_read_actor                            0.0085
     2 ext2_get_inode                             0.0066
     2 eligible_child                             0.0114
     2 elf_map                                    0.0107
     2 do_sync_read                               0.0109
     2 do_lookup                                  0.0124
     2 do_irq_balance                             0.0019
     2 dnotify_flush                              0.0128
     2 dentry_open                                0.0053
     2 create_elf_tables                          0.0022
     2 copy_strings                               0.0031
     2 convert_fxsr_to_user                       0.0057
     2 change_protection                          0.0035
     2 bounce_copy_vec                            0.0175
     2 alloc_ldt                                  0.0047
     2 add_wait_queue                             0.0286
     2 __user_walk                                0.0213
     2 __bio_map_user                             0.0030
     1 yield                                      0.0455
     1 wake_up_inode                              0.0156
     1 vsscanf                                    0.0008
     1 vgacon_cursor                              0.0024
     1 vfs_stat                                   0.0110
     1 vfs_permission                             0.0031
     1 vfs_fstat                                  0.0125
     1 unix_stream_connect                        0.0010
     1 unix_sock_destructor                       0.0036
     1 unix_peer_get                              0.0238
     1 uart_wait_until_sent                       0.0045
     1 sys_write                                  0.0101
     1 sys_wait4                                  0.0016
     1 sys_socketcall                             0.0015
     1 sys_shmdt                                  0.0030
     1 sys_rt_sigreturn                           0.0032
     1 sys_read                                   0.0101
     1 sys_mmap2                                  0.0059
     1 sys_ioctl                                  0.0016
     1 sys_dup2                                   0.0044
     1 sys_clock_nanosleep                        0.0034
     1 sys_access                                 0.0030
     1 sync_sb_inodes                             0.0017
     1 supplemental_group_member                  0.0204
     1 submit_bh                                  0.0029
     1 sockfd_lookup                              0.0084
     1 sock_wfree                                 0.0132
     1 sock_init_data                             0.0030
     1 sock_destroy_inode                         0.0323
     1 sock_create                                0.0027
     1 sock_alloc_send_skb                        0.0196
     1 sock_alloc                                 0.0106
     1 skip_atoi                                  0.0154
     1 skb_release_data                           0.0045
     1 skb_free_datagram                          0.0256
     1 shm_open                                   0.0111
     1 shm_get_stat                               0.0064
     1 shm_close                                  0.0063
     1 serial_in                                  0.0156
     1 seq_printf                                 0.0116
     1 sched_migrate_task                         0.0127
     1 save_i387_fxsave                           0.0050
     1 save_i387                                  0.0055
     1 s_start                                    0.0024
     1 run_timer_softirq                          0.0026
     1 restore_i387                               0.0079
     1 reserve_blocks                             0.0055
     1 release_task                               0.0024
     1 rb_insert_color                            0.0044
     1 rb_erase                                   0.0044
     1 raw_release                                0.0069
     1 raw_open                                   0.0033
     1 proc_readdir                               0.0022
     1 proc_info_read                             0.0029
     1 proc_destroy_inode                         0.0323
     1 prepare_binprm                             0.0044
     1 prep_compound_page                         0.0185
     1 posix_locks_conflict                       0.0058
     1 pipe_read                                  0.0017
     1 path_release                               0.0159
     1 netif_receive_skb                          0.0022
     1 mpage_writepages                           0.0014
     1 move_addr_to_kernel                        0.0069
     1 monotonic_clock_cyclone                    0.0061
     1 mmput                                      0.0060
     1 mm_init                                    0.0040
     1 meminfo_read_proc                          0.0020
     1 locks_insert_lock                          0.0143
     1 locks_conflict                             0.0323
     1 load_elf_interp                            0.0017
     1 lease_alloc                                0.0044
     1 kmap                                       0.0455
     1 ipc_addid                                  0.0058
     1 inode_update_time                          0.0059
     1 huge_pte_alloc                             0.0244
     1 hash_vcache                                0.0400
     1 handle_signal                              0.0032
     1 handle_IRQ_event                           0.0100
     1 get_zeroed_page                            0.0082
     1 get_wchan                                  0.0082
     1 get_unmapped_area                          0.0029
     1 generic_forget_inode                       0.0033
     1 follow_page                                0.0024
     1 flush_signal_handlers                      0.0149
     1 flush_old_exec                             0.0005
     1 flush_all_zero_pkmaps                      0.0056
     1 finish_wait                                0.0111
     1 find_task_by_pid                           0.0130
     1 find_group_orlov                           0.0012
     1 find_busiest_node                          0.0015
     1 filldir64                                  0.0032
     1 file_ra_state_init                         0.0312
     1 fcntl_setlk                                0.0014
     1 fasync_helper                              0.0043
     1 ext2_new_block                             0.0007
     1 ext2_free_blocks                           0.0014
     1 ext2_find_entry                            0.0015
     1 ext2_block_to_path                         0.0031
     1 ext2_alloc_branch                          0.0019
     1 ext2_add_link                              0.0009
     1 exit_thread                                0.0185
     1 error_code                                 0.0179
     1 end_buffer_async_write                     0.0051
     1 elv_put_request                            0.0303
     1 do_sync_write                              0.0055
     1 do_signal                                  0.0038
     1 do_sigaltstack                             0.0028
     1 do_rw_proc                                 0.0062
     1 do_pollfd                                  0.0069
     1 do_poll                                    0.0051
     1 destroy_inode                              0.0125
     1 destroy_context                            0.0058
     1 deny_write_access                          0.0159
     1 default_idle                               0.0222
     1 dcache_readdir                             0.0021
     1 d_rehash                                   0.0111
     1 copy_siginfo_to_user                       0.0025
     1 con_write_room                             0.0370
     1 complete                                   0.0123
     1 cap_vm_enough_memory                       0.0053
     1 cap_task_post_setuid                       0.0034
     1 can_vma_merge_after                        0.0109
     1 can_share_swap_page                        0.0097
     1 call_rcu                                   0.0192
     1 batch_entropy_process                      0.0047
     1 assign_type                                0.0417
     1 alloc_buffer_head                          0.0135
     1 __vma_link                                 0.0063
     1 __unix_insert_socket                       0.0109
     1 __rb_erase_color                           0.0024
     1 __pagevec_lru_add                          0.0048
     1 __kfree_skb                                0.0046
     1 __find_get_block_slow                      0.0029
     1 __filemap_copy_from_user_iovec             0.0057
     1 SHATransform                               0.0033
     1 .text.lock.swap                            0.0103
     1 .text.lock.file_table                      0.0092



Mike Sullivan

