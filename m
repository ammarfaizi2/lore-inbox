Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVA0ASI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVA0ASI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVA0ARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:17:23 -0500
Received: from mail.joq.us ([67.65.12.105]:64954 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262468AbVAZW0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:26:23 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 16:27:23 -0600
In-Reply-To: <20050126070404.GA27280@elte.hu> (Ingo Molnar's message of
 "Wed, 26 Jan 2005 08:04:04 +0100")
Message-ID: <87fz0neshg.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

>  - exported the current RT-average value to /proc/stat (it's the last 
>    field in the cpu lines)

> e.g. the issue Con and others raised: privileged tasks. By default, the
> root user will likely have a 0 rlimit, for compatibility. _But_ i can
> easily imagine users wanting to put in a safety limit even for
> root-owned RT tasks by making the rlimit 98% or so. Nonprivileged users
> would have this rlimit at say 20% in a typical desktop distribution.

That seems rather small.  CPU starvation is not generally much of a
problem on desktop machines.  If that (single) user wants to eat up
70% or 80% of the CPU, that's not likely to be a problem.  Mac OS X
allows 90% on their desktop systems.

>> So, what does it mean for a task to say "I'm in the 60% range"?  That
>> it individually will never use more than 60% of any one CPU?  Or, that
>> it and several other associated tasks will never use more than that?
>
> it means that it will only be allowed to run if the CPU utilization of
> all RT tasks (eligible to run) do not exceed 60%.

But how would people use it?

There are many RT application scenarios I don't know about, and
probably some more I'm forgetting at the moment.  But, I do have at
least one user-oriented view of the problem.  Perhaps others will
mention additional scenarios based on their own experience.

My initial reaction is that the kind of priority-based SCHED_FIFO and
SCHED_RR techniques we're providing (i.e. POSIX realtime) really only
supports one set of at least loosely cooperating RT threads.  For
multiple, non-cooperating RT subsystems, one needs something more like
a deadline scheduler.  That would be a nice project for someone to
work on, but we are definitely *not* asking for it here.

Priority-based RT thread cooperation generally involves a "realtime
pyramid".  A thread with a short trigger latency needs to run at high
priority, near the top of the pyramid.  It must do its job quickly to
avoid delaying the lower-priority threads.  So, high priority
generally imposes a tight pathlength restriction.  Threads at the base
of the pyramid can run longer, but have longer trigger latencies due
to the number and worst-case pathlengths of the layers above them.
You can even think of IRQ handlers as occupying "special" hardware
scheduled priorities at the apex of the pyramid.

But, rlimits is per-process, not per-thread (right??).  So, the whole
RT subsystem is going to end up needing to share a single, overall
RLIMIT_RT_CPU value.  This makes rlimits a rather poor fit for the
purpose.  I could imagine limiting CPU use per priority level (not per
process), with the kernel helping to enforce the realtime priority
pyramid directly, restricting higher priorities to fewer cycles.  But,
I have no well thought out proposal like that (as yet).

So apparently, this clumsy rlimits mechanism is really only going to
store two or three different values for every process in the system,
for example: (1) 0% for ordinary processes, (2) 80% for desktop audio
and video users, and (3) 98% for root and perhaps a few other
privileged processes.  I probably still don't understand exactly how
these work, but does anyone seriously expect there to be more?

> yes, even though the way it increases is not linear, you can expect the
> average to increase if you run for 'too long' - where 'too long' is
> roughly (percentage * 300msecs). I.e. if you have it at 80% then you
> should expect the limit to kick in after running for 240 msecs. This
> shouldnt be a practical issue, unless an RT application has a very
> 'choppy' workload (processing for 1 second, then sleeping for 1 second,
> etc.) - in which case it needs an increased limit. There obviously must
> be some sort of boundary where the scheduler says 'this is enough'.

This seems reasonable to me.  AFAIK, very few RT applications are
*that* intermittent.  Generally, there is some basic cycle in which
things get done.  Sometimes there are cycles within cycles.

I think I see a way to do graceful degradation with arbitrary shorter
RT cycles.  JACK currently watches its clients to detect when they
exceed the available cycle duration.  JACK could query its own
RLIMIT_RT_CPU value and use that percentage of the actual cycle time
as the time limit.  If this is exceeded, jackd would start shutting
down clients before the scheduler shuts down realtime operation
completely, thus (perhaps) avoiding a catastrophic failure of the
whole subsystem (like we saw in my tests).  Since it makes no sense
for the clients to run with a different RLIMIT_RT_CPU value, this
ought to work in practice.  Libjack could complain if a client with a
lower limit tried to connect.  Each JACK server only handles one user
at a time, anyway.

Will the scheduler support that approach?
-- 
  joq
