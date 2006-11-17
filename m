Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424304AbWKQDG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424304AbWKQDG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 22:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424752AbWKQDG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 22:06:28 -0500
Received: from mx2.rowland.org ([192.131.102.7]:26630 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1424304AbWKQDG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 22:06:27 -0500
Date: Thu, 16 Nov 2006 22:06:25 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Linus Torvalds wrote:

> 
> 
> On Thu, 16 Nov 2006, Alan Stern wrote:
> > On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > >
> > > Paul, it would be _really_ nice to have some way to just initialize 
> > > that SRCU thing statically. This kind of crud is just crazy.
> > 
> > I looked into this back when SRCU was first added.  It's essentially 
> > impossible to do it, because the per-cpu memory allocation & usage APIs 
> > are completely different for the static and the dynamic cases.
> 
> I don't think that's how you'd want to do it.
> 
> There's no way to do an initialization of a percpu allocation statically. 
> That's pretty obvious.

Hmmm...  What about DEFINE_PER_CPU in include/asm-generic/percpu.h 
combined with setup_per_cpu_areas() in init/main.c?  So long as you want 
all the CPUs to start with the same initial values, it should work.

> What I'd suggest instead, is to make the allocation dynamic, and make it 
> inside the srcu functions (kind of like I did now, but I did it at a 
> higher level).
> 
> Doing it at the high level was trivial right now, but we may well end up 
> hitting this problem again if people start using SRCU more. Right now I 
> suspect the cpufreq notifier is the only thing that uses SRCU, and it 
> already showed this problem with SRCU initializers.
> 
> So I was more thinking about moving my "one special case high level hack" 
> down lower, down to the SRCU level, so that we'll never see _more_ of 
> those horrible hacks. We'll still have the hacky thing, but at least it 
> will be limited to a single place - the SRCU code itself.

Another possible approach (but equally disgusting) is to use this static 
allocation approach, and have the SRCU structure include both a static and 
a dynamic percpu pointer together with a flag indicating which should be 
used.

Alan Stern

