Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTKSK3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTKSK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:29:22 -0500
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:9125 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263977AbTKSK3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:29:17 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16315.17913.982049.700867@wombat.chubb.wattle.id.au>
Date: Wed, 19 Nov 2003 21:29:13 +1100
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PIIX ide driver can't disable DMA
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,
   On an I2000 there's a PIIX5 IDE controller and a pci bridge that
identifies as a 450NX rev 5.  This causes the ide driver to attempt to
disable DMA, to work around a limitation in the old 450NX chipset.

Unfortunately, this doesn't work, and on boot I see these messages:

piix: 450NX errata present, disabling IDE DMA.
piix: A BIOS update may resolve this.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:03.1
PCI: Found IRQ 0 for device 0000:00:03.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1070-0x1077, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1078-0x107f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdb: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
hdc: Maxtor 6Y080L0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 33
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, (U)DMA
hdc:<4>hdc: dma_timer_expiry: dma status == 0x21
hdc: DMA timeout error

If I boot with ide1=nodma things work.

It's currently broken to try to unconfigure IDE DMA with kconfig.

Note that:
     1. The PIIX5 at is not on the same PCI bus as the 450NX PXB.
     From lspci:

     00:03.1 IDE interface: Intel Corp. 82372FB PIIX5 IDE (rev 01)
     04:10.1 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
     Bridge (rev 05)

     2.  As far as I can tell from Intel's website, the device that
     identifies as a 450NX is actually part of the 460GX chipset; and it's
     only rev 0 through 3 that have the problem (the `real' 450NX
chips) (although I could easily be wrong there; it's hard to work out
what the PCI revision field corresponds to in Intel's stepping chart.
The bug is in steppings A0, B0 and C0.)


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
