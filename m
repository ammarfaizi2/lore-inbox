Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbTAORdt>; Wed, 15 Jan 2003 12:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTAORdt>; Wed, 15 Jan 2003 12:33:49 -0500
Received: from smtp15.us.dell.com ([143.166.85.138]:11457 "EHLO
	smtp15.us.dell.com") by vger.kernel.org with ESMTP
	id <S266792AbTAORds>; Wed, 15 Jan 2003 12:33:48 -0500
Date: Wed, 15 Jan 2003 11:36:38 -0600 (CST)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: robert@ping.us.dell.com
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
Message-ID: <Pine.LNX.4.44.0301151106340.21210-100000@ping.us.dell.com>
X-Complaints-to: /dev/null
X-Apparently-From: mars
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In between 2.5.56 and 2.5.57 IO speeds have dropped if CONFIG_PREEMPT is 
set. 

The machine is a 4 processor Xeon with 8GB of RAM. The external storage is
attached to the machine via qlogic 2200 HBAs using the qlogicfc driver.  
The filesystems on the external devices is reiserfs, mounted with noatime
as the only change from defaults. The config file is attached below. The
same config was used for both 2.5.56 and 2.5.57. The config has
preemptable kernel enabled. I know preemption will lower your throughput,
but it was enabled in 2.5.56, and speed was good.

The test involved the simultaneous writing to all 8 filesystems on the 
external storage. On 2.5.56, the vmstat output is below

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 8  1      0   7108  87280 7505164    0    0    20  2989  144    56  0 21 
77  1
 8  2      0   8444  85376 7505440    0    0     0 115536 1387  2391  0 93  
1  5
 9  2      0   7684  89364 7502132    0    0     0 112348 1455  2308  0 94  
1  5
 4  2      0   7072  94704 7495600    0    0     0 129468 1382  4314  0 51 
32 18


For 2.5.57, the io bo rate drops, and the system time pegs at 100%

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 8  1      0   8000  61196 7535276    0    0    36  4158  147    22  1 40 
58  1
 9  1      0   7468  62316 7533832    0    0     1 79852 1223   303  0 100  
0  0
 9  1      0   6740  64884 7532368    0    0     0 79655 1288   182  0 100  
0  0
 9  0      0   7004  66720 7528828    0    0     0 78841 1261   354  0 100  
0  0
 9  1      0   8272  67604 7526844    0    0     0 77958 1190   204  0 100  
0  0


The profiling information for 2.5.57 is below
/usr/sbin/readprofile -m /boot/System.map-2.5.57-test2 -v | sort -nr +2 | 
head -15
00000000 total                                    436997   2.9703
c011bb60 __preempt_spin_lock                      293278 3054.9792
c0107020 default_idle                              83500 1304.6875
c011bc22 .text.lock.sched                          55920 185.1656
c0119fc0 __wake_up                                  2371  29.6375
c0118960 kmap_atomic                                 941   7.3516
c0121920 do_softirq                                  393   1.8894
c01189f0 kmap_atomic_to_page                         129   1.1518
c011bb00 __might_sleep                               128   1.3333
c0119af0 schedule                                    126   0.1270
c0113e50 flush_tlb_mm                                 47   0.3264
c011bbc0 __preempt_write_lock                         35   0.3571
c01178c0 do_page_fault                                31   0.0251
c01189e0 kunmap_atomic                                17   1.0625
c0124cb0 add_timer                                    15   0.0446

If I recompile 2.5.57 with preemption off, the vmstat rates go back to the 
rates similar to the 2.5.56 w/ preemption turned on.

Is this expected behaviour now?
Thanks in advance.
Robert

