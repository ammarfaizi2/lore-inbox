Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUAVD5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUAVD5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:57:41 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:3945 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S264284AbUAVD5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:57:37 -0500
Message-Id: <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Jan 2004 14:57:28 +1100
To: Tom Sightler <ttsig@tuxyturvy.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: JG <jg@cms.ac>, Andreas Hartmann <andihartmann@freenet.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1074655162.5834.16.camel@localhost.localdomain>
References: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <20040119033527.GA11493@linux.comp>
 <20040119033527.GA11493@linux.comp>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:19 PM 21/01/2004, Tom Sightler wrote:
>I'm curious is the people seeing this problem happen to have preempt
>enabled in their config.  I've noticed that my laptop, which also
>happens to have a tg3 based 10/100/1000 card, uses tons of CPU during
>trasfers, but only when preempt is enabled.

nope.
i didn't use PREEMPT=y in my previous test, but i have just done so now.

the difference in CPU utilization when pushing wire-rate gig-e ttcp on this 
system (Dual P4 Xeon) with PREEMPT=y or PREEMPT=n is just noise.

you should run oprofile and see where your cpu time is spent.

with preempt enabled:
   ttcp-t: 6553600000 bytes in 58.29 real seconds = 109797.21 KB/sec +++
   ttcp-t: 6553600000 bytes in 18.47 CPU seconds = 346485.49 KB/cpu sec
   ttcp-t: 100000 I/O calls, msec/call = 0.60, calls/sec = 1715.58
   ttcp-t: 0.1user 18.3sys 0:58real 31% 0i+0d 0maxrss 0+16pf 8038+1csw

with preempt disabled:
   ttcp-t: 6553600000 bytes in 58.42 real seconds = 109543.94 KB/sec +++
   ttcp-t: 6553600000 bytes in 18.82 CPU seconds = 340115.47 KB/cpu sec
   ttcp-t: 100000 I/O calls, msec/call = 0.60, calls/sec = 1711.62
   ttcp-t: 0.0user 18.7sys 0:58real 32% 0i+0d 0maxrss 0+16pf 7985+2csw


--
with PREEMPT=y:

[root@mel-stglab-host31 linux]# zcat /proc/config.gz |grep PREEM
CONFIG_PREEMPT=y
[root@mel-stglab-host31 linux]# sh -c 'opcontrol --start; opcontrol 
--reset; ttcp -t -l65536 -s -v -b2097152 -D -n100000 10.67.16.91; opcontrol 
--stop; opreport -l /usr/src/linux/vmlinux' 2>&1 | head -30
Profiler running.
Signalling daemon... done
ttcp-t: socket
ttcp-t: sndbuf
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: buflen=65536, nbuf=100000, align=16384/0, port=5001, 
sockbufsize=2097152  tcp  -> 10.67.16.91
ttcp-t: 6553600000 bytes in 58.29 real seconds = 109797.21 KB/sec +++
ttcp-t: 6553600000 bytes in 18.47 CPU seconds = 346485.49 KB/cpu sec
ttcp-t: 100000 I/O calls, msec/call = 0.60, calls/sec = 1715.58
ttcp-t: 0.1user 18.3sys 0:58real 31% 0i+0d 0maxrss 0+16pf 8038+1csw
ttcp-t: buffer address 0x8050000
Stopping profiling.
CPU: P4 / Xeon with 2 hyper-threads, speed 2393.64 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (count cycles when processor is active) 
count 100000
samples  %        symbol name
198646   14.4698  tg3_enable_ints
166885   12.1562  __copy_from_user_ll
93473     6.8088  tg3_interrupt
57435     4.1837  default_idle
50924     3.7094  skb_clone
47592     3.4667  tg3_rx
45568     3.3193  tcp_sendmsg
36887     2.6869  qdisc_restart
35256     2.5681  tg3_poll
31588     2.3009  ip_queue_xmit
29742     2.1665  skb_release_data
29258     2.1312  tcp_write_xmit
27799     2.0249  irq_entries_start
24281     1.7687  alloc_skb
--

with PREEMPT=n:

[root@mel-stglab-host31 linux]# zcat /proc/config.gz |grep PREEM
# CONFIG_PREEMPT is not set

[root@mel-stglab-host31 linux]# sh -c 'opcontrol --start; opcontrol 
--reset; ttcp -t -l65536 -s -v -b2097152 -D -n100000 10.67.16.91; opcontrol 
--stop; opreport -l /usr/src/linux/vmlinux' 2>&1 | head -30
Profiler running.
Signalling daemon... done
ttcp-t: socket
ttcp-t: sndbuf
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: buflen=65536, nbuf=100000, align=16384/0, port=5001, 
sockbufsize=2097152  tcp  -> 10.67.16.91
ttcp-t: 6553600000 bytes in 58.42 real seconds = 109543.94 KB/sec +++
ttcp-t: 6553600000 bytes in 18.82 CPU seconds = 340115.47 KB/cpu sec
ttcp-t: 100000 I/O calls, msec/call = 0.60, calls/sec = 1711.62
ttcp-t: 0.0user 18.7sys 0:58real 32% 0i+0d 0maxrss 0+16pf 7985+2csw
ttcp-t: buffer address 0x8050000
Stopping profiling.
CPU: P4 / Xeon with 2 hyper-threads, speed 2393.76 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (count cycles when processor is active) 
count 100000
samples  %        symbol name
225502   18.1062  tg3_enable_ints
152548   12.2485  __copy_from_user_ll
85683     6.8797  tg3_interrupt
58248     4.6769  skb_clone
52288     4.1984  tcp_sendmsg
37893     3.0425  default_idle
35365     2.8396  tg3_rx
32555     2.6139  ip_queue_xmit
31778     2.5515  qdisc_restart
30089     2.4159  tg3_poll
29935     2.4036  tcp_v4_rcv
24818     1.9927  tcp_write_xmit
23781     1.9094  tcp_transmit_skb
23329     1.8732  skb_release_data


cheers,

lincoln.

