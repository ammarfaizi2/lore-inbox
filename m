Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRBYMCX>; Sun, 25 Feb 2001 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129836AbRBYMCN>; Sun, 25 Feb 2001 07:02:13 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:20715 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129675AbRBYMB5>; Sun, 25 Feb 2001 07:01:57 -0500
Message-ID: <3A98F417.C38A67BE@uow.edu.au>
Date: Sun, 25 Feb 2001 23:01:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
>...
> 1) Rx Skb recycling.
>... 
> 2) Tx packet grouping.
>...
> 3) Slabbier packet allocation.

Let's see what the profiler says.  10 seconds of TCP xmit
followed by 10 seconds of TCP receive.  100 mbits/sec.
Kernel 2.4.2+ZC.

c0119470 do_softirq                                   97   0.7132
c020e718 ip_output                                    99   0.3694
c020a2c8 ip_route_input                              103   0.2893
c01fdc4c skb_release_data                            113   1.0089
c021312c tcp_sendmsg                                 113   0.0252
c0129c64 kmalloc                                     117   0.3953
c0112efc __wake_up_sync                              128   0.6667
c01fdd24 __kfree_skb                                 153   0.6071
c020e824 ip_queue_xmit                               154   0.1149
c011be80 del_timer                                   163   2.2639
c0222fac tcp_v4_rcv                                  173   0.1022
c010a778 handle_IRQ_event                            178   1.4833
c01127fc schedule                                    200   0.1259
c01d39f8 boomerang_rx                                332   0.2823
c024284c csum_partial_copy_generic                   564   2.2742
c01d2c84 boomerang_start_xmit                        654   0.9033
c0242b3c __generic_copy_from_user                    733  12.2167
c01d329c boomerang_interrupt                         910   0.8818
c01071f4 poll_idle                                 41813 1306.6562
00000000 total                                     48901   0.0367

7088 non-idle ticks.
153+117+113 ticks in skb/memory type functions.

So, naively, the most which can be saved here by optimising
the skb and memory usage is 5% of networking load. (1% of
system load @100 mbps)

Total device driver cost is 27% of the networking load.

All the meat is in the interrupt load.  The 3com driver
transfers about three packets per interrupt.  Here's
the system load (dual CPU):

Doing 100mbps TCP send with netperf:    14.9%
Doing 100mbps TCP receive with netperf: 23.3%

When tx interrupt mitigation is disabled we get 1.5 packets
per interrupt doing transmit:

Doing 100mbps TCP send with netperf:    16.1%
Doing 100mbps TCP receive with netperf: 24.0%

So a 2x reduction in interrupt frequency on TCP transmit has
saved 1.2% of system load. That's 8% of networking load, and,
presumably, 30% of the driver load. That all seems to make sense.


The moral?

- Tuning skb allocation isn't likely to make much difference.
- At the device-driver level the most effective thing is
  to reduce the number of interrupts.
- If we can reduce the driver cost to *zero*, we improve
  TCP efficiency by 27%.
- At the system level the most important thing is to rewrite
  applications to use sendfile(). (But Rx is more expensive
  than Tx, so even this ain't the main game).

I agree that batching skbs into hard_start_xmit() may allow
some driver optimisations.  Pass it a vector of skbs rather
than one, and let it return an indication of how many were
actually consumed.  But we'd need to go through an exercise
like the above beforehand - it may not be worth the
protocol-level trauma.

I suspect that a thorough analysis of the best way to
use Linux networking, and then a rewrite of important
applications so they use the result of that analysis
would pay dividends.

-
