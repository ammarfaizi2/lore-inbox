Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUDIUje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUDIUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:39:34 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:51601 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261668AbUDIUjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:39:31 -0400
Date: Fri, 09 Apr 2004 13:39:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <1524892704.1081543162@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0404041330580.21790-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404041330580.21790-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This anobjrmap 9 (or anon_mm9) patch adds Rajesh's radix priority search
> tree on top of Martin's 2.6.5-rc3-mjb2 tree, making a priority mjb tree!
> Approximately equivalent to Andrea's 2.6.5-aa1, but using anonmm instead
> of anon_vma, and of course each tree has its own additional features.

This slows down kernel compile a little, but worse, it slows down SDET
by about 25% (on the 16x). I think you did something horrible to sem
contention ... presumably i_shared_sem, which SDET was fighting with
as it was anyway ;-(

Diffprofile shows:


    122626    15.7% total
     44129   790.0% __down
     20988     4.1% default_idle
     12101   550.3% __wake_up
     11723   489.1% finish_task_switch
      6988    77.4% do_wp_page
      3983    21.7% copy_page_range
      2683    19.2% zap_pte_range
      2325    54.3% do_anonymous_page
      2293    73.1% copy_mm
      1787    68.3% remove_shared_vm_struct
      1768   101.6% pte_alloc_one
      1564    40.0% do_no_page
      1520    50.8% do_page_fault
      1376    39.2% clear_page_tables
      1282    63.4% __copy_user_intel
       926     9.4% page_remove_rmap
       878    13.1% __copy_to_user_ll
       835    46.8% __block_prepare_write
       788    35.8% copy_process
       777     0.0% __vma_prio_tree_remove
       761    48.8% buffered_rmqueue
       740    48.6% free_hot_cold_page
       674   128.4% vma_link
       641     0.0% __vma_prio_tree_insert
       612   941.5% sched_clock
       585     0.0% prio_tree_insert
       563    60.4% exit_notify
       547   225.1% split_vma
       539     6.4% release_pages
       534   464.3% schedule
       495    32.0% release_task
       422   148.1% flush_signal_handlers
       421    66.6% find_vma
       420    79.5% set_page_dirty
       409    60.1% fput
       359    44.5% __copy_from_user_ll
       319    47.6% do_mmap_pgoff
       290   254.4% find_vma_prepare
       270   167.7% rb_insert_color
       254    61.7% pte_alloc_map
       251    91.3% exit_mmap
       229    23.2% __read_lock_failed
       228     9.9% filemap_nopage
...
      -100   -29.3% group_reserve_blocks
      -107   -53.5% .text.lock.namespace
      -107   -18.4% render_sigset_t
      -126   -18.7% mmgrab
      -146   -10.9% generic_file_open
      -166    -9.5% ext2_new_inode
      -166   -38.1% d_path
      -166   -20.1% __find_get_block_slow
      -173   -20.7% proc_pid_status
      -182   -19.3% update_atime
      -185   -25.8% fd_install
      -202   -13.8% .text.lock.highmem
      -221   -14.5% __fput
      -225   -14.3% number
      -257   -14.2% proc_pid_stat
      -284   -21.6% file_kill
      -290   -35.3% proc_root_link
      -300   -36.5% ext2_new_block
      -349   -61.7% .text.lock.base
      -382   -48.0% proc_check_root
      -412   -19.4% path_release
      -454   -20.0% file_move
      -462   -32.2% lookup_mnt
      -515    -4.5% find_get_page
      -547   -34.5% .text.lock.dcache
      -689   -31.2% follow_mount
      -940   -33.8% .text.lock.dec_and_lock
     -1043   -51.6% .text.lock.file_table
     -1115    -9.9% __d_lookup
     -1226   -20.1% path_lookup
     -1305   -61.5% grab_block
     -2101   -29.8% atomic_dec_and_lock
     -2554   -40.3% .text.lock.filemap

