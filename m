Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDMPxF>; Fri, 13 Apr 2001 11:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDMPw4>; Fri, 13 Apr 2001 11:52:56 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:24088 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131457AbRDMPwr>; Fri, 13 Apr 2001 11:52:47 -0400
Message-ID: <3AD72048.23CAE80A@mvista.com>
Date: Fri, 13 Apr 2001 08:50:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Salisbury <gonar@mediaone.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org> <m1snjdtgcc.fsf@frodo.biederman.org> <3AD6B894.39848F3F@mvista.com> <002d01c0c414$346b2140$6501a8c0@gonar.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Salisbury wrote:
> 
> > I think it makes the most sense to keep jiffie as a simple unsigned
> > int.  If we leave drivers, and other code as is they can deal with
> > single word (32 bit) values and get reasonable results.  If we make HZ
> > too high (say 10,000 to get micro second resolution) we will start
> > limiting the max time we can handle, in this case to about 71.5 hours.
> > (Actually 1/2 this value would start giving us trouble.)  HZ only
> > affects the kernel internals (the user API is either seconds/micro
> > seconds or seconds/nano seconds).  For those cases where we want a higer
> > resolution we just add a sub jiffie component.  Another way of looking
> > at this is to set up HZ as the "normal" resolution.  This would be the
> > resolution (as it is today) of the usual API calls.  Only calls to the
> > POSIX 1b timers would be allowed to have higher resolution.  I propose
> > that we use the POSIX standard to define "CLOCKS" with various
> > resolution, with the understanding that the higher resolutions will have
> > higher overhead.  An yet another consideration, to get high resolution
> > with a reasonable maximum timer interval we will need to use two words
> > in the timer.  I think it makes sense to use the jiffie (i.e. 1/HZ) as
> > the high order part of the timer's time.
> >
> > Note that all of these considerations on jiffie size hold with or with
> > out a tick less system.
> 
> inner loop, i.e. interrupt timer code should never have to convert from some
> real time value into number of decrementer ticks in order to set up the next
> interrupt as that requires devides (and 64 bit ones at that) in a tickless
> system.

A good point!  If we keep jiffies and sub jiffies in the timer
structure, then the sub jiffies should be in hardware defined units
(i.e. what we need to directly talk to the hardware).  This argues for
the jiffie to be longer than the longest expected inter event interval,
i.e. for it to be larger than 10 ms.  Seconds and sub seconds?  At least
this eliminates the mpy from the high order part.  

I think we need to balance the units used in the time list with the
needs of the list management code.  It may not be a good idea to tie it
too tightly to the jiffie.  Thinking aloud here...

Another though, if we keep a small conversion table to convert from
jiffies to machine units for say the first 10 jiffies, then force an
"non event" timer interrupt if needed.  This would, I guess, get us back
to a tick system, but with tick every 10 jiffies...  Still thinking...


George
> 
> this is why any variable interval list/heap/tree/whatever should be kept in
> local ticks.  frequently used values can be pre-computed at boot time to
> speed up certain calculations (like how many local ticks/proc quantum)
