Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276170AbRJCMwh>; Wed, 3 Oct 2001 08:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276172AbRJCMw1>; Wed, 3 Oct 2001 08:52:27 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:35511 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276170AbRJCMwR>;
	Wed, 3 Oct 2001 08:52:17 -0400
Date: Wed, 3 Oct 2001 08:49:51 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031025530.1694-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110030819540.4495-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> On Tue, 2 Oct 2001, jamal wrote:
>
> > [...] please have the courtesy of at least posting results/numbers of
> > how this improved things and under what workloads and conditions.
> > [...]
>
> 500 MHz PIII UP server, 433 MHz client over a single 100 mbit ethernet
> using Simon Kirby's udpspam tool to overload the server. Result: 2.4.10
> locks up before the patch. 2.4.10 with the first generation irqrate patch
> applied protects against the lockup (if max_rate is correct), but results
> in dropped packets. The auto-tuning+polling patch results in a working
> system and working network, no lockup and no dropped packets. Why this
> happened and how it happened has been discussed extensively.
>
> (the effect of polling-driven networking is just an extra and unintended
> bonus side-effect.)
>

This is insufficient and, no pun intended, but you must be joking if you
intend on putting this patch into the kernel based on these observations.

For sample data look at: http://www.cyberus.ca/~hadi/247-res/
Weve been collecting data for about a year and fixing the patchs and we
still dont think we cover the full range (hopefully other people will help
in that when we merge).

You dont need the patch for 2.4 to work against any lockups. And
infact i am suprised that you observe _any_ lockups on a PIII which are
not observed on my PII. Linux as is, without any tuneups can handle
upto about 40000 packets/sec input before you start observing user space
startvations. This is about 30Mbps at 64 byte packets; its about 60Mbps at
128 byte packets and comfortable at 100Mbps with byte size of 256. We
really dont have a problem at 100Mbps.

There are several solutions in 2.4 and i suggest you try those first

1) has been around since 2.1 is hardware flow control.
First you need to register callbacks to throttle on/off your device.
Typically the xoff() callbacks will involve the driver turning off the
receive and receive_nobuf interupt sources and the xon() callback will
undo this. The network subsytem observes congestion levels by the size of
the backlog queue. it shuts off devices with when its overloaded and
unthrottles them when the conditions get better

2) and upgrade to the above introduced in 2.4:
Instead of waiting until you get shut off because of an overloaded
syatem, you could do something about it... use the return values from
netif_rx to make decisions. The return value indicates whether the system
is getting congested or not. The value is computed based on a moving
window averaging of the backlog queue and so is a pretty good reflection
of congestion levels. Typical uses of the return value are to tune the
mitigation registers. If the congestion thresholds are approaching a high
watermark, you back off and if they indicate things are getting
better, you increase you packet rate to the stack.

since you seem to be unaware of the above, i would suggest you try them
out first.

NAPI builds upon the above and introduces a more generic solution.

cheers,
jamal


