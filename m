Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRJBAoK>; Mon, 1 Oct 2001 20:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275745AbRJBAnu>; Mon, 1 Oct 2001 20:43:50 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:5812 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S274872AbRJBAnk>;
	Mon, 1 Oct 2001 20:43:40 -0400
Date: Mon, 1 Oct 2001 20:41:20 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
cc: <kuznet@ms2.inr.ac.ru>, Robert Olsson <Robert.Olsson@data.slu.se>,
        Ingo Molnar <mingo@elte.hu>, <netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <Pine.GSO.4.30.0110012018430.27922-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The new mechanizm:
>
>- the irq handling code has been extended to support 'soft mitigation',
>  ie. to mitigate the rate of hardware interrupts, without support from
>  the actual hardware. There is a reasonable default, but the value can
>  also be decreased/increased on a per-irq basis via
> /proc/irq/NR/max_rate.

I am sorry, but this is bogus. There is no _reasonable value_. Reasonable
value is dependent on system load and has never been and never
will be measured by interupt rates. Even in non-work conserving schemes
There is already a feedback system that is built into 2.4 that
measures system load by the rate at which the system processes the backlog
queue. Look at netif_rx return values. The only driver that utilizes this
is currently the tulip. Look at the tulip code.
This in conjuction with h/ware flow control should give you sustainable
system.
[Granted that mitigation is a hardware specific solution; the scheme we
presented at the kernel summit is the next level to this and will be
non-dependednt on h/ware.]

>(note that in case of shared interrupts, another 'innocent' device might
>stay disabled for some short amount of time as well - but this is not an
>issue because this mitigation does not make that device inoperable, it
>just delays its interrupt by up to 10 msecs. Plus, modern systems have
>properly distributed interrupts.)

This is a _really bad_ idea. not just because you are punishing other
devices.
Lets take network devices as examples: we dont want to disable interupts;
we want to disable offending actions within the device. For example, it is
ok to disable/mitigate receive interupts because they are overloading the
system but not transmit completion because that will add to the overall
latency.

cheers,
jamal


PS: we have been testing what was presented at the kernel summit for the
last few months with very promising results. Both on live and setups which
are experimental where data is generated at very high rates with hardware
traffic generators

