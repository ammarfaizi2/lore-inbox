Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267400AbSKSVwr>; Tue, 19 Nov 2002 16:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbSKSVwr>; Tue, 19 Nov 2002 16:52:47 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:48905 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267400AbSKSVwp>; Tue, 19 Nov 2002 16:52:45 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB194C@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Steven Timm'" <timm@fnal.gov>, linux-kernel@vger.kernel.org
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError } 
Date: Tue, 19 Nov 2002 13:59:38 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0x40 indicate Uncorrectable ECC errors. CHeck the SMART data from the drive
using utility called smartctl. You should probably see a Current Pending
Count. As long as the pending sector does not reallocated, you will continue
to see this problem when reading that specific sector. WHat you can do is
write to that sector and get the sector remapped. Once remapped, these
problems on that sector wont occur.

ALso, we had been using TYAN S2518 with OSB4 in UDMA 2. However, it causes
data corruption when there is IO with even one drive. We used two drives in
master-master and master-slave mode and it did not solve the problem. EVen
at UDMA 0, we experienced the same issue of data corruption. Once does not
need to have 0x40 errors to see this corruption. If you want to see this
corruption, use the dt utility and then run:

./dt of=/dev/hdc bs=300M incr=512 enable=raw iodir=forward pattern=iot
log=tst_hdc.log dispose=keep iodir=reverse iotype=sequential pattern=iot
enable=compare,coredump,debug,raw,verify,verbose,pstats &

on hda and hdc. Also, try to have network traffic in parallel. This will
result in data getting shifted by 4 bytes ...

-----Original Message-----
From: Steven Timm [mailto:timm@fnal.gov]
Sent: Tuesday, November 19, 2002 1:47 PM
To: linux-kernel@vger.kernel.org
Subject: Serverworks dma_intr: error=0x40 { UncorrectableError } 



The problems with the Serverworks OSB4 chipset are well documented
on this list.  It is known that changing to multi-word DMA mode
will severely reduce problems.  However, since we need high
throughput in our application, we are running at high DMA speeds still.
The configuration in question is:

2.4.9-31smp kernel, Tyan 2518 motherboard, Western Digital 20 Gb system
disk hda, and hdc and hdd being each a 40Gb Western Digital drive.

The error usually happens on the system disk.  In that location
of the disk, there are usually some corrupted files as a result.
But when we either reinstall the system disk, formatting checking
for bad blocks, or low-level format the disk and reinstall, the
system is able to go on for quite some length of time
without these errors repeating.

My question--is there any way that the Serverworks OSB4 could be
causing a soft error on the disk such that the disk appears to
be bad (sometimes to the point that SMART puts up an alert in
the BIOS saying it is bad) but yet can still be used effectively?

(And yes, I am aware that the 2.4.18 kernels trap this condition and
usually stop the file corruption before it happens.)

Nov  7 05:08:10 fnd0102 kernel: Curious - OSB4 thinks the DMA is still
running.
Nov  7 05:08:10 fnd0102 kernel: OSB4 wait exit.
Nov  7 05:08:10 fnd0102 kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Nov  7 05:08:10 fnd0102 kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=4457382, sector=4457312
Nov  7 05:08:10 fnd0102 kernel: end_request: I/O error, dev 03:01 (hda),
sector
4457312
Nov  7 05:08:10 fnd0102 kernel: EXT2-fs error (device ide0(3,1)):

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
