Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVK0Va4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVK0Va4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVK0Va4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:30:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:42902 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751154AbVK0Vaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:30:55 -0500
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511271234.27708.mbuesch@freenet.de>
References: <200511271234.27708.mbuesch@freenet.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 08:25:26 +1100
Message-Id: <1133126726.7768.127.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 12:34 +0100, Michael Buesch wrote:
> Hi,
> 
> Latest GIT code oopses in the USB driver with a spinlock corruption:

(backtrace below)

Looks bad. I went through the code, and I discovered that indeed,
usb_add_hcd() calls driver->reset() before anything else, that is,
before giving the low level driver a chance to initialize it's local
data structure, including the spinlock. On EHCI, at least, reset will
dive deep into the guts of the driver tying among others to acquire the
lock.

That is very bad. It's yet another example of broken "mid-layer" design.
I can't say enough how bad this whole mid-layer hcd stuff is but you
guys don't beleive it.

So what you should do to fix the immediate problem is to have a separate
"init" callback to the low level driver to initialize it's private data
structure before anything else is called. A kind of "constructor". Call
that from usb_add_hcd() before you call reset().

In the long run, the whole hcd layer junk should probably be flipped
upside down though. It's the low level driver that should be in control,
and the hcd layer should act as a "library" used by the hcd driver,
instead of the opposite.

That is, the HCD driver gets probed, gets control first, calls something
to allocate the hcd data structure, gets a chance to initialize it, then
calls usb_add_hcd() etc... 

The whole thing is done backward currently.

> hub 3-0:1.0: 2 ports detected
> usb 1-1: device descriptor read/64, error -71
> usb 1-1: new full speed USB device using ohci_hcd and address 
> usb 1-1: device descriptor read/64, error -71
> usb 1-1: device descriptor read/64, error -71
> PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
> ehci_hcd 0001:10:1b.2: EHCI Host Controller
> BUG: spinlock bad magic on CPU#0, modprobe/2001
>  lock: cfe6ce64, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> Call Trace:
> [DF1CDC40] [C000988C] show_stack+0x5c/0x1a0 (unreliable)
> [DF1CDC70] [C012D408] spin_bug+0xa8/0xd0
> [DF1CDC90] [C012D608] _raw_spin_lock+0x88/0x180
> [DF1CDCA0] [C02B5E10] _spin_lock_irqsave+0x30/0x50
> [DF1CDCC0] [E2587F58] ehci_hub_control+0x38/0x750 [ehci_hcd]
> [DF1CDCF0] [E25886DC] ehci_port_power+0x6c/0xa0 [ehci_hcd]
> [DF1CDD10] [E25887F4] ehci_pci_reinit+0xe4/0x320 [ehci_hcd]
> [DF1CDD50] [E258A3D0] ehci_pci_reset+0xe0/0x5f0 [ehci_hcd]
> [DF1CDD80] [E25ACD38] usb_add_hcd+0x68/0x7b0 [usbcore]
> [DF1CDDD0] [E25B77CC] usb_hcd_pci_probe+0x19c/0x2d0 [usbcore]
> [DF1CDE00] [C0133164] pci_device_probe+0x84/0xb0
> [DF1CDE20] [C018FA84] driver_probe_device+0x64/0x110
> [DF1CDE40] [C018FC94] __driver_attach+0x94/0xb0
> [DF1CDE60] [C018EC9C] bus_for_each_dev+0x5c/0xa0
> [DF1CDE90] [C018F7E4] driver_attach+0x24/0x40
> [DF1CDEA0] [C018F230] bus_add_driver+0x90/0x180
> [DF1CDEC0] [C01900CC] driver_register+0x6c/0x80
> [DF1CDEF0] [C0132C60] __pci_register_driver+0xb0/0x100
> [DF1CDF10] [E1035030] ehci_hcd_pci_init+0x30/0x90 [ehci_hcd]
> [DF1CDF20] [C0048AD8] sys_init_module+0x148/0x3b0
> [DF1CDF40] [C000E1AC] ret_from_syscall+0x0/0x44
> --- Exception: c01 at 0xff7391c
>     LR = 0x10003a00
> BUG: spinlock lockup on CPU#0, modprobe/2001, cfe6ce64
> Call Trace:
> [DF1CDC60] [C000988C] show_stack+0x5c/0x1a0 (unreliable)
> [DF1CDC90] [C012D6A8] _raw_spin_lock+0x128/0x180
> [DF1CDCA0] [C02B5E10] _spin_lock_irqsave+0x30/0x50
> [DF1CDCC0] [E2587F58] ehci_hub_control+0x38/0x750 [ehci_hcd]
> [DF1CDCF0] [E25886DC] ehci_port_power+0x6c/0xa0 [ehci_hcd]
> [DF1CDD10] [E25887F4] ehci_pci_reinit+0xe4/0x320 [ehci_hcd]
> [DF1CDD50] [E258A3D0] ehci_pci_reset+0xe0/0x5f0 [ehci_hcd]
> [DF1CDD80] [E25ACD38] usb_add_hcd+0x68/0x7b0 [usbcore]
> [DF1CDDD0] [E25B77CC] usb_hcd_pci_probe+0x19c/0x2d0 [usbcore]
> [DF1CDE00] [C0133164] pci_device_probe+0x84/0xb0
> [DF1CDE20] [C018FA84] driver_probe_device+0x64/0x110
> [DF1CDE40] [C018FC94] __driver_attach+0x94/0xb0
> [There is more, but netconsole cut off here]
> 
> This is a PowerPC machine (PowerBook G4).
> The .config is attached.
> 2.6.15-rc2-g1778d55e (Nov 23 2005) does not crash.
> 

