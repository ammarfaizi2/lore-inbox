Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUD2XoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUD2XoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUD2XoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:44:14 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:45440 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263173AbUD2XoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:44:11 -0400
Date: Fri, 30 Apr 2004 09:42:59 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: libata + siI3112 + 2.6.5-rc3 hang
Message-ID: <20040429234258.GA6145@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just acquired a Seagate 200GB SATA HD (yeah, baby, yeah ;) and hooked
it up to my onboard Silicon Image iI 3112 SATA Raid controller of my
Gigabyte nforce2 MB. Things work fine for the most part except when
heavy IO is done on the drive. Then the system hangs totally with no
console error msgs displayed. This also happens under Debian sarge's
2.4.25 aswell and has occured when I did a mke2fs -c on a partition
and (twice) with hdparm -tT. The first time hdparm works fine and
infact clocks the HD at 62MB/s (wowsers!), but the second time the
system hangs.

I'm not 100% sure what info to provide here so I took a stab at a few 
things:

0000:01:0d.0 Unknown mass storage controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
        Subsystem: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at a800
        Region 1: I/O ports at ac00 [size=4]
        Region 2: I/O ports at b000 [size=8]
        Region 3: I/O ports at b400 [size=4]
        Region 4: I/O ports at b800 [size=16]
        Region 5: Memory at e1001000 (32-bit, non-prefetchable) [size=512]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

--- 8< ---

NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
NFORCE2: neither IDE port enabled (BIOS)
ide-floppy driver 0.99.newide
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xE0847080 ctl 0xE084708A bmdma 0xE0847000 irq 15
ata2: SATA max UDMA/100 cmd 0xE08470C0 ctl 0xE08470CA bmdma 0xE0847008 irq 15
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

--- 8< ---

scsi0? I thought it detected it at scsi1? This reminds me. The MB has
the connector labeled as SATA1 but on bootup it's detected as the primary
SATA drive.

--- 8< ---

CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_SIL=y
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set

--- 8< ---

lexx:/proc# more interrupts 
           CPU0       
  0:    5107953    IO-APIC-edge  timer
  1:          9    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0          XT-PIC  NVidia nForce2
 11:       1872    IO-APIC-edge  eth0
 12:         58    IO-APIC-edge  i8042
 15:       3200    IO-APIC-edge  libata
NMI:          0 
LOC:    5107919 
ERR:          0
MIS:          0

If you need more info, any debugging done, etc please yell. This is going
to be the primary and only linux drive in the system (I'm relegating
windows to 'PATA') and so it'd be nice to have it stable. :)

Thanks.

-- 
    Red herrings strewn hither and yon.
