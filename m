Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbUCZKju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUCZKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:39:49 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:5294 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264003AbUCZKjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:39:44 -0500
Date: Fri, 26 Mar 2004 11:39:39 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
Message-ID: <20040326103939.GC9599@drinkel.cistron.nl>
References: <1079996577.6595.19.camel@bach> <16480.28882.388997.71072@gargle.gargle.HOWL> <c3qa94$qhi$1@news.cistron.nl> <20040325190718.GD11236@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040325190718.GD11236@mail.shareable.org> (from jamie@shareable.org on Thu, Mar 25, 2004 at 20:07:18 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 20:07:18, Jamie Lokier wrote:
> Miquel van Smoorenburg wrote:
> > Is that real SMP, or hyperthreading? If it's hyperthreading, then
> > it makes sense that the IRQs are not balanced.
> 
> That's unfair to the two tasks which might be running on each virtual
> CPU: one of the tasks is interrupted often.
> 
> > In fact I have a server on which the IRQ balancing code does
> > balance over the 2 virtual CPUs by accident (still have to debug
> > what goes wrong and file a proper bug report) and as a result
> > performance sucked until I turned it off.
> 
> What caused the suckage?  Obviously there's a small time spend doing
> the work of rebalancing, but there is no cache hit from moving an
> interrupt between virtual CPUs, unlike with SMP, so why did that make
> performance suck?

I have no idea. I have a transit NNTP server, newsgate.cistron.nl, that
has a acenic GigE card, 1 Maxtor ATA 80 GB for the O/S, and 4 Maxtor
SATA 80 GB for database and storage. Sustained input is 100 mbit/sec,
sustained output is 250-300 mbit/sec.

It rans fine with 2.6.0-test11, but not any later kernels. I tried 2.6.2,
2.6.3 etc but somehow the output wouldn't get above 100 mbit/sec. Then
I noticed that with the 2.6.0-test11 kernel IRQs weren't balanced over
the 2 SMT cores while with later kernels they were.

So I installed a 2.6.4-rc2 kernel. Bad performance. Did a
"echo 1 > /proc/irq/XX/smp_affinity" for the NIC and IO interrupts,
and performance went bang right back to what it was before.

Yesterday I rebooted with 2.6.4-rc2, but with the "noirqbalance" option.
That didn't really perform well. So I rebooted again with 2.6.5-rc2
without the "noirqbalance" option. It appeared to run better, but not
quite up to par. Then I did the "echo 1 > /proc/irq/XX/smp_affinity"
for the NIC and IO interrupts again. Output traffic peaked again.

If you look at
http://newsgate.cistron.nl/lkml/stats.cistron.nl/mrtg/html/quantum.html
you can see the effect on the bandwidth stats:

25-03 before 14:00 2.6.4-rc2 with "echo 1 > /proc/irq/XX/smp_affinity
25-03        16:00 2.6.4-rc2 with noirqbalance
26-03        01:00 2.6.5-rc2 irq balancing enabled
26-03        10:30 2.6.5-rc2 with "echo 1 > /proc/irq/XX/smp_affinity

In my case, it looks like the box runs best with only IRQ balancing
for the timer interrupt over the 2 SMT cores, and no IRQ balancing
for all the other hardware.

I have no idea _why_ this affects throughput so much - the box itself
doesn't "feel" any different wrt latency on the shell, or load average.
It's just throughput, and I don't even know if this is disk controller
or NIC related.

Now since the box was down for 2 hours yesterday, it also has a
large backlog to process. I really have to retry this once it has been
running for a few days in a stable state, that's why I haven't really
dug into it yet, circumstances have been changing too much.

Mike.
