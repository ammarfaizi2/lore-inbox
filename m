Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbRDSNQE>; Thu, 19 Apr 2001 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135661AbRDSNPy>; Thu, 19 Apr 2001 09:15:54 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:43510 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S135659AbRDSNPr>; Thu, 19 Apr 2001 09:15:47 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-pm-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: PCI power management
Date: Thu, 19 Apr 2001 15:14:53 +0200
Message-Id: <20010419131453.12448@mailhost.mipsys.com>
In-Reply-To: <E14qE0V-00078Y-00@the-village.bc.nu>
In-Reply-To: <E14qE0V-00078Y-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - Some devices just can't be brought back to life from D3 state without
>> a PCI reset (ATI Rage M3 for example) and that require some arch specific
>> support (when it's possible at all).
>
>Putting on a driver author hat what I want is
>
>	pci_power_on_generic
>	pci_power_off_generic
>	pci_power_on_null
>	pci_power_off_null
>
>At which point most driver writers are having to do no thinking at all about
>their device. The PCI layer just requires they pick a function and stick it
>in the struct pci_device. 

Could you elaborate about the difference between generic and null
functions ? I'm not sure I understand what you mean...

Note that in the case of chips like the Rage M3, the driver is the only
one to know if it will be able to bring back the card from a power off
state or not. It's the only one to know if it can reconfigure the card
completely without having a BIOS run before it.

I would suggest a call that looks like

pci_power_off(uint mask);

where mask is

  PCI_POWER_MASK_D1 = 0x00000001
  PCI_POWER_MASK_D2 = 0x00000002
  PCI_POWER_MASK_D3 = 0x00000004
  PCI_POWER_MASK_NOCLOCK = 0x00000008
  PCI_POWER_MASK_NOPOWER = 0x00000010

The driver sets the mask to whatever state it supports getting the card
from. We can #define a PCI_POWER_MASK_STD (that would be a D1+D2+D3) for
"generic" drivers that don't really know anything but to follow the HW
PCI power management capabilities.

This function would be routed to an arch function, that will in turn
either call the lower-level PCI code to set D1, D2 or D3 mode (the best
supported) or will suspend the card's clock or power if it can and the
driver accept it.

Typically, on a PowerMac, this function could keep track of which cards
are in D2 or D3 mode (or which drivers allowed for clock suspend) and
would stop the PCI clock once they all asked for it. 

>This doesnt help you. You need device specific support in each case where
>bus mastering is occuring and a bus master error could be fatal if missed.
>For example on i2o I can easily have 4Mbytes of outstanding I/O between the
>message layer and disk, all of which is bus mastering. Only the driver
>actually
>knows when its idle.

Right. That's a driver issue. The problem would go away if all drivers
properly block their IO queues and wait for all IO to complete when
notified of sleep

>X has hooks for this in XFree 4

The last time I looked at it, those were rather APM-specific. But well, I
guess it's easy to update them. What I'm thinknig about is the kernel
side, that is a generic, non-APM or non-ACPI specific way of notifying
userland process that request for it. Some kind of interface allowing
userland to register PM notifiers and have the kernel PM thread be
blocked until the userland code "acked" the message.

Well, maybe there is already something I missed...

Ben.



