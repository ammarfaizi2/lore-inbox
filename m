Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTBCC26>; Sun, 2 Feb 2003 21:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBCC26>; Sun, 2 Feb 2003 21:28:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41412 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265854AbTBCC2z>; Sun, 2 Feb 2003 21:28:55 -0500
Date: Sun, 02 Feb 2003 18:38:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: Benchmarking 59 vs -mm vs -mjb
Message-ID: <130380000.1044239907@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some benchmarks on 16-way NUMA-Q w/ 16 Gb RAM.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                        2.5.59       46.08      563.88      118.38     1480.00
                   2.5.59-mjb1       45.99      566.45      111.98     1474.67
                   2.5.59-mjb2       45.56      564.81      113.29     1487.83
                   2.5.59-mjb3       45.66      565.33      110.18     1479.00
                    2.5.59-mm6       45.95      563.16      115.85     1477.50


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         0.8%
                   2.5.59-mjb1        94.4%         2.0%
                   2.5.59-mjb2        96.1%         2.8%
                   2.5.59-mjb3        96.7%         4.1%
                    2.5.59-mm6       100.4%         0.7%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         0.7%
                   2.5.59-mjb1       119.9%         0.8%
                   2.5.59-mjb2       122.3%         0.8%
                   2.5.59-mjb3       122.6%         0.4%
                    2.5.59-mm6       102.7%         0.8%

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00      235.18     3632.73       15.45
                   2.5.59-mjb1        0.00      232.06     3658.60       15.38
                   2.5.59-mjb2        0.00      233.38     3618.16       15.20
                   2.5.59-mjb3        0.00      236.59     3627.47       15.24
                    2.5.59-mm6        0.00      239.24     3634.88       15.89

----------------------------------------

Summary:

Kernbench is mainly boosted by dcache_rcu and wli's pfn_to_nid and
pgd_ctor changes. (note the system times).

Going from virgin to -mjb gives a small degredation on SDET 1,2,4. 
but a good boost on SDET 8 up to 64. I presume this is a NUMA scheduler
effect, but haven't confirmed yet. I have Ingo's B0 patch apart from the
topo cleanup ... not really too worried about this - slight effect on
a huge machine at very low loads.

NUMA schedbench results are really very boring.

-----------------------------------------

kernbench-2
diffprofile 2.5.59 2.5.59-mjb3 (+ is worse in -mjb, - better).

2541 do_schedule
2112 .text.lock.file_table
422 file_move
265 prepare_to_wait
215 get_empty_filp
186 kmem_cache_alloc
121 find_get_page
116 eventpoll_init_file
95 do_anonymous_page
94 vm_enough_memory
91 file_ra_state_init
80 __copy_to_user_ll
72 vfs_read
58 mark_page_accessed
56 default_wake_function
52 __wake_up
51 pte_chain_alloc
...
-51 strnlen_user
-51 profile_exit_mmap
-61 __pte_chain_free
-68 buffered_rmqueue
-71 .text.lock.dcache
-84 fd_install
-101 kmem_cache_free
-115 eventpoll_release
-171 may_open
-173 path_lookup
-179 find_trylock_page
-183 kmalloc
-235 vfs_follow_link
-248 clear_page_tables
-259 prepare_to_wait_exclusive
-274 pgd_alloc
-441 path_release
-624 dput
-625 pfn_to_nid
-889 default_idle
-931 current_kernel_time
-933 __fput
-1135 dget_locked
-1382 link_path_walk
-2060 __d_lookup
-2398 schedule
-2881 .text.lock.dec_and_lock
-5163 .text.lock.namei
-8863 total

---------------------------------------------------------

SDET 64
diffprofile 2.5.59 2.5.59-mjb3 (+ is worse in -mjb, - better).

56544 default_idle
8837 __down
7385 do_schedule
3538 page_remove_rmap
2830 .text.lock.file_table
2665 __wake_up
1429 page_add_rmap
1209 d_lookup
873 find_get_page
799 follow_mount
458 release_pages
425 kmem_cache_alloc
418 file_move
360 get_empty_filp
272 ext2_new_block
263 ext2_free_blocks
261 vfs_read
...
-245 .text.lock.dir
-284 pte_alloc_one
-288 may_open
-307 set_fs_pwd
-309 proc_check_root
-358 find_trylock_page
-360 vfs_follow_link
-371 real_lookup
-425 open_namei
-430 sys_unlink
-436 pfn_to_nid
-489 d_delete
-524 d_rehash
-568 __fput
-570 prune_dcache
-598 kmalloc
-717 d_alloc
-865 pgd_alloc
-920 dput
-1053 d_instantiate
-1233 path_release
-1275 dget_locked
-1293 kmem_cache_free
-1354 .text.lock.attr
-1502 .text.lock.namespace
-1646 .text.lock.base
-1750 clear_page_tables
-2063 current_kernel_time
-2373 __d_lookup
-2774 link_path_walk
-3407 do_lookup
-4215 schedule
-5388 atomic_dec_and_lock
-7874 path_lookup
-25037 .text.lock.dcache
-33737 .text.lock.dec_and_lock
-55200 .text.lock.namei
-73012 total

---------------------------------------------------

SDET 1
diffprofile 2.5.59 2.5.59-mjb3 (+ is worse in -mjb, - better).
(though the tick count is small, this is the average of 5 runs).

988 total
930 default_idle
10 d_lookup
8 page_remove_rmap
8 do_schedule
7 page_add_rmap
6 __copy_to_user_ll
5 kmem_cache_alloc
5 do_wp_page
...
-5 schedule
-6 link_path_walk
-7 pfn_to_nid
-12 __d_lookup


