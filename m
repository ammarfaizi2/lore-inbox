Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292035AbSCDG6J>; Mon, 4 Mar 2002 01:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292036AbSCDG6A>; Mon, 4 Mar 2002 01:58:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15009 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292035AbSCDG5q>; Mon, 4 Mar 2002 01:57:46 -0500
Date: Mon, 4 Mar 2002 00:12:23 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
Message-ID: <20020304001223.A29448@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



More bottlenecks located during SCI/Gigabit Ethernet testing
and profiling.  Configuration is 2.4.19-pre2(3) running SCI 
and Intel e1000 gigbit ethernet adapters.  In this scenario,
the Gnet adapter is DMA'ing frames from a gigabit segment 
directly into reflective memory mapped into an SCI adapter
address space, then immediately triggering an outbound
DMA of the data over an SCI clustering fabric into
the memory of a remote node.  In essense a GNET to SCI 
routing fabric.  

Performance thoughput numbers are stable for the most part since
we are at the maximum throughput with Intel's GNET adapters at 
124 MB/S, however, processor utilization, locking, etc. is far more 
excessive than necessary.   We are also spending too much time calling 
kmalloc/kfree during skb contruct/destruct operations.  Also, 
Intel's adapter by default has the ring buffer size in the driver 
set to 256 packets, and our skb hot_list count we before discarding
free skb header frames is too low for these GNET adapters (128),
resulting in packet overruns intermittently.  

Increasing these numbers and using a fixed frame size consistent with GNET
(less 9K jumbo frames) instead of kmalloc'ing/kfree'ing the 
skb->data portion of these frames all the time yields a decrease  
in remote receipt latency and lower utilization and bus 
utilization. 

Measured latency of packets coming off the SCI interface on the remote
side of the clustering fabric is 3-4% higher between the two 
test scenarios.

The modifications made to skbuff.c are extensive and driver changes 
were also required to get around these performance problems.  Data
provided for review.  Recommend a minumum change of increasing 
the sysctl_hot_list_len from 128 to 1024 by default.  I have reviewed 
(and modified) the skbuff and all the copy stuff related to mapping
fragment lists, etc. and this code is quite a mess.  

NetWare always created ECB's (Event Control Blocks) at the max size
of the network adpapter rather than trying to allocate fragment 
elements on the fly the way is being done in Linux with skb's.  

Bottom line is this stuff is impacting performance and IO bandwidth,
and needs to be corrected.  Default hot_list size should be 
increased by default.


/usr/src/linux/net/core/skbuff.c

//int sysctl_hot_list_len = 128;
int sysctl_hot_list_len = 1024;  // bump this value up


alloc_skb with calls to kmalloc/kfree 2.4.19-pre2 with code
"as is".  Notice high call rate to kmalloc/kfree and corresponding
higher utilization (@ 7%)

 36324 total                                      0.0210
 28044 default_idle                             584.2500
  1117 __rdtsc_delay                             34.9062
   927 eth_type_trans                             4.4567
   733 skb_release_data                           5.0903
   645 kmalloc                                    2.5195
   638 kfree                                      3.9875
   463 __make_request                             0.3180
   415 __scsi_end_request                         1.3651
   382 alloc_skb                                  0.8843
   372 tw_interrupt                               0.3633
   241 kfree_skbmem                               1.8828
   233 scsi_dispatch_cmd                          0.4161
   233 __generic_copy_to_user                     3.6406
   194 __kfree_skb                                0.9327
   184 scsi_request_fn                            0.2396
   103 ip_rcv                                     0.1238
    88 __wake_up                                  0.5000
    84 do_anonymous_page                          0.4773
    72 do_softirq                                 0.4091

52 processes: 51 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 32.8% system,  0.0% nice, 67.1% idle
Mem:   897904K av,  869248K used,   28656K free,       0K shrd,    3724K buff
Swap: 1052216K av,       0K used, 1052216K free                   46596K cached



alloc_skb_frame with fixed 1514 + fragment list allocations, 
sysctl_hot_list_len = 1024.  

 34880 total                                      0.0202
 28581 default_idle                             595.4375
  1125 __rdtsc_delay                             35.1562
  1094 eth_type_trans                             5.2596
   657 skb_release_data                           4.5625
   378 __make_request                             0.2596
   335 alloc_skb_frame                            1.1020
   334 tw_interrupt                               0.3262
   293 __scsi_end_request                         0.9638
   208 scsi_dispatch_cmd                          0.3714
   193 __kfree_skb                                0.9279
   184 scsi_request_fn                            0.2396
   160 kfree_skbmem                               1.2500
    90 __generic_copy_to_user                     1.4062
    81 ip_rcv                                     0.0974
    68 __wake_up                                  0.3864
    59 do_anonymous_page                          0.3352
    48 do_softirq                                 0.2727
    43 generic_make_request                       0.1493
    43 alloc_skb                                  0.0995

50 processes: 49 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 27.5% system,  0.0% nice, 72.4% idle
Mem:   897904K av,  841280K used,   56624K free,       0K shrd,    2220K buff
Swap: 1052216K av,       0K used, 1052216K free                   22292K cached


Jeff


