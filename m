Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSLHNCR>; Sun, 8 Dec 2002 08:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSLHNCR>; Sun, 8 Dec 2002 08:02:17 -0500
Received: from dp.samba.org ([66.70.73.150]:14728 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261206AbSLHNCP>;
	Sun, 8 Dec 2002 08:02:15 -0500
Date: Mon, 9 Dec 2002 00:09:08 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50-BK + 24 CPUs
Message-ID: <20021208130908.GE19698@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found time to run a few benchmarks over a largish machine (24 way
ppc64) running 2.5.50-BK from a few days ago.

1. kernel compile benchmark (ie build an x86 2.4.18 kernel)

I hijacked /proc/profile to log functions where we call schedule from.
It shows:

schedules:
 56283 total
 41984 pipe_wait
  9746 do_work
  1949 do_exit
  1834 sys_wait4

ie during the compile we scheduled 56283 times, and 41984 of them were
caused by pipes. Simple fix, remove -pipe from the Makefile of the
kernel I was building:

schedules:
  8497 total
  3665 do_work
  1878 do_exit
  1824 sys_wait4
   306 cpu_idle
   260 open_namei
   256 pipe_wait

Much nicer. Does it make sense to use -pipe in our kernel Makefile these
days? Note "do_work" is a ppc64 assembly function which checks
need_resched and calls schedule if the timeslice has been exceeded. So
its nice to see almost all of the schedules are due to timeslice
expiration, processes exiting or processes doing a wait().

Now we can look at the profile:

profile:
 66260 total
 54227 cpu_idle
  1000 page_remove_rmap
   909 __get_page_state
   830 page_add_rmap
   753 save_remaining_regs
   646 do_anonymous_page
   529 do_page_fault
   475 release_pages
   468 pSeries_flush_hash_range
   462 pSeries_hpte_insert
   266 __copy_tofrom_user
   215 zap_pte_range
   214 sys_brk
   210 __pagevec_lru_add_active
   209 buffered_rmqueue
   201 find_get_page
   185 vm_enough_memory
   183 nr_free_pages

Mostly idle time, theres a limit to how much we can parallelize here.
Note: save_remaining_regs is the syscall/interrupt entry path for ppc64.

2. dbench 24

Lets not pay too much attention here but there are a few things to keep
in mind:

schedules:
1635314 total
753694 cpu_idle
357910 ext2_new_block
289189 ext2_free_blocks
123788 ext2_new_inode
 95025 ext2_free_inode

Whee, look at all the schedules we took inside the ext2 code. Of course
its due to the superblock lock semaphore.

profile:
370142 total
302615 cpu_idle
  8600 __copy_tofrom_user
  3119 schedule
  2760 current_kernel_time

Lots of idle time in part due to the superblock lock (oh yeah and my
slow to react finger stopping profiling after the benchmark finished).
current_kernel_time makes a recent appearance in the profile, we are
working on a number of things to address this.

3. "University workload"

A benchmark that does lots of shell scripts, cc, troff, etc. 

schedules:
470212 total
126262 do_work
 86986 ext2_free_blocks
 58039 ext2_new_block
 53627 cpu_idle
 43140 ext2_new_inode
 30934 ext2_free_inode
 19849 do_exit
 18526 sys_wait4

The superblock lock semaphore makes an appearance in the schedule
summary again (ext2_*). Now for the profile:

profile:
136296 total
 41592 cpu_idle
 16319 page_remove_rmap
  7338 page_add_rmap
  3583 save_remaining_regs
  3072 pSeries_flush_hash_range
  2832 release_pages
  2584 do_page_fault
  2281 find_get_page
  2238 pSeries_hpte_insert
  2117 copy_page_range
  2085 current_kernel_time
  2028 zap_pte_range
  1886 __get_page_state
  1689 atomic_dec_and_lock

No big suprises in the profile. This benchmark tends to be a worst case
scenario for rmap, think of 100s of shells all mapping the same text
pages.

Anton
