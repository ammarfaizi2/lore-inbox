Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWAGHjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWAGHjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWAGHjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:39:20 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:26013 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030328AbWAGHjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:39:19 -0500
Date: Sat, 7 Jan 2006 02:41:46 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Alan Stern <stern@rowland.harvard.edu>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060107074146.GC3184@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	kernel list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:42:24AM -0500, Alan Stern wrote:
> On Thu, 5 Jan 2006, Patrick Mochel wrote:
> 
> > On Fri, 6 Jan 2006, Pavel Machek wrote:
> > 
> > > On 05-01-06 16:04:07, Patrick Mochel wrote:
> > 
> > > > A better point, and one that would actually be useful, would be to remove
> > > > the file altogether. Let Dominik export a power file, with complete
> > > > control over the values, for each pcmcia device. Then you never have to
> > > > worry about breaking PCMCIA again.
> > >
> > > Fine with me.
> > 
> > ACK, you beat me to it.
> > 
> > And, appended is a patch to export PM controls for PCI devices. The file
> > "pm_possible_states" exports the states a device supports, and "pm_state"
> > exports the current state (and provides the interface for entering a
> > state).
> > 
> > Eventually, some drivers will want to fix up those values so that it can
> > mask of states that it doesn't support, as well as offer possible device-
> > specific states.
> > 
> > What's interesting is that with this patch, I can see that two more
> > devices on my system support D1 and D2 -- the cardbus controllers, which
> > are actually bridges whose PM capabilities aren't exported via lspci.
> 
> This trend is extremely alarming!!
> 
> It's a very bad idea to make bus drivers export and manage the syfs power 
> interface.  It means that lots of code gets repeated and different buses 
> do things differently.

In my opinion, the vast and often fundamentally different power
management specifications contribute greatly to the problem of
coordinated operating system controlled power management.  ACPI has
defined D0 - D3, and frankly, on x86 platforms, limiting the core interface
to those four states can be very functional.  Of course this isn't
pratical for the Linux PM layer because there several other important
platforms.  With that in mind, any generic representation of power
states has a tendency to be either overly complex or unacceptably limiting.

Considering these factors, I think allowing each bus to define its own
power management states and capabilities is a sensible option.  However,
I'm not convinced that it is necessary for these bus specific interfaces
to provide direct control of a device's power management states in most
situations.  That's not to say that some platforms won't need this
functionality but rather that PCI, USB, ACPI, and many others may not
want to provide userspace control of these low-level details.

As an alternative, it might be possible to allow each driver to export a
list of runtime power management states.  These states might revolve around
high level device class definitions rather than bus and platform interfaces.
The mechanism of reading and controlling these states could be similar to
the one you previously proposed for bus-level states.

As an example, a typical ethernet driver might export "on" and "off".
It doesn't matter if the ethernet device is PCI, ACPI, USB, etc.  The
key matter is that, for the "net" device class, most drivers will want 
to providee "on" and "off" as they correspond to "up" and "down". For the
PCI case, "off" will mean the highest (most off) D-state capable of
supporting the user's current wake settings.  This might be D2 if link
detect is enabled or D3 if it is disabled.  The actual PCI state can
be changed by the driver at any time, but the driver level state
dictates the drivers current intentions ("off" meaning save as much
power as would be possible while satisfying constraints).

Most sound card drivers will probably have more complex states.
They might be "on", "sleep", and "off".  "sleep" could be invoked as a
low latency state when the input and output lines have been quiet for
a certain uesr specified timeout period.  "off" could be be much higher
latency (some output might be lost i.e. skipping) and only invoked when
the audio interface has been closed from the userspace end.  Once again,
these states are not required to have a direct relation to bus level states.
A PCI sound card might remain in "D0" during the "sleep" state but turn off
many sub-components of the card and still save some power.

I think runtime power management is really all about what functionality
the drivers are willing provide.  If we focus on presenting bus-level power
management capabilities under a unified interface, then at best we are
ignoring the various subtleties of each specification (even ACPI and PCI
have minor differences), and at worst we're preventing drivers from revealing
the states that are actually important.  In other words, power management
can also be seen as a behavior, not just a power level.  Afterall, even
devices without bus level PM suport can save power just by doing things like
stopping DMA.  Even "virtual" devices can be seen as power-managable.

In short I'm suggesting the following:

1.) Every bus and device has its own unique PM mechanisms and specifications.
Representing this in a single unified model of any sort is nearly impossible.
Therefore, it may be best to allow each bus to define its own PM
infustructure and sysfs files (perhaps in a way similar to Pat's recent
patch).

2.) Device drivers on the other hand exist at a more abstract level and,
as a result, we have greater flexability and more options.  Therefore, I
think this is an excellent place to define power states and driver core PM
infustructure.

3.) System suspend and runtime power management are not even close to
similar.  Trying to use the same ->suspend and ->resume API is
ridiculious because it prevents intermediate power states and doesn't
properly perpare devices and device classes for a runtime environment.
Therefore, I'm in favor of a seperate interface tailored specifically for
runtime power management.

4.) If we're going to make any meaningful progress, we need to also
focus on device classes and class orriented power policy.  For example,
the "net" device class should provide infustructure and helper functions
for runtime power management of that flavor.  This might include some
generic "net" PM sysfs files.

Thanks,
Adam

