Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269926AbUJNAXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269926AbUJNAXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269932AbUJNAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:23:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10980 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269926AbUJNAXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:23:11 -0400
Date: Thu, 14 Oct 2004 02:24:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014002433.GA19399@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013061518.GA1083@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.672, required 5.9,
	autolearn=not spam, BAYES_00 -4.90, OPT_IN 0.23
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i'm pleased to announce a significantly improved version of the
Real-Time Preemption (PREEMPT_REALTIME) feature that i have been working
towards in the past couple of weeks.

the patch (against 2.6.9-rc4-mm1) can be downloaded from:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0

this is i believe the first correct conversion of the Linux kernel to a
fully preemptible (fully mutex-based) preemption model, while still
keeping all locking properties of Linux.

I also think that this feature can and should be integrated into the
upstream kernel sometime in the future. It will need improvements and
fixes and lots of testing, but i believe the basic concept is sound and
inclusion is manageable and desirable. So comments, testing and feedback
is more than welcome!

to recap the conceptual issues that needed solving: the previous patch
already converted a fair portion of spinlocks to mutexes, but that in a
fully preemptible kernel model the following locking primitives are
especially problematic:

	- RCU locking
	- per-cpu counters and per-cpu variables
	- tlb gather/release logic
	- seqlocks
	- atomic-kmaps
	- pte mapping

note that while we tend to think about these as SMP locking primitives,
in a fully preemptible model these locking rules are necessary for
correctness, even on a single-CPU embedded box.

Unfortunately none of the existing preemption patches solve these
problems: they concentrate on UP but these locking rules must not be
ignored on UP either!

(Bill Huey's mutex patch he just released is the one notable exception i
know about, which is also a correct implementation i believe, but it
doesnt attack these locking rules [yet]. Bill's locking hierarchy is i
believe quite similar to the -T9 patch - this i believe is roughly the
best one can get when only using spinlocks as a vehicle.)

In the previous (-T9) version of the Real-Time Preemption patch, the
above locking primitives kept large portions of kernel code
non-preemptable, causing a 'spreadout' of raw spinlocks and
non-preemptible sections to various kernel subsystems.

Another, even more problematic effect was that both network drivers and
block IO drivers got 'contaminated' by raw spinlocks, triggering lots of
per-driver changes and thus limiting testability. It is basically an
opt-in model to correctness which is bad from a maintainance and
upstream acceptance point of view. The -T9 patch was a prime example of
the problems the Linux locking primitives cause in a fully preemptible
kernel model.


To solve all these fundamental problems, i improved/fixed/changed all of
these locking methods to be preemption-friendly. Most of the time it was
necessary to introduce an additional API variant because e.g.
rcu_read_lock() is anonymous (it doesnt identify the data protected), so
i introduced a variant that takes the write-lock as an argument. In the
PREEMPT_REALTIME case we can thus properly serialize on that lock.

For per-cpu variables i introduced a new API variant that creates a
spinlock-array for the per-cpu-variable, and users must make sure the
cpu field doesnt change. Migration to another CPU can happen within the
critical section, but 'statistically' the variable is still per-CPU and
update correctness is fully preserved.

TLB shootdown was the source of another nasty type of critical section:
it keeps preemption disabled during much of the pagetable zapping and
also relies on a per-CPU variable to keep TLB state. The fix for
PREEMPT_REALTIME (on x86) was to implement a simpler but preemptible TLB
flushing method. This necessiated two minor API changes to the generic
TLB shootdown code - pretty straightforward ones.

Atomic kmaps were another source of non-preemptible sections:
pte_map/pte_unmap both used nontrivial functions within and ran for a
long time, creating a lock dependency and a latency problem as well. I
wrapped them via normal kmaps, which thus become preemptible. (The main
reason for atomic kmaps were non-preemptability constraints - but those
are not present in a fully preemptible model.)

seqlocks (used within the VFS and other places) were another problem:
the are now preemptible by default, the same auto-type-detection logic
applies to them as to preemptible/raw spinlocks: switching between a
preemptible and a non-preemptible type is done by changing the
prototype, the locking APIs stay the same.

