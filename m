Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281065AbRKKUxO>; Sun, 11 Nov 2001 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281067AbRKKUxE>; Sun, 11 Nov 2001 15:53:04 -0500
Received: from astcc-423.astound.net ([24.219.123.215]:9989 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281065AbRKKUwt>; Sun, 11 Nov 2001 15:52:49 -0500
Date: Sun, 11 Nov 2001 13:52:24 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Maxwell Spangler <maxwax@mindspring.com>
cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
In-Reply-To: <Pine.LNX.4.33.0111111420410.17275-100000@tyan.doghouse.com>
Message-ID: <Pine.LNX.4.10.10111111336030.13115-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Maxwell Spangler wrote:

> On Fri, 9 Nov 2001, Erik Andersen wrote:
> 
> > On Fri Nov 09, 2001 at 08:57:07PM -0200, Rik van Riel wrote:
> > > >
> > > > But wouldn't it make more sense to enable DMA by default, except
> > > > for a set of blacklisted chipsets, rather then disabling it for
> > > > everybody just because some older chipsets are crap?
> > >
> > > The kernel does this, but only if CONFIG_IDEDMA_AUTO
> > > is enabled ...
> >
> > That seems to be the theory.  In practice every system in my house has
> > that option enabled and yet only some controllers boot up with DMA enabled...
> >
> > For example lets look at the following case.  This system has
> > an intel chipset builtin and a Promise PCI card.
> >
> >     Uniform Multi-Platform E-IDE driver Revision: 6.31
> >     ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> >     PIIX4: IDE controller on PCI bus 00 dev 39
> >     PIIX4: chipset revision 1
> >     PIIX4: not 100% native mode: will probe irqs later
> > 	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> > 	ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> >     PDC20267: IDE controller on PCI bus 00 dev 68
> >     PCI: Found IRQ 5 for device 00:0d.0
> >     PDC20267: chipset revision 2
> >     PDC20267: not 100% native mode: will probe irqs later
> > 	ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:DMA
> > 	ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
> >     hda: IBM-DPTA-373420, ATA DISK drive
> >     hdd: PCRW804, ATAPI CD/DVD-ROM drive
> >     hde: IBM-DTLA-307045, ATA DISK drive
> >     hdg: IBM-DTLA-307045, ATA DISK drive
> >     ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >     ide1 at 0x170-0x177,0x376 on irq 15
> >     ide2 at 0xac00-0xac07,0xb002 on irq 5
> >     ide3 at 0xb400-0xb407,0xb802 on irq 5
> >     hda: 66055248 sectors (33820 MB) w/1961KiB Cache, CHS=4111/255/63, UDMA(33)
> >     hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
> >     hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
> >     Partition check:
> >      hda: hda1 hda2
> >      hde: hde1
> >      hdg: hdg1
> >
> > So the Intel one came up with DMA enabled,  No problem there.
> >
> > The Promise controller has two identical 46.1GB IBM-DTLA-307045 7200
> > rpm hard drives on it.  The controller is capable of ATA100.  The hard
> > drives are capable of ATA100.  And yet even with CONFIG_IDEDMA_AUTO
> > set, these drives both come up running 3.39 MB/s.
> 
> I've got the same setup and things work fine.  Do you have the "Special UDMA
> feature" enabled in the Promise driver configuration portion of the kernel
> config?  Perhaps it specifically needs that while any other EIDE driver (like
> the embedded PIIX4) would already use DMA..
> 
> Perhaps Andre can give us a final answer :)
> -------------------------------------------------------------------------------
> Maxwell Spangler
> Program Writer
> Greenbelt, Maryland, U.S.A.
> Washington D.C. Metropolitan Area
> 

One needs to set the chipsets and not allow it to be in the default setup.

> >     PDC20267: IDE controller on PCI bus 00 dev 68
> >     PCI: Found IRQ 5 for device 00:0d.0
> >     PDC20267: chipset revision 2
> >     PDC20267: not 100% native mode: will probe irqs later
> >     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:DMA
> >     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA

These lines tell me that you do not have the pdc202xx compiled into the
kernel.  Therefore you have not way to setup the host device pair.
If the chipset code was compiled into the kernel, there would have been a
line reporting about the ultra_bits and master/pci modes of each channel.

The significance of the tuning code is not just for init events.
Linux is the first and only OS to have the autodma down grade feature
(Intel borrowed my model, approved by me).  This allows for kernel to auto
reconfigure the drive to stablize the transfer rates to protect the data.
Of course the ATA hardware has iCRC's un Ultra modes, but excessive
retries which are/will be successfully defeat the power of Ultra
transfers.  Therefore the tuning code in conjunction the the
auto-down-grade functions will reduce the transfer rates until the iCRC's
go away.  This is the 0x84/0x51 error pairs.  There are various reasons
that can cause this error to occur; however, the first stage is to
stablize the transport data path and then allow the SA or EU to examine
the problems.

My current folly in the code base is chipsets are not modular, but then
one has the problem to only allow booting of legacy hardware during
install.  This is another story to be addressed, whenever 2.5 begins.

As for the PIIX4 AB/EB that is a total mess at the hardware layer.
I have an ugly fix for linux but it is violent in the noise maker and is
not acceptable as standard use.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

