Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTHZDYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHZDYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:24:48 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:26756 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262515AbTHZDYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:24:44 -0400
Date: Mon, 25 Aug 2003 20:24:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v7
Message-ID: <3070000.1061868247@[10.10.2.4]>
In-Reply-To: <3F49E7D1.4000309@cyberone.com.au>
References: <3F48B12F.4070001@cyberone.com.au> <29760000.1061744102@[10.10.2.4]> <3F497BB6.90100@cyberone.com.au> <3F49E7D1.4000309@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't miss 5 revisions, I'll just stick to using my internal
> numbering for releases.
> 
> This one has a few changes. Children now get a priority boost
> on fork, and parents retain more priority after forking a child,
> however exiting CPU hogs will now penalise parents a bit.
> 
> Timeslice scaling was tweaked a bit. Oh and remember raising X's
> priority should _help_ interactivity with this patch, and IMO is
> not an unreasonable thing to be doing.
> 
> Please test. I'm not getting enough feedback!

Well, it's actually a bit faster than either mainline or your previous
rev whilst running SDET:

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test4       100.0%         0.3%
         2.6.0-test4-nick       102.9%         0.3%
       2.6.0-test4-nick7a       105.1%         0.5%

But kernbench is significantly slower. The increase in sys time has 
dropped from last time, but user time is up.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test4       45.87      116.92      571.10     1499.00
         2.6.0-test4-nick       49.37      131.31      611.15     1500.75
       2.6.0-test4-nick7a       49.48      125.95      617.71     1502.00

diffprofile {2.6.0-test4,2.6.0-test4-nick7a}/kernbench/0/profile

     13989     8.6% total
      4402     9.6% default_idle
      3385    14.4% page_remove_rmap
      1093    13.8% __d_lookup
       702     5.0% do_anonymous_page
       613    11.5% __copy_to_user_ll
       613    32.9% atomic_dec_and_lock
       565    40.9% free_hot_cold_page
       322    18.7% buffered_rmqueue
       296     9.4% zap_pte_range
       282    75.6% .text.lock.file_table
       185    11.4% kmem_cache_free
       183     9.8% path_lookup
       164    12.2% link_path_walk
       154    12.7% release_pages
       152    43.1% pgd_ctor
       127    33.0% file_kill
       126    15.8% pte_alloc_one
       123    10.4% file_move
       107    75.4% .text.lock.dcache
...
       -59    -9.5% copy_process
       -94   -22.5% release_task
      -146    -2.3% page_add_rmap
      -352   -24.7% schedule
     -1026   -29.4% __copy_from_user_ll

Not sure why you're beating up on rmap so much more from a scheduler
change.

diffprofile {2.6.0-test4,2.6.0-test4-nick7a}/sdetbench/128/profile
       513    19.1% .text.lock.filemap
       246     2.6% find_get_page
       150     4.4% copy_mm
        86    46.0% try_to_wake_up
        82    24.1% kunmap_high
        76     0.0% sched_fork
        74     0.5% copy_page_range
        67     1.1% do_no_page
        54    17.3% __pagevec_lru_add_active
        53    10.2% radix_tree_lookup
        51     7.4% __wake_up
...
      -101    -8.6% __block_prepare_write
      -105   -65.2% release_blocks
      -108    -4.7% link_path_walk
      -112   -15.2% mmgrab
      -116    -5.5% buffered_rmqueue
      -118    -5.9% path_release
      -119    -2.9% do_wp_page
      -125    -3.9% pte_alloc_one
      -125   -15.6% proc_pid_status
      -127    -5.5% free_hot_cold_page
      -132   -10.2% exit_notify
      -138   -11.7% __read_lock_failed
      -146    -9.7% number
      -154   -28.5% proc_check_root
      -155   -20.9% proc_root_link
      -176   -10.3% d_alloc
      -179   -13.6% task_mem
      -186    -9.8% .text.lock.dcache
      -186    -7.6% proc_pid_stat
      -193   -11.1% ext2_new_inode
      -230    -4.0% kmem_cache_free
      -239    -8.2% .text.lock.dec_and_lock
      -244   -11.5% schedule
      -250   -38.3% __blk_queue_bounce
      -257   -15.0% current_kernel_time
      -307   -17.6% release_task
      -327    -1.8% zap_pte_range
      -338    -7.7% clear_page_tables
      -384   -20.7% lookup_mnt
      -406   -26.5% __find_get_block
      -412   -18.5% follow_mount
      -565    -9.7% path_lookup
      -729   -11.6% atomic_dec_and_lock
      -865   -46.1% grab_block
     -1185   -10.5% __d_lookup
     -2145    -0.5% default_idle
     -2786    -7.0% page_add_rmap
    -12702   -14.2% page_remove_rmap
    -29467    -3.8% total

Again, rmap and dlookup. Very odd. Some sort of locality thing, I guess.

M.

