Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUJ2IBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUJ2IBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbUJ2IBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:01:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59792 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261382AbUJ2IBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:01:42 -0400
Date: Fri, 29 Oct 2004 10:02:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029080247.GC30400@elte.hu>
References: <1099008264.4199.4.camel@krustophenia.net> <200410290057.i9T0v5I8011561@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410290057.i9T0v5I8011561@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> >how is the 'maximum delay' calculated? Could you put in a tracing hook
> >into jackd whenever such a ~720 usecs maximum is hit? I'd _love_ to see 
> >how such a latency path looks like, it seems a bit long.
> 
> "maximum delay" is computed like this:
> 
> 	 a) we know that jackd should be woken at regular, known
> 	    intervals based on the interrupt of the audio interface.
> 
> 	 b) jackd is (often) blocked in poll(2), waiting for the
> 	    audio interface to become readable+writable.
> 
> 	 c) on return from poll, we check the time we are returning
> 	    and compare it to the last wakeup. the difference should
> 	    be almost exactly the interrupt interval. 
> 
> 	 d) any amount larger than this is a delay caused by
> 	    kernel scheduling. we track the largest such delay.

there are multiple possibilities of how this ~700 usecs delay occured:

 - the kernel still has a wakeup bug. But this should be detected by the
   tracer which measures the time between when the task hits the
   runqueue and the task gets to execute on the CPU. Also, if there is a
   critical section in the kernel that is 700 usecs long it would be
   detected by _another_, independent timing/tracing mechanism that
   measures critical sections. The likelyhood of both the scheduler
   _and_ two independent kernel-tracers being buggy in the same way is
   quite significantly low. (not to mention the user-space amlat tool
   which seems to agree with the kernel instrumentation.)

note that currently the maximum delay reported by the tracer is around
20-30 usecs. It is nowhere near the 700 usecs measured here. Here are
some of the other latency possibilities:

 - ALSA latency bug: Jackd didnt get woken up in time. Or driver bug, it
   somehow didnt do the wakeup. I'd say this has pretty low probability
   as well since it would break for alot of other scenarios as well.

 - poll() latency bug: pretty low probability too. It's simple and does
   the wakeup immediately, and would be noticed by many people if this
   were buggy.

 - Jackd related latency: is the thread that waits in poll() _truly_ the 
   highest-prio task in the system? IIRC there is some other Jackd
   thread around too that has SCHED_FIFO priority 50, couldnt that 
   thread come in occasionally and delay the poll()-ing thread? Or, is 
   it 100% sure that the only processing the poll()-ing thread does is 
   waiting for the next interrupt and immediately and atomically
   handling it? If there is any delay (either due to processing
   overhead or due to unintended scheduling) then Jackd wont hit poll() 
   in time and could miss the next interrupt - and there's nothing the
   kernel can do about this. I know that Jackd does alot of precautions 
   to avoid unintentional scheduling (mlockall, the use of SCHED_FIFO), 
   but are you absolutely sure it doesnt happen? This scenario could be 
   excluded by measuring the time Jackd calls poll(), and comparing it
   to the expected value. [Or is this value already included in the 
   stats Rui collected? Maybe the "Maximum Process Cycle" value?]

but at this point i'd say that the likelyhood that the scheduler caused
this delay is pretty low - all of that codepath is instrumented and i
think we should instrument Jackd a bit more before putting the blame
back on the scheduler. So while ~3 months ago, when i started this
project, the blame was clearly on the kernel and on the scheduler, i'd
now say for the first time that this particular phenomenon is not
directly caused by it :-)

Could the kernel help some more in debugging this? E.g. if the Jackd
SCHED_FIFO thread (after it has started up) can never legitimately
reschedule except via poll(), i could try to put in a syscall hack in
where in the Jackd code you could call say gettimeofday(0,3) to turn on
'do not reschedule' mode, and call gettimeofday(0,4) to turn it off. If
Jackd reschedules while in 'do not reschedule' mode then the scheduler
code will detect this and will print out the offending user-space EIP
and a stacktrace. [and will turn off 'do-not schedule' mode.]

(i could even make it a clean scheduler feature and send a SIGBUS (or
any other alert signal) if this occurs, and implement a new syscall to
control it. I guess this could be useful to most RT applications. This
signal would only be sent if the RT task got scheduled voluntarily (i.e.
not delayed due to some even higher-prio task).)

> we block in poll(2), waiting for the interrupt from the audio
> interface to mark the relevant jackd thread as runnable.

ok, good. Not having signals involved certainly makes this simpler ;)

> i don't know what you mean by "channel" information in this context.

it was just a stupid question based on the ALSA source code, i assumed
that somehow you could have multiple audio streams [the driver called it
'voices'?] per driver, and the same interrupt comes for each stream. If
multiple streams are handled then there must be some sort of index to
find out where stream (or streams) got that particular interrupt, so
that Jackd can refill the proper output stream. I assumed (it seems
incorrectly) that when Rui ran 9 'fluidsynth' instances then Jackd would
open 9 'channels', one for each fludsynth instance?

but i suspect your comment means that there is a single 'output stream'
assembled by Jackd out of the 9 streams coming from the 9 fluidsynth
instances, with no concurrency issues on the driver level and the
SCHED_FIFO Jackd thread is the sole owner of that periodic interrupt,
and that there's no additional per-device information it needs to
associate it with each interrupt to ge to the current audio stream?
(i.e. there is only one output audio stream per device?)

and here i'm specifically concentrating on the scenario that Rui's
testing triggers: 9 fluidsynth instances running, and Jackd handling a
single ali5451 output device.

	Ingo
