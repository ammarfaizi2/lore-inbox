Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUEKTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUEKTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUEKTIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:08:16 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:11407 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S263407AbUEKTHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:07:51 -0400
Message-ID: <40A12427.6000109@keyaccess.nl>
Date: Tue, 11 May 2004 21:06:15 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <20040510221729.3b8e93da.akpm@osdl.org> <40A0B7DA.9090905@keyaccess.nl> <200405111537.23535.bzolnier@elka.pw.edu.pl> <40A1073E.3030605@keyaccess.nl>
In-Reply-To: <40A1073E.3030605@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> Bartlomiej Zolnierkiewicz wrote:
> 
>> Please revert ALL changes to 2.6.6 and gather some debug information
>> using these simple patch.
> 
> 
> Vanilla 2.6.6 with just this patch, at boot, directly after the 
> partition scan:
> 
> hda: wcache=1 cmd=234
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: Write Cache FAILED Flushing!
> 
> At reboot or halt:
> 
> Shutdown: hda
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: DMA disabled
> ide0: reset: success
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> ide0: reset: success
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> Restarting system.
> 
>> Oh and please check 'wcache' value from /proc/ide/hda/settings
>> now and with this patch applied.
> 
> 
> Vanilla 2.6.6:
> 
> rene@7ixe4:~/cache$ grep wcache settings-2.6.6
> wcache                  1               0               1               rw
> 
> 2.6.6 with the de{flush,spin}ification patches:
> 
> rene@7ixe4:~/cache$ grep wcache settings-2.6.6-hackedup
> wcache                  0               0               1               rw
> 
> Hrmpf. 0?
> 
> Will test a few older Maxtor drives as well tonight. Hope it's useful.

Sorry for quoting everything, forgot to CC lkml first time.

Only took one. Does not happen on a (slightly) older Maxtor 4W030H2, 30G 
5400RPM drive. 2.6.6 vanilla with your debug patch:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 4W030H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
hdd: 6X4X32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(33)
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA

rene@5bt0:~$ su -c "cat /proc/ide/hda/settings" | grep wcache
wcache                  1               0               1               rw

Rene.
