Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVJEQI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVJEQI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVJEQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:08:26 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:45564 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030204AbVJEQI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:08:26 -0400
Date: Wed, 5 Oct 2005 12:07:53 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051005155836.GA3626@elte.hu>
Message-ID: <Pine.LNX.4.58.0510051204170.23350@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
 <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
 <1128527319.13057.139.camel@tglx.tec.linutronix.de> <20051005155836.GA3626@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Ingo Molnar wrote:

>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > On Wed, 2005-10-05 at 10:29 -0400, Steven Rostedt wrote:
> > > Hmm, Ingo,
> > >
> > > Do you know why time goes backwards when I run hackbench as a realtime
> > > process?  I added the output of start and stop and it does seem to go
> > > backwards.
> > >
> > > Thomas?
> >
> > Yes. Thats happening. I moved the priority of softirq-timer above
> > hackbench priority and the problem goes away. I look into this
> > further.
>
> wouldnt hackbench then permanently starve run_timer_softirq(), and
> update_times() in particular?
>

It seems that the problem comes down to the call to getnstimeofday in
do_gettimeofday.

void getnstimeofday(struct timespec *ts)
{
	nsec_t delta;
	unsigned long seq;

	/* atomically read __monotonic_clock() */
	do {
		seq = read_seqbegin(&system_time_lock);

		delta = __monotonic_clock() - xtime_last_update;
		*ts = xtime_last_update_ts;

	} while (read_seqretry(&system_time_lock, seq));

	set_normalized_timespec(ts,
				ts->tv_sec,
				ts->tv_nsec + (long) delta);

}


I found that xtime_last_update is not updated while hackbench is running,
and the delta ends up being 16 billion and some change. So the call to
set_normalized_timespec overflows with the (long) delta.

-- Steve
