Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTKERCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTKERCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:02:52 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6117 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262993AbTKERCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:02:50 -0500
Date: Wed, 5 Nov 2003 18:02:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matt <dirtbird@ntlworld.com>, herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031105170217.GA27752@ucw.cz>
References: <3FA91493.7060009@ntlworld.com> <Pine.LNX.4.44.0311050818240.11208-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311050818240.11208-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 08:27:30AM -0800, Linus Torvalds wrote:
> 
> On Wed, 5 Nov 2003, Matt wrote:
> >
> > had excatly the same problem moving to test9-mm1, way i fixed it was to 
> > pass the options "psmouse_rate=60 psmouse_resolution=200" to the kernel 
> > at boot (these were the old defaults).
> 
> Can you guys test passing in "psmouse_noext=1" instead?
> 
> The thing is, the psmouse initialization in 2.4.x does _nothing_. Nada. 
> Zilch. Zero. And it obviously works fine. So the 2.6.x code is apparently 
> just _crap_.
> 
> The extended psmouse detection code will try different things, and one 
> thing in particular is that the Logitech magic ID matching sets the 
> resolution to zero, while the IntelliMouse thing sets the rate to 80.
> 
> I don't know what the proper thing to do is, but I'm pretty certain that
> the current mouse initialization has got to go. It clearly breaks setups
> that worked fine in 2.4.x, and the 2.6.x doesn't actually have any
> _advantages_ that I can tell. Maybe Vojtech can inform us.
> 
> Passing in "psmouse_noext=1" gets you close to 2.4.x behaviour.
 
The main problem here is actually how the X/GPM mouse acceleration
works. It has a certain threshold in mixels per update after which it
begins multiplying the values coming from a mouse by a user settable
multiplier.

The problem is in "mixels per update". It's not in "mixels per second",
which means that if you change the updates per second value, the
threshold kicks in at a different mouse speed.

This of course annoys people. Both ways. I've got a bunch of mails that
mouse worked just fine with psmouse_rate=200 (or 2.5.* code, which is
the equivalent) and that the default settings (same as 2.4) are utter
crap. And I've also got a bunch of mails stating the opposite.

Also, all the complaints started coming in only after I changed the
default value down from 200. This was unfortunately needed because of
old machines where the i8042 will ignore all keyboard input if mouse
input is available and the mouse is able to saturate the cable at 200
updates per second.

The reason to use a high rate of updates per second is that the more
updates per second you get, the more snappy the system feels. Suddenly
windows are dragged smoothly on the screen and in GIMP the
freehand-drawn curves are actually curves and not just polygons. Also,
fine pointing is much easier, because the hand-mouse-screen-eye feedback
loop is faster.

Imagine what life used to be with old serial mice. That's the same, only
exaggerated.

Regarding removing all extension support from the psmouse driver in the
kernel, well, then we can ditch the input core completely, because the
only way to make your mouse wheel work will be to let X access the PS/2
port directly again, with all the problems that causes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
