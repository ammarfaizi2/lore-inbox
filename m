Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSCOIsa>; Fri, 15 Mar 2002 03:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSCOIsM>; Fri, 15 Mar 2002 03:48:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:54202 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285850AbSCOIru>;
	Fri, 15 Mar 2002 03:47:50 -0500
Date: Fri, 15 Mar 2002 08:43:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203141426200.1477-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.44.0203150834050.11415-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Mar 2002, Martin Wilck wrote:

> > let me know whether this fixes your problem,
> 
> The patch distributes the IRQs nicely between CPUs, but unfortunately
> does not fix our timer IRQ problem.

that is a different issue, a fix for it was sent to lkml.

> Btw is it correct that one could also use the APIC Task Priority
> Registers to implement "fair" IRQ routing? (If linux adjusted them,
> which it currently doesn't).

no. The TPR has a number of limitations, and it suffers from the same
problem that lowest priority routing is suffering.

1) the TRP is not really finegrained and does not match Linux's irq
architecture, it's a rather spl-alike metric to allow irqs in below/above
a certain level. Since Linux distributes IRQ sources in essence randomly,
there is no point in TPR-limiting a certain half of the IRQ vector
spectrum.

2) i initially played with the TPR and it does not really solve the P4
problem. It can be used to force irqs away from a busy CPU, but in the
common (idle, or mostly idle) case the TPR will be equivalent across CPUs,
resulting in the same 'ugly' IRQ inbalance that you see.

3) the irqbalance patch also takes CPU affinity into account, ie. it will
try to keep the same IRQ source on a single CPU, for some time. So the
micro-distribution of IRQ sources is 'CPU affine', while the
macro-distribution is statistically random, in a load-weighted way. The
TPR approach results in the same 'one IRQ goes to CPU1, next IRQ goes to
CPU2' type of cache-affinity problems.

4) irqbalance is a software-based distribution method. It was time for the
Linux/x86 IRQ routing code to 'grow up' and actually be clever in a number
of ways. The hardware did bad decisions - even in lowestprio mode.

eg. apply the irqbalance patch, start a single CPU-using script like:

	while [ 1 ]; do N=1; done

and watch IRQ load wander to the idle CPU(s) instantly.

	Ingo

