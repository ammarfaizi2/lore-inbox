Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUGIXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUGIXue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUGIXue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:50:34 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:20612 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S264850AbUGIXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:50:31 -0400
Date: Sat, 10 Jul 2004 01:50:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040709235017.GP20947@dualathlon.random>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709195105.GA4807@infradead.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 08:51:05PM +0100, Christoph Hellwig wrote:
> > unlike the lowlatency patches, this patch doesn't add a lot of new
> > scheduling points to the source code, it rather reuses a rich but
> > currently inactive set of scheduling points that already exist in the
> > 2.6 tree: the might_sleep() debugging checks. Any code point that does
> > might_sleep() is in fact ready to sleep at that point. So the patch
> > activates these debugging checks to be scheduling points. This reduces
> > complexity and impact quite significantly.
> 
> I don't think this is a good idea.  Just because a function might sleep
> it doesn't mean it should sleep.  I'd rather add the might_sleep() to
> cond_resched() and replace the former with the latter in the cases where
> it makes sense.

agreed. might_sleep() just like BUG() can be defined to noop.

cond_resched() is the API to use.

the other bad thing is that there is no  point for the sysctl (in 2.4
that made no sense at all too, yeah it only makes sense for benchmarking
easily w/ and w/o the feature but it must be optimized away at the very
least with a config option for production), if need_resched is set we
_must_ schedule no matter what (a sysctl can only introduce a bug if
something). If we spend any cpu checking the sysctl, we should instead
spend such cpu to check need_resched in the first place.

The rest is of course very welcome, but you should remove all the
pollution from the patch to make it mergeable.

Just convert all those might to cond_resched() and remove all the
superflous volountary stuff and config options.

As worse you can leave a single config option LOW_RESCHEDULE_OVERHEAD
with PREEMPT=n, that could remove some cond_resched() from an extremely
fast path if you're concerned about adding branches in some critical
point, but you really seem not concerned since with
CONFIG_PREEMPT_VOLUNTARY=y (the only way to enable it) you even _waste_
cpu on these paths to check a worthless sysctl that can only introduce
bugs at runtime since it overrides the wishes of the scheduler.

If scheduler is bad fix the scheduler, but as soon as need_resched is
set no sysctl must be allowed to mask the wishes of the scheduler.
