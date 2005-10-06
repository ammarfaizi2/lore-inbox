Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVJFSY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVJFSY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJFSY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:24:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751291AbVJFSY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:24:58 -0400
Date: Thu, 6 Oct 2005 11:24:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Justin R. Smith" <jsmith@drexel.edu>,
       "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Instability in kernel version 2.6.12.5
In-Reply-To: <43455F33.7020102@drexel.edu>
Message-ID: <Pine.LNX.4.64.0510061110170.31407@g5.osdl.org>
References: <43455F33.7020102@drexel.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Justin R. Smith wrote:
> 
> funky=
> 
> 1. the clock is frozen at about 2331 the previous night. Setting it is
> possible, but it remains frozen at whatever time one set it to.
> 
> 2. Any X app one starts hangs.
> 
> 3. Many operations take an extraordinarily long time. Rebooting the system too
> > 30 minutes (all spent shutting down. The restart was at the normal speed).

This all sounds like there are no timer interrupts happening (or they are 
extremely slowed down). The "X app" thing is likely because a lot of X 
apps end up doing things that are itimer-related and do gettimeofday() for 
X events. I assume things like "sleep 1" also hung forever..

It could also be that some networking stuff corrupted the timers somehow - 
maybe the interrupt happens, but longer timers end up being infinitely 
delayed by the timer just never triggering. There was some report of 
double-added neighbor entry timers recently.

> I can easily modify the firewall to block the incoming connections, but this
> strikes me as showing an instability in the Linux kernel: initiating a large
> number of failed ssh connections should not be able to corrupt the kernel.
> 
> Any suggestions?

I don't recall any similar bug-reports. Did you have any kernel events 
printed at all during this time? 

If you can trigger it again, it would be very interesting to see if 
/proc/timer indicates that the timer interrupt happens, just to check 
that. Also, to see if there's some timer list corruption, testign whether 
"sleep 1" is broken (the timers are also sorted according to how long they 
are, so testing other timeouts can be interesting too).

For example, maybe some networking timer just changes its "expires" field 
_while_ a timer is active directly rather than using "mod_timer()", which 
can screw up the sorting - and that can affect other timers.

If you can figure out a way to re-create this, people would be very 
interested, I bet.

			Linus
