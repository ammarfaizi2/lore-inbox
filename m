Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUBYHPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUBYHPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:15:02 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:18699 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id S262647AbUBYHO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:14:58 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 18:14:50 +1100
User-Agent: KMail/1.5.4
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1077497593.5960.28.camel@gaston> <200402241657.37382.sgy-lkml@amc.com.au> <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402251812.26624.sgy-lkml@amc.com.au>
Organization: AMC Enterprises P/L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 07:36 pm, Geert Uytterhoeven wrote:
> On Tue, 24 Feb 2004, Stuart Young wrote:
> > On Mon, 23 Feb 2004 11:53 am, Benjamin Herrenschmidt wrote:
> > >  - Logo problems. When booting with a logo, then going to getty, the
> > > logo doesn't get erased until we actually switch to another console (or
> > > reset the console). At this point, using things like vi & scrolling up
> > > doesn't work properly. Actually, last time I tried, I had to switch
> > > back & forth twice before my console that had the logo got fully
> > > working with vi.
> >
> > If it's possible to unlock this region so that it scrolls again from
> > userspace (ie: not resetting/clearing it, just unlocking it), then it's
> > just a simple matter of checking wether the current console is an fb
> > device, and if it is, making it unlock the scrolling region. In Debian,
> > this could be done in /etc/init.d/rmnologin, or even in /etc/profile if
> > someone would rather it done after login.
>
> There should be an ANSI escape sequence for resetting the scroll region.
> Just send that to the console.

Yup there is. It's Esc [r , however this also returns the cursor to the top of 
the screen. You can use Esc [s & Esc [u to save and restore the current 
cursor position, so it's just a matter of putting them around it thus:
 Esc [s Esc [r Esc [u

Or with echo (in a bash script - \\'s to escape it from the shell):
 echo -ne \\033[s\\033[r\\033[u

Now there is a problem with this solution: This leaves the logo (and any 
boot-time drawn graphics in the unscrollable region) on the screen. When text 
scrolls up the screen, these graphics do not scroll, and are only removed 
when a character overwrites the graphics position on the screen. If you have 
a number of graphics on the screen (or a machine with a number of processors, 
and therefore a number of tux logos), you'll find that you end up with 
spurious graphical artifacts left on the display where the text hasn't 
directly overwritten the image.

Now you'd think that you could easily just wipe (n) lines off the screen, 
probably using ansi escape sequences. Well it sort of works, but then you 
need to know how big the logo is, how big the font is (as you're working with 
an ascii to graphical representation), and just how much of the screen to 
wipe, to get it right for all the various fbcon display arrangements. While 
the info might be available to userspace to figure this out, it stops being 
simple.

Probably could just talk to the fb driver directly (from the shell) and wipe 
that section of screen. Fun fun fun... Hrm.. Time to look into it.

Of course, you could just clear the screen.....

Note: Fixing this in a binary is pretty much a no-no. How many dists will want 
to add another binary to their systems, or patch something like getty simply 
to fix a display artifact? I'm guessing pretty close to the 0 mark.

--
 Stuart Young - sgy-lkml@amc.com.au is specifically for LKML and related email

