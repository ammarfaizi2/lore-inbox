Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTIQPXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTIQPXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:23:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:22260 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262781AbTIQPXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:23:09 -0400
Importance: Normal
Sensitivity: 
Subject: Re: I/O degredation with AS on 2.6.0-test3
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org, Mike Sullivan <mksully@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF7EFA21A7.C5FDCD40-ON85256DA4.005356E3@us.ibm.com>
From: Mike Sullivan <mksully@us.ibm.com>
Date: Wed, 17 Sep 2003 10:22:34 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 JHEG5P4HSL
 JBONL5L8FGD MIAS5MHLYW|August 26, 2003) at 09/17/2003 11:22:45
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Dave Hansen wrote:
>>
>>You might want to try Martin Bligh's diffprofile utility.  It's a bit
>>hard to compare 2 500-line profiles without it.
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/tools/
>>
>>Also, there have evidently been a few I/O scheduler fixes since -test3.
>>Please retry with -test5.
>>

>Nick Piggen wrote:
>More important, are they regressions vs. previous kernels with AS?

I've checked 2.5.69mm9, 2.5.75, 2.6.0test3, and 2.6.0test5 and they all
show a
significant degradation in IO performance (>40%) when using the as
scheduler
compared to the deadline scheduler.

Configuration: IBM x440 8way with hypertheading enabled, 16GB RAM,
4 QLA2310 FC adapters attached to 2 FastT900 controllers
(112 disks total). The 112 physical disks are striped as 8 raid 0
logical disks. There are a total of 40 raw devices setup (5 per raid0
disk).

I've reattached excerpts from the database test for vmstat and
the readprofile diffs created from Martin's diffprofile utility
(diffprofile readp.as readp.dl).



vmstat for anticipatory scheduler
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
14 41      0 3489576   3840 168280    0    0    25     2   70    30  1  2
96  0
 4 103      0 3329760   3860 172160    0    0 233549    97 6606 21284 27  6
0 67
 7 91      0 3327496   3864 172156    0    0 137106    14 7364 32957 20  5
0 75
 2 84      0 3325416   3868 172412    0    0 138979    73 7096 30445 19  5
0 76
 6 78      0 3324528   3868 173192    0    0 143213   444 7328 24901 13  4
0 83
 0 105      0 3316408   3876 173964    0    0 142413   524 7531 26854 12  5
0 83
 7 94      0 3313664   3880 174220    0    0 134939   821 7336 29037 14  5
0 82
 1 110      0 3313560   3884 174216    0    0 114651   923 6990 27063 11  4
0 84
 5 109      0 3313008   3884 174216    0    0 110115   862 6937 26381 11  4
0 85
 3 111      0 3325400   3920 174180    0    0 108664  1030 6892 26721 11  4
0 85

