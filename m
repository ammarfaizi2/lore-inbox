Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272526AbTGaQIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272516AbTGaQGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:06:40 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:5830
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272513AbTGaQG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:06:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm1 results
Date: Fri, 1 Aug 2003 02:11:02 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <200308010135.57514.kernel@kolivas.org> <61330000.1059667311@[10.10.2.4]>
In-Reply-To: <61330000.1059667311@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308010211.02246.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003 02:01, Martin J. Bligh wrote:
> > On Fri, 1 Aug 2003 01:19, Martin J. Bligh wrote:
> >> >> Does this help interactivity a lot, or was it just an experiment?
> >> >> Perhaps it could be less agressive or something?
> >> >
> >> > Well basically this is a side effect of selecting out the correct cpu
> >> > hogs in the interactivity estimator. It seems to be working ;-) The
> >> > more cpu hogs they are the lower dynamic priority (higher number) they
> >> > get, and the more likely they are to be removed from the active array
> >> > if they use up their full timeslice. The scheduler in it's current
> >> > form costs more to resurrect things from the expired array and restart
> >> > them, and the cpu hogs will have to wait till other less cpu hogging
> >> > tasks run.
> >> >
> >> > How do we get around this? I'll be brave here and say I'm not sure we
> >> > need to, as cpu hogs have a knack of slowing things down for everyone,
> >> > and it is best not just for interactivity for this to happen, but for
> >> > fairness.
> >> >
> >> > I suspect a lot of people will have something to say on this one...
> >>
> >> Well, what you want to do is prioritise interactive tasks over cpu hogs.
> >> What *seems* to be happening is you're just switching between cpu hogs
> >> more ... that doesn't help anyone really. I don't have an easy answer
> >> for how to fix that, but it doesn't seem desireable to me - we need some
> >> better way of working out what's interactive, and what's not.
> >
> > Indeed and now that I've thought about it some more, there are 2 other
> > possible contributors
> >
> > 1. Tasks also round robin at 25ms. Ingo said he's not sure if that's too
> > low, and it definitely drops throughput measurably but slightly.
> > A simple experiment is changing the timeslice granularity in sched.c and
> > see if that fixes it to see if that's the cause.
> >
> > 2. Tasks waiting for 1 second are considered starved, so cpu hogs running
> > with their full timeslice used up when something is waiting that long
> > will be expired. That used to be 10 seconds.
> > Changing starvation limit will show if that contributes.
>
> Ah. If I'm doing a full "make -j" I have almost 100 tasks per cpu.
> if it's 25ms or 100ms timeslice that's 2.5 or 10s to complete the
> timeslice. Won't that make *everyone* seem starved? Not sure that's
> a good idea ... reminds me of Dilbert: "we're going to focus particularly
> on ... everything!" ;-)

The starvation thingy is also dependent on number of running tasks.

I quote from the master engineer Ingo's codebook:

#define EXPIRED_STARVING(rq) \
		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
		(jiffies - (rq)->expired_timestamp >= \
			STARVATION_LIMIT * ((rq)->nr_running) + 1)))

Where STARVATION_LIMIT is 1 second.

Con

