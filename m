Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314453AbSDRWX4>; Thu, 18 Apr 2002 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSDRWXz>; Thu, 18 Apr 2002 18:23:55 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:58295 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S314453AbSDRWXy>; Thu, 18 Apr 2002 18:23:54 -0400
Date: Fri, 19 Apr 2002 00:24:14 +0200 (CEST)
From: Erich Focht <focht@ess.nec.de>
X-X-Sender: focht@beast.local
To: William Lee Irwin III <wli@holomorphy.com>, Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <1019166066.5395.99.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204182358450.3004-100000@beast.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

thanks for sending me your patch. No, I didn't see it before.


rl> Eric, I am interested in your opinion of wli's patch, too.  I really
rl> liked his approach.

Hmm, as far as I can see, it probably fixes the problems but keeps the
original philosophy of depending on the load balancer to get the
migration tasks scheduled on every CPU.

rl> You seem to remove a lot of code since, after starting the first thread,
rl> you rely on set_cpus_allowed and the existing migration_thread to push
rl> the task to the correct place.  I suppose this will work .. but it may
rl> depend implicitly on behavior of the migration_threads and load_balance
rl> (not that the current code doesn't rely on load_balance - it does).

The first thread starts up on the boot cpu with cpus_allowed mask set
to the boot cpu. It will write itself into cpu_rq(0)->migration_thread
and be fully functional because all other existing threads (and
migration_init) will call yield() or schedule(). The other
migration_threads can also run only on cpu#0 and will do so when
migration_CPU0 was completely initialized. Then they move themselves
to their designated CPU by calling set_cpus_allowed(). Their initial
CPU mask beeing 1<<0, they will call migration_CPU0, which is fully
functional at this time and only does the job it was designed
for. There is no dependency on the load balancer any more.

rl> What happens if a migration_thread comes up on a CPU without a migration
rl> thread and then you call set_cpus_allowed?

It doesn't because the cpus_allowed mask is 0x0001.

rl> I am also curious what causes #1 you mention.  Do you see it in the
rl> _normal_ code or just with your patch?  I cannot see what we race
rl> against wrt interrupts ... disabling interrupts, however, would disable
rl> load_balance and that is a potential pitfall with using
rl> migration_threads to migrate migration_threads as noted above.

I saw the problem #1 when testing an interface to
userspace which migrates tasks from one cpu to another. It happens
pretty easilly that the timer interrupt occurs while the migration
thread is doing its job and holds the current runqueue
lock. scheduler_tick() spinlocks on the own rq->lock which will never
be released by migration_thread. Maybe this occurs pretty seldomly on
IA32 with 10ms ticks, in IA64 it's easy to produce.

Best regards,
Erich

