Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268351AbUHKX1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268351AbUHKX1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUHKX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:26:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37587 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268353AbUHKXYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:24:01 -0400
Date: Thu, 12 Aug 2004 01:23:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040811232355.GU26174@fs.tum.de>
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408101646.57542.bjorn.helgaas@hp.com> <20040810235621.GZ26174@fs.tum.de> <200408111433.50641.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408111433.50641.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 02:33:50PM -0600, Bjorn Helgaas wrote:
> On Tuesday 10 August 2004 5:56 pm, Adrian Bunk wrote:
> > On Tue, Aug 10, 2004 at 04:46:57PM -0600, Bjorn Helgaas wrote:
> > > On Tuesday 10 August 2004 11:32 am, Adrian Bunk wrote:
> > > > On Tue, Aug 10, 2004 at 09:59:18AM -0600, Bjorn Helgaas wrote:
> > > > > On Tuesday 10 August 2004 9:09 am, Adrian Bunk wrote:
> > > > > > 2.6.8-rc3-mm1 boots fine on my computer.
> > > > > > 2.6.8-rc4-mm1 doesn't boot.
> > > > > > 2.6.8-rc4-mm1 with pci=routeirq boots.
> > > 
> > It happens before the
> >   floppy0: no floppy controllers found
> > line.
> > 
> > Could there be a problem because the floppy driver doesn't find 
> > anything (there's currently no floppy drive in my computer)?
> 
> Not only is your machine floppy drive-less, but the driver thinks you
> don't even have a floppy *controller*, which I assume is separate
> from the actual drive.
> 
> What mainboard do you have?  Does it boot without "pci=routeirq"

I have an ASRock K7S8X (it was the only Athlon board for under 30 Euro  
half a year ago...).

It boots without "pci=routeirq" only if I disable ACPI.

> if you turn CONFIG_BLK_DEV_FD off?

Yes, CONFIG_BLK_DEV_FD fixes the problem.

> The code in the floppy_init() -> user_reset_fdc() -> WAIT() ->
> wait_til_done() -> reset_fdc() path looks pretty scary if there
> really is no controller out there.  I'd feel much better if
> we at least tried to use ACPI to figure out whether we have
> a controller before we try to talk to it.
> 
> All that aside, I still don't see how the pci=routeirq change
> would affect the floppy driver.  It does request_irq(6, ...),
> and it is interesting that you have this:
> 
>     ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
>     ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
> 
> which is for your NIC.  But the floppy controller isn't a PCI
> device, so the LNKD enable shouldn't matter to it.
> 
> Let's see... you're using the PIC model.  Maybe the floppy driver
> depends on the ACPI_IRQ_MODEL_PIC stuff in acpi_register_gsi()?
> Can you post the contents of /proc/interrupts with the floppy
> driver and "pci=routeirq"?  It seems weird to have the floppy

<--  snip  -->

           CPU0       
  0:     477284          XT-PIC  timer
  1:       2354          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  6:      36675          XT-PIC  eth0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          0          XT-PIC  ehci_hcd
 11:      41789          XT-PIC  Ensoniq AudioPCI, radeon@PCI:1:0:0
 12:      13254          XT-PIC  i8042
 14:      19687          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0 
ERR:          5

<--  snip  -->

> and the NIC share an IRQ, but it looks like that's what should
> be happening.
> 
> Bjorn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

