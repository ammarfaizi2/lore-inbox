Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTAPXkP>; Thu, 16 Jan 2003 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTAPXkP>; Thu, 16 Jan 2003 18:40:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:40181 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267333AbTAPXkO>;
	Thu, 16 Jan 2003 18:40:14 -0500
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Jan 2003 15:45:40 -0800
Message-Id: <1042760746.4747.367.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 12:19, Ingo Molnar wrote:
> 
> 	Ingo
> 
> (*) whether sched_balance_exec() is a high-frequency path or not is up to
> debate. Right now it's not possible to get much more than a couple of
> thousand exec()'s per second on fast CPUs. Hopefully that will change in
> the future though, so exec() events could become really fast. So i'd
> suggest to only do local (ie. SMP-alike) balancing in the exec() path, and
> only do NUMA cross-node balancing with a fixed frequency, from the timer
> tick. But exec()-time is really special, since the user task usually has
> zero cached state at this point, so we _can_ do cheap cross-node balancing
> as well. So it's a boundary thing - probably doing the full-blown
> balancing is the right thing.
> 
The reason for doing load balancing on every exec is that, as you say,
it is cheap to do the balancing at this point - no cache state, minimal
memory allocations.  If we did not balance at this point and relied on
balancing from the timer tick, there would be much more movement of 
established processes between nodes, which is expensive.  Ideally, the
exec balancing is good enough so that on a well functioning system there
is no inter-node balancing taking place at the timer tick.  Our testing
has shown that the exec load balance code does a very good job of
spreading processes across nodes, and thus, very little timer tick
balancing.  The timer tick internode balancing is there as a safety
valve for those cases where exec balancing is not adequate.  Workloads
with long running processes, and workloads with processes that do lots
of forks but not execs, are examples.

An earlier version of Erich's initial load balancer provided for
the option of balancing at either fork or exec, and the capability
of selecting on a per-process basis which to use.  That could be
used if workloads that do forks with no execs become a problem on
NUMA boxes.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

