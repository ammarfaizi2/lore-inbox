Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVBJPgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVBJPgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVBJPgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:36:11 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60121 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262142AbVBJPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:36:01 -0500
Message-ID: <420B7F40.9080308@grupopie.com>
Date: Thu, 10 Feb 2005 15:35:28 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
References: <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de> <20050209215335.GA2634@ucw.cz> <20050210104655.GO10594@lug-owl.de> <420B5C66.8040408@grupopie.com> <20050210134311.GP10594@lug-owl.de>
In-Reply-To: <20050210134311.GP10594@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Thu, 2005-02-10 13:06:46 +0000, Paulo Marques <pmarques@grupopie.com>
> wrote in message <420B5C66.8040408@grupopie.com>:
> [...]
>>To get raw values that are (xmax-xmin)<=20, the TS controller must be 
>>"trying" to do some calibration itself.
> 
> 
> All touchscreens get calibrated once during their production AFAIK. This
> should result at least in a "useable" resolution. ...but have a tight
> look at today's touches: their [xy]{min,max} values don't cover all the
> theoretical range of values that could be sent with the protocol in use.
> Just taking an example, one screen here (it has never ever been
> physically recalibrated except right after production) used values (for
> X as well as for Y) in the range of about [350..3800]. The protocol does
> allow a lot more...

This happens because the touch area is in fact a little larger than the 
screen (and there are probably some protection resistors in series with 
the touch) and you have 12-bit A/D that should give values [0..4095]. 
You still have more than enough range to calibrate in software.

The protocol has nothing to do with this. It is the number of bits in 
the A/D converter that matter. Usually you will have 2 bytes for each 
coordinate but only N bits will actually contain data, with N being the 
A/D resolution.

>>That's the brain-damaged part.
> 
> 
> It's not :)  The foil layers aren't all that equal after production.
> They're (from the protocol point of view) generalized by calibrating
> them once (during production). However, if the screen gets injured, this
> must either be re-done, or the screen may need to be replaced. However,
> replacing parts in the field is expensive and service staff tries to not
> do that, but instead a recalibration is tried first. IFF the touchscreen
> is then found to be *really* dead, it's replaced.

So you're seriously saying that a perfectly good touchscreen, that 
returned values in the range [350..3800] after being injured might give 
values in a range (xmax-xmin)<=20 ???  That's a pretty nasty injury...

More to the point, usually when you send calibration data into the TS 
controller, it doesn't change anything at the analog level, it only 
makes the controller do some math on the A/D data before sending it to 
the PC. That doesn't help us at all.

>>The TS controller should not be doing any calibration at all, and send 
>>the widest range it can through the serial port to the PC.
> 
> 
> But it needs to know the exact range of possible resistance/capacity to
> be able to do that. This is where the trouble starts that I'm talking
> about. Of course you can *assume* that capacity will be in a
> (well-known) range (you know the range because you can just test a
> production example), but this range is a bit different for each
> touchscreen produced, let alone the fact that the foils may get
> scratches or other injuries. In a bad case, you get a near-short-circuit
> so that your (new) range of values is near-zero. Recalibrating the A/D
> converter may revive this almost-dead screen.

The way a resistive touchscreen works, the controller doesn't need to 
know at all the value of the total resistance. A capacitive TS might 
need some calibration, but nowhere near to the amount that makes a 12 
bit A/D return a 4/5 bit range.

In more than 10 years of touch screen usage, I've never seen a case like 
you describe, so it's pretty hard for me to believe that:

a) you can get a resistive touch screen to give values (xmin-xmax)<=20 
just by injuring it, but in a way that it can be revived

b) you can revive it by just changing the calibration parameters on the 
TS controller

I believe you can make a touch screen controller return values in a very 
short range if you try to use its internal calibration and mess up the 
values really badly. In this case, recalibrating will almost certainly 
make it work again.

>[...]
> Right, but there are two kinds of calibration:
> 
> (1) Mapping the raw capacity/resistor values (that only the TS controller
>     is aware of) to something the HID API can output. (This, too, includes
>     that the kernel dictates the range of values that can be reached).

I would really like to see a datasheet of a TS controller that actually 
does this, before we start working on a solution for it.

By the way, this has nothing to do with the kernel. The input API can 
deliver at least 16 bit resolution to user space, so there is no 
limitation on the software side. It is the A/D resolution that matters.

> [...]
> However, the hardware-internal mapping (1) isn't covered anywhere right
> now. This usually isn't much of a problem during real use, but it *is* a
> problem if the hardware ever gets damaged (or the controller's flash
> breaks). 

Why would a flash break if you never write to it? I would expect the TS 
layers to be damaged before any electronic part gets broken...

> Ever tried to use a serial sniffer on vendor's original MS
> Windows drivers? They almost always update the controller's internal
> mapping, too.

That is because they were done by the same brain-damaged people that 
didn't yet realize that a PC can do the couple of multiplications / 
divisions necessary in a few nanoseconds and still believe that the TS 
controller is "alleviating" the burden of the PC by doing that _complex_ 
math itself :P

>[...]
>>Actually a calibration that can do scaling and rotation, can 
>>automatically compensate for mirroring and/or switched X/Y axes. We 
>>probably need the user to press 4 points for that, though (3 points are 
>>enough, but just barely enough).
> 
> 
> ACK. We'd do a lib for that and have a X11 driver to make use of it.

Ok, lets start working on it then :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