The improvements to locking allowed the gradual 'pulling out' of all
raw-spinlocks from various kernel subsystems. In the -U0 patch i have
almost completely finished this 'pullout', and as a result the following
kernel subsystems are now completely spinlock-free and 100% mutex-based:

	- networking
	- IO subsystem
	- VFS and lowlevel filesystems
	- memory management (except the SLAB allocator lock)
	- signal code
	- all of drivers/* and sound/*

note: it is important that when PREEMPT_REALTIME is disabled, the old
locking rules apply and there is no performance impact whatsoever. So
what this implements is in essence a compile-time multi-tier locking
architecture enabling 4 types of preemption models:

  - stock                      (casual voluntary kernel preemption)
  - CONFIG_PREEMPT_VOLUNTARY   (lots of cond_resched() points)
  - CONFIG_PREEMPT             (involuntary preemption plus spinlocks)
  - CONFIG_PREEMPT_REALTIME    (everything is a mutex)

these models cover all the variants people are interested in: servers
with almost no latency worries, desktops with ~1msec needs and hard-RT
applications needing both microsecond-range latencies and provable
maximum latencies.

to quantitatively see the effects of these changes to the locking
landscape, here's the output of a script that disassembles the kernel
image and counts the number of actual spin lock/unlock function calls
done versus mutex lock/unlocks:

With PREEMPT_REALTIME disabled, all locks are spinlocks and old
semaphores:

        spinlock API calls:      5359  (71.6%)
        | old mutex API calls:   2120  (28.3%)
        | new mutex API calls:      2  (0%)
        all mutex API calls:     2122  (28.3%)
        --------------------------------------
        lock API calls:          7481 (100.0%)

with the -T9 kernel, which had the 'spread out' locking model, a
considerable portion of spinlocks were replaced by mutexes, but more
than 20% of usage was still spinlocks:

        spinlock API calls:      1835  (23.1%)
        | old mutex API calls:   2142  (26.9%)
        | new mutex API calls:   3961  (49.8%)
        all mutex API calls:     6103  (76.8%)
        --------------------------------------
        lock API calls:          7938 (100.0%)

here are some fresh numbers from Bill Huey's mmLinux kernel:

        spinlock API calls:      2452  (30.3%)
        all mutex API calls:     5614  (69.6%)
        --------------------------------------
        lock API calls:          8066 (100.0%)

(his mutex implementation directly falls back to up()/down() so the new
mutexes become part of the old mutexes.)

while i believe that the locking design is fundamentally incomplete in
the MontaVista kernel and thus is not directly comparable to
PREEMPT_REALTIME nor the mmLinux kernel, here are the stats from it
using a similar .config:

        spinlock API calls:      1444  (26.1%)
        | old mutex API calls:   2095  (37.9%)
        | new mutex API calls:   1981  (35.8%)
        all mutex API calls:     4076  (73.8%)
        --------------------------------------
        lock API calls:          5520 (100.0%)

(here it is visible that apparently a significant amount of [i believe
necessary] locking is missing from this kernel.)

finally, here are the stats from the new PREEMPT_REALTIME -U0 kernel:

        spinlock API calls:       491  (6.0%)
        | old mutex API calls:   2142  (26.2%)
        | new mutex API calls:   5536  (67.7%)
        all mutex API calls:     7678  (93.9%)
        --------------------------------------
        lock API calls:          8169 (100.0%)

note that almost all of the remaining spinlocks are held for a short
amount of time and have a finite maximum duration. They involve hardware
access, scheduling and interrupt handling and timers - almost all of
that code has O(1) characteristics.

what this means is that we are approaching hard-real-time domains ... 
using what is in essence the stock Linux kernel!

note that priority inheritance is still not part of this patch, but that
effort can now be centralized to the two basic Linux semaphore types,
solving the full spectrum of priority inheritance problems!

the code is still x86-only but only for practical reasons - other
architectures will be covered in the future as well.

to create a -U0 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0

	Ingo
