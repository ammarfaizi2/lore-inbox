Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264046AbTCXCxY>; Sun, 23 Mar 2003 21:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264047AbTCXCxY>; Sun, 23 Mar 2003 21:53:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:14286 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264046AbTCXCxU>; Sun, 23 Mar 2003 21:53:20 -0500
Date: Sun, 23 Mar 2003 19:04:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-ID: <9590000.1048475057@[10.10.2.4]>
In-Reply-To: <20030323020646.0dfcc17b.akpm@digeo.com>
References: <20030323020646.0dfcc17b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> . Several ext3 speedups here.  They reduce the overhead of a write() to
>   ext3 by about 45%.
> 
> . Large locking changes to ext3.  lock_kernel() has been completely
>   removed from ext3 and pushed down into the JBD layer, around those bits
>   which actually need it.
> 
>   Lock contention is greatly reduced, but this change means that the
>   front-line locking for ext3 is now two semaphores.  The context switch
> rate   under load has gone through the roof.  So there is more work to be
> done   here yet.

Well, it shook things up a bit, but doesn't seem to have much effect for
the workload I was looking at, at least:

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         2.0%
               2.5.65-mm4        98.9%         1.8%
          2.5.65-mm4-ext3        90.4%         4.1%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         2.3%
               2.5.65-mm4        98.3%         3.6%
          2.5.65-mm4-ext3        93.4%         3.1%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         1.3%
               2.5.65-mm4        97.8%         0.3%
          2.5.65-mm4-ext3        45.5%         7.1%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         1.0%
               2.5.65-mm4        98.7%         1.5%
          2.5.65-mm4-ext3        13.7%         3.3%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         1.0%
               2.5.65-mm4        55.2%        57.2%
          2.5.65-mm4-ext3         8.4%         2.5%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         0.5%
               2.5.65-mm4        98.2%         0.6%
          2.5.65-mm4-ext3         8.5%         3.7%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         0.4%
               2.5.65-mm4        97.7%         0.4%
          2.5.65-mm4-ext3         7.9%         2.2%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.65-mm3       100.0%         0.6%
               2.5.65-mm4        98.0%         0.4%
          2.5.65-mm4-ext3         8.3%         1.2%

profile from SDET 64:

82303 __down
42835 schedule
31323 __wake_up
26435 .text.lock.sched
15924 .text.lock.transaction
6470 do_get_write_access
5106 zap_pte_range
4693 copy_page_range
4522 journal_add_journal_head
4491 __blk_queue_bounce
4179 page_remove_rmap
3859 find_get_page
3687 journal_get_write_access
2949 journal_dirty_metadata
2769 cpu_idle
2691 d_lookup
2495 start_this_handle
2220 __copy_to_user_ll
2199 do_anonymous_page
2168 __find_get_block
2069 page_add_rmap
2063 __find_get_block_slow
1842 .text.lock.attr
1650 do_wp_page
1603 ext3_get_inode_loc
1600 release_pages
1405 journal_stop
1237 find_next_usable_block
1233 do_no_page
1224 current_kernel_time
1203 __brelse
1143 ext3_do_update_inode
1083 kmem_cache_free
1030 kmap_atomic

diffprofile with a spinlined version 
(still on ext3, should just show who took the locks).

     20618    48.1% schedule
      6211    96.0% do_get_write_access
      4485   609.4% journal_start
      3559   253.3% journal_stop
      1554   582.0% inode_change_ok
       605  1680.6% sem_exit
       589    13.0% journal_add_journal_head
       421   825.5% proc_pid_readlink
       301    13.9% __find_get_block
       246  1366.7% sys_ioctl
       186    15.0% find_next_usable_block
       139   195.8% inode_setattr
       122    13.2% atomic_dec_and_lock
...
      -101    -9.3% kmem_cache_free
      -103   -34.0% journal_forget
      -106   -20.7% __make_request
      -117  -100.0% .text.lock.root
      -118    -5.7% page_add_rmap
      -123   -15.2% free_hot_cold_page
      -126    -7.6% do_wp_page
      -127    -3.0% page_remove_rmap
      -130   -17.2% buffered_rmqueue
      -133    -5.3% start_this_handle
      -149   -24.8% scsi_queue_next_request
      -181  -100.0% .text.lock.dec_and_lock
      -209   -10.1% __find_get_block_slow
      -210    -5.7% journal_get_write_access
      -269   -12.1% __copy_to_user_ll
      -318  -100.0% .text.lock.ioctl
      -383    -8.5% __blk_queue_bounce
      -438  -100.0% .text.lock.base
      -736  -100.0% .text.lock.sem
      -903  -100.0% .text.lock.journal
     -1008    -3.2% __wake_up
     -1842  -100.0% .text.lock.attr
     -3472    -4.2% __down
    -14325    -0.6% default_idle
    -15908   -99.9% .text.lock.transaction
    -26435  -100.0% .text.lock.sched
    -30643    -1.2% total

I'll need to put something else together for the semaphores, unless
you already know who's taking them ...

Just for reference, this is the profile from the -mjb1 run with ext3 I did:

22660 .text.lock.inode
2888 .text.lock.namei
2570 .text.lock.sched
2424 .text.lock.attr
860 ext3_prepare_write
498 unmap_all_pages
468 .text.lock.dir
464 ext3_commit_write
448 page_remove_rmap
427 copy_page_range
411 .text.lock.sem
356 schedule
349 __down
302 page_add_rmap
252 find_get_page
252 .text.lock.base
246 d_lookup
225 .text.lock.ioctl
209 __copy_to_user_ll
199 inode_change_ok
196 journal_add_journal_head
187 __wake_up
176 start_this_handle
176 __blk_queue_bounce
175 ext3_setattr
170 do_anonymous_page
156 do_wp_page
145 ext3_dirty_inode
127 __find_get_block
122 ext3_get_block_handle
118 find_next_usable_block
118 do_get_write_access
117 do_no_page
111 ext3_get_inode_loc
107 kmap_atomic
106 do_page_fault
104 __block_prepare_write
101 pte_alloc_one

M.


