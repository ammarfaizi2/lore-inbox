Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264926AbSJOVkR>; Tue, 15 Oct 2002 17:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264930AbSJOVkR>; Tue, 15 Oct 2002 17:40:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47089 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264926AbSJOVkN>;
	Tue, 15 Oct 2002 17:40:13 -0400
Message-ID: <3DAC8C7E.25668472@mvista.com>
Date: Tue, 15 Oct 2002 14:45:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Ingo Adlung <Ingo.Adlung@t-online.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <3DA4B1EC.781174A6@mvista.com> <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA94F07.7070109@t-online.de> <20021014091855.A4197@ucw.cz> <20021015001747.A661@elf.ucw.cz> <20021015091358.A3969@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Tue, Oct 15, 2002 at 12:17:47AM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > > >>This patch, in conjunction with the "core" high-res-timers
> > > > >>patch implements high resolution timers on the i386
> > > > >>platforms.
> > > > >
> > > > >
> > > > > I really don't get the notion of partial ticks, and quite frankly, this
> > > > > isn't going into my tree until some major distribution kicks me in the
> > > > > head and explains to me why the hell we have partial ticks instead of just
> > > > > making the ticks shorter.
> > >
> > > Not speaking for a major distro, just for me writing HPET (high
> > > performance event timer ...) support for x86-64 (and it happens to exist
> > > on ia64 as well, and possibly might be in new Intel P4 chipsets, too).
> > >
> > > It's a very nice piece of hardware that allows very fine granularity
> > > aperiodic interrupts (in each interrupt you set when the next one will
> > > happen), without much overhead.
> >
> > I believe the problem is like this: assume you have three timers,
> > 10msec polling of mouse, 30msec keyboard autorepeat and 50msec cursor
> > blinking. With current approach, you get
> >
> > 10msec userland runs
> > <enter kernel>
> > <process mouse>
> > <process keyboard>
> > <process cursor>
> > <exit kernel>
> >
> > With hires timers, you get:
> >
> > 3msec userland runs
> > <enter kernel>
> > <process mouse>
> > <exit kernel>
> > 2msec userland runs
> > <enter kernel>
> > <process keyboard>
> > <exit kernel>
> > ...
> >
> > which is not so efficient. I guess rounding could be implemented to
> > preserve this "do-all-together" ability?
> 
> Actually that's exactly why you'd want sub-tick timing. For timers where
> you don't care too much about the timing ;) you could do the rounding,
> and for those where you need exact timing (sound, video, ...) you could
> call a different add_timer() which would disable the coalescing.

The way you do this with the POSIX interface is to use the
low res CLOCKs.  Internally one would just set the
sub_jiffie in the struct timer_list to zero (as the
initialize code does).  This way the timer would always be
handled on the tick interrupt and would never cause a
"special" sub tick interrupt.

As the patch is currently written, it takes extra effort to
force a sub tick event (as it should) so one has to
"request" it.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
