Return-Path: <linux-kernel-owner+w=401wt.eu-S1755405AbXABUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbXABUzX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755408AbXABUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:55:23 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51090 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405AbXABUzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:55:22 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1167767185.3141.15.camel@localhost>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <1166578357.5594.3.camel@localhost> <1166579658.5594.6.camel@localhost>
	 <200701011929.28546.zippel@linux-m68k.org>
	 <1167767185.3141.15.camel@localhost>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 12:50:52 -0800
Message-Id: <1167771052.3141.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 11:46 -0800, john stultz wrote:
> On Mon, 2007-01-01 at 19:29 +0100, Roman Zippel wrote:
> > On Wednesday 20 December 2006 02:54, john stultz wrote:
> > 
> > > And here would be the follow on patch (again *untested*) for
> > > CONFIG_NO_HZ slowing the time accumulation down to once per second.
> > 
> > Changing it to one creates a potential problem with calling second_overflow().

Wait, at first I thought I understood this, but looking closer, I'm not
so sure I do.

> > It should be called every NTP_INTERVAL_FREQ times, but occasionally it's off

Wait, so second_overflow should be called every NTP_INTERVAL_FREQ times
(instead of every second)? Surely that's not right.

> > by one (when xtime is close to a full second and the tick length is different
> > from 1sec). At a higher frequency that's not much of a problem, but at one it
> > means second_overflow() is occasionally called twice a second or skipped for
> > a second. Usually the error should be quite small, but sometimes it can be
> > significant.
> > So in this case the loop in update_wall_time() should rather look like this:
> > 
> > 	while (offset >= clock->cycle_interval) {
> > 		...
> > 		second_overflow();
> > 		while (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
> > 			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
> > 			xtime.tv_sec++;
> > 		}
> > 		...
> > 	}
> > 
> > (Also note the change from "if" to "while".)

This would assume that clock->cycle_interval would *always* be the
length of a full second and that isn't what the patch trying to do.

Maybe could you explain this some more?

thanks
-john


