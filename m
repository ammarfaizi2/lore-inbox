Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUE0Bo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUE0Bo3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 21:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUE0Bo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 21:44:29 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:34551 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261498AbUE0Bo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 21:44:27 -0400
Date: Wed, 26 May 2004 21:45:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] i386: enable interrupts on contention in
 spin_lock_irq
In-Reply-To: <Pine.LNX.4.58.0405260401320.1794@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0405262111310.1794@montezuma.fsmlabs.com>
References: <14280.1085556586@kao2.melbourne.sgi.com> <200405260958.21252.baldrick@free.fr>
 <Pine.LNX.4.58.0405260401320.1794@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Zwane Mwaikambo wrote:

> On Wed, 26 May 2004, Duncan Sands wrote:
>
> > > However I have seen buggy code where spin_lock_irq() was issued with
> > > interrupts disabled. [...]
> >
> > Some time ago I sent a patch to lkml that tests for this [1].
> > And guess what - it happens all over the place [2].  Also, the
> > scheduler often gets called with interrupts disabled (schedule()
> > does spin_lock_irq), but the cases I checked all turned out to be
> > OK [3].  Perhaps it is more problematic now?
>
> I'll run with the debug code and audit any suspect ones. The ones
> mentioned below all seem ok.

The oft hit one is triggered from the timer softirq;

Badness in __run_timers at kernel/timer.c:427
 [<c0107705>] dump_stack+0x15/0x20
 [<c012d497>] run_timer_softirq+0x2e7/0x2f0
 [<c0128bc8>] __do_softirq+0xb8/0xc0
 [<c0128c05>] do_softirq+0x35/0x40
 [<c0108fb5>] do_IRQ+0x1a5/0x240

static inline void __run_timers(tvec_base_t *base)
{
	struct timer_list *timer;

	spin_lock_irq(&base->lock); <==
	...
		timer->base = NULL;
		spin_unlock_irq(&base->lock);
		fn(data);
		spin_lock_irq(&base->lock);
	...
	spin_unlock_irq(&base->lock);
}

Most of them would be because the timer irq is setup with SA_INTERRUPT,
this particular one looks safe too, we're on the exit path of irq handling
and there is no critical section to protect. We're also about to
unconditionally enable interrupts again before running the timers. There
also isn't much contention on this lock on most workloads, some
heavy tcp networking load should help that out.

I'll look for others too.

	Zwane
