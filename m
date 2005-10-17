Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVJQUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVJQUwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVJQUwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:52:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4757
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932319AbVJQUwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:52:55 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       george@mvista.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       paulmck@us.ibm.com, hch@infradead.org, oleg@tv-sign.ru,
       tim.bird@am.sony.com
In-Reply-To: <Pine.LNX.4.61.0510171511010.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510100213480.3728@scrub.home>
	 <1129016558.1728.285.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
	 <Pine.LNX.4.61.0510150143500.1386@scrub.home>
	 <1129490809.1728.874.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510170021050.1386@scrub.home>
	 <20051017075917.GA4827@elte.hu>
	 <Pine.LNX.4.61.0510171054430.1386@scrub.home>
	 <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>
	 <Pine.LNX.4.61.0510171511010.1386@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 17 Oct 2005 22:55:12 +0200
Message-Id: <1129582512.19559.136.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 18:25 +0200, Roman Zippel wrote:
> It's rather simple:
> - "timer API" vs "timeout API": I got absolutely no acknowlegement that 
> this might be a little confusing and in consequence "process timer" may be 
> a better name.

Not only me, also a lot of other people do _not_ find it confusing and I
explained why it is a clear technical distcinction. I also explained why
I think that process_timers is too restrictive IMO.

I accept that you find it confusing, but I dont understand neither what
kind of acknowledgement you want nor how you deduce my obligation for
acknowledging whatever.

> - I pointed out various (IMO) unnecessary complexities, which were rather 
> quickly brushed off e.g. with a need for further (not closer specified) 
> cleanups.

The so called complexities are a not various. You complained about
exactly 5 members of the ktimer structure. 

- list, expired, status, interval, overrun

which are superflous in your opinion.

Again an explanation for each :

list: 
allows fast access to the time sorted list without walking the rbtree
and is a preliminary for the extension to high resolution timers.

-----------

expired:
The field was added for simplification of some delta calculations in the
return path. e.g. nanosleep in the expired case to avoid the extra call
to get the current time. Also quite useful for debugging.

-----------

status:
A simple field, which stores at the moment 2 states and is necessary for
extensions to high resolution timers too, as we have more states there. 
The suggested usage of the rbnode.parent pointer is wrong IMO as the
overloading of arbitrary pointers for status information is a kind of
pseudo optimization which is reducing in fact maintainability and
clarity for a the win of a 32bit variable.

-----------

interval, overrun:
Interval holds the converted interval value for itimers. The overrun
member is used by the rearm code so the caller can figure out the number
of missed events. 

The cleanup I pointed out for the posix timer interval timers is pretty
obvious. It makes use of interval and overrun and removes two members of
the posix timer structure.

-----------

The size of the ktimer structure is a matter of micro optimizations in
the same way as the macros/inlines are. 

Calling the pure existence of some struct members complexity is an
exaggeration and contradicts your own request for a simple and clear
design. 

The implementation was done clear and simple from the very beginning and
I really dont understand why the preparation for further extensions in
the first place is bad. 

Doing a design with the final goal in mind is much cleaner than doing
micro optimizations in the first place and afterwards working around
them when you apply extensions.

> - resolution handling: at what resolution should/does the kernel work and 
> what do we report to user space. The spec allows multiple interpretations 
> and I have a hard time to get at least one coherent interpretation out of 
> Thomas.

I interpret the spec in the way I do for following reasons:

1. It is _usual practice_ to return the "timer" resolution for
clock_res() and to return clock values with as much resolution as
possible. In no case should the actual clock resolution be less than
what clock_res() returns.
- George Anzinger in this thread. Similar opinions can be found via
Google. I came to the same conclusion and saw no reason to repeat
Georges statement. I thought a simple pointer would be sufficient.

2. The rounding to the resolution value is explicitly required by the
standard.

3. It makes a lot of sense to do what (1.) describes, due to the fact
that we actually want to restrict the timer resolution to avoid
interrupt and reprogramming floods in very short intervals. This in fact
is the default behaviour in a jiffy driven environment. Pretending a
real nsec resolution and doing no rounding at all is violating (2.).
>From an application programmers view it makes sense to return the timer
resolution so he actually can adjust the program behaviour on the
provided resolution and not rely on wild guess assumptions about what
might be there. Applications need to be able to verify whether the
system can handle the required intervals or not.

	tglx


