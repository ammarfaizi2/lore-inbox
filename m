Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274871AbTGaVYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274874AbTGaVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:24:20 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:22055
	"EHLO gaston") by vger.kernel.org with ESMTP id S274871AbTGaVYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:24:16 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3F288CAB.6020401@pacbell.net>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz>  <3F288CAB.6020401@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059686596.7187.153.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:23:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, partially; but it's not used consistently.  Could you
> (or someone) explain what the plan is?  I see:
> 
>   - Three separate x86 PM "initiators":  APM, ACPI, swsusp.
>     (Plus ones for ARM and MIPS.)

You should look at Patrick Mochel's stuff that shall be getting in
the official tree this month hopefully. It does that (among others)

>   - Two driver registration infrastructures, the driver model
>     stuff and the older pm_*() stuff.

The older pm_ model is deprecated.

> The pm_*() is how a handful of sound drivers and other random
> stuff register themselves -- and how PCI does it.
> 
> I'd sure have expected PCI to only use the driver model stuff,
> and I'll hope all those users will all be phased out by the
> time that 2.6 gets near the end of its test cycle.

PCI is broken since it does both (and thus, if we call both rounds
of notifiers, we end up suspending PCI twice, the second time without
any ordering constraints). In my trees, I comment out that "legacy"
stuff (though I also don't call the old-style pm_* stuff anymore
neither)

> The "initiators" all talk to _both_ infrastructures, but they
> don't talk to the driver model stuff in the same way.  For
> example, on suspend:
> 
>   - ACPI issues a NOTIFY, which can veto the suspend;
>     then SAVE_STATE, ditto; finally POWER_DOWN.
> 
>   - APM uses the pm_*() calls for a vetoable check,
>     never issues SAVE_STATE, then goes POWER_DOWN.
> 
>   - While swsusp is more like ACPI except that it doesn't
>     support vetoing from either NOTIFY or SAVE_STATE.

All that will change to a unified mecanism soon

> That all seems more problematic to me.  Seems to me that
> APM should issue SAVE_STATE (and RESTORE_STATE), and all
> three PM "initiators" should agree on vetoing.
> 
> For USB, the {SAVE,RESTORE}_STATE calls would be the most
> natural place to do the "kill pending urbs" calls that
> Alan Stern mentioned -- at least, for D3 or swsusp levels.
> Likely for D1 and D2, devices with pending I/O won't really
> be keen on from suspending.

SAVE_STATE is going away. The proper semantics are
SUSPEND and POWERDOWN (+/-). The later is optional and really only
needed by drivers who need to do their last powerdown step with
interrupts disabled.

The SUSPEND state is responsible for blocking further IOs, and
snapshoting the state. It can enter the HW suspend mode too, depending
on the "state" argument you pass.

The actual policy of what shall be done to "block" IOs is
function-specific. Typically, a network driver will just stop the Rx
side and drop any Tx packet (it just need to call netif_stop_queue()
actually, but it can drop pending packets in the Tx ring). A block
driver (IDE, SCSI) must complete any pending request and keep new
incoming ones held in the BIO queue. This has been implemented properly
for IDE already, SCSI still need work.
 
> 
> Now, for the record I tried to suspend a test1 APM-works
> system, with UHCI, and it wouldn't resume -- unclear why,
> or if test2 will do the same.
> 
> A different APM-works system, with OHCI and test2, did
> suspend/resume OK; but something went wrong with OHCI
> even before any driver model PM calls happened, if the
> OHCI driver was active (doing DMA):  the HCD got an
> "Unrecoverable Error" IRQ, which generally means that
> some kind DMA fault appeared.
> 
> All of which is a roundabout way of adding to what I
> said:  the PM infrastructure USB will need to rely on
> seems like it needs polishing yet!  :)

The USB "device" drivers shall just rely on the Device Model
infrastructure to have their suspend/resume callbacks be called at the
appropriate time. If they take care of finishing pending IOs (or
cancelling, as you like, depending on the driver function) and not
issuing new URBs until they are resumed, there shall be no problem, the
HCD should be idle when it's own suspend callback is reached. Which is
why I beleive it's safe/better to actually cancel pending URBs and
reject any new one in the HCD driver when it's in suspend state.

Ben.

