Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUHBQnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUHBQnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUHBQnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:43:19 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:3001 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266609AbUHBQnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:43:14 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Mon, 2 Aug 2004 09:38:17 -0700
User-Agent: KMail/1.6.2
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407311741.12406.david-b@pacbell.net> <1091324075.7389.41.camel@gaston>
In-Reply-To: <1091324075.7389.41.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408020938.17593.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 18:34, Benjamin Herrenschmidt wrote:
> On Sun, 2004-08-01 at 10:41, David Brownell wrote:
> > On Saturday 31 July 2004 10:01, Oliver Neukum wrote:
> > > 
> > > Maybe a better approach would be to describe the required features to
> > > the drivers rather than encoding them in a single integer. Rather
> > > like passing a request that states "lowest power level with device state
> > > retained, must not do DMA, enable remote wake up"
> > 
> > A pointer to some sort of struct could be generic and typesafe;
> > better than an integer or enum.
> 
> Well... if it gets that complicated, drivers will get it wrong...

It's already broken though!   Type-safe calls might at least
trigger compiler warning when folk do things like, for example,
pass a system power policy where a device power policy is
needed.  So long as the API uses integers (or enums), it falls
in the category of "oversimplified, impossible to get right".

But such a massive API change sounds to me like a 2.7
thing.


> I'm pretty sure that in real life, drivers only care about 2 states
> at this point, which is the ones needed for suspend to disk and suspend
> to RAM, the later doing a D3. An assitional "standby" state could be
> added later if we want.

The current problems relate to the fact that some drivers are
bothering to actually look at the parameters they're getting, and
notice that they're not meaningful device power states.

It's not an issue of how many states exist.  For example, the
drivers that care about both D3hot and D3cold are actually
caring about three states (including D0), so they can't rely on
that "all states other than 0 are D3hot" assumption.  And of
course, when D2 is passed for a device that doesn't do D2,
that's a problem in the caller.


> The only thing we need to make sure of at this point is that drivers ignore
> states they don't understand so we keep some flexibility to extending
> the list of states.

That just hides the bug:  upper level code passing nonsense
states down to the driver.


> Part of the confusion at this point is that we are playing with 2 different
> concepts, which are the driver operating state and the device power state.

Make that "3 different concepts":  system suspend state too.
Or maybe "2" is right, since I think you've already said you
define the driver operating state as something that should
be invisible from outside.  (So it's not what I described.)


> System suspend wants all drivers to suspend (freeze activity so that a
> consistent state of the driver is kept in memory). It may or may not
> be followed by a device power down.

I'd say "suspend wants drivers to quiesce" (using a word whose meaning
isn't so overloaded).  But why shouldn't some coprocessors -- bus controller,
DSP, CPU, etc -- continue as active?  At least on some kinds of system.  They
might need to be active in order to serve as a wakeup source.  Not all
Linux systems revolve so exclusively around one CPU that suspending it
CPU means the system should stop operating.  (That does seem to be
an integral part of the ACPI model though; must be part of why I keep
thinking it's the wrong "core" model for Linux PM.)


> Dynamic per-device power management would alter the device power state,
> but without putting the driver into a suspended state (actually, the driver
> itself would be responsible to turning the device back on as soon as some
> kind of request comes in).

There are two models happening here:

 - What you're describing, where this wouldn't be visible from outside
   a driver.  It wouldn't even need to be packaged through PM operations.

 - The scenario I mentioned, where in order for one device to suspend
   (example was usb-storage flash memory) it's got to first suspend a
   few subsidiary devices (SCSI host, SCSI disk, and a block device).

I don't see a good way to apply that first model to the scenario I was
describing.


> I think we don't need at this point to provide hooks or abstractions to
> represent these. Doing so would break everything, we don't need to do it
> at this point, we can at least get something reasonably working with our
> current scheme. The device power state policy can remain under driver
> control imho and don't need to be abstracted.

I don't think we need to add any abstractions, and don't see what your
concern is about "breaking" something (that's already broken).  We
do however need to make the existing abstractions (and APIs) work.

- Dave

