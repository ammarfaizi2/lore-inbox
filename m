Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJCJYj>; Wed, 3 Oct 2001 05:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272074AbRJCJY3>; Wed, 3 Oct 2001 05:24:29 -0400
Received: from chiara.elte.hu ([157.181.150.200]:47879 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S271911AbRJCJYP>;
	Wed, 3 Oct 2001 05:24:15 -0400
Date: Wed, 3 Oct 2001 11:22:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben Greear <greearb@candelatech.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, jamal <hadi@cyberus.ca>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BB956D3.AE0FCC54@candelatech.com>
Message-ID: <Pine.LNX.4.33.0110031115110.2796-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Oct 2001, Ben Greear wrote:

> So, when you turn off the IRQs, are the drivers somehow made aware of
> this so that they can go into polling mode? That might fix the 10ms
> latency/starvation problem that bothers me...

the latest, -D9 patch does this. If drivers provide a (backwards
compatible) ->poll_controller() call then they can be polled by kpolld.
There are also a few points within the networking code that trigger a poll
pass, to make sure events are processed even if networking-intensive
applications take away all CPU time from kpolld. The device is only polled
if the IRQ is detected to be in overload mode. IRQ-overload protection
does not depend on the existence of the availability of the
->poll_controller(). The poll_controller() call is very simple for most
drivers. (It has to be per-driver, because not all drivers advance their
state purely via their device interrupts.)

but kpolld itself and auto-mitigation is not limited to networking - any
other driver framework that has high-irq-load problems can use it.

> I'm more worried about dropped pkts.  If you can receive 10k packets
> per second, then you can receive (lose) 100 packets in 10ms....

yep - this does not happen anymore, at least under the loads i tested
which otherwise choke a purely irq-driven machine. (It will happen in a
gradual way if load is increased further, but that is natural.)

	Ingo

