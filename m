Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVAYVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVAYVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAYVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:52:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14745 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262169AbVAYVt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:49:28 -0500
Date: Tue, 25 Jan 2005 22:49:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125214900.GA9421@elte.hu>
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oefdfaxp.fsf@sulphur.joq.us>
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

> At around 55 seconds into the run, JACK got in trouble and throttled
> itself back to approximately the 30% limit (actually a little above).
> Then, around second 240 it got in trouble again, this time collapsing
> completely.  I'm a bit confused by all the messages in that log, but
> it appears that approximately 9 of the 20 clients were evertually shut
> down by the JACK server.  It looks like the second collapse around 240
> also caused the scheduler to revoke RT privileges for the rest of the
> run (just a guess).

no, the scheduler doesnt revoke RT privileges, it just 'delays' RT tasks
that violate the threshold. In other words, SCHED_OTHER tasks will have
a higher effective priority than RT tasks, up until the CPU use average
drops below the limit again.

the effect is pretty similar to starting too many Jack clients - things
degrade quickly and _all_ clients start skipping, and the whole audio
experience escallates into a big xrun mess. Not much to be done about it
i suspect. Maybe if the current 'RT load' was available via /proc then
jackd could introduce some sort of threshold above which it would reject
new clients?

> JACK can probably do a better job of shutting down hyperactive
> realtime clients than the kernel, because it knows more about what the
> user is trying to do.  Multiplying incomprehesible rlimits values does
> not help much that I can see.

please debug this some more - the kernel certainly doesnt do anything
intrusive - the clients only get delayed for some time.

> Sometimes musicians want to "push the envelope" using CPU-hungry
> realtime effects like reverbs or Fourier Transforms.  It is often hard
> to predict how much of this sort of load a given system can handle.
> JACK reports its subsystem-wide "DSP load" as a moving average,
> allowing users to monitor it.  It might be helpful if the kernel's
> estimate of this number were also available somewhere (but maybe that
> value has no meaning to users).  Often, the easiest method is to push
> things to the breaking point, and then back off a bit.

yeah, i'll add this to /proc, so that utilities can access it. Jackd
could monitor it and refuse to start new clients if the RT load is
dangerously close to the limit (say within 10% of it)?

> The equivalent rlimits experiment probably requires:
> 
>   (1) editing /etc/security/limits.conf
>   (2) shutting everything down
>   (3) logout
>   (4) login
>   (5) restarting the test

well, there's setrlimit, so you could add a jackd client callback that
instructs all clients to change their RT_CPU_RATIO rlimit. In theory we
could try to add a new rlimit syscall that changes another task's rlimit
(right now the syscalls only allow the changing of the rlimit of the
current task) - that would enable utilities to change the rlimit of all
tasks in the system, achieving the equivalent of a global sysctl.

	Ingo
