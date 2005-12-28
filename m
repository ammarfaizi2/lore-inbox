Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVL1EWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVL1EWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVL1EWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:22:17 -0500
Received: from digitalimplant.org ([64.62.235.95]:63649 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932465AbVL1EWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:22:16 -0500
Date: Tue, 27 Dec 2005 20:22:04 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20051227220533.GA1914@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
References: <20051227213439.GA1884@elf.ucw.cz>
 <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
 <20051227220533.GA1914@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Dec 2005, Pavel Machek wrote:

> Hi!
>
> > >  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
> > >  {
> > > -       return sprintf(buf, "%u\n", dev->power.power_state.event);
> > > +       if (dev->power.power_state.event)
> > > +               return sprintf(buf, "suspend\n");
> > > +       else
> > > +               return sprintf(buf, "on\n");
> > >  }
> >
> > Are you sure that having only 2 options (suspend/on) is enough at the
> > core level? I could envision having more levels, like "poweroff", etc?
>
> Note that interface is 0/2, currently, so this is improvement :-).

Heh, not really. You're not really solving any problems, only giving the
illusion that you've actually fixed something.

As I mentioned in the thread (currently happening, BTW) on the linux-pm
list, what you want to do is accept a string that reflects an actual state
that the device supports. For PCI devices that support low-power states,
this would be "D1", "D2", "D3", etc. For USB devices, which only support
an "on" and "suspended" state, the values that this patch parses would
actually work.

One way or another, you want the drivers to export the power states that
they support in some fashion. Not all devices support PM, and the current
interface is admittedly lacking in that respect. As I mentioned, the
proper thing to do would be to not add this file for *every* device, but
leave it up to the buses to add it for devices that support PM (and that
have drivers bound to them that implement it).

The reason is that some drivers and devices will support more than just
"on" and "suspended". which states those are, the power savings that they
offer, and the tradeoff in latency for resuming from those states are real
values and things to be considered for wanting to enter those states.

Your patch does nothing to actually help support those things, and doesn't
do anything to improve the broken interface.

> One day, when we find device that needs it, we may want to add more
> states. I don't know about such device currently.

There are many devices already do - there are PCI, PCI-X, PCI Express,
ACPI devices, etc that do. But, you simply cannot create a single decent
runtime power management interface for every single type of device. The
power states are inherently specific to the bus that they are on. Some of
them are specific to the device.

This is not suspend - you won't be able to get away with a few arbitrary
values that work for most systems. The proper interface should allow the
buses and drivers to use *factual* identifiers to express the states they
support. Anything else (including the current interface, which I wrote) is
simply a hack.

Thanks,


	Patrick

