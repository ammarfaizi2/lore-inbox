Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424745AbWKPWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424745AbWKPWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424749AbWKPWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:22:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424747AbWKPWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:22:24 -0500
Date: Thu, 16 Nov 2006 14:21:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <Pine.LNX.4.44L0.0611161658170.2929-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org>
References: <Pine.LNX.4.44L0.0611161658170.2929-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2006, Alan Stern wrote:
> On Thu, 16 Nov 2006, Linus Torvalds wrote:
> >
> > Paul, it would be _really_ nice to have some way to just initialize 
> > that SRCU thing statically. This kind of crud is just crazy.
> 
> I looked into this back when SRCU was first added.  It's essentially 
> impossible to do it, because the per-cpu memory allocation & usage APIs 
> are completely different for the static and the dynamic cases.

I don't think that's how you'd want to do it.

There's no way to do an initialization of a percpu allocation statically. 
That's pretty obvious.

What I'd suggest instead, is to make the allocation dynamic, and make it 
inside the srcu functions (kind of like I did now, but I did it at a 
higher level).

Doing it at the high level was trivial right now, but we may well end up 
hitting this problem again if people start using SRCU more. Right now I 
suspect the cpufreq notifier is the only thing that uses SRCU, and it 
already showed this problem with SRCU initializers.

So I was more thinking about moving my "one special case high level hack" 
down lower, down to the SRCU level, so that we'll never see _more_ of 
those horrible hacks. We'll still have the hacky thing, but at least it 
will be limited to a single place - the SRCU code itself.

		Linus
