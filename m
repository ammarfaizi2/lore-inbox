Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTGaGnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272410AbTGaGnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:43:13 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:1877 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S272405AbTGaGnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:43:10 -0400
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's -
	all needed rpms installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, arjanv@redhat.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F21C5FA.5020507@pacbell.net>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com>
	 <1058217601.4441.1.camel@aurora.localdomain>
	 <1058299838.3358.4.camel@aurora.localdomain>
	 <20030715210240.GA5345@kroah.com>  <3F21C5FA.5020507@pacbell.net>
Content-Type: text/plain
Message-Id: <1059633777.4720.7.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 02:42:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 20:06, David Brownell wrote:

> See if this patch resolves it.
> 
> The patch adds an explicit reset to HCD initialization, and then makes
> EHCI use it.  (OHCI could do so even more easily ... but nobody's reported
> firmware acting that type of strange with OHCI.)   It should prevent IRQs
> being enabled while the HC is still in an indeterminate state.
> 
> This also fixes a missing local_irq_restore() that was generating some
> annoying might_sleep() messages, and a missing readb() that affects some
> ARM (and other) PCI systems.
> 
> - Dave

Applied it against test2.  I think the problem is indeed ACPI handling
PCI irqs.  This is an nVidia nForce2 board, I should check to see if the
patch someone posted fixes this (Did it get folded into test2?).

Anyway, the first oops only happens if I have the mouse plugged in as
USB (Intellimouse USB... I usually use the dumb little PS/2 adapter). 
The second happens now, but didn't before.  It is 1394 related. 
Interrupts are at 100k+ on both usb and 1394 ohci almost instantly with
ACPI on.

irq 11: nobody cared!
Call Trace:
[<c010c12a>] __report_bad_irq+0x2a/0x90
[<c010c21c>] note_interrupt+0x6c/0xb0
[<c010c42d>] do_IRQ+0xed/0x110
[<c010a9f8>] common_interrupt+0x18/0x20
[<c011f780>] do_softirq+0x40/0xa0
[<c010c414>] do_IRQ+0xd4/0x110
[<c010a9f8>] common_interrupt+0x18/0x20
[<c010c84e>] setup_irq+0x6e/0xb0
[<e087f350>] usb_hcd_irq+0x0/0x60 [usbcore]
[<c010c4d0>] request_irq+0x80/0xd0
[<e08824e0>] usb_hcd_pci_probe+0x200/0x4a0 [usbcore]
[<e087f350>] usb_hcd_irq+0x0/0x60
[<c01aa1f2>] pci_device_probe_static+0x52/0x70
[<c01aa30c>] __pci_device_probe+0x3c/0x50
[<c01aa34f>] pci_device_probe+0x2f/0x50
[<c01eb695>] bus_match+0x45/0x80
[<c01eb7ac>] driver_attach+0x5c/0x60
[<c01eba97>] bus_add_driver+0xa7/0xc0
[<c01ebf1f>] driver_register+0x2f/0x40
[<c01aa600>] pci_register_driver+0x70/0xa0
[<e0824021>] init+0x21/0x4f [ehci_hcd]
[<c0130afb>] sys_init_module+0x10b/0x200
[<c010a839>] sysenter_past_esp+0x52/0x71

handlers:
[<e087f350>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #11
ehci_hcd 0000:00:02.2: irq 11, pci mem e0815000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1


irq 4: nobody cared!
Call Trace:
[<c010c12a>] __report_bad_irq+0x2a/0x90
[<c010c21c>] note_interrupt+0x6c/0xb0
[<c010c42d>] do_IRQ+0xed/0x110
[<c010a9f8>] common_interrupt+0x18/0x20
[<c011f780>] do_softirq+0x40/0xa0
[<c010c414>] do_IRQ+0xd4/0x110
[<c010a9f8>] common_interrupt+0x18/0x20
[<c010c84e>] setup_irq+0x6e/0xb0
[<e08536d0>] ohci_irq_handler+0x0/0x720 [ohci1394]
[<c010c4d0>] request_irq+0x80/0xd0
[<e0855603>] ohci1394_pci_probe+0x3d3/0x580 [ohci1394]
[<e08536d0>] ohci_irq_handler+0x0/0x720 [ohci1394]
[<c01aa1f2>] pci_device_probe_static+0x52/0x70
[<c01aa30c>] __pci_device_probe+0x3c/0x50
[<c01aa34f>] pci_device_probe+0x2f/0x50
[<c01eb695>] bus_match+0x45/0x80
[<c01eb7ac>] driver_attach+0x5c/0x60
[<c01eba97>] bus_add_driver+0xa7/0xc0
[<c01ebf1f>] driver_register+0x2f/0x40
[<c01aa600>] pci_register_driver+0x70/0xa0
[<e0817013>] ohci1394_init+0x13/0x3d [ohci1394]
[<c0130afb>] sys_init_module+0x10b/0x200
[<c010a839>] sysenter_past_esp+0x52/0x71

handlers:
[<e08536d0>] (ohci_irq_handler+0x0/0x720 [ohci1394])
Disabling IRQ #4

Anyway, so either it is ACPI and fixable, or I just forget pci routing
with ACPI.

Trever Adams
--
"If a revolution destroys a systematic government, but the systematic
patterns of thought that produced that government are left intact, then
those patterns will repeat themselves in the succeding government." --
Robert M. Pirsig

