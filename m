Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263660AbTCVP5q>; Sat, 22 Mar 2003 10:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263646AbTCVP4M>; Sat, 22 Mar 2003 10:56:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:36071 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262897AbTCVPzW>; Sat, 22 Mar 2003 10:55:22 -0500
Date: Sat, 22 Mar 2003 08:06:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       dmccr@us.ibm.com
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.65-mm2 vs 2.5.65-mm3 (full objrmap)
Message-ID: <362150000.1048349169@[10.10.2.4]>
In-Reply-To: <20030320235821.1e4ff308.akpm@digeo.com>
References: <20030320235821.1e4ff308.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> . Added Hugh's new rmap-without-pte_chains-for-anon-pages patches.  Mainly
>   for interested parties to test and benchmark at this stage.
> 
>   It seems to be stable, however it is not clear that this passes the
>   benefit-vs-disruption test.

I see very little impact either way. My initial analysis showed that 90%
of the anonymous mappings were singletons, so the chain manipulation costs
are probably very low. If there's a workload that has long anonymous chains,
and manipulates them a lot, that might benefit. 

However, I thought there might be some benefit in the fork/exec cycle 
(which presumably sets up a new chain instead of the direct mapping then
tears it down again) ... but seemingly not. Did you keep the pte_direct
optimisation? That seems worth keeping, with partial objrmap as well
(I think that was removed in Dave's patch, but would presumably be easy
to put back). Or maybe we just need some more tuning ;-)

Results from 16x NUMA-Q below (that seems to have severe problems with
pte_chains, so is a good testbed for these things... )

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.65-mm2       44.04       80.63      566.83     1469.25
               2.5.65-mm3       44.21       80.57      567.61     1466.00

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.65-mm2       44.27       88.56      574.21     1496.75
               2.5.65-mm3       44.10       89.24      574.70     1503.75

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.65-mm2       44.30       86.09      572.75     1488.25
               2.5.65-mm3       44.36       86.86      573.28     1486.25


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         2.2%
               2.5.65-mm3        98.9%         2.0%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         2.7%
               2.5.65-mm3        97.1%         2.3%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         1.3%
               2.5.65-mm3       103.5%         1.3%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         1.0%
               2.5.65-mm3        98.0%         1.0%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         0.6%
               2.5.65-mm3        99.4%         1.0%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         0.2%
               2.5.65-mm3       101.7%         0.5%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         0.1%
               2.5.65-mm3       101.0%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm2       100.0%         0.5%
               2.5.65-mm3       100.8%         0.6%


diffprofile (kernbench, + worse in -mm3)

       353     0.0% set_page_dirty
       284     0.0% try_to_unmap_one
       224    17.1% page_add_rmap
       193     5.8% find_get_page
       142     1.8% d_lookup
       113    10.6% link_path_walk
        67     0.0% page_dup_rmap
        56     9.4% __wake_up
        53     0.0% rmap_get_cpu
        46     8.8% find_vma
        45     8.6% fd_install
        44     0.0% page_turn_rmap
        40    14.6% do_lookup
        37     9.9% .text.lock.file_table
        36     2.1% buffered_rmqueue
        35     5.5% copy_process
        34    10.5% pgd_ctor
        33    97.1% exit_mmap
        31     4.9% handle_mm_fault
...
       -36   -80.0% profile_exit_mmap
       -51   -14.9% pte_alloc_map
       -53   -27.5% install_page
       -99  -100.0% pte_chain_alloc
      -127    -8.4% free_hot_cold_page
      -128    -0.9% do_anonymous_page
      -158  -100.0% __pte_chain_free
      -238   -16.4% do_no_page
      -293   -12.0% page_remove_rmap
      -330    -0.2% total
      -355  -100.0% __set_page_dirty_buffers
      -666    -1.4% default_idle



diffprofile (sdet, + worse in -mm3)

      2139     0.0% try_to_unmap_one
      2032     0.0% page_dup_rmap
      1508     0.0% set_page_dirty
      1448     0.0% page_turn_rmap
       223     9.9% link_path_walk
       169     2.8% .text.lock.dcache
       168     3.0% .text.lock.namei
       158     1.9% find_get_page
       139     1.2% d_lookup
       104     6.8% .text.lock.attr
        98    32.9% exit_mmap
        97     5.0% d_alloc
        93    21.8% generic_delete_inode
        92    89.3% __blk_queue_bounce
        90     0.0% rmap_get_cpu
        83     0.9% .text.lock.dec_and_lock
        70     0.0% dup_rmap
        69     0.6% atomic_dec_and_lock
        67    24.6% find_group_other
        65     8.2% new_inode
        59     0.9% path_lookup
        50     4.8% prune_dcache
        50     2.9% .text.lock.base
...
       -51   -22.6% ext2_new_block
       -56    -6.1% read_block_bitmap
       -60    -3.6% __read_lock_failed
       -66    -3.7% current_kernel_time
       -67    -4.0% __find_get_block
       -78   -21.9% group_reserve_blocks
       -83    -2.5% do_anonymous_page
       -84   -22.3% truncate_inode_pages
       -85    -5.4% real_lookup
       -87   -27.6% unlock_page
      -106   -59.6% profile_exit_mmap
      -107  -100.0% pte_chain_alloc
      -134   -41.0% install_page
      -158  -100.0% __pte_chain_free
      -170    -6.4% kmem_cache_free
      -170    -9.9% __wake_up
      -202   -41.7% grab_block
      -253    -1.7% copy_page_range
      -266    -3.9% __copy_to_user_ll
      -328    -1.7% zap_pte_range
      -626    -6.9% release_pages
      -679   -19.0% __down
      -730   -23.9% do_no_page
     -1492  -100.0% __set_page_dirty_buffers
     -2051    -0.6% default_idle
     -3399   -22.3% page_remove_rmap
     -4052   -54.8% page_add_rmap
     -6486    -1.0% total



