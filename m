Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268942AbTBSQNt>; Wed, 19 Feb 2003 11:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268948AbTBSQNt>; Wed, 19 Feb 2003 11:13:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:47573 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268942AbTBSQNs>; Wed, 19 Feb 2003 11:13:48 -0500
Date: Wed, 19 Feb 2003 08:23:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: Strange performance change 59 -> 61/62
Message-ID: <32720000.1045671824@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm comparing 59-mjb6 to 61-mjb1 and notice some strange performance
differences that I can't explain ... not a big drop, but odd.
Only changes in -mjb during that switchover were to drop the merged stuff
and add:

+ sighand_locking
+ percpu_loadavg 
+ irq_affinity
+ kirq_clustered_fix

However, all but percpu_loadavg are just bugfixes, and I tested 
percpu_loadavg seperately (see below). Moreover, the profile differences
don't seem related.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                   2.5.59-mjb6       45.55      564.83      110.03     1481.00
           2.5.59-mjb6-cpuload       45.72      563.63      110.80     1474.67
                   2.5.61-mjb1       45.55      563.99      112.96     1485.50
                   2.5.62-mjb1       45.81      564.41      112.76     1478.00

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                   2.5.59-mjb6       46.59      568.81      131.97     1503.67
           2.5.59-mjb6-cpuload       46.60      567.42      132.19     1502.67
                   2.5.61-mjb1       46.91      568.71      138.26     1506.33
                   2.5.62-mjb1       47.21      569.17      139.55     1500.67

Note the increase in systime. Diffprofile shows:

Most of the changes kind of look dcache releated, but I have the same
exact dcache patches in both trees (with sunrpc fixes) ... is anyone
familiar with the pattern below, and might be able to see what's 
causing this?

Thanks,

M.

2.5.59-mjb6 -> 2.5.61-mjb1 (+ worse in 61, - better)

1562 .text.lock.file_table
583 dentry_open
551 get_empty_filp
479 __mark_inode_dirty
274 __down
162 atomic_dec_and_lock
162 __fput
159 page_remove_rmap
148 page_add_rmap
122 vma_merge
97 current_kernel_time
93 file_move
92 do_no_page
81 do_schedule
72 find_get_page
68 dput
62 can_vma_merge_after
54 __copy_to_user_ll
...
-58 sys_brk
-69 fd_install
-70 __copy_from_user_ll
-86 do_lookup
-205 do_generic_mapping_read
-219 do_anonymous_page
-248 file_ra_state_init
-256 vfs_read
-308 path_lookup
-309 d_lookup
-506 vm_enough_memory
-1796 total
-4472 default_idle

