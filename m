Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTLHNwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTLHNwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:52:45 -0500
Received: from holomorphy.com ([199.26.172.102]:18907 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265413AbTLHNwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:52:39 -0500
Date: Mon, 8 Dec 2003 05:52:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031208135225.GT19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311041355.08731.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 01:55:08PM +1100, Con Kolivas wrote:
> This is now a balance tradeoff of trying to set a value that works for your 
> combination of the required ram of the applications you run concurrently, the 
> physical ram and the swap ram. As you can see from your example, in your 
> workload it seems there would be no point having more swap than your physical 
> ram since even if it tries to use say 40Mb it just drowns in a swapstorm. 
> Clearly this is not the case in a machine with more ram in different 
> circumstances, as swapping out say openoffice and mozilla while it's not 
> being used will not cause any harm to a kernel compile that takes up all the 
> available physical ram (it would actually be beneficial). Fortunately most 
> modern machines' ram vs application sizes are of the latter balance.
> There's always so much more you can do...
> wli, riel care to comment?

Explicit load control is in order. 2.4 appears to work better in these
instances because it victimizes one process at a time. It vaguely
resembles load control with a random demotion policy (mmlist order is
effectively random), but is the only method of page reclamation, which
disturbs its two-stage LRU, and basically livelocks in various situations
because having "demoted" a process address space to whatever extent it
does fails to eliminate it from consideration during further attempts
to reclaim memory to satisfy allocations.

On smaller machines or workloads with high levels of overcommitment
(in a sense different from non-overcommit; here it means that if all
tasks were executing simultaneously over some period of time they
would require more RAM than the machine has), the effect of load control
dominates replacement by several orders of magnitude, so the mere
presence of anything like a load control mechanism does them wonders.

According to a study from the 80's (Carr's thesis), the best load
control policies are demoting the smallest task, demoting the "most
recently activated task", and demoting the "task with the largest
remaining quantum". The latter two no longer make sense in the presence
of threads, or at least have to be revised not to assume a unique
execution context associated with a process address space. These three
Were said to be largely equivalent and performed 15% better than random.

Other important aspects of load control beyond the demotion policy are
explicit suspension the execution contexts of the process address
spaces chosen as its victims, complete eviction of the process address
space, load-time bonuses for process address spaces promoted from that
demoted status, and, of course, fair enough scheduling that starvation
or repetitive demotions of the same tasks (I think demoting the faulting
task runs into this) without forward progress don't occur.

2.4 does not do any of this.

The effect of not suspending the execution contexts of the demoted
process address spaces is that the victimized execution contexts thrash
while trying to reload the memory they need to execute. The effect of
incomplete demotion is essentially livelock under sufficient stress.
Its memory scheduling to what extent it has it is RR and hence fair,
but the various caveats above justify "does not do any of this",
particularly incomplete demotion.

So I predict that a true load control mechanism and policy would be
both an improvement over 2.4 and would correct 2.6 regressions vs. 2.4
on underprovisioned machines. For now, we lack an implementation.


-- wli
