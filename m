Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTAVQZv>; Wed, 22 Jan 2003 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTAVQZu>; Wed, 22 Jan 2003 11:25:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:12462 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261900AbTAVQZt>; Wed, 22 Jan 2003 11:25:49 -0500
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@ess.nec.de>, Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <003301c2c235$2f3123c0$29060e09@andrewhcsltgw8>
References: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
	<1043205347.5161.42.camel@kenai> 
	<003301c2c235$2f3123c0$29060e09@andrewhcsltgw8>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Jan 2003 08:35:52 -0800
Message-Id: <1043253356.24747.589.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-22 at 08:41, Andrew Theurer wrote:
> > On Mon, 2003-01-20 at 13:18, Ingo Molnar wrote:
> > >
> > > the attached patch (against 2.5.59) is my current scheduler tree, it
> > > includes two main areas of changes:
> > >
> > >  - interactivity improvements, mostly reworked bits from Andrea's tree
> and
> > >    various tunings.
> > >
> > >  - HT scheduler: 'shared runqueue' concept plus related logic: HT-aware
> > >    passive load balancing, active-balancing, HT-aware task pickup,
> > >    HT-aware affinity and HT-aware wakeup.
> >
> > I ran Erich's numatest on a system with this patch, plus the
> > cputime_stats patch (so that we would get meaningful numbers),
> > and found a problem.  It appears that on the lightly loaded system
> > sched_best_cpu is now loading up one node before moving on to the
> > next.  Once the system is loaded (i.e., a process per cpu) things
> > even out.  Before applying the D7 patch, processes were distributed
> > evenly across nodes, even in low load situations.
> 
> Michael,  my experience has been that 2.5.59 loaded up the first node before
> distributing out tasks (at least on kernbench).  

Well the data I posted doesn't support that conclusion - it showed at
most two processes on the first node before moving to the next node
for 2.5.59, but for the D7 patched system, the current node was fully
loaded before putting processes on other nodes.  I've repeated this on
multiple runs and obtained similar results.

The first check in
> sched_best_cpu would almost always place the new task on the same cpu, and
> intra node balance on an idle cpu in the same node would almost always steal
> it before a inter node balance could steal it.  Also, sched_best_cpu does
> not appear to be changed in D7. 

That is true, and is the only thing I've had a chance to look at.  
sched_best_cpu depends on data collected elsewhere, so my suspicion
is that it is working with bad data.  I'll try to find time this week
to look further at it.

 Actually, I expected D7 to have the
> opposite effect you describe (although I have not tried it yet), since
> load_balance will now steal a running task if called by an idle cpu.
> 
> I'll try to get some of these tests on x440 asap to compare.

I'm interested in seeing these results.  Any chance of getting time on
a 4-node x440?
> 
> -Andrew Theurer
> 
> 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

