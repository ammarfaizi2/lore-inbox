Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVBLSeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVBLSeX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVBLSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:34:22 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1951 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261181AbVBLSeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:34:09 -0500
Date: Sat, 12 Feb 2005 19:34:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050212183440.GC8170@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108227679.12327.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108227679.12327.24.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 06:01:19PM +0100, Kenan Esau wrote:
> Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik: 
> > Hi!
> > 
> > I've reimplemented the Lifebook touchscreen driver using libps2 and
> > input, to make it short and fitting into the kernel drivers.
> > 
> > Please comment on code and test for functionality!
> > 
> > PS.: The driver should register two input devices. It doesn't yet,
> > since that isn't very straightforward in the psmouse framework.
> 
> First of all it's good to see lifebook-support integrated. 
> 
> I have tested your driver on my box but the initialization fails. Do you
> have hardware available for testing? 

No, none at all.

> As far as I can see the
> init-sequence is the one from Haralds xfree 3.3.6-driver. There is a
> reason why this sequence is not like that anymore in my driver.

OK.

> This
> sequence does not always work and there is not something like a "magic
> knock sequence".

You mean that the only needed bit is setting the resolution to '7'?

> The lifebook-touchscreen hardware is a little bit slow
> and it happens quite often that it does not understand a command that
> you send.

I don't believe this - the PS/2 protocol has handshakes for both sides,
so each side can slow down as much as it wants. PLUS, the clock is
driven by the device.

> This is the reason why you often have to send a command
> several times until the hardware understands... 
> Probably this was what was seen by Harald on the USB-bus and he just
> used this sequence.

USB?!

> Second thing is that I am not shure that it is a good idea to integrate
> the lbtouch-support into the psmouse-driver since there is no real way
> of deciding if the device you are talking to is REALLY a
> lifebook-touchsreen or not. 

All normal PS/2 mice will fail on the SETRES 7 command. That's an
obligation given in the spec.

> You have put the init-sequence for the hw into the
> lifebook_detect-function which is not correct since this not really a
> "detect" but a HW-init. 

Since based on the result of the commands it decides whether there is
something (first command would fail), and whether it is a Fujitsu
TouchScreen (the SETRES 7 command would fail), it is a detection.

> IMHO the driver should be standalone and the user should decide which
> driver he wants to use. As default the touchscreen-functionality will be
> disabled and only the quick-point device will work like a normal
> PS2-mouse.

If it cannot be probed for, I agree.

But I still hope it can be probed for. Almost every PS/2 device has a
method. Maybe it's not known yet, maybe the SETRES 7 command is enough,
but I believe there is one.

> I also don't think that it is useful to have two devices for the
> touchscreen. I assume you want to have one device for relative movements
> and one for the absolute ones!?

Definitely.

> But for the implementor in userspace (X,
> SDL,...) it will be easier if ALL events from this HW-device come via
> one device-node. 

I believe it's much easier the other way around. X now has a event-based
mouse driver, and it might be a good idea to use its options on the
touchpoint on the lifebook.

> I attached the current version of my driver here so people can also have
> a look at it. I didn't release this version on my homepage yet and the
> only difference between the released version an this one is that the
> y-axis is swapped. I did this since all input devices seem to have a
> common idea of where y=0 is and my driver was the only one where y was
> just the other way round.

I think the driver I sent has the same problem.

> One more thing I observed by inspecting your code is that your
> untouch-event will never happen. 

I'll take a look.

> I think my driver works and is clean enough for integration into the
> kernel. We can talk about integrating calls to libps2 instead of doing
> the stuff myself (I am a big fan of preventing code-duplication) but
> don't you think it would be more wise to use a driver which works (since
> the very early 2.6-days) and build upon that instead of trying to
> implement your own one from the scratch and using snippets from very old
> and obsolete code?

I did the rewrite mainly because the code I had from you was doing
everything in its own way and I remember it was quite hard to
persuade back then to use the already existing helpers for that.

I also didn't at all like the 'make every little check a function of its
own' way it was done.

Similarly I don't see a reason why to filter all the touch/button data
changes in the driver, when the input layer does that for you.

If those things get fixed (which is not the case in your attached
driver), I'll gladly accept it.

But then, it'll be pretty similar to what I sent you. You can take that
as my vision of how the driver should look, even if it doesn't work as
it is.

> And as far as I can see you don't even have access to the hardware!?!?

You're right. But I simply can't have all the hardware I've written
drivers for - it wouldn't fit into my office.

But I may get some ... the lifebooks are pretty cheap these days.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
