Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVIONOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVIONOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVIONOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:14:07 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:60619 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1030410AbVIONOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:14:06 -0400
Date: Thu, 15 Sep 2005 21:16:51 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: Adaptive read-ahead: benchmarks
Message-ID: <20050915131651.GA5336@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I carried out the tests on a DELL PE1750 with 2G memory and a hardware
raid5 array built on three 73G SCSI disks. I failed to interpret some of
the benchmark results, any comments are greatly appreciated. 

DEBUG OUTPUT
=====================================================================

# cp kernel-image-2.6.13_10.00.Custom_i386.deb /dev/null
-----------------------------------------------------------------
the current logic:

[17179814.868000] blockable-readahead(ino=83571, ra=0+1) = 1
[17179814.880000] blockable-readahead(ino=83571, ra=1+4) = 4
[17179814.880000] blockable-readahead(ino=83571, ra=5+16) = 16
[17179814.892000] blockable-readahead(ino=83571, ra=21+32) = 32
[17179814.896000] blockable-readahead(ino=83571, ra=53+64) = 64
[17179814.924000] blockable-readahead(ino=83571, ra=117+128) = 128
[17179814.924000] blockable-readahead(ino=83571, ra=245+256) = 256
[17179815.024000] blockable-readahead(ino=83571, ra=501+256) = 256
[17179815.024000] blockable-readahead(ino=83571, ra=757+256) = 256
[17179815.076000] blockable-readahead(ino=83571, ra=1013+256) = 256
[17179815.100000] blockable-readahead(ino=83571, ra=1269+256) = 256
[17179815.184000] blockable-readahead(ino=83571, ra=1525+256) = 256
[17179815.188000] blockable-readahead(ino=83571, ra=1781+256) = 256
[17179815.236000] blockable-readahead(ino=83571, ra=2037+256) = 256
[17179815.272000] blockable-readahead(ino=83571, ra=2293+256) = 256
[17179815.328000] blockable-readahead(ino=83571, ra=2549+256) = 256
[17179815.332000] blockable-readahead(ino=83571, ra=2805+256) = 256
[17179815.368000] blockable-readahead(ino=83571, ra=3061+256) = 256
[17179815.396000] blockable-readahead(ino=83571, ra=3317+256) = 251
[17179815.424000] blockable-readahead(ino=83571, ra=3573+256) = 0

the new logic with readahead-ratio set to 101:

[17179673.064000] readahead(ino=83571, index=0-0-1, ra=0+32) = 32
[17179673.084000] readahead(ino=83571, index=32-32-33, ra=32+32) = 32
[17179673.100000] readahead(ino=83571, index=64-64-65, ra=64+64) = 64
[17179673.116000] readahead(ino=83571, index=128-128-129, ra=128+129) = 129
[17179673.144000] readahead(ino=83571, index=257-257-258, ra=257+256) = 256
[17179673.212000] readahead(ino=83571, index=513-513-514, ra=513+256) = 256
[17179673.248000] readahead(ino=83571, index=769-769-770, ra=769+256) = 256
[17179673.288000] readahead(ino=83571, index=1025-1025-1026, ra=1025+256) = 256
[17179673.332000] readahead(ino=83571, index=1281-1281-1282, ra=1281+256) = 256
[17179673.408000] readahead(ino=83571, index=1537-1537-1538, ra=1537+256) = 256
[17179673.440000] readahead(ino=83571, index=1793-1793-1794, ra=1793+256) = 256
[17179673.476000] readahead(ino=83571, index=2049-2049-2050, ra=2049+256) = 256
[17179673.512000] readahead(ino=83571, index=2305-2305-2306, ra=2305+256) = 256
[17179673.576000] readahead(ino=83571, index=2561-2561-2562, ra=2561+256) = 256
[17179673.604000] readahead(ino=83571, index=2817-2817-2818, ra=2817+256) = 256
[17179673.652000] readahead(ino=83571, index=3073-3073-3074, ra=3073+256) = 256
[17179673.704000] readahead(ino=83571, index=3329-3329-3330, ra=3329+256) = 239

OPROFILE STATISTICS
=====================================================================
# cat oprofile.sh 
#!/bin/sh

oprofile() {
        opcontrol --vmlinux=/temp/kernel/linux-2.6.13ra/vmlinux
        opcontrol --start
        opcontrol --reset
        echo $1 > /proc/sys/vm/readahead_ratio
        dd if=/temp/kernel/hugefile of=/dev/null bs=$bs
        opreport -l -o oprofile.$1.$bs /temp/kernel/linux-2.6.13ra/vmlinux
        opcontrol --stop
}

