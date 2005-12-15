Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVLOOSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLOOSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVLOOSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:18:39 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62445 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750700AbVLOOSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:18:39 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <1134599444.2542.76.camel@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>
	 <1134405768.4205.190.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512140101410.1609@scrub.home>
	 <1134599444.2542.76.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 09:18:15 -0500
Message-Id: <1134656295.13138.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 23:30 +0100, Thomas Gleixner wrote:

> > 
> > I don't think that's enough (unless I missed something). Steven maybe 
> > explained it better than I did in
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113047529313935
> 
> Steven said:
> 
> > Interesting though, I tried to force this scenario, by changing the
> > base->get_time to return jiffies.  I have a jitter test and ran this
> > several times, and I could never get it to expire early.  I even changed
> > HZ back to 100.
> > 
> > Then I looked at run_ktimer_queue.  And here we have the compare:
> > 
> > 		timer = list_entry(base->pending.next, struct ktimer, list);
> > 		if (ktime_cmp(now, <=, timer->expires))
> > 			break;
> > 
> > So, the timer does _not_ get processed if it is after or _equal_ to the
> > current time.  So although the timer may go off early, the expired queue
> > does not get executed.  So the above example would not go off at 3.2,
> > but some time in the 4 category
> 
> Again, I'm not able to find the problem. 
> 
> while(timers_pending()) {
> 	timer = getnext_timer();
> 	if (timer->expires > now)
> 		break;
> 	execute_callback();
> }
> 
> Please elaborate how the timer can expire early.

Actually Thomas, the above code doesn't handle it correctly, although,
the code you have in hrtimer.c does.  Here you say ">" where it should
be ">=", otherwise you can have the affect that I explained in the
reference that Roman stated.

Although run_hrtimer_queue is still correct, I think you might want to
change the hrtimer_forward.  It has a ">" where it should be ">=".

-- Steve


