Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSFHDhs>; Fri, 7 Jun 2002 23:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317383AbSFHDhr>; Fri, 7 Jun 2002 23:37:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52989 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317381AbSFHDhq>;
	Fri, 7 Jun 2002 23:37:46 -0400
Message-ID: <3D017BE8.8759AD8D@mvista.com>
Date: Fri, 07 Jun 2002 20:37:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: ashieh@OCF.Berkeley.EDU, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday clock jump bug
In-Reply-To: <Pine.LNX.4.44.0206080046420.19463-100000@sharra.ivimey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> 
> ashieh@OCF.Berkeley.EDU wrote:
> > time() occasionally returns a
> >bogus value (>1 hour jump forward, and a few microseconds later jumps back to
> >the right time) on my box (Thunderbird 750, Asus K7V (KX133) kernel 2.4.17).
> >This behavior sets in after the box is up for some period of time. I don't
> >think this is related to the 686a configuration reset bug.
> >
> On Fri, 7 Jun 2002, george anzinger wrote:
> >I suspect that do_gettimeoffset() may be, on occasion,
> >returning a negative number.  The normalizing code then
> >works with this (unsigned) value until it is < 1,000,000.
> >If it came back as -1, this would generate an error of about
> >1.19 hours.  I suspect the best fix would be to test the
> >result from do_gettimeoffset() for something greater than
> >say 20ms and if so set it to 0.
> 
> I've just looked at the i386 time.c source and can see no obvious way for -1
> to be returned by do_gettimeoffset(). 

It can happen two ways (and I am not saying it returns -1,
but some large number ~ 1hr worth of usecs).  The first
possibility is an overflow in the conversion of tsc ticks to
usec.  This is more likely a problem if the processor is
running at high speeds, AND interrupts have been held off
for a while.  The second possibility is that either the
latch read failed to latch or the PIT is actually not
resetting at count = 0.  This is, I think, the VIA chip
bug.  If there is no "correction" code for this bug, the net
result will be a slow and erratic clock.  If there is
correction software in place, it could result in the
observed time jump by providing an invalid count which is
then used by do_gettimeoffset().  The reason the fault
clears is a.) on the next tick a valid count will be
obtained, and b) the value from do_gettimeoffset() is never
rolled into the wall clock.

> I note that this error is fixed in the
> next time() call, so I would instead expect the error to be one involving the
> conversion of tv_secs/tv_usecs into the seconds return from time().
> 
> One possible way to check this out would be to change the test program from
> using the time() call to using gettimeofday(), and to ignore tv_usecs.

And just where does time() get the time of day if not from
gettimeofday()?
> 
> Hope this helps,
> 
> Ruth
> 
> --
> Ruth Ivimey-Cook
> Software engineer and technical writer.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
