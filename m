Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269942AbTGVHVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTGVHVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:21:44 -0400
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:6152 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S269942AbTGVHVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:21:42 -0400
Date: Tue, 22 Jul 2003 00:36:43 -0700
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre6 DMA broken? [Was: Re: DMA timeouts with 2.4.22-pre6]
Message-ID: <20030722073643.GA2108@gambit.implode.net>
References: <20030719150728.GA265@gambit.implode.net> <20030719200556.GA249@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719200556.GA249@gambit.implode.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/hdb is a 120GB drive partitioned as FAT32 for easy file access
between Linux and WinXP when dual booting.

When I was running 2.4.22-pre4 to -pre6, I had DMA timeout problems.  
These timeouts occur even when I try to do a hdparm test on it.  When 
I have it mounted and attempt to copy to and from it, the DMA timeouts 
appear.  This leads me to think it is not the vfat system causing 
the problems.  As I mentioned earlier, in the pre2-pre3 changelog, 
there was mention of dma timeout fix.  I am not sure if this cause of 
the problems.  I didn't try pre1 - pre3 due to ACPI/IO-APIC/PCI IRQ 
routing problems.  I used acpi=off to "resolve" those problems in pre4
to pre6.

Once I started to use pre4, and pre5, and pre6, I started to get the DMA 
timeout problems listed below.  I believe this may have caused the file 
corruption on the fat32 partition.  When I get the timeout problems, I 
do try to do a SysRQ sync and Ctl-Alt-Del.  Come to think of it, 
sometimes I was not able to recover and had to reset...this is probably 
where I may have caused the file system corruption.  The problem stems 
from the pre kernels giving DMA timeouts on the UDMA 133 drive on the 
nForce2's UDMA 133 controller (though only support up to UDMA 100 is 
available with the current Linux driver).  /dev/hda did not run into 
any of the DMA timeout problems.  It is a UDMA 100 drive only though.

Reverting back to 2.4.21, I didn't get the DMA timeouts and was able to
fsck.vfat /dev/hdb.  Prior to do this, the drive/partition was making
WinXP boot up really slow.  It's own chkdsk would not even check the 
volume.  WinXP wasn't able to determine anything about the volume.  Only
after running fsck.vfat was WinXP able to access that volume normally.
Ever since, I have reverted back to 2.4.21.  I have yet to try pre7
since there is nothing in its changelog about dma.

John

On Sat, Jul 19, 2003 at 01:05:56PM -0700, John Wong wrote:
> Thinking it may be the "fix ida dma timeout bug", I booted up 2.4.21 and 
> the DMA problems were gone.
> 
> One difference in the sytems though.  With 2.4.21, I am using ACPI and APIC.  
> With 2.4.22-preX, I have to set acpi=off otherwise, system interrupts get
> crazy.  I tried pci=noacpi where the system is usuable for a short 
> period of time and no IRQ higher than 15 are assigned.
> 
> John
> 
> On Sat, Jul 19, 2003 at 08:07:29AM -0700, John Wong wrote:
> > I am having dma timeouts with my Maxtor 6Y120P0.  It is connected as the
> > slave on the primary channel of the nVidia nForce2 based Asus A7N8X DX.
> > 
> > I did not have this problem with 2.4.21.  On the 2.4.22-pre series, I
> > have encountered this problem in pre4, pre5, and pre6.  I did not try 
> > earlier pre's.  In the pre2 -> pre3 change log, there was a mention of 
> > fix ide dma timeout bugs.  I am wondering if this fix is causing my newly
> > experienced problems.
> > 
> > gambit:/root# hdparm /dev/hdb
> > 
> > /dev/hdb:
> >  multcount    = 16 (on)
> >  IO_support   =  1 (32-bit)
> >  unmaskirq    =  1 (on)
> >  using_dma    =  1 (on)
> >  keepsettings =  0 (off)
> >  readonly     =  0 (off)
> >  readahead    =  8 (on)
> >  geometry     = 14946/255/63, sectors = 240121728, start = 0
> > 
> > 
> > Jul 11 18:59:26 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
> > SeekComplete Error }
> > Jul 11 18:59:26 gambit kernel: hdb: dma_intr: error=0x40 {
> > UncorrectableError }, LBAsect=98468, sector=98405
> > Jul 11 18:59:26 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
> > sector 98405
> > Jul 11 18:59:36 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
> > SeekComplete Error }
> > Jul 11 18:59:36 gambit kernel: hdb: dma_intr: error=0x40 {
> > UncorrectableError }, LBAsect=98470, sector=98407
> > Jul 11 18:59:36 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
> > sector 98407
> > Jul 11 18:59:42 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
> > SeekComplete Error }
> > Jul 11 18:59:42 gambit kernel: hdb: dma_intr: error=0x40 {
> > UncorrectableError }, LBAsect=98471, sector=98408
> > Jul 11 18:59:42 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
> > sector 98408
> > 
> > John
