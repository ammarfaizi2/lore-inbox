Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263472AbUECCR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUECCR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbUECCR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:17:29 -0400
Received: from holomorphy.com ([207.189.100.168]:13188 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263472AbUECCRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:17:16 -0400
Date: Sun, 2 May 2004 19:17:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [0/2] filtered wakeups
Message-ID: <20040503021709.GF1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thundering herd issue in waitqueue hashing has been seen in
practice. In order to preserve the space footprint reduction while
improving performance, I wrote "filtered wakeups", which discriminate
between waiters based on a key.

The following patch series, vs. 2.6.6-rc3-mm1, drastically reduces the
kernel cpu consumption of tiobench --threads 512 --size 16384 (fed to
tiotest by hand since apparently the perl script is buggy) on a 6x336MHz
UltraSPARC III Sun Enterprise 3000 with 3.5GB RAM, ESP-366HME HBA,
10x10Krpm 18GB U160 SCSI disks configured for dm thusly:
0 355655680 striped 10 64 /dev/sda 0 /dev/sdb 0 /dev/sdc 0 /dev/sdd 0 \
	/dev/sde 0 /dev/sdf 0 /dev/sdg 0 /dev/sdh 0 /dev/sdi 0 /dev/sdj 0
This was mkfs'd freshly to a single 171GB ext2 fs.

1/2, filtered page waitqueues, resolves the thundering herd issue with
	hashed page waitqueues.
2/2, filtered buffer_head waitqueues, resolves the thundering herd issue
	with hashed buffer_head waitqueues.
Futexes appear to have their own solution to this issue, which is
necessarily different from this as it needs to discriminate based on a
longer key. They could in principle be consolidated by passing a
comparator instead of comparing a key field or some similar strategy at
the cost of indirect function calls.

I furthermore instrumented the calls to schedule(), possibly done
indirectly, in patch 0.5/2 of the series, which isn't necessarily meant
to be applied to anything, but merely shows how I collected some of the
information in the runtime logs, which for space reasons I've posted as
URL's instead of including them inline.
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/filtered_wakeup/virgin_mm.log.tar.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/filtered_wakeup/filtered_wakeup.log.tar.bz2

Here "cpusec" represents 1 second of actual cpu consumed, counting cpu
consumption of both user and kernel. Apart from regular sampling of
profile data, no other load was running on the machine.

before:
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs | 1118.1 s |  14.654 MB/s |   1.6 %  | 280.9 % |
| Random Write 2000 MBs |  336.2 s |   5.950 MB/s |   0.8 %  |  20.4 % |
| Read        16384 MBs | 1717.1 s |   9.542 MB/s |   1.4 %  |  31.8 % |
| Random Read  2000 MBs |  465.2 s |   4.300 MB/s |   1.1 %  |  36.1 % |
`----------------------------------------------------------------------'

Throughput scaled by %cpu:
Write:            5.1873MB/cpusec
Random Write:    28.0660MB/cpusec
Read:            28.7410MB/cpusec
Random Read:     11.5591MB/cpusec

top 10 kernel cpu consumers:
 21733 finish_task_switch                       113.1927
 11976 __wake_up                                187.1250
 11433 generic_file_aio_write_nolock              5.0321
  9730 read_sched_profile                        43.4375
  9606 file_read_actor                           42.8839
  9116 __do_softirq                              31.6528
  8682 do_anonymous_page                         19.3795
  3635 prepare_to_wait                           28.3984
  2159 kmem_cache_free                           16.8672
  1944 buffered_rmqueue                           3.3750

top 10 callers of scheduling functions:
9391185 wait_on_page_bit                         32608.2812
7280055 cpu_idle                                 37916.9531
1458446 __lock_page                              5064.0486
258142 __handle_preemption                      16133.8750
134815 worker_thread                            247.8217
 45989 __wait_on_buffer                         205.3080
 22294 do_exit                                   21.7715
 22187 generic_file_aio_write_nolock              9.7654
 14932 sys_wait4                                 25.9236
 14652 shrink_list                                7.8944


after:
Tiotest results for 512 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write       16384 MBs | 1099.5 s |  14.901 MB/s |   2.2 %  | 279.3 % |
| Random Write 2000 MBs |  333.8 s |   5.991 MB/s |   1.0 %  |  14.9 % |
| Read        16384 MBs | 1706.3 s |   9.602 MB/s |   1.4 %  |  19.1 % |
| Random Read  2000 MBs |  460.3 s |   4.345 MB/s |   1.1 %  |  14.8 % |
`----------------------------------------------------------------------'

Throughput scaled by %cpu:
Write:            5.2934MB/cpusec
Random Write:    37.6792MB/cpusec
Read:            46.8390MB/cpusec
Random Read:     27.3270MB/cpusec

top 10 kernel cpu consumers:
 11873 generic_file_aio_write_nolock              5.2258
 10245 file_read_actor                           45.7366
 10212 read_sched_profile                        45.5893
 10135 finish_task_switch                        52.7865
  9171 do_anonymous_page                         20.4710
  8619 __do_softirq                              29.9271
  2905 wake_up_filtered                          18.1562
  2325 __get_page_state                          10.3795
  2278 del_timer_sync                             5.0848
  2033 buffered_rmqueue                           3.5295

top 10 callers of scheduling functions:
3985424 cpu_idle                                 20757.4167
2396754 wait_on_page_bit                         7489.8562
209453 __handle_preemption                      13090.8125
164071 worker_thread                            301.6011
 24321 do_exit                                   23.7510
 21272 generic_file_aio_write_nolock              9.3627
 16271 sys_wait4                                 28.2483
 11080 pipe_wait                                 86.5625
  9634 compat_sys_nanosleep                      25.0885
  7742 shrink_list                                4.1713


-- wli
