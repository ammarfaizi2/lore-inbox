Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314482AbSDRWia>; Thu, 18 Apr 2002 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSDRWi3>; Thu, 18 Apr 2002 18:38:29 -0400
Received: from zero.tech9.net ([209.61.188.187]:60427 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314482AbSDRWi2>;
	Thu, 18 Apr 2002 18:38:28 -0400
Subject: Re: [PATCH] migration thread fix
From: Robert Love <rml@tech9.net>
To: Erich Focht <focht@ess.nec.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0204182358450.3004-100000@beast.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 18 Apr 2002 18:38:29 -0400
Message-Id: <1019169510.5395.126.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 18:24, Erich Focht wrote:

> The first thread starts up on the boot cpu with cpus_allowed mask set
> to the boot cpu. It will write itself into cpu_rq(0)->migration_thread
> and be fully functional because all other existing threads (and
> migration_init) will call yield() or schedule(). The other
> migration_threads can also run only on cpu#0 and will do so when
> migration_CPU0 was completely initialized. Then they move themselves
> to their designated CPU by calling set_cpus_allowed(). Their initial
> CPU mask beeing 1<<0, they will call migration_CPU0, which is fully
> functional at this time and only does the job it was designed
> for. There is no dependency on the load balancer any more.

This seems right.  I was skeptical because it is very easy here to rely
on some implicit behavior that is not at all defined.  I cannot think of
anything wrong with your approach - good.

> I saw the problem #1 when testing an interface to
> userspace which migrates tasks from one cpu to another. It happens
> pretty easilly that the timer interrupt occurs while the migration
> thread is doing its job and holds the current runqueue
> lock. scheduler_tick() spinlocks on the own rq->lock which will never
> be released by migration_thread. Maybe this occurs pretty seldomly on
> IA32 with 10ms ticks, in IA64 it's easy to produce.

Oh, this is indeed a problem.  But perhaps the bigger question is, why
does not double_rq_lock disable interrupts like task_rq_lock?  You are
right about rq_lock vs. interrupts - thus interrupts must _always_ be
disabled when holding a runqueue lock.

The only other code that uses double_rq_lock is init_idle, which
correctly disables interrupts.  Maybe it is wise to just make
double_rq_lock disable interrupts?  If not, at least a comment above the
code: "must disable interrupts before calling!".

Also, this is almost certainly the cause of the preempt race in
set_cpus_allowed.  I knew it was not kernel preemptions fault!

	Robert Love

