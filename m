Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbTDBBJ2>; Tue, 1 Apr 2003 20:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbTDBBJ2>; Tue, 1 Apr 2003 20:09:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31141 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261281AbTDBBJX>; Tue, 1 Apr 2003 20:09:23 -0500
Date: Tue, 01 Apr 2003 17:10:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.66-mm2
Message-ID: <151780000.1049245829@flay>
In-Reply-To: <20030401000127.5acba4bc.akpm@digeo.com>
References: <20030401000127.5acba4bc.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +ext3-concurrent-block-allocation-hashed.patch
> 
>  Change the ext3 BKL-removal code to use the hashed locking and
>  percpu_counters from ext2.

Ho hum. All very strange. Kernbench seems to be really behaving itself
quite well now, but SDET sucks worse than ever. The usual 16x NUMA-Q 
machine .... 

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.66-mm2       44.04       81.12      569.40     1476.75
          2.5.66-mm2-ext3       44.43       84.10      568.82     1469.00

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.66-mm2       44.36       89.64      575.45     1499.25
          2.5.66-mm2-ext3       44.79       91.15      575.48     1488.25

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.66-mm2       44.06       87.03      574.31     1501.00
          2.5.66-mm2-ext3       44.35       89.33      573.47     1495.75


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         1.9%
          2.5.66-mm2-ext3        92.6%         1.8%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         0.0%
          2.5.66-mm2-ext3        88.4%         5.1%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         1.9%
          2.5.66-mm2-ext3        26.3%         7.8%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         1.0%
          2.5.66-mm2-ext3         8.0%         3.1%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         1.0%
          2.5.66-mm2-ext3         5.6%         1.6%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         0.7%
          2.5.66-mm2-ext3         4.7%         1.5%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         0.7%
          2.5.66-mm2-ext3         3.6%         1.9%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         0.6%
          2.5.66-mm2-ext3         3.9%         0.4%

diffprofile for SDET 128 (+ worse with ext3, - better)

  10410044  1594.1% total
   8799596  2479.9% default_idle
    649656  15845.3% __down
    347530     0.0% .text.lock.sched
    218233  8660.0% schedule
    183618  9984.7% __wake_up
    117605     0.0% .text.lock.transaction
     30896     0.0% do_get_write_access
     18162  1319.9% .text.lock.attr
     14815     0.0% journal_dirty_metadata
     13655     0.0% journal_get_write_access
     12762  79762.5% cpu_idle
     11023  7252.0% __blk_queue_bounce
      9404     0.0% start_this_handle
      9310     0.0% journal_add_journal_head
      5566     0.0% block_write_full_page
      5478     0.0% journal_stop
      4210     0.0% ext3_get_inode_loc
      4127   668.9% __find_get_block_slow
      3852  1965.3% .text.lock.sem
      3660     0.0% ext3_mark_iloc_dirty
      3630   184.5% __find_get_block
      3360   239.8% __brelse
      2911     0.0% ext3_do_update_inode
      2672  16700.0% scsi_request_fn
      2565     0.0% journal_start
      2432     0.0% journal_commit_transaction
      1945     0.0% journal_unlock_journal_head
      1937     0.0% ext3_new_inode
      1820     0.0% ext3_orphan_del
      1731  13315.4% __make_request
      1606  1784.4% .text.lock.ioctl
      1591   103.9% .text.lock.base
      1575     0.0% find_next_usable_block
      1563   142.2% __block_prepare_write
      1483     0.0% ext3_orphan_add
      1428     0.0% __journal_unfile_buffer
      1367     0.0% journal_get_undo_access
      1365   156.7% kmap_atomic
      1360  1766.2% default_wake_function
      1344    40.5% do_anonymous_page
      1232     0.0% ext3_reserve_inode_write
      1180    64.7% current_kernel_time
      1172     0.0% journal_invalidatepage
      1139   136.4% kmalloc
      1121  37366.7% mempool_alloc
      1017     0.0% __journal_file_buffer
...
     -1080   -55.4% d_alloc
     -1105   -67.4% filemap_nopage
     -1153  -100.0% ext2_new_inode
     -1182   -37.3% pte_alloc_one
     -1186   -46.4% copy_process
     -1470   -98.4% .text.lock.highmem
     -1496   -95.2% .text.lock.file_table
     -1555   -64.2% file_move
     -1596   -94.4% __read_lock_failed
     -1601   -61.8% path_release
     -1602  -100.0% grab_block
     -1649   -51.0% copy_mm
     -2413   -57.4% remove_shared_vm_struct
     -2540   -78.9% free_pages_and_swap_cache
     -3236   -93.1% .text.lock.namei
     -3600   -47.5% page_add_rmap
     -4671   -72.9% path_lookup
     -4720   -95.8% .text.lock.dcache
     -4921   -42.9% __d_lookup
     -5140   -86.9% follow_mount
     -6005   -39.7% copy_page_range
     -6534   -72.0% release_pages
     -6905   -94.2% .text.lock.dec_and_lock
     -7158   -74.2% atomic_dec_and_lock
     -7307   -47.3% page_remove_rmap
     -9399   -48.2% zap_pte_range

Looks just like horrific semaphore contention to me.

I dumped the full results to:
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/benchmarks/2.5.66-mm2/
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/benchmarks/2.5.66-mm2-ext3/
as you probably want the gory detail, knowing you ;-)

M.

