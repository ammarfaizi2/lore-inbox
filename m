Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSJ1HNT>; Mon, 28 Oct 2002 02:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJ1HNT>; Mon, 28 Oct 2002 02:13:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7332 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263026AbSJ1HNQ>; Mon, 28 Oct 2002 02:13:16 -0500
Date: Sun, 27 Oct 2002 23:16:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3152708915.1035760600@[10.10.2.3]>
In-Reply-To: <200210280132.33624.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is interesting, indeed. As you might have seen from the tests I
> posted on LKML I could not see that effect on our IA64 NUMA machine.
> Which arises the question: is it expensive to recalculate the load
> when doing an exec (which I should also see) or is the strategy of
> equally distributing the jobs across the nodes bad for certain
> load+architecture combinations? As I'm not seeing the effect, maybe
> you could do the following experiment:
> In sched_best_node() keep only the "while" loop at the beginning. This
> leads to a cheap selection of the next node, just a simple round robin. 

I did this ... presume that's what you meant:

static int sched_best_node(struct task_struct *p)
{
        int i, n, best_node=0, min_load, pool_load, min_pool=numa_node_id();
        int cpu, pool, load;
        unsigned long mask = p->cpus_allowed & cpu_online_map;

        do {
                /* atomic_inc_return is not implemented on all archs [EF] */
                atomic_inc(&sched_node);
                best_node = atomic_read(&sched_node) % numpools;
        } while (!(pool_mask[best_node] & mask));

        return best_node;
}

Odd. seems to make it even worse.

Kernbench:
                                   Elapsed        User      System         CPU
           2.5.44-mm4-focht-12      20.32s        190s       44.4s     1153.6%
      2.5.44-mm4-focht-12-lobo     21.362s     193.71s     48.672s       1134%

The diffprofiles below look like this just makes it make bad decisions. 
Very odd ... compare with what hapenned when I put Michael's balance_exec
on instead. I'm tired, maybe I did something silly.

diffprofile 2.5.44-mm4-focht-1 2.5.44-mm4-focht-12      

606 page_remove_rmap
566 do_schedule
488 page_add_rmap
475 .text.lock.file_table
370 __copy_to_user
306 strnlen_user
272 d_lookup
235 find_get_page
233 get_empty_filp
193 atomic_dec_and_lock
161 copy_process
159 sched_best_node
135 flush_signal_handlers
131 complete
116 filemap_nopage
109 __fput
105 path_lookup
103 follow_mount
95 zap_pte_range
92 file_move
91 do_no_page
87 release_task
80 do_page_fault
62 lru_cache_add
62 link_path_walk
62 do_generic_mapping_read
57 find_trylock_page
55 release_pages
50 dup_task_struct
...
-73 do_anonymous_page
-478 __copy_from_user

diffprofile 2.5.44-mm4-focht-12 2.5.44-mm4-focht-12-lobo

567 do_schedule
482 do_anonymous_page
383 page_remove_rmap
336 __copy_from_user
333 page_add_rmap
241 zap_pte_range
213 init_private_file
189 strnlen_user
186 buffered_rmqueue
172 find_get_page
124 complete
111 filemap_nopage
97 free_hot_cold_page
89 flush_signal_handlers
86 clear_page_tables
79 do_page_fault
79 copy_process
75 d_lookup
74 path_lookup
71 sched_best_cpu
68 do_no_page
58 release_pages
58 __set_page_dirty_buffers
52 wait_for_completion
51 release_task
51 handle_mm_fault
...
-53 lru_cache_add
-73 dentry_open
-100 sched_best_node
-108 file_ra_state_init
-402 .text.lock.file_table

