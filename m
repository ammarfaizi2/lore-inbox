Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVEJUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVEJUIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVEJUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:08:37 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:24929
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261771AbVEJUIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:08:31 -0400
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: paulmck@us.ibm.com
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050510012444.GA3011@us.ibm.com>
References: <20050510012444.GA3011@us.ibm.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 22:08:11 +0200
Message-Id: <1115755692.26548.15.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 18:24 -0700, Paul E. McKenney wrote:

> 
> Counter-Based Approach
> 
> The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> counter-based approach, which seems to work, but which can result in
> indefinite-duration grace periods.  The following are very hazy thoughts
> on how to get the benefits of this approach, but with short grace periods.
> 
> 1.	The basic trick is to maintain a pair of counters per CPU.
> 	There would also be a global boolean variable that would select
> 	one or the other of each pair.  The rcu_read_lock() primitive
> 	would then increment the counter indicated by the boolean
> 	corresponding to the CPU that it is currently running on.
> 	It would also keep a pointer to that particular counter in
> 	the task structure.  The rcu_read_unlock() primitive would
> 	decrement this counter.  (And, yes, you would also have a
> 	counter in the task structure so that only the outermost of
> 	a set of nested rcu_read_lock()/rcu_read_unlock() pairs would
> 	actually increment/decrement the per-CPU counter pairs.)
> 
> 	To force a grace period, one would invert the value of the
> 	global boolean variable.  Once all the counters indicated
> 	by the old value of the global boolean variable hit zero,
> 	the corresponding set of RCU callbacks can be safely invoked.
> 
> 	The big problem with this approach is that a pair of inversions
> 	of the global boolean variable could be spaced arbitrarily 
> 	closely, especially when you consider that the read side code
> 	can be preempted.  This could cause RCU callbacks to be invoked
> 	prematurely, which could greatly reduce the life expectancy
> 	of your kernel.

> Thoughts?
> 

How about having another boolean indicating the ability to flip the
selector boolean. This boolean would be set false on an actual flip and
cleared during a grace period. That way the flips cannot ever interfere
with one another such that the callbacks would be cleared prematurely.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

