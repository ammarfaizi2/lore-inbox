Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVKVVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVKVVeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbVKVVeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:34:10 -0500
Received: from bernhard.xss.co.at ([193.80.108.69]:42919 "EHLO
	bernhard.xss.co.at") by vger.kernel.org with ESMTP id S1030180AbVKVVeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:34:06 -0500
Message-ID: <43838ECC.5060204@xss.co.at>
Date: Tue, 22 Nov 2005 22:34:04 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT =
 0
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I'm in the process of setting up a new fileserver and
have some troubles with an Adaptec ASC-29320ALP U320
SCSI card and an external Infortrend EonStor RAID!

This is a Tyan TA26 barebone system (dual opteron CPU,
4GB RAM) with two on-board AIC-7902B SCSI controllers
(Tyan Thunder K8SD Pro motherboard) for internal system disks
(SW-RAID1) and two additional Adaptec 29320ALP U320 cards
for externally connected RAID (Infortrend EonStor A16U-G2421
RAID subsystem) and backup hardware.

I'm running linux-2.4.31 in 32 bit mode.

root@setup:~ {521} $ lspci
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:03.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
01:04.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
02:06.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
02:06.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:05.0 Mass storage controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
03:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 10)

The SCSI devices are connected as follows:

root@setup:~ {520} $ cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IFT      Model: A16U-G2421       Rev: 342A
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: IFT      Model: A16U-G2421       Rev: 342A
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K5_73SCA  Rev: JNZH
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi3 Channel: 00 Id: 05 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K5_73SCA  Rev: JNZH
  Type:   Direct-Access                    ANSI SCSI revision: 03

