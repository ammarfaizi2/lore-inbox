Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTA0R1l>; Mon, 27 Jan 2003 12:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbTA0R1l>; Mon, 27 Jan 2003 12:27:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48105 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267247AbTA0R1h>; Mon, 27 Jan 2003 12:27:37 -0500
Date: Mon, 27 Jan 2003 09:36:52 -0800
From: "Martin J. Bligh" <fletch@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernbench-16 on 2.5.59 vs 2.5.59-mm6
Message-ID: <375110000.1043689012@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This test does a make -j X vmlinux on a 2.4.17 kernel compile with
a very large config set. X is 16 times the number of cpus. This is
on a 16-way NUMA-Q so we end up with a make -j256 (it's fastest
with about 1.5 * num_cpus), but this test puts more stress on the 
kernel. 

None of the other tests I ran showed anything very interesting.
(the new NUMA sched stuff from Ingo seems to give mild degredations
in -mjb ... probably needs some more tuning).

Going from 59 to 59-mm6, I get:

Kernbench-16:
                                   Elapsed        User      System         CPU
                        2.5.59       47.45      568.02      143.17     1498.17
                    2.5.59-mm6       47.18      567.15      138.62     1495.50

Summary: Scheduler stuff seems like a wash (schedule -> do_schedule). 
Seems to be some sort of rearrangement of the dcache stuff which 
appears to be mildly beneficial (what's going in there?). 
current_kernel_time seems to be less than half the cost, I'm assuming 
the new frlock kernel time stuff is doing that. This workload doesn't 
stress that very much, so I'll find a better test for that one ...

2.5.59: 1657 current_kernel_time
2.5.59-mm6: 747 current_kernel_time

diffprofile (+ gets worse, - gets better).

2023 do_schedule
485 dentry_open
289 .text.lock.file_table
132 clear_page_tables
131 pgd_ctor
113 vma_merge
75 kmap_atomic
62 get_empty_filp
51 can_vma_merge_after
-52 dget_locked
-54 vfs_follow_link
-55 kmem_cache_free
-66 buffered_rmqueue
-74 __copy_to_user_ll
-94 page_add_rmap
-102 fd_install
-110 __copy_from_user_ll
-117 __d_lookup
-157 do_generic_mapping_read
-188 path_lookup
-273 .text.lock.dec_and_lock
-275 file_ra_state_init
-283 do_anonymous_page
-331 pfn_to_nid
-405 page_remove_rmap
-413 pgd_alloc
-427 vm_enough_memory
-910 current_kernel_time
-1222 .text.lock.namei
-2076 total
-2133 schedule

