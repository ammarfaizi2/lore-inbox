Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTIZH40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIZH40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:56:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:34698 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261364AbTIZH4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:56:23 -0400
Date: Fri, 26 Sep 2003 09:54:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, akpm@osdl.org, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030926075408.GA7330@ucw.cz>
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net> <20030925223032.GA32130@ucw.cz> <200309260224.54264.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309260224.54264.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 02:24:53AM -0500, Dmitry Torokhov wrote:
> On Thursday 25 September 2003 05:30 pm, Vojtech Pavlik wrote:
> > On Thu, Sep 25, 2003 at 01:23:33PM -0500, Dmitry Torokhov wrote:
> > > - Introducing BTN_TOUCH as far as I can seen does nothing to prevent
> > > joydev grabbing either Synaptics or touchscreens... Is there a patch
> > > missing?
> >
> > No. It's a statement you're missing near the beginning of
> > joydev_connect().
> >
> 
> Ok.. I see... and I hate it. We have a mechanism to match input devices to
> input handler and we violate it.

Well, the mechanism is: check the bit table, if doesn't match, go
forward to next handler. Then call the connect function, if it fails, go
to next handler.

Originally there only was the connect function which was doing all the
decisions, but that meant you have to load all the handler modules to
check if they will attach to a device. Now the number of modules is
limited, because the hotplug agent can check the tables.

But still the tables aren't (and will never be) the only way to decide
if a handler will attach to a specific device.

> What could be done is adding a black list
> to the input handler structure similar to the white list we have now. This
> way all matching conditions will be kept in one place...
> 
> ...But, unless I am missing something again, with introduction of BTN_TOUCH,
> tsdev now will happily claim Synaptics touchpads. We could filter it out
> by checking for example ABS_PRESSURE in tsdev but it would be just a another
> band aid. I could easily see a touch screen reporting pressure and multiple
> fingers. As far as capabilities go touchscreens are almost indistinguishable
> from touch pads, they just operate as true absolute devices.

You're right. And it's a problem.

> IMHO we should let input device driver explicitly request which input
> handler it wishes to bind to (for example by passing a bitmap of desired
> input handlers when registering input device and everyone binds to evdev). 
> It is not as flexible as capabilities checking solution but much more 
> simple and predictable. I do not thing that there will be that many handlers 
> implemented...

No, it won't work. It assumes that all the handlers are known
beforehand. Someone may want to load their own input handler module and
it wouldn't bind to any device, because it wouldn't be on the list.

Also, we need to communicate the information not just to kernel
handlers, but also to userspace programs/drivers ...

One thing I tried to avoid is a 'device class' kind of field, that'd
tell if a device is a mouse a touchpad, touchscreen, tablet, whatever.
I tried to avoid it because there are devices that don't fall into any
predefined class and if we make enough classes, someone someday will
make a device that won't fit again.

Adding a device class field and ioctl would solve the touchpad /
touchscreen problem nicely.

Another option is defining a set of features (events) a touchpad must
have and which a touchscreen must have and based on this do the decision
on the class. But now I think this is just another bandaid.

> Should I try to cook something along these lines?

If you do it the device-class way (be it an int or be it a bitmap), I
think it's worth trying.

> > > BTW, any chance on including pass-through patches? Do you want me to
> > > re-diff them?
> >
> > Hmm, I thought I've merged them in already, but obviously I did not.
> > Please resend them (rediffed if possible). Thanks.
> 
> I meant reconnect patches that Peter sent in his last mail, sorry for the
> confusion.

I don't think I'll apply those, sorry. We really should try to go the
driver-model way and not invent our own ways how to restore devices
hierarchically.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