SCSI driver boot messages:
[...]
Nov 22 19:53:52 setup kernel: SCSI subsystem driver Revision: 1.00
Nov 22 19:53:52 setup kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Nov 22 19:53:52 setup kernel:         <Adaptec 29320ALP Ultra320 SCSI adapter>
Nov 22 19:53:52 setup kernel:         aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 22 19:53:52 setup kernel:
Nov 22 19:53:52 setup kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Nov 22 19:53:52 setup kernel:         <Adaptec 29320ALP Ultra320 SCSI adapter>
Nov 22 19:53:52 setup kernel:         aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 22 19:53:52 setup kernel:
Nov 22 19:53:52 setup kernel: scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Nov 22 19:53:52 setup kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Nov 22 19:53:52 setup kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 22 19:53:52 setup kernel:
Nov 22 19:53:52 setup kernel: scsi3 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
Nov 22 19:53:52 setup kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Nov 22 19:53:52 setup kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 22 19:53:52 setup kernel:
Nov 22 19:53:52 setup kernel: blk: queue f7ace618, I/O limit 4095Mb (mask 0xffffffff)
Nov 22 19:53:52 setup kernel: (scsi2:A:0): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
Nov 22 19:53:52 setup kernel: (scsi1:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
Nov 22 19:53:52 setup kernel: (scsi3:A:5): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
Nov 22 19:53:52 setup kernel:   Vendor: IFT       Model: A16U-G2421        Rev: 342A
Nov 22 19:53:52 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 22 19:53:52 setup kernel: blk: queue f7ace418, I/O limit 4095Mb (mask 0xffffffff)
Nov 22 19:53:52 setup kernel:   Vendor: IFT       Model: A16U-G2421        Rev: 342A
Nov 22 19:53:52 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 22 19:53:52 setup kernel: blk: queue f7ace018, I/O limit 4095Mb (mask 0xffffffff)
Nov 22 19:53:52 setup kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Nov 22 19:53:52 setup kernel: scsi1:A:0:1: Tagged Queuing enabled.  Depth 32
Nov 22 19:53:52 setup kernel:   Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
Nov 22 19:53:52 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 22 19:53:52 setup kernel: blk: queue f7261c18, I/O limit 4095Mb (mask 0xffffffff)
Nov 22 19:53:52 setup kernel: scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
Nov 22 19:53:52 setup kernel:   Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
Nov 22 19:53:52 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 22 19:53:52 setup kernel: blk: queue f7261a18, I/O limit 4095Mb (mask 0xffffffff)
Nov 22 19:53:52 setup kernel: scsi3:A:5:0: Tagged Queuing enabled.  Depth 32
Nov 22 19:53:52 setup kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Nov 22 19:53:52 setup kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 1
Nov 22 19:53:52 setup kernel: Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Nov 22 19:53:52 setup kernel: Attached scsi disk sdd at scsi3, channel 0, id 5, lun 0
[...]

Both Maxtor discs are used in a SW-RAID1 for the system
volume group and they work fine for a few days now.

Today I tried to integrate the external EonStor RAID and first
it seemd to work fine, too. The system did find the devices
and I could create a new volume group with several logical
volumes out of them.

But as soon as I try to create a filesystem on the new logical
volumes or do some other work with the devices, the SCSI driver
goes berserk:
[...]
Nov 22 19:56:14 setup kernel: scsi1:0:0:0: Attempting to abort cmd f71dec00: 0x2a 0x0 0x1 0x71 0x3 0x0 0x0 0x0 0x8 0x0
Nov 22 19:56:14 setup kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Nov 22 19:56:14 setup kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Nov 22 19:56:14 setup kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
Nov 22 19:56:14 setup kernel: Card was paused
Nov 22 19:56:14 setup kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11]
Nov 22 19:56:14 setup kernel: DFFSTAT[0x33] SCSISIGI[0x25] SCSIPHASE[0x0] SCSIBUS[0x0]
Nov 22 19:56:14 setup kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0]
Nov 22 19:56:14 setup kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10]
Nov 22 19:56:14 setup kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0]
Nov 22 19:56:14 setup kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]
Nov 22 19:56:14 setup kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40]
Nov 22 19:56:14 setup kernel:
Nov 22 19:56:14 setup kernel: SCB Count = 32 CMDS_PENDING = 32 LASTSCB 0x10 CURRSCB 0x7 NEXTSCB 0xff80
Nov 22 19:56:14 setup kernel: qinstart = 268 qinfifonext = 268
Nov 22 19:56:14 setup kernel: QINFIFO:
Nov 22 19:56:14 setup kernel: WAITING_TID_QUEUES:
Nov 22 19:56:14 setup kernel:        0 ( 0x7 )
Nov 22 19:56:14 setup kernel: Pending list:
Nov 22 19:56:14 setup kernel:   7 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  19 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  15 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  10 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  11 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  12 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   5 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  13 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   4 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   1 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   9 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:   8 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  14 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  30 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  31 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  25 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  26 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  27 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  29 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  20 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  21 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  22 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  23 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  24 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  16 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  17 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel:  18 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 22 19:56:14 setup kernel: Total 32
Nov 22 19:56:14 setup kernel: Kernel Free SCB list:
Nov 22 19:56:14 setup kernel: Sequencer Complete DMA-inprog list:
Nov 22 19:56:14 setup kernel: Sequencer Complete list:
Nov 22 19:56:14 setup kernel: Sequencer DMA-Up and Complete list:
Nov 22 19:56:14 setup kernel:
Nov 22 19:56:14 setup kernel: scsi1: FIFO0 Free, LONGJMP == 0x8251, SCB 0x11
Nov 22 19:56:14 setup kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]
Nov 22 19:56:14 setup kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
Nov 22 19:56:14 setup kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0
Nov 22 19:56:15 setup kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
[...]

And so on, until the external SCSI devices become unusable.
The system is still running on the internally connected
SCSI drives, though.

I found some messages reporting similar problems on this
list, a few weeks ago (beginning of October 2005). There
was also a patch for the aic79xx driver mentioned, but I
haven't found any report about it since then, so I don't
know the status of the patch (it was for the 2.6 kernel,
anyway, as far as I remember)

What can I do to make the external RAID usable?
Dump the Adaptec cards and replace them with something better?
Patch the driver?

Any help is appreciated!

Thanks!

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDg47JxJmyeGcXPhERAmHJAKDDneUcGWBG/DO6BmErT+EFm3WDUgCfYrW7
jjGW+en9tiILjo5XhcFa5Cc=
=GR+f
-----END PGP SIGNATURE-----
