Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269262AbTCBSOW>; Sun, 2 Mar 2003 13:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269263AbTCBSOW>; Sun, 2 Mar 2003 13:14:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27021 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269262AbTCBSOT>; Sun, 2 Mar 2003 13:14:19 -0500
Date: Sun, 02 Mar 2003 10:24:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <47970000.1046629477@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Tested, boots, and runs on NUMA-Q. Trims 6s of 41s off kernel compiles.

Odd. I get nothing like that difference.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.63-mjb2       44.43      557.16       95.31     1467.83
      2.5.63-mjb2-pernode       44.21      556.92       95.16     1474.33

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.63-mjb2       45.39      560.26      117.25     1492.33
      2.5.63-mjb2-pernode       44.78      560.24      112.20     1501.17

No difference for make -j32, definite improvement in the systime for -j256.

Measurement error? Different test (make -j 65536? ;-))
The full output of the time command (systime, user, elapsed, etc)
and profiles might be useful in working out why we have this disparity.
(diffprofile at end)

It also seems to slow SDET down a fraction:

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         0.9%
      2.5.63-mjb2-pernode        92.8%         2.9%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         6.5%
      2.5.63-mjb2-pernode        97.7%         3.2%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         2.3%
      2.5.63-mjb2-pernode        97.9%         3.5%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         3.3%
      2.5.63-mjb2-pernode       101.0%         2.6%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         2.7%
      2.5.63-mjb2-pernode       103.8%         3.1%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         0.6%
      2.5.63-mjb2-pernode        96.0%         1.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.5.63-mjb2       100.0%         1.2%
      2.5.63-mjb2-pernode        96.8%         1.2%

Any chance you could split the patch up a bit, maybe roughly along the
lines of the following groupings:

> (6)  per_cpu()/__get_cpu_var() needs to parenthesize the cpu arg
> (2)  make irq_stat[] per_cpu, x86-only
> (3)  make mmu_gathers[] per_cpu, with comcomitant divorce from asm-generic
> (16) make task_cache per_cpu
> (17) make runqueues[] per_cpu
> (19) make reap_timers[] per_cpu


> (1) reuse the arch/i386/discontigmem.c per-node mem_map[] virtual remap
> 	to remap node-local memory backing per_cpu and per_node areas
> (8)  added MAX_NODE_CPUS for pessimistic sizing of virtual remapping arenas
> (13) declare MAX_NODE_CPUS in include/asm-i386/srat.h
> (4)  delay discontig zone_sizes_init() to dodge bootstrap order issues
> (5)  add .data.pernode section handling in vmlinux.lds.S
> (7)  introduced asm-generic/pernode.h to do similar things as percpu.h
> (10) #undef asm-i386/per{cpu,node}.h's __GENERIC_PER_{CPU,NODE}
> (11) declare setup_per_cpu_areas() in asm-i386/percpu.h
> (12) make an asm-i386/pernode.h stub header like include/asm-generic/pernode.h
> (15) call setup_per_node_areas() in init/main.c, with analogous hooks


> (18) make node_nr_running[] per_node
> (14) make zone_table[] per_node


> (9)  fix return type error in NUMA-Q get_zholes_size()

diffprofile for kernbench -j256
(+ worse with patch, - better)


        60   125.0% page_address
        30     3.9% d_lookup
        28    18.4% path_lookup
        15    10.5% do_schedule
        12    63.2% __pagevec_lru_add_active
        11    47.8% bad_range
        10    15.9% kmap_atomic
...
       -11   -18.3% file_ra_state_init
       -11    -3.9% zap_pte_range
       -12    -5.5% page_add_rmap
       -14    -6.8% file_move
       -15   -17.9% strnlen_user
       -20    -4.3% vm_enough_memory
       -38   -13.9% __fput
       -39    -8.4% get_empty_filp
       -43   -14.5% atomic_dec_and_lock
      -389    -8.3% default_idle
      -552   -26.1% .text.lock.file_table
      -931    -5.6% total

diffprofile for SDET 64:
(+ worse with patch, - better)


      1294     2.7% total
      1057     3.1% default_idle
       225    10.5% __down
        86    13.1% __wake_up
        48    66.7% page_address
        41     4.8% do_schedule
        37    77.1% kmap_atomic
        25    12.8% __copy_to_user_ll
        20     4.5% page_remove_rmap
        16   320.0% bad_range
        15    13.0% path_lookup
        14    18.4% copy_mm
        12     4.0% release_pages
        11    33.3% read_block_bitmap
        11     2.3% copy_page_range
        10    25.6% path_release
        10     3.2% page_add_rmap
         9    16.7% free_hot_cold_page
         9   450.0% page_waitqueue
         7    36.8% ext2_get_group_desc
         6    12.0% proc_pid_stat
         6     5.0% vfs_read
         6    26.1% kmem_cache_alloc
         6    35.3% alloc_inode
         6    46.2% mark_page_accessed
         5    22.7% ext2_update_inode
         5    45.5% __blk_queue_bounce
         5    55.6% exec_mmap
...
        -5   -23.8% real_lookup
        -5   -25.0% exit_mmap
        -5   -25.0% do_page_cache_readahead
        -5    -3.6% do_anonymous_page
        -5    -7.9% follow_mount
        -5   -18.5% generic_delete_inode
        -5   -45.5% kunmap_high
        -6   -17.6% __copy_user_intel
        -7   -23.3% dentry_open
        -8   -40.0% default_wake_function
        -8   -10.1% filemap_nopage
        -9   -12.2% __find_get_block_slow
        -9    -8.7% ext2_free_blocks
       -11    -5.9% atomic_dec_and_lock
       -13    -9.0% __fput
       -15   -75.0% mark_buffer_dirty
       -19    -5.3% find_get_page
       -20   -23.5% file_move
       -22   -20.8% __find_get_block
       -37   -14.1% get_empty_filp
      -175   -39.1% .text.lock.file_table



