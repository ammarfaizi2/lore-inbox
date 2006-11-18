Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753877AbWKREx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbWKREx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbWKREx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:53:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753877AbWKREx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:53:28 -0500
Date: Fri, 17 Nov 2006 20:51:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       <manfred@colorfullife.com>, <oleg@tv-sign.ru>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-Id: <20061117205103.847081a4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0611172318180.8754-100000@netrider.rowland.org>
References: <20061118003859.GG2632@us.ibm.com>
	<Pine.LNX.4.44L0.0611172318180.8754-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 23:33:45 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, 17 Nov 2006, Paul E. McKenney wrote:
> 
> > > Perhaps a better approach to the initialization problem would be to assume 
> > > that either:
> > > 
> > >     1.  The srcu_struct will be initialized before it is used, or
> > > 
> > >     2.  When it is used before initialization, the system is running
> > > 	only one thread.
> > 
> > Are these assumptions valid?  If so, they would indeed simplify things
> > a bit.
> 
> I don't know.  Maybe Andrew can tell us -- is it true that the kernel runs 
> only one thread up through the time the core_initcalls are finished?

I don't see why - a core_initcall could go off and do the
multithreaded-pci-probing thing, or it could call kernel_thread() or
anything.  I doubt if any core_initcall functions _do_ do that, but there
are a lot of them.

> If not, can we create another initcall level that is guaranteed to run 
> before any threads are spawned?

It's a simple and cheap matter to create a precore_initcall() - one would
need to document it carefully to be able to preserve whatever guarantees it
needs.

However by the time the initcalls get run, various thing are already
happening: SMP is up, the keventd threads are running, the CPU scheduler
migration threads are running, ksoftirqd, softlockup-detector, etc. 
keventd is the problematic one.

So I guess you'd need a new linker section and a call from
do_pre_smp_initcalls() or thereabouts.
