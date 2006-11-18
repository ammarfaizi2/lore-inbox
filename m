Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755992AbWKRGAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbWKRGAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbWKRGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:00:09 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:64099
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1755992AbWKRGAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:00:07 -0500
Date: Fri, 17 Nov 2006 21:57:46 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       manfred@colorfullife.com, oleg@tv-sign.ru
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118055746.GB6059@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061118003859.GG2632@us.ibm.com> <Pine.LNX.4.44L0.0611172318180.8754-100000@netrider.rowland.org> <20061117205103.847081a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117205103.847081a4.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 08:51:03PM -0800, Andrew Morton wrote:
> On Fri, 17 Nov 2006 23:33:45 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Fri, 17 Nov 2006, Paul E. McKenney wrote:
> >
> > > > Perhaps a better approach to the initialization problem would be to assume
> > > > that either:
> > > >
> > > >     1.  The srcu_struct will be initialized before it is used, or
> > > >
> > > >     2.  When it is used before initialization, the system is running
> > > > 	only one thread.
> > >
> > > Are these assumptions valid?  If so, they would indeed simplify things
> > > a bit.
> >
> > I don't know.  Maybe Andrew can tell us -- is it true that the kernel runs
> > only one thread up through the time the core_initcalls are finished?
> 
> I don't see why - a core_initcall could go off and do the
> multithreaded-pci-probing thing, or it could call kernel_thread() or
> anything.  I doubt if any core_initcall functions _do_ do that, but there
> are a lot of them.
> 
> > If not, can we create another initcall level that is guaranteed to run
> > before any threads are spawned?
> 
> It's a simple and cheap matter to create a precore_initcall() - one would
> need to document it carefully to be able to preserve whatever guarantees it
> needs.
> 
> However by the time the initcalls get run, various thing are already
> happening: SMP is up, the keventd threads are running, the CPU scheduler
> migration threads are running, ksoftirqd, softlockup-detector, etc.
> keventd is the problematic one.
> 
> So I guess you'd need a new linker section and a call from
> do_pre_smp_initcalls() or thereabouts.

Hmmm...  OK then, for the moment, I will stick with the current checks
in the primitives.  Not that I particularly like the "bulking up" of
srcu_read_lock() and srcu_read_unlock() -- but if the super-fast
version is needed, it can easily be provided either within the
confines of the subsystem that needs it, or as yet another set of
RCU-like primitives.  Hopefully this latter option can be avoided!

BTW, the reason for the hardluckref is that I don't want to inflict a
failure return from srcu_read_lock() on you guys.  The non-blocking
synchronization community has repeatedly made that sort of mistake,
and I have no intention of letting it propagate any further.  ;-)

						Thanx, Paul
