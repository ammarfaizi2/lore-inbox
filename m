Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWBWT4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWBWT4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWBWT4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:56:07 -0500
Received: from mail.atl.external.lmco.com ([192.35.37.50]:57275 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S1751776AbWBWT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:56:05 -0500
Message-ID: <43FE134C.6070600@atl.lmco.com>
Date: Thu, 23 Feb 2006 14:55:56 -0500
From: Gautam H Thaker <gthaker@atl.lmco.com>
Organization: Lockheed Martin -- Advanced Technology Laboratories
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Gautam H. Thaker - LM ATL" <gthaker@atl.lmco.com>,
       Ingo Molnar <mingo@redhat.com>
Subject: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The real-time patches at the URL below do a great job of endowing Linux with
real-time capabilities.

http://people.redhat.com/mingo/realtime-preempt/

It has been documented before (and accepted) that this patch turns Linux into
a RT kernel but considerably slows down the code paths, esp. thru the I/O
subsystem. I want to provide some additional measurements and seek opinions
of if it might ever be possible to improve on this situation.

In my tests I used 20 3GHZ Intel Xeon PCs on an isoloated gigabit network.
One of the nodes has a "monitor" process that listens to incoming UDP packets
from the other 19 nodes. Each node is sending approximately 2000 UDP
packets/sec to the monitor process for a total of about 38,000 incoming UDP
packest/sec. These UDP packets are small with application payload being ~10
bytes, for total BW usage of less than 4 Mbits/sec at application level and
less than 15 Mbits/sec counting all headers. (Total BW usage is not high but
there is a large number of packets that are coming in.) Monitor process does
some fairly simple processing per packet.

I measured the CPU usage of the "monitor" process when the testbed was used
with two different operating system. The monitor process is the "nalive.p"
process in the "top" output below. The CPU laod is fairly stable and "top"
gives the following information:

::::::::::::::
top:  2.6.12-1.1390_FC4    # STANDARD KERNEL
::::::::::::::
top - 14:34:39 up  2:32,  2 users,  load average: 0.10, 0.05, 0.01
Tasks:  56 total,   2 running,  54 sleeping,   0 stopped,   0 zombie
top - 14:35:32 up  2:33,  2 users,  load average: 0.11, 0.06, 0.01
Tasks:  56 total,   2 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  1.4% us,  7.0% sy,  0.0% ni, 80.8% id,  0.2% wa,  7.0% hi,  3.6% si
Mem:   2076008k total,   100292k used,  1975716k free,    16192k buffers
Swap:   128512k total,        0k used,   128512k free,    50376k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 4823 root     -66   0 22712 2236 1484 S  8.4  0.1   0:37.74 nalive.p
 4860 gthaker   16   0  7396 2380 1904 R  0.2  0.1   0:00.04 sshd
    1 root      16   0  1748  572  492 S  0.0  0.0   0:01.06 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 events/0


::::::::::::::
top:  2.6.15-rt15-smp.out   # REAL_TIME KERNEL
::::::::::::::
node0> top
top - 09:52:48 up  1:47,  3 users,  load average: 0.91, 1.05, 1.02
Tasks:  98 total,   1 running,  97 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.5% us, 41.8% sy,  0.0% ni, 55.6% id,  0.1% wa,  0.0% hi,  0.0% si
Mem:   2058608k total,    88104k used,  1970504k free,     9072k buffers
Swap:   128512k total,        0k used,   128512k free,    39208k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2906 root     -66   0 18624 2244 1480 S 41.4  0.1  27:11.21 nalive.p
    6 root     -91   0     0    0    0 S 32.3  0.0  21:04.53 softirq-net-rx/
 1379 root     -40  -5     0    0    0 S 14.5  0.0   9:54.76 IRQ 23
  400 root      15   0     0    0    0 S  0.2  0.0   0:00.13 kjournald
    1 root      16   0  1740  564  488 S  0.0  0.0   0:04.03 init

The %CPU is at 8% for the non-real-time, uniprocessor kernel, while it is at
least 41% (and may be 41.4%+32.3%+14.5% = 88%) for the real-time SMP kernel.)


My question is this: How much improvement in raw efficiency is possible for
real-time patches? We take very long view, so if there is a belief that in 5
years the penalty will be reduced from 5-10x in this application to less than
2x that would be great. If we think this is about as well as can be done it
helps knowing that too.

There is nothing else going on on the machines, all code paths should be
going down "happy path" with no contention or blocking - my naive view is
that a 2x overhead is possible, but 5-10x seems harder to understand. And
this is not the case of finding some large non-preemptible region - since
real-time performance is excellent, but about why the code paths seem so "heavy".

Gautam Thaker

