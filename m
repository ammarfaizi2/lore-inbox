Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267906AbUGaEg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267906AbUGaEg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 00:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267907AbUGaEg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 00:36:57 -0400
Received: from gprs214-20.eurotel.cz ([160.218.214.20]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267906AbUGaEgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 00:36:52 -0400
Date: Sat, 31 Jul 2004 06:36:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: benh@kernel.crashing.org, kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040731043629.GA2429@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200407302102.12554.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407302102.12554.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * system-wide suspend level is always passed down (it is more
> > detailed, and for example IDE driver cares)
> 
> This bothers me -- why should a "system" suspend level matter
> to a device-level suspend call?  Seems like if IDE cares, it's
> probably being given the wrong device-level suspend state,
> or it needs more information than the target device state.

During swsusp, you need to make devices quiet; you do not need them to
enter any particular D0..D3, you just want them not to do DMA and
interrupts.

During reboot, you do not need devices in any of D0..D3; you do not
care, as long as BIOS can work with the devices after the reboot.

I do not think I'm giving them wrong device-level state.

> The problem I'm clear on is with PCI suspend, which some
> earlier driver model PM changes goofed up.  It's trying to
> pass a system state to driver suspend() methods that are
> expecting a value appropriate for pci_set_power_state().
> You're proposing to fix that by changing the call semantics,
> while I'd rather just see the call site fixed.

I do not think enough info can be fit into D0..D3.

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

PCI suspend routines need more detailed info than D0..D3. We do not
want global "int real_system_state" that devices look at...

> Point being that it should certainly be possible to selectively
> suspend devices without trying to put the whole system into a
> different state (just certain devices) ... and also without lying to
> any device about the system state.  (In fact, devices should as
> a rule not care about system power state, only their own state.)

See above, devices care what system is doing. For example you do not
want to spin down disks during "make it quiet for swsusp". And you
need to turn off apic before reboot, not because you want to save
power, but because bios crashes if you don't do that.

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

No problem with that.

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

Moving include should not be a problem... Changing all PCI
drivers... Ben H. claimed there's so little of them he can change them
all ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
