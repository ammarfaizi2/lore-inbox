Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVBISIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVBISIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVBISIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:08:49 -0500
Received: from [195.23.16.24] ([195.23.16.24]:4073 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261866AbVBISIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:08:22 -0500
Message-ID: <420A518A.9040500@grupopie.com>
Date: Wed, 09 Feb 2005 18:08:10 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz>
In-Reply-To: <20050209173026.GA17797@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Feb 09, 2005 at 06:14:38PM +0100, Jan-Benedict Glaw wrote:
> 
>>>I want serious support for ALL touchscreens in Linux.

I'm glad to hear it. I was just pointing out the "serial" part, because, 
unlike USB and other interfaces, a serial port can not say "what" is 
attached to it, so we need the "inputattach" method to explain to the 
kernel what is there (and the irattach, pppd, etc.).

>>Maybe I'd write drivers for the T-Sharc and fujitsu controllers, too.
>>These are in a lot of POS hardware, too, and sometimes they're a pain to
>>use (esp. calibration).
> 
> Well, if you write them, send them my way. :)

I sometimes feel that we should have a "generic" touch screen driver 
from looking at the code for the different brands.

Almost all touch screen data goes something like this:

  - every packet is fixed size, N bytes long

  - the "header" bytes can be described by <data> AND <mask> == 
something expected

  - the X,Y,pressure,touch data can be described as "starting at bit B, 
length N, multiply by Z". An array of these tokens should be able to 
handle coordinates broken into several.

If this information could be passed as a module parameter, new 
touchscreens could be supported without any kernel modification.

We could parse a definition "string", like this:

"SIZE:10,SYNC:0:8:85,SYNC:8:8:54,X:24:8:1,X:32:8:256,Y:40:8:1,Y:48:8:256,T:16:2:1"

This string defines the touch driver for elotouch, 10 bytes packet (I 
didn't include the pressure reading, for simplification).

I currently have 6 different "drivers" that would all fit into this 
model. The same goes for all 3 elotouch protocols that you implemented.

Does this sound like a good idea?

>>If I find a minute, I'll possibly give it a test run. I've got actual
>>hardware around.
> 
> 
> Thanks!
> 
> 
>[...]
>>>I don't believe the mirroring/flipping is kernel's job, since it tries
>>>to always pass the data with the least amount of transformation applied
>>>to achieve hardware abstraction.

This is one argument that I don't quite understand. Doesn't hardware 
abstraction mean that the application should receive the "same" data 
regardless of the hardware.

I would say that the kernel would do a good job in abstracting hardware, 
if it always returned X,Y coordinates from [0..65535] (or something like 
that) in always the same direction, regardless of the actual hardware 
involved...

>>ACK. Should be handled by XFree86's driver.

Unfortunately, I don't use any X driver (The application runs over the 
framebuffer), and I don't think it is a good idea to force people to use it.

>>Additionally, there are two other things that need to be addressed (and
>>I'm willing to actually write code for this, but need input from other
>>parties, too:)
>>
>>	- Touchscreen calibration
>>		Basically all these touchscreens are capable of being
>>		calibrated. It's not done with just pushing the X/Y
>>		values the kernel receives into the Input API. These
>>		beasts may get physically mis-calibrated and eg. report
>>		things like (xmax - xmin) <= 20, so resolution would be
>>		really bad and kernel reported min/max values were only
>>		"theoretical" values, based on the protocol specs.
>>		I think about a simple X11 program for this. Comments?

Touch screens doing this are severely brain-damaged. And yes, I've come 
across a few of them, but not lately.

I would say that a tool to recover the touch screen into a "usable" 
state, by talking directly to the serial port, and "calibrating" it to 
max possible / min possible values would be the best way to deal with this.

Modern touchscreens just send the A/D data to the PC, and let the real 
processor do the math (it can even do more complex calculations, like 
compensate for rotation, etc.). IMHO calibration should be handled by 
software.

>>	- POS keyboards
>>		These are real beasties. Next to LEDs and keycaps, they
>>		can contain barcode scanners, magnetic card readers and
>>		displays. Right now, there's no good API to pass
>>		something as complex as "three-track magnetic stripe
>>		data" or a whole scanned EAN barcode. Also, some
>>		keyboards can be written to (change display contents,
>>		switch on/off scanners, ...).
> 
> 
> We probably don't want magnetic stripe data to go through the input
> event stream (although it is possible to do that), so a new interface
> would be most likely necessary.

It's even worse. Most keyboards don't separate the real keys from 
magnetic stripe reader events, and just simulate key presses for MSR 
data. They expect the software to be in a state where it is waiting for 
that data, and will process it accordingly.

What we've done in our application is to use the timings and sequence of 
key presses to distinguish between normal key presses and MSR data :P

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
