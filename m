Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUJPFzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUJPFzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUJPFzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:55:53 -0400
Received: from fmr99.intel.com ([192.55.52.32]:60384 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S268648AbUJPFzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:55:44 -0400
Subject: Re: PCI IRQ problems: "nobody cared!"
From: Len Brown <len.brown@intel.com>
To: Jim Paris <jim@jtan.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20041015083722.GA3315@jim.sh>
References: <20041015083722.GA3315@jim.sh>
Content-Type: text/plain
Organization: 
Message-Id: <1097906133.14149.37.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Oct 2004 01:55:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 04:37, Jim Paris wrote:
> I'm having some strange PCI IRQ problems on my new laptop (Panasonic
> Toughbook CF-M34UTVZKM) under 2.6.8-1-686 (Debian).  I'm at a loss to
> figure out their source, other than the fact that Toughbooks seem to
> have a particularly crappy BIOS.

Jim,

Before doing anything else, please verify that you're running the latest
BIOS for this box.

I don't think this is an interrupt misrouting problem -- I think the
problem is that a device is pulling on a shared interrupt before
we get its driver loaded.

You might find that using "noirqdebug" gets you through the boot
sequence and that after the drivers are loaded the system runs
normally. This may be preferable to the irqpoll workaround.
Of course both are workarounds and neither actually help us
identify the root cause.

Note that PNPBIOS shouldn't run on an ACPI-enabled system -- probably no
harm, but use a CONFIG_PNPBIOS=n kernel to verify there is no change in
your ACPI enabled result.

ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs *9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.

There isn't any opportunity for "mis-routing" IRQs here, IRQ 9 is the
only choice the BIOS gives us.  It would be interesting to look at your
BIOS setup to see if there are some parameters you can use to allow the
BIOS to give us more freedom.  Sometimes these BIOS setup options allow
selecting broken configurations, so start by restoring the system to its
default configuration if there is a setup option to do that.

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
irq 9: nobody cared!
...
handlers:
[<c01b3b60>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 9 (level, low) -> IRQ 9

It appears that a device is pulling on its interrupt line and so as soon
as we enable its link we get clobbered.  acpi_irq() is the only handler
on the IRQ at that point and it gets clobbered.

One thing that might help is if you try Bjorn's patch
to delay enabling the PCI Interrupt Links until the
actual drivers request that their interrupt be enabled:
http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/remove-unconditional-pci-acpi-irq-routing.patch

Also, it would be a good idea to identify the device at the root cause.
As a start, go to your BIOS SETUP
and disable all devices that it allows you to disable.
Looks like you have a couple of NICs behind a cardbus bridge.
If they are physically removable, then take them out.

If you supply the output from lspci -vv
and acpidmp, then we can find out exactly
what devices are attached to which interrupt link
and that will probably tell us which device is being bad.
acpidmp is in /usr/sbin/, or you can be had from pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

The failure in the acpioff case is a clue I think.
Several devices get enabled on IRQ9 with no issues,
but the system dies when yenta gets enabled,
so perhaps the devices behind that bridge are at fault.

They appear to be NICs, you might try pulling out the cable
and disabling the Radio to see if it allows us to
get through boot and get those drivers loaded.

cheers,
-Len


