Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSJZTLQ>; Sat, 26 Oct 2002 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJZTLQ>; Sat, 26 Oct 2002 15:11:16 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30428 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261459AbSJZTLO>; Sat, 26 Oct 2002 15:11:14 -0400
Date: Sat, 26 Oct 2002 12:14:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       mingo@redhat.com, habanero@us.ibm.com
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3022997410.1035634489@[10.10.2.3]>
In-Reply-To: <200210251015.46388.efocht@ess.nec.de>
References: <200210251015.46388.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> From my point of view, the reason for focussing on this was that
>> your scheduler degraded the performance on my machine, rather than
>> boosting it. Half of that was the more complex stuff you added on
>> top ... it's a lot easier to start with something simple that works
>> and build on it, than fix something that's complex and doesn't work
>> well.
> 
> You're talking about one of the first 2.5 versions of the patch. It
> changed a lot since then, thanks to your feedback, too.

OK, I went to your latest patches (just 1 and 2). And they worked!
You've fixed the performance degradation problems for kernel compile
(now a 14% improvement in systime), that core set works without 
further futzing about or crashing, with or without TSC, on either 
version of gcc ... congrats!

It also produces the fastest system time for kernel compile I've ever
seen ... this core set seems to be good (I'm still less than convinced
about the further patches, but we can work on those one at a time now
you've got it all broken out and modular). Michael posted slightly 
different looking results for virgin 44 yesterday - the main difference between virgin 44 and 44-mm4 for this stuff is probably the per-cpu 
hot & cold pages (Ingo, this is like your original per-cpu pages).

All results are for a 16-way NUMA-Q (P3 700MHz 2Mb cache) 16Gb RAM.

Kernbench:
                             Elapsed        User      System         CPU
              2.5.44-mm4     19.676s    192.794s     42.678s     1197.4%
        2.5.44-mm4-hbaum     19.422s    189.828s     40.204s     1196.2%
      2.5.44-mm4-focht12     19.316s    189.514s     36.704s     1146.8%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       32.45       49.47      129.86        0.82
        2.5.44-mm4-hbaum       31.31       43.85      125.29        0.84
      2.5.44-mm4-focht12       38.50       45.34      154.05        1.07

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       39.90       61.48      319.26        2.79
        2.5.44-mm4-hbaum       32.63       46.56      261.10        1.99
      2.5.44-mm4-focht12       35.56       46.57      284.53        1.97

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       62.99       93.59     1008.01        5.11
        2.5.44-mm4-hbaum       49.78       76.71      796.68        4.43
      2.5.44-mm4-focht12       51.94       61.43      831.26        4.68

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       88.13      194.53     2820.54       11.52
        2.5.44-mm4-hbaum       54.67      147.30     1749.77        7.91
      2.5.44-mm4-focht12       55.43      119.49     1773.97        8.41

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4      159.92      653.79    10235.93       25.16
        2.5.44-mm4-hbaum       65.20      300.58     4173.26       16.82
      2.5.44-mm4-focht12       56.49      235.78     3615.71       18.05

There's a small degredation at the low end of schedbench (Erich's
numa_test) in there ... would be nice to fix, but I'm less worried
about that (where the machine is lightly loaded) than the other 
numbers. Kernbench is just gcc-2.95-4 compiling the 2.4.17 kernel
doing a "make -j24 bzImage".

diffprofile 2.5.44-mm4 2.5.44-mm4-hbaum
(for kernbench, + got worse by adding the patch, - got better)

184 vm_enough_memory
154 d_lookup
83 do_schedule
75 page_add_rmap
73 strnlen_user
58 find_get_page
52 flush_signal_handlers
...
-61 pte_alloc_one
-63 do_wp_page
-85 .text.lock.file_table
-96 __set_page_dirty_buffers
-112 clear_page_tables
-118 get_empty_filp
-134 free_hot_cold_page
-144 page_remove_rmap
-150 __copy_to_user
-213 zap_pte_range
-217 buffered_rmqueue
-875 __copy_from_user
-1015 do_anonymous_page

diffprofile 2.5.44-mm4 2.5.44-mm4-focht12
(for kernbench, + got worse by adding the patch, - got better)

<nothing significantly degraded>
....
-57 path_lookup
-69 do_page_fault
-73 vm_enough_memory
-77 filemap_nopage
-78 do_no_page
-83 __set_page_dirty_buffers
-83 __fput
-84 do_schedule
-97 find_get_page
-106 file_move
-115 free_hot_cold_page
-115 clear_page_tables
-130 d_lookup
-147 atomic_dec_and_lock
-157 page_add_rmap
-197 buffered_rmqueue
-236 zap_pte_range
-264 get_empty_filp
-271 __copy_to_user
-464 page_remove_rmap
-573 .text.lock.file_table
-618 __copy_from_user
-823 do_anonymous_page