bs=$1
shift

while test -n "$1"
do      
        oprofile $1
        shift
done

# ./oprofile.sh 4k 0 100
3932946432 bytes transferred in 80.383702 seconds (48927162 bytes/sec)
3932946432 bytes transferred in 109.835723 seconds (35807534 bytes/sec)

# head -n100 oprofile.0.4k
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.38 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
34745    14.0697  __copy_to_user_ll
11894     4.8164  ll_rw_block
10362     4.1960  system_call
8669      3.5104  shrink_list
7761      3.1428  radix_tree_delete
7627      3.0885  __find_get_block
6901      2.7945  delay_pmtmr
6474      2.6216  add_to_page_cache
5350      2.1664  dnotify_parent
4868      1.9713  isolate_lru_pages
4768      1.9308  inotify_dentry_parent_queue_event
4453      1.8032  do_generic_mapping_read
4421      1.7902  do_mpage_readpage
4108      1.6635  find_get_page
4047      1.6388  default_idle
4000      1.6198  unlock_buffer
3914      1.5849  __brelse
3850      1.5590  zone_watermark_ok
3777      1.5295  __wake_up_bit
3615      1.4639  __do_page_cache_readahead
3211      1.3003  unlock_page
3095      1.2533  kmap_atomic
3059      1.2387  bad_range
2894      1.1719  __mod_page_state
2665      1.0792  free_pages_bulk
2530      1.0245  __alloc_pages
2385      0.9658  __pagevec_lru_add
2273      0.9204  mpage_end_io_read
2225      0.9010  free_hot_cold_page
2092      0.8471  buffered_rmqueue
1811      0.7333  page_waitqueue
1808      0.7321  radix_tree_lookup
1780      0.7208  __rmqueue
1702      0.6892  find_busiest_group
1672      0.6771  page_referenced
1648      0.6673  mark_page_accessed
1594      0.6455  __read_lock_failed
1560      0.6317  wakeup_kswapd
1557      0.6305  __pagevec_release_nonlru
1464      0.5928  schedule
1449      0.5868  mark_offset_pmtmr
1439      0.5827  radix_tree_insert
1367      0.5536  blk_recount_segments
1306      0.5289  release_pages
1162      0.4705  current_fs_time
1159      0.4693  apic_timer_interrupt
1098      0.4446  mempool_free
1061      0.4296  vfs_read
1045      0.4232  kmem_cache_alloc
1031      0.4175  __write_lock_failed
1019      0.4126  timer_interrupt
931       0.3770  vfs_write
925       0.3746  bit_waitqueue
908       0.3677  mpage_readpages
895       0.3624  find_next_bit
895       0.3624  kmem_cache_free
892       0.3612  __bio_add_page
883       0.3576  irq_entries_start
818       0.3312  sys_write
794       0.3215  sys_read
788       0.3191  restore_nocheck
783       0.3171  __remove_from_page_cache
762       0.3086  __do_IRQ
750       0.3037  __generic_file_aio_read
749       0.3033  page_address
718       0.2907  __getblk
694       0.2810  shrink_cache
686       0.2778  blk_rq_map_sg
654       0.2648  as_completed_request
613       0.2482  shrink_slab
606       0.2454  scheduler_tick
602       0.2438  file_read_actor
589       0.2385  rmqueue_bulk
583       0.2361  generic_file_read
577       0.2337  load_balance
567       0.2296  __make_request
563       0.2280  fget_light
558       0.2260  rw_verify_area
553       0.2239  run_timer_softirq
513       0.2077  radix_tree_preload
513       0.2077  smp_apic_timer_interrupt
495       0.2004  cond_resched
493       0.1996  bio_alloc_bioset
462       0.1871  rebalance_tick
417       0.1689  update_atime
406       0.1644  generic_make_request
389       0.1575  __do_softirq
382       0.1547  cpu_idle
381       0.1543  update_process_times
377       0.1527  prep_new_page
373       0.1510  __end_that_request_first
371       0.1502  balance_pgdat
352       0.1425  as_update_iohist
349       0.1413  tasklet_action
345       0.1397  account_system_time
333       0.1348  __read_page_state
333       0.1348  sched_clock
# head -n100 oprofile.100.4k
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.38 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
36120    13.7910  __copy_to_user_ll
12537     4.7868  ll_rw_block
10416     3.9770  system_call
8790      3.3561  shrink_list
8147      3.1106  radix_tree_delete
7833      2.9907  __find_get_block
7731      2.9518  delay_pmtmr
6651      2.5394  add_to_page_cache
5346      2.0412  dnotify_parent
5174      1.9755  default_idle
5174      1.9755  isolate_lru_pages
4966      1.8961  inotify_dentry_parent_queue_event
4626      1.7663  do_generic_mapping_read
4418      1.6868  do_mpage_readpage
4054      1.5479  __brelse
4033      1.5398  __wake_up_bit
4012      1.5318  unlock_buffer
3906      1.4914  find_get_page
3859      1.4734  zone_watermark_ok
3712      1.4173  __do_page_cache_readahead
3418      1.3050  unlock_page
3194      1.2195  bad_range
3109      1.1871  kmap_atomic
3029      1.1565  __mod_page_state
2603      0.9939  __alloc_pages
2594      0.9904  free_pages_bulk
2356      0.8995  __pagevec_lru_add
2309      0.8816  find_busiest_group
2227      0.8503  free_hot_cold_page
2126      0.8117  schedule
2078      0.7934  mpage_end_io_read
2030      0.7751  buffered_rmqueue
2015      0.7694  mark_offset_pmtmr
1943      0.7419  radix_tree_lookup
1904      0.7270  page_waitqueue
1898      0.7247  __rmqueue
1774      0.6773  page_referenced
1720      0.6567  mark_page_accessed
1672      0.6384  __read_lock_failed
1646      0.6285  __pagevec_release_nonlru
1614      0.6162  wakeup_kswapd
1511      0.5769  apic_timer_interrupt
1471      0.5616  radix_tree_insert
1452      0.5544  blk_recount_segments
1437      0.5487  release_pages
1320      0.5040  timer_interrupt
1247      0.4761  current_fs_time
1149      0.4387  vfs_read
1133      0.4326  mempool_free
1129      0.4311  find_next_bit
1105      0.4219  kmem_cache_alloc
1048      0.4001  __write_lock_failed
1023      0.3906  irq_entries_start
929       0.3547  vfs_write
902       0.3444  bit_waitqueue
887       0.3387  __generic_file_aio_read
878       0.3352  kmem_cache_free
865       0.3303  __bio_add_page
861       0.3287  load_balance
853       0.3257  __do_IRQ
843       0.3219  mpage_readpages
840       0.3207  page_address
839       0.3203  __remove_from_page_cache
822       0.3138  restore_nocheck
810       0.3093  sys_read
787       0.3005  sys_write
776       0.2963  __getblk
749       0.2860  scheduler_tick
726       0.2772  shrink_cache
707       0.2699  run_timer_softirq
656       0.2505  blk_rq_map_sg
651       0.2486  as_completed_request
651       0.2486  file_read_actor
642       0.2451  smp_apic_timer_interrupt
610       0.2329  rw_verify_area
604       0.2306  shrink_slab
600       0.2291  rebalance_tick
598       0.2283  rmqueue_bulk
590       0.2253  generic_file_read
570       0.2176  fget_light
558       0.2131  __make_request
524       0.2001  update_process_times
523       0.1997  bio_alloc_bioset
522       0.1993  cond_resched
506       0.1932  radix_tree_preload
502       0.1917  __do_softirq
482       0.1840  cpu_idle
454       0.1733  sched_clock
437       0.1669  update_atime
430       0.1642  account_system_time
425       0.1623  generic_make_request
412       0.1573  __switch_to
399       0.1523  tasklet_action
396       0.1512  rt_run_flush
395       0.1508  try_to_wake_up
390       0.1489  __read_page_state
369       0.1409  balance_pgdat 
additional two lines:
324       0.1237  page_cache_readahead_adaptive
46        0.0176  count_sequential_pages

