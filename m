Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317959AbSGRLTM>; Thu, 18 Jul 2002 07:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317973AbSGRLTM>; Thu, 18 Jul 2002 07:19:12 -0400
Received: from t6o53p85.telia.com ([212.181.176.205]:58499 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S317959AbSGRLTK>;
	Thu, 18 Jul 2002 07:19:10 -0400
To: Greg KH <greg@kroah.com>
Cc: Pierre ROUSSELET <pierre.rousselet@wanadoo.fr>,
       Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.25  uhci-hcd  very bad
References: <3D308A30.7070702@wanadoo.fr> <20020717213332.GA10227@kroah.com>
	<3D2A7916004B5024@mel-rta10.wanadoo.fr>
	<20020718060551.GB12626@kroah.com>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jul 2002 13:18:42 +0200
In-Reply-To: <20020718060551.GB12626@kroah.com>
Message-ID: <m2bs95e12l.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Thu, Jul 18, 2002 at 08:35:37AM +0200, Pierre ROUSSELET wrote:
> > The driver is made of a kernel module speedtch.o (built outside of the
> > tree) and of userspace modem firmware loader and management daemon
> > speedmgt.
> 
> I'd suggest asking the authors of the driver about this.

I also get the "very bad" message when booting 2.5.25 and 2.5.26, even
if no usb devices are connected. From dmesg:

        Freeing unused kernel memory: 200k freed
        Adding 104824k swap on /dev/hda3.  Priority:-1 extents:1
        usb.c: registered new driver usbfs
        usb.c: registered new driver hub
        uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
        PCI: Assigned IRQ 10 for device 00:07.2
        hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB
        hcd-pci.c: irq 10, io base 0000f300
        hcd.c: new USB bus registered, assigned bus number 1
        uhci-hcd.c: detected 2 ports
        hcd.c: 00:07.2 root hub device address 1
        usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
        Product: Intel Corp. 82371AB PIIX4 USB
        Manufacturer: Linux 2.5.26-packet uhci-hcd
        SerialNumber: 00:07.2
        hub.c: USB hub found at /
        hub.c: 2 ports detected
        hub.c: standalone hub
        hub.c: ganged power switching
        hub.c: global over-current protection
        hub.c: Port indicators are not supported
        hub.c: power on to power good time: 2ms
        hub.c: hub controller current requirement: 0mA
        hub.c: port removable status: RR
        hub.c: local power source is good
        hub.c: no over-current condition exists
        hub.c: enabling power on all ports
        usb.c: hub driver claimed interface c10ce460
        usb.c: kusbd: /sbin/hotplug add 1
        uhci-hcd.c: f300: suspend_hc
        uhci-hcd.c: f300: wakeup_hc
        uhci-hcd.c: f300: suspend_hc
        uhci-hcd.c: f300: wakeup_hc
        ...                             (usually repeated about 50 times)
        uhci-hcd.c: f300: suspend_hc
        uhci-hcd.c: f300: host controller halted. very bad
        uhci-hcd.c: f300: wakeup_hc

This happens both with preemtible and non-preemtible kernels. I can
still use a Freecom usb cdrw drive though, so maybe this is not a
problem, even though the message indicates that it is.

I also have a performance problem with the uhci-hcd driver. When
writing data to a CDRW in packet writing mode, usb_stor_freecom_reset
is called quite often, see logs below. This happens in both 2.5.25 and
2.5.26. I tested with the usb-uhci-hcd driver in 2.5.25 (edited the
Makefile) just to rule out kernel changes and other usb changes, but
that driver didn't have this problem. I saw one or two freecom reset
messages though, so it's possible that the new driver just makes an
old problem much more frequent.

pengo:/home/petero# tail -f -n 10000 /var/log/debug | egrep 'Command |reset'
        ...
        Jul 18 12:57:04 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:05 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:05 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:05 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:05 pengo kernel: freecom reset called
        Jul 18 12:57:05 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:06 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:06 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:06 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:07 pengo kernel: freecom reset called
        Jul 18 12:57:07 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:08 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:08 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:08 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:08 pengo kernel: freecom reset called
        Jul 18 12:57:08 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:10 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:10 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:10 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:10 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:11 pengo kernel: freecom reset called
        Jul 18 12:57:11 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:13 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:13 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:13 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:13 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:15 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:15 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:16 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:16 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:16 pengo kernel: freecom reset called
        Jul 18 12:57:16 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:17 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:20 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:20 pengo kernel: freecom reset called
        Jul 18 12:57:20 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:20 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:21 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
        Jul 18 12:57:21 pengo kernel: freecom reset called
        ...

>From /var/log/debug:

Jul 18 12:18:11 pengo kernel: usb-storage: queuecommand() called
Jul 18 12:18:11 pengo kernel: usb-storage: *** thread sleeping.
Jul 18 12:18:11 pengo kernel: usb-storage: *** thread awakened.
Jul 18 12:18:11 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
Jul 18 12:18:11 pengo kernel: usb-storage: 2a 00 00 00 1b e0 00 00 20 00 00 00
Jul 18 12:18:11 pengo kernel: usb-storage: Freecom TRANSPORT STARTED
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 2a 00 00 00 1b e0 00 00 - 20 00 00 00             - *....... ...
Jul 18 12:18:11 pengo kernel: usb-storage: foo Status result 0 4
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 4a 00 00 f8                                       - J...
Jul 18 12:18:11 pengo kernel: usb-storage: Device indicates that it has 63488 bytes available
Jul 18 12:18:11 pengo kernel: usb-storage: SCSI requested 65536
Jul 18 12:18:11 pengo kernel: usb-storage: Write data Freecom! (c=65536)
Jul 18 12:18:11 pengo kernel: usb-storage: Done issuing write request: 0 64
Jul 18 12:18:11 pengo kernel: usb-storage: Start of write
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 0
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 4096
... [cut]
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 61440
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul 18 12:18:11 pengo kernel: usb-storage: freecom_writedata done!
Jul 18 12:18:11 pengo kernel: usb-storage: FCM: Waiting for status
Jul 18 12:18:11 pengo kernel: usb-storage: operation failed
Jul 18 12:18:11 pengo kernel: usb-storage: -- transport indicates command failure
Jul 18 12:18:11 pengo kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jul 18 12:18:11 pengo kernel: usb-storage: Freecom TRANSPORT STARTED
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 03 00 00 00 12 00 00 00 - 20 00 00 00             - ........ ...
Jul 18 12:18:11 pengo kernel: usb-storage: foo Status result 0 4
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 52 03 ff ff                                       - R...
Jul 18 12:18:11 pengo kernel: usb-storage: Device indicates that it has 65535 bytes available
Jul 18 12:18:11 pengo kernel: usb-storage: SCSI requested 18
Jul 18 12:18:11 pengo kernel: usb-storage: Truncating request to match buffer length: 18
Jul 18 12:18:11 pengo kernel: usb-storage: SCSI wants data, drive doesn't have any
Jul 18 12:18:11 pengo kernel: usb-storage: -- auto-sense failure
Jul 18 12:18:11 pengo kernel: freecom reset called
Jul 18 12:18:11 pengo kernel: usb-storage: scsi cmd done, result=0x70000
Jul 18 12:18:11 pengo kernel: usb-storage: queuecommand() called
Jul 18 12:18:11 pengo kernel: usb-storage: *** thread sleeping.
Jul 18 12:18:11 pengo kernel: usb-storage: *** thread awakened.
Jul 18 12:18:11 pengo kernel: usb-storage: Command WRITE_10 (10 bytes)
Jul 18 12:18:11 pengo kernel: usb-storage: 2a 00 00 00 1b e0 00 00 20 00 00 00
Jul 18 12:18:11 pengo kernel: usb-storage: Freecom TRANSPORT STARTED
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 2a 00 00 00 1b e0 00 00 - 20 00 00 00             - *....... ...
Jul 18 12:18:11 pengo kernel: usb-storage: foo Status result 0 4
Jul 18 12:18:11 pengo kernel: usb-storage: 00000000: 4a 00 00 f8                                       - J...
Jul 18 12:18:11 pengo kernel: usb-storage: Device indicates that it has 63488 bytes available
Jul 18 12:18:11 pengo kernel: usb-storage: SCSI requested 65536
Jul 18 12:18:11 pengo kernel: usb-storage: Write data Freecom! (c=65536)
Jul 18 12:18:11 pengo kernel: usb-storage: Done issuing write request: 0 64
Jul 18 12:18:11 pengo kernel: usb-storage: Start of write
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 0
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 4096
... [cut]
Jul 18 12:18:11 pengo kernel: usb-storage: transfer_amount: 65536 and total_transferred: 61440
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
Jul 18 12:18:11 pengo kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul 18 12:18:11 pengo kernel: usb-storage: freecom_writedata done!
Jul 18 12:18:11 pengo kernel: usb-storage: FCM: Waiting for status
Jul 18 12:18:12 pengo kernel: usb-storage: Transfer happy
Jul 18 12:18:12 pengo kernel: usb-storage: scsi cmd done, result=0x0
Jul 18 12:18:12 pengo kernel: usb-storage: *** thread sleeping.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
