Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTEABBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTEABBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:01:12 -0400
Received: from pasky.ji.cz ([62.44.12.54]:41454 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262601AbTEABBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:01:08 -0400
Date: Thu, 1 May 2003 03:19:50 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [HINTS] Re:  More radeonfb fixes
Message-ID: <20030501011950.GA641@pasky.ji.cz>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <1050062592.562.14.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050062592.562.14.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dear diary, on Fri, Apr 11, 2003 at 02:03:13PM CEST, I got a letter,
where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me, that...
> Here's a new patch against 2.4.20 and 2.4.21-pre7 which brings more
> fixes to radeonfb:
> 
> - Fix the M6 video RAM workaround
> - Some bits in the PM code were flipped, fix that.
> - RB2D_DSTCACHE_MODE shouldn't be cleared on r300 (and
>   maybe not on others according to a comment in XFree, but
>   we keep working code for now).
> - Re-change the pitch workaround. We now align the pitch
>   when accel is enabled for a given mode, and we don't when
>   accel is disabled. That should properly deal with all cases
>   and allows us to remove the "special case" accel code
> - Bring in XFree workaround to not write the same value to
>   the PLL (can cause blanking of some panels)
> - Bring in some of Peter Horton fixes (accel reset, cleanups)
>   still some more to get in though...
> - Properly reset accel engine on each console switch so
>   we work around switching from XFree leaving it in a weird
>   state. Also extend the comparison of values causing us to
>   reload the mode on console switch.

thanks a lot, this patch solved my quite annoying framebuffer problems with the
stock 2.4.21rc1 radeonfb driver on ATI Radeon 7000 w/ 64MB RAM :-).

If you are interested in some bugreports and don't want to read the following
semi-minihowto, please just look for the [PERHAPS-BUGREPORT] string.

In order to give advice to the fellow googlers possibly seeing this in
archives: if you have annoying long delays when switching between consoles or
the video mode you specify on the cmdline carefully results in just an ugly
mess,

* before trying anything out, something about modes and refresh rates (does NOT
  cover interlaced modes):

  - fbset excepts modes in the format of <X>x<Y>-<refreshrate>, while kernel
    excepts the modes in the format of <X>x<Y>[-<depth>][@<refreshrate>. Beware
    this difference. More about modes on commandline below.

  - the kernel and fbset modes database is not in sync. You may find it useful
    to add

mode "1024x768-85"
    # D: 98.902 MHz, H: 70.243 kHz, V: 85.454 Hz
    geometry 1024 768 1024 768 8
    timings 10111 192 32 34 14 160 6
endmode

    to your /etc/fb.modes --- it is the highest refresh rate my monitor
    supports for this resolution.

  - when you want to convert a modedb record from kernel to fb.modes format,
    look into the modedb database at drivers/video/modedb.c, the structure
    format is described in include/linux/fb.h. Probably the easiest way is to
    do variation of

fbset -xres 1024 -yres 768 -depth 24 -match -left .... -hslen ....

    with the values filled accordingly to the structure. Then run

fbset

    and insert the output (ONLY the lines shown above in the example) to
    /etc/fb.modes.

  - the most common refresh rates appear to be 60,70,85 ; kernel has also 76,
    while fbset knows about 75 ; obviously not all rates can be used with all
    resolutions, this is basically what I use with 1024x768 --- I think at
    least 60 should work with almost everything, though.

* try this patch

* be careful when including any vga=... parameters; if it doesn't work, try to
  remove them

* when something does not work, try to login blindly and type

fbset 800x600-60

  (or some other mode known to work). If nothing does happen, try to switch to
  some other console and back (however that probably means you are still using
  the old and broken driver).

* be careful when specifying the mode string at the kernel (lilo) commandline:

  - generally, the parameter will look like

video=radeon:<mode>

    (some more flags can follow, comma-separated)

  - you should always specify the refresh rate, otherwise the highest possible
    one could be used and your monitor may not handle it.

[PERHAPS-BUGREPORT]

  - BE CAREFUL when specifying depth! This is basically where I was most burnt,
    I kept specifying 24 but for some strange reason, this did very strange
    things here. If you will specify some other depth (8,15,16,32,...), you may
    experience problems with cursor (or it just won't work at all ;) --- it
    could have different colors (which will change by time), eventually
    disappearing completely (this could mean it just went black..?).

    The best solution is probably not to specify the depth at all. Apparently,
    24 is used by default, but it seems to work when chosen defaultly :^).

  - this is what I use:

video=radeon:1024x768@85

* don't try to use anything svgalibish. SvgaLib appears not to play well with
  Radeon's framebuffer w/ default configuration (I've managed to run zgv along
  nvidia fb) (or maybe it cannot handle Radeon at all..?) and it will complain
  about some register not being set high enough (admittelly, I didn't yet
  attempt to fix that and see what happens). The main thing is though that it
  leaves the card in some unknown mode and monitor goes sleep. See below.

* when you will have your Radeon in some weird state (after trying to run some
  svgalibish application or naively selecting vesa video output in mplayer or
  so..), you can either:

[PERHAPS-BUGREPORT]

  - startx or switch to X and back if you have it already running. This will
    repair it, but it won't reset all the flags (ie. accel), so you will get
    delays when switching to the affected console caused by video mode changes.

  - fbset on the affected console, which will also properly reset all these
    flags. You can obviously first get usable console by letting X to reset it
    and then running fbset on it, if you like to see what are you typing. Note
    that you should reset the console to the same mode you are running on the
    other consoles, otherwise you won't get rid of that delays.

[PERHAPS-BUGREPORT]

* you will have that ugly video mode change also the first time you switch to
  some console. This appears to be a bug, I think it could be fixed quite
  easily. You can either live with it or fix it or workaround it by doing
  something smart with for, seq and chvt in your rc scripts (let this be a
  homework ;-).


It is just a mix of generic fb usage advices and Radeon-specific ones... well,
what I had to discover by myself in the last few hours ;-). Perhaps it could
find a comfortable place in Documentation/fb/, dunno.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
A man once asked Mozart how to write a symphony. Mozart told him to study at
the conservatory for six or eight years, then apprentice with a composer for
four or five more years, then begin writing a few sonatas, pieces for string
quartets, piano concertos, etc. and in another four or five years he would be
ready to try a full symphony. The man said, "But Mozart, didn't you write a
symphony at age eight?" Mozart replied, "Yes, but I didn't have to ask how."
.
Stuff: http://pasky.ji.cz/
