Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSEHKfD>; Wed, 8 May 2002 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSEHKfC>; Wed, 8 May 2002 06:35:02 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16933 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312928AbSEHKfB>; Wed, 8 May 2002 06:35:01 -0400
Date: Wed, 8 May 2002 12:35:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Preemptible Read-Copy Update
Message-ID: <20020508123521.G31998@dualathlon.random>
In-Reply-To: <20020508145149.E10505@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 02:51:49PM +0530, Dipankar Sarma wrote:
> Read-Copy Update depends on tasks losing local reference to 
> RCU protected data during context switches. That is not
> guaranteed in a preemptible kernel environment. So, I modified
> RCU to work correctly in both preemptible and non-preemptible
> kernel environments.
> 
> Based on Andrea's suggestion, I have introduced a separate
> interface for preemptible RCU - call_rcu_preempt(). 
> Existing call_rcu() interface requires that you disable preemption
> during read-side of the RCU protected data. With call_rcu_preempt(),
> that is not required. It transparently takes care of detecting
> the grace period despite existence of preempted tasks. Andrea's
> point was that we could have kernel daemons who may do -
> 
> #ifndef CONFIG_PREEMPT
> 	schedule();
> #else
> 	continue to do stuff inside the kernel
> #endif
> 
> This may result in very large RCU grace periods thereby increasing
> memory pressure. So for things like synchronize_kernel() which
> aren't concerned about latency (when used with module unloading
> or cpu hotplug), call_rcu_preempt() can be used. For anything
> else that care about latency, preemption should be disabled
> during the read-side and call_rcu() should be used.
> 
> Preemptible RCU uses a pair of per-CPU counters to keep
> track of preempted tasks. The pair is used as a cyclical
> queue. While one counts the number of tasks preempted
> in that cpu before the start of the current grace period,
> the other counts the same after the start of the current
> grace period. At the end of every grace period, the counters
> are switched. A preempted task may migrate to another CPU, so
> we keep track of the original counter whose reference it held
> in a per-task counter pointer. When such a task undergoes
> a voluntary context switch or exits, the reference is decremented.
> For a grace period to end, each cpus current preempt conter
> must be zero.
> 
> Note: rcu_preempt_put() needs to be done more aggressively by
> detecting transition to user level or user level itself.
> 
> The included patch is based on rcu_poll which is in
> 2.4.x-aa series of kernels.
> 
> Comments/suggestions are welcome.

I didn't checked every single line of the implementation yet, but the
design looks fine to me. the call_rcu_preempt is actually the only way
to do cpu-hotplug removal and rmmod race fixes when preemption is
enabled (i.e. synchronize_kernel()), in such two cases being subject to
starvation from cpu-intensive kernel code never doing active schedules
is fine, because we cannot avoid it anyways if we allow preemption in
kernel. Or as you said in a previous email the only way to avoid
starvation with preemption enabled would be to require the replacement
of the explicit schedule() with a cpu-local call to
reached_quiescent_point(), but the whole point of -preempt is not having
to make those schedule point explicit and infact as every mainline
kernel out there the mainline 2.5 kernel is still broken in
read/write/sendfile etc..  if -preempt is disabled (at least
read/write/sendfile cannot generate an indefinite starvation, after
reading 32G of cache into a 32G buffer it will eventually reschedule,
and the 32G buffer is available only 64bit archs so at least x86 is a
bit less affected by the DoS).

Andrea
