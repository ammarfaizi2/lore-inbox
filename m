Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWBTNZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWBTNZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWBTNZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:25:45 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:41859 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1030208AbWBTNZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:25:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: aacraid: strange array [detection] behaviour
Date: Mon, 20 Feb 2006 08:25:37 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F02280B4B@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: aacraid: strange array [detection] behaviour
Thread-Index: AcY2Dfl2h/7wlGTMSJGCDKvTWJshrQAEsCsg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>
Cc: "linux-scsi" <linux-scsi@vger.kernel.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong page error has been mitigated recently in a patch ([PATCH 1/3]
aacraid: reduce device probe warnings) by telling the scsi layer to not
request page 3F and 8. The driver emulates a *proper* empty mode page. I
have not checked how far this patch has propagated yet.

The arrays have always been reported as removable disks, this is done in
a multitude of array drivers and target devices. This is to ensure that
the partition table, capacity are not cached in Linux and that busy
(drive lock and drive unlock) status is detected and recorded for the
application layers. Arrays can be morphed, expanded, snapshotted all
leading to devices that come and go at varying capacities.

As for the flush complete, we emulate the SCSI Synchronize command. We
report BUSY if there are *any* commands outstanding in scsi queue, fully
expecting a retry from the upper layers. Otherwise we take it to the
controller (and in some conditions to the drives if the controller
determines it can not guarantee the ordered write). We have many
applications that report that the SCSI synchronize is functioning as
expected, we will have to investigate why hdparm is taking issue with
it; an inappropriate ioctl is *not* under control of the LLD as far as I
understand.

Sincerely -- Mark Salyzyn

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Michael Tokarev
> Sent: Monday, February 20, 2006 6:08 AM
> To: Kernel Mailing List
> Subject: aacraid: strange array [detection] behaviour
> 
> 
> Yesterday I noticied the following text in dmesg, which was
> here for a long time:
> 
> SCSI subsystem initialized
> Adaptec aacraid driver (1.1-4 Feb 19 2006 18:08:14)
> ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 52 (level, low) -> IRQ 169
> AAC0: kernel 4.2-0[7348]
> AAC0: monitor 4.2-0[7348]
> AAC0: bios 4.2-0[7348]
> AAC0: serial c3c8bf
> scsi0 : aacraid
>   Vendor: Adaptec   Model: 1                 Rev: V1.0
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 580452352 512-byte hdwr sectors (297192 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
> SCSI device sda: 580452352 512-byte hdwr sectors (297192 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> sd 0:0:0:0: Attached scsi removable disk sda
> 
> There are several questions about it.
> 
>  o What's this "got wrong page" message and "Mode sense" stuff?
>    It looks like sd_mod (or whatever) wants to get some info from
>    the "drive" (which is a virtual scsi drive, it's a raid array
>    in reality), and hardware returns something unexpected.  Is it
>    a controller issue?
> 
>  o Why linux "thinks" it's a removable disk?  It's not removable
>    in any sense.  I dunno how the fact that it's "removable"
>    affects other I/O operations, but the fact itself is somewhat
>    strange.
> 
> Also, I noticied this:
> 
> # hdparm -t /dev/sda
>  Timing buffered disk reads:  210 MB in  3.00 seconds =  70.00 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: 
> Inappropriate ioctl for device
> 
> What does it mean, and should i be concerned?  It looks like the
> drive (some "part" of it anyway, be it the controller, or driver,
> or physical drives) does not implement a command which is useful
> and even important to ensure proper write ordering/commits.
> 
> The above output is from 2.6.15.4 kernel, but looking at syslog
> it seems the same behaviour was here for a long time, at least
> since 2.6.11 (first log entry I have).
> 
> The controller is like this (from lspci):
> 0000:04:02.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
>         Subsystem: Adaptec AAR-21610SA PCI SATA 16ch (Corsair-16)
>         Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 169
>         Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Expansion ROM at feaf8000 [disabled] [size=32K]
>         Capabilities: [80] Power Management version 2
> 
> Thanks.
> 
> /mjt
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
