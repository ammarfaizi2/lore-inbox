Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUHIQGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUHIQGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUHIQGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:06:52 -0400
Received: from digitalimplant.org ([64.62.235.95]:14302 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266725AbUHIQCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:02:39 -0400
Date: Mon, 9 Aug 2004 09:02:30 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, "" <benh@kernel.crashing.org>,
       "" <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <20040809113829.GB9793@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <20040809113829.GB9793@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Pavel Machek wrote:

> > - ->dev_stop() and ->dev_start() to struct class
> >   This provides the framework to shutdown a device from a functional
> >   level, rather than at a hardware level, as well as the entry points
> >   to stop/start ALL devices in the system.
>
> Hmm, that will need lots of new code to call these, right? Like
> device_suspend() will now get device_stop() equivalent, etc....

Uh, not really. During suspend-to-disk, you would call

	device_stop();
	device_save();
	<snapshot system>
	class_device_start(suspend_device);
	<write snapshot>
	class_device_stop(suspend_device);
	device_power_down(state);

> >   This is implemented by iterating through the list of struct classes,
> >   then through each of their struct class_device's. The class_device is
> >   the only argument to those functions.
>
> Aha, so you are saying these do not need to be done in hardware order?

AFAICT, no.

> Semantics of dev_stop is "may not do DMA and interrupts when stopped",
> right?

To be more precise, "device is not processing any transactions and will
not be used to submit more to". It's up to the class to remove it from any
queues, etc, so DMA never has a chance to begin.

> I do not think we want to see "u32 state" any more. This really needs
> to be specified as "enum something" otherwise everyone will get it
> wrong... again.

That's not the point, at least at this stage. Eventually, the u32 could be
replaced with an enum. But, remember why there is confusion - the value of
the system suspend level was also passed to the drivers as the device
suspend level. If you read the email again and look at the code, you will
see that drivers always get passed a 'struct pm_state', and the 'u32' are
only used between the suspend imeplementations and the driver core (which
is the re-mapper). I think compile-time checks are good, but we're in
bigger trouble if we can't get a half-dozen calls using the right value..

> > pointers, that is in dev->power.pm_system. The pointers in that array
> > point to entries in dev->power.pm_supports, which is an array of all the
> > device power states that device supports. Please see include/linux/pm.h in
> > the patch below. These arrays should be initialized by the bus, though
> > they can be fixed up by the individual drivers, should they have a
> > different set of states they support, or given user policy.
>
> I'd simply pass system state down to the driver, and let them map as
> they see fit... This seems to be way too complex. OTOH you are solving
> 'runtime suspend', too...

It's not too complex; it's simply that the driver core is the one
responsible between mapping a system suspend state to the device suspend
state, based on values that the driver knows a priori. If you push that
responsibility down to the drivers, you require all of them to implement
the same thing, causing code duplication, which means more copy-n-pasting,
and more of a chance to get it wrong. If we choose to do it once and right
in the driver core, the resulting drivers become simpler, since they only
have to respond to something that says "enter this power state, damnit"

On the other hand, if it's too complicated for you, I encourage you to
modify the patch or create a new one that solves all of the problems in a
simpler manner.

> > +enum {
> > +	pm_sys_ON = 1,
> > +	pm_sys_SHUTDOWN,
> > +	pm_sys_RESET,
> > +	pm_sys_STANDBY,
> > +	pm_sys_SUSPEND,
> > +	pm_sys_HIBERNATE,
> > +	pm_sys_NUM,
> > +};
>
> I believe different state is needed for "quiesce for atomic copy" and
> for "we are really going down to S4 now".

There is nothing fundamentally different at the functional level - you
don't want any devices fulfilling any request. Besides, by the time the
system is actually ready to be placed in S4, the devices have long-since
been stopped, and the class devices do not need another notification
beyond "stop"

Thanks,


	Pat

