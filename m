Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVDUO5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDUO5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVDUO5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:57:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:45794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261411AbVDUO5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:57:00 -0400
Date: Thu, 21 Apr 2005 07:58:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, jdavis@accessline.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
 behavior in 2.6 vs 2.4  (1 extra tick)]
In-Reply-To: <1114080708.5996.16.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com> 
 <1114052315.5058.13.camel@localhost.localdomain>  <1114054816.5996.10.camel@localhost.localdomain>
  <20050421095109.A25431@flint.arm.linux.org.uk> <1114080708.5996.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Apr 2005, Steven Rostedt wrote:
> 
> Thanks, I forgot about the guarantee of "at least" the time requested.
> I took this on because I noticed this in a driver I wrote. With the user
> passing in a timeval for a periodic condition. I noticed that this would
> drift quite a bit.

Your user is doing things wrong. If he wants a non-drifting clock, he 
should look at _realtime_ and then always re-calculate the "how long do I 
want to sleep" from that. Because even if the kernel was able to do all 
offsets with nanosecond precision and wake you up _exactly_, you'd still 
be drifting because of the time spent in between calls (and scheduling 
events etc).

>	 I guess I need to write my own timeval_to_jiffies
> conversion so that i remove the added jiffy. For this case, I actually
> want a true rounded value to the closest jiffy.

No, if you're looking at reliable wall-clock time, you really need to use
wall-clock, not successive time offsets. The time offsets will always
drift: you can make the drift small enough that your particular
application doesn't happen to care (or, quite often - make it drift in a
_direction_ you don't happen to care about), but it's still wrong.

If you calculate the expected timeout from the time-of-day in the caller,
your drift not only goes away, but you'll actually be able to handle 
things like "oops, the machine is under load so I missed an event".

Yes, it gets slightly more complicated (and a _lot_ more complicated if
your app needs to do something special for the missed case, like dropping
data and re-syncing, which is common in things like video or sound
streaming), but the fact is, it's just the right thing to do.

		Linus
