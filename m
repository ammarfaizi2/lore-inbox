Return-Path: <linux-kernel-owner+w=401wt.eu-S932701AbWLNMwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWLNMwN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWLNMwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:52:13 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59909 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701AbWLNMwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:52:12 -0500
Date: Thu, 14 Dec 2006 07:52:02 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: tike64 <tike64@yahoo.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt and arm
In-Reply-To: <297400.29698.qm@web59212.mail.re1.yahoo.com>
Message-ID: <Pine.LNX.4.58.0612140740480.17165@gandalf.stny.rr.com>
References: <297400.29698.qm@web59212.mail.re1.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, tike64 wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> > tike64 <tike64@yahoo.com> wrote:
> > > Ok, understood; I tried this:
> > >
> > > 	t = raw_timer();
> > > 	ts.tv_nsec = 5000000;
> > > 	ts.tv_sec = 0;
> > > 	nanosleep(&ts, 0);
> > > 	t = raw_timer() - t;
> > >
> > > It is better but I still see 8ms occasional delays when listing
> > > nfs-mounted directories onto FB. And, what is funny, also this
> > > version makes the average delay 20ms as if it made the jiffy 20ms.
> >
> > ARM has no high resolution timers support yet in the -rt tree.
>
> Yes, but is there a reason why the -rt patch seems to make the 10ms
> jiffy 20ms and why the jitter is so high. I don't need high resolution
> but reasonable, a couple of milliseconds, jitter.
>

OK, let me see if I get this right.  You have jiffies at 100HZ right? So
that means the timer needs to go off at 10ms intervals. So you are always
seeing a jiffy+1 delay?  Well this unfortunately has to happen, since it's
ok for the timer to be a little over, but it must never be a little under.
Lets add some ASCII graphics to this :)


         10ms      20ms          (n+10)ms     (n+11)ms
|---------+---------+---- .... ---+---------+--->
                 ^                  ^
               Start               End

OK, here we have a timer that should go off in (n)ms. We start between
10ms and 20ms (remember, our resolution is only 10ms).  If we just make
the timer go off at 10+n ms in the future, you get the above.  But notice,
that the Start was really closer to 20 than to 10, so the End really
didn't go off in (n)ms. It went off in less. So to solve this, we must add
one resolution time to the counter. So we make sure the timer goes off in
(n+1) ms, and not just (n).

Is this what you're seeing?

Note, even with high resolution timers, you still get a resolution+1 time.
But with high resolution timers, that resolution number is much smaller
than 10ms :)

-- Steve

