Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUK2Oe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUK2Oe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 09:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUK2Oe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 09:34:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32200 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261287AbUK2OeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 09:34:24 -0500
Date: Mon, 29 Nov 2004 15:33:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041129143316.GA3746@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> > the trace buffer is too small to capture a significant portion of the
> > xrun - i'd suggest for you to increase it from 4096-1 to 4096*16-1, to
> > be able to capture a couple of hundreds of millisecs worth of traces.
> >
> 
> and how I do that? Is it some /proc magic or its in the kernel configuration?

it's the MAX_TRACE define in kernel/latency.c.

but please try to the -31-10 kernel that i've just uploaded, it has a
number of tracer enhancements:

 - process name tracking. The new format is:

    bash- 3633 80000003 0.264ms (+0.000ms): idle_cpu (wake_idle)
    bash- 3633 80000003 0.264ms (+0.000ms): idle_cpu (wake_idle)
    bash- 3633 80000003 0.264ms (+0.000ms): find_next_bit (wake_idle)

  this makes it easier to identify which process does what. This feature 
  has no significant overhead in the tracer itself, all the hard work is
  done when /proc/latency_trace is read by the user.

 - /proc/sys/kernel/mcount_enabled flag: if disabled then 
   /proc/latency_trace will only contain 'custom' events, but no 
   per-function entries. This can be useful to trace really long 
   latencies, to get a rough idea of what is going on.

 - /proc/latency_trace atomicity. It was fundamentally non-atomic, due 
   to it being a 4K-granular file interface. Now the kernel has a second
   layer of saved-trace logic, which makes sure that the only time the
   trace is switched is when the header of the trace is read. I.e. when
   cp-ing or cat-ing /proc/latency_trace, no new trace info will be
   used. This change could solve some of the 'truncated traces'
   weirdnesses reported.

	Ingo
