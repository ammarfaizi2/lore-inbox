Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263910AbTDVXrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTDVXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:47:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2270 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263910AbTDVXrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:47:04 -0400
Date: Tue, 22 Apr 2003 16:48:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9
Message-ID: <1490710000.1051055323@flay>
In-Reply-To: <Pine.LNX.4.44.0304211509010.11700-100000@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304211509010.11700-100000@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the attached patch (against 2.5.68 or BK-curr) is the latest
> implementation of the "no compromises" HT-scheduler. I fixed a couple of
> bugs, and the scheduler is now stable and behaves properly on a
> 2-CPU-2-sibling HT testbox. The patch can also be downloaded from:
> 
> 	http://redhat.com/~mingo/O(1)-scheduler/
> 
> bug reports, suggestions welcome,

Hmmm. When the machine is loaded up fully, this seems OK, but for lower
loads, it seems to have a significant degredation. This is on my normal
16-way machine, no HT at all ... just checking for degredations. At a
guess, maybe it's bouncing stuff around between runqueues under low
loads?

Are there things embedded in here that change stuff for non-HT machines?

M.

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.7%
                2.5.68-ht        72.9%         1.8%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         2.8%
                2.5.68-ht        73.7%         2.1%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         1.0%
                2.5.68-ht        62.5%        47.0%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.6%
                2.5.68-ht        92.6%         1.0%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
                2.5.68-ht       100.0%         0.5%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.4%
                2.5.68-ht        99.1%         0.6%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.2%
                2.5.68-ht        99.0%         0.1%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
                2.5.68-ht        99.0%         0.1%

diffprofile for SDET 4:

     12339    28.7% total
     10551    27.0% default_idle
       313    75.6% page_add_rmap
       240   110.1% copy_page_range
       192   243.0% do_wp_page
       174    31.1% page_remove_rmap
        51    20.6% zap_pte_range
        48    65.8% do_anonymous_page
        48    41.0% find_get_page
        48   160.0% copy_mm
        41    41.4% __d_lookup
        38    44.7% __copy_to_user_ll
        34    82.9% __copy_user_intel
        32   110.3% copy_process
        28    28.9% release_pages
        27   158.8% current_kernel_time
        23   121.1% release_task
        23    35.4% kmem_cache_free
        20   125.0% free_hot_cold_page
        17    77.3% buffered_rmqueue
        15   100.0% __copy_from_user_ll
        15    24.2% do_no_page
        13    16.9% do_page_fault
        12    44.4% pte_alloc_one
        12    57.1% schedule
        12   400.0% copy_files
        11    73.3% exit_notify
        10    29.4% path_lookup
         9   180.0% dup_task_struct
         9    27.3% atomic_dec_and_lock
         7    31.8% handle_mm_fault
         7   140.0% block_invalidatepage
         7    38.9% __pte_chain_free
         7    14.0% clear_page_tables
         7   116.7% fd_install
         7    77.8% write_profile
         7   350.0% generic_delete_inode
         6    54.5% ext2_update_inode
         6    60.0% do_page_cache_readahead
         6    66.7% dentry_open

Which looks like maybe more off-node NUMA accesses in there ...
is there some new rebalance mechanism that could be bouncing
stuff across nodes?

