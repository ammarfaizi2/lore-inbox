Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWDDEx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWDDEx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWDDEx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:53:28 -0400
Received: from www.osadl.org ([213.239.205.134]:26003 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751732AbWDDEx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:53:28 -0400
Subject: Re: [PATCH 0/5] clocksource patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 06:53:42 +0200
Message-Id: <1144126422.5344.418.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 21:54 +0200, Roman Zippel wrote:
> Another general comment from an arch/driver specific perspective: right 
> now everything is rather concentrated on getting the time, but AFAICT it's 
> more common that the subsystem which is used to read the time is also used 
> as timer (i.e. for the scheduler tick), this means the clocksource driver 
> should also include the interrupt setup.

I don't think so. Coupling the clock sources to clock event sources is
wrong. In many systems the clock event source delivering the next event
interrupt - either periodic or per event programmed - is independend
from the clock source which is used to read the time.

Also we want to distribute multiple clock event sources for various
services. Hardwiring those into combos is counter productive.

> i386 is currently rather hardcoded to use the i8253 timer, but AFAIK it 
> would be desirable to e.g. use HPET for that (especially for hrtimer). 
> Something like TSC should internally use another clocksource to provide 
> the timer interrupt.

This is exactly the result of such an artificial combo. "Use internally
something else." Thats fundamentally wrong and violates every basic rule
of abstraction.

>  Anyway, i386 is quite a mess here right now and I can 
> understand that you wanted to stay away from it with the generic 
> gettimeofday infrastructure. :-)

He ? John addressed the clock source (timeofday) related problem in
x386. He never claimed that his timeofday code is solving the clock
event source problem. gettimeofday() exactly does what it says: it gets
the time of day. And it does it independend of any interrupt source in
the first place.

Clock event sources need their own independent abstraction layer, as one
can be found in my high resolution timer patch queue. There is
interaction between the timekeeping and the next event interrupt
programming, but it's important to keep them seperate.

How should a combo solution allow to add special hardware, which
provides only one of the services ? By using "something else
internally" ? No, thanks.

	tglx


