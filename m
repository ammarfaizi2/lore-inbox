Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLEVSD>; Tue, 5 Dec 2000 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbQLEVRx>; Tue, 5 Dec 2000 16:17:53 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:52241 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129652AbQLEVRq>;
	Tue, 5 Dec 2000 16:17:46 -0500
Date: Tue, 5 Dec 2000 21:47:07 +0100
From: Martin Mares <mj@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: x86 PCI IRQ's were not being routed in some cases (against 2.4.0-test11pre4)
Message-ID: <20001205214707.A427@albireo.ucw.cz>
In-Reply-To: <20001205004346.A677@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001205004346.A677@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Dec 05, 2000 at 12:43:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	To fix this problem, I have deleted a conditional in
> pcibios_enable_irq, so that it will route the IRQ, even if it
> thinks the work has already been done.  Now, USB and my PCMCIA
> flash cards work in that notebook computer again.

Unfortunately, your fix is wrong -- it makes Linux ignore all the IRQ
settings the user has set up in the BIOS and I also guess there are
machines where the IRQ information in the INTERRUPT_LINE register
is correct, but the BIOS tables/functions are inaccurate.

First of all, please send me the 'lspci -vvx' output for the USB
device and also try booting the kernel with a "pci=autoirq" option
which should have exactly the same effect as your patch.

> 	I do not have that solid of an understanding of PCI
> initialization in Linux.  I am still rather confused about what
> routines are supposed to set up an interrupt if one is needed
> and has not yet been routed for the device and which ones are supposed
> to punt in case.

The IRQ assignment logic is somewhat complicated to handle all
the corner cases:

   o  When we are scanning the PCI bus and we encounter a device
      with wrong IRQ, we ignore the IRQ information.

   o  During the scan, if we find a device with unset IRQ, but having
      an interrupt pin advertised in its configuration header, we
      try to look at the interrupt router to see what IRQ did BIOS
      route the pin to.

   o  When pci_enable_device() is called and the IRQ is still unset
      (and interrupt pin exists), we try to route the IRQ ourselves.

> For example, there is another problem that I
> am trying to fix, where the motherboard BIOS on that other computer
> sets the IRQ associated with the USB controller to zero, no matter
> how I program the BIOS, and pcibios_lookup_irq takes this as reason
> enough to refuse to allocate and route a new IRQ.

It definitely shouldn't behave so -- IRQ set to zero is always
interpreted as "no IRQ assigned".

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
Purchasing Windows is an Unrecoverable Application Error.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
