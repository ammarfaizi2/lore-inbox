Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbSJGTX3>; Mon, 7 Oct 2002 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262537AbSJGTX3>; Mon, 7 Oct 2002 15:23:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:32129 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262513AbSJGTXJ>;
	Mon, 7 Oct 2002 15:23:09 -0400
Date: Mon, 7 Oct 2002 21:27:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] HZ as a config option
Message-ID: <20021007212753.B833@ucw.cz>
References: <3D9E1BEA.7060804@us.ibm.com> <1033779196.1335.8.camel@irongate.swansea.linux.org.uk> <3DA1BD51.6040003@us.ibm.com> <3DA1C3F1.56B709FC@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA1C3F1.56B709FC@mvista.com>; from george@mvista.com on Mon, Oct 07, 2002 at 10:27:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 10:27:13AM -0700, george anzinger wrote:
> Dave Hansen wrote:
> > 
> > Alan Cox wrote:
> > > On Fri, 2002-10-04 at 23:53, Dave Hansen wrote:
> > >
> > >>On large systems (like NUMA-Q, Intel Profusion, etc...), latency and
> > >>user responsiveness become much less important.  The extra scheduling
> > >>overhead caused by higher HZ is bad.
> > >>
> > >>This is x86-only right now.  Is there any wider desire to tune this at
> > >>config time?  Do any architecutures have strict rules as to what this
> > >>can be set to?
> > >
> > > You can't set this arbitarily, the NTP PLL's will only lock for certain
> > > value ranges.
> > 
> > Where can I find these ranges?  include/linux/timex.h only errors if
> > the number is out of the 12-1535 range.
> 
> The issue is not the value itself, but if, by using the
> value and the PIT with its clock of 14.3181818/12 MHZ you
> can come up with a count that is ?? parts per million of
> being right.  I am not sure what ?? should be but 20 comes
> to mind.
> 
> All this is (incorrectly) covered over in 2.5 by using a
> more "correct" value for tick_nsec.  This keeps the wall
> clock correct for most any value of HZ, BUT breaks the POSIX
> standard that says NO TIMER SHALL EXPIRE BEFORE ITS TIME. 
> To prove this breakage, try this on a 2.5 system:
> 
> time sleep 60
> 
> Any answer less than 1 minute is BROKEN.

1 minute universal time or 1 minute gettimeofday time or 1 minute
internal kernel time? 

The current kernels do the last ...
I guess correct would probably be the second ...
While the first is what the user would expect. ;_

Anyway, if you do an usleep(20000) on a 2.4 (with 100 Hz timer), you
probably expect it to sleep two (and not three) ticks, while with NTP
running you can easily get that it took 19998 usec. Or do we really want
it to go off at 39997 us?

> I think the correct way to do all this is to use something
> other than the PIT as the clock reference AND adjust the
> jiffies time, not the wall clock.  
> 
> The High-res-timers patch I posted last Friday does the
> first part, i.e. uses a different clock reference.  The NTP
> changes will come later.

Btw, current kernel NTP implementation (at least 2.4, didn't check 2.5
yet, but it looks very similar) is broken enough, that with NTP running,
the time can jump -1us or -2us backward if the 14.318... MHz clock in
the computer goes slightly faster than it should per spec. Errors of
+200 ppm are quite common.

This is quite a problem ...

-- 
Vojtech Pavlik
SuSE Labs
