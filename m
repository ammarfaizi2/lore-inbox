Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFGHB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFGHB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 03:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFGHB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 03:01:28 -0400
Received: from office.icomedias.com ([62.99.232.80]:25486 "EHLO
	relay.icomedias.com") by vger.kernel.org with ESMTP id S261255AbVFGHAy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 03:00:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [SATA] libata-dev queue updated
Date: Tue, 7 Jun 2005 09:00:48 +0200
Message-ID: <FA095C015271B64E99B197937712FD02510D0B@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [SATA] libata-dev queue updated
Thread-Index: AcVqtKdTI4u4/j7hTiu9oazNLv0z3wAdYvhA
From: "Bene Martin" <martin.bene@icomedias.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-ide@vger.kernel.org>, "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The two reasons why passthru is not upstream are:
> 
> * I need to make sure that it is 100% up-to-date for the latest ATA
> passthru spec, which clarified some SCSI CDB and descriptor codes.
> 
> * There was at least one report of ATA passthru use causing a device
> under load to start timing out, which could possibly indicate a driver
> bug. I need to do a serious analysis and final review of the patch, to
> make sure that it is plugged into the ATA host state machine at the
> correct places.

Just as a data point:

I've had a couple of problems on a system using sata+passthrough patch; 
not latest code though. I am reading smart info at fairly high frequency

(smartd + a smartctl call for each device every 5 minutes to graph drive
temperatures).

Versions used: 2.6.11.7 + 2.6.11-bk6-libata-dev1.patch.bz2

I got several ata errors, mostly in high - throughput situations (rsync 
over local network or rebuilding raid5), example from the logs:

Jun  5 04:13:50 backup kernel: ata3: command 0x25 timeout, stat 0x50
host_stat 0x1
Jun  5 06:30:51 backup kernel: ata3: command 0x35 timeout, stat 0x50
host_stat 0x1
Jun  5 10:46:50 backup kernel: ata3: command 0x35 timeout, stat 0x50
host_stat 0x1
Jun  5 10:47:20 backup kernel: ata3: command 0x35 timeout, stat 0x50
host_stat 0x1
Jun  5 10:53:45 backup kernel: ATA: abnormal status 0xD0 on port
0xE0802287
Jun  5 10:53:45 backup last message repeated 2 times
Jun  5 10:54:15 backup kernel: ata3: command 0x35 timeout, stat 0x50
host_stat 0x1
Jun  5 11:43:11 backup kernel: ATA: abnormal status 0xD0 on port
0xE0802287
Jun  5 11:43:11 backup last message repeated 2 times
Jun  5 11:43:41 backup kernel: ata3: command 0x35 timeout, stat 0x50
host_stat 0x1
Jun  5 14:23:45 backup kernel: ata3: command 0x35 timeout, stat 0x51
host_stat 0x1
Jun  5 14:23:45 backup kernel: ata3: status=0x51 { DriveReady
SeekComplete Error }
Jun  5 14:23:45 backup kernel: ata3: error=0x04 { DriveStatusError }
Jun  5 14:23:45 backup kernel: SCSI error : <3 0 0 0> return code =
0x8000002
Jun  5 14:23:45 backup kernel: sdc: Current: sense key: Aborted Command
Jun  5 14:23:45 backup kernel:     Additional sense: No additional sense
information
Jun  5 14:23:45 backup kernel: end_request: I/O error, dev sdc, sector
135917718
Jun  5 14:23:45 backup kernel: raid5: Disk failure on sdc6, disabling
device. Operation continuing on 2 devices

What makes me doubt the theory that smart/passthrough might be to blame 
is that I've only seen these errors on one of the 3 disks (always 
sdc/ata3). On the other hand, smart info for the drive doesn't show any 
errors or suspicious readings.

Boot log for the sata devices:

May 18 08:51:53 backup kernel: libata version 1.10 loaded.
May 18 08:51:53 backup kernel: sata_sil version 0.8
May 18 08:51:53 backup kernel: ACPI: PCI interrupt 0000:02:00.0[A] ->
GSI 21 (level, low) -> IRQ 21
May 18 08:51:53 backup kernel: ata1: SATA max UDMA/100 cmd 0xE0802080
ctl 0xE080208A bmdma 0xE0802000 irq 21
May 18 08:51:53 backup kernel: ata2: SATA max UDMA/100 cmd 0xE08020C0
ctl 0xE08020CA bmdma 0xE0802008 irq 21
May 18 08:51:53 backup kernel: ata3: SATA max UDMA/100 cmd 0xE0802280
ctl 0xE080228A bmdma 0xE0802200 irq 21
May 18 08:51:53 backup kernel: ata4: SATA max UDMA/100 cmd 0xE08022C0
ctl 0xE08022CA bmdma 0xE0802208 irq 21
May 18 08:51:53 backup kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
May 18 08:51:53 backup kernel: ata1: dev 0 ATA-7, max UDMA/133,
781422768 sectors: LBA48
May 18 08:51:53 backup kernel: ata1: dev 0 configured for UDMA/100
May 18 08:51:53 backup kernel: scsi1 : sata_sil
May 18 08:51:53 backup kernel: ata2: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
May 18 08:51:53 backup kernel: ata2: dev 0 ATA-7, max UDMA/133,
781422768 sectors: LBA48
May 18 08:51:53 backup kernel: ata2: dev 0 configured for UDMA/100
May 18 08:51:53 backup kernel: scsi2 : sata_sil
May 18 08:51:53 backup kernel: ata3: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
May 18 08:51:53 backup kernel: ata3: dev 0 ATA-7, max UDMA/133,
781422768 sectors: LBA48
May 18 08:51:53 backup kernel: ata3: dev 0 configured for UDMA/100
May 18 08:51:53 backup kernel: scsi3 : sata_sil
May 18 08:51:53 backup kernel: ata4: no device found (phy stat 00000000)
May 18 08:51:53 backup kernel: scsi4 : sata_sil
May 18 08:51:53 backup kernel:   Vendor: ATA       Model: ST3400832AS
Rev: 3.01
May 18 08:51:53 backup kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
May 18 08:51:53 backup kernel:   Vendor: ATA       Model: ST3400832AS
Rev: 3.01
May 18 08:51:53 backup kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
May 18 08:51:53 backup kernel:   Vendor: ATA       Model: ST3400832AS
Rev: 3.01
May 18 08:51:53 backup kernel:   Type:   Direct-Access
ANSI SCSI revision: 05

SATA controller used:

0000:02:00.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)

Bye, Martin
