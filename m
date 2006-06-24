Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWFXWbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWFXWbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFXWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:31:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53889 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751134AbWFXWbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:31:09 -0400
Subject: Re: More weird latency trace output (was Re: 2.6.17-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060624221235.GA23423@elte.hu>
References: <20060618070641.GA6759@elte.hu>
	 <1150937848.2754.379.camel@mindpipe> <1150944663.2754.416.camel@mindpipe>
	 <1151025892.17952.32.camel@mindpipe> <1151187320.2931.191.camel@mindpipe>
	 <20060624221235.GA23423@elte.hu>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 18:31:01 -0400
Message-Id: <1151188262.2931.201.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 00:12 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Thu, 2006-06-22 at 21:24 -0400, Lee Revell wrote:
> > > On Wed, 2006-06-21 at 22:51 -0400, Lee Revell wrote:
> > > > How can the latency tracer be reporting 1898us max latency while the
> > > > trace is of a 12us latency?  This must be a bug, correct?
> > > 
> > > I've found the bug.  The latency tracer uses get_cycles() for
> > > timestamping, which uses rdtsc, which is unusable for timing on dual
> > > core AMD64 machines due to the well known "unsynced TSCs" hardware bug.
> > > 
> > > Would a patch to convert the latency tracer to use gettimeofday() be
> > > acceptable?
> > 
> > OK, I tried that and it oopses on boot - presumably the latency tracer 
> > runs before clocksource infrastructure is initialized.
> > 
> > Does anyone have any suggestions at all as to what a proper solution 
> > would look like?  Is no one interested in this problem?
> 
> does it get better if you boot with idle=poll? [that could work around 
> the rdtsc drifting problem] Calling gettimeofday() from within the 
> tracer is close to impossible - way too many opportunities for 
> recursion. It's also pretty slow that way.

Probably, but that seems like an extremely heavy solution.  Won't it
turn my box into a space heater?

I'm thinking of replacing get_cycles() with low level code to just read
the PM timer.  I can deal with the slowness, this is just a debug
feature after all.

It seems that there might be a solution involving per CPU data, but I'm
not nearly a good enough kernel hacker to attempt that.

(I hope AMD fixes this issue in a future generation of CPUs.  At least,
they seem to acknowledge that it's a bug...)

Lee

