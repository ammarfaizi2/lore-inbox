Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWBNByA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWBNByA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBNByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:54:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:55944 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWBNBx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:53:59 -0500
Subject: Re: [BUG -rt] -rt16 hang w/ realtime thread test
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
References: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 17:53:46 -0800
Message-Id: <1139882031.28536.135.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 10:34 -0500, Steven Rostedt wrote:
> On Fri, 10 Feb 2006, john stultz wrote:
> 
> > Hey Ingo,
> > 	I've been hunting a report that lower priority realtime threads are not
> > preempting higher priority realtime threads. However, in generating test
> > cases, I found I was locking the system quite frequently.
> >
> > The attached test runs to completion on 2.6.15, but with 2.6.15-rt16, it
> > hangs the box. It could very well be a test issue, but I'm not sure I
> > see where the problem is.
> >
> 
> Hi John,
> 
> Have you turned on nmi_watchdog and softlockup detect?  Just so we can see
> where it is hung.

Ugh. Ok, I think I've found the issue.

The systems I'm testing w/ all use the ACPI PM timer for the
clocksource. On a whim I forced the TSC to be used and the hang went
away.

It appears the issue is that the ACPI PM wraps every ~5 seconds.  Since
the test takes longer the 5 seconds to run, the
timeofday_periodic_hook() function gets starved and we never accumulate
time. Then as the counter wraps, time starts wrapping thus timers do not
expire and the test never completes, effectively hanging the box.

I believe this issue was hit before back when cycle_t was 32bits long,
thus causing the TSC to wrap every ~4seconds on a 1Ghz box.

So whats the solution here? Do we need to do something to
timeofday_periodic_hook is guaranteed to run with some frequency? Or is
the test just bunk because realtime threads must give up the cpu in
order for the kernel to function?

Thoughts?
-john



