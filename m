Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267907AbUGaFvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267907AbUGaFvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 01:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUGaFvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 01:51:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:36487 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267907AbUGaFvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 01:51:14 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200407302102.12554.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407302102.12554.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091252962.7387.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 15:49:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 14:02, David Brownell wrote:
> On Friday 30 July 2004 09:44, Pavel Machek wrote:
> 
> > * system-wide suspend level is always passed down (it is more
> > detailed, and for example IDE driver cares)
> 
> This bothers me -- why should a "system" suspend level matter
> to a device-level suspend call?  Seems like if IDE cares, it's
> probably being given the wrong device-level suspend state,
> or it needs more information than the target device state.

Well, as I explained you during OLS ... Drivers will act differently
for suspend-to-ram, suspend-to-disk, and eventually other states we
may introduce, like a system "idle" state.

Disks in general are an example (IDE beeing the one that is currently
implemented, but we'll probably have to do the same for SATA and SCSI
at one point), you want to spin them off (with proper cache flush
etc...) when suspending to RAM, while you don't when suspending to
disk, as you really don't want them to be spun up again right away to
write the suspend image.

USB is another example. Typically, suspend-to-RAM wants to do a bus
suspend, eventually enabling remote wakeup on some devices, and expects
to recover the bus on wakeup, while suspend-to-disk is roughtly
equivalent to a full shutdown & reconnect on wakeup.

I have other platform drivers that will behave differently. Most of the
time the difference is that suspend-to-disk will not bother actually
shutting down the HW, just freeze the state of the device, while suspend
to RAM will actually want to enter whatever D state is appropriate.

> The problem I'm clear on is with PCI suspend, which some
> earlier driver model PM changes goofed up.  It's trying to
> pass a system state to driver suspend() methods that are
> expecting a value appropriate for pci_set_power_state().
> You're proposing to fix that by changing the call semantics,
> while I'd rather just see the call site fixed.

No, I don't agree. It's a driver policy to decide what PCI state
to use based on the system suspend level.

> I trust nobody is now disagreeing that's the root cause of
> several suspend problems ... and I suspect that API changes,
> to pass enums, should be part of the "real" fix.  (As Len has
> commented, C enums aren't type-safe ... but at least they
> provide documentation which "u32 state" can't!)
> 
> 
> > * if you want to derive Dx state, just use provided inline function to
> > convert.
> 
> If the model is that there's some PM "layer" (for lack of better term)
> that's in charge of "system suspend" (e.g. to ACPI S3), then I have
> no qualms saying that layer is responsible for mapping the those
> states into PCI D-states before calling PCI suspend routines.  But
> we don't really seem to have such a layer.  MontaVista has some
> "DPM" code, distinct from drivers/base/power calls with that TLA,
> that are one example of such a layer ... allowing multiple power
> configurations.  Not the only way to do it -- but also not quite the
> limited "laptop into S3 now" kind of model either.
> 
> Point being that it should certainly be possible to selectively
> suspend devices without trying to put the whole system into a
> different state (just certain devices) ... and also without lying to
> any device about the system state.  (In fact, devices should as
> a rule not care about system power state, only their own state.)
> It should be easy for one driver to suspend or resume another
> one, without any changes to "system" state.
> 
> 
> Some specific comments on the patch:
> 
> > +enum pci_state {
> > +	D0 = 20,		/* For debugging, symbolic constants should be everywhere */
> > +	D1,
> > +	D2,
> > +	D3hot,
> > +	D3cold
> > +};
> 
> Those would be better as PCI_D0, PCI_D2 etc ... so they're not confused
> with ACPI_D0, ACPI_D2 etc.
> 
> > +
> > +static inline enum pci_state to_pci_state(enum suspend_state state)
> > +{
> > +	switch(state) {
> > +	case RUNTIME_D1:
> > +		return D1;
> > +	case RUNTIME_D2:
> > +		return D2;
> > +	case RUNTIME_D3hot:
> > +		return D3hot;
> > +	case SNAPSHOT:
> > +	case POWERDOWN:
> > +	case RESTART:
> > +	case RUNTIME_D3cold:
> > +		return D3cold;
> > +	default:
> > +		BUG();
> > +	}
> > +}
> >  
> >  #endif /* __KERNEL__ */
> 
> This stuff, if it's used, belongs in <linux/pci.h> not <linux/pm.h> ... it's
> not generic to all busses.  And pci_set_power_state() should probably
> be modified to take the enum ... though I don't much like that notion,
> it'd require changing every driver that actually tries to use the PCI
> PM calls (since they currently "know" D3hot==3 and D3cold==4).
> 
> - Dave
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

