Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUBWTAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUBWTAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:00:17 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:63247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262000AbUBWTAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:00:03 -0500
Date: Mon, 23 Feb 2004 18:59:58 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fbdv/fbcon pending problems
In-Reply-To: <1077497593.5960.28.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's a list of pending issues with fbdev (either upstream or in the
> fbdev bk treee), I figured posting it here may help getting more people
> on those issues as my time is sparse and I suppose James too.

A bit. I managed to create the first crack at the ioremap problem with 
machines with lots of memory. Had some problems tho.
 
>  - First one, I will deal with, just writing it for completeness: When
> switching from KD_GRAPHICS to KD_TEXT (either same console changing mode
> or switching to a different console), we need a callback so the fbdev
> has a chance to restore the accel engine setting (or even the whole
> mode, to be safe).

This is a big problem. It's been around since the beginning of time. Also 
we have the case of fbdev/vgacon systems. Alot fo work has to be done 
here.

>  - Memory corruption problems. There is still at least one identified
> when using stty. Just use crazy values, like flipping rows & cols (like
> stty rows 132 cols 30) and usually, you'll see the box blow up very soon
> with heavy memory corruption.

Ug. I have to hunt down this problem.

>  - Logo problems. When booting with a logo, then going to getty, the
> logo doesn't get erased until we actually switch to another console (or
> reset the console). At this point, using things like vi & scrolling up
> doesn't work properly. Actually, last time I tried, I had to switch
> back & forth twice before my console that had the logo got fully working
> with vi.

Also been around for ever. I think that will be a much easier fix.

>  - Back buffer problem: maybe related to the logo ? After boot, doing
> shift-pageup to go back to the boot message, usually you get crap
> displayed at various places.

strange. I don't have that problem on my systems.

>  - On x86, various junk displayed when the fbdev takes over. Reported
> by radeonfb users, I couldn't test myself, I don't have an x86 with
> radeon at hand for the moment. Apparently, the takeover from vgacon
> doesn't properly "convert" the previous VGA text buffer content

I have to try that one out. I know I haven't seen the problem if you
have a fbdev driver and fbcon modular and load them. 
 
>  - stty & mode picking. Currently, fbcon_resize() (called when stty is
> used to resize the console) will hack a "var" strcture by just putting
> new width/height in it and pass that to set_var. The way the various
> drivers react to that mostly broken "var" structure is rather random.
> We need to explicitely differenciate between a mode that is "complete"
> (like what fbset or X passes down the fbdev) or a mode that is just
> width/height and eventually a hint of frequency, like what fbcon passes
> in this case. I added FB_ACTIVATE_FIND for that purpose, but that needs
> better driver support to "pick" up a proper mode. The algorithm for
> that isn't trivial. Could be moved to common code.

I think we should do better validating of the var passed in. This also 
needs a bit of work. 

>  - fbset doesn't resize the console. I consider that a regression from
> 2.4. I have some code based on the notification mecanism to address
> that, but it tends to trigger the same memory corruption problem as
> reported with stty & bogus coordinates. There is something hairy going
> on with console resizes. That code is a bit foreign to me though.

I had problems as well. I will have to work on it. 

Other problems have to deal with multiheaded system. Fbcon is multihead 
safe. Alot of gloabl variables that are shared with different framebuffers.
Also the mapping at boot time is really broke. That laso has had problems 
for ages :-( 


