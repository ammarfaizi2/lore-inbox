Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbRFAHva>; Fri, 1 Jun 2001 03:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbRFAHvU>; Fri, 1 Jun 2001 03:51:20 -0400
Received: from aeon.tvd.be ([195.162.196.20]:30200 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S263399AbRFAHvE>;
	Fri, 1 Jun 2001 03:51:04 -0400
Date: Fri, 1 Jun 2001 09:48:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        mc@cs.Stanford.EDU, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.05.10106010941190.18375-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Dawson Engler wrote:
> Here are *uninspected* 2.4.5-ac4 results of a checker that warns when a
> non-__init function calls an __init function (suggested by
> jlundell@lobitos.net).  There seem to be two cases:
> 
>         1. The best case: the caller should actually be an __init function
> 	as well.  This is a performance bug since it won't be freed.
> 
>         2. The worst case: some random post-initialization routine
>         calls an __init routine which can cause the kernel to go into
>         hyperspace if the __init routine's code has been deleted.
> 
> The current messages do not differentiate between these two cases.  If these
> results are generally useful, I can fix up the checker, but as it now stands
> there shouldn't be that many false positives.
> 
> Dawson
> MC linux bug database: http://hands.stanford.edu/linux
> 
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/cyber2000fb.c:1548:cyberpro_probe: ERROR:INIT: non-init fn 'cyberpro_probe' calling init fn 'fb_find_mode'

[ I'm responding to this one only, woken up by Russell ]

But cyberpro_probe() is marked __devinit, so it's used during driver
initialization only.

And fb_find_mode() is special: it's indeed an __init function, but there's also
a special inline variant in <linux/fb.h>, protected by #ifdef MODULE. So this
doesn't harm.

For clarification, fb_find_mode() finds a suitable video mode in the video mode
database (drivers/video/modedb.c). Since we don't want to waste memory, this
database is __initdata. To make life easier for the driver writers, they
can still use fb_find_mode() through the inline function, which knows only
about 640x480@60 Hz.

I guess the correct fix is to (re)implement __init for modules, then we can
link the whole modedb with every frame buffer device driver module...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


