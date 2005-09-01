Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVIAM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVIAM1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIAM1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:27:46 -0400
Received: from spirit.analogic.com ([208.224.221.4]:23059 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965090AbVIAM1p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:27:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-ID: <Pine.LNX.4.61.0509010755440.6373@chaos.analogic.com>
In-Reply-To: <20050901113614.GA63@DervishD>
References: <20050901113614.GA63@DervishD>
X-OriginalArrivalTime: 01 Sep 2005 12:27:44.0964 (UTC) FILETIME=[8E1DF840:01C5AEF0]
Content-class: urn:content-classes:message
Subject: Re: USB Storage speed regression since 2.6.12
Date: Thu, 1 Sep 2005 08:29:00 -0400
Message-ID: <Pine.LNX.4.61.0509010744050.14182@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB Storage speed regression since 2.6.12
Thread-Index: AcWu8I4lIIVm/PNZQOOOs7/+t9rAiQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "DervishD" <lkml@dervishd.net>
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Sep 2005, DervishD wrote:

>    Hi all :)
>
>    I don't know if this is a known issue, but usb-storage speed for
> 'Full speed' devices dropped from 2.6.11.12 (more than 800Kb/s) to
> 2.6.12 (less than 250Kb/s). The problem still exists in 2.6.13.
>
>    The lack of speed seems to affect only the OHCI driver. My test
> was done over a PCI USB 2.0 card, ALi chipset, OHCI driver (well
> EHCI+OHCI) and using a full speed device capable of 12MBps. The
> average measured speeds are:
>
>    - 2.4.31:           about 450Kb/seg
>    - 2.6.11-Debian:    about 800Kb/seg
>    - 2.6.11.12:        about 820Kb/seg
>    - 2.6.12.x:         about 200Kb/seg
>    - 2.6.13:           about 200Kb/seg
>
>    The .config is more or less the same in all kernels. I've took a
> look at the ChangeLog for 2.6.12 and there are lots of changes in the
> USB subsystem but I cannot identify which one could be the culprit.
>
>    If anyone needs more information (for example, device
> identification in all kernels) just tell. I don't provide much more
> information since this can be a known issue and so there is no need
> to pollute the list with a long .config and dmesg output...
>
>    Thanks in advance :)
>
>    Raúl Núñez de Arenas Coronado
>
> --
> Linux Registered User 88736 | http://www.dervishd.net
> http://www.pleyades.net & http://www.gotesdelluna.net
> It's my PC and I'll cry if I want to...
> -

The SCSI subsystem has similar problems. The speed has
gone down since linux-2.4.26. I'm compiling a bunch of
kernels to see which one starts the down-hill trend.
The SCSI disc sybsystem with this kernel (the initial RedHat
distribution, unmodified 2.6.5-1.358) is awful.

The data I have so far from `hdparam -tT` is:

linux-2.6.13

/dev/sda:
  Timing buffer-cache reads:   3036 MB in  2.00 seconds = 1515.96 MB/sec
  Timing buffered disk reads:   28 MB in  3.14 seconds =   8.93 MB/sec

/dev/sdb:
  Timing buffer-cache reads:   3052 MB in  2.00 seconds = 1523.95 MB/sec
  Timing buffered disk reads:   78 MB in  3.01 seconds =  25.87 MB/sec

/dev/sdc:
  Timing buffer-cache reads:   3024 MB in  2.00 seconds = 1511.47 MB/sec
  Timing buffered disk reads:   56 MB in  3.11 seconds =  18.01 MB/sec

/dev/hda:
  Timing buffer-cache reads:   3040 MB in  2.00 seconds = 1520.23 MB/sec
  Timing buffered disk reads:  132 MB in  3.02 seconds =  43.66 MB/sec

linux-2.4.26	(baseline)

/dev/sda:
  Timing buffer-cache reads:   3032 MB in  2.00 seconds = 1589.64 MB/sec
  Timing buffered disk reads:  128 MB in  3.12 seconds =  43.02 MB/sec

/dev/sdb:
  Timing buffer-cache reads:   3062 MB in  2.00 seconds = 1605.36 MB/sec
  Timing buffered disk reads:  166 MB in  3.01 seconds =  58.73 MB/sec

/dev/sdc:
  Timing buffer-cache reads:   3024 MB in  2.00 seconds = 1511.47 MB/sec
  Timing buffered disk reads:  102 MB in  3.08 seconds =  34.72 MB/sec

/dev/hda:
  Timing buffer-cache reads:   3032 MB in  2.00 seconds = 1589.64 MB/sec
  Timing buffered disk reads:  130 MB in  3.01 seconds =  45.28 MB/sec

Linux-2.4.26 had reasonable performance. The latest kernel has
essentially the same IDE performance, but absolutely awful SCSI
performance, sort of like a floppy.

IT looks as though the SCSI system isn't brought into
synchronous mode because there are two slow devices
(urelated) on the NARROW interface even though there
are 3 WIDE FAST devices on the other bus.

SCSI subsystem initialized
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

   Vendor: SEAGATE   Model: ST32171W          Rev: 0484
   Type:   Direct-Access                      ANSI SCSI revision: 02
  target0:0:0: asynchronous.
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
  target0:0:0: Beginning Domain Validation
  target0:0:0: wide asynchronous.
  target0:0:0: Domain Validation skipping write tests
  target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
  target0:0:0: Ending Domain Validation
SCSI device sda: 4194057 512-byte hdwr sectors (2147 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 4194057 512-byte hdwr sectors (2147 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
   Vendor: SEAGATE   Model: ST318233LWV       Rev: 0002
   Type:   Direct-Access                      ANSI SCSI revision: 03
  target0:0:1: asynchronous.
scsi0:A:1:0: Tagged Queuing enabled.  Depth 4
  target0:0:1: Beginning Domain Validation
  target0:0:1: wide asynchronous.
  target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
  target0:0:1: Ending Domain Validation
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
   Vendor: SEAGATE   Model: ST39102LW         Rev: 0005
   Type:   Direct-Access                      ANSI SCSI revision: 02
  target0:0:2: asynchronous.
scsi0:A:2:0: Tagged Queuing enabled.  Depth 4
  target0:0:2: Beginning Domain Validation
  target0:0:2: wide asynchronous.
  target0:0:2: Domain Validation skipping write tests
  target0:0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
  target0:0:2: Ending Domain Validation
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
   Type:   CD-ROM                             ANSI SCSI revision: 02
  target0:0:4: asynchronous.
  target0:0:4: Beginning Domain Validation
  target0:0:4: Domain Validation skipping write tests
  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
  target0:0:4: Ending Domain Validation
libata version 1.12 loaded.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
