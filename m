Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUJKWZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUJKWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJKWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:25:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:51650 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269321AbUJKWXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:23:06 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <200410110915.33331.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org>
	 <1097470524.3249.34.camel@gaston>  <200410110915.33331.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097533363.13795.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 08:22:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 02:15, David Brownell wrote:

> In USB-land, we've been discussing "idle" as something orthogonal
> to the PM states.  Not clear on all the details yet, but I'd vote against
> anything that tries to make "driver doing nothing" a power state,
> or doesn't have a way to idle drivers.

Well, having an "idle" system state that asks all drivers to go to
"idle" state doesn't prevent local bus/driver management from having
it's own dynamic idle state ...

"idle" as a system state is a kind of "light sleep" state where you come
back up very quickly and makes a lot of sense for handheld devices.

"idle" as a device-state is what suspend-to-disk really wants :)

So you don't wnat the system state passed down to drivers but a policy
instead ... We probably need more than that, like some additional flags
along with a platform filter. For example, during a system suspend, a
given piece of HW may end up beeing unclocked or powered off by the
system, the driver will want to know that. The firmware may reboot the
device on wakeup or not. The driver need to know that too.

But I agree that we can avoid passing down a system state if we define
a "policy" state along with a few flags.

There is something else that we need to take into account. For system
state, we want the driver to stay idle until woken up explicitely. But
there are also more "dynamic" PM states that we may want to be triggered
by the user via sysfs for which the driver will come back automatically
when a request comes in from upstream (equivalent to disk idle sleep).

> Drivers can be "idle" without entering low power states, and can
> use wakeup events to enter/exit low power states without being
> fully idle. (Hardware allowing.)  That's an example of a policy that
> drivers should be able to choose without affecting PMcore.

But that doesn't prevent the system from enforcing all drivers into an
idle state, that is no request processing, consistent state image in
memory and no DMA, but no need to actually power down the device. That
is suitable for quick-wakeup idle or for suspend-to-disk.

> I've sent separate posts about how to add wakeup support to the
> PM framework ... that omission should have been a great big
> red (or is it chartreuse?) warning flag that the PM framework was
> lacking some very basic functionality.

Right.

> 
> > "suspend to ram" and  "suspend to disk".
> 
> Those aren't device power states at all!!  They're system sleep
> states (or transitions).   And by the way, "suspend to disk" is
> an odd model for systems without disks, or swap ... which oddly
> enough tend to be ones that really need good PM, and which
> (like HH.org) need the "partially suspended" system model
> to work well.

They are, but the choice of a device power state from a system power
state can most of the time only be done ... by the device-driver itself,
eventually with support from the platform. Only the device-driver knows
what it's device really supports as far as states as concerned, what the
driver supports waking the device from, etc... Though it needs
informations and help from the platform as well, like knowing if the
firmware will bring the device back up from power-on-reset (this is very
important for video cards).
> 
> > But what about user /sysfs originated requests ? (that is random numbers
> > the user whacks in /sys/devices/...../power) what are their semantics ?
> 
> Sysfs should only read/write the names of the states that particular
> device can support.  Plus probably some generic requests for policies
> that the sleep framework would hand to individual drivers.
>
> > Also, do we carry around a "suggested" D state for what it means ? it's
> > really an obscure PCI concept. However, as you can see with the hacks
> > in drivers like radeonfb, ....
> 
> I can't think of PCI D-states as obscure, they're the core of its PM support.
> PCI drivers need to use them to implement power policies.

No, they are obscure. The signification of a given D state at the HW
level and the way a given state is actually supported by a given device
is really totally device-specific. The PCI spec is nice but HW rarely
follow it in my experience.

> Without looking at that code, I'll just say that while many PCI drivers
> can probably offload the decision making to some PCI core code
> ("use D1 or D2 when idle if available; D3hot otherwise"), not all
> can do that. 

The problem, again, is that chosing the right state is a decision that
can only be done by the driver, provided it knows information about the
system state (or policy if you prefer, your policy thing is just a way
to pass system states without calling them this way), and informations
from the platform about what will actually happen on this specific slot
after the state is entered (and a lot of systems don't give a shit about
PCI D states at this point, some machines will just power down all
slots, or a random set of them, some will cut clocks off, some will do
nothing, etc...) 

Ben.


