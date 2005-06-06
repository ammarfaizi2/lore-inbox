Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFFA1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFFA1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFFA1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 20:27:43 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:55424
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261161AbVFFA1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 20:27:40 -0400
Date: Mon, 6 Jun 2005 02:27:39 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605204645.A28422@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 08:46:45PM +0400, Ivan Kokshaysky wrote:
> It's the "transparent" bridge. The code in setup-bus.c doesn't handle this
> properly.
> 
> Please try this patch - it should fix two problems:
> - in pci_setup_bridge() use bridge resources directly, instead of
>   the resource pointers in struct pci_bus (this fixes an oops);
> - [ioport,iomem]_resource must not be touched in the bus setup code,
>   otherwise we screw up the whole resource tree.
> 
> Ivan.

With the patch and Linus' modifications, the boot progresses further
than with Linus' mods alone.  However, it now fails a bit later when
it comes the CardBus bridge in the docking station (following output
manually typed from the console):

...
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
yenta 0000:03:05.0: Preassigned resource 0 busy, reconfiguring ...
yenta 0000:03:05.0: no resource of type 1200 available, trying to continue ...
yenta 0000:03:05.0: Preassigned resource 1 busy, reconfiguring ...
yenta 0000:03:05.0: no resource of type 200 available, trying to continue ...
yenta 0000:03:05.0: no resource of type 100 available, trying to continue ...
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta TI: socket 0000:03:05.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:03:05.0 falling back to parallel PCI interrupts
Yenta TI: socket 0000:03:05.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: ffffffff

For your reference, at this stage we appear to have a cascade of three
bridges between a potential device (currently empty CardBus slot) and
the CPU

                1              2      3
CPU Southbridge -> PCI Express -> PCI -> CardBus

Note that the messages before this log, e.g., from ohci1394, also indicate
that the peripherals in the docking station still remain inaccessible due to
unmapped memory (all reads return 0xff). 

Many thanks for your effort,
  Andreas
