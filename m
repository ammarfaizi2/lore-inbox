Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUJLFtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUJLFtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 01:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269468AbUJLFtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 01:49:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17337 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269467AbUJLFs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 01:48:59 -0400
Date: Tue, 12 Oct 2004 07:50:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012055029.GB1479@elte.hu>
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven Dietrich <sdietrich@mvista.com> wrote:

> > But, there is a 'correctness' _minimum_ set of spinlocks that _must_ be
> > raw spinlocks - this i tried to map in the -T4 patch. The patch does run
> > on SMP systems for example. (it was developed as an SMP kernel - in fact
> > i never compiled it as UP :-|.) If code has per-CPU or preemption
> > assumptions then there is no choice but to make it a raw spinlock, until
> > those assumptions are fixed.

> The grunt work is in identifying those problem areas and coming up
> with elegant, low-impact solutions. RCU locks is one example as
> mentioned before. We had a fix to serialize RCU access, but weren't
> happy with that. We were hoping to get some input on this, but these
> problems seem to show up more readily on slow systems (we are also
> testing with a bunch of old P1, P2 and K6 boxes all far sub 1 GHz)

identifying problem areas is near 100% automatic if you look at -T5: all
illegal sleeps and illegal smp_processor_id() assumptions are reported
when they happen. That's how i identified & fixed the core 90 locks in
the first wave, in just a couple of hours. The only minor annoyance when
doing a conversion is the inflexibility of SPIN_LOCK_UNLOCKED and
RW_LOCK_UNLOCKED initializer. If it werent for the initializers then a
'conversion' would be a matter of a 2-line change, the change of the
prototype and the change of the definition. Now it's a 3-line change
most of the time - still very fast and painless.

regarding RCU serialization - i think that is the way to go - i dont
think there is any sensible way to extend RCU to a fully preempted
model, RCU is all about per-CPU-ness and per-CPU-ness is quite limited 
in a fully preemptible model.

could you send those RCU patches (no matter how incomplete/broken)? It's
the main issue that causes the dcache_lock to be raw still. (and a
number of dependent locks: fs-writeback.c, inode.c, etc.) We can make
those RCU changes not impact the normal !PREEMPT_REALTIME locking so it
might have a chance for upstream merging as well.

> I was making this observation: One can't look at an arbitrary piece of
> code and tell if it will be a spinlock or a mutex. One has to go look
> elsewhere. In the spin_undefs case one can look the top of the file
> and check for it, in the LOCK_OPS case, you have to call up the data
> structure declaration.

ok, i now understand what you mean. The way i drove it wasnt really via
code review but via: 'compile kernel, look at the bootlogs, fix the
first lock reported, repeat' iterations. This was much easier and much
more reliable than trying to figure out lock dependencies from the
source. The turnaround for a single lock was 2-3 minutes in the typical
case, allowing the conversion of 90 locks in a couple of hours.

> > > There are a whole lot of caveats and race conditions that have not yet
> > > been unearthed by the brief LKML testing. [...]
> > 
> > actually, have you tried your patchset on an SMP box? As far as i can
> > see the locking in it ignores SMP issues _completely_, which makes the
> > choice of locks much less useful.
> 
> We stated that its been tested minimally on SMP. That means we have
> had it up and running and found it to be unstable. I fully agree that
> SMP is the superset to get it working on, and that PMutex is not
> perfect at this point.

it's not just the problem of PMutex - i believe it's mainly the plain
inadequacy of the 30 raw locks you have identified - and identifying the
locks is the bigger work, not the semaphore implementation. I'm now at
90 locks (20% of all locking in this .config) and that's just to quiet
the DEBUG_PREEMPT violations on my testboxes.

and no matter how well UP works, to fix SMP one has to 'cover' all the
necessary locks first before fixing it, which (drastic) increase in raw
locks invalidates most of the UP efforts of getting rid of raw locks. 
That's why i decided to go for SMP primarily - didnt see much point in
going for UP.

> We will take a look at the T5 patch and see what we can do about PI
> for the system semaphore, but I am not sure how portable it would be
> without also touching the assembly. FWIW PMutex is already based in
> part on the system semaphore, so we might get similar problems when
> porting elsewhere.

there are in-C variants of Linux mutexes and rw-semaphores in the kernel
source, so worst-case we could just make use of them in the
PREEMPT_REALTIME case. I'm not a big fan of assembly optimizations (or
having to touch assembly optimizations) at an early stage like this.

	Ingo
