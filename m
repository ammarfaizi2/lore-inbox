Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267962AbUGaO1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267962AbUGaO1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUGaO1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:27:38 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:15772 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S267961AbUGaO0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:26:10 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Sat, 31 Jul 2004 07:23:12 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407302102.12554.david-b@pacbell.net> <1091252962.7387.14.camel@gaston>
In-Reply-To: <1091252962.7387.14.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407310723.12137.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 July 2004 22:49, Benjamin Herrenschmidt wrote:
> On Sat, 2004-07-31 at 14:02, David Brownell wrote:
> > On Friday 30 July 2004 09:44, Pavel Machek wrote:
> > 
> > > * system-wide suspend level is always passed down (it is more
> > > detailed, and for example IDE driver cares)
> > 
> > This bothers me -- why should a "system" suspend level matter
> > to a device-level suspend call?  Seems like if IDE cares, it's
> > probably being given the wrong device-level suspend state,
> > or it needs more information than the target device state.
> 
> Well, as I explained you during OLS ... Drivers will act differently
> for suspend-to-ram, suspend-to-disk, and eventually other states we
> may introduce, like a system "idle" state.

We didn't quite get into details enough to have it be "explain"
though ... it was more of "assert"!


> Disks in general are an example (IDE beeing the one that is currently
> implemented, but we'll probably have to do the same for SATA and SCSI
> at one point), you want to spin them off (with proper cache flush
> etc...) when suspending to RAM, while you don't when suspending to
> disk, as you really don't want them to be spun up again right away to
> write the suspend image.

So suspend-to-RAM more or less matches PCI D3hot, and
suspend-to-DISK matches PCI D3cold.  If those power states
were passed to the device suspend(), the disk driver could act
appropriately.  In my observation, D3cold was never passed
down, it was always D3hot.

These look to me like "wrong device-level suspend state" cases.


> USB is another example. Typically, suspend-to-RAM wants to do a bus
> suspend, eventually enabling remote wakeup on some devices, and expects
> to recover the bus on wakeup, while suspend-to-disk is roughtly
> equivalent to a full shutdown & reconnect on wakeup.

Same thing:  an HCD could do the right thing if it was told to go
into D1, D2, or D3hot (supports USB suspend) vs D3cold (doesn't).

Though the PM core doesn't cooperate at all there.  Neither the
suspend nor the resume codepaths cope well with disconnect
(and hence device removal), the PM core self-deadlocks since
suspend/resume outcalls are done while holding the semaphore
that device_pm_remove() needs, ugh.

And FWIW Greg's now merged the CONFIG_USB_SUSPEND code
into his tree, as experimental ... so now all the relevant integration
issues can start to get sorted out.  Eventually, that PM core deadlock
can get fixed.  And remote wakeup needs work ... x86 machines need
a way to tell ACPI to pay attention to PME# wakeups (which Len says
is in some recent ACPI patch), and maybe the PPC/Mac platforms
will need something similar.

 
> > The problem I'm clear on is with PCI suspend, which some
> > earlier driver model PM changes goofed up.  It's trying to
> > pass a system state to driver suspend() methods that are
> > expecting a value appropriate for pci_set_power_state().
> > You're proposing to fix that by changing the call semantics,
> > while I'd rather just see the call site fixed.
> 
> No, I don't agree. It's a driver policy to decide what PCI state
> to use based on the system suspend level.

You've not persuaded me on that point at all ...

Consider:  device PM calls  aren't only made as part of changing
a "system suspend level".  Minimally, there's the ability to suspend
a single device through sysfs.  And in general, we need to be able
to do that directly ... one device suspending **must** be able to
trigger another one suspending, without assuming that every
device on the system is suspending to the same state.

As for example, suspending a USB flash storage device must
be able to suspend its subsidiary storage and block devices,
without necessarily suspending the network link on an adjacent
hub port.  Or a USB port on a camera (or cell phone) that must
act as either host or peripheral (USB OTG) ... at most one of those
controllers should be active at a time.

Consider a system PM policy including "suspend all idle devices".
With N devices supporting only "on" and "suspend" states, that's
something like 2^N system suspend levels.  Or more; most
devices support more than two suspend states (add at least
"off", plus often light weight suspend states).  And N is system-specific,
so there's no way all those system states can be given small
integer values ... much less fit into a "u32 state".

 - Dave
