Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVBAUon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVBAUon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVBAUon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:44:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4517 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262116AbVBAUoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:44:15 -0500
Date: Tue, 1 Feb 2005 21:44:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
Message-ID: <20050201204359.GA346@elte.hu>
References: <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net> <20050126080952.GC4771@elte.hu> <1107288076.18349.7.camel@krustophenia.net> <20050201201704.GA32139@elte.hu> <1107289878.18349.20.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107289878.18349.20.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> OK.  So for application triggered tracing you need LATENCY_TRACING
> enabled, as described here:
> 
> http://lkml.org/lkml/2004/10/29/312

correct, that too should still work fine - with the small change that
there's now a separate flag to active it:

	echo 1 > /proc/sys/kernel/trace_user_triggered  # default: 0

it is an orthogonal mechanism to atomicity-debugging.

since i wrote the above mail 3 months ago, a number of improvements have
been done to the tracer. There are a handful of modifier feature-flags
to the tracer, which can be used to get additional functionality. Here's
a quick summary:

	echo 1 > /proc/sys/kernel/trace_freerunning  # default: 0

will get a 'freerunning' tracer which never stops (and overwrites the
oldest entries if the trace gets full). Especially with long latencies 
this in some cases can be more informative.

this flag:

	echo 0 > /proc/sys/kernel/mcount_enabled  # default: 1

causes the tracer to record only key kernel events (schedule/wakeup
events, etc.), not every kernel function call. This might be useful if
you want to see the bigger picture and want to validate scheduling logic
on a bigger scale, spanning a much longer timeframe.

and if you have stability problems, this flag might be handy:

	echo 1 > /proc/sys/kernel/trace_freerunning  # default: 0

it will dump the current kernel trace to the kernel console if a crash
happens - obviously only useful with a serial console or netconsole. 
It's a big dump but can make some bugs much easier to debug.

on SMP:

	echo 1 > /proc/sys/kernel/trace_all_cpus  # default: 0

this flag will cause all activity from all CPUs to be included in the
trace. This can be useful if it is suspected that a particular latency
was caused not by the CPU where the latency triggers, but by some other
CPU.

	Ingo
