Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTKESBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTKESBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:01:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:8934 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263018AbTKESBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:01:08 -0500
Date: Wed, 5 Nov 2003 19:00:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Matt <dirtbird@ntlworld.com>,
       herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031105180035.GB27922@ucw.cz>
References: <20031105170217.GA27752@ucw.cz> <Pine.LNX.4.44.0311050920080.11208-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311050920080.11208-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 09:36:28AM -0800, Linus Torvalds wrote:


> The alternative approach is to _not_ try to autodetect and leave it in a
> sane default state - or at least leaving the detection to a minimum, but
> having sane ways of letting the user set the thing.

Would sysfs be a sane enough way?

> As an example, the old psaux driver allowed the user to _send_ to the
> mouse, not just receive. That made it possible for user mode to autodetect
> the mouse, and set the settings. The input-mode mouse driver totally drops
> that feature - which forces the kernel to get it right.
> 
> That's a very fragile design: making feedback impossible means that you
> have to always get it right - which in turn tends to be fundamentally
> impossible (ie new mice etc). And right now we force the user to make the
> choice at _boot_ time, which means that the installer can't even ask the
> user.

I agree here.

In the original design I assumed the PS/2 hardware is sane enough to be
(auto)detectable. Most other hardware is, so why not PS/2 mice? It has
become obvious that there are many caveats and many broken devices (most
notably KVMs and notebook transparent mux chips) in the equation.

I still would prefer to have the autodetect be enabled, because it works
for 99% of the cases and allow to set the mouse protocol manually
(either boot time or via sysfs) for the troublesome cases.

If psmouse.o is a module, the installer of course can ask the user. 

> Also, some of the autodetect code is less intrusive. For example, if the
> mouse driver decides it's a Logitech mouse, it will have set the
> resolution down to zero, but it will have left the reporting rate at the
> default.

Originally, the psmouse code set all the resolution/rate/scaling to sane
values after the detection was run. It does that only conditionally now,
which causes a lot of problems with the intrusiveness of the probing.

There are four approaches:
	1) Kill some of the probes (but having the MS one is needed for 80% of mice)
	2) Get the values from the mouse and restore them after probing
	3) Set the mouse to sane values like before
	4) detect -> reset -> initialize

IMO sane values are
	* 80 samples/sec
		+ interactive enough, about the same as the refresh rate
		  of the monitor - you never can actually see a smoother
		  movement than your monitor HZ
		+ slow enough that old hardware doesn't choke

	* 400 dpi
		+ simply the default. 99% USB mice are 400 dpi by
		  default, and PS/2 mice at least 90%

	* 1:1 scaling
		+ has anyone ever changed this one?

Nevertheless, we probably cannot stop at least two of these three groups
of people from complaining:

	* 2.5.* users will see erratic movement of their X cursor if
	  they set mouse acceleration to insane values, because 200
          samples/sec rate used through 2.5 effectively disabled
	  mouse acceleration.

	* 2.4 users will see mouse 'slowdown', because 2.4 default 
	  (or better the HW default) is 60 samples/sec (thus the
	  speed when acceleration kicks in goes up 1.33x)

	* 2.4 users who have set up different speed/res/scale values
	  in XF86Config, because those are ignored in 2.6

> In contrast, an unrecognized mouse will have gone through the intellimouse
> test, which will have set the rate down to 80 (in addition to having the
> resolution set down to the lowest setting by the Logitech detect code). So
> now some mice get even _worse_ behaviour. Or at least different.

Agreed, this is simply WRONG. We need to have the mouse set to defined
speed/resolution/scaling after we probe. Options listed above.

> Right now we can't make big changes, but it would be good to think about 
> the issues.
> 
> And we could make the defaults a bit nicer and less likely to screw up.
> 
> 		Linus

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
