Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVAZFXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVAZFXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 00:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVAZFXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 00:23:32 -0500
Received: from mail.joq.us ([67.65.12.105]:13004 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262284AbVAZFWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 00:22:40 -0500
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
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 25 Jan 2005 23:24:19 -0600
Message-ID: <87sm4opxto.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> pretty much the only criticism of the RT-CPU patch was that the global
> sysctl is too rigid and that it doesnt allow privileged tasks to ignore
> the limit. I've uploaded a new RT-CPU-limit patch that solves this
> problem:
>
>   http://redhat.com/~mingo/rt-limit-patches/
>
> i've removed the global sysctl and implemented a new rlimit,
> RT_CPU_RATIO: the maximum amount of CPU time RT tasks may use, in
> percent. For testing purposes it defaults to 80%.

Small terminology quibble: `ratio' sounds like a fraction, not a
percentage.  Since it really is a percentage, why not call it
RLIMIT_RT_CPU_PERCENT, or (maybe better) just RLIMIT_RT_CPU?

Does getrusage() return anything for this?  How can a field be added
to the rusage struct without breaking binary compatibility?  Can we
assume that no programs ever use sizeof(struct rusage)?

> the RT-limit being an rlimit makes it much more configurable: root tasks
> can have unlimited CPU time limit, while users could have a more
> conservative setting of say 30%. This also makes it per-process and
> runtime configurable as well. The scheduler will instantly act upon any
> new RT_CPU_RATIO rlimit.

I'm having trouble coming up with reasons why this is better than the
previous (rt_cpu_limit) solution, which was so much simpler and easier
to explain.

I can imagine defining per-user limits based on membership in groups
like `audio', `video' or `cdrom'.  While logical, I'm having trouble
thinking of usage scenarios where it makes any practical difference.

What problem(s) are we trying to solve with this rlimits field?

> multiple tasks can have different rlimits as well, and the scheduler
> interprets it the following way: it maintains a per-CPU "RT CPU use"
> load-average value and compares it against the per-task rlimit. If e.g. 
> the task says "i'm in the 60% range" and the current average is 70%,
> then the scheduler delays this RT task - if the next task has an 80%
> rlimit then it will be allowed to run. This logic is straightforward and
> can be used as a further control mechanism against runaway highprio RT
> tasks.

I can almost understand how this works, but not quite.  I guess I need
to read the code.  You're trying to selectively throttle certain tasks
and not others, right?  But, the limit they're hitting is system
global.

My main conceptual difficulty is driven by the fact that "realtime" is
actually a system attribute.  Factors such as hardware, kernel, device
drivers, applications, and system configuration all contribute to it
and can all screw it up.

So, what does it mean for a task to say "I'm in the 60% range"?  That
it individually will never use more than 60% of any one CPU?  Or, that
it and several other associated tasks will never use more than that?

> other properties of the RT_CPU_RATIO rlimit:
>
>  - a zero RLIMIT_RT_CPU_RATIO value means unlimited CPU time to that
>    RT task. If the task is not an RT task then it may not change to RT
>    priority. (i.e. a zero value makes it fully compatible with previous
>    RT scheduling semantics.)

What about root, or CAP_SYS_NICE?

>  - the CPU-use measurement code has a 'memory' of roughly 300 msecs.
>    I.e. if an RT task runs 100 msecs nonstop then it will increase
>    its CPU use by about 30%. This should be fast enough for users for
>    the limit to be human-inperceptible, but slow enough to allow
>    occasional longer timeslices to RT tasks.

So, at 80% I get 240 msecs out of every 300?  If I use them all up, do
I then have to wait 60 msecs before getting scheduled again?
-- 
  joq
