Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVAMTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVAMTKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAMTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:10:08 -0500
Received: from 67.104.112.69.ptr.us.xo.net ([67.104.112.69]:46280 "EHLO
	migcom.com") by vger.kernel.org with ESMTP id S261246AbVAMTFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:05:17 -0500
Message-ID: <41E6C590.2000503@zanfx.com>
Date: Thu, 13 Jan 2005 11:01:36 -0800
From: "Paul A. Sumner" <paul@zanfx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050101
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>
Subject: Re: High write latency, iowait, slow writes 2.6.9
References: <41E4BB99.90908@zanfx.com> <cs44ai$oet$1@news.cistron.nl> <41E61C68.10801@zanfx.com> <20050113085633.GE2815@suse.de>
In-Reply-To: <20050113085633.GE2815@suse.de>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000405040003010502010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000405040003010502010207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks much. I still seem to be getting latency, etc. w/ 2.6.11 rc1 bk 
w/ the patch... Here you go (vmstat.log is a little long).

Jens Axboe wrote:
> On Wed, Jan 12 2005, Paul A. Sumner wrote:
> 
>>Thanks... I've tried the as, deadline and cfq schedulers. Deadline is
>>giving me the best results. I've also tried tweaking the stuff in
>>/sys/block/sda/queue/iosched/.
>>
>>For lack of a better way of describing it, it seems like something is
>>thrashing.
> 
> 
> I you have time, I would like you to try current BK with this patch:
> 
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.11-rc1/cfq-time-slices-20.gz
> 
> You should enable CONFIG_IOPRIO_WRITE, it is in the io scheduler config
> section, if you do a make oldconfig it should pop up for you. Boot with
> elevator=cfq to select cfq.
> 
> A simple profile of the bad period would also be nice, along with
> vmstat 1 info from that period. If you boot with profile=2, do:
> 
> # readprofile -r
> # run bad workload
> # readprofile | sort -nr +2 > result_file
> 
> And send that along with the logged vmstat 1 from that same period.
> 
> Oh, and lastly, remember to CC people on lkml when you respond, thanks.
> 

--------------000405040003010502010207
Content-Type: text/plain;
 name="nohup.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nohup.out"

+ uname -a
Linux taz 2.6.11-rc1-bk1 #1 SMP Thu Jan 13 09:11:26 PST 2005 x86_64 AMD Opteron(tm) Processor 250 AuthenticAMD GNU/Linux
+ grep MemTotal /proc/meminfo
MemTotal:     16126744 kB
+ dmesg
+ grep Bootdata
Bootdata ok (command line is root=/dev/ram0 init=/linuxrc ramdisk=8192 real_root=/dev/sda3 console=tty0 console=ttyS0,115200n8 elevator=cfq profile=2 gentoo=udev)
+ readprofile -r
+ vmstat 1
+ tiotest -d /data/scratch -f 8192
Tiotest results for 4 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       32768 MBs |  484.3 s |  67.662 MB/s |   0.8 %  |  12.9 % |
| Random Write   16 MBs |    3.2 s |   4.913 MB/s |   0.1 %  |   1.6 % |
| Read        32768 MBs |  155.1 s | 211.207 MB/s |   1.5 %  |  22.9 % |
| Random Read    16 MBs |    8.7 s |   1.795 MB/s |   0.1 %  |   0.3 % |
`----------------------------------------------------------------------'
Tiotest latency results:
,-------------------------------------------------------------------------.
| Item         | Average latency | Maximum latency | % >2 sec | % >10 sec |
+--------------+-----------------+-----------------+----------+-----------+
| Write        |        0.152 ms |   178448.837 ms |  0.00032 |   0.00015 |
| Random Write |        0.007 ms |        6.228 ms |  0.00000 |   0.00000 |
| Read         |        0.073 ms |      363.501 ms |  0.00000 |   0.00000 |
| Random Read  |        8.515 ms |      270.383 ms |  0.00000 |   0.00000 |
|--------------+-----------------+-----------------+----------+-----------|
| Total        |        0.115 ms |   178448.837 ms |  0.00016 |   0.00008 |
`--------------+-----------------+-----------------+----------+-----------'

+ pkill vmstat
+ readprofile
+ sort -nr +2
./lkml.sh: line 10:  8599 Terminated              vmstat 1 >vmstat.log

--------------000405040003010502010207
Content-Type: text/plain;
 name="result_file"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="result_file"

1171085 default_idle                             24397.6042
 34154 copy_user_generic_c                      898.7895
  1160 __wake_up_bit                             24.1667
  2697 find_get_page                             21.0703
  2122 find_trylock_page                         18.9464
  1755 kmem_cache_free                           18.2812
    85 ret_from_sys_call                         17.0000
  1072 kmem_cache_alloc                          16.7500
  3659 add_to_page_cache                         15.2458
   842 unlock_page                               13.1562
   201 xfs_bmap                                  12.5625
  1061 page_waitqueue                            11.0521
   990 truncate_complete_page                    10.3125
  1713 fget_light                                 9.7330
  2246 end_buffer_async_write                     9.3583
   562 bio_put                                    8.7812
   259 mark_buffer_async_write                    8.0938
  1896 test_clear_page_dirty                      7.9000
  1876 test_clear_page_writeback                  7.3281
   569 current_kernel_time                        7.1125
   565 end_page_writeback                         7.0625
    99 xfs_size_fn                                6.1875
   295 bio_add_page                               6.1458
   191 fput                                       5.9688
  1043 __smp_call_function                        5.9261
  1040 find_lock_page                             5.9091
   740 mpage_end_io_read                          5.7812
  1102 dnotify_parent                             5.7396
  1783 __set_page_dirty_nobuffers                 5.5719
  1277 __pagevec_lru_add                          5.3208
  1575 free_hot_cold_page                         5.1809
  1625 test_set_page_writeback                    5.0781
   792 xfs_map_at_offset                          4.9500
   150 xfs_bmbt_get_startoff                      4.6875
   574 system_call                                4.3817
   138 linvfs_prepare_write                       4.3125
   412 xfs_trans_unlocked_item                    4.2917
   671 create_empty_buffers                       4.1937
   577 xfs_count_page_state                       4.0069
  5929 __make_request                             3.9845
   940 __do_softirq                               3.9167
   605 __down_write                               3.7812
  3015 buffered_rmqueue                           3.7687
   230 mark_page_accessed                         3.5938
   333 generic_commit_write                       3.4688
   485 finish_task_switch                         3.3681
   604 memset                                     3.2128
   599 __block_commit_write                       3.1198
   136 mark_buffer_dirty                          2.8333
    43 xfs_bmbt_get_blockcount                    2.6875
   414 put_page                                   2.5875
    39 mempool_alloc_slab                         2.4375
  2605 scsi_request_fn                            2.3943
  1138 linvfs_get_block_core                      2.3708
   354 __down_read                                2.2987
   434 try_to_free_buffers                        2.2604
    35 mempool_free_slab                          2.1875
   675 __find_get_block_slow                      2.1094
   364 alloc_page_buffers                         2.0682
   129 end_bio_bh_io_sync                         2.0156
   313 alloc_pages_current                        1.9563
   480 scsi_end_request                           1.8750
   298 mempool_free                               1.8625
   551 __up_write                                 1.8125
   290 find_get_pages                             1.8125
   737 mempool_alloc                              1.7716
   170 set_bh_page                                1.7708
   140 free_buffer_head                           1.7500
   275 xfs_iunlock                                1.7188
   546 vfs_write                                  1.7063
   190 linvfs_write                               1.6964
   539 vfs_read                                   1.6844
   160 bad_range                                  1.6667
   260 __up_read                                  1.6250
   544 submit_bh                                  1.6190
   714 __mark_inode_dirty                         1.5938
   250 update_atime                               1.5625
    75 block_prepare_write                        1.5625
   146 current_fs_time                            1.5208
   170 xfs_mod_incore_sb                          1.5179
   213 sys_write                                  1.4792
   496 xfs_ichgtime                               1.4762
   233 drop_buffers                               1.4563
    23 xfs_extent_state                           1.4375
  6439 shrink_zone                                1.4271
   815 __end_that_request_first                   1.4149
   225 radix_tree_preload                         1.4062
   244 xfs_ilock                                  1.3864
   664 __bio_add_page                             1.3833
   796 generic_make_request                       1.3819
    44 linvfs_get_blocks_direct                   1.3750
   401 xfs_submit_page                            1.3191
   839 __do_page_cache_readahead                  1.2790
   225 zone_watermark_ok                          1.2784
   142 xfs_bmap_worst_indlen                      1.2679
   634 scsi_dispatch_cmd                          1.2008
   518 bio_alloc                                  1.1562
    73 alloc_buffer_head                          1.1406
   359 submit_bio                                 1.1219
   465 release_pages                              1.1178
    87 smp_call_function_all_cpus                 1.0875
   240 do_sync_write                              1.0714
    51 xfs_ilock_map_shared                       1.0625
    34 xfs_bmbt_get_state                         1.0625
   935 __alloc_pages                              1.0435
   131 bio_endio                                  1.0234
    32 linvfs_get_block                           1.0000
   156 __pagevec_release_nonlru                   0.9750
   684 xfs_read                                   0.9716
    45 __pagevec_free                             0.9375
    15 set_page_refs                              0.9375
    74 bio_destructor                             0.9250
  1149 generic_file_buffered_write                0.9207
   103 linvfs_read                                0.9196
   102 smp_call_function                          0.9107
   301 page_referenced                            0.8958
   269 mpage_readpages                            0.8849
   181 inode_update_time                          0.8702
  1073 xfs_iomap                                  0.8489
   271 file_read_actor                            0.8469
   119 zonelist_policy                            0.8264
   178 linvfs_release_page                        0.7946
    25 xfs_bmbt_get_startblock                    0.7812
   172 __cache_shrink                             0.7679
    61 flat_send_IPI_allbutself                   0.7625
   164 do_sync_read                               0.7321
   635 xfs_bmap_do_search_extents                 0.7216
    33 xfs_inode_shake                            0.6875
   218 shrink_slab                                0.6813
    75 cond_resched                               0.6696
   259 generic_write_checks                       0.6475
    23 init_buffer_head                           0.6389
   254 balance_dirty_pages_ratelimited            0.6350
    10 xfs_ail_min                                0.6250
   137 xfs_bmap_search_extents                    0.6116
    87 sys_read                                   0.6042
  1565 xfs_write                                  0.6038
   572 do_mpage_readpage                          0.5958
    33 do_softirq_thunk                           0.5690
    45 try_to_release_page                        0.5625
   320 xfs_convert_page                           0.5556
    62 put_io_context                             0.5536
    26 xfs_rwunlock                               0.5417
   932 xfs_page_state_convert                     0.5295
     8 fs_noerr                                   0.5000
   480 __block_prepare_write                      0.4839
    37 timespec_trunc                             0.4625
   551 do_generic_mapping_read                    0.4592
    44 cpu_idle                                   0.4583
    60 get_io_context                             0.4167
   237 try_to_wake_up                             0.4115
    52 __read_page_state                          0.4062
    24 io_schedule                                0.3750
1301831 total                                      0.3712
   231 get_request                                0.3208
    15 xfs_offset_to_map                          0.3125
    10 scsi_next_command                          0.3125
     5 free_hot_page                              0.3125
   175 blk_recount_segments                       0.2878
    18 unmap_underlying_metadata                  0.2812
    49 wakeup_kswapd                              0.2784
    22 __down_read_trylock                        0.2292
    11 elv_set_request                            0.2292
    21 blockable_page_cache_readahead             0.2188
    37 wait_on_page_bit                           0.2102
   140 blk_queue_bounce                           0.2083
    96 __generic_file_aio_read                    0.2000
    48 scsi_put_command                           0.2000
    30 do_page_cache_readahead                    0.1875
     3 xfs_iunlock_map_shared                     0.1875
  1482 xfs_bmapi                                  0.1856
    34 scsi_finish_command                        0.1771
    34 recalc_bh_state                            0.1771
    48 get_request_wait                           0.1765
    14 sysret_check                               0.1687
     8 add_disk_randomness                        0.1667
    93 truncate_inode_pages                       0.1571
    10 wake_up_bit                                0.1562
     7 scsi_free_sgtable                          0.1458
    20 task_rq_lock                               0.1389
    17 kref_put                                   0.1328
    61 xfs_mod_incore_sb_unlocked                 0.1271
    95 page_cache_readahead                       0.1263
    16 thread_return                              0.1250
    10 xfs_bmbt_get_all                           0.1250
     8 xfs_bmap_cancel                            0.1250
     4 xfs_bmbt_set_blockcount                    0.1250
     4 sched_clock                                0.1250
     2 pagebuf_ispin                              0.1250
     9 shrink_dcache_memory                       0.1125
     7 bio_get_nr_vecs                            0.1094
    36 __mod_timer                                0.1071
   164 cfq_set_request                            0.1068
     5 pagebuf_daemon_wakeup                      0.1042
     5 kmem_cache_shrink                          0.1042
     8 lru_add_drain                              0.1000
     8 block_sync_page                            0.1000
    37 mb_cache_shrink_fn                         0.0964
     3 put_device                                 0.0938
     3 handle_ra_miss                             0.0938
     7 xfs_trans_tail_ail                         0.0875
    20 scsi_softirq                               0.0833
     9 remove_from_page_cache                     0.0804
    88 cache_grow                                 0.0797
    41 pagebuf_daemon                             0.0777
    11 finish_wait                                0.0764
    13 memcpy                                     0.0739
   111 xfs_iomap_write_delay                      0.0738
    21 copy_user_generic                          0.0705
    10 scsi_device_unbusy                         0.0694
    30 __bitmap_weight                            0.0670
     9 scsi_add_timer                             0.0625
     7 alloc_io_context                           0.0625
     3 mpage_bio_submit                           0.0625
     2 blk_backing_dev_unplug                     0.0625
     1 xfs_trans_find_item                        0.0625
    20 xfs_log_move_tail                          0.0595
     8 del_timer                                  0.0556
     7 prepare_to_wait_exclusive                  0.0547
    52 scsi_io_completion                         0.0524
    10 __clear_page_dirty                         0.0521
     9 xfs_bmap_eof                               0.0511
     4 get_next_ra_size                           0.0500
     6 .text.lock.buffer                          0.0484
     2 xfs_bmbt_set_startblock                    0.0417
     2 __pagevec_release                          0.0417
    49 kswapd                                     0.0414
    22 add_timer_randomness                       0.0382
    16 scsi_run_queue                             0.0345
     3 __get_free_pages                           0.0312
     2 ioc_set_batching                           0.0312
     1 linvfs_readpages                           0.0312
     1 kobject_put                                0.0312
     1 retint_careful                             0.0303
     9 scsi_decide_disposition                    0.0281
    44 schedule                                   0.0264
     1 del_singleshot_timer_sync                  0.0208
     4 schedule_timeout                           0.0192
     4 find_get_pages_tag                         0.0192
     4 generic_file_direct_IO                     0.0179
     2 percpu_counter_mod                         0.0179
     2 __wake_up                                  0.0179
    12 xfs_map_unwritten                          0.0163
     2 __wait_on_bit_lock                         0.0156
     4 generic_cont_expand                        0.0139
     2 mpage_alloc                                0.0125
     1 sync_page                                  0.0125
     2 background_writeout                        0.0114
     3 profile_hit                                0.0094
     1 schedule_tail                              0.0089
     1 journal_unfile_buffer                      0.0089
     1 end_buffer_write_sync                      0.0089
    40 xfs_bmap_add_extent                        0.0078
     6 shrink_icache_memory                       0.0078
     2 linvfs_writepage                           0.0078
     2 get_dirty_limits                           0.0078
     1 sys_lseek                                  0.0078
     1 clear_page_dirty_for_io                    0.0078
     1 __wait_on_bit                              0.0078
     4 sd_rw_intr                                 0.0074
     3 prune_dcache                               0.0063
     1 lookup_mnt                                 0.0063
     1 devfs_d_iput                               0.0063
     1 sched_fork                                 0.0057
     1 __lock_page                                0.0057
     1 xfs_mod_incore_sb_batch                    0.0048
     1 kfree                                      0.0045
     1 writeback_inodes                           0.0042
     1 ext3_get_branch                            0.0042
     1 __sched_text_start                         0.0037
     2 try_to_free_pages                          0.0036
     1 release_task                               0.0027
     1 journal_write_revoke_records               0.0026
     2 __generic_file_aio_write_nolock            0.0022
     1 page_referenced_one                        0.0021
     1 __getblk_slow                              0.0018
     1 journal_stop                               0.0016
     1 xfs_getattr                                0.0015
     1 __journal_file_buffer                      0.0014
     1 do_wp_page                                 0.0010
     1 start_this_handle                          0.0009
     1 clear_page_range                           0.0009
     1 copy_page_range                            0.0007
     1 journal_commit_transaction                 0.0002

--------------000405040003010502010207
Content-Type: application/gzip;
 name="vmstat.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vmstat.log.gz"

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
V0e75AAA
--------------000405040003010502010207--
