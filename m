Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTDUPuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDUPuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:50:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3283 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261528AbTDUPuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:50:04 -0400
Date: Mon, 21 Apr 2003 09:01:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.67-mm1 vs 2.5.68-mm1
Message-ID: <30710000.1050940919@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the vma sorting is hurting (contention on i_shared_sem). It also
only gains a factor of about 2 in the corner case you were worried about
... any ideas on ways to make it cheaper? We need something more dramatic
anyway (though the other solutions I have revolve around the same
contention problem ;-( ) I just backed it out for now in my stuff.

Note systimes on kernel compiles, and SDET throughput.

M.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.67-mm1       44.02       80.92      567.78     1473.00
               2.5.68-mm1       44.14       82.82      567.21     1472.25

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.67-mm1       44.76       89.40      576.67     1487.50
               2.5.68-mm1       44.84       95.52      576.48     1498.25

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.67-mm1       44.77       87.34      576.85     1482.75
               2.5.68-mm1       45.18       96.24      576.75     1489.75


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         2.2%
               2.5.68-mm1       103.5%         2.3%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         3.9%
               2.5.68-mm1       101.8%         2.7%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.9%
               2.5.68-mm1        98.7%         2.3%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.9%
               2.5.68-mm1        96.9%         0.9%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.8%
               2.5.68-mm1        89.7%         0.2%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.3%
               2.5.68-mm1        76.6%         0.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.3%
               2.5.68-mm1        75.5%         0.1%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.67-mm1       100.0%         0.2%
               2.5.68-mm1        78.7%         0.2%

diffprofile 2.5.6{7,8}-mm1/kernbench/0/profile
      6159     4.4% total
      3786     0.0% move_vma_start
      3158  3222.4% __vma_link
       762  8466.7% __down
       522   293.3% may_open
       478    16.5% zap_pte_range
       458    74.2% __wake_up
       438    13.2% find_get_page
       400   102.3% remove_shared_vm_struct
       332    23.1% schedule
       282     0.0% install_page
       257     4.9% __copy_to_user_ll
       255     7.7% __copy_from_user_ll
       198    47.9% copy_page_range
       133    21.6% sys_brk
       115     5.2% page_remove_rmap
...
      -100    -0.7% do_anonymous_page
      -100    -8.3% file_move
      -127   -10.7% link_path_walk
      -128    -6.5% path_lookup
      -179    -2.2% __d_lookup
      -224   -72.3% do_lookup
      -433   -21.4% do_page_fault
      -447   -57.7% filemap_nopage
      -493   -25.1% do_no_page
      -535   -85.3% dentry_open
      -776   -38.5% page_add_rmap
     -2452    -4.8% default_idle

 diffprofile 2.5.6{7,8}-mm1/sdetbench/128/profile
    117130    18.0% total
     92204    26.2% default_idle
     28537   962.5% __down
      9253   378.1% schedule
      9119   596.4% __wake_up
      6573     0.0% move_vma_start
      4587  1176.2% __vma_link
      1899    45.7% remove_shared_vm_struct
      1805    47.2% do_wp_page
      1467    11.0% copy_page_range
       978    30.6% copy_mm
       506    68.2% vma_link
       490     0.0% install_page
       395   411.5% rb_insert_color
       354     2.0% zap_pte_range
       347    55.3% task_mem
       320    29.4% __block_prepare_write
       314    52.7% may_open
       313  2235.7% cpu_idle
       304    33.6% __copy_user_intel
       294   490.0% default_wake_function
       276     8.2% do_anonymous_page
       219   509.3% __vma_link_rb
...
      -206   -17.5% ext2_new_inode
      -208   -14.1% number
      -208  -100.0% pid_revalidate
      -209   -22.9% update_atime
      -214   -41.9% d_path
      -222   -26.7% proc_root_link
      -231   -20.0% __mark_inode_dirty
      -234   -13.9% release_task
      -238   -10.5% do_page_fault
      -244   -47.7% ext2_new_block
      -253    -1.8% page_remove_rmap
      -259   -62.3% do_lookup
      -271   -22.7% file_kill
      -287   -39.9% ext2_get_group_desc
      -289   -15.7% __find_get_block
      -292   -43.4% __find_get_block_slow
      -292   -30.4% dput
      -296   -21.0% __brelse
      -312   -36.4% d_instantiate
      -313   -12.6% link_path_walk
      -348   -39.1% prune_dcache
      -352   -18.6% current_kernel_time
      -358   -24.4% fd_install
      -369   -25.7% __fput
      -410   -34.9% flush_signal_handlers
      -424   -28.0% .text.lock.highmem
      -450   -65.5% dentry_open
      -456   -24.4% d_alloc
      -475   -45.0% proc_check_root
      -525   -21.6% file_move
      -555   -21.0% proc_pid_stat
      -631   -38.6% grab_block
      -643   -49.5% .text.lock.attr
      -648    -7.6% release_pages
      -675   -45.0% .text.lock.file_table
      -718   -47.7% .text.lock.base
      -749   -27.9% kmem_cache_free
      -788   -48.2% __read_lock_failed
      -882   -38.5% filemap_nopage
      -918   -35.3% path_release
      -947   -20.8% .text.lock.filemap
      -994   -22.3% do_no_page
     -1037   -93.8% task_vsize
     -1068   -13.1% page_add_rmap
     -1591   -13.8% __d_lookup
     -1830   -27.6% path_lookup
     -2116   -61.3% .text.lock.namei
     -2399   -39.5% follow_mount
     -2987   -61.0% .text.lock.dcache
     -3705   -38.0% atomic_dec_and_lock
     -4444   -61.7% .text.lock.dec_and_lock


