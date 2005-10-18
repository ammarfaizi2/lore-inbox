Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVJRIq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVJRIq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJRIq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:46:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54509 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932424AbVJRIq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:46:56 -0400
Date: Tue, 18 Oct 2005 10:46:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051018084655.GA28933@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510172227010.1386@scrub.home>
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

> On Mon, 17 Oct 2005, Ingo Molnar wrote:
> 
> > why you insist on ktimers being 'process timers'?
> 
> Because they are optimized for process usage. OTOH kernel usage is 
> more than just "timeouts".

you have cut out the rest of what i write in the paragraph, which IMO 
answers your question:

> > They are totally separate entities, not limited to any process 
> > notion. One of their first practical use happens to be POSIX process 
> > timers (both itimers and ptimers) via them, but no way are ktimers 
> > only 'process timers'. They are very generic timers, usable for any
> > kernel purpose.

so i can only repeat that ktimers is a generic timer subsystem, with a 
focus on _actually delivering a timer event_.

and no, ktimers are not "optimized for process usage" (or tied to 
whatever other process notion, as i said before), they are optimized 
for:

 - the delivery of time related events

as contrasted to the timeout-API (a'ka "timer wheel") code in 
kernel/timers.c that is optimized towards:

 - the fast adding/removal of timers

without too much focus on robust and deterministic delivery of events.

these two concepts are conflicting, and i claim that a (sane) data 
structure that maximally fulfills both sets of requirements does not 
exist, mathematically. (to repeat, the requirements are: 'fast 
add/remove' and 'fast+deterministic expiry')

at this point i'd really suggest for readers to lean back and think 
about the mathematical foundations of timer data structures for a bit, 
with a focus on the tradeoffs that the timer wheel data structure has, 
vs. the tradeoffs of the rbtree data structure that ktimers has.

My claim is that if you _know_ that a timer will expire most likely, you 
want it to order at insertion time - i.e. you want to have a tree 
structure. If you _know_ that a timer will most likely _not_ expire, 
then you can avoid the tree overhead by 'delaying' the decision of 
sorting timers, to the point in the future where we really are forced to 
do so.

The result of this mathematical paradox is that we end up with two data 
structures: one is the timer wheel (kernel/timers.c) for 
timeout/exception related use; the other one is ktimers 
(kernel/ktimers.c), for expiry oriented use.

> > so to answer your question: it is totally possible for a watchdog 
> > mechanism to use ktimers. In fact it would be desirable from a 
> > robustness POV too: 
> 
> "possible" and "desirable" is still different from "preferable", as 
> they involve a higher cost.

[ in my answer above you are free to substitute "preferable" with
  "desirable" - i do mean it as it reads in plain English. ]

> > e.g. we dont want a watchdog from being 
> > overload-able via too many timeouts in the timer wheel ...
> 
> Please explain.

e.g. on busy networked servers (i.e. ones that do have a need for 
watchdogs) the timer wheel often includes large numbers of timeouts, 
99.9% of which never expire. If they do expire en masse for whatever 
reason, then we can get into overload mode: a million timers might have 
to expire before we get to process the watchdog event and act upon it.  
This can delay the watchdog event significantly, which delay might (or 
might not) matter to the watchdog application.

in short: the timer wheel was not designed with determinism in mind (nor 
should 'simple timeouts' care about determinism). Watchdogs are 
preferably (and desirably) implemented via the most deterministic timer 
mechanism that the kernel offers: ktimers in this particular case.

	Ingo
