Return-Path: <linux-kernel-owner+w=401wt.eu-S932328AbXAGCJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbXAGCJN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXAGCJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:09:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47921 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328AbXAGCJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:09:11 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] HZ free ntp
Date: Sat, 6 Jan 2007 17:56:20 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org> <1167767185.3141.15.camel@localhost> <1167771052.3141.32.camel@localhost>
In-Reply-To: <1167771052.3141.32.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061756.20470.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 02 January 2007 21:50, john stultz wrote:

> > > It should be called every NTP_INTERVAL_FREQ times, but occasionally
> > > it's off
>
> Wait, so second_overflow should be called every NTP_INTERVAL_FREQ times
> (instead of every second)? Surely that's not right.

But it is, that's the reason the various adjustment values are divided by it, 
so they are applied to the next NTP_INTERVAL_FREQ times.

BTW I think NTP_INTERVAL_FREQ isn't the right name, CLOCK_UPDATE_FREQ would be 
a better name, currently ntp is the main user, but a clock can also be 
updated via other means (e.g. adjtimex or another clock).

> > > So in this case the loop in update_wall_time() should rather look like
> > > this:
> > >
> > > 	while (offset >= clock->cycle_interval) {
> > > 		...
> > > 		second_overflow();
> > > 		while (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
> > > 			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
> > > 			xtime.tv_sec++;
> > > 		}
> > > 		...
> > > 	}
> > >
> > > (Also note the change from "if" to "while".)
>
> This would assume that clock->cycle_interval would *always* be the
> length of a full second and that isn't what the patch trying to do.
>
> Maybe could you explain this some more?

As I said this was the case for a value of one.
Anyway, to avoid these problems, I'd prefer to keep it at least at 2 or better 
at 4. This would still drastically reduce the time spent in the loop and we 
can revisit the issue later.

bye, Roman
