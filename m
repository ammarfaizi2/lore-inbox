Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUGaEFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUGaEFB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 00:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267905AbUGaEFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 00:05:01 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:36006 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267670AbUGaEE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 00:04:56 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Solving suspend-level confusion
Date: Fri, 30 Jul 2004 21:02:12 -0700
User-Agent: KMail/1.6.2
Cc: benh@kernel.crashing.org, kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz>
In-Reply-To: <20040730164413.GB4672@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407302102.12554.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 July 2004 09:44, Pavel Machek wrote:

> * system-wide suspend level is always passed down (it is more
> detailed, and for example IDE driver cares)

This bothers me -- why should a "system" suspend level matter
to a device-level suspend call?  Seems like if IDE cares, it's
probably being given the wrong device-level suspend state,
or it needs more information than the target device state.

The problem I'm clear on is with PCI suspend, which some
earlier driver model PM changes goofed up.  It's trying to
pass a system state to driver suspend() methods that are
expecting a value appropriate for pci_set_power_state().
You're proposing to fix that by changing the call semantics,
while I'd rather just see the call site fixed.

I trust nobody is now disagreeing that's the root cause of
several suspend problems ... and I suspect that API changes,
to pass enums, should be part of the "real" fix.  (As Len has
commented, C enums aren't type-safe ... but at least they
provide documentation which "u32 state" can't!)


> * if you want to derive Dx state, just use provided inline function to
> convert.

If the model is that there's some PM "layer" (for lack of better term)
that's in charge of "system suspend" (e.g. to ACPI S3), then I have
no qualms saying that layer is responsible for mapping the those
states into PCI D-states before calling PCI suspend routines.  But
we don't really seem to have such a layer.  MontaVista has some
"DPM" code, distinct from drivers/base/power calls with that TLA,
that are one example of such a layer ... allowing multiple power
configurations.  Not the only way to do it -- but also not quite the
limited "laptop into S3 now" kind of model either.

Point being that it should certainly be possible to selectively
suspend devices without trying to put the whole system into a
different state (just certain devices) ... and also without lying to
any device about the system state.  (In fact, devices should as
a rule not care about system power state, only their own state.)
It should be easy for one driver to suspend or resume another
one, without any changes to "system" state.


Some specific comments on the patch:

> +enum pci_state {
> +	D0 = 20,		/* For debugging, symbolic constants should be everywhere */
> +	D1,
> +	D2,
> +	D3hot,
> +	D3cold
> +};

Those would be better as PCI_D0, PCI_D2 etc ... so they're not confused
with ACPI_D0, ACPI_D2 etc.

> +
> +static inline enum pci_state to_pci_state(enum suspend_state state)
> +{
> +	switch(state) {
> +	case RUNTIME_D1:
> +		return D1;
> +	case RUNTIME_D2:
> +		return D2;
> +	case RUNTIME_D3hot:
> +		return D3hot;
> +	case SNAPSHOT:
> +	case POWERDOWN:
> +	case RESTART:
> +	case RUNTIME_D3cold:
> +		return D3cold;
> +	default:
> +		BUG();
> +	}
> +}
>  
>  #endif /* __KERNEL__ */

This stuff, if it's used, belongs in <linux/pci.h> not <linux/pm.h> ... it's
not generic to all busses.  And pci_set_power_state() should probably
be modified to take the enum ... though I don't much like that notion,
it'd require changing every driver that actually tries to use the PCI
PM calls (since they currently "know" D3hot==3 and D3cold==4).

- Dave
