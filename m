Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFKAV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFKAV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFKAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:21:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34298 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261491AbVFKAVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:21:02 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com
In-Reply-To: <Pine.OSF.4.05.10506110117180.5042-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506110117180.5042-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Date: Fri, 10 Jun 2005 17:20:47 -0700
Message-Id: <1118449247.27756.47.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 01:37 +0200, Esben Nielsen wrote:
> I am sorry, Daniel, but this patch doesn't make much sense to me.
> As far as I can see you effectlively turned local_irq_disable() into a
> preempt_disable(). I.e. it gives no improvement to task latency. As all
> interrupts are threaded it will not improve irq-latency either....

It does turn local_irq_disable() into a preempt_disable() . My
definition of IRQ latency is the longest period that interrupts are
disabled. So my patch does reduce interrupt latency.

> I hope it is just me who have misunderstood the patch, but as far as I see
> it
>  taks->preempt_count
> is non-zero in a local_irq_disable() region. That means preempt_schedule()
> wont schedule.

True.

> What is the problem you wanted to fix in the first place?
> Drivers and subsystems using local_irq_disable()/enable() as a lock -
> which is valid for !PREEMPT_RT to protect per-cpu variables but not a good
> idea when we want determnistic realtime. Thus these regions needs to be
> made preemptive, such any RT events can come through even though you have
> enabled a non-RT subsystem  where local_irq_disable()/enable() haven't
> been removed. 

My patch gives a set upper bound on interrupt latency that doesn't
change depending on config. You can also measure all these disable
sections. Your missing the relevance of the SA_NODELAY flag. If you have
a specific interrupt that you want to be low latency you would flag it
SA_NODELAY .

> As far as I can see the only solution is to replace them with a per-cpu
> mutex. Such a mutex can be the rt_mutex for now, but someone may want to
> make a more optimized per-cpu version where a raw_spin_lock isn't used.
> That would make it nearly as cheap as cli()/sti() when there is no
> congestion. One doesn't need PI for this region either as the RT
> subsystems will not hit it anyway.

I don't like this solution mainly because it's so expensive. cli/sti may
take a few cycles at most, what your suggesting may take 50 times that,
which would similar in speed to put linux under adeos.. Plus take into
account that the average interrupt disable section is very small .. I
also think it's possible to extend my version to allow those section to
be preemptible but keep the cost equally low.

Daniel


