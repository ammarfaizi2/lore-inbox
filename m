Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbUKKLuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUKKLuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKKLuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:50:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63189 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262223AbUKKLua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:50:30 -0500
Date: Thu, 11 Nov 2004 13:51:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041111125128.GA25126@elte.hu>
References: <OFB20B576E.5695CD7C-ON86256F48.0050136F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB20B576E.5695CD7C-ON86256F48.0050136F@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> I was thinking about this problem this morning and was wondering if
> we could do something like an "end trigger" to help determine the cause
> of some of these pauses. Something like:
>  - start to fill / refresh the trace buffer (already doing this?)
>  - run RT CPU loop & sample TSC every 100 iterations or so
>  - if delta T exceeds 100 usec (or so), then set "end trigger" and
> dump the data from /proc/latency_trace.
> Repeat with some rate limit so we don't get too much data.

we had most of this in the tracer already, just obscured a bit.

In the current tree i've separated all the functionality into the
following flags: trace_enabled, trace_user_triggered, trace_freerunning.
When user_triggered is enabled all the other timing related tracing
activities stops (wakeup & critical/irq timing), and userspace is the
master of when tracing starts and stops. The way to turn the tracer
on/off is still the gettimeofday API hack:

	gettimeofday(0,1);
	gettimeofday(0,0);

i enhanced this user-defined tracing with a timing mechanism: the kernel
measures the latency between on and off and does the usual max-latency
or threshold tracking and saves the latency trace into
/proc/latency_trace only if the latency condition triggers. So userspace 
only has to add the start/stop hooks and the kernel will deal with the 
rest.

the freerunning flag can be used to generate traces where there's no
natural 'start' event, only some well-defined "we have a latency
problem" point. The application can start tracing at startup (or you can
start it via a different app), and it's enough to stop tracing when
there's a problem - the last ~4000 trace entries will be copied into
/proc/latency_trace. (the timing mechanism is still present in this mode
as well.)

(Freerunning mode can also be used if for some reason the delays are too
long to be fully traced and if the 'interesting' stuff is at the end of
the delay.)

This stuff will show up in the next release, later today. It should
cover the needs that your tests have at the moment, correct? 

	Ingo
