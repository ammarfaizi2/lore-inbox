Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVAZHFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVAZHFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVAZHFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:05:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4306 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262369AbVAZHFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:05:33 -0500
Date: Wed, 26 Jan 2005 08:04:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050126070404.GA27280@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm4opxto.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> >   http://redhat.com/~mingo/rt-limit-patches/
> >
> > i've removed the global sysctl and implemented a new rlimit,
> > RT_CPU_RATIO: the maximum amount of CPU time RT tasks may use, in
> > percent. For testing purposes it defaults to 80%.
> 
> Small terminology quibble: `ratio' sounds like a fraction, not a
> percentage.  Since it really is a percentage, why not call it
> RLIMIT_RT_CPU_PERCENT, or (maybe better) just RLIMIT_RT_CPU?

yeah, makes sense. I've uploaded the -D5 patch, which has the following 
changes:

 - renamed the rlimit to RLIMIT_RT_CPU

 - exported the current RT-average value to /proc/stat (it's the last 
   field in the cpu lines)

> Does getrusage() return anything for this?  How can a field be added
> to the rusage struct without breaking binary compatibility?  Can we
> assume that no programs ever use sizeof(struct rusage)?

rlimits are easily extended and there are no binary compatibility
worries. The kernel doesnt export the maximum towards userspace. 
getrusage() will return the value on new kernels and will return -EINVAL
on old kernels, so new userspace can deal with this accordingly.

> I can imagine defining per-user limits based on membership in groups
> like `audio', `video' or `cdrom'.  While logical, I'm having trouble
> thinking of usage scenarios where it makes any practical difference.

e.g. the issue Con and others raised: privileged tasks. By default, the
root user will likely have a 0 rlimit, for compatibility. _But_ i can
easily imagine users wanting to put in a safety limit even for
root-owned RT tasks by making the rlimit 98% or so. Nonprivileged users
would have this rlimit at say 20% in a typical desktop distribution.

> > multiple tasks can have different rlimits as well, and the scheduler
> > interprets it the following way: it maintains a per-CPU "RT CPU use"
> > load-average value and compares it against the per-task rlimit. If e.g. 
> > the task says "i'm in the 60% range" and the current average is 70%,
> > then the scheduler delays this RT task - if the next task has an 80%
> > rlimit then it will be allowed to run. This logic is straightforward and
> > can be used as a further control mechanism against runaway highprio RT
> > tasks.
> 
> I can almost understand how this works, but not quite.  I guess I need
> to read the code.  You're trying to selectively throttle certain tasks
> and not others, right? [...]

correct.

> [...] But, the limit they're hitting is system global.

no, the limit is per-task. It is the _current CPU average_, measured by
the scheduler, that is global. (well, on SMP: "per-CPU global".) This
means that the scheduler knows all the time the percentage of time RT
tasks use up. If it's say 76%, and the rlimit of the _current task_ is
at 90% then this task will be allowed to run. (up to the point the
average reaches 90%.) If this task finishes running, and another RT task
would like to run, and we are still at a 76% RT-average, and that new
task has a 60% rlimit, then the scheduler will not allow the new task to
run. Only tasks that are SCHED_OTHER, or have a higher RT rlimit than
the current average will be allowed to run. [except if there are no
SCHED_OTHER tasks, in which case all tasks are allowed to run.]

> So, what does it mean for a task to say "I'm in the 60% range"?  That
> it individually will never use more than 60% of any one CPU?  Or, that
> it and several other associated tasks will never use more than that?

it means that it will only be allowed to run if the CPU utilization of
all RT tasks (eligible to run) do not exceed 60%.

> > other properties of the RT_CPU_RATIO rlimit:
> >
> >  - a zero RLIMIT_RT_CPU_RATIO value means unlimited CPU time to that
> >    RT task. If the task is not an RT task then it may not change to RT
> >    priority. (i.e. a zero value makes it fully compatible with previous
> >    RT scheduling semantics.)
> 
> What about root, or CAP_SYS_NICE?

what do you mean? root can change its own rlimit if it wants to, but
there is no special hack to allow root/CAP_SYS_NICE tasks to get
unlimited RT CPU time. That would make it impossible for a privileged
task to make use of this feature.

> >  - the CPU-use measurement code has a 'memory' of roughly 300 msecs.
> >    I.e. if an RT task runs 100 msecs nonstop then it will increase
> >    its CPU use by about 30%. This should be fast enough for users for
> >    the limit to be human-inperceptible, but slow enough to allow
> >    occasional longer timeslices to RT tasks.
> 
> So, at 80% I get 240 msecs out of every 300?  If I use them all up, do
> I then have to wait 60 msecs before getting scheduled again?

it's implemented as a decayling average. The 300 msecs means that if the
current RT average is at 100%, and suddenly every RT task stops running
(i.e. the average will decrease as fast as it can), then it will reach
5% in 300 msecs.

the same goes in the other direction: it needs roughly 300 msecs for the
average to go from 0% to 100%.

yes, even though the way it increases is not linear, you can expect the
average to increase if you run for 'too long' - where 'too long' is
roughly (percentage * 300msecs). I.e. if you have it at 80% then you
should expect the limit to kick in after running for 240 msecs. This
shouldnt be a practical issue, unless an RT application has a very
'choppy' workload (processing for 1 second, then sleeping for 1 second,
etc.) - in which case it needs an increased limit. There obviously must
be some sort of boundary where the scheduler says 'this is enough'.

	Ingo
