Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbSJGRWU>; Mon, 7 Oct 2002 13:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262577AbSJGRWT>; Mon, 7 Oct 2002 13:22:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12022 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262575AbSJGRWP>;
	Mon, 7 Oct 2002 13:22:15 -0400
Message-ID: <3DA1C3F1.56B709FC@mvista.com>
Date: Mon, 07 Oct 2002 10:27:13 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] HZ as a config option
References: <3D9E1BEA.7060804@us.ibm.com> <1033779196.1335.8.camel@irongate.swansea.linux.org.uk> <3DA1BD51.6040003@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Alan Cox wrote:
> > On Fri, 2002-10-04 at 23:53, Dave Hansen wrote:
> >
> >>On large systems (like NUMA-Q, Intel Profusion, etc...), latency and
> >>user responsiveness become much less important.  The extra scheduling
> >>overhead caused by higher HZ is bad.
> >>
> >>This is x86-only right now.  Is there any wider desire to tune this at
> >>config time?  Do any architecutures have strict rules as to what this
> >>can be set to?
> >
> > You can't set this arbitarily, the NTP PLL's will only lock for certain
> > value ranges.
> 
> Where can I find these ranges?  include/linux/timex.h only errors if
> the number is out of the 12-1535 range.

The issue is not the value itself, but if, by using the
value and the PIT with its clock of 14.3181818/12 MHZ you
can come up with a count that is ?? parts per million of
being right.  I am not sure what ?? should be but 20 comes
to mind.

All this is (incorrectly) covered over in 2.5 by using a
more "correct" value for tick_nsec.  This keeps the wall
clock correct for most any value of HZ, BUT breaks the POSIX
standard that says NO TIMER SHALL EXPIRE BEFORE ITS TIME. 
To prove this breakage, try this on a 2.5 system:

time sleep 60

Any answer less than 1 minute is BROKEN.

I think the correct way to do all this is to use something
other than the PIT as the clock reference AND adjust the
jiffies time, not the wall clock.  

The High-res-timers patch I posted last Friday does the
first part, i.e. uses a different clock reference.  The NTP
changes will come later.

-g
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
