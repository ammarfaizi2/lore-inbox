Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUDBIXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDBIXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:23:07 -0500
Received: from A88c0.a.pppool.de ([213.6.136.192]:13952 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S263360AbUDBIV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:21:57 -0500
Message-ID: <406D21F6.8080005@A88c0.a.pppool.de>
Date: Fri, 02 Apr 2004 10:19:02 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>	 <20040328200710.66a4ae1a.akpm@osdl.org>	 <4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de> <1080570227.20685.93.camel@watt.suse.com>
In-Reply-To: <1080570227.20685.93.camel@watt.suse.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> On Mon, 2004-03-29 at 01:16, Andreas Hartmann wrote:
>> Andrew Morton wrote:
>> > Andreas Hartmann <andihartmann@freenet.de> wrote:
>> >>
>> >> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
>> >>  kernel 2.6 seems to be slower than 2.4.25.
>> >> 
>> >>  So I did some tests to compare the performance directly. Therefore I
>> >>  rebooted for everey test in init 2 (no X).
>> >> 
>> >>  I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
>> >>  reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
>> >>  the following result:
>> >> 
>> >>  In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
>> >>  under 2.4.25.
>> >>  The user-processortime is about the same, but the system-processortime is
>> >>  under 2.6.4 32.9% higher than under 2.4.25.
>> > 
>> > Try mounting your reiserfs filesystems with the `-o nolargeio=1' option.
>> 
>> This didn't help.
>> 
>> > 
>> > If that doesn't help, please run a comparative kernel profile.  See
>> > Documentation/basic_profiling.txt.
>> 
>> I'll do this next.
> 
> You might also want to try 2.6.5-rc2 which has a set of reiserfs fixes
> from 2.4.x.  I'm hoping those will clean things up for you.
> 
> 2.6.5-rc2-mm3 and higher have a number of other reiserfs performance
> fixes, but most of those were not in 2.4.  Trying them out will
> complicate the picture (although I'm still interested in numbers from
> -mm).

Now, I tested 2.6.5-rc3-mm4. Same procedure.
The good news first:
2.6.5-rc3-mm4 is nearly as fast as 2.4.25 - it is about 2% slower than 
2.4.25 (with preemption turned on).

Now the bad news:
The system-processor-time is unchanged abnormal high: it is 34% (!) higher 
than in 2.4.25 (and about 1% more than in 2.4.6).


Btw: Did the other profile outputs help to find the problem?

These are the profile-values for an example run (make of kernel 2.6.5rc2) 
with 2.6.5rc3mm4:

48344 default_idle                             1007.1667
      2 cpu_idle                                   0.0312
      1 exit_thread                                0.0156
      2 flush_thread                               0.0156
      2 release_thread                             0.0250
      2 prepare_to_copy                            0.0156
      2 sys_fork                                   0.0312
      1 sys_vfork                                  0.0156
      4 sys_execve                                 0.0312
      1 __down                                     0.0035
      3 sys_sigreturn                              0.0134
      1 setup_sigcontext                           0.0033
      7 setup_frame                                0.0141
      2 handle_signal                              0.0078
      3 do_signal                                  0.0099
     10 handle_IRQ_event                           0.0893
      4 release_x86_irqs                           0.0312
      7 init_new_context                           0.0199
      1 destroy_context                            0.0125
      3 do_gettimeofday                            0.0170
    143 old_mmap                                   0.3724
    213 kernel_fpu_begin                           3.3281
      2 convert_fxsr_to_user                       0.0048
      2 convert_fxsr_from_user                     0.0060
      3 save_i387                                  0.0110
      3 sched_clock                                0.0208
     36 delay_pmtmr                                1.1250
     10 get_offset_pmtmr                           0.0046
      3 pte_alloc_one                              0.0375
      2 pgd_alloc                                  0.0625
      2 pgd_free                                   0.0312
   2289 do_page_fault                              1.7211
      1 try_to_wake_up                             0.0052
      6 wake_up_forked_process                     0.0163
     85 finish_task_switch                         0.5903
     18 schedule                                   0.0163
      1 preempt_schedule                           0.0125
     16 __wake_up                                  0.1667
      1 __wake_up_sync                             0.0078
      2 wait_for_completion                        0.0078
      1 io_schedule                                0.0312
    529 __might_sleep                              2.5433
      5 __put_task_struct                          0.0195
      3 add_wait_queue                             0.0312
      1 remove_wait_queue                          0.0069
      1 prepare_to_wait                            0.0078
     28 dup_task_struct                            0.1167
      4 mm_init                                    0.0179
      7 mm_alloc                                   0.1094
      2 __mmdrop                                   0.0250
      4 mmput                                      0.0227
      4 mm_release                                 0.0208
     48 copy_mm                                    0.0411
      8 count_open_files                           0.1667
     23 copy_files                                 0.0271
      4 unshare_files                              0.0417
     37 copy_process                               0.0129
      8 do_fork                                    0.0220
     49 release_task                               0.0988
     11 put_files_struct                           0.0573
     51 exit_notify                                0.0270
     13 do_exit                                    0.0119
      1 next_thread                                0.0312
      5 do_group_exit                              0.0284
      1 sys_exit_group                             0.0312
      4 eligible_child                             0.0167
      8 wait_task_zombie                           0.0156
      9 sys_wait4                                  0.0148
      1 sys_waitpid                                0.0233
      1 .text.lock.exit                            0.0047
     25 current_kernel_time                        0.3906
      1 get_jiffies_64                             0.0208
   3912 __do_softirq                              30.5625
      7 tasklet_action                             0.0625
     23 __mod_timer                                0.0553
      1 del_timer                                  0.0057
    198 run_timer_softirq                          0.4267
      1 sys_getpid                                 0.0625
      1 sys_getppid                                0.0312
      1 sys_getgid                                 0.0625
      1 sys_getegid                                0.0625
      2 free_uid                                   0.0125
      3 flush_signal_handlers                      0.0375
     20 get_signal_to_deliver                      0.0223
     30 sigprocmask                                0.1562
     17 sys_rt_sigprocmask                         0.0425
     14 do_sigaction                               0.0273
      7 sys_rt_sigaction                           0.0208
    129 groups_search                              1.1518
     69 in_group_p                                 0.5391
      4 sys_newuname                               0.0227
      1 getrusage                                  0.0015
      1 sys_getrusage                              0.0156
      1 __queue_work                               0.0069
      6 alloc_pidmap                               0.0117
      2 rcu_do_batch                               0.0208
      1 rcu_start_batch                            0.0156
      5 rcu_check_quiescent_state                  0.0347
      7 rcu_process_callbacks                      0.0273
      1 kthread_should_stop                        0.0312
      2 acct_process                               0.0143
      6 remove_from_page_cache                     0.0750
      1 filemap_fdatawrite                         0.0312
     13 add_to_page_cache                          0.0580
      2 add_to_page_cache_lru                      0.0250
     22 page_waitqueue                             0.4583
      1 wait_on_page_bit                           0.0052
     76 unlock_page                                0.7917
      7 end_page_writeback                         0.0625
    874 find_get_page                              9.1042
      7 find_lock_page                             0.0312
      2 find_or_create_page                        0.0104
      2 find_get_pages                             0.0179
    108 find_get_pages_tag                         0.7500
     85 do_generic_mapping_read                    0.0871
     47 file_read_actor                            0.1836
     70 __generic_file_aio_read                    0.1287
     30 generic_file_read                          0.1705
    162 filemap_nopage                             0.1841
     21 generic_file_mmap                          0.3281
     13 read_cache_page                            0.0232
      1 remove_suid                                0.0078
     10 generic_write_checks                       0.0149
     28 mempool_alloc                              0.0761
      1 mempool_alloc_slab                         0.0312
     93 bad_range                                  0.8304
     74 prep_new_page                              0.7708
    465 free_hot_cold_page                         1.8164
      4 free_hot_page                              0.2500
   1657 buffered_rmqueue                           3.5711
    356 __alloc_pages                              0.4363
      1 __free_pages                               0.0125
      2 free_pages                                 0.0417
     73 nr_free_pages                              0.9125
      1 get_zone_counts                            0.0078
      2 balance_dirty_pages_ratelimited            0.0125
      2 wb_kupdate                                 0.0069
      3 do_writepages                              0.0375
     53 __set_page_dirty_nobuffers                 0.2760
      1 test_clear_page_dirty                      0.0057
     27 clear_page_dirty_for_io                    0.4219
     38 test_clear_page_writeback                  0.2159
     29 test_set_page_writeback                    0.1295
      2 mapping_tagged                             0.0179
     77 file_ra_state_init                         1.6042
     90 do_page_cache_readahead                    0.2250
     84 page_cache_readahead                       0.1694
      2 cache_grow                                 0.0032
    161 kmem_cache_alloc                           1.4375
     20 __kmalloc                                  0.1250
     95 kmem_cache_free                            1.1875
     18 kfree                                      0.1607
     10 reap_timer_fnc                             0.0189
      4 activate_page                              0.0192
    241 mark_page_accessed                         5.0208
      2 lru_cache_add                              0.0208
    128 lru_cache_add_active                       1.3333
     19 lru_add_drain                              0.1979
    356 __page_cache_release                       1.8542
     76 release_pages                              0.1827
      3 __pagevec_lru_add                          0.0117
    205 __pagevec_lru_add_active                   0.7537
      1 pagevec_lookup_tag                         0.0125
      1 truncate_inode_pages                       0.0014
      5 shrink_list                                0.0039
      1 blk_queue_bounce                           0.0089
     88 clear_page_tables                          0.4583
    265 pte_alloc_map                              1.3802
    221 copy_page_range                            0.2558
    667 zap_pte_range                              1.7370
     13 zap_pmd_range                              0.1161
     15 unmap_page_range                           0.1339
     36 unmap_vmas                                 0.0662
     64 do_wp_page                                 0.0800
    692 do_anonymous_page                          1.4417
    684 do_no_page                                 0.8906
    663 handle_mm_fault                            1.4799
     54 remove_shared_vm_struct                    0.3750
     12 sys_brk                                    0.0417
    109 find_vma_prepare                           0.9732
     14 __vma_link_rb                              0.2188
     23 __vma_link                                 0.1437
     16 vma_link                                   0.1000
      4 __insert_vm_struct                         0.0278
      8 can_vma_merge_before                       0.1000
     46 can_vma_merge_after                        0.5750
    119 vma_merge                                  0.1730
    311 do_mmap_pgoff                              0.1735
     66 get_unmapped_area                          0.2062
    548 find_vma                                   5.7083
     36 find_vma_prev                              0.3750
      1 expand_stack                               0.0052
     22 free_pgtables                              0.1375
     10 unmap_vma                                  0.0781
      3 unmap_vma_list                             0.0625
     22 unmap_region                               0.0982
     20 detach_vmas_to_be_unmapped                 0.1786
     16 split_vma                                  0.0357
     23 do_munmap                                  0.0575
     16 sys_munmap                                 0.1250
     20 do_brk                                     0.0368
     23 exit_mmap                                  0.0575
    473 page_add_rmap                              2.6875
    304 page_remove_rmap                           1.0000
    295 __pte_chain_free                           2.6339
    109 pte_chain_alloc                            0.5677
     72 free_page_and_swap_cache                   0.6429
     10 can_share_swap_page                        0.0893
      4 si_swapinfo                                0.0357
      3 sys_access                                 0.0089
     34 filp_open                                  0.3036
     51 dentry_open                                0.0966
     59 get_unused_fd                              0.1418
     20 fd_install                                 0.3125
     29 sys_open                                   0.2014
     32 filp_close                                 0.2222
     41 sys_close                                  0.2562
      5 default_llseek                             0.0208
      2 sys_llseek                                 0.0078
     52 vfs_read                                   0.1625
      9 vfs_write                                  0.0281
     14 sys_read                                   0.1250
      4 sys_write                                  0.0357
     46 get_empty_filp                             0.1797
     22 fput                                       0.6875
     67 __fput                                     0.2204
     23 fget                                       0.3594
     42 fget_light                                 0.3281
     19 file_move                                  0.1979
     26 file_kill                                  0.4062
     57 __constant_c_and_count_memset              0.3958
      5 bh_waitq_head                              0.1562
     47 wake_up_buffer                             0.9792
     19 unlock_buffer                              0.2375
      3 __wait_on_buffer                           0.0125
      3 __set_page_buffers                         0.0469
    159 __find_get_block_slow                      0.4141
      4 inode_has_buffers                          0.1250
     41 __set_page_dirty_buffers                   0.1424
      2 invalidate_inode_buffers                   0.0179
      2 create_buffers                             0.0114
      1 __getblk_slow                              0.0035
     43 __brelse                                   0.6719
     76 bh_lru_install                             0.3393
    473 __find_get_block                           1.8477
     30 __getblk                                   0.2679
     29 __bread                                    0.3625
      3 create_empty_buffers                       0.0187
     14 __block_write_full_page                    0.0139
      3 __block_prepare_write                      0.0027
      2 block_prepare_write                        0.0250
      2 block_write_full_page                      0.0078
      5 submit_bh                                  0.0104
      1 check_ttfb_buffer                          0.0104
      1 drop_buffers                               0.0045
      1 try_to_free_buffers                        0.0048
      2 alloc_buffer_head                          0.0208
      3 init_buffer_head                           0.0625
     19 bio_alloc                                  0.0457
     11 bio_clone                                  0.0688
      2 sync_supers                                0.0083
     23 nr_blockdev_pages                          0.2396
      2 chrdev_open                                0.0038
      1 cdev_get                                   0.0052
     77 generic_fillattr                           0.4813
     46 vfs_getattr                                0.2396
     31 vfs_fstat                                  0.3875
     43 cp_new_stat64                              0.1344
      1 sys_stat64                                 0.0156
     20 sys_fstat64                                0.3125
      2 count                                      0.0312
     90 copy_strings                               0.1480
      2 copy_strings_kernel                        0.0250
      1 put_dirty_page                             0.0030
      9 setup_arg_pages                            0.0176
      9 open_exec                                  0.0375
      2 kernel_read                                0.0208
      3 exec_mmap                                  0.0110
     15 flush_old_exec                             0.0066
      2 prepare_binprm                             0.0096
      7 compute_creds                              0.0243
      9 search_binary_handler                      0.0128
      4 do_execve                                  0.0063
      1 set_binfmt                                 0.0063
      5 pipe_wait                                  0.0260
     15 pipe_readv                                 0.0195
      1 pipe_read                                  0.0156
      9 pipe_writev                                0.0097
      3 pipe_write                                 0.0469
      2 pipe_release                               0.0089
      1 pipe_write_fasync                          0.0069
      1 pipe_write_release                         0.0156
      1 get_pipe_inode                             0.0052
     53 getname                                    0.2548
     30 vfs_permission                             0.1042
     28 permission                                 0.2188
      1 get_write_access                           0.0125
      2 deny_write_access                          0.0250
      1 path_release                               0.0156
      1 cached_lookup                              0.0069
      5 real_lookup                                0.0184
     25 follow_mount                               0.1736
     22 do_lookup                                  0.1250
    453 link_path_walk                             0.1827
     84 path_lookup                                0.2625
      2 __lookup_hash                              0.0089
      1 lookup_hash                                0.0208
      5 __user_walk                                0.0521
      1 unlock_rename                              0.0125
      4 vfs_create                                 0.0147
    128 may_open                                   0.2963
     33 open_namei                                 0.0290
      1 vfs_mkdir                                  0.0039
      1 vfs_unlink                                 0.0023
      1 sys_unlink                                 0.0030
      1 vfs_rename_other                           0.0031
      1 sys_rename                                 0.0018
     25 page_getlink                               0.1302
     23 page_follow_link                           0.0464
      1 set_close_on_exec                          0.0156
      2 expand_files                               0.0179
      2 locate_fd                                  0.0069
      1 sys_dup2                                   0.0033
      2 generic_file_fcntl                         0.0046
      1 fasync_helper                              0.0042
      3 sys_ioctl                                  0.0042
      3 filldir64                                  0.0094
      1 max_select_fd                              0.0045
      2 do_select                                  0.0028
     39 locks_remove_posix                         0.1434
     37 locks_remove_flock                         0.1927
      6 steal_locks                                0.0288
      1 d_callback                                 0.0156
      1 d_free                                     0.0156
     67 dput                                       0.1074
      8 d_alloc                                    0.0156
      3 d_instantiate                              0.0234
    644 __d_lookup                                 1.9167
      6 d_rehash                                   0.0536
      9 alloc_inode                                0.0216
      1 inode_init_once                            0.0039
      4 clear_inode                                0.0227
      1 prune_icache                               0.0018
      5 new_inode                                  0.0312
      3 get_new_inode_fast                         0.0110
      1 iget_locked                                0.0052
      6 __insert_inode_hash                        0.0625
      4 generic_delete_inode                       0.0132
      8 iput                                       0.0625
     33 inode_times_differ                         0.4125
     69 update_atime                               0.3080
      6 inode_update_time                          0.0268
      1 i_waitq_head                               0.0312
      2 wake_up_inode                              0.0417
      2 is_bad_inode                               0.0250
     35 dnotify_flush                              0.1823
     44 dnotify_parent                             0.2292
      5 lookup_mnt                                 0.0391
      3 copy_namespace                             0.0039
     53 __mark_inode_dirty                         0.1840
     10 __sync_single_inode                        0.0216
      1 __writeback_single_inode                   0.0052
     12 sync_sb_inodes                             0.0179
      1 writeback_acquire                          0.0312
      4 writeback_in_progress                      0.2500
      3 writeback_release                          0.0652
     22 do_mpage_readpage                          0.0188
      1 mpage_readpages                            0.0024
     41 mpage_writepages                           0.0483
      4 exit_aio                                   0.0278
      4 eventpoll_init_file                        0.1250
      5 set_brk                                    0.0521
     24 create_elf_tables                          0.0259
      9 elf_map                                    0.0402
     12 load_elf_interp                            0.0192
     35 load_elf_binary                            0.0104
      2 de_put                                     0.0089
      1 proc_delete_inode                          0.0069
      3 proc_get_inode                             0.0094
      3 proc_pid_unhash                            0.0234
      1 proc_file_read                             0.0015
     20 proc_lookup                                0.0694
     41 get_vmalloc_info                           0.2330
      2 meminfo_read_proc                          0.0040
      3 write_profile                              0.0469
     44 scan_bitmap_block                          0.0377
      9 scan_bitmap                                0.0165
      2 _reiserfs_free_block                       0.0060
      2 reiserfs_free_block                        0.0312
      1 reiserfs_discard_all_prealloc              0.0156
      2 determine_prealloc_size                    0.0139
     15 reiserfs_allocate_blocknrs                 0.0076
      1 reiserfs_claim_blocks_to_be_allocated      0.0208
      1 reiserfs_release_claimed_blocks            0.0208
      3 reiserfs_can_fit_pages                     0.0312
      3 balance_leaf_when_delete                   0.0027
     21 balance_leaf                               0.0017
      3 free_thrown                                0.0268
      1 reiserfs_invalidate_buffer                 0.0208
      4 do_balance                                 0.0147
      4 bin_search_in_dir_item                     0.0227
      9 search_by_entry_key                        0.0181
      5 get_third_component                        0.0521
      3 linear_search_in_dir_item                  0.0042
      4 reiserfs_find_entry                        0.0114
      1 reiserfs_lookup                            0.0026
     10 reiserfs_add_entry                         0.0082
      2 new_inode_init                             0.0179
      4 reiserfs_create                            0.0089
      4 reiserfs_unlink                            0.0050
      1 reiserfs_rename                            0.0004
      1 reiserfs_delete_inode                      0.0037
     33 _make_cpu_key                              0.1587
     88 make_cpu_key                               0.7857
      1 file_capable                               0.0156
      1 reiserfs_get_block                         0.0002
     72 inode2sd                                   0.3750
      4 inode2sd_v1                                0.0278
     28 update_stat_data                           0.1029
     59 reiserfs_update_sd                         0.1272
     14 reiserfs_new_inode                         0.0097
      1 grab_tail_page                             0.0025
     10 reiserfs_truncate_file                     0.0179
     73 reiserfs_write_full_page                   0.0830
      4 reiserfs_writepage                         0.0625
     10 i_attrs_to_sd_attrs                        0.0893
      1 invalidatepage_can_drop                    0.0069
      3 reiserfs_invalidatepage                    0.0134
      3 make_le_item_head                          0.0136
     50 reiserfs_file_release                      0.0434
     29 reiserfs_allocate_blocks_for_region        0.0055
      4 reiserfs_copy_from_user_to_file_region     0.0167
      7 reiserfs_commit_page                       0.0273
      9 reiserfs_submit_file_region_for_write      0.0117
      5 reiserfs_check_for_tail_and_convert        0.0089
     49 reiserfs_prepare_file_region_for_write     0.0199
     30 reiserfs_file_write                        0.0151
      1 reiserfs_readdir                           0.0007
     15 create_virtual_node                        0.0117
      4 check_left                                 0.0125
      1 check_right                                0.0031
     15 get_num_ver                                0.0174
      5 set_parameters                             0.0347
      1 are_leaves_removable                       0.0027
      4 get_rfree                                  0.0357
      1 is_left_neighbor_in_cache                  0.0063
      3 get_parents                                0.0072
     18 ip_check_balance                           0.0062
      1 dc_check_balance_internal                  0.0007
      5 dc_check_balance_leaf                      0.0092
      2 dc_check_balance                           0.0417
      4 check_balance                              0.0227
      3 get_direct_parent                          0.0110
      7 get_neighbors                              0.0199
      1 get_virtual_node_size                      0.0125
      2 get_mem_for_virtual_node                   0.0083
      6 wait_tb_buffers_until_unlocked             0.0074
     18 fix_nodes                                  0.0184
      6 unfix_nodes                                0.0170
      1 is_reiserfs_jr                             0.0125
      3 add_save_link                              0.0055
      1 remove_save_link                           0.0045
      1 reiserfs_alloc_inode                       0.0208
     62 reiserfs_dirty_inode                       0.3229
      1 reiserfs_get_unused_objectid               0.0035
      1 leaf_copy_boundary_item                    0.0005
      3 leaf_copy_items_entirely                   0.0039
      1 leaf_copy_items                            0.0025
      4 leaf_define_dest_src_infos                 0.0093
      1 leaf_shift_left                            0.0052
      2 leaf_delete_items                          0.0045
     22 leaf_insert_into_buf                       0.0259
      9 leaf_paste_in_buffer                       0.0097
      3 leaf_cut_entries                           0.0072
     12 leaf_cut_from_buffer                       0.0097
      7 leaf_delete_items_entirely                 0.0122
     13 leaf_paste_entries                         0.0173
      7 internal_insert_childs                     0.0112
      1 internal_delete_pointers_items             0.0021
      1 internal_insert_key                        0.0030
      1 balance_internal_when_delete               0.0018
      2 balance_internal                           0.0008
     29 decrement_counters_in_path                 0.3625
      1 pathrelse_and_restore                      0.0125
     21 pathrelse                                  0.3281
    274 is_leaf                                    0.5905
     29 is_internal                                0.1812
    167 is_tree_node                               1.4911
    716 search_by_key                              0.1857
     14 search_for_position_by_key                 0.0143
      1 comp_items                                 0.0104
      5 prepare_for_delete_or_cut                  0.0026
      2 calc_deleted_bytes_number                  0.0042
      9 init_tb_struct                             0.0938
      1 padd_item                                  0.0312
      2 maybe_indirect_to_direct                   0.0030
      6 reiserfs_cut_from_item                     0.0048
      8 reiserfs_do_truncate                       0.0060
      2 reiserfs_paste_into_item                   0.0066
      1 reiserfs_insert_item                       0.0031
      3 B_IS_IN_TREE                               0.0938
     10 copy_item_head                             0.2083
      3 decrement_bcount                           0.0469
      3 r5_hash                                    0.0375
      3 indirect2direct                            0.0038
     22 init_journal_hash                          0.6875
      5 get_cnode                                  0.0312
      2 free_cnode                                 0.0139
      1 reiserfs_check_lock_depth                  0.0625
     89 reiserfs_in_journal                        0.1794
      2 submit_ordered_buffer                      0.0312
      1 write_ordered_chunk                        0.0125
      1 reiserfs_free_jh                           0.0089
      5 reiserfs_add_ordered_list                  0.0260
     16 write_ordered_buffers                      0.0263
     47 reiserfs_async_progress_wait               0.3264
     11 flush_commit_list                          0.0107
      2 find_newer_jl_for_cn                       0.0417
      2 flush_journal_list                         0.0013
      7 dirty_one_transaction                      0.0547
     33 remove_journal_hash                        0.1719
      1 alloc_journal_list                         0.0069
     20 reiserfs_wait_on_write_block               0.1389
     15 wake_queued_writers                        0.2344
    106 do_journal_begin_r                         0.1656
     36 journal_begin                              0.1731
     59 journal_mark_dirty                         0.0899
     40 journal_end                                0.2083
      1 remove_from_transaction                    0.0028
     30 can_dirty                                  0.1705
     65 check_journal_end                          0.1016
      1 journal_mark_freed                         0.0020
      8 reiserfs_restore_prepared_buffer           0.0417
     40 reiserfs_prepare_for_journal               0.3125
    133 do_journal_end                             0.0452
      1 sd_bytes_number                            0.0625
      1 sd_is_left_mergeable                       0.0625
      1 sd_create_vi                               0.0625
      2 sd_part_size                               0.0625
      2 direct_is_left_mergeable                   0.0139
      1 direct_create_vi                           0.0625
      3 direct_part_size                           0.1875
      1 indirect_bytes_number                      0.0312
      3 indirect_part_size                         0.1875
      6 direntry_is_left_mergeable                 0.3750
      8 direntry_create_vi                         0.0200
      1 direntry_check_left                        0.0069
      1 direntry_part_size                         0.0156
      3 copy_semundo                               0.0144
      1 exit_sem                                   0.0030
      1 capable                                    0.0104
      4 dummy_capable                              0.0833
    110 dummy_vm_enough_memory                     0.6250
      1 dummy_bprm_alloc_security                  0.0625
      1 dummy_bprm_set_security                    0.0625
      1 dummy_bprm_secureexec                      0.0156
      5 dummy_inode_alloc_security                 0.3125
      2 dummy_inode_unlink                         0.1250
      6 dummy_inode_follow_link                    0.3750
     20 dummy_inode_permission                     1.2500
      1 dummy_inode_getattr                        0.0625
      6 dummy_file_permission                      0.3750
     18 dummy_file_alloc_security                  1.1250
      3 dummy_file_free_security                   0.1875
      2 dummy_file_ioctl                           0.1250
     32 dummy_file_mmap                            2.0000
      4 dummy_task_wait                            0.2500
      1 dummy_d_instantiate                        0.0625
      2 kobject_get                                0.0250
      2 kobject_put                                0.0625
      2 radix_tree_preload                         0.0125
     13 __rb_rotate_left                           0.2031
     10 __rb_rotate_right                          0.1562
     58 rb_insert_color                            0.2417
      6 __rb_erase_color                           0.0139
     29 rb_erase                                   0.1133
      3 skip_atoi                                  0.0469
     21 number                                     0.0285
     17 vsnprintf                                  0.0144
      2 vsprintf                                   0.0417
      2 sprintf                                    0.0417
     76 atomic_dec_and_lock                        0.9500
      1 __delay                                    0.0312
      4 __get_user_4                               0.1739
      3 bad_get_user                               0.3333
     38 memcpy                                     0.3958
    355 _mmx_memcpy                                0.9647
   8365 fast_clear_page                           87.1354
    827 fast_copy_page                             3.2305
     83 mmx_clear_page                             2.5938
      1 mmx_copy_page                              0.0208
     77 direct_strncpy_from_user                   0.6875
     55 direct_clear_user                          0.5729
    149 direct_strnlen_user                        1.5521
      2 __copy_user_intel                          0.0114
   2408 __copy_to_user_ll                         21.5000
    247 __copy_from_user_ll                        1.5437
      1 write_null                                 0.0625
      3 init_dev                                   0.0019
      4 release_dev                                0.0026
      3 tty_open                                   0.0035
      1 tty_fasync                                 0.0035
      2 tty_ioctl                                  0.0015
      2 vt_ioctl                                   0.0002
      1 con_open                                   0.0057
      1 con_close                                  0.0063
     21 blk_rq_map_sg                              0.0656
      4 generic_unplug_device                      0.0357
      6 get_request                                0.0089
     73 __make_request                             0.0507
     12 generic_make_request                       0.0242
      3 submit_bio                                 0.0117
      1 put_io_context                             0.0104
      1 get_io_context                             0.0078
      1 blk_backing_dev_unplug                     0.0208
      3 as_work_handler                            0.0268
      3 as_set_request                             0.0208
      1 mii_link_ok                                0.0125
    181 ide_end_request                            0.5387
      4 start_request                              0.0068
     60 ide_do_request                             0.0682
     28 ide_intr                                   0.0700
     92 ide_inb                                    5.7500
    162 ide_outb                                  10.1250
      9 ide_outl                                   0.5625
      1 SELECT_DRIVE                               0.0125
      4 ide_wait_stat                              0.0132
     23 ide_execute_command                        0.1198
      5 ide_dma_intr                               0.0260
      5 ide_build_sglist                           0.0284
     11 ide_build_dmatable                         0.0275
      1 ide_start_dma                              0.0057
      4 __ide_dma_write                            0.0167
      1 __ide_dma_end                              0.0063
      2 __ide_do_rw_disk                           0.0011
      2 ide_do_rw_disk                             0.0208
     19 i8042_interrupt                            0.0540
      2 i8042_timer_func                           0.0417
      3 sock_poll                                  0.0469
      1 fn_hash_lookup                             0.0037
      8 ret_from_intr                              0.2963
    261 system_call                                5.9318
      2 syscall_call                               0.1818
     15 syscall_exit                               1.3636
     33 error_code                                 0.5893
    174 device_not_available                       4.1429
  90826 total                                      0.0533


Regards,
Andreas Hartmann
