Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSJRM7l>; Fri, 18 Oct 2002 08:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSJRM7l>; Fri, 18 Oct 2002 08:59:41 -0400
Received: from iris.mc.com ([192.233.16.119]:60113 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S265102AbSJRM7k>;
	Fri, 18 Oct 2002 08:59:40 -0400
Message-Id: <200210181305.JAA28085@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Date: Fri, 18 Oct 2002 09:11:21 -0400
X-Mailer: KMail [version 1.3.2]
Cc: george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0210171453050.2499-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0210171453050.2499-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 17:54, Randy.Dunlap wrote:
> On Wed, 9 Oct 2002, Linus Torvalds wrote:
> | On Wed, 9 Oct 2002, george anzinger wrote:
> | > This patch, in conjunction with the "core" high-res-timers
> | > patch implements high resolution timers on the i386
> | > platforms.
> |
> | I really don't get the notion of partial ticks, and quite frankly, this
> | isn't going into my tree until some major distribution kicks me in the
> | head and explains to me why the hell we have partial ticks instead of
> | just making the ticks shorter.
> | -

because just making ticks shorter/more frequent just increases timer overhead 
all the time whether you are actually doing anything requiring it or not. 
this is a big waste of cpu cycles.

using the partial tick method put forward by george, you only pay the price 
for higher resolution timers WHEN YOU WANT TO.

most things that want say 1usec precision dont want to do something EVERY us, 
just something every now and then with 1us precision.  things like programs 
that want to block for a 350 usec. but waiting 10 or even 1 msec would be too 
long. 

the timer overhead using fixed interval timers (as you suggest) to support 
that occaisional 350 usec block would eat too much cpu to be practical.

increasing timer frequency penalizes ALL users/processes with increased timer 
overhead all the time for the benefit of the small number of tasks that need 
better resolution.  the sub-jiffie/partial tick model only pays that price 
when there is an actual timed event that needs to occur at that higher 
resolution and the rest of the time the timer overhead remains as it is today 
(which to my mind is 10 times what it needs to be, but that is an argument 
for another day)

embedded systems in particular need higher resolution and these types of 
systems are precisely the systems that can't afford to multiply their timer 
overhead by a factor of 10 or more (as increasing HZ to 1000 does).


