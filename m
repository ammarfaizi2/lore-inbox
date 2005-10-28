Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbVJ1KIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbVJ1KIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJ1KIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:08:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36481 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751623AbVJ1KIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:08:00 -0400
Date: Fri, 28 Oct 2005 12:08:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
Message-ID: <20051028100806.GA19507@elte.hu>
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com> <4361EC95.5040800@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4361EC95.5040800@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Chen, Kenneth W wrote:
> >Once upon a time, this patch was in -mm tree (2.6.13-mm1):
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2
> >
> >It is neither in Linus's official tree, nor it is in -mm anymore.
> >
> >I guess I missed the objection for dropping the patch.  I'm bringing
> 
> My objection for the patch is that it seems to be designed just to 
> improve your TPC - and I don't think we've seen results yet... or did 
> I miss that?
> 
> Also - by no means do I think improving TPC is wrong, but I think such 
> a patch may not be the right way to go. It doesn't seem to solve your 
> problem well.

Nick, the TPC workload is simple and has been described before: lots of 
interrupts arriving on many CPUs, and waking up tasks randomly, which do 
short amount of work and then go back to sleep again. There is no 
correlation between the CPU the interrupt arrives on and the CPU the 
task gets woken up on. There is no point in immediate balancing either: 
the IRQs are well-balanced themselves so there are no load transients to 
take care of (except for idle CPUs, which my patch handles), and the 
next wakeup for that task wont arrive on the same CPU anyway.

in such a workload, my patch will clearly improve things, by not 
bouncing tasks around wildly.

> Now you may have one of two problems. Well it definitely looks like 
> you are taking a lot of cache misses in try_to_wake_up - however this 
> won't be due to the load balancing stuff, but rather from locking the 
> remote CPUs runqueue and touching its runqueues, and cachelines in the 
> task_struct that had been last touched by the remote CPU.

no, because you are not considering a fundamentally random workload like 
TPC. There is only a 1:8 chance to hit the right CPU with the interrupt, 
and there is no benefit from moving the task to the CPU it got woken up 
from. In fact, it hurts by doing pointless migrations.

my patch adds the rule that we only consider 'fast' migration when 
provably beneficial: if the target CPU is idle. Any other case will have 
to go over the 'slow' migration paths.

> In fact, if the balancing stuff in try_to_wake_up is working as it 
> should, then it will result in fewer "remote wakups" because tasks 
> will be moved to the same CPU that wakes them. Schedstats can tell us 
> a lot about this, BTW.

wrong. Even if the balancing stuff in try_to_wake_up is working as it 
should, it can easily happen that moving a task is not worthwhile: if 
there is little or no further relationship between the wakeup CPU and 
the IRQ CPU, i.e. when the migration cost is larger than the 
relationship-win between the wakeup CPU and the IRQ CPU.

so for me the decision logic is simple: the balancing code logic is 
migrating over-eagerly, and this simple and straightforward patch makes 
it less eager for an important workload class. You are welcome to 
suggest other approaches, but simply saying "I dont like this" wont 
bring us further, as the damage on TPC workloads is clearly 
demonstrated. If this patch hurts other workloads (and please 
demonstrate them instead of calling my patch a hammer - the patch has 
been in -mm for many months already) then simply provide the logic that 
will do the balancing for those workloads only, without hurting this 
workload!

When we have to pick between two workloads (only one of which is 
identified at the moment!) that have have to balance out against each 
other then we will go towards the simpler solution (all other factors 
being equal). I.e. in this case by not doing the balancing. Migration is 
a fundamentally intrusive act and should be done carefully. If you can 
pull it off without hurting other workloads then fine, but otherwise it 
needs refinement. This rule is not a hard limit: we obviously will do 
changes that hurt some rare workloads only a bit while helping other, 
more common workloads enormously. This has not been demonstrated for 
this case yet. There is also a simplicity factor: not doing a complex 
balancing decision is obviously simpler, so we have a bias towards it.  
I.e. do something complex and costly only if we can prove it most likely 
OK.

	Ingo
