Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUHDPKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUHDPKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUHDPKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:10:50 -0400
Received: from jade.spiritone.com ([216.99.193.136]:62422 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266467AbUHDPK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:10:27 -0400
Date: Wed, 04 Aug 2004 08:10:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <6560000.1091632215@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.8-rc2-mm2 has some significant improvements over 2.6.8-rc2,
particularly at low to mid loads ... at the high loads, it's still       -58   -33.5% clear_page_tables
       -61   -19.3% __d_lookup
       -70   -15.2% page_remove_rmap
       -71   -71.0% finish_task_switch
       -71   -46.4% fput
       -72   -56.7% buffered_rmqueue
       -73   -53.7% pte_alloc_one
       -74   -22.9% __copy_to_user_ll
       -75   -31.0% do_no_page
       -85   -68.0% free_hot_cold_page
       -95   -66.0% __copy_user_intel
      -118   -21.1% find_trylock_page
      -126   -43.8% do_anonymous_page
      -171   -21.6% copy_page_range
      -368   -38.8% zap_pte_range
      -392   -62.1% do_wp_page
     -6262   -11.9% default_idle
     -9294   -14.4% total

slightly improved, but less significant. Numbers from 16x NUMA-Q.
Kernbench sees most improvement in sys time, but also some elapsed
time ... SDET sees up to 18% more througput.

I'm also amused to see that the process scalability is now pretty
damned good ... a full -j kernel compile (using up to about 1300
tasks) goes as fast as the -j 256 (the middle one) ... and elapsed
is faster than -j16, even if system is a little higher.

I *think* this is the scheduler changes ... fits in with profile diffs
I've seen before ... diffprofiles at the end. In my experience, higher
copy_to/from_user and finish_task_switch stuff tends to indicate task 
thrashing. Note also .text.lock.semaphore numbers in kernbench profile.
The SDET one looks like it's load-balancing better (mainly less idle
time).

Great stuff.

M.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                    2.6.7       45.37       90.91      579.75     1479.33
                2.6.8-rc2       45.05       88.53      577.87     1485.67
            2.6.8-rc2-mm2       44.09       78.84      577.01     1486.33

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                    2.6.7       44.77       97.96      576.59     1507.00
                2.6.8-rc2       44.83       96.00      575.50     1497.33
            2.6.8-rc2-mm2       43.43       86.04      576.26     1524.33

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                    2.6.7       44.25       88.95      575.63     1501.33
                2.6.8-rc2       44.03       87.74      573.82     1503.67
            2.6.8-rc2-mm2       43.75       86.68      576.98     1518.00

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         1.0%
                2.6.8-rc2        95.9%         2.3%
            2.6.8-rc2-mm2       111.5%         3.3%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.0%
                2.6.8-rc2       100.5%         1.4%
            2.6.8-rc2-mm2       115.1%         4.0%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         1.0%
                2.6.8-rc2        99.2%         1.1%
            2.6.8-rc2-mm2       111.9%         0.5%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.2%
                2.6.8-rc2       100.2%         1.0%
            2.6.8-rc2-mm2       117.4%         0.9%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.3%
                2.6.8-rc2        99.5%         0.3%
            2.6.8-rc2-mm2       118.5%         0.6%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.3%
                2.6.8-rc2        99.7%         0.4%
            2.6.8-rc2-mm2       102.1%         0.8%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.2%
                2.6.8-rc2       101.6%         0.4%
            2.6.8-rc2-mm2       103.2%         0.0%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                    2.6.7       100.0%         0.2%
                2.6.8-rc2       100.2%         0.1%
            2.6.8-rc2-mm2       103.0%         0.3%



Diffprofile for kernbench -j32 (-ve numbers better with mm2)
      2135     4.3% default_idle
       233    44.2% pte_alloc_one
       220    11.9% buffered_rmqueue
       164   264.5% schedule
       135     5.9% do_page_fault
        84    10.7% clear_page_tables
        62    62.6% __wake_up_sync
        51    60.7% set_page_address
...
       -50   -43.9% sys_close
       -56   -10.7% __fput
       -58   -13.7% set_page_dirty
       -61   -10.0% copy_process
       -70   -41.4% pipe_writev
       -77    -8.1% file_move
       -85  -100.0% wake_up_forked_thread
       -87   -50.9% pipe_wait
       -90    -5.7% path_lookup
       -93   -21.2% page_add_anon_rmap
      -105   -28.5% release_task
      -113   -11.9% do_wp_page
      -116    -7.9% link_path_walk
      -116   -43.1% pipe_readv
      -121    -7.5% atomic_dec_and_lock
      -138   -15.4% strnlen_user
      -159    -9.4% do_no_page
      -167    -2.7% __d_lookup
      -214   -59.4% find_idlest_cpu
      -230    -6.2% find_trylock_page
      -237    -1.6% do_anonymous_page
      -255    -7.8% zap_pte_range
      -444   -97.6% .text.lock.semaphore
      -532   -43.4% Letext
      -632   -54.2% __wake_up
     -1086   -52.2% finish_task_switch
     -1436   -24.6% __copy_to_user_ll
     -3079   -46.3% __copy_from_user_ll
     -7468    -5.4% total

sdetbench 8 (-ve numbers better with mm2)

...
       -58   -33.5% clear_page_tables
       -61   -19.3% __d_lookup
       -70   -15.2% page_remove_rmap
       -71   -71.0% finish_task_switch
       -71   -46.4% fput
       -72   -56.7% buffered_rmqueue
       -73   -53.7% pte_alloc_one
       -74   -22.9% __copy_to_user_ll
       -75   -31.0% do_no_page
       -85   -68.0% free_hot_cold_page
       -95   -66.0% __copy_user_intel
      -118   -21.1% find_trylock_page
      -126   -43.8% do_anonymous_page
      -171   -21.6% copy_page_range
      -368   -38.8% zap_pte_range
      -392   -62.1% do_wp_page
     -6262   -11.9% default_idle
     -9294   -14.4% total

