Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTIEK51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTIEK51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:57:27 -0400
Received: from smtp0.telegraaf.net ([217.196.45.130]:22247 "EHLO
	smtp0.telegraaf.net") by vger.kernel.org with ESMTP id S262436AbTIEK5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:57:21 -0400
Date: Fri, 5 Sep 2003 12:57:18 +0200
From: Brendan Keessen <brendan@telegraafnet.nl>
To: linux-kernel@vger.kernel.org
Subject: ksoftirqd causing severe network performance problems
Message-ID: <20030905105718.GA22825@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

More than a week ago we replaced our old linux core routers (in a
failover setup), with a new one. The old used 2 100 mbit NICs and worked
very well, however we needed more than a 100 mbit throughput, so we
replaced the setup with an almost identical setup based on two new
servers with 2 1g NICs. At peek time it processes about 70 Mbits/sec of
traffic and we use vlan's and use iptables, firewalling and DNAT of
almost all the connections, the same as in the old setup.               
                                                                                
At the end of last week, the new setup had network problems and what we saw on
the linux router was that the kernel threads ksoftirqd_CPU1 and ksoftirqd_CPU0
were using almost 100% of system time and the network throughput collapsed.
This happens every day once or twice but the first one seems reasonably
predictable and happens when the network traffic raises from a constant
throughput from 3 Mbit/sec to 46 Mbit/sec in 3 hours. At a rough 40 Mbit/sec
the problem occures and a failover to the slave router solves the problem. On
the faulty server (previously master) the 100% CPU usage drops to almost 100%
idle. When the backup is working fine, we can't use the faulty server anymore
for routing/firewalling because failing back to it again results in an instant
100% system time again. Rebooting the system helps.                             

Because the router was a new server (Dell 2650/Dual Xeon) and it had a new
network card (Gigabit Broadcom 5703, which we never used before in our servers)
we thought that maybe the driver for the card was causing the problem. After
switching drivers and switching between kernel versions (2.4.21/2.4.22/
2.4.18(which ran perfectly on our old router))we eventually choose to replace
the server with a dell 1650 which has 2 gigabit e1000 interfaces. Different
kernels and e1000 drivers resulted in the same problem again. Now we are
running 2.4.18 with the 4.3.2 e1000 driver. I know we don't use the newest
kernel and newest driver but this doesn't seem to cause the problem because we
tested with other network cards, drivers and kernel versions. 

The same problem still exists on the new server with totally different
network cards. In the kernel logfiles we don't see any messages at all
which are related to the problem.

Here is some info which tells something about the server when the network
performance collapses and ksoftirqd_CPU0/ksoftirqd_CPU1 are using 99% system
time:

routing cache (no. entries):

$ ip r ls cache | grep from | wc -l
69323

$ cat /proc/sys/net/ipv4/route/max_size 
131072

$ cat /proc/sys/net/ipv4/route/gc_thresh 
8192

We thought maybe for some reasom the routing cache is thrashing so we
experimented with changing the max_size to 4 times the current value and
raising the gc_thresh to 80% of that value and gc_elasticity to 32. But
that didn't help and the same problem occured again.

info on ip conntrack (no. entries):

$ cat /proc/net/ip_conntrack | wc -l
126804

The ip_conntrack module is loaded with the hashsize parameter:

ip_conntrack hashsize=2097152

To give you more input I turned on profiling. Read and clear profiling info
every 60 second. The kernel functions which use the most clockticks (top 10)
during the problem are:

    31 handle_IRQ_event                           0.2500
    32 add_timer                                  0.1311
    34 net_rx_action                              0.0467
    35 __kfree_skb                                0.1136
    35 batch_entropy_store                        0.1944
    40 dev_queue_xmit                             0.0535
    50 ip_route_input                             0.1238
   676 __write_lock_failed                       21.1250
  2928 __read_lock_failed                       146.4000
  3620 default_idle                              69.6154

A few minutes before the problem occured (normal state):

    37 __kfree_skb                                0.1201
    49 net_rx_action                              0.0673
    50 dev_queue_xmit                             0.0668
    50 handle_IRQ_event                           0.4032
    54 ip_route_input                             0.1337
    56 schedule                                   0.0422
    68 __write_lock_failed                        2.1250
    73 batch_entropy_store                        0.4056
   742 __read_lock_failed                        37.1000
  8893 default_idle                             171.0192

I also monitored interrupts (/proc/interrupts) of eth0 and eth1 but the
interrupts seem related with the throughput at that moment and no
strange burst of interrupts occure:

Before and during the problem occures the interrupts are about:

eth0: 5000/s
eth1: 4200/s

Does anybody know why we have this problem and how to solve it. Or could
you maybe tell me what more info is needed and how I can get it, to
resolve the problem.

Thanks,
Brendan Keessen
