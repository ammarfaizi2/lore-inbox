Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJROsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJROsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 10:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJROsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 10:48:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62947 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266459AbUJROsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 10:48:47 -0400
Date: Mon, 18 Oct 2004 16:50:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018145008.GA25707@elte.hu>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016153344.GA16766@elte.hu>
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


i have released the -U5 Real-Time Preemption patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5

this is a release intended to increase stability, but since it also
includes new debug features and related cleanups it might introduce new
regressions. Be careful.

there are two big changes:

 - debug feature: automatic semaphore/rwsem deadlock detection, based on
   the code from Igor Manyilov and Bill Huey.

this is a very nice feature that should help in debugging the remaining
deadlocks. The deadlock detection feature has already helped me fix a
bug that was causing hangs in the VFS, so it's really useful.

 - generic semaphore implementation

the generic semaphore implementation (which uses rwsems) makes it
possible to use the deadlock detection mechanism for all the mutex types
we currently have: semaphores, rw-semaphores, spinlock-mutexes and
rwlock-mutexes. Another benefit is that PREEMPT_REALTIME becomes much
more portable this way. (although it's still x86-only at the moment.)

other changes since -U4:

 - crash fix: fixed a possible "unbound recursion upon IRQ entry" bug.
   introduced preempt_schedule_irq() which now schedules without
   enabling interrupts again, preventing new IRQs from hitting this
   task again and triggering preemption. This might fix the
   'infinite stackdumps' problem Rui Nuno Capela was seeing.

 - deadlock fix: is_subdir()'s PREEMPT_REALTIME locking was buggy. This 
   could perhaps fix the other problem reported by Rui Nuno Capela.

 - i8253_lock fixes: apm, hd.c, gameport.c and analog.c were all 
   improperly importing the variable while overriding the prototype. 
   This fixes the bug reported by Florian Schmidt.

 - possible crash fix: one particular lock in selinux has to be 
   mutex-based, because while held it calls other mutex-using code.

 - two more selinux locks converted to raw spinlocks, because they were
   called from within raw-critical sections.

 - debug feature: enforce interrupts-enabled upon schedule().
   (Note that this does not break sleep_on() because sleep_on() does not
   disable interrupts in the PREEMPT_REALTIME mode. It might break with 
   !PREEMPT_REALTIME though.)

 - locking cleanup: converted the IPC code from raw spinlocks & RCU to
   spinlock-mutexes.

 - code cleanup: cleaned up the generic rwsem code.

 - debug feature: implemented /proc/sys/kernel/trace_verbose runtime
   flag (default:0), which enables a much more verbose printout in
   /proc/latency_trace.  This trace format can be useful in e.g. 
   debugging timestamp weirdnesses.

 - irqs-off fix: there was one codepath where irqd would call schedule() 
   with interrupts disabled.

 - debug feature: the NMI entries in the latency trace now also include 
   the last-observed-EFLAGS value. Can be useful in figuring out what a
   certain CPU is doing and why.

 - cleanup: fixed preemption-off ordering: often the spinlock (and 
   scheduler) code would re-enable preemption and interrupts in the
   wrong order, opening up a small window for an interrupt handler to
   fit in and increase the latency of that almost-finished critical
   section.

 - cleanup: consolidated various bug-printouts. It should now be easy to
   find whether anything bad happens even amongst lots of preempt-timing
   printouts: 'dmesg | grep BUG'.

to create a -U5 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5

	Ingo
