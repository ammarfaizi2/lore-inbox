Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135238AbRDLRks>; Thu, 12 Apr 2001 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135240AbRDLRki>; Thu, 12 Apr 2001 13:40:38 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:45830 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135238AbRDLRkY>; Thu, 12 Apr 2001 13:40:24 -0400
Message-ID: <3AD5E852.687DBC09@mvista.com>
Date: Thu, 12 Apr 2001 10:39:30 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bret Indrelee <bret@io.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer!
In-Reply-To: <Pine.LNX.4.21.0104111242150.16730-100000@fnord.io.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Indrelee wrote:
> 
> Mikulas Patocka (mikulas@artax.karlin.mff.cuni.cz) wrote:
> > Adding and removing timers happens much more frequently than PIT tick,
> > so
> > comparing these times is pointless.
> >
> > If you have some device and timer protecting it from lockup on buggy
> > hardware, you actually
> >
> > send request to device
> > add timer
> >
> > receive interrupt and read reply
> > remove timer
> >
> > With the curent timer semantics, the cost of add timer and del timer is
> > nearly zero. If you had to reprogram the PIT on each request and reply,
> > it
> > would slow things down.
> >
> > Note that you call mod_timer also on each packet received - and in worst
> > case (which may happen), you end up reprogramming the PIT on each
> > packet.
> 
> You can still have nearly zero cost for the normal case. Avoiding worst
> case behaviour is also pretty easy.
> 
> You only reprogram the PIT if you have to change the interval.
> 
> Keep all timers in a sorted double-linked list. Do the insert
> intelligently, adding it from the back or front of the list depending on
> where it is in relation to existing entries.

I think this is too slow, especially for a busy system, but there are
solutions...
> 
> You only need to reprogram the interval timer when:
> 1. You've got a new entry at the head of the list
> AND
> 2. You've reprogrammed the interval to something larger than the time to
> the new head of list.

Uh, I think 1. IMPLIES 2.  If it is at the head, it must be closer in
than what the system is waiting for (unless, of course its time has
already passed, but lets not consider that here).
> 
> In the case of a device timeout, it is usually not going to be inserted at
> the head of the list. It is very seldom going to actually timeout.

Right, and if the system doesn't have many timers, thus putting this at
the head, it has the time to do the extra work.
> 
> Choose your interval wisely, only increasing it when you know it will pay
> off. The best way of doing this would probably be to track some sort
> of LCD for timeouts.

I wonder about a more relaxed device timeout semantic that says
something like: wait X + next timer interrupt.  This would cause the
timer insert code to find an entry at least X out and put this timer
just after it.  There are other ways to do this of course.  The question
here is: Would this be worth while?
> 
> The real trick is to do a lot less processing on every tick than is
> currently done. Current generation PCs can easily handle 1000s of
> interrupts a second if you keep the overhead small.

I don't see the logic here.  Having taken the interrupt, one would tend
to want to do as much as possible, rather than schedule another
interrupt to continue the processing.  Rather, I think you are trying to
say that we can afford to take more interrupts for time keeping.  Still,
I think what we are trying to get with tick less timers is a system that
takes FEWER interrupts, not more.

George
