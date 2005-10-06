Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVJFOCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVJFOCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVJFOCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:02:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48836 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751003AbVJFOCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:02:16 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: SMP syncronization on AMD processors (broken?)
Date: Thu, 6 Oct 2005 16:02:29 +0200
User-Agent: KMail/1.8.2
Cc: Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru, st@sw.ru
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de> <20051006174604.B10342@castle.nmd.msu.ru>
In-Reply-To: <20051006174604.B10342@castle.nmd.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061602.30558.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 15:46, Andrey Savochkin wrote:
> On Thu, Oct 06, 2005 at 03:32:30PM +0200, Andi Kleen wrote:
> > Kirill Korotaev <dev@sw.ru> writes:
> > > Please help with a not simple question about spin_lock/spin_unlock on
> > > SMP archs. The question is whether concurrent spin_lock()'s should
> > > acquire it in more or less "fair" fashinon or one of CPUs can starve
> > > any arbitrary time while others do reacquire it in a loop.
> >
> > They are not fully fair because of the NUMAness of the system.
> > Same on many other NUMA systems.
> >
> > We considered long ago to use queued locks to avoid this, but
> > they are quite costly for the uncongested case and never seemed worth it.
> >
> > So live with it.
>
> Well, it's hard to swallow...
> It's not about being not fully fair, it's about deadlocks that started
> to appear after code changes inside retry loops...

Don't do that then.

> A practical question is whether there is an "official" way to tell the CPU
> that it should synchronize with memory, or if you have ideas how to make it
> less costly than queued locks.

I don't think there is an way specified in the architecture. So you're
definitely in undocumented system dependent territory if you attempt this.

delay.

Or maybe a write combining access (movnti) follwed with a sfence.
 

> A theoretical question is how many places in the kernel use such retry
> loops that may start to fail some day (or on some machines)...

We already have such cases - e.g. our rwlocks always had such a deadlock
even on SMP systems. As far as I know it has been reported exactly once on a 
64CPU IA64 system, but it wasn't possible to fix it without large scale
changes so it was ignored.   I am not aware of the problem ever happening on a 
production system.

And in general fairness was never a force of Linux. A lot of subsystems
do resource handling / sharing without taking it into account. And so far
we got away with it.

I'm not saying it's a good thing, but that general strategy  
doesn't seem to have hurt us significantly so far and the fixes are usually
worse than the problems.

-Andi
