Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSJOHIK>; Tue, 15 Oct 2002 03:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJOHIK>; Tue, 15 Oct 2002 03:08:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:41358 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262620AbSJOHIJ>;
	Tue, 15 Oct 2002 03:08:09 -0400
Date: Tue, 15 Oct 2002 09:13:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Ingo Adlung <Ingo.Adlung@t-online.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Message-ID: <20021015091358.A3969@ucw.cz>
References: <3DA4B1EC.781174A6@mvista.com> <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA94F07.7070109@t-online.de> <20021014091855.A4197@ucw.cz> <20021015001747.A661@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021015001747.A661@elf.ucw.cz>; from pavel@suse.cz on Tue, Oct 15, 2002 at 12:17:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:17:47AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >>This patch, in conjunction with the "core" high-res-timers
> > > >>patch implements high resolution timers on the i386
> > > >>platforms.
> > > > 
> > > > 
> > > > I really don't get the notion of partial ticks, and quite frankly, this 
> > > > isn't going into my tree until some major distribution kicks me in the 
> > > > head and explains to me why the hell we have partial ticks instead of just 
> > > > making the ticks shorter.
> > 
> > Not speaking for a major distro, just for me writing HPET (high
> > performance event timer ...) support for x86-64 (and it happens to exist
> > on ia64 as well, and possibly might be in new Intel P4 chipsets, too).
> > 
> > It's a very nice piece of hardware that allows very fine granularity
> > aperiodic interrupts (in each interrupt you set when the next one will
> > happen), without much overhead.
> 
> I believe the problem is like this: assume you have three timers,
> 10msec polling of mouse, 30msec keyboard autorepeat and 50msec cursor
> blinking. With current approach, you get
> 
> 10msec userland runs
> <enter kernel>
> <process mouse>
> <process keyboard>
> <process cursor>
> <exit kernel>
> 
> With hires timers, you get:
> 
> 3msec userland runs
> <enter kernel>
> <process mouse>
> <exit kernel>
> 2msec userland runs
> <enter kernel>
> <process keyboard>
> <exit kernel>
> ...
> 
> which is not so efficient. I guess rounding could be implemented to
> preserve this "do-all-together" ability?

Actually that's exactly why you'd want sub-tick timing. For timers where
you don't care too much about the timing ;) you could do the rounding,
and for those where you need exact timing (sound, video, ...) you could
call a different add_timer() which would disable the coalescing.

-- 
Vojtech Pavlik
SuSE Labs
