Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbSLLB17>; Wed, 11 Dec 2002 20:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbSLLB17>; Wed, 11 Dec 2002 20:27:59 -0500
Received: from codepoet.org ([166.70.99.138]:52668 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S267375AbSLLB15>;
	Wed, 11 Dec 2002 20:27:57 -0500
Date: Wed, 11 Dec 2002 18:35:46 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1 IDE
Message-ID: <20021212013546.GA30408@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 10, 2002 at 06:37:14PM -0200, Marcelo Tosatti wrote:
> 
> So here goes the first pre of 2.4.21 including the new IDE code merged
> from Alan's tree.
> 
> Test it carefully, since the new IDE code is not yet fully tested.

A few off things here...

    Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PDC20267: IDE controller at PCI slot 00:0b.0
    PDC20267: chipset revision 2
    PDC20267: not 100%% native mode: will probe irqs later
    PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
	ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:DMA
	ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
    VP_IDE: IDE controller at PCI slot 00:11.1
    PCI: No IRQ known for interrupt pin A of device 00:11.1.
    VP_IDE: chipset revision 6 
    VP_IDE: not 100%% native mode: will probe irqs later
    VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
	ide0: BM-DMA at 0xbc00-0xbc07, BIOS settings: hda:DMA, hdb:DMA
	ide1: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdc:DMA, hdd:DMA
    hda: IC35L080AVVA07-0, ATA DISK drive
    hdb: IC35L040AVER07-0, ATA DISK drive
    hda: DMA disabled
    ^^^^^^^^^^^^^^^^^

What's up with this?  For each drive in my system it claims it
has disabled DMA.  But hdparm later reports that DMA is in fact
enabled.  In fact, later on the kernel ever reports the drive
as being in UDMA 100 mode...  I think these "DMA disabled"
messages are bogus.

    blk: queue c03c4a00, I/O limit 4095Mb (mask 0xffffffff)
    hdb: DMA disabled
    ^^^^^^^^^^^^^^^^^

    blk: queue c03c4b4c, I/O limit 4095Mb (mask 0xffffffff)
    hdc: PCRW804, ATAPI CD/DVD-ROM drive
    hdd: Pioneer DVD-ROM ATAPIModel DVD-116 0122, ATAPI CD/DVD-ROM drive
    hdc: DMA disabled
    hdd: DMA disabled
    ^^^^^^^^^^^^^^^^^

    hde: IC35L040AVER07-0, ATA DISK drive
    hde: DMA disabled
    ^^^^^^^^^^^^^^^^^

Yet more bogus DMA disabled messages....

    blk: queue c03c52d8, I/O limit 4095Mb (mask 0xffffffff)
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    ide2 at 0x1800-0x1807,0xac02 on irq 11
    hda: host protected area => 1
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(100)

Now we see the funky "host protected area => 1" message.  As
discussed earlier with Andre, this message should be removed from
the kernel.  The message as written implies that the drive
actually has an active HPA -- which is not the case at all!  All
this is doing is enumerating support for a particular drive
feature.  Do we really care that the drive has Host Protected
Area feature set support?   I don't care.  I suppose it might be
interesting to note if there is actually an HPA in effect, but
this as is the message is just noise.  If we are going to
enumerate drive capabilities, why not useful ones like the Power
Management feature set, or the Power-Up In Standby feature set...

I think we should kill the "host protected area => 1" message. If
people care about their drives supported feature set, they can
run 'hdparm -I' to find this out,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
