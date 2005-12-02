Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVLBCv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVLBCv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVLBCv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:51:57 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:44247 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964819AbVLBCv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:51:56 -0500
Subject: Re: [patch 00/43] ktimer reworked
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.61.0512020120180.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512010118200.1609@scrub.home>
	 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
	 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	 <20051201165144.GC31551@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0512011828150.1609@scrub.home>
	 <1133464097.7130.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0512012048140.1609@scrub.home>
	 <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com>
	 <Pine.LNX.4.61.0512020120180.1609@scrub.home>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 21:51:18 -0500
Message-Id: <1133491878.32583.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 01:29 +0100, Roman Zippel wrote:
> Hi,

> > As for portablility, I believe John Stultz has some nice plugins coming
> > to what timer source you want to use, so if there's a better way to get a
> > time, these should make things easy to add.
> 
> These plugins can do no magic, if the hardware timer is slow, the whole 
> thing gets slow.

I was stating that if you have a faster timer, you can switch to it
without suffering much portability problems.  Anyway, you can turn off
HR if you don't need it and you still just get jiffy resolution.  And we
still lose the overhead of the timer wheel having a lot of timers that
will expire.

...

> > And they would be if that is all you need. But coming from an embedded
> > point of view, that is not nearly enough.  I really see HighRes making it
> > into the kernel soon, and any new code in this area really needs to take
> > that into account.
> 
> I'm not against HR timer, I have a problem with using them as timer for 
> everything.

When do we know to use HR or not?  So do you think that adding HR should
be specific to certain areas? 

So now we could have three separate timers :)

expire_timer    -  A timer that is expected to expire
nonexpire_timer -  A timer not expected to expire (timeout)
precision_timer -  A timer that will expire at a specific high
                    resolution time.

This would clear things up a bit, but I don't think Andrew would go for
three different timer interfaces ;)  But it would give you what you and
I both want.  

1) a timer that won't use high resolution timers but is still efficient
for the add->expire case.
2) a timer that will most likely not expire and is efficient for the
add->remove case.
3) a timer that will expire but will use the slower but more precise
hardware timer.

If this didn't cause more confusion for developers not knowing which
timer to use, I would say this would be a good idea.

Actually, we could make a single API for this and the default being the
nonexpire_timer (timeout). Just add a flag field that would tell it to
use the expire or precision timer.  Have the guts of the API be
implemented separately.

Just a suggestion.

> 
> > > - timer life time: if only a short interval is needed (e.g. a fraction of
> > > a second) timer_list is often a lot cheaper.
> > 
> > And again, you are only limited to 1000 choices to go off in that fraction
> > of a second if jiffies is the resolution (with jiffies an 1000HZ).
> 
> The point is still valid, short interval timer are cheaper using normal 
> timer, independent of whether they are removed or they expire.

As long as they don't need to be rehashed.

-- Steve


