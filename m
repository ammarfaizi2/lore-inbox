Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVBITSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVBITSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVBITSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:18:15 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:53407 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261711AbVBITRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:17:52 -0500
Date: Wed, 9 Feb 2005 20:18:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209191817.GA1534@ucw.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A518A.9040500@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 06:08:10PM +0000, Paulo Marques wrote:

> >>>I want serious support for ALL touchscreens in Linux.
> 
> I'm glad to hear it. I was just pointing out the "serial" part, because, 
> unlike USB and other interfaces, a serial port can not say "what" is 
> attached to it, so we need the "inputattach" method to explain to the 
> kernel what is there (and the irattach, pppd, etc.).

Touchscreens are one class of devices where the serial attachment is not
dying.

> >>Maybe I'd write drivers for the T-Sharc and fujitsu controllers, too.
> >>These are in a lot of POS hardware, too, and sometimes they're a pain to
> >>use (esp. calibration).
> >
> >Well, if you write them, send them my way. :)
> 
> I sometimes feel that we should have a "generic" touch screen driver 
> from looking at the code for the different brands.
> 
> Almost all touch screen data goes something like this:
> 
>  - every packet is fixed size, N bytes long
> 
>  - the "header" bytes can be described by <data> AND <mask> == 
> something expected
> 
>  - the X,Y,pressure,touch data can be described as "starting at bit B, 
> length N, multiply by Z". An array of these tokens should be able to 
> handle coordinates broken into several.
> 
> If this information could be passed as a module parameter, new 
> touchscreens could be supported without any kernel modification.
> 
> We could parse a definition "string", like this:
> 
> "SIZE:10,SYNC:0:8:85,SYNC:8:8:54,X:24:8:1,X:32:8:256,Y:40:8:1,Y:48:8:256,T:16:2:1"
> 
> This string defines the touch driver for elotouch, 10 bytes packet (I 
> didn't include the pressure reading, for simplification).
> 
> I currently have 6 different "drivers" that would all fit into this 
> model. The same goes for all 3 elotouch protocols that you implemented.
> 
> Does this sound like a good idea?

I don't think so. I don't think the saving of code is worth the
obfuscation, after all, 6 drivers is still not so much.

Also, direct code implementation can implement better synchronization
methods and faster resynchronization in case of lost bytes.

And then there are protocols like the Gunze one, which wouldn't be
covered by this.

> >>>I don't believe the mirroring/flipping is kernel's job, since it tries
> >>>to always pass the data with the least amount of transformation applied
> >>>to achieve hardware abstraction.
> 
> This is one argument that I don't quite understand. Doesn't hardware 
> abstraction mean that the application should receive the "same" data 
> regardless of the hardware.
> 
> I would say that the kernel would do a good job in abstracting hardware, 
> if it always returned X,Y coordinates from [0..65535] (or something like 
> that) in always the same direction, regardless of the actual hardware 
> involved...

I can understand that, however, when the only difference is in the
actual _mounting_ of the hardware ... I'm not so sure.

> >>ACK. Should be handled by XFree86's driver.
> 
> Unfortunately, I don't use any X driver (The application runs over the 
> framebuffer), and I don't think it is a good idea to force people to use it.

We could have a library that would do that and link applications against
it. It could also handle things like tap-n-drag, etc, something we
certainly don't want in the kernel.

> >>Additionally, there are two other things that need to be addressed (and
> >>I'm willing to actually write code for this, but need input from other
> >>parties, too:)
> >>
> >>	- Touchscreen calibration
> >>		Basically all these touchscreens are capable of being
> >>		calibrated. It's not done with just pushing the X/Y
> >>		values the kernel receives into the Input API. These
> >>		beasts may get physically mis-calibrated and eg. report
> >>		things like (xmax - xmin) <= 20, so resolution would be
> >>		really bad and kernel reported min/max values were only
> >>		"theoretical" values, based on the protocol specs.
> >>		I think about a simple X11 program for this. Comments?
> 
> Touch screens doing this are severely brain-damaged. And yes, I've come 
> across a few of them, but not lately.
> 
> I would say that a tool to recover the touch screen into a "usable" 
> state, by talking directly to the serial port, and "calibrating" it to 
> max possible / min possible values would be the best way to deal with this.

I agree with that. It could possibly even be put into the inputattach
init routine for the specific touchscreen.

> Modern touchscreens just send the A/D data to the PC, and let the real 
> processor do the math (it can even do more complex calculations, like 
> compensate for rotation, etc.). IMHO calibration should be handled by 
> software.

And this is something the kernel certainly won't do. Floating point math
is possible in the kernel with some jumping through hoops, but avoiding
it is usually the better option.

> >We probably don't want magnetic stripe data to go through the input
> >event stream (although it is possible to do that), so a new interface
> >would be most likely necessary.
> 
> It's even worse. Most keyboards don't separate the real keys from 
> magnetic stripe reader events, and just simulate key presses for MSR 
> data. They expect the software to be in a state where it is waiting for 
> that data, and will process it accordingly.

In that case I'm not sure if the kernel should care at all what the data
is.

> What we've done in our application is to use the timings and sequence of 
> key presses to distinguish between normal key presses and MSR data :P

Yes, embedded and single purpose systems are often full of hacks like
this.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
