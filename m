Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135444AbRDMIaM>; Fri, 13 Apr 2001 04:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135441AbRDMIaD>; Fri, 13 Apr 2001 04:30:03 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:38377 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135444AbRDMI3q>; Fri, 13 Apr 2001 04:29:46 -0400
Message-ID: <3AD6B894.39848F3F@mvista.com>
Date: Fri, 13 Apr 2001 01:28:04 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org> <m1snjdtgcc.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Andre Hedrick <andre@linux-ide.org> writes:
> 
> > On Thu, 12 Apr 2001, george anzinger wrote:
> >
> > > Actually we could do the same thing they did for errno, i.e.
> > >
> > > #define jiffies get_jiffies()
> > > extern unsigned get_jiffies(void);
> >
> > > No, not really.  HZ still defines the units of jiffies and most all the
> > > timing is still related to it.  Its just that interrupts are only "set
> > > up" when a "real" time event is due.
> >
> > Great HZ always defines units of jiffies, but that is worthless if there
> > is not a ruleset that tells me a value to divide by to return it to a
> > specific quantity of time.

The definition of HZ is the number of units in a second.  Thus if HZ is
100 we are talking about a 10 ms jiffie.
> 
> Actually in rearranging it.  jiffies should probably be redefined as
> the smallest sleep we are prepared to take.  And then HZ because the
> number of those smallest sleeps per second.  So we might see HZ values
> up in the millions but otherwise things should be pretty much as
> normal.

Actually I think it is more useful to define it as something like 100
for the following reasons.  

I think it makes the most sense to keep jiffie as a simple unsigned
int.  If we leave drivers, and other code as is they can deal with
single word (32 bit) values and get reasonable results.  If we make HZ
too high (say 10,000 to get micro second resolution) we will start
limiting the max time we can handle, in this case to about 71.5 hours. 
(Actually 1/2 this value would start giving us trouble.)  HZ only
affects the kernel internals (the user API is either seconds/micro
seconds or seconds/nano seconds).  For those cases where we want a higer
resolution we just add a sub jiffie component.  Another way of looking
at this is to set up HZ as the "normal" resolution.  This would be the
resolution (as it is today) of the usual API calls.  Only calls to the
POSIX 1b timers would be allowed to have higher resolution.  I propose
that we use the POSIX standard to define "CLOCKS" with various
resolution, with the understanding that the higher resolutions will have
higher overhead.  An yet another consideration, to get high resolution
with a reasonable maximum timer interval we will need to use two words
in the timer.  I think it makes sense to use the jiffie (i.e. 1/HZ) as
the high order part of the timer's time.  

Note that all of these considerations on jiffie size hold with or with
out a tick less system.

George
