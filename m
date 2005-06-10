Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVFJPvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVFJPvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVFJPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:51:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:1228 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262580AbVFJPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:47:42 -0400
Date: Fri, 10 Jun 2005 08:47:46 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610154745.GA1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118372388.32270.6.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 10:59:48PM -0400, Lee Revell wrote:
> On Thu, 2005-06-09 at 16:50 -0700, Paul E. McKenney wrote:
> > On Thu, Jun 09, 2005 at 04:34:11PM -0700, Tim Bird wrote:
> > > Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > Midway through the recent "RT patch acceptance" thread, someone mentioned
> > > > that it might be good to summarize the various approaches.  The following
> > > > is an attempt to do just this, with an eye to providing a reasonable
> > > > framework for future discussion.
> > > > 
> > > > Thoughts?  Errors?  Omissions?
> > > 
> > > I haven't finished it, but it looks great so far.  Are you planning to
> > > repost it to LKML, or otherwise publish it somewhere, after incorporating
> > > feedback?
> > 
> > Glad you like it!
> > 
> > I figured on sending out an update sometime next week, after incorporating
> > feedback.
> 
> I believe you are too friendly to vanilla + CONFIG_PREEMPT.  People are
> still seeing tens or hundreds of ms bumps.

Good point -- I certainly need to add a disclaimer to the effect that
common hardware (such as VGA, last I checked some months ago) can
cause such bumps, as can long-running system calls.  Here is my updated
CONFIG_PREEMPT quality-of-service section:

a.	Quality of service: soft realtime, with timeframe of 100s of
	microseconds for task scheduling and interrupt handling, but
	-only- for very carefully restricted hardware configurations
	that exclude problematic devices and drivers (such as VGA)
	that can cause latency bumps of tens or even hundreds of
	milliseconds (-not- microseconds).  Furthermore, the software
	configuration of such systems must be carefully controlled,
	for example, doing a "kill -1" traverses the entire task list
	with tasklist_lock held (see kill_something_info()), which might
	result in disappointing latencies in systems with very large
	numbers of tasks.  System services providing I/O, networking,
	task creation, and VM manipulation can take much longer.  A very
	small performance penalty is exacted, since spinlocks and RCU
	must suppress preemption.

Does this help, or are there other CONFIG_PREEMPT latency issues that
need to be called out?

> Does the LTP include an RT latency test yet?

Not as far as I know.  I believe that LTP contains primarily pass-fail
rather than performance tests, but regardless of where RT latency
tests live, I believe that there needs to be a good home for them.

There are a number of RT latency tests that people run -- any nominations
for particularly good ones?  Should we be running lmbench at realtime
priority with 15 kernel builds in the background, measuring the
latency of each lmbench operation, in addition to running the existing
scheduler-latency tests?  (Sorry, couldn't resist!)

						Thanx, Paul
