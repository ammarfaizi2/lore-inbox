Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVDLCO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVDLCO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 22:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDLCO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 22:14:56 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:62095 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262003AbVDLCMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 22:12:55 -0400
Subject: Re: [patch] sched: unlocked context-switches
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: davidm@hpl.hp.com
Cc: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>,
       tony.luck@intel.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16987.7956.806699.617633@napali.hpl.hp.com>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	 <ugoecowjci.fsf@panda.mostang.com> <20050409070738.GA5444@elte.hu>
	 <16983.33049.962002.335198@napali.hpl.hp.com>
	 <20050409155810.593d8f7b.davem@davemloft.net>
	 <20050410064324.GA24596@elte.hu>
	 <16987.7956.806699.617633@napali.hpl.hp.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 12:12:45 +1000
Message-Id: <1113271965.5090.24.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 18:06 -0700, David Mosberger wrote:

> I had to refresh my memory with a quick Google search that netted [1]
> (look for "Disable interrupts during context switch").  Actually, it
> wasn't really a deadlock, but rather a livelock, since a CPU got stuck
> on an infinite page-not-present loop.
> 
> Fundamentally, the issue was that doing the switch_mm() and
> switch_to() with interrupts enabled opened a window during which you
> could get a call to flush_tlb_mm() (as a result of an IPI).  This, in
> turn, could end up activating the wrong MMU-context, since the action
> of flush_tlb_mm() depends on the value of current->active_mm.  The
> problematic sequence was:
> 
> 1) schedule() calls switch_mm() which calls activate_context() to
>    switch to the new address-space
> 2) IPI comes in and flush_tlb_mm(mm) gets called
> 3) "current" still points to old task and if "current->active_mm == mm",
>    activate_mm() is called for the old address-space, resetting the
>    address-space back to that of the old task
> 
> Now, Ingo says that the order is reversed with his patch, i.e.,
> switch_mm() happens after switch_to().  That means flush_tlb_mm() may
> now see a current->active_mm which hasn't really been activated yet.

If that did bother you, could you keep track of the actually
activated mm in your arch code? Or would that involve more arch
hooks and general ugliness in the scheduler?

Could you alternatively just disable interrupts across the switch?
I guess that would require a bit of #ifdefery in sched.c, which we
are trying to move away from, but it would be pretty minimal. Much
better than what is there now.

> That should be OK since it would just mean that we'd do an early (and
> duplicate) activate_context().  While it does not give me a warm and
> fuzzy feeling to have this inconsistent state be observable by
> interrupt-handlers (and, in particular, IPI-handlers), I don't see any
> problem with it off hand.
> 

IMO it *is* the direction we should move towards. That is,
liberating context switching from scheduler locking, and providing
a single set of semantics for the context switch hooks for all
architectures.

No rush, of course. But it would be good to get it in sooner
or later.

Nick


