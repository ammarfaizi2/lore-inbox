Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUHJEzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUHJEzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267428AbUHJEzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:55:44 -0400
Received: from digitalimplant.org ([64.62.235.95]:12173 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267427AbUHJEzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:55:41 -0400
Date: Mon, 9 Aug 2004 21:55:29 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <1092098425.14102.69.camel@gaston>
Message-ID: <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <1092098425.14102.69.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Benjamin Herrenschmidt wrote:

> >   This is implemented by iterating through the list of struct classes,
> >   then through each of their struct class_device's. The class_device is
> >   the only argument to those functions.
>
> Hrm... I don't agree, that iteration should be done in bus ordering too.
>
> For example, if you stop operation of a USB host controller, you have to
> do that after you have stopped operation of child devices. Same goes
> with the ATA disk vs. controller. The ordering requirements for stopping
> operations are the same as for PM

It's easy enough to change which order things get stopped/started in. What
matters more is the conceptual shift in responsibility for who
stops/starts the devices, or rather their interfaces.

It also requires a mapping from struct device -> struct class_device that
the drivers will have to initialize.

> What about passing the previous state to restore ? could be useful...

It's saved in dev->power.pm_resume, so drivers can check it.

> > - To struct bus_type:
> >
> > 	int             (*pm_power)(struct device *, struct pm_state *);
> >
> >   This method is used to do all power transitions, including both
> >   shutdown/reset and device power management states.
>
> Who calls it ? It's the driver calling it's bus or what ? It make no
> sense to power manage a device before suspending activity... I agree it
> may be worth splitting dev_start/stop from PM transitions proper, that
> would help dealing with various policies, however, there are still some
> dependencies between those, and they all need to be tied to the bus
> topology.

The driver core calls it in device_power_down() (as was in the patch ;),
in physical topological order. The ordering of the calls is up the power
management core, but it just wouldn't make sense to power down a device
that wasn't stopped. Would be easy enough to add a check for it..

Note it would make sense to power down a device without stopping, if the
device had no device driver bound to it (e.g. unclaimed devices that are
in D0 unnecessarily; or unclaimed devices that need to be powered down
during a suspend transition).

> What about partial tree ? We need to suspend childs first and we need to
> tied PM transition with dev_start/stop (or have some way to indicate the
> device we want it to auto-resume when it gets a request, or something).
> We need to work out policy a bit more here I suppose...

Policy can come later; we have to have a working model first.

As far as partial trees go, it can be done using the posted patch.  Think
about why you want to suspend/resume a partial tree - to use a particular
leaf device. You know what device it is, and by virtue of the driver
model, you know each of its ancestors. So, you walk the tree up to the
root, and restart all the way down. Then, you re-stop it all the way back
up. Should be ~10 lines of code that is left as an exercise against the
posted patch. :)


	Pat
