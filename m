Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUCDG0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUCDG0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:26:14 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:15538 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261467AbUCDG0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:26:11 -0500
Date: Thu, 4 Mar 2004 07:26:30 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nmi_watchdog=2 and P4-HT
Message-ID: <20040304072630.GB683@zaniah>
References: <20040304054215.GA683@zaniah> <20040303213033.6348a08b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303213033.6348a08b.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 at 21:30 +0000, Andrew Morton wrote:

> Philippe Elie <phil.el@wanadoo.fr> wrote:
> >
> > Hi,
> > 
> > Actually with nmi_watchdog=2 and a P4 ht box the nmi is reflected
> > only on logical processor 0, it's better to get it on both.
> 
> What do you mean by "reflected"?  That the NMi is delivered to both
> siblings but only appears in /proc/interrupts as being delivered to the
> zeroeth?

w/o the patch the nmi is delivered to cpu0 only, on HT watchdog on cpu1
has never been enabled afaics.

> > Note, if you test this patch, than on all x86 SMP and nmi_watchdog=2
> > nmi occurs at 1000 hz (if the cpu is loaded) not at the intended 1 hz
> > rate but that's a distinct problem.
> 
> nmi_watchdog=2 is local apic, and nmi_watchdog=1 is I/O apic, is that
> correct?

yes

> 
> I am showing the current behaviour:
> 
> 
> nmi_watchdog=1: 1000 NMI/second, accounted to both siblings
> nmi_watchdog=2: one NMI/second, accounted to sibling 0 only.

I think you didn't load any cpu for this test, the problem is confusing
because nmi_watchdog=2 use performance counter which doesn't count when
the processor is halted, on HT we use only one counter. If both processor
are halted performance monitoring shutdown and no longer tick, that's
why a cat /proc/interrupts && sleep 1 && cat /proc/interrupts look
like to work at something like one hz, there is always a few load...

 
> with your patch:
> 
> nmi_watchdog=1: 1000 NMI/second, accounted to both siblings
> nmi_watchdog=2: 1000 NMI/second, accounted to both siblings

w/o my patch you can get 1000 NMI per sec too. Load at least
one cpu.

>
> All of these are wrong, aren't they?  We'd like to see one NMI per second,
> on all siblings.  I gues that's not possible for the IO APIC?

I didn't look the IO APIC but I don't think we can (aren't we using the
same timer source to tick irq0 and the NMI so we need really 1000 hz I
guess :)

> From the above it appears that you have a solution planned for the local
> APIC at least, yes?

I'm unhappy with my solution for now.

What do you think about the feature "the performance doesn't increment
counter in hlt mode". afaics there is no way on Ppro/P4/K7/K8 to get
a real "count each cycle w/o regarding hlt mode". It's a real problem
if a driver rather than deadlocking a cpu do a halt with interrupt
disabled, int this that'll stop performance counter and NMI will never
occur... Is it a real problem ?

oh and the side effect of this feature: during idle time and if we
implement 1 NMI per sec we will get rouglhy 2 or 3 NMI per hour.

regards,
Phil
