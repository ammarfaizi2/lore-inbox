Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbTGJBWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbTGJBWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:22:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10696 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266246AbTGJBWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:22:06 -0400
Date: Wed, 09 Jul 2003 18:36:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <80050000.1057800978@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'm pleased to announce the first public release of the "4GB/4GB VM split"
> patch, for the 2.5.74 Linux kernel:
> 
>    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
> 
> The 4G/4G split feature is primarily intended for large-RAM x86 systems,
> which want to (or have to) get more kernel/user VM, at the expense of
> per-syscall TLB-flush overhead.

wli pointed out that the only problem with the NUMA boxen was that you
left out "remap_numa_kva();" from pagetable_init - sticking it back at the
end works fine.

Preliminary benchmark results:

2.5.74-bk6-44 is with the patch applied
2.5.74-bk6-44-on is with the patch applied and config option turned on.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.5.74       46.11      115.86      571.77     1491.50
            2.5.74-bk6-44       45.92      115.71      570.35     1494.75
         2.5.74-bk6-44-on       48.11      134.51      583.88     1491.75

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.1%
            2.5.74-bk6-44       100.3%         0.7%
         2.5.74-bk6-44-on        92.1%         0.2%

Which isn't too bad at all, considering ... highpte does this to it:

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.73-mm3       45.38      114.91      565.81     1497.75
       2.5.73-mm3-highpte       46.54      130.41      566.84     1498.00

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
               2.5.73-mm3       100.0%         0.3%
       2.5.73-mm3-highpte        94.8%         0.6%

(I don't have highpte results for higher SDET right now - I'll run 
'em later).

diffprofile for kernbench (- is better with 4/4 on, + worse)

     15066     9.2% total
     10883     0.0% rw_vm
      3686   170.3% do_page_fault
      1652     3.4% default_idle
      1380     0.0% str_vm
      1256     0.0% follow_page
      1012     7.2% do_anonymous_page
       669   119.7% kmap_atomic
       611    78.1% handle_mm_fault
       563     0.0% get_user_pages
       418    41.4% clear_page_tables
       338    66.3% page_address
       304    16.9% buffered_rmqueue
       263   222.9% kunmap_atomic
       161     2.0% __d_lookup
       152    21.8% sys_brk
       151    26.3% find_vma
       138    24.3% pgd_alloc
       135     9.3% schedule
       133     0.6% page_remove_rmap
       128     0.0% put_user_size
       123     3.4% find_get_page
       121     8.4% free_hot_cold_page
       106     3.3% zap_pte_range
        99    11.1% filemap_nopage
        97     1.5% page_add_rmap
        84     7.5% file_move
        79     6.6% release_pages
        65     0.0% get_user_size
        59    15.7% file_kill
        52     0.0% find_extend_vma
...
       -50   -47.2% kmap_high
       -63   -10.8% fd_install
       -76  -100.0% bad_get_user
       -86   -11.6% pte_alloc_one
      -109  -100.0% direct_strncpy_from_user
      -151  -100.0% __copy_user_intel
      -878  -100.0% direct_strnlen_user
     -3505  -100.0% __copy_from_user_ll
     -5368  -100.0% __copy_to_user_ll

and for SDET:

     63719     8.1% total
     39097     9.8% default_idle
     12494     0.0% rw_vm
      4820   192.6% do_page_fault
      3587    36.4% clear_page_tables
      3341     0.0% follow_page
      1744     0.0% str_vm
      1297   138.4% kmap_atomic
      1026    43.8% pgd_alloc
      1010     0.0% get_user_pages
       932    27.6% do_anonymous_page
       877   100.2% handle_mm_fault
       828    14.2% path_lookup
       605    42.9% page_address
       552    13.3% do_wp_page
       496   216.6% kunmap_atomic
       455     4.1% __d_lookup
       441     2.5% zap_pte_range
       415    12.8% do_no_page
       408    36.7% __block_prepare_write
       349     2.5% copy_page_range
       331    12.3% filemap_nopage
       308     0.0% put_user_size
       305    43.9% find_vma
       266    35.7% update_atime
       212     2.3% find_get_page
       209     8.4% proc_pid_stat
       196     9.1% schedule
       188     7.7% buffered_rmqueue
       186     5.2% pte_alloc_one
       166    13.7% __find_get_block
       162    15.1% __mark_inode_dirty
       159     9.1% current_kernel_time
       155    18.1% grab_block
       149     1.5% release_pages
       124     2.6% follow_mount
       118     7.6% ext2_new_inode
       117     5.6% path_release
       113    28.2% __free_pages
       113     0.0% get_user_size
       107    12.1% dnotify_parent
       105    20.8% __alloc_pages
       102    18.4% generic_file_aio_write_nolock
       102     4.7% file_move
...
      -101    -6.5% __set_page_dirty_buffers
      -102   -30.7% kunmap_high
      -104   -13.4% .text.lock.base
      -108    -3.9% copy_process
      -114   -13.4% unmap_vmas
      -121    -5.0% link_path_walk
      -127   -10.5% __read_lock_failed
      -128   -24.3% set_page_address
      -180  -100.0% bad_get_user
      -237   -11.6% .text.lock.namei
      -243  -100.0% direct_strncpy_from_user
      -262    -0.3% page_remove_rmap
      -310    -5.6% kmem_cache_free
      -332    -4.4% atomic_dec_and_lock
      -365   -35.3% kmap_high
      -458   -15.7% .text.lock.dcache
      -583   -22.8% .text.lock.filemap
      -609   -13.4% .text.lock.dec_and_lock
      -649   -54.9% .text.lock.highmem
      -848  -100.0% direct_strnlen_user
      -877  -100.0% __copy_user_intel
      -958  -100.0% __copy_from_user_ll
     -1098    -2.7% page_add_rmap
     -6746  -100.0% __copy_to_user_ll


I'll play around some more with it later. Presumably things like
disk / network intensive workloads that generate a lot of interrupts
will be bad ... but NAPI would help?

What I *really* like is that without the config option on, there's
no degredation ;-)

M.

