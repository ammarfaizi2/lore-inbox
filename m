Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269327AbTCDIB1>; Tue, 4 Mar 2003 03:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269329AbTCDIB1>; Tue, 4 Mar 2003 03:01:27 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9639 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269327AbTCDIBW>; Tue, 4 Mar 2003 03:01:22 -0500
Date: Tue, 04 Mar 2003 00:11:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Odd benchmark results ... 62 vs -mm vs -mjb
Message-ID: <108650000.1046765495@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The usual 16x NUMA-Q system ... this is all cache warm out of pagecache, so
I don't see why AS would make a difference. -mm and -mjb are fairly
consistent (as I'd expect) except for kernbench -j256 (the middle one)
where you somehow do dramtically better (on systime especially). These are
the averages of 5 runs, and they only move by a second or two of systime,
so I don't think it's experimental error. I ran SDET as well, but it wasn't
very interesting.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.63       45.47      111.20      563.81     1483.50
               2.5.63-mm2       44.27       94.30      562.88     1484.00
              2.5.63-mjb2       44.09       94.38      557.26     1477.00

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.63       47.09      138.43      567.92     1499.25
               2.5.63-mm2       44.94      108.35      565.37     1497.50
              2.5.63-mjb2       45.53      118.06      560.48     1489.50

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.5.63       47.30      138.33      568.13     1497.00
               2.5.63-mm2       45.62      119.91      565.66     1499.25
              2.5.63-mjb2       45.17      117.80      560.62     1500.50


diffprofile 2.5.63-mm2 2.5.63-mjb2 (both have objrmap + fixes)
(+ gets worse going from -mm to -mjb, - better) for -j256.

     12196     7.9% total
      9773    81.5% .text.lock.file_table
      3484     7.5% default_idle
       915   554.5% do_generic_mapping_read
       823    21.5% get_empty_filp
       569    26.8% __fput
       462    76.0% dput
       457    11.2% vm_enough_memory
       456    29.9% file_move
       386    21.6% page_add_rmap
       215     1.5% do_anonymous_page
       151    23.3% fd_install
       137   415.2% eventpoll_init_file
       117   354.5% kmem_cache_alloc
       100     0.0% pmd_ctor
        82    18.3% file_ra_state_init
        70     0.0% update_atime
        67     1.4% __copy_to_user_ll
        63     2.2% zap_pte_range
        62    24.0% __set_page_dirty_buffers
        59     3.8% buffered_rmqueue
        55     2.0% atomic_dec_and_lock
        52    44.1% filp_close
        51     4.5% vfs_read
        50    33.3% prep_new_page
...
       -52  -100.0% free_pages_bulk
       -54   -73.0% lru_cache_add
       -56  -100.0% migration_task
       -57   -18.6% flush_signal_handlers
       -68   -69.4% set_cpus_allowed
       -68   -10.3% kmap_atomic
       -69   -49.6% set_page_address
       -75   -60.0% sched_best_cpu
       -80  -100.0% prepare_to_wait_exclusive
       -82   -26.3% exit_notify
       -90   -25.0% remove_shared_vm_struct
      -108   -84.4% kmalloc
      -110   -44.0% kmem_cache_free
      -151   -88.3% eventpoll_release
      -172   -19.1% strnlen_user
      -180  -100.0% pgd_ctor
      -207   -45.3% complete
      -207  -100.0% find_trylock_page
      -210  -100.0% one_sec_update_atime
      -276  -100.0% __down
      -292   -90.7% current_kernel_time
      -351   -35.1% clear_page_tables
      -409   -53.9% __wake_up
      -543   -28.2% path_lookup
      -567   -25.9% do_schedule
      -707   -38.1% do_no_page
      -736   -23.0% find_get_page

OK, so who killed .text.lock.file_table? and how? ;-)

If I do a "-j" instead (infinte tasks), it looks boringly similar
from the results, but the profiles tell a different story:
(+ gets worse going from -mm to -mjb, - better)

      3426    18.3% .text.lock.file_table
       937   574.8% do_generic_mapping_read
       610    14.6% vm_enough_memory
       470    72.3% dput
       285     2.0% do_anonymous_page
       260    14.8% page_add_rmap
       161    10.4% buffered_rmqueue
       158   493.8% eventpoll_init_file
       130     0.0% pmd_ctor
       107    44.0% __set_page_dirty_buffers
        99    12.8% fd_install
        92    58.2% prep_new_page
        64   177.8% kmem_cache_alloc
        60     0.0% update_atime
...
       -50  -100.0% free_pages_bulk
       -53   -72.6% lru_cache_add
       -55   -15.1% remove_shared_vm_struct
       -56    -2.7% do_page_fault
       -57    -9.1% copy_process
       -59  -100.0% migration_task
       -65   -56.5% wait_for_completion
       -69   -53.5% set_page_address
       -70   -41.2% dup_task_struct
       -72   -10.9% kmap_atomic
       -76   -24.1% exit_notify
       -83   -27.4% flush_signal_handlers
       -86   -68.3% sched_best_cpu
       -99   -76.7% kmalloc
      -104   -36.6% kmem_cache_free
      -106   -11.7% strnlen_user
      -114   -23.6% __wake_up
      -117    -9.4% vfs_read
      -123    -2.7% get_empty_filp
      -131   -76.6% eventpoll_release
      -135   -23.5% pte_alloc_one
      -144   -13.8% link_path_walk
      -148    -3.0% __copy_to_user_ll
      -163   -35.2% complete
      -185    -6.8% __fput
      -191  -100.0% one_sec_update_atime
      -215  -100.0% pgd_ctor
      -227   -76.4% current_kernel_time
      -236  -100.0% find_trylock_page
      -252    -7.7% atomic_dec_and_lock
      -285   -28.4% clear_page_tables
      -498   -24.4% path_lookup
      -524    -6.4% d_lookup
      -534   -26.1% do_schedule
      -603   -32.7% do_no_page
      -817   -24.9% find_get_page
     -1911    -4.0% default_idle
     -2470    -1.5% total

BTW, I have your "atime" patch you sent me in -mjb2, and fstab is:

# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>                  <dump>
<pass>
/dev/sda2       /               ext2    defaults,noatime,errors=remount-ro
0   1
/dev/sdd1       /home/mbligh    ext3    defaults,noatime                0
2
proc            /proc           proc    defaults                        0
0
/dev/cdrom      /cdrom          iso9660 defaults,ro,user,noauto         0
0
ramfs           /ram            ramfs   defaults                        0
2

