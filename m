Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbTCOJhj>; Sat, 15 Mar 2003 04:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTCOJhj>; Sat, 15 Mar 2003 04:37:39 -0500
Received: from holomorphy.com ([66.224.33.161]:14033 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261367AbTCOJhc>;
	Sat, 15 Mar 2003 04:37:32 -0500
Date: Sat, 15 Mar 2003 01:47:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Cc: hawkes@sgi.com, hannal@us.ibm.com
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315094758.GT20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, hawkes@sgi.com, hannal@us.ibm.com
References: <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315054910.GN20188@holomorphy.com> <20030315062025.GP20188@holomorphy.com> <20030314224413.6a1fc39c.akpm@digeo.com> <20030315070511.GQ20188@holomorphy.com> <20030315082431.GG5891@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315082431.GG5891@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 12:24:31AM -0800, William Lee Irwin III wrote:
> Next pass involves lockmeter:

Throughput 39.2014 MB/sec 128 procs
dbench 128  142.51s user 10828.91s system 964% cpu 18:57.88 total

That's an 83% reduction in throughput from applying lockmeter.

Um, somebody should look into this. The thing is a bloody doorstop:

vma      samples  %-age       symbol name
c012fbbd 20829312 51.3129     .text.lock.lockmeter
c012eb1c 3834281  9.44573     alloc_rwlock_struct
c0106f74 2940592  7.24413     default_idle
c025174c 2837008  6.98895     sync_buffer
c012ec58 1438542  3.54384     _metered_read_lock
c012e98c 1129385  2.78223     _metered_spin_lock
c012ea94 1044869  2.57403     _metered_spin_unlock
c012e89c 982225   2.41971     lstat_update
c012efd0 702482   1.73056     _metered_write_lock
c01cca10 657780   1.62044     __copy_to_user_ll
c012e6f0 587940   1.44839     lstat_lookup
c0251910 551723   1.35917     add_event_entry
c012ee70 512327   1.26211     _metered_read_unlock
c0109a30 298994   0.73657     apic_timer_interrupt
c01cca78 202482   0.498813    __copy_from_user_ll
c0120730 159350   0.392558    current_kernel_time
c012f148 133340   0.328482    _metered_write_unlock
c02516a8 127259   0.313502    add_sample
c0251634 112579   0.277338    add_sample_entry
c0118cac 102231   0.251845    scheduler_tick
c010f080 75857    0.186873    timer_interrupt

AFAICT the actual results are also garbage.


System: Linux curly 2.5.64 #1 SMP Sat Mar 15 00:49:53 PST 2003 i686
Total counts

All (32) CPUs

Start time: Sat Mar 15 01:20:18 2003
End   time: Sat Mar 15 01:39:03 2003
Delta Time: 1129.85 sec.
Hash table slots in use:      216.
Global read lock slots in use: 999.

*************************** Warnings! ******************************
	Read Lock table overflowed.

	The data in this report may be in error due to this.
************************ End of Warnings! **************************


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        2.6%                   0us                821511883 97.4% 0.15%  2.5%  *TOTAL*

    0%    0%                   0us                      179  100%    0%    0%  [0xc0433810]
    0%    0%                   0us                      179  100%    0%    0%    uart_wait_modem_status+0x168

    0%    0%                   0us                      179  100%    0%    0%  [0xc0434260]
    0%    0%                   0us                      179  100%    0%    0%    uart_wait_modem_status+0x18c

    0%    0%                   0us                      129  100%    0%    0%  [0xee1c90f0]
    0%    0%                   0us                      129  100%    0%    0%    autofs4_dir_rmdir+0xa0

    0%    0%                   0us                        1  100%    0%    0%  [0xee66b020]
    0%    0%                   0us                        1  100%    0%    0%    inet_rtm_newaddr+0x54

    0%    0%                   0us                       49  100%    0%    0%  [0xef30b8d4]
    0%    0%                   0us                       16  100%    0%    0%    do_mmap_pgoff+0x468
    0%    0%                   0us                       33  100%    0%    0%    sys_mlockall+0x88

    0%  3.7%                   0us                    46947 96.3%  3.7%    0%  [0xef3c85f4]
    0%  3.7%                   0us                    46947 96.3%  3.7%    0%    sys_fchmod+0xb8

    0%    0%                   0us                      227  100%    0%    0%  [0xef53e994]
    0%    0%                   0us                      227  100%    0%    0%    scsi_dispatch_cmd+0x38

    0%    0%                   0us                     2770  100%    0%    0%  [0xef55011c]
    0%    0%                   0us                     2218  100%    0%    0%    __constant_c_and_count_memset+0x24
    0%    0%                   0us                      552  100%    0%    0%    _decode_session+0x130

    0%    0%                   0us                     2218  100%    0%    0%  [0xef550128]
    0%    0%                   0us                     2218  100%    0%    0%    _decode_session+0x14

    0%    0%                   0us                        2  100%    0%    0%  [0xef6455a0]
    0%    0%                   0us                        1  100%    0%    0%    filemap_sync+0xcc
    0%    0%                   0us                        1  100%    0%    0%    mprotect_fixup+0x14

    0%    0%                   0us                        2  100%    0%    0%  [0xf04c7df0]
    0%    0%                   0us                        1  100%    0%    0%    get_one_pte_map_nested+0x58
    0%    0%                   0us                        1  100%    0%    0%    insert_vm_struct+0xc

    0%  3.0%                   0us                  1543963 97.0%  3.0%    0%  __per_cpu_end+0xdc
    0%  3.6%                   0us                      220 96.4%  3.6%    0%    clear_inode+0x58
    0%  1.9%                   0us                   258185 98.1%  1.9%    0%    dentry_iput+0x24
    0%  4.3%                   0us                   119875 95.7%  4.3%    0%    do_pollfd+0x68
    0%  2.6%                   0us                   258168 97.4%  2.6%    0%    do_poll+0x7c
    0%  3.2%                   0us                   385561 96.8%  3.2%    0%    sys_poll+0x218
    0%  3.4%                   0us                   258115 96.6%  3.4%    0%    sys_select+0x7c
    0%    0%                   0us                        5  100%    0%    0%    sys_select+0x204
    0%  3.2%                   0us                   263834 96.8%  3.2%    0%    sys_select+0x340

    0%    0%                   0us                        3  100%    0%    0%  _binary_usr_initramfs_data_cpio_gz_end+0x13c
    0%    0%                   0us                        2  100%    0%    0%    do_rw_proc+0x24
    0%    0%                   0us                        1  100%    0%    0%    proc_readsys+0xc

    0% 31.8%                   0us                   904982 68.2% 31.8%    0%  log_buf+0x5c60
    0%    0%                   0us                        3  100%    0%    0%    .text.lock.eventpoll+0x6
    0% 20.0%                   0us                       80 80.0% 20.0%    0%    .text.lock.pageattr+0x3f
    0% 35.8%                   0us                     2302 64.2% 35.8%    0%    __register_serial+0x98
    0% 33.3%                   0us                        3 66.7% 33.3%    0%    aio_kick_handler+0x8
    0%  100%                   0us                        2    0%  100%    0%    block_truncate_page+0x20c
    0% 31.9%                   0us                      138 68.1% 31.9%    0%    copy_msqid_from_user+0xbc
    0% 36.4%                   0us                     2176 63.6% 36.4%    0%    ep_poll+0x34
    0% 24.4%                   0us                      639 75.6% 24.4%    0%    flock_make_lock+0x38
    0% 36.5%                   0us                      639 63.5% 36.5%    0%    flock_make_lock+0xb0
    0% 34.6%                   0us                     2331 65.4% 34.6%    0%    get_pci_port+0x14c
    0% 44.0%                   0us                      639 56.0% 44.0%    0%    locks_alloc_lock
    0% 35.6%                   0us                      225 64.4% 35.6%    0%    parse_extended+0x184
    0% 12.7%                   0us                       71 87.3% 12.7%    0%    pipe_write+0x258
    0% 31.7%                   0us                   895062 68.3% 31.7%    0%    proc_pid_make_inode+0x3c
    0% 33.3%                   0us                        3 66.7% 33.3%    0%    read_events+0xe8
    0%    0%                   0us                        2  100%    0%    0%    serial8250_type+0x8
    0% 39.4%                   0us                      635 60.6% 39.4%    0%    unuse_pmd+0x11c
    0% 12.5%                   0us                       32 87.5% 12.5%    0%    vfs_create+0x90

    0%    0%                   0us                        2  100%    0%    0%  log_buf+0x5c80
    0%    0%                   0us                        2  100%    0%    0%    kmap_atomic+0x8

    0%  1.6%                   0us                  1045171 98.4%  1.6%    0%  lru_add_active_pvecs__per_cpu+0x20
    0%  1.6%                   0us                  1045150 98.4%  1.6%    0%    bd_set_size+0x24
    0%    0%                   0us                       21  100%    0%    0%    bd_set_size+0x70

    0%    0%                   0us                        2  100%    0%    0%  pci_boards+0x22c
    0%    0%                   0us                        2  100%    0%    0%    mtrr_ioctl+0x4f8

    0%    0%                   0us                        6  100%    0%    0%  pci_boards+0x234
    0%    0%                   0us                        6  100%    0%    0%    __constant_c_and_count_memset+0x50

    0%    0%                   0us                  1129503  100%    0%    0%  pci_vendor_list+0x4200
    0%    0%                   0us                  1129503  100%    0%    0%    destroy_context+0x4c

    0%    0%                   0us                  1129503  100%    0%    0%  pci_vendor_list+0x47d0
    0%    0%                   0us                  1129503  100%    0%    0%    mtrr_write+0x194

    0%    0%                   0us                      149  100%    0%    0%  pid_hash+0x8680
    0%    0%                   0us                        4  100%    0%    0%    bio_add_page+0xa8
    0%    0%                   0us                      140  100%    0%    0%    load_balance+0x1e8
    0%    0%                   0us                        5  100%    0%    0%    scheduler_tick+0x180

    0%    0%                   0us                  1129503  100%    0%    0%  pid_hash+0x8824
    0%    0%                   0us                  1129503  100%    0%    0%    init_new_context+0xe0

    0%  3.9%                   0us                  2900686 96.1%  3.9%    0%  pid_hash+0x89c0
    0%  4.0%                   0us                  1450343 96.0%  4.0%    0%    __pagevec_lru_add+0xa4
    0%  3.8%                   0us                  1450343 96.2%  3.8%    0%    do_invalidatepage

    0%  6.5%                   0us                  2985077 93.5%  6.5%    0%  pid_hash+0x89e0
    0%  6.8%                   0us                  1492680 93.2%  6.8%    0%    sys_swapon+0xe4
    0% 50.0%                   0us                        2 50.0% 50.0%    0%    sys_swapon+0x1bc
    0%  6.1%                   0us                  1492393 93.9%  6.1%    0%    sys_swapon+0x204
    0%    0%                   0us                        2  100%    0%    0%    sys_swapon+0x244

    0%    0%                   0us                     1089  100%    0%    0%  pid_hash+0x8a00
    0%    0%                   0us                     1089  100%    0%    0%    __block_prepare_write+0x428

    0%  7.6%                   0us                  4513471 92.4%  7.6%    0%  pid_hash+0x8a20
    0% 25.0%                   0us                     4929 75.0% 25.0%    0%    .text.lock.namei+0x74
    0%  8.8%                   0us                   324046 91.2%  8.8%    0%    .text.lock.namei+0x1ac
    0%  7.2%                   0us                  2491551 92.8%  7.2%    0%    __follow_down+0x4c
    0% 50.0%                   0us                        2 50.0% 50.0%    0%    blkdev_put+0x110
    0%  2.4%                   0us                     1185 97.6%  2.4%    0%    count+0x28
    0% 11.4%                   0us                    17982 88.6% 11.4%    0%    do_fcntl+0x154
    0%    0%                   0us                        8  100%    0%    0%    do_open+0x258
    0% 10.0%                   0us                       20 90.0% 10.0%    0%    file_ioctl+0x138
    0%  8.6%                   0us                     6114 91.4%  8.6%    0%    locate_fd+0xd0
    0%  7.6%                   0us                   265244 92.4%  7.6%    0%    send_sigio+0x94
    0%  3.5%                   0us                   368709 96.5%  3.5%    0%    send_sigurg+0x24
    0%  7.4%                   0us                    54539 92.6%  7.4%    0%    send_sigurg+0x84
    0% 10.6%                   0us                   368709 89.4% 10.6%    0%    setfl+0xa8
    0%  9.0%                   0us                   608895 91.0%  9.0%    0%    setfl+0x110
    0%    0%                   0us                        2  100%    0%    0%    sys_ioctl+0xf0
    0%  7.2%                   0us                     1536 92.8%  7.2%    0%    sys_uselib+0x12c

    0%    0%                   0us                      390  100%    0%    0%  pid_hash+0x8a60
    0%    0%                   0us                      195  100%    0%    0%    csi_m+0x258
    0%    0%                   0us                      195  100%    0%    0%    cursor_report+0x2c

    0% 21.7%                   0us                    25815 78.3% 21.7%    0%  tvec_bases__per_cpu+0x24
    0%  7.1%                   0us                     4725 92.9%  7.1%    0%    in_group_p+0xc
    0% 24.9%                   0us                    21090 75.1% 24.9%    0%    sys_getgroups+0x38

    0%    0%                   0us                        1  100%    0%    0%  tvec_bases__per_cpu+0x554
    0%    0%                   0us                        1  100%    0%    0%    .text.lock.mprotect+0x41

    0%    0%                   0us                     1089  100%    0%    0%  tvec_bases__per_cpu+0xac0
    0%    0%                   0us                     1089  100%    0%    0%    get_vm_area+0x4c

    0%    0%                   0us                     1770  100%    0%    0%  tvec_bases__per_cpu+0xc70
    0%    0%                   0us                      225  100%    0%    0%    __getblk_slow+0x40
    0%    0%                   0us                      445  100%    0%    0%    __getblk_slow+0x80
    0%    0%                   0us                      220  100%    0%    0%    clear_inode+0x68
    0%    0%                   0us                      880  100%    0%    0%    clear_inode+0xbc

    0%    0%                   0us                       69  100%    0%    0%  .text.lock.mempool+0x4a
    0% 0.00%                   0us                   670256  100% 0.00%    0%  .text.lock.namei+0xac
    0%    0%                   0us                      587  100%    0%    0%  __bounce_end_io_read+0x38
    0%    0%                   0us                      140  100%    0%    0%  __constant_memcpy+0x10
    0% 0.99%                   0us                   829218 99.0% 0.99%    0%  __constant_memcpy+0xf0
    0% 0.00%                   0us                  2491547  100% 0.00%    0%  __follow_down+0x60
    0% 0.94%                   0us                    21329 99.1% 0.94%    0%  __free_pages_bulk+0x2c
    0%  100%                   0us                  2119165    0%    0%  100%  __free_pages_bulk+0x88
    0% 57.2%                   0us                    30598 42.8% 57.2%    0%  __ioremap+0x20
    0% 0.05%                   0us                    30598  100% 0.05%    0%  __ioremap+0x2c
    0% 78.7%                   0us                     7429 21.3% 78.7%    0%  __ioremap+0x68
    0% 0.01%                   0us                    28980  100% 0.01%    0%  __set_page_dirty_buffers+0x110
    0%  3.5%                   0us                    20255 96.5%  3.5%    0%  balance_dirty_pages+0xb8
    0%    0%                   0us                        4  100%    0%    0%  bio_add_page+0x104
    0%    0%                   0us                        4  100%    0%    0%  bio_alloc+0xf8
    0%    0%                   0us                    23110  100%    0%    0%  cpu_raise_softirq+0x8
    0%    0%                   0us                      142  100%    0%    0%  create_workqueue+0x144
    0%    0%                   0us                   327491  100%    0%    0%  dentry_open+0x14c
    0%    0%                   0us                        7  100%    0%    0%  do_anonymous_page+0x268
    0%    0%                   0us                        7  100%    0%    0%  do_page_fault+0xfc
    0% 0.71%                   0us                   203785 99.3% 0.71%    0%  do_proc_readlink+0x38
    0%    0%                   0us                      901  100%    0%    0%  do_wp_page+0x2cc
    0%    0%                   0us                       22  100%    0%    0%  do_wp_page+0x45c
    0%    0%                   0us                      138  100%    0%    0%  dup_mmap+0x120
    0%    0%                   0us                      138  100%    0%    0%  dup_mmap+0x158
    0%    0%                   0us                      138  100%    0%    0%  dup_mmap+0x220
    0%    0%                   0us                      138  100%    0%    0%  dup_mmap+0xc8
    0% 0.34%                   0us                     1782 99.7% 0.34%    0%  frag_show+0x40
    0%    0%                   0us                  1019899  100%    0%    0%  free_buffer_head+0x34
    0%    0%                   0us                       14  100%    0%    0%  free_one_pmd+0x168
    0% 0.01%                   0us                    11129  100% 0.01%    0%  get_dirty_limits+0x3c
    0%    0%                   0us                   392486  100%    0%    0%  get_empty_filp+0x12c
    0%    0%                   0us                      838  100%    0%    0%  handle_mm_fault+0xe0
    0%    0%                   0us                       14  100%    0%    0%  hugetlb_report_meminfo+0x34
    0%    0%                   0us                  1185123  100%    0%    0%  init_buffer_head+0x4c
    0%    0%                   0us                        7  100%    0%    0%  kmap_atomic+0x14
    0%    0%                   0us                       75  100%    0%    0%  ksoftirqd+0x100
    0%    0%                   0us                       77  100%    0%    0%  ksoftirqd+0x10c
    0%    0%                   0us                      152  100%    0%    0%  ksoftirqd+0x114
    0%    0%                   0us                        5  100%    0%    0%  kunmap+0x20
    0% 0.22%                   0us                   487201 99.8% 0.22%    0%  mem_open+0x8
    0% 0.65%                   0us                   510091 99.4% 0.65%    0%  mounts_release+0x8
    0%    0%                   0us                        2  100%    0%    0%  number+0x1fc
    0%    0%                   0us                      138  100%    0%    0%  proc_doutsstring+0x78
    0% 0.39%                   0us                     1275 99.6% 0.39%    0%  proc_info_read+0x98
    0% 0.38%                   0us                   675021 99.6% 0.38%    0%  proc_pid_cmdline+0x54
    0%    0%                   0us                      714  100%    0%    0%  pte_alloc_kernel+0x74
    0% 12.2%                   0us                   312871 87.8%    0% 12.2%  remap_area_pages+0x1f0
    0%    0%                   0us                        8  100%    0%    0%  risc_code01+0x1490
    0%    0%                   0us                     2186  100%    0%    0%  risc_code01+0x1b24
    0% 0.13%                   0us                     2225 99.9% 0.13%    0%  risc_code01+0x4f9c
    0%    0%                   0us                      129  100%    0%    0%  scheduler_tick+0x2e0
    0% 0.03%                   0us                  1282523  100% 0.03%    0%  search_exception_table+0x3c
    0%    0%                   0us                   265244  100%    0%    0%  send_sigio+0xa0
    0% 0.94%                   0us                 14301378 99.1% 0.94%    0%  send_sigio_to_task+0x30
    0%    0%                   0us                    54539  100%    0%    0%  send_sigurg+0x94
    0%    0%                   0us                        4  100%    0%    0%  sget+0x30
    0%    0%                   0us                      129  100%    0%    0%  shrink_cache+0x264
    0%    0%                   0us                       30  100%    0%    0%  shrink_list+0x420
    0% 0.00%                   0us                  1132765  100% 0.00%    0%  simd_math_error+0x28
    0%    0%                   0us                  1132765  100%    0%    0%  simd_math_error+0x94
    0% 0.10%                   0us                 10704360 99.9% 0.10%    0%  split_large_page+0x4
    0%  2.5%                   0us                    11583 97.5%  2.5%    0%  sys_access+0x150
    0%  3.0%                   0us                    41401 97.0%  3.0%    0%  sys_fstatfs+0x18
    0%    0%                   0us                       14  100%    0%    0%  sys_mincore+0x138
    0%    0%                   0us                        4  100%    0%    0%  sys_semtimedop+0x3fc
    0%    0%                   0us                   174724  100%    0%    0%  udp_queue_rcv_skb+0x5c
    0%  2.4%                   0us                761925513 97.6%    0%  2.4%  udp_recvmsg+0x26c
    0%  3.9%                   0us                  1705264 96.1%  3.9%    0%  valid_swaphandles+0x4c
    0%  1.2%                   0us                     1782 98.8%  1.2%    0%  vmstat_next+0x38
    0% 50.0%                   0us                        2 50.0% 50.0%    0%  vsnprintf+0x20
    0%    0%                   0us                     2518  100%    0%    0%  zap_pte_range+0x2e0
    0%    0%                   0us                      805  100%    0%    0%  zap_pte_range+0x9c

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.02%                                 0us                 26339364  100% 0.02%  *TOTAL*

 0.01%    0%   6.7us     1  6.7us( 628us)    0us                     2196  100%    0%  [0xc1be51c4]
          0%                                 0us                     2196  100%    0%    do_pipe+0x1bc

 0.00%    0%  11.5us     1   11us( 130us)    0us                        3  100%    0%  [0xee6ae8a4]
          0%                                 0us                        3  100%    0%    __constant_memcpy+0x68

 0.00%    0%  13.0us     1   13us( 286us)    0us                     1099  100%    0%  [0xee8c21c0]
          0%                                 0us                     1099  100%    0%    risc_code01+0x4e1c

 55.9%    0%  10.4us     8  271us( 231ms)    0us                        1  100%    0%  [0xef3c858c]
          0%                                 0us                        1  100%    0%    sys_setgroups16+0xcc

 0.04%    0%  19.1us     1   19us( 481us)    0us                        1  100%    0%  [0xf057b3a4]
          0%                                 0us                        1  100%    0%    sys_ioctl+0x38

 0.03%    0%  15.8us     1   16us( 337us)    0us                        1  100%    0%  [0xf057d364]
          0%                                 0us                        1  100%    0%    set_user_nice

 0.01%    0%   6.0us     2  6.1us( 337us)    0us                    11056  100%    0%  __per_cpu_end+0x1c
          0%                                 0us                    11056  100%    0%    pipe_write+0x6c

 0.07%    0% 202.6us     1  203us(1013us)    0us                     3652  100%    0%  pid_hash+0x8660
          0%                                 0us                       18  100%    0%    copy_files+0xd4
          0%                                 0us                       49  100%    0%    internal_add_timer+0x98
          0%                                 0us                     1130  100%    0%    sys_capset+0x64
          0%                                 0us                     2455  100%    0%    sys_personality+0x30

 93.4% 0.08%   7.9us     5  354us( 232ms)    0us                  3151445  100% 0.08%  pid_hash+0x8a40
          0%                                 0us                      639  100%    0%    lease_alloc+0x30
          0%                                 0us                        7  100%    0%    setup_swap_extents+0xa8
       0.08%                                 0us                  2264074  100% 0.08%    try_to_unuse+0xb8
       0.08%                                 0us                   886725  100% 0.08%    try_to_unuse+0x2a8

 1620%    0%   7.5us    15 2027us( 232ms)    0us                 13185756  100%    0%  serial_pci_tbl+0xb8c
          0%                                 0us                 13185756  100%    0%    mm_init+0xb8

          0%                                 0us                    20917  100%    0%  buffered_rmqueue+0x38
          0%                                 0us                    16081  100%    0%  find_local_symbol+0x8
          0%                                 0us                  2513995  100%    0%  get_chrfops+0x15c
          0%                                 0us                    45266  100%    0%  proc_pid_stat+0x120
       0.05%                                 0us                  2864093  100% 0.05%  sys_getgroups16+0x5c
       0.01%                                 0us                    76659  100% 0.01%  sys_setgroups16+0x64
          0%                                 0us                  4447143  100%    0%  sys_swapon+0x16c

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

          0%                   0us                   0us          16216231  100%    0%(   0%)  *TOTAL*

    0%    0%                   0us                   0us                 1  100%    0%(   0%)  [0xe0fff12c]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    task_name+0xb0

    0%    0%                   0us                   0us                 3  100%    0%(   0%)  [0xee6ae8a4]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    generic_shutdown_super+0x84
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    locks_wake_up_blocks+0x58
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    schedule+0x278

    0%    0%                   0us                   0us                 4  100%    0%(   0%)  [0xee78d7c4]
    0%    0%                   0us                   0us                 4  100%    0%(   0%)    free_dma+0x1c

    0%    0%                   0us                   0us            428518  100%    0%(   0%)  __per_cpu_end+0x1c8
    0%    0%                   0us                   0us            428518  100%    0%(   0%)    posix_test_lock+0x28

    0%    0%                   0us                   0us                35  100%    0%(   0%)  cpu_devices+0xb48
    0%    0%                   0us                   0us                35  100%    0%(   0%)    fn_hash_delete+0x1a8

    0%    0%                   0us                   0us                12  100%    0%(   0%)  memblk_devices+0x904
    0%    0%                   0us                   0us                 6  100%    0%(   0%)    __func__.1+0x130d8
    0%    0%                   0us                   0us                 6  100%    0%(   0%)    __func__.1+0x135a4

    0%    0%                   0us                   0us             51985  100%    0%(   0%)  pid_hash+0x8a40
    0%    0%                   0us                   0us             51985  100%    0%(   0%)    __kill_fasync+0x1c

    0%    0%                   0us                   0us                 6  100%    0%(   0%)  __func__.1+0x13104
    0%    0%                   0us                   0us                 6  100%    0%(   0%)  __func__.1+0x13d24
    0%    0%                   0us                   0us                21  100%    0%(   0%)  badness+0x30
    0%    0%                   0us                   0us            338541  100%    0%(   0%)  badness+0xdc
    0%    0%                   0us                   0us                 6  100%    0%(   0%)  de_thread+0x25c
    0%    0%                   0us                   0us            447544  100%    0%(   0%)  de_thread+0x30
    0%    0%                   0us                   0us               105  100%    0%(   0%)  fn_hash_delete+0x220
    0%    0%                   0us                   0us                 4  100%    0%(   0%)  generic_shutdown_super+0x28
    0%    0%                   0us                   0us           1825042  100%    0%(   0%)  get_swap_page+0x8c
    0%    0%                   0us                   0us                20  100%    0%(   0%)  ifind+0x5c
    0%    0%                   0us                   0us                25  100%    0%(   0%)  inode_change_ok+0x98
    0%    0%                   0us                   0us                 2  100%    0%(   0%)  lock_get_status+0x54
    0%    0%                   0us                   0us            392487  100%    0%(   0%)  param_get_intarray+0x5c
    0%    0%                   0us                   0us                20  100%    0%(   0%)  param_set_copystring+0x4c
    0%    0%                   0us                   0us            510098  100%    0%(   0%)  proc_pid_follow_link+0x38
    0%    0%                   0us                   0us           2063912  100%    0%(   0%)  proc_pid_maps_get_line+0x128
    0%    0%                   0us                   0us           2063900  100%    0%(   0%)  proc_pid_maps_get_line+0x48
    0%    0%                   0us                   0us           2332202  100%    0%(   0%)  proc_pid_status+0x120
    0%    0%                   0us                   0us           2105301  100%    0%(   0%)  proc_pid_status+0x184
    0%    0%                   0us                   0us           1492685  100%    0%(   0%)  remove_exclusive_swap_page+0xc
    0%    0%                   0us                   0us           1492406  100%    0%(   0%)  swap_entry_free+0x8
    0%    0%                   0us                   0us            332694  100%    0%(   0%)  swap_info_get+0xe0
    0%    0%                   0us                   0us            338646  100%    0%(   0%)  sys_fchown16+0x24
_________________________________________________________________________________________________________________________
Number of read locks found=10

Hanna, I suspect you're not to blame, but rather the global lock...


-- wli
