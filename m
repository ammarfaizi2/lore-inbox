Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTIBK6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTIBK6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:58:51 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:17292 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S263698AbTIBK6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:58:49 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.0t4] 1 cpu/node scheduler fix
Date: Tue, 2 Sep 2003 12:57:17 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@osdl.org
References: <200308241913.24699.efocht@hpce.nec.com> <Pine.LNX.4.56.0308251010020.6670@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0308251010020.6670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309021257.17091.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

thanks for the reply and sorry for the late reaction. I've been away
for a week and (unexpectedly) didn't have email/internet connectivity
during this time.

On Monday 25 August 2003 10:13, Ingo Molnar wrote:
> On Sun, 24 Aug 2003, Erich Focht wrote:
> > different balancing intervals for each node) and I'd really like to get
> > back to just one single point of entry for load balancing: the routine
> > load_balance(), no matter whether we balance inside a timer interrupt or
> > while the CPU is going idle.
>
> your patch clearly simplifies things. Would you mind to also extend the
> rebalance-frequency based balancing to the SMP scheduler, and see what
> effect that has? Ie. to remove much of the 'tick' component from the SMP
> scheduler as well, and make it purely frequency based.

Actually I didn't remove the tick-based load-balancing, just
simplified it and wanted to have only one load_balance() call instead of
separate load_balance(), node_balance(),
load_balance_in_timer_interrupt_when_idle() and
load_balance_in_timer_interrupt_when_busy().

The current change keeps track of the number of failed load_balance
attempts and does cross-node balancing after a certain number of
failed attempts. If I understand you correctly you'd like to test this
concept also on a lower level? So keep track of the number of
schedules and context switches and call the SMP load balancer after a
certain number of schedules? This could work, though on idle CPUs I'm
more comfortable with the timer tick... The logic of cpu_idle() would
need a change, too. Do you expect an impact on the latency issue?
Would you mind doing these changes in two steps: first the simple NUMA
one, later the radical SMP change?

> I'm still afraid of balancing artifacts if we lose track of time (which
> the tick thing is about, and which cache affinity is a function of), but
> maybe not. It would certainly unify things more. If it doesnt work out
> then we can still do your stuff for the cross-node balancing only.

With the small fix for NUMA there's no problem because the
CAN_MIGRATE_TASK macro really compares times/jiffies for getting an
idea about the cache coolness. This wouldn't change even with the
elimination of the timer based load_balance calls.

Regards,
Erich


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hi Ingo,

thanks for the reply and sorry for the late reaction. I've been away
for a week and (unexpectedly) didn't have email/internet connectivity
during this time.

On Monday 25 August 2003 10:13, Ingo Molnar wrote:
> On Sun, 24 Aug 2003, Erich Focht wrote:
> > different balancing intervals for each node) and I'd really like to get
> > back to just one single point of entry for load balancing: the routine
> > load_balance(), no matter whether we balance inside a timer interrupt or
> > while the CPU is going idle.
>
> your patch clearly simplifies things. Would you mind to also extend the
> rebalance-frequency based balancing to the SMP scheduler, and see what
> effect that has? Ie. to remove much of the 'tick' component from the SMP
> scheduler as well, and make it purely frequency based.

Actually I didn't remove the tick-based load-balancing, just
simplified it and wanted to have only one load_balance() call instead of
separate load_balance(), node_balance(),
load_balance_in_timer_interrupt_when_idle() and
load_balance_in_timer_interrupt_when_busy().

The current change keeps track of the number of failed load_balance
attempts and does cross-node balancing after a certain number of
failed attempts. If I understand you correctly you'd like to test this
concept also on a lower level? So keep track of the number of
schedules and context switches and call the SMP load balancer after a
certain number of schedules? This could work, though on idle CPUs I'm
more comfortable with the timer tick... The logic of cpu_idle() would
need a change, too. Do you expect an impact on the latency issue?
Would you mind doing these changes in two steps: first the simple NUMA
one, later the radical SMP change?

> I'm still afraid of balancing artifacts if we lose track of time (which
> the tick thing is about, and which cache affinity is a function of), but
> maybe not. It would certainly unify things more. If it doesnt work out
> then we can still do your stuff for the cross-node balancing only.

With the small fix for NUMA there's no problem because the
CAN_MIGRATE_TASK macro really compares times/jiffies for getting an
idea about the cache coolness. This wouldn't change even with the
elimination of the timer based load_balance calls.

Regards,
Erich


