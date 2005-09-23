Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIWGtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIWGtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVIWGtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:49:35 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41610
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750715AbVIWGtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:49:35 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509230151080.3743@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
	 <Pine.LNX.4.61.0509230151080.3743@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 23 Sep 2005 08:49:57 +0200
Message-Id: <1127458197.24044.726.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 02:25 +0200, Roman Zippel wrote:
> > Maybe it would make sense to have the API be in nanoseconds and internally use
> > 32bit ms for now, and only change to 64bit nanos when we actually move to
> > sub-ms resolution timers.
> 
> Actually the decision to use ns has nothing to do with API issues. 
> <linux/jiffies.h> has already a lot of options to specify timeouts for 
> kernel timer. The official userspace API is mostly timespec/timeval.
> The nsec_t type is an _internal_ type to manage time, so this makes it 
> possible to do something like this:
> 
> #ifdef CONFIG_HIRES_TIMER
> typedef u64 ktime_t;
> #else
> typedef u32 ktime_t;
> #endif

Sure that's possible, but the 32bit storage format has its limitiations
and it is not possible to keep the code compatible for both use cases.

Posix timers - both CLOCK_REALTIME and CLOCK_MONOTONIC - can be
programmed in absolute time. In a 32bit representation with ms
resolution we can store ~49 days, so we can not fit the value which come
up from user space wihtout correction/conversion except we limit the use
cases to 49 days uptime and clock realtime < 49days since the epoch.

If we can not fit the given value into the internal representation, we
have to do exactly what the current implementation of clock realtime in
posix-timers.c has to do. Storing information about xtime / monotonic
offset, adding the timer to yet another list (abs_list) convert to
jiffies and in case the clock gets set, run through all the affected
timers in abs_list recalculate the expiry value and requeue them.

The idea of ktimers is to use the requested time given by a timespec in
human time without any corrections, so we actually can avoid the above.

Also doing time ordered insertion into a list introduces incompabilities
between 32/64 bit storage formats.

I carefully waged the necessary quirk load vs. the cleanliness,
simplicity and robustness of a pure 64 bit implementation. The resulting
payload for 32bit systems, which is in the range of 1-3 instructions per
fast path operation (add, sub, compare) is not worth the trouble IMO to
give up a clean, simple and robust design, which also allows high
resolution timers with no big change to the base implementation.


tglx


