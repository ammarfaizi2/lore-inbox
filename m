Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVJQUJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVJQUJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJQUJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:09:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53145 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751243AbVJQUJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:09:44 -0400
Date: Mon, 17 Oct 2005 22:09:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017200949.GA8590@elte.hu>
References: <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org> <Pine.LNX.4.61.0510171511010.1386@scrub.home> <4353D60E.70901@am.sony.com> <Pine.LNX.4.61.0510171948040.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171948040.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > It's rather simple:
> > > - "timer API" vs "timeout API": I got absolutely no acknowlegement that this
> > > might be a little confusing and in consequence "process timer" may be a
> > > better name.
> > 
> > I agree with Thomas on this one.  Maybe "timer" and "timeout" are too close,
> > but I think they are the most descriptive names.
> >  - timeout is something used for a timeout.  Timeouts only actually
> >  expire infrequently, so they have a host of attributes associated
> >  with that characteristic.
> >  - timer is something used to time something.  They almost always
> >  expire as part of their normal behaviour.  In the ktimer code they
> >  have a host of attributes related to this characteristic.
> 
> There is of course a difference, but is it big enough that they 
> deserve different APIs? Just look into <linux/timer.h> it doesn't 
> mention timeout once, but according to Thomas that's our "timeout 
> API". Look at the description of mod_timer() in timer.c: "modify a 
> timer's timeout". It seems I'm not only one who thinks that both are 
> closely related.

this is one more area where there's no good substitute from 'walking the 
walk', i.e. getting yourself dirty with actual code. I have been 
involved with the following variants which were part of the -rt tree:

- we implemented both timeouts and timers with the same
  timeout-optimized framework [i.e. with the 'wheel'] - it sucked.

- timers and timeouts with a timer-optimized framework [i.e. with a
  binary tree] sucks too, due to the tree overhead.

- we in fact tried another variant too: a hybrid method where timers and
  timeouts lived in the timer wheel and some time before (hr) timers
  were about to time out they were put into a separate hr-list. This
  hybrid solution sucked too.

so then we tried a separate API and subsystem for both of them, and 
voila, many of the uglinesses went away, and things became robust.

	Ingo
