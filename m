Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWBTLIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWBTLIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBTLIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:08:13 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:45406 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932227AbWBTLIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:08:12 -0500
Message-ID: <43F9A31B.3010608@tls.msk.ru>
Date: Mon, 20 Feb 2006 14:08:11 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: aacraid: strange array [detection] behaviour
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I noticied the following text in dmesg, which was
here for a long time:

SCSI subsystem initialized
Adaptec aacraid driver (1.1-4 Feb 19 2006 18:08:14)
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 52 (level, low) -> IRQ 169
AAC0: kernel 4.2-0[7348]
AAC0: monitor 4.2-0[7348]
AAC0: bios 4.2-0[7348]
AAC0: serial c3c8bf
scsi0 : aacraid
  Vendor: Adaptec   Model: 1                 Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 580452352 512-byte hdwr sectors (297192 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
SCSI device sda: 580452352 512-byte hdwr sectors (297192 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi removable disk sda

There are several questions about it.

 o What's this "got wrong page" message and "Mode sense" stuff?
   It looks like sd_mod (or whatever) wants to get some info from
   the "drive" (which is a virtual scsi drive, it's a raid array
   in reality), and hardware returns something unexpected.  Is it
   a controller issue?

 o Why linux "thinks" it's a removable disk?  It's not removable
   in any sense.  I dunno how the fact that it's "removable"
   affects other I/O operations, but the fact itself is somewhat
   strange.

Also, I noticied this:

# hdparm -t /dev/sda
 Timing buffered disk reads:  210 MB in  3.00 seconds =  70.00 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device

What does it mean, and should i be concerned?  It looks like the
drive (some "part" of it anyway, be it the controller, or driver,
or physical drives) does not implement a command which is useful
and even important to ensure proper write ordering/commits.

The above output is from 2.6.15.4 kernel, but looking at syslog
it seems the same behaviour was here for a long time, at least
since 2.6.11 (first log entry I have).

The controller is like this (from lspci):
0000:04:02.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
        Subsystem: Adaptec AAR-21610SA PCI SATA 16ch (Corsair-16)
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 169
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at feaf8000 [disabled] [size=32K]
        Capabilities: [80] Power Management version 2

Thanks.

/mjt