Summary:
1. The real time of dd is 80.383702 to 109.835723, or 1:1.37.
The current logic has an 'ahead window' and always issues readaheads
ahead of time, which effectively prevents reads to stall from time to
time. The new logic simply issues readaheads at times of immediate need.
So the difference is quite reasonable.

2. The new logic shows 5% or so overhead, though the direct overhead of
the two functions is only 2%.
Where is the remaining 3%? Locking contentions somewhere?


SEQUENTIAL READ PATTERNS
=====================================================================
# cat test_ra.sh
#!/bin/zsh

blockdev --setra 256 /dev/sda 
echo deadline > /sys/block/sda/queue/scheduler

TIMEFMT="%E real  %S system  %U user  %w+%c cs  %J"
FILE=hugefile

bs=$1
shift

while test -n "$1"
do
        echo $1 > /proc/sys/vm/readahead_ratio

        cp $FILE /dev/null
        echo "readahead_ratio = $1"

        time dd if=$FILE of=/dev/null bs=$bs 2>/dev/null
        time grep -r 'asdfghjkl;' linux-2.6.13 &
        time dd if=$FILE of=/dev/null bs=$bs 2>/dev/null &
        time diff -r linux-2.6.13 linux-2.6.13ra >/dev/null &

        sleep 20
        while {pidof dd diff grep > /dev/null};
        do
                sleep 3
        done

        shift
