Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTA2WMH>; Wed, 29 Jan 2003 17:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTA2WMH>; Wed, 29 Jan 2003 17:12:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45805 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267365AbTA2WME>; Wed, 29 Jan 2003 17:12:04 -0500
Date: Wed, 29 Jan 2003 14:13:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernbench: 2.5.59 vs 2.5.59-mm6 vs 2.5.59-mjb2
Message-ID: <62800000.1043878411@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel compile (long version), 2 tasks per CPU, cache warm.
16-way NUMA-Q, 16Gb RAM.

Kernbench-2:
                                   Elapsed        User      System         CPU
                        2.5.59       46.08      563.88      118.38     1480.00
                    2.5.59-mm6       45.95      563.16      115.85     1477.50
                   2.5.59-mjb2       45.56      564.81      113.29     1487.83

Both improve over 2.5.59, mjb2 is a little faster (especially on 
systime), but I think that's mainly just because you dropped dcache_rcu
temporarily. What's more interesting is diffprofile (differences under
50 ticks dropped)

---------------------------------------------

Going from 59 to 59-mm6 (+ gets worse, - better in your tree)
(frlock stuff, I think you have Ingo's D7 or part of it for sched?,
not sure what's causing the pfn_to_nid and pgd_alloc improvements?)

2367 do_schedule
527 dentry_open
133 kmap_atomic
131 .text.lock.file_table
85 get_empty_filp
79 vma_merge
55 can_vma_merge_after
-64 strnlen_user
-80 __copy_from_user_ll
-84 link_path_walk
-87 buffered_rmqueue
-110 page_remove_rmap
-122 fd_install
-155 do_generic_mapping_read
-259 file_ra_state_init
-276 pgd_alloc
-284 vm_enough_memory
-321 do_anonymous_page
-329 pfn_to_nid
-890 current_kernel_time
-998 default_idle
-2398 schedule
-3565 total

Going from 59 to 59-mjb2 (+ gets worse, - better in my tree)

6477 d_lookup
2621 do_schedule
2507 .text.lock.file_table
537 vm_enough_memory
287 prepare_to_wait
277 get_empty_filp
209 find_get_page
188 kmem_cache_alloc
181 fd_install
155 page_add_rmap
148 page_remove_rmap
145 vfs_read
145 file_move
144 do_anonymous_page
128 zap_pte_range
116 eventpoll_init_file
102 __wake_up
99 file_ra_state_init
81 __copy_from_user_ll
55 sys_brk
55 default_wake_function
51 mark_page_accessed
-51 profile_exit_mmap
-57 strnlen_user
-79 .text.lock.dcache
-94 path_lookup
-115 eventpoll_release
-160 may_open
-164 clear_page_tables
-179 find_trylock_page
-184 kmalloc
-240 vfs_follow_link
-259 prepare_to_wait_exclusive
-438 path_release
-609 dput
-892 current_kernel_time
-892 __fput
-1135 dget_locked
-1388 link_path_walk
-2060 __d_lookup
-2398 schedule
-2875 .text.lock.dec_and_lock
-3890 default_idle
-5163 .text.lock.namei
-8613 total

Going from 59-mm6 to 59-mjb2 (+ gets worse, - better in my tree)
(mainly dcache RCU, though the vm expense up the top is odd,
might be ingo's scheduler mods).

6479 d_lookup
2376 .text.lock.file_table
821 vm_enough_memory
465 do_anonymous_page
360 pfn_to_nid
358 file_ra_state_init
303 fd_install
294 prepare_to_wait
264 pgd_alloc
258 page_remove_rmap
254 do_schedule
230 find_get_page
192 get_empty_filp
185 kmem_cache_alloc
169 vfs_read
165 page_add_rmap
161 __copy_from_user_ll
124 do_generic_mapping_read
119 eventpoll_init_file
114 zap_pte_range
106 file_move
96 __copy_to_user_ll
90 __wake_up
87 do_page_fault
82 free_hot_cold_page
65 page_address
60 sys_brk
60 __alloc_pages
56 pipe_wait
53 default_wake_function
50 register_profile_notifier
-55 can_vma_merge_after
-55 atomic_dec_and_lock
-55 __mark_inode_dirty
-63 remove_shared_vm_struct
-82 .text.lock.dcache
-98 path_lookup
-107 kmap_atomic
-110 eventpoll_release
-121 vma_merge
-133 may_open
-135 clear_page_tables
-177 kmalloc
-184 find_trylock_page
-204 vfs_follow_link
-271 prepare_to_wait_exclusive
-450 path_release
-537 dentry_open
-649 dput
-876 __fput
-1094 dget_locked
-1304 link_path_walk
-2033 __d_lookup
-2852 .text.lock.dec_and_lock
-2892 default_idle
-5048 total
-5153 .text.lock.namei

