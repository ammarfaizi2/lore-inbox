Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272107AbRHWBg2>; Wed, 22 Aug 2001 21:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272175AbRHWBgS>; Wed, 22 Aug 2001 21:36:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:24838 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S272107AbRHWBgJ>;
	Wed, 22 Aug 2001 21:36:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15236.23943.260421.31691@cargo.ozlabs.ibm.com>
Date: Thu, 23 Aug 2001 11:33:59 +1000 (EST)
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC 
 add_timer_randomness()
In-Reply-To: <3B8423B9.29B1293A@nortelnetworks.com>
In-Reply-To: <Pine.LNX.4.33.0108221702300.12521-100000@terbidium.openservices.net>
	<3B8423B9.29B1293A@nortelnetworks.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen writes:

> > +extern int have_timebase;
> >   ...
> 
> > Am I missing something, or should at least one of these not be extern?
> 
> 
> Okay, I feel dumb.  You're right of course. I guess I must have missed the
> compiler warning.

I accidently deleted the message with the patch, but my comment would
be that the way we have tended to handle this sort of thing is by
reading the PVR register (processor version register) each time rather
than by setting a flag in memory and testing that, since I expect that
reading a special-purpose register in the CPU should be faster than
doing a load from memory.

In the 2.4 tree we have code that works out a cpu features word from
the PVR value.  The cpu features word has bits for things like does
the cpu have the TB register, does the MMU use a hash table, does the
cpu have separate I and D caches, etc.

The other thing you could consider is using the value in the
decrementer register rather than the TB or RTC.  The timer interrupt
is signalled when the DEC transitions from 0 to -1, and the DEC keeps
decrementing (at the same rate that the TB increments, on cpus which
have a TB).  I assume that the source of randomness that you are
trying to capture is the jitter in the timer (decrementer) interrupt
latency.  AFAICS you could get that from DEC just as well as from the
TB/RTC and it would have the advantage that you would not need a
conditional on the processor version.

There is a list, linuxppc-dev@lists.linuxppc.org, where you will find
a greater concentration of PPC kernel developers.  There is nothing
wrong with discussing this stuff on linux-kernel but you may perhaps
get more informed responses on linuxppc-dev. :)

Paul.
