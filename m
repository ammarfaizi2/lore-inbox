Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTISI3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbTISI3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:29:45 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:33987 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261433AbTISI3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:29:42 -0400
Date: Fri, 19 Sep 2003 10:29:38 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063957248.603.38.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309191005270.17132-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Sep 2003, Benjamin Herrenschmidt wrote:

> I need a brown paper bag here. A while ago (maybe 3 years), ATI send me
> a list of RefClk/MCLK/XCLK for their entire line of Mac chips with the
> Open Firmware node name so we could identify them. Some way, I lost that
> list (disk crash)... It was covering all "Mac" mach64 boards and a bunch
> of the r128 ones iirc. We don't need that as badly on recent machines as
> recent ATI cards provide the RefClk in the device-tree

Well, we don't need it on Mach64 either. It's just that the current code
starts reprogramming the clocks; allthough the BIOS/firmware already does
a fine job. The advantage of the current code is that we have built-in overclking
facilities and perhaps that the chips can be initialized in very lowlevel
situations where the BIOS/firmware did not initialize yet. But it is a bit
questionable if that works at all; especially the Rage chips have a lot of
vital registers that atyfb does not touch.

> and we don't need to mess with the MLCK/XCLK any more on radeons.

Actually I think we need that urgently. I cannot have my Inspiron 4500
laptop (Radeon 7500) on my, ehm, what's the english word, upper legs or
something, for along time, the amount of heat generated is incredible.
In Windows this is not a problem, only when you start playing games it gets hot.

> > Okay.... By the way, how shall we get the powermanagement code to work on
> > x86? As far as I saw that register backlight procedure exists only on PowerPC.
>
> The backlight "core" is a simple thing I did for PowerBook (since the
> backlight can be either done by the ATI chip or by some other uController
> on the motherboard). This current implementation is only suitable for
> a single panel and isn't something worth extending I beleive.
>
> Better would be to add proper backlight/frontlight/contrast control to
> 2.6 via the generic monitor infrastructure, maybe via sysfs. This covers
> more than just laptops: Flat panels on ADC/DVI can have USB controlled
> backlight, things like CRT iMacs have a chip that allow to control
> brightness & all of the geometry settings via i2c etc... We would need
> a common interface to userland for these at least, even if the actual
> implementation in the drivers is full of platform specific hooks, there
> is not much we can do about it for now I'm afraid.

> The sleep code is something specific to the way those chips are put
> to sleep on Macs. AFAIK, their clock is removed but not their power.
> I don't know if that can be useful on any x86 laptop...

I have some experience with that.

Because of the way the Atyfb is currently designed, mclk could be an
artbitrary value and adding XCLK to the table would mean XCLK could be an
arbitrary value. But without using SCLK, they need to be relative to each
other i.e. 1/2 3/4 2/3 etc.

Luckily the BIOS on my Rage LT Pro did use SCLK to clock the engine,
without that I would never had solved this. And I never found any other
card that did use SCLK by default. By having the engine clocked
by SCLK instead of MCLK, you can have both frequencies completely
independend, just like what was needed.

It was easier said than done, everytime I did submit code to someone I got
the reply the computer did crash. I was unable to get this resolved until
I had a Dell laptop temporarily available to me, which did not crash
allways, it was just completely random wether the driver would load or
not.

As far as I believe now, after you start the SCLK, it doesn't work at
once. You have to wait a while before a good clock signal is generated.
Adding a primitive wait loop did solve the problem for about anyone.

The conclusion is that the chip cannot be without clock signal even for a
very short time and it even locks up the AGP so the rest of the computer
hangs.

It must be possible to stop the clock; I have a Rage IIc here with a
broken BIOS, experiments on it show that you can enable the chip using the
PCI registers without any clock running. Of course I never got the card to
display anything.

Greetings,

Daniël Mantione

