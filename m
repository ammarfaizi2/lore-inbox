Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUBWXAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUBWW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:59:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:64945 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262071AbUBWW6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:58:22 -0500
Subject: Re: fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077576644.5960.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 09:50:44 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 05:59, James Simmons wrote:
> > Here's a list of pending issues with fbdev (either upstream or in the
> > fbdev bk treee), I figured posting it here may help getting more people
> > on those issues as my time is sparse and I suppose James too.
> 
> A bit. I managed to create the first crack at the ioremap problem with 
> machines with lots of memory. Had some problems tho.

I worked around this one in radeonfb by only mapping part of the
framebuffer (see current version in linus tree), but that's sub
optimal. Better is to implement full accel and not map the fb
at all. But good enough for now, the other problems are more
important imho.

> This is a big problem. It's been around since the beginning of time. Also 
> we have the case of fbdev/vgacon systems. Alot fo work has to be done 
> here.

Yes. Working on it.

> >  - Memory corruption problems. There is still at least one identified
> > when using stty. Just use crazy values, like flipping rows & cols (like
> > stty rows 132 cols 30) and usually, you'll see the box blow up very soon
> > with heavy memory corruption.
> 
> Ug. I have to hunt down this problem.

I would appreciate if you did so ;) Please let me know what you find.

> >  - Logo problems. When booting with a logo, then going to getty, the
> > logo doesn't get erased until we actually switch to another console (or
> > reset the console). At this point, using things like vi & scrolling up
> > doesn't work properly. Actually, last time I tried, I had to switch
> > back & forth twice before my console that had the logo got fully working
> > with vi.
> 
> Also been around for ever. I think that will be a much easier fix.

Ok.

> >  - Back buffer problem: maybe related to the logo ? After boot, doing
> > shift-pageup to go back to the boot message, usually you get crap
> > displayed at various places.
> 
> strange. I don't have that problem on my systems.

I have this problem since the very beginning. The very first
shift-pageup to display things properly from the back buffer, but to not
_erase_ properly, until you do a bit of ping pong (down up down up) so
that your screen end up properly refreshed.

> >  - On x86, various junk displayed when the fbdev takes over. Reported
> > by radeonfb users, I couldn't test myself, I don't have an x86 with
> > radeon at hand for the moment. Apparently, the takeover from vgacon
> > doesn't properly "convert" the previous VGA text buffer content
> 
> I have to try that one out. I know I haven't seen the problem if you
> have a fbdev driver and fbcon modular and load them. 

I never use modules for fbdevs
 
> I think we should do better validating of the var passed in. This also 
> needs a bit of work. 

It does. Radeonfb did one step in this direction, but that's not
enough. _BUT_ we still need to differenciate between a full mode 
passed from userland from a mode where we _KNOW_ everything is
bogus but width/height... In the later case, we really want to
find a mode that is just large enough for the passed in width/height
(but not smaller, or just fail if not found) and with the same
hfreq if possible as the current mode. That's really a different
request than a full blown mode coming from userland (like a 'tuning'
tool or whatever...)

The FB_ACTIVATE_FIND is just that. It justs tells the driver to
pick up a mode based on width/height only. We know the rest of
the var is bogus.

> I had problems as well. I will have to work on it. 
> 
> Other problems have to deal with multiheaded system. Fbcon is multihead 
> safe. Alot of gloabl variables that are shared with different framebuffers.
> Also the mapping at boot time is really broke. That laso has had problems 
> for ages :-( 

Yes, but that's less urgent than the other ones. We really need to fix
those basic behaviour problems before multihead. Multihead will come
later as I will implement dual head support in radeonfb. That leads to
a while bunch of problems with the userland API that need to be improed
too, and that leads to the problem of properly soft booting additional
cards. I have various ideas to address those problems, but that's
definitely less urgent than the list I wrote down.

Ben.


