Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUHCAr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUHCAr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUHCAo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:44:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:16794 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264791AbUHCAmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:42:18 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408020938.17593.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407311741.12406.david-b@pacbell.net> <1091324075.7389.41.camel@gaston>
	 <200408020938.17593.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091493486.7396.92.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:38:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The current problems relate to the fact that some drivers are
> bothering to actually look at the parameters they're getting, and
> notice that they're not meaningful device power states.
> 
> It's not an issue of how many states exist.  For example, the
> drivers that care about both D3hot and D3cold are actually
> caring about three states (including D0), so they can't rely on
> that "all states other than 0 are D3hot" assumption.  And of
> course, when D2 is passed for a device that doesn't do D2,
> that's a problem in the caller.

Nope. I don't think it makes sense to have the caller understand
anything about D states. And their actual impact on hardware tend
to depends from one chip to another too...

> That just hides the bug:  upper level code passing nonsense
> states down to the driver.

Nobody can get a D state right anyway, so it makes no sense to pass
that to drivers. Only the driver itself may know it's hardware well
enough (eventually with platform specific tweaks) to figure out what
D state to apply for a global policy.

What we need to pass to drivers are policies. Right now, we defined
suspend-to-ram and suspend-to-disk system wide policies, we may want
to define some additional ones especially those that can be triggered
by userspace to individual drivers.

> Make that "3 different concepts":  system suspend state too.
> Or maybe "2" is right, since I think you've already said you
> define the driver operating state as something that should
> be invisible from outside.  (So it's not what I described.)

Well, system suspend state too, right, it defines the driver
state we are asking for.

> I'd say "suspend wants drivers to quiesce" (using a word whose meaning
> isn't so overloaded).  But why shouldn't some coprocessors -- bus controller,
> DSP, CPU, etc -- continue as active?  At least on some kinds of system.  They
> might need to be active in order to serve as a wakeup source.  Not all
> Linux systems revolve so exclusively around one CPU that suspending it
> CPU means the system should stop operating.  (That does seem to be
> an integral part of the ACPI model though; must be part of why I keep
> thinking it's the wrong "core" model for Linux PM.)

Sure, and that already works, but it's a per driver policy at this
point, I don't think we can do much better at the driver model level.

> > Dynamic per-device power management would alter the device power state,
> > but without putting the driver into a suspended state (actually, the driver
> > itself would be responsible to turning the device back on as soon as some
> > kind of request comes in).
> 
> There are two models happening here:
> 
>  - What you're describing, where this wouldn't be visible from outside
>    a driver.  It wouldn't even need to be packaged through PM operations.
> 
>  - The scenario I mentioned, where in order for one device to suspend
>    (example was usb-storage flash memory) it's got to first suspend a
>    few subsidiary devices (SCSI host, SCSI disk, and a block device).
> 
> I don't see a good way to apply that first model to the scenario I was
> describing.

I don't understand what you are talking about... in the case of
usb-storage, it has scsi disk as it's child in the device tree,
the child should get the suspend call first of course, and yes, I know
the current sysfs semantics for userland-originated suspend are broken.

Right now, we are trying to at least get the full system suspend
working, we can work on fixing partial-tree suspend (which is what you
want there) later.

> I don't think we need to add any abstractions, and don't see what your
> concern is about "breaking" something (that's already broken).  We
> do however need to make the existing abstractions (and APIs) work.

Yup, but I still consider that it's a non-sense to pass D states to
driver suspend() callback ;)

Ben.


