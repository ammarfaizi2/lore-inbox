Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTG1UPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTG1UPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:15:11 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:17888 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S270818AbTG1UPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:15:01 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Date: Mon, 28 Jul 2003 22:18:19 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <3900670000.1059422153@[10.10.2.4]>
In-Reply-To: <3900670000.1059422153@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282218.19578.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 21:55, Martin J. Bligh wrote:
> > after talking to several people at OLS about the current NUMA
> > scheduler the conclusion was:
> > (1) it sucks (for particular workloads),
> > (2) on x86_64 (embarassingly simple NUMA) it's useless, goto (1).
>
> I really feel there's no point in a NUMA scheduler for the Hammer
> style architectures. A config option to turn it off would seem like
> a simpler way to go, unless people can see some advantage of the
> full NUMA code?

But the Hammer is a NUMA architecture and a working NUMA scheduler
should be flexible enough to deal with it. And: the corner case of 1
CPU per node is possible also on any other NUMA platform, when in some
of the nodes (or even just one) only one CPU is configured in. Solving
that problem automatically gives the Hammer what it needs.

> > Fact is that the current separation of local and global balancing,
> > where global balancing is done only in the timer interrupt at a fixed
> > rate is way too unflexible. A CPU going idle inside a well balanced
> > node will stay idle for a while even if there's a lot of work to
> > do. Especially in the corner case of one CPU per node this is
> > condemning that CPU to idleness for at least 5 ms.
>
> Surely it'll hit the idle local balancer and rebalance within the node?
> Or are you thinking of a case with 3 tasks on a 4 cpu/node system?

No, no, the local load balancer just doesn't make sense now if you
have one cpu per node. It is called although it will never find
another cpu in the own cell to steal from. There just is nothing
else... (or did I misunderstand your comment?)

> > So x86_64 platforms
> > (but not only those!) suffer and whish to switch off the NUMA
> > scheduler while keeping NUMA memory management on.
>
> Right - I have a patch to make it a config option (CONFIG_NUMA_SCHED)
> ... I'll feed that upstream this week.

That's one way, but the proposed patch just solves the problem (in a
more general way, also for other NUMA cases). If you deconfigure NUMA
for a NUMA platform, we'll have problems switching it back on when
adding smarter things like node affine or homenode extensions.

> > The attached patch is a simple solution which
> > - solves the 1 CPU / node problem,
> > - lets other systems behave (almost) as before,
> > - opens the way to other optimisations like multi-level node
> >   hierarchies (by tuning the retry rate)
> > - simpifies the NUMA scheduler and deletes more lines of code than it
> >   adds.
>
> Looks simple, I'll test it out.

Great! Thanks!

Erich


