Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUBKAbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUBKAbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:31:52 -0500
Received: from smtp08.auna.com ([62.81.186.18]:63446 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S262580AbUBKAbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:31:47 -0500
Date: Wed, 11 Feb 2004 01:31:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Controlling PCI ordering
Message-ID: <20040211003145.GA5351@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have a little problem with PIC card/function ordering.
Lets see if I can state it clearly...

I have an Adaptec 29320 card, that has two independent channels.
Channel B has the external connector and the internal LVD connector.
Channel A has one internal Ultra and one other 50-pin scsi-2 connector.
I have a ZIP and a CDROM connected to the 50pin plug,

Channel A is limited to 40 Mb/s (do not know if its the card or the fact that
I have the 50pin bus used...).
So my U320 boot disk has to go to channel B.

Problem is that BIOS detects the drive in channel B as the first SCSI disk,
but the kernel (aic79xx driver) detects first the A channel, so my boot
disk goes to sdb instead of sda (sda is the zip for the kernel, the CD goes
to scd).

In short, I have to install lilo/set root to sdb1. What happens if I remove
the zip drive ? Non-booting box :(.

Can I make the kernel to reverse the ordering of the two functions in that
PCI slot ? IE, move the U320 channel B to scsi0.

03:02.0 SCSI storage controller: Adaptec ASC-29320 U320 (rev 03)
03:02.1 SCSI storage controller: Adaptec ASC-29320 U320 (rev 03)

TIA

/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1030
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.08
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K4_36WLS  Rev: DFV0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: MAJ3364MP        Rev: 0115
  Type:   Direct-Access                    ANSI SCSI revision: 04

/proc/scsi/aic79xx/0:
...
Target 2 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz RDSTRM|DT, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz)
        Curr: 10.000MB/s transfers (10.000MHz)
        Transmission Errors 0
        Channel A Target 2 Lun 0 Settings
                Commands Queued 25
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 4 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz RDSTRM|DT, 16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Transmission Errors 0
        Channel A Target 4 Lun 0 Settings
                Commands Queued 7
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0

/proc/scsi/aic79xx/1:

Target 0 Negotiation Settings
        User: 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|QAS, 16bit)
        Goal: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Curr: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Transmission Errors 0
        Channel A Target 0 Lun 0 Settings
                Commands Queued 42238
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
Target 1 Negotiation Settings
        User: 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|QAS, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Transmission Errors 0
        Channel A Target 1 Lun 0 Settings
                Commands Queued 1030
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0

dmesg:

SCSI subsystem driver Revision: 1.00
PCI: Setting latency timer of device 03:02.0 to 64
PCI: Setting latency timer of device 03:02.1 to 64
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec 29320 Ultra320 SCSI adapter>
        aic7901A: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec 29320 Ultra320 SCSI adapter>
        aic7901A: Ultra320 Wide Channel B, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

blk: queue f7e5ce18, I/O limit 4095Mb (mask 0xffffffff)
(scsi1:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, 16bit)
(scsi0:A:2): 10.000MB/s transfers (10.000MHz)
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7e5ca18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IOMEGA    Model: ZIP 100           Rev: E.08
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7e5c418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7e05818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAJ3364MP         Rev: 0115
  Type:   Direct-Access                      ANSI SCSI revision: 04
blk: queue f7e05618, I/O limit 4095Mb (mask 0xffffffff)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 1, lun 0
sda: Unit Not Ready, sense:
Current 00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 
0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 
0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
Partition check:
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
SCSI device sdc: 71390320 512-byte hdwr sectors (36552 MB)
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >


-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.3-rc1-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