done

# ./test_ra.sh 4k 0 100
readahead_ratio = 0
79.75s real  8.88s system  0.43s user  13927+10 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
142.75s real  1.37s system  24.16s user  13724+42 cs  grep -r 'asdfghjkl;' linux-2.6.13
167.09s real  9.47s system  0.50s user  25065+30 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
173.99s real  3.70s system  1.48s user  31148+10 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
readahead_ratio = 100
107.51s real  8.58s system  0.48s user  28065+8 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
149.86s real  1.60s system  23.57s user  14372+42 cs  grep -r 'asdfghjkl;' linux-2.6.13
178.63s real  9.52s system  0.51s user  32047+34 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
184.56s real  3.87s system  1.34s user  32399+6 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null

Summary:
1. The blockdev command takes no effect at all -- the readahead-max is
still 1M.

2. In single stream, the new logic seems to get lower system time,
doesn't it conflict with that of oprofile?
And context switches are more than doubled, but why?

3. In parallel streams, the new logic gets more system time and lower
user time, context switches are roughly the same.
The 'ahead window' magic should work only for large files, though the
new logic losed again in small files. Maybe it's the 3 radix tree
lookups that show up in small reads?

To find things out, I add a call to lock_page() at the end of
__do_page_cache_readahead(), and the code can be enabled with some
readahead_ratio values(such as 102).
The command below runs the test with the page lock:

# ./test_ra.sh 4k 102
readahead_ratio = 102
108.66s real  9.43s system  0.48s user  10235+132 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
192.52s real  1.87s system  23.86s user  19073+321 cs  grep -r 'asdfghjkl;' linux-2.6.13
201.40s real  9.99s system  0.46s user  17490+141 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
209.59s real  4.37s system  1.55s user  36987+68 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null

It shows that context switches are effectively cut down in dd, though
system times are even higher.

MORE DATA
=====================================================================
Some more tests with 32k block size:

# ./test_ra.sh 32k 0 100 102
readahead_ratio = 0
80.05s real  7.98s system  0.07s user  14044+117 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
148.02s real  1.38s system  24.45s user  13532+310 cs  grep -r 'asdfghjkl;' linux-2.6.13
178.84s real  8.66s system  0.08s user  26165+130 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
180.80s real  4.01s system  1.54s user  32994+67 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
readahead_ratio = 100
108.13s real  7.92s system  0.05s user  28877+97 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
157.50s real  1.50s system  22.35s user  14842+291 cs  grep -r 'asdfghjkl;' linux-2.6.13
185.94s real  8.81s system  0.09s user  34166+117 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
190.27s real  3.90s system  1.60s user  35728+66 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
readahead_ratio = 102
112.04s real  9.22s system  0.48s user  10483+136 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
190.23s real  1.74s system  21.76s user  19097+279 cs  grep -r 'asdfghjkl;' linux-2.6.13
199.14s real  10.10s system  0.56s user  17904+179 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
207.10s real  4.20s system  1.43s user  38820+63 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null

More oprofile results:
# head -n20 oprofile.0.4k
PU: P4 / Xeon with 2 hyper-threads, speed 2388.41 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
34763    14.0479  __copy_to_user_ll
15171     6.1307  ll_rw_block
10795     4.3623  system_call
10254     4.1437  shrink_list
9199      3.7174  __find_get_block
7818      3.1593  delay_pmtmr
6480      2.6186  add_to_page_cache
5541      2.2391  radix_tree_delete
5478      2.2137  isolate_lru_pages
5474      2.2121  dnotify_parent
5141      2.0775  __brelse
5014      2.0262  inotify_dentry_parent_queue_event
4838      1.9551  unlock_buffer
4790      1.9357  find_get_page
4618      1.8662  do_mpage_readpage
4390      1.7740  do_generic_mapping_read
3989      1.6120  default_idle
# head -n20 oprofile.102.4k 
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.41 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
34954    14.0548  __copy_to_user_ll
14888     5.9864  ll_rw_block
10895     4.3808  shrink_list
10398     4.1810  system_call
9109      3.6627  __find_get_block
8003      3.2180  delay_pmtmr
6746      2.7125  add_to_page_cache
5752      2.3128  radix_tree_delete
5644      2.2694  isolate_lru_pages
5354      2.1528  dnotify_parent
5004      2.0121  __brelse
4952      1.9912  default_idle
4900      1.9703  find_get_page
4845      1.9481  inotify_dentry_parent_queue_event
4711      1.8943  unlock_buffer
4404      1.7708  do_generic_mapping_read
4135      1.6627  do_mpage_readpage

