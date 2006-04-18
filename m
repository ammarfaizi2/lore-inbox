Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDRNum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDRNum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWDRNum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:50:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:3274 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750825AbWDRNum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:50:42 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145365886.5447.28.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 09:50:28 -0400
Message-Id: <1145368228.17085.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 06:11 -0700, Daniel Walker wrote:

> 
> Something in the code bothered me right around the block you
> referenced. 
> 
> Specifically when it drops the pi_lock , then takes it again, then does
> plist_add to the pi_waiters ( during the "Boost the owner" section in
> rt_mutex_adjust_prio_chain() ). Since the pi_lock was dropped you could
> get an priority change which would lead to a bogus value in
> waiter->pi_list_entry.prio .

It's not really bogus. It just wont match the task->prio.  The
waiter->pi_list_entry.prio is set to waiter->list_entry.prio and that's
what you really need to match.  But you are right that the prio could
have changed.  But whoever changed the prio should also be updating the
chain, so whoever finishes, should have the chain setup properly.

> 
> I was looking over the code, and it seems like once all the chain
> adjusting bottoms out you would end up with the correct priorities in
> the waiter structures .. Cause whatever task made the priority
> adjustment would just end up resetting the pi_waiters during it's
> adjustment process. (Seems like there's room for optimization
> though ..) 

I guess I just reiterated above what you are saying here.  Not sure if
this can be optimized.  You're talking about optimizing a case that
would seldom happen, but in doing so you stand a great chance of slowing
down the normal case.

To keep latencies down, we are letting the PI chain walk be preempted,
by releasing locks.  It's understood that the chain can then change
while walking (big debate about this between Ingo, tglx and Esben).  But
at the end, we decided on it being better to have latencies down, and
just make adjustments when they arise.  This also keeps the latencies
bounded, since the old way was harder to know the worst case (PI chain
creep).

BUT!  I need to take another good look at the code, and maybe my
previous example of the failed BUG_ON is really a clue that there exists
a deeper bug.  If the processes D and E from my last example were of
different priorities, but still higher than A, could the end result be
setting A to the lower of the two?  This would be a bug, because then A
would not inherit the correct priority!

-- Steve


