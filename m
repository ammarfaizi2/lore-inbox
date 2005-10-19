Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVJSB6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVJSB6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVJSB6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:58:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1966 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751107AbVJSB6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:58:33 -0400
Date: Wed, 19 Oct 2005 03:58:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051018084655.GA28933@elte.hu>
Message-ID: <Pine.LNX.4.61.0510190311140.1386@scrub.home>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com>
 <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu>
 <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Oct 2005, Ingo Molnar wrote:

> > Because they are optimized for process usage. OTOH kernel usage is 
> > more than just "timeouts".
> 
> you have cut out the rest of what i write in the paragraph, which IMO 
> answers your question:
> 
> > > They are totally separate entities, not limited to any process 
> > > notion. One of their first practical use happens to be POSIX process 
> > > timers (both itimers and ptimers) via them, but no way are ktimers 
> > > only 'process timers'. They are very generic timers, usable for any
> > > kernel purpose.
> 
> so i can only repeat that ktimers is a generic timer subsystem, with a 
> focus on _actually delivering a timer event_.

It doesn't answer it at all. The new timer system is definitively not 
"usable for any kernel purpose", it has certain properties, which makes it 
only applicable under certain conditions.

> and no, ktimers are not "optimized for process usage" (or tied to 
> whatever other process notion, as i said before), they are optimized 
> for:
> 
>  - the delivery of time related events
> 
> as contrasted to the timeout-API (a'ka "timer wheel") code in 
> kernel/timers.c that is optimized towards:
> 
>  - the fast adding/removal of timers
> 
> without too much focus on robust and deterministic delivery of events.

You forgot the main property of high resolution, which implies a higher 
maintainance cost. 
Whether the timer event is delivered or not is completely unimportant, as 
at some point the event has to be removed anyway, so that optimizing a 
timer for (non)delivery is complete nonsense.

> these two concepts are conflicting, and i claim that a (sane) data 
> structure that maximally fulfills both sets of requirements does not 
> exist, mathematically. (to repeat, the requirements are: 'fast 
> add/remove' and 'fast+deterministic expiry')

to repeat: low resolution/overhead vs high resolution.
Both are hopefully deterministic (only at different resolutions) or we 
have serious bug at hand.

> > > e.g. we dont want a watchdog from being 
> > > overload-able via too many timeouts in the timer wheel ...
> > 
> > Please explain.
> 
> e.g. on busy networked servers (i.e. ones that do have a need for 
> watchdogs) the timer wheel often includes large numbers of timeouts, 
> 99.9% of which never expire. If they do expire en masse for whatever 
> reason, then we can get into overload mode: a million timers might have 
> to expire before we get to process the watchdog event and act upon it.  
> This can delay the watchdog event significantly, which delay might (or 
> might not) matter to the watchdog application.

I already mentioned earlier that it's possible to reduce the timer load by 
using a watchdog timer to filter most of these events, so that you get 
into the interesting situation that most kernel timer actually do expire 
and suddenly you easily can have more "timers" than "timeouts".

bye, Roman
