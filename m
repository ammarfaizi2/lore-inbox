Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVA1X2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVA1X2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVA1X1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:27:43 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:7690 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262819AbVA1X10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:27:26 -0500
Date: Fri, 28 Jan 2005 15:25:33 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Esben Nielsen <simlo@phys.au.dk>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       "Igor Manyilov (auriga)" <manyilov@lnxw.com>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Message-ID: <20050128232533.GA7267@nietzsche.lynx.com>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu> <1106939910.14321.37.camel@lade.trondhjem.org> <20050128194546.GA348@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128194546.GA348@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:45:46PM +0100, Ingo Molnar wrote:
> * Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > If you do have a highest interrupt case that causes all activity to
> > block, then rwsems may indeed fit the bill.
> > 
> > In the NFS client code we may use rwsems in order to protect stateful
> > operations against the (very infrequently used) server reboot recovery
> > code. The point is that when the server reboots, the server forces us
> > to block *all* requests that involve adding new state (e.g. opening an
> > NFSv4 file, or setting up a lock) while our client and others are
> > re-establishing their existing state on the server.
> 
> it seems the most scalable solution for this would be a global flag plus
> per-CPU spinlocks (or per-CPU mutexes) to make this totally scalable and
> still support the requirements of this rare event. An rwsem really
> bounces around on SMP, and it seems very unnecessary in the case you
> described.
> 
> possibly this could be formalised as an rwlock/rwlock implementation
> that scales better. brlocks were such an attempt.

>From how I understand it, you'll have to have a global structure to
denote an exclusive operation and then take some additional cpumask_t
representing the spinlocks set and use it to iterate over when doing a
PI chain operation.

Locking of each individual parametric typed spinlock might require
a raw_spinlock manipulate lists structures, which, added up, is rather
heavy weight.

No only that, you'd have to introduce a notion of it being counted
since it could also be aquired/preempted  by another higher priority
thread on that same procesor.  Not having this semantic would make the
thread in that specific circumstance effectively non-preemptable (PI
scheduler indeterminancy), where the mulipule readers portion of a
real read/write (shared-exclusve) lock would have permitted this.

	http://people.lynuxworks.com/~bhuey/rt-share-exclusive-lock/rtsem.tgz.1208

Is our attempt at getting real shared-exclusive lock semantics in a
blocking lock and may still be incomplete and buggy. Igor is still
working on this and this is the latest that I have of his work. Getting
comments on this approach would be a good thing as I/we (me/Igor)
believed from the start that this approach is correct.

Assuming that this is possible with the current approach, optimizing
it to avoid CPU ping-ponging is an important next step

bill

