Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266377AbVBDQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266377AbVBDQRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVBDQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:17:32 -0500
Received: from mailman2.ppco.com ([138.32.33.140]:22916 "EHLO
	mailman2.ppco.com") by vger.kernel.org with ESMTP id S266377AbVBDQQY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:16:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10: kswapd spins like crazy
Date: Fri, 4 Feb 2005 10:16:22 -0600
Message-ID: <D821697F08061F4FBB069FA1AAAA92370C44D1@hoexmb7.conoco.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10: kswapd spins like crazy
Thread-Index: AcUKWgPN9Dd1I+xBQamySf0EjMDjwQAd7F2Q
From: "Weathers, Norman R." <Norman.R.Weathers@conocophillips.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2005 16:16:22.0717 (UTC) FILETIME=[DE3336D0:01C50AD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We have had a similar problem with all kernels since 2.6.8.1.  It has
gotten so bad that we had to drop back to 2.6.7 with some extra patches
to get our systems working.  Our situation is a little bit different.

We are using smp Opteron boxes as NFS servers.  Under almost any load at
all, kswapd goes nuts, taking up
99 % of the CPU cycles for long periods of time.  With 2.6.7, this has
not been noticed as bad (just periods of about 3 - 5 seconds of 10 - 35
% utilized, then off for a few seconds, then back again.  Sometimes
kswapd lingers longer as the most aggressive app in top, but with 2.6.7,
the nfsd's are the most prevalent).

Also, we have noticed something else.  Our servers have dual Broadcom
gigabit nics (Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
(rev 03)).  We have bonded both NICS back to our core switch, both
running at gigabit speed.  Under different loads, we start to get call
traces in dmesg and the syslog.  An excerpt follows:


<Jan/06 03:50 pm>Call Trace:<IRQ> <ffffffff80158fa0>{__alloc_pages+816}
<ffffffff8013ffd3>{del_timer+115}
<Jan/06 03:50 pm>       <ffffffff80158fe0>{__get_free_pages+16}
<ffffffff8015c886>{kmem_getpages+38}
<Jan/06 03:50 pm>       <ffffffff8015d8be>{cache_grow+190}
<ffffffff8015db16>{cache_alloc_refill+422}
<Jan/06 03:50 pm>       <ffffffff8015de06>{kmem_cache_alloc+54}
<ffffffff802d5eaf>{dst_alloc+47}
<Jan/06 03:50 pm>       <ffffffff802e3d17>{ip_route_input_slow+1639}
<ffffffff803085bb>{udp_rcv+267}
<Jan/06 03:50 pm>       <ffffffff802e612e>{ip_rcv+526}
<ffffffff802d297d>{netif_receive_skb+477}
<Jan/06 03:50 pm>
<ffffffffa0120fe8>{:bcm5700:MM_IndicateRxPackets+920}
<Jan/06 03:50 pm>       <ffffffffa011c9fe>{:bcm5700:bcm5700_poll+158}
<ffffffff802d2b94>{net_rx_action+132}
<Jan/06 03:50 pm>       <ffffffff8013c4b1>{__do_softirq+113}
<ffffffff8013c565>{do_softirq+53}
<Jan/06 03:50 pm>       <ffffffff80113baf>{do_IRQ+335}
<ffffffff80111001>{ret_from_intr+0}
<Jan/06 03:50 pm>        <EOI> <ffffffff8031e419>{thread_return+41}
<ffffffff8010eb20>{default_idle+0}
<Jan/06 03:50 pm>       <ffffffff8010eb44>{default_idle+36}
<ffffffff8010ebdc>{cpu_idle+44}
<Jan/06 03:50 pm>       <ffffffff80517885>{start_kernel+453}
<Jan/06 03:50 pm>swapper: page allocation failure. order:0, mode:0x20

<Jan/06 03:50 pm>Call Trace:<IRQ> <ffffffff80158fa0>{__alloc_pages+816}
<ffffffff801158b4>{end_8259A_irq+100}
<Jan/06 03:50 pm>       <ffffffff80158fe0>{__get_free_pages+16}
<ffffffff8015c886>{kmem_getpages+38}
<Jan/06 03:50 pm>       <ffffffff8015d8be>{cache_grow+190}
<ffffffff8015db16>{cache_alloc_refill+422}
<Jan/06 03:50 pm>       <ffffffff8015de06>{kmem_cache_alloc+54}
<ffffffff802d5eaf>{dst_alloc+47}
<Jan/06 03:50 pm>       <ffffffff802e3d17>{ip_route_input_slow+1639}
<ffffffff802e612e>{ip_rcv+526}
<Jan/06 03:50 pm>       <ffffffff80131b2b>{try_to_wake_up+523}
<ffffffff802d297d>{netif_receive_skb+477}
<Jan/06 03:50 pm>
<ffffffffa0120fe8>{:bcm5700:MM_IndicateRxPackets+920}
<Jan/06 03:50 pm>       <ffffffffa011c9fe>{:bcm5700:bcm5700_poll+158}
<ffffffff802d2b94>{net_rx_action+132}
<Jan/06 03:50 pm>       <ffffffff8013c4b1>{__do_softirq+113}
<ffffffff8013c565>{do_softirq+53}
<Jan/06 03:50 pm>       <ffffffff80113baf>{do_IRQ+335}
<ffffffff80111001>{ret_from_intr+0}
<Jan/06 03:50 pm>        <EOI> <ffffffff8031e419>{thread_return+41}
<ffffffff8010eb20>{default_idle+0}
<Jan/06 03:50 pm>       <ffffffff8010eb44>{default_idle+36}
<ffffffff8010ebdc>{cpu_idle+44}
<Jan/06 03:50 pm>       <ffffffff80517885>{start_kernel+453}
<Jan/06 03:50 pm>swapper: page allocation failure. order:0, mode:0x20

<Jan/06 03:50 pm>Call Trace:<IRQ> <ffffffff80158fa0>{__alloc_pages+816}
<ffffffff801158b4>{end_8259A_irq+100}
<Jan/06 03:50 pm>       <ffffffff80158fe0>{__get_free_pages+16}
<ffffffff8015c886>{kmem_getpages+38}
<Jan/06 03:50 pm>       <ffffffff8015d8be>{cache_grow+190}
<ffffffff8015db16>{cache_alloc_refill+422}
<Jan/06 03:50 pm>       <ffffffff8015de06>{kmem_cache_alloc+54}
<ffffffff802d5eaf>{dst_alloc+47}
<Jan/06 03:50 pm>       <ffffffff802e3d17>{ip_route_input_slow+1639}
<ffffffff803085bb>{udp_rcv+267}
<Jan/06 03:50 pm>       <ffffffff802e612e>{ip_rcv+526}
<ffffffff802d297d>{netif_receive_skb+477}
<Jan/06 03:50 pm>
<ffffffffa0120fe8>{:bcm5700:MM_IndicateRxPackets+920}
<Jan/06 03:50 pm>       <ffffffffa011c9fe>{:bcm5700:bcm5700_poll+158}
<ffffffff802d2b94>{net_rx_action+132}
<Jan/06 03:50 pm>       <ffffffff8013c4b1>{__do_softirq+113}
<ffffffff8013c565>{do_softirq+53}
<Jan/06 03:50 pm>       <ffffffff80113baf>{do_IRQ+335}
<ffffffff80111001>{ret_from_intr+0}
<Jan/06 03:50 pm>        <EOI> <ffffffff8031e419>{thread_return+41}
<ffffffff8010eb20>{default_idle+0}
<Jan/06 03:50 pm>       <ffffffff8010eb44>{default_idle+36}
<ffffffff8010ebdc>{cpu_idle+44}
<Jan/06 03:50 pm>       <ffffffff80517885>{start_kernel+453}
<Jan/06 03:50 pm>swapper: page allocation failure. order:0, mode:0x20

<Jan/06 03:50 pm>Call Trace:<IRQ> <ffffffff80158fa0>{__alloc_pages+816}
<ffffffff801158b4>{end_8259A_irq+100}
<Jan/06 03:50 pm>       <ffffffff80158fe0>{__get_free_pages+16}
<ffffffff8015c886>{kmem_getpages+38}
<Jan/06 03:50 pm>       <ffffffff8015d8be>{cache_grow+190}
<ffffffff8015db16>{cache_alloc_refill+422}
<Jan/06 03:50 pm>       <ffffffff8015de06>{kmem_cache_alloc+54}
<ffffffff802d5eaf>{dst_alloc+47}
<Jan/06 03:50 pm>       <ffffffff802e3d17>{ip_route_input_slow+1639}
<ffffffff802e612e>{ip_rcv+526}
<Jan/06 03:50 pm>       <ffffffff802d297d>{netif_receive_skb+477}
<ffffffffa0120fe8>{:bcm5700:MM_IndicateRxPackets+920}
<Jan/06 03:50 pm>       <ffffffffa011c9fe>{:bcm5700:bcm5700_poll+158}
<ffffffff802d2b94>{net_rx_action+132}
<Jan/06 03:50 pm>       <ffffffff8013c4b1>{__do_softirq+113}
<ffffffff8013c565>{do_softirq+53}
<Jan/06 03:50 pm>       <ffffffff80113baf>{do_IRQ+335}
<ffffffff80111001>{ret_from_intr+0}
<Jan/06 03:50 pm>        <EOI> <ffffffff8031e419>{thread_return+41}
<ffffffff8010eb20>{default_idle+0}
<Jan/06 03:50 pm>       <ffffffff8010eb44>{default_idle+36}
<ffffffff8010ebdc>{cpu_idle+44}
<Jan/06 03:50 pm>       <ffffffff80517885>{start_kernel+453}
<Jan/06 03:50 pm>swapper: page allocation failure. order:0, mode:0x20

<Jan/06 03:50 pm>Call Trace:<IRQ> <ffffffff80158fa0>{__alloc_pages+816}
<ffffffff80158fe0>{__get_free_pages+16}
<Jan/06 03:50 pm>       <ffffffff8015c886>{kmem_getpages+38}
<ffffffff8015d8be>{cache_grow+190}
<Jan/06 03:50 pm>       <ffffffff8015db16>{cache_alloc_refill+422}
<ffffffff8015de06>{kmem_cache_alloc+54}
<Jan/06 03:50 pm>       <ffffffff802d5eaf>{dst_alloc+47}
<ffffffff802e3d17>{ip_route_input_slow+1639}
<Jan/06 03:50 pm>       <ffffffff802e612e>{ip_rcv+526}
<ffffffff802d297d>{netif_receive_skb+477}

This was just a partial listing from one of our servers.  I had read in
several lists that this was not considered fatal.  The problem is that
with our setup, it has turned fatal, to the point of locking out the
system remotely, and only a reset from the machine itself able to work
(didn't even honor the sysrq-b combo at the console).

Has anyone else run into this?  I can get this kind of error using about
20 clients (100 MB connected) hitting one server (dual gigabit bonded).
With 2.6.8.1 and newer, the errors are reproducible, but I can't exactly
tell when they happen (either write or read).  I think I have seen them
happen in both writes and reads.  And the kswapd problems happened
during writes and reads both as well.

I can also get the kswapd going crazy with a local set of disk I/O
tests.

Any information needed, please ask.  Any help would be appreciated.

Thanks,
Norman Weathers




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nick Piggin
Sent: Thursday, February 03, 2005 7:20 PM
To: Andrew Morton
Cc: terje_fb@yahoo.no; linux-kernel@vger.kernel.org; torvalds@osdl.org
Subject: Re: 2.6.10: kswapd spins like crazy



Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Oh, attached should be a minimal fix if you would like to try it out.
>>
>>
>>...
>>--- linux-2.6/mm/vmscan.c~vmscan-minfix	2005-02-04
11:52:37.000000000 +1100
>>+++ linux-2.6-npiggin/mm/vmscan.c	2005-02-04 11:53:32.000000000
+1100
>>@@ -575,6 +575,7 @@ static void shrink_cache(struct zone *zo
>> 			nr_taken++;
>> 		}
>> 		zone->nr_inactive -= nr_taken;
>>+		zone->pages_scanned += nr_scan;
>> 		spin_unlock_irq(&zone->lru_lock);
>> 
>> 		if (nr_taken == 0)
>>
> 
> 
> Any theories as to why these pages aren't being activated and aren't
being
> reclaimed?
> 
> 

No none yet, which is what we should get to the bottom of. I must be
overlooking something, but the only ways I can see should be due to
transient conditions like page locked or under writeback. laptop_mode?

Terje, what is /proc/sys/vm/laptop_mode set to?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
