Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDOHX5>; Sun, 15 Apr 2001 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRDOHXr>; Sun, 15 Apr 2001 03:23:47 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:45627 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132586AbRDOHXn>; Sun, 15 Apr 2001 03:23:43 -0400
Message-ID: <3AD94C3E.57948593@mvista.com>
Date: Sun, 15 Apr 2001 00:22:38 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
CC: Andre Hedrick <andre@linux-ide.org>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org> <01041504103400.02781@jeloin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> On Thursday 12 April 2001 23:52, Andre Hedrick wrote:
> > Okay but what will be used for a base for hardware that has critical
> > timing issues due to the rules of the hardware?
> >
> > I do not care but your drives/floppy/tapes/cdroms/cdrws do:
> >
> > /*
> >  * Timeouts for various operations:
> >  */
> > #define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms
> > */ #ifdef CONFIG_APM
> > #define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very
> > slow */ #else
> > #define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous
> > */ #endif /* CONFIG_APM */
> > #define WAIT_PIDENTIFY  (10*HZ) /* 10sec  - should be less than 3ms (?), if
> > all ATAPI CD is closed at boot */ #define WAIT_WORSTCASE  (30*HZ) /* 30sec
> > - worst case when spinning up */ #define WAIT_CMD        (10*HZ) /* 10sec
> > - maximum wait for an IRQ to happen */ #define WAIT_MIN_SLEEP  (2*HZ/100)
> >    /* 20msec - minimum sleep time */
> >
> > Give me something for HZ or a rule for getting a known base so I can have
> > your storage work and not corrupt.
> >
> 
> Wouldn't it make sense to define these in real world units?
> And to use that to determine requested accuracy...
> 
> Those who wait for seconds will probably not have a problem with up to (half)
> a second longer wait - or...?
> Those in range of the current jiffie should be able to handle up to one
> jiffie longer...
> 
> Requesting a wait in ms gives yo ms accuracy...

The POSIX standard seems to point to a "CLOCK" for this sort of thing. 
A "CLOCK" has a resolution.  One might define CLOCK_10MS, CLOCK_1US, or
CLOCK_1SEC, for example.  Then the request for a delay would pass the
CLOCK to use as an additional parameter.  Of course, CLOCK could also
wrap other characteristics of the timer.  For example, the jiffies
variable in the system could be described as a CLOCK which has a
resolution of 10 ms and is the uptime.  Another CLOCK might return
something related to GMT or wall time (which, by the way, is allowed to
slip around a bit relative to uptime to account for leap seconds, day
light time, and even the date command).

Now to make this real for the kernel we would need to define a set of
CLOCKs, to meet the kernel as well as the user needs.  POSIX timers
requires the CLOCK construct and doesn't limit it very much.  Once
defined to meet the standard, it is easy to extend the definition to fix
the apparent needs.  It is also easy to make the definition extensible
and we (the high-res-timers project
http://sourceforge.net/projects/high-res-timers) intend to do so.

George
