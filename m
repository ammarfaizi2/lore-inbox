Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267952AbTBSDdY>; Tue, 18 Feb 2003 22:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBSDdY>; Tue, 18 Feb 2003 22:33:24 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19364 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267952AbTBSDdV>;
	Tue, 18 Feb 2003 22:33:21 -0500
Date: Tue, 18 Feb 2003 22:42:54 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Grover, Andrew" <andrew.grover@intel.com>,
       Shawn Starr <shawn.starr@datawire.net>,
       LinuxKernelMailingList <linux-kernel@vger.kernel.org>
Cc: Simone Piunno <pioppo@ferrara.linux.it>, Grover@unaropia
Subject: Re: 2.5.xx ACPI/Sb16 IRQ conflict
Message-ID: <20030218224254.GE25172@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	Shawn Starr <shawn.starr@datawire.net>,
	LinuxKernelMailingList <linux-kernel@vger.kernel.org>,
	Simone Piunno <pioppo@ferrara.linux.it>, Grover@unaropia
References: <F760B14C9561B941B89469F59BA3A84725A18B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A18B@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:42:10AM -0800, Grover, Andrew wrote:
> > From: Shawn Starr [mailto:shawn.starr@datawire.net] 
> > I can confirm this with 2.5.61 and my SB16AWE card. There
> > seems to be a bug
> > when PCI interrupts are set by ACPI on a IBM 300PL 6892-N2U.
> >
> > Also, the IBM BIOS's PnP for OS is enabled.
> >
> > When the PnP BIOS is disabled and pci=noacpi is NOT used.
> > There are no
> > conflicts. When PnP BIOS is enabled and we don't set
> > pci=noacpi we get
> > conflicts with IRQs.
>
> Hmmm, yes.
>
> > >ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
>
> There should have been a previous line about LNKD, listing possible
> interrupts for it -- what did that line say?

On my copy of Shawn's dmesg I see the following:

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 5


> 
> Clearly, either we need another IRQ for LNKD or we PnPISA needs to
> assign a different IRQ - some coordination is needed here.

Agreed, in this particular case there are no available irqs for PnPISA to
assign because it isn't able to share irqs.  Here is some aditional
information about the ISAPnP device that is using irq 5.

7 is used by the parport
10 and 11 are used by pci devices
5 is clear but only with pci=noacpi

ISAPnP Based Sound Blaster Card

sh-2.05a$ cat possible
Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible
Dependent: 02 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 03 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 04 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 05 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 06 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 07 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10,11 High-Edge
   dma 0,1,3 8-bit byte-count compatible

How would you suggest PnP and PCI coordinate this?

Thanks,

Adam