# head -n20 oprofile.0.32k
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.41 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
36906    16.4281  __copy_to_user_ll
15199     6.7656  ll_rw_block
10248     4.5617  shrink_list
9276      4.1291  __find_get_block
7811      3.4769  delay_pmtmr
6706      2.9851  add_to_page_cache
6028      2.6833  isolate_lru_pages
5855      2.6063  radix_tree_delete
5577      2.4825  find_get_page
4959      2.2074  __brelse
4931      2.1950  unlock_buffer
4189      1.8647  do_mpage_readpage
4025      1.7917  default_idle
3869      1.7222  mpage_end_io_read
3809      1.6955  __do_page_cache_readahead
3069      1.3661  kmap_atomic
2814      1.2526  __read_lock_failed
# head -n20 oprofile.100.32k
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.41 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
37118    15.8645  __copy_to_user_ll
15602     6.6684  ll_rw_block
10664     4.5579  shrink_list
9487      4.0548  __find_get_block
8366      3.5757  delay_pmtmr
6902      2.9500  add_to_page_cache
6192      2.6465  isolate_lru_pages
5989      2.5597  radix_tree_delete
5164      2.2071  __brelse
5060      2.1627  unlock_buffer
4962      2.1208  default_idle
4668      1.9951  find_get_page
4381      1.8725  do_mpage_readpage
3957      1.6912  __do_page_cache_readahead
3223      1.3775  kmap_atomic
3185      1.3613  mpage_end_io_read
3080      1.3164  __wake_up_bit
# head -n20 oprofile.102.32k
CPU: P4 / Xeon with 2 hyper-threads, speed 2388.41 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
34634    15.8598  __copy_to_user_ll
14628     6.6985  ll_rw_block
10239     4.6887  shrink_list
8721      3.9936  __find_get_block
7880      3.6085  delay_pmtmr
6424      2.9417  add_to_page_cache
5654      2.5891  isolate_lru_pages
5418      2.4810  radix_tree_delete
5104      2.3373  find_get_page
4860      2.2255  default_idle
4821      2.2077  __brelse
4765      2.1820  unlock_buffer
4008      1.8354  do_mpage_readpage
3322      1.5212  __do_page_cache_readahead
3114      1.4260  __read_lock_failed
2959      1.3550  kmap_atomic
2713      1.2424  __wake_up_bit



LARGE READ SIZE
=====================================================================
There is an early (broken) version that issues the next readahead when
only 1/4 of the previous readahead pages are left. This behaves like the
current logic, and the results are exciting. But I think it is not sane
to search through the page cache too much.

The default kernel on my PC with 128K readahead-max:
====================================================================
readahead_ratio = 0  
22387+1 records in
22387+1 records out 
733589504 bytes transferred in 25.293262 seconds (29003357 bytes/sec)
  0.01s user 1.56s system 6% cpu 25.310 total
22326+1 records in
22326+1 records out
731596800 bytes transferred in 103.776015 seconds (7049768 bytes/sec)
  0.01s user 1.54s system 1% cpu 1:43.85 total
  0.38s user 1.50s system 1% cpu 2:09.72 total
--------------------------------------------------------------------

An early version of the new logic with 2M readahead-max:
====================================================================
readahead_ratio = 90
22387+1 records in
22387+1 records out
733589504 bytes transferred in 21.265200 seconds (34497183 bytes/sec)
  0.01s user 1.56s system 7% cpu 21.334 total
22326+1 records in
22326+1 records out
731596800 bytes transferred in 42.916377 seconds (17047031 bytes/sec)
  0.02s user 1.51s system 3% cpu 43.126 total
  0.37s user 1.44s system 2% cpu 1:08.89 total
--------------------------------------------------------------------

It effectively shows the advantage of large readahead sizes ;)
-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
