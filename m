Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVCDGcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVCDGcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVCDGcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:32:31 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64929 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262145AbVCDGcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:32:17 -0500
From: David Brownell <david-b@pacbell.net>
To: ncunningham@cyclades.com
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Date: Thu, 3 Mar 2005 22:31:55 -0800
User-Agent: KMail/1.7.1
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-pm@osdl.org,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <200503031817.06993.david-b@pacbell.net> <1109911788.3772.228.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1109911788.3772.228.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503032231.56045.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 8:49 pm, Nigel Cunningham wrote:
> > 
> > ... the goal of letting the system use those low
> > power modes more generally, without needing user(space) input to
> > suggest that now would be a good time to conserve more milliWatts.
> > 
> > Of course, on systems that don't swap (or swsusp) there may be
> > dozens of different low-power "standby" states.  I'm not sure it
> > helps to try labeling them all through /sys/power/files.
> 
> It seems to make a lot of sense to me for us to make a split between
> capability/implementation and policy, and move the policy stuff to
> userspace. 

But what's a "policy"?  And what's its scope?  When the device drivers
can cheaply turn their clocks on/off depending on whether their hardware
is in use, there's little point in having control knobs for that.  And
considering debug and testing, such knobs create pain and trouble.

Yet each different clock that can be gated creates a different family of
such low power "standby" states... all subtly different combinations
of active clocks.  I counted over six dozen clocks on one SOC; do the
math, it's hard to justify userspace caring about that many states!!
(Some characteristics may matter though, e.g. whether the 48 MHz PLL
is currently active or not.  If not, more aggressive power saving modes
might be available.)

There's a cost to having userspace make decisions.  When that cost can
exceed the power savings, it's probably best not to get it involved.

There are policy decisions that probably make sense in userspace,
like "backlight off"; and ones that certainly don't make sense there
(like IMO almost all clock gating decisions).


> Drivers could also interact with each other to communicate status
> changes (eg USB drivers notify parent HUB of their removal).

Actually it works the other way around:  hub status change events
are used to detect device removal, then the device gets told.
I think most hotpluggable busses work that way:  PCMCIA/CF, MMC,
CardBus, FireWire, PCI Hotplug, and so on.


> This is, of 
> course, the more complicated bit. Since this is the implementation (and
> not policy), however, userspace doesn't need to be involved. This
> separation should simplify things. My USB hub driver knows what its
> children are via the driver model. It doesn't need to receive a message
> from userspace to tell it to sleep because it has nothing to do.

Right, but there are important PM scenarios lurking there.  There's the
example of USB mice autosuspending, to enable root hubs to suspend,
allowing DMA to stop, and thus enabling C3 CPU mode, and saving 2 Watts
on top of the power no longer being supplied to that bus-powered mouse.
(And the same could be done for some other USB devices.)  This is,
you'll note, purely device power management ... it's all in the same
ACPI system state, S0.  (Though the mouse can probably be used to wake
the system from S1, S2, or S3 later on ...)

What we've discussed so far is that the only policy setting there
would be a module parameter for the HID driver, saying whether to
start that sequence after N seconds.  For the other drivers, CONFIG_PM
would seem to be enough of a request.


> With an implementation along these lines, I think we'll have a good
> basis for getting runtime power management and system states into a
> usable state.

Using DBUS to allow active policy (re)decisions could work, but I'd
also like to see most PM policies not need to swap in DBUS.  Sysfs
is a fine place to record policy decisions (though the cost of each
new attribute is less memory available for Real Work).

Do you have examples of PM policies where a DBUS agent would need
to make choices on the fly?  

- Dave


> 
> Regards,
> 
> Nigel
> -- 
> Nigel Cunningham
> Software Engineer, Canberra, Australia
> http://www.cyclades.com
> Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574
> 
> Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de
> 
> 
> 