vmstat for deadline scheduler
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
19  0      0 3518364   3104 119096    0    0    43     1   78    62  1  2
97  1
70 23      0 3361380   3776 170684    0    0 351035   538 3521 19435 68 17
9  5
96 25      0 3321060   3816 171684    0    0 588377   349 4973 25000 91  9
0  0
79 41      0 3316492   3824 171676    0    0 621683   831 5037 26853 91  9
0  0
86 48      0 3318684   3836 172964    0    0 609092  3073 4882 27878 91  9
0  0
71 44      0 3310164   3848 173212    0    0 551741  3746 4291 28492 92  8
0  0
91 35      0 3297708   3852 174248    0    0 508096  1425 4410 29533 91  8
0  1

      9217   161.5% scsi_request_fn
      8588    75.5% do_softirq
      8236   236.5% qla2x00_start_scsi
      7890   550.6% follow_hugetlb_page
      5822    47.6% schedule
      3432   762.7% do_direct_IO
      3275   253.5% sys_msgsnd
      3171   781.0% submit_page_section
      2645   527.9% set_page_dirty_lock
      2541   169.1% unlock_page
      2061   467.3% dio_bio_complete
      1979   620.4% dio_bio_add_page
      1552   674.8% get_offset_cyclone
      1528   217.7% system_call
      1509  1012.8% bio_add_page
      1485   629.2% fsync_buffers_list
      1472   213.0% del_timer_sync
      1184   240.2% get_request
      1147   151.3% try_to_wake_up
      1000   628.9% dio_refill_pages
       701   722.7% blkdev_get_blocks
       680   957.7% max_block
       660   628.6% .text.lock.util
       607    35.6% qla2x00_queuecommand
       604    17.4% dio_bio_end_io
       581   162.3% bio_alloc
       542   171.5% ipc_lock
       502     0.0% generic_unplug_device
       494   425.9% get_jiffies_64
       488   650.7% page_add_rmap
       473   276.6% sys_msgrcv
       469   609.1% find_vma
       463   593.6% dio_send_cur_page
       420  3230.8% default_llseek
       414   246.4% blk_run_queue
       412    91.4% direct_io_worker
       400   126.2% __generic_file_aio_read
       397   536.5% page_waitqueue
       363   394.6% __copy_from_user_ll
       362   122.3% kfree
       349   623.2% get_user_pages
       344  8600.0% copy_page_range
       309   148.6% scsi_put_command
       298   172.3% testmsg
       297    76.9% kmem_cache_alloc
       285    84.1% kmem_cache_free
       279  1268.2% do_readv_writev
       224   164.7% fget_light
       202  1188.2% do_wp_page
       196   233.3% __copy_to_user_ll
       196   560.0% __kmalloc
       184    29.3% do_no_page
       181   603.3% get_more_blocks
       171    33.8% scsi_device_unbusy
       167   136.9% do_page_fault
       166  2766.7% generic_file_readv
       160   141.6% sd_rw_intr
       156    70.0% huge_pte_offset
       155   620.0% wait_on_page_bit
       149   191.0% do_gettimeofday
       148   389.5% __set_page_dirty_buffers
       143  4766.7% sys_llseek
       142   215.2% sys_ipc
       139   165.5% sys_semtimedop
       132   275.0% dio_get_page
       125   223.2% find_extend_vma
       120   190.5% del_timer
       118   100.0% update_atime
       118   184.4% kmap_atomic
       117   144.4% io_schedule
       115    61.8% blockdev_direct_IO
       114   495.7% ipcperms
       108     0.0% deadline_set_request
       103   251.2% do_anonymous_page
        90   100.0% generic_file_direct_IO
        88   125.7% blkdev_direct_IO
        87   348.0% do_setitimer
        86   215.0% do_getitimer
        84   466.7% store_msg
        82    52.2% generic_make_request
        78   222.9% do_clock_nanosleep
        75   166.7% find_get_page
        74   123.3% bio_destructor
        67    78.8% submit_bio
        66   507.7% wake_up_process
        66   188.6% sys_setitimer
        65   928.6% pte_alloc_one
        65   127.5% syscall_exit
        64   206.5% page_remove_rmap
        64   400.0% sys_gettimeofday
        62    35.8% batch_entropy_store
        61   762.5% load_msg
        58    96.7% mempool_free
        57    28.9% mempool_alloc
        57   300.0% blk_queue_bounce
        54  2700.0% sys_readv
        52     0.0% huge_page_release
        45    21.1% qla2x00_next
        45    71.4% scsi_softirq
        44   275.0% handle_mm_fault
        43   307.1% .text.lock.direct_io
        42  4200.0% sys_select
        40   142.9% scsi_decide_disposition
        40     3.7% scsi_dispatch_cmd
        40   190.5% zap_pte_range
        40  4000.0% find_lock_page
        39    27.9% dnotify_parent
        38   633.3% vfs_readv
        37    72.5% dio_await_completion
        37   308.3% scsi_next_command
        37    67.3% __d_lookup
        35  3500.0% do_select
        34  3400.0% device_not_available
        34  3400.0% work_resched
        33   157.1% scsi_finish_command
        32    49.2% proc_pid_stat
        31   182.4% try_atomic_semop
        31   620.0% radix_tree_lookup
        30    41.7% scsi_init_cmd_errh
        28   155.6% syscall_call
        27   180.0% elv_set_request
        27    75.0% mempool_alloc_slab
        27   117.4% vsnprintf
        26   650.0% pte_chain_alloc
        26   130.0% scsi_add_timer
        26    23.4% scsi_run_queue
        25    75.8% adjust_abs_time
        22    57.9% dio_new_bio
        22    71.0% blkdev_writepage
        21     3.8% __end_that_request_first
        20   117.6% buffered_rmqueue
        20   133.3% qla2x00_calc_iocbs_64
        20   500.0% __pte_chain_free
        19   146.2% dio_bio_alloc
        19   211.1% free_msg
        18  1800.0% set_huge_pte
        18   360.0% filemap_nopage
        17    89.5% update_queue
        17   242.9% pte_alloc_map
        17     0.0% shmem_getpage
        17   566.7% fget
        17   242.9% release_pages
        17    22.7% bio_put
        17   566.7% __alloc_pages
        17     0.0% find_vma_prev
        16   266.7% dio_complete
        16     0.0% kstat_read_proc
        15   136.4% __lookup
        15   214.3% ipc_unlock
        15   250.0% tstojiffie
        15    30.0% bio_get_nr_vecs
        15    55.6% sys_nanosleep
        15    18.3% dio_bio_submit
        14    46.7% inode_times_differ
        14   700.0% copy_files
        13     0.0% shmem_nopage
        13    23.6% task_mem
        13   260.0% bad_range
        13  1300.0% tcp_poll
        13    92.9% kmap_atomic_to_page
        12    23.1% number
        12   600.0% cache_grow
        12  1200.0% math_state_restore
        12     0.0% hugetlb_prefault
        12   400.0% may_open
        12  1200.0% copy_mm
        11    73.3% free_hot_cold_page
        11   122.2% clear_page_tables
        10   166.7% end_that_request_chunk
        10    13.3% memcpy
        10   125.0% __wake_up
        10   500.0% pid_alive
        10   142.9% fput
        10  1000.0% get_unused_fd
         9    60.0% flush_tlb_mm
         9   225.0% .text.lock.time
         9   900.0% show_interrupts
         9   900.0% ipc_checkid
         8   400.0% remove_shared_vm_struct
         8   800.0% restore_fpu
         8   400.0% end_that_request_first
         8    28.6% link_path_walk
         8   800.0% qla2x00_build_scsi_iocbs_32
         8   100.0% local_bh_enable
         8   800.0% __posix_lock_file
         8     0.0% ipc_parse_version
         7    63.6% dio_bio_reap
         7     0.0% free_pages
         7     0.0% unmap_hugepage_range
         7     0.0% nr_blockdev_pages
         7   175.0% __get_user_4
         7   350.0% sock_poll
         7   350.0% d_alloc
         6     0.0% do_sigaction
         6   200.0% __mark_inode_dirty
         6   600.0% schedule_delayed_work
         6   600.0% __alloc_percpu
         6     0.0% sys_shmat
         6   600.0% do_sys_settimeofday
         6   120.0% generic_file_write_nolock
         6     0.0% mark_page_accessed
        -7    -2.0% add_disk_randomness
        -7   -63.6% show_cpuinfo
        -8   -34.8% queue_delayed_work
       -12   -25.0% sys_pread64
       -15    -5.3% add_timer_randomness
       -26  -100.0% show_regs
       -32   -44.4% generic_file_read
       -33   -15.6% io_schedule_timeout
       -34    -3.7% qla2x00_get_new_sp
       -49  -100.0% as_set_request
       -61   -98.4% default_idle
       -62   -45.9% vfs_read
       -78   -95.1% remove_wait_queue
       -86   -97.7% add_wait_queue
       -94   -16.3% blk_run_queues
      -128   -21.7% blk_recount_segments
      -143   -86.1% mempool_free_slab
      -204   -16.2% current_kernel_time
      -232   -43.5% get_io_context
      -253   -15.4% add_timer
      -268  -100.0% as_work_handler
      -409  -100.0% worker_thread
      -770   -49.0% put_io_context
     -1098   -48.2% dio_await_one
     -1592   -30.1% scsi_end_request
     -2054   -99.5% cpu_idle
     -4169   -42.6% __make_request
  -1527947   -89.9% total
  -1605826   -99.7% poll_idle

Mike Sullivan



