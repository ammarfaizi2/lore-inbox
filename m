Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVAKAUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVAKAUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVAKAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:20:15 -0500
Received: from gprs214-230.eurotel.cz ([160.218.214.230]:43904 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262674AbVAKAOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:14:46 -0500
Date: Tue, 11 Jan 2005 01:14:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111001426.GF1444@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110174804.GC4641@blackham.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > arch/i386/kernel/time.c, can you comment out
> > > > > jiffies += sleep_length * HZ;
> > > > 
> > > > Worked like a charm.  I'm not seeing any time drift after your suggested 
> > > > change.
> > > 
> > > AIUI, this also means that a machine's uptime does not include time
> > > whilst suspended. This was the behaviour prior to 2.6.10 and seems to be
> > > more desirable as it counts the time the machine is actually running,
> > > not just time since boot. Is there a good reason why we can't go back to
> > > this?
> > 
> > I think it means very wrong system clock in ACPI state.
> 
> So would implementing the equivalent of hwclock --hctosys keep both
> ACPI & APM happy, but not include time suspended in uptime?

I think that hwclock --hctosys is not quite straightforward operation
-- it needs to know if your CMOS clock are in local timezone or GMT,
or something like that, IIRC.

But this might work: compute difference between system and cmos time
before suspend, and use that info to restore time after suspend.

> > Plus think something wanting timeout of five minutes, then suspend
> > one minute after, machine sleeps for a hour.
> > 
> > With this approach, timeout should happen just after resume, with your
> > approach, it would wait 4 more minutes.
> 
> It does depend on whether a timer wants a delay against the wall
> clock or the rest of the system.  A process may be sleeping because
> it's waiting for some other task to complete, or waiting for input
> from the user. In these cases I claim time-whilst-hibernated should
> not be counted.

> Hibernating shouldn't be noticeable to the system. For example, a
> popup window that came up an instant prior to suspending which is
> normally on the screen for several seconds would vanish instantly
> upon resuming without the user ever seeing it.

I disagree here.

If I do cli(); sleep(5 hours); sti();, system should survive that. If
you do cli(); sleep(5 hours); sti() but fail to compensate for lost
ticks, all sorts of funny things might happen if you are comunicating
with someone who did not sleep.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
