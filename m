Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUEEGHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUEEGHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUEEGHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:07:25 -0400
Received: from holomorphy.com ([207.189.100.168]:8591 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262418AbUEEGGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:06:19 -0400
Date: Tue, 4 May 2004 23:06:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [0/3] filtered wakeups respun
Message-ID: <20040505060612.GV1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1/3]: filtered wakeups
	filter wakeups by the page being woken up for
[2/3]: filtered buffers
	filter wakeups by the bh being woken up for
[3/3]: wakeone
	restore wake-one semantics to bitlocking for pages and bh's

Same machine/etc. as before, except this time, ext3 instead of ext2.
ext3 shows noise-level differences in raw throughputs with large
reductions in cpu overhead, mostly on the read side.

ext2 results differ from these in that a 23% boost to sequential write
cpu efficiency (throughput scaled by %cpu) is also achieved for
sequential writes, almost entirely due to wake-one semantics. The tests
take long enough to run that I've not done the ext2 results on a
precisely-matching codebase. From the extant ext2 results:

$ cat ~/tmp/virgin_mm.log/tiotest.log  
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs | 1118.1 s |  14.654 MB/s |   1.6 %  | 280.9 % |
| Random Write 2000 MBs |  336.2 s |   5.950 MB/s |   0.8 %  |  20.4 % |
| Read        16384 MBs | 1717.1 s |   9.542 MB/s |   1.4 %  |  31.8 % |
| Random Read  2000 MBs |  465.2 s |   4.300 MB/s |   1.1 %  |  36.1 % |
`----------------------------------------------------------------------'
$ cat ~/tmp/filtered_wakeup.log/tiotest.log                   
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs | 1099.5 s |  14.901 MB/s |   2.2 %  | 279.3 % |
| Random Write 2000 MBs |  333.8 s |   5.991 MB/s |   1.0 %  |  14.9 % |
| Read        16384 MBs | 1706.3 s |   9.602 MB/s |   1.4 %  |  19.1 % |
| Random Read  2000 MBs |  460.3 s |   4.345 MB/s |   1.1 %  |  14.8 % |
`----------------------------------------------------------------------'
$ cat ~/tmp/wakeone.log/tiotest.log                          
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs | 1073.8 s |  15.258 MB/s |   1.5 %  | 237.3 % |
| Random Write 2000 MBs |  336.9 s |   5.937 MB/s |   0.9 %  |  15.2 % |
| Read        16384 MBs | 1703.0 s |   9.621 MB/s |   1.3 %  |  18.8 % |
| Random Read  2000 MBs |  458.6 s |   4.361 MB/s |   1.0 %  |  14.9 % |
`----------------------------------------------------------------------'

/home/wli/tmp/virgin_mm.log/tiotest.log:
Write:            5.1873MB/cpusec
Random Write:    28.0660MB/cpusec
Read:            28.7410MB/cpusec
Random Read:     11.5591MB/cpusec
/home/wli/tmp/filtered_wakeup.log/tiotest.log:
Write:            5.2934MB/cpusec
Random Write:    37.6792MB/cpusec
Read:            46.8390MB/cpusec
Random Read:     27.3270MB/cpusec
/home/wli/tmp/wakeone.log/tiotest.log:
Write:            6.3894MB/cpusec
Random Write:    36.8758MB/cpusec
Read:            47.8657MB/cpusec
Random Read:     27.4277MB/cpusec

The wakeone implementation used for the ext2 run(s) above was somewhat
less refined than the current one in that it didn't implement wake-one
semantics for lock_buffer() and committed a major stupidity in waking
more waiters than necessary in its wake_up_filtered().

One should also note specific complaints about random read performance
are going around, and this near triples ext3's cpu efficiency on random
reads i.e. it takes ext3 from 10.3MB/cpusec to 28.5MB/cpusec.


ext3 results;
before:
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs |  926.5 s |  17.683 MB/s |   1.9 %  | 161.3 % |
| Random Write 2000 MBs |  333.5 s |   5.998 MB/s |   0.9 %  |  21.0 % |
| Read        16384 MBs | 1634.0 s |  10.027 MB/s |   1.5 %  |  28.4 % |
| Random Read  2000 MBs |  448.1 s |   4.463 MB/s |   1.2 %  |  42.2 % |
`----------------------------------------------------------------------'

Throughput scaled by cpu consumption:
Write:           10.8352MB/cpusec
Random Write:    27.3881MB/cpusec
Read:            33.5351MB/cpusec
Random Read:     10.2834MB/cpusec

top 10 cpu consumers:
 15328 finish_task_switch                        79.8333
 10149 __wake_up                                158.5781
  9859 generic_file_aio_write_nolock              4.3393
  8836 file_read_actor                           39.4464
  7601 __do_softirq                              26.3924
  3114 kmem_cache_free                           24.3281
  2810 __find_get_block                           9.7569
  2727 prepare_to_wait                           21.3047
  2464 kmem_cache_alloc                          19.2500
  1675 tl0_linux32                               52.3438

top 10 scheduler callers:
8827430 wait_on_page_bit                         30650.7986
327735 __wait_on_buffer                         1463.1027
209926 __handle_preemption                      13120.3750
138613 worker_thread                            254.8033
 35838 generic_file_aio_write_nolock             15.7738
 32265 __lock_page                              112.0312
 16281 pipe_wait                                127.1953
  9538 do_exit                                    9.3145
  7622 shrink_list                                4.1067
  6816 compat_sys_nanosleep                      17.7500

after:
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs |  926.7 s |  17.680 MB/s |   1.9 %  | 140.4 % |
| Random Write 2000 MBs |  334.4 s |   5.981 MB/s |   0.9 %  |  19.7 % |
| Read        16384 MBs | 1649.8 s |   9.931 MB/s |   1.3 %  |  19.0 % |
| Random Read  2000 MBs |  443.6 s |   4.509 MB/s |   1.1 %  |  14.7 % |
`----------------------------------------------------------------------'

Throughput scaled by cpu consumption:
Write:           12.4245MB/cpusec
Random Write:    29.0340MB/cpusec
Read:            48.9212MB/cpusec
Random Read:     28.5380MB/cpusec

top 10 cpu consumers:
  9751 generic_file_aio_write_nolock              4.2918
  9116 file_read_actor                           40.6964
  7419 __do_softirq                              25.7604
  5217 finish_task_switch                        27.1719
  3482 __find_get_block                          12.0903
  2725 kmem_cache_free                           21.2891
  2669 wake_up_filtered                          13.9010
  2543 kmem_cache_alloc                          19.8672
  1629 find_get_page                             16.9688
  1613 tl0_linux32                               50.4062

top 10 scheduler callers:
2402700 wait_on_page_bit                         6825.8523
198357 __handle_preemption                      12397.3125
179318 worker_thread                            329.6287
 18343 generic_file_aio_write_nolock              8.0735
 15687 pipe_wait                                122.5547
  9306 do_exit                                    9.0879
  7531 __lock_buffer                             39.2240
  6814 compat_sys_nanosleep                      17.7448
  6716 kswapd                                    29.9821
  5429 sys_wait4                                  9.4253


-- wli
