Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTDIQ4b (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTDIQ4b (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:56:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42153 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263607AbTDIQ41 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:56:27 -0400
Date: Wed, 09 Apr 2003 10:07:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <192640000.1049908071@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304081914110.10459-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304081914110.10459-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm. Something somewhere went wrong. Some semaphore blew up
somewhere ... I'm not convinced that this is your patch
causing the problem, I just thought that since vma_link seems
to have gone up rather in the profile. I'm playing with getting
some better data on what actually happened, but in case someone
is feeling psychic. 

The main thing I changed here (66-mjb2 -> 67-mjb0.2) was to pick up 
Andrew's rmap speedups, and drop the objrmap code I had for the stuff 
he had. *However*, what he had worked fine. I also picked up your 
sorting patch here Hugh ... this bit worries me:

+static void move_vma_start(struct vm_area_struct *vma, unsigned long addr)
+{
+	spinlock_t *lock = &vma->vm_mm->page_table_lock;
+	struct inode *inode = NULL;
+	
+	if (vma->vm_file) {
+		inode = vma->vm_file->f_dentry->d_inode;
+		down(&inode->i_mapping->i_shared_sem);
+	}
+	spin_lock(lock);
+	if (inode)
+		__remove_shared_vm_struct(vma, inode);
+	/* If no vm_file, perhaps we should always keep vm_pgoff at 0?? */
+	vma->vm_pgoff += (long)(addr - vma->vm_start) >> PAGE_SHIFT;
+	vma->vm_start = addr;
+	if (inode) {
+		__vma_link_file(vma);
+		up(&inode->i_mapping->i_shared_sem);
+	}
+	spin_unlock(lock);
+}

M.

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.66       100.0%         0.2%
                   2.5.67        97.7%         5.1%
               2.5.66-mm2       176.1%         0.6%
               2.5.67-mm1       176.7%         0.2%
              2.5.66-mjb2       181.8%         0.0%
            2.5.67-mjb0.2       141.1%         0.1%


diffprofile {2.5.66-mjb2,2.5.67-mjb0.2}/sdetbench/128/profile
(these are at 100 Hz).

     12913    38.8% default_idle
     12472    20.2% total
      3085   912.7% __down
      1026   385.7% schedule
       946   666.2% __wake_up
       904     0.0% __d_lookup
       626     0.0% move_vma_start
       452  6457.1% __vma_link
       159    40.9% remove_shared_vm_struct
        84    36.4% do_no_page
        69    22.5% copy_mm
        65   125.0% vma_link
        37   528.6% default_wake_function
        31     9.0% do_wp_page
        29   290.0% rb_insert_color
        19    95.0% try_to_wake_up
        18   450.0% __vma_link_rb
        17     6.0% clear_page_tables
        15    20.3% handle_mm_fault
        14   140.0% find_vma_prepare
        14   700.0% __rb_rotate_left
        13    46.4% exit_mmap
        11   110.0% kunmap_atomic
        10    24.4% do_mmap_pgoff
...
      -102   -58.6% __read_lock_failed
      -124   -43.5% path_release
      -126   -17.7% __copy_to_user_ll
      -168   -20.1% release_pages
      -189   -21.1% page_add_rmap
      -223   -33.2% path_lookup
      -241   -15.3% zap_pte_range
      -247   -18.3% page_remove_rmap
      -310   -46.5% follow_mount
      -405   -70.7% .text.lock.dcache
      -425   -76.6% .text.lock.namei
      -551   -49.5% atomic_dec_and_lock
      -628   -71.2% .text.lock.dec_and_lock
     -1148   -98.5% d_lookup

diffprofile {2.5.67-mm1,2.5.67-mjb0.2}/sdetbench/128/profile


    110028    31.3% default_idle
     92085    14.2% total
     31265  1054.5% __down
     10473   428.0% schedule
      9351   611.6% __wake_up
      6260     0.0% move_vma_start
      4200  1076.9% __vma_link
      1328    32.0% remove_shared_vm_struct
       831  1695.9% find_trylock_page
       567    17.8% copy_mm
       428    57.7% vma_link
       380   633.3% default_wake_function
       294   306.2% rb_insert_color
       182    87.5% try_to_wake_up
       177   411.6% __vma_link_rb
       158    62.7% exit_mmap
       150     0.0% rcu_do_batch
       135   540.0% __rb_rotate_left
...
      -196   -31.3% block_invalidatepage
      -202   -39.5% ext2_new_block
      -204   -54.5% .text.lock.inode
      -208   -33.1% task_mem
      -213    -6.6% clear_page_tables
      -213   -55.6% d_lookup
      -218   -44.7% select_parent
      -228   -21.2% kmap_high
      -235   -46.5% read_block_bitmap
      -241   -47.2% d_path
      -244   -57.5% complete
      -261  -100.0% group_release_blocks
      -263   -31.6% proc_root_link
      -264   -17.9% number
      -295   -38.6% strnlen_user
      -296   -26.8% task_vsize
      -320   -49.2% generic_file_aio_write_nolock
      -331   -75.1% call_rcu
      -334   -23.3% __fput
      -336   -56.4% may_open
      -339   -35.3% dput
      -343   -51.0% __find_get_block_slow
      -348   -40.6% d_instantiate
      -354   -65.1% __alloc_pages
      -371   -41.6% prune_dcache
      -377  -100.0% group_reserve_blocks
      -380   -22.6% release_task
      -398   -55.4% generic_fillattr
      -398   -31.4% exit_notify
      -420   -51.9% unmap_vmas
      -424   -35.5% file_kill
      -427   -72.7% read_inode_bitmap
      -435   -41.2% proc_check_root
      -459   -16.3% free_pages_and_swap_cache
      -480   -14.3% do_anonymous_page
      -517   -43.9% ext2_new_inode
      -519   -72.2% ext2_get_group_desc
      -527   -35.9% fd_install
      -537   -28.8% d_alloc
      -559   -30.4% __find_get_block
      -574   -49.7% __mark_inode_dirty
      -575   -38.0% .text.lock.highmem
      -580   -44.6% .text.lock.attr
      -598   -24.6% file_move
      -603   -23.4% copy_process
      -628   -27.4% filemap_nopage
      -633   -42.1% __set_page_dirty_buffers
      -634   -24.0% proc_pid_stat
      -636   -42.2% .text.lock.base
      -705   -28.5% link_path_walk
      -716   -60.9% flush_signal_handlers
      -758   -11.5% __copy_to_user_ll
      -780   -52.0% .text.lock.file_table
      -781   -36.3% free_hot_cold_page
      -834   -91.2% update_atime
      -906   -42.2% buffered_rmqueue
      -916   -56.0% __read_lock_failed
      -920   -34.3% kmem_cache_free
      -993   -38.1% path_release
     -1002   -71.0% __brelse
     -1106   -13.6% page_add_rmap
     -1256   -39.7% pte_alloc_one
     -1303   -29.3% do_no_page
     -1365   -83.5% grab_block
     -1522   -80.4% current_kernel_time
     -1819   -21.4% release_pages
     -1902   -14.2% copy_page_range
     -2149   -32.4% path_lookup
     -2150   -62.3% .text.lock.namei
     -2464   -21.4% __d_lookup
     -2486   -26.1% find_get_page
     -2499   -41.2% follow_mount
     -3174   -22.3% page_remove_rmap
     -3217   -65.7% .text.lock.dcache
     -4119   -42.3% atomic_dec_and_lock
     -4359   -24.6% zap_pte_range
     -4551  -100.0% .text.lock.filemap
     -4665   -64.7% .text.lock.dec_and_lock

