Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267243AbUHDCe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267243AbUHDCe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHDCe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:34:58 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:34025 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267243AbUHDCel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:34:41 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Tue, 3 Aug 2004 19:28:08 -0700
User-Agent: KMail/1.6.2
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
In-Reply-To: <1091493486.7396.92.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031928.08475.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 17:38, Benjamin Herrenschmidt wrote:

> Nope. I don't think it makes sense to have the caller understand
> anything about D states. And their actual impact on hardware tend
> to depends from one chip to another too...

Even if you don't think that, it's what the current PCI drivers are
expecting.  You're arguing to change about a dozen in-tree drivers
(doable), and some unknown number of others.   When I do changes
like that, I _really_ like to change the argument type enough to make
the compiler start reporting broken drivers!

Maybe rather than changing from values 0-4 into values 0-3, it
should change into string constants naming the states ... if you don't
like typed struct pointers for such things!


> What we need to pass to drivers are policies. Right now, we defined
> suspend-to-ram and suspend-to-disk system wide policies, we may want
> to define some additional ones especially those that can be triggered
> by userspace to individual drivers.

/sys/power/state defines also "standby"; these are the PM_SUSPEND_*
enumeration values (other than "on").

But the /sys/bus/*/devices/*/power/state files just read and write numbers.
Those get sent to individual drivers.  Passing (and printing) symbols
would make it more obvious what's going on there.  It'd be good if those
symbols could include bus-specific state names (driver-specific?), as
well as policies like "standby", "mem", and "disk".


> > Make that "3 different concepts":  system suspend state too.
> > Or maybe "2" is right, since I think you've already said you
> > define the driver operating state as something that should
> > be invisible from outside.  (So it's not what I described.)
> 
> Well, system suspend state too, right, it defines the driver
> state we are asking for.

System state != driver state though.   I'd agree that there
can be semi-generic policy names though, which various
software (ACPI, platform- or bus-specific code, even drivers)
could try mapping to hardware-specific states.


> I don't understand what you are talking about... in the case of
> usb-storage, it has scsi disk as it's child in the device tree,
> the child should get the suspend call first of course, and yes, I know
> the current sysfs semantics for userland-originated suspend are broken.

At one point I heard one of those issues described as "semantics are
bus-specific", but that's only part of it... :(


> Right now, we are trying to at least get the full system suspend
> working, we can work on fixing partial-tree suspend (which is what you
> want there) later.

The "partial tree suspend" works only for the degenerate
tree:  every device in the system!  Wakeup events also need
some more attention.

There's now some partial-tree code in CONFIG_USB_SUSPEND (for
developers only), but jumping from USB into the next level driver
(SCSI, video, etc) raises questions.


> > I don't think we need to add any abstractions, and don't see what your
> > concern is about "breaking" something (that's already broken).  We
> > do however need to make the existing abstractions (and APIs) work.
> 
> Yup, but I still consider that it's a non-sense to pass D states to
> driver suspend() callback ;)

Passing PM_SUSPEND_* values (0-3) instead of PCI power states (0-4),
as PCI drivers have previously expected, looks like it ought to be a
simplifying assumption.  Simpler is often good ... though this makes
me suspect "too simple".  Especially since it pushes policy choices
into device drivers (normally not good, except for quirks like "this
driver+hardware can't do D3, so let's use D2")..

- Dave
