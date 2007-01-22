Return-Path: <linux-kernel-owner+w=401wt.eu-S1751314AbXAVJrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXAVJrb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXAVJrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 04:47:31 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:50329 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXAVJra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 04:47:30 -0500
Subject: Re: SATA hotplug from the user side ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45AAE52B.2070705@gmail.com>
References: <1168588629.5403.7.camel@localhost>
	 <45A7BFB0.9090308@garzik.org> <1168639639.3707.6.camel@localhost>
	 <45A83C22.6050409@gmail.com> <1168672966.3707.24.camel@localhost>
	 <45AAE52B.2070705@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Jan 2007 09:04:42 +0000
Message-Id: <1169456682.2901.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 11:21 +0900, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > Jeff & Tejun thanks *a lot* for clarifying this. I am quite happy to see
> > that this is working very reliably!
> 
> You're welcome.  :-)
> 
> >>> These messages sound eval - so now the question is should I care ?
> >>> ( On the other hand it did not crash the machine )
> >> So, no, you don't really have to care.  Just make sure the device is
> >> unmounted prior to unplugging.
> > 
> > OK, but then this really should be in the SATA hotplug FAQ (or can one
> > fix this somehow?)... No user will ignore messages like this. What is
> 
> Yeah, probably.  Care to submit patch to FAQ to Jeff?

OK, how about this (please especially check the non SIL part):

SATA Hotplug from the User Side

- For SIL3114 and SIL3124 you don't have to run any commands at all. It
should notice when you yank the cable, or plug in a new device. All you
have to do is to stop using the devices before unplugging, e.g. unmount
partitions on the disk or remove the disk from a dm setup). One can
validate which disks are attached using ``scsiadd -p''. Note that the
device name may change from e.g. /dev/sdd to /dev/sde on a
remove/reinsert cycle (this can be fixed by using udev-provided
persistent names). Also note that it is perfectly normal to see messages
like this in dmesg:

<removing /dev/sdd>

ata4: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 310)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 310)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 310)
ata4.00: disabled
ata4: EH complete
ata4.00: detaching (SCSI 3:0:0:0)
Synchronizing SCSI cache for disk sdd: 
FAILED
  status = 0, message = 00, host = 4, driver = 00
  <3>ata4: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata4: hard resetting port
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port

<reinserting the disk>
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/100
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0
ANSI: 5
SCSI device sde: 1465149168 512-byte hdwr sectors (750156 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 1465149168 512-byte hdwr sectors (750156 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: unknown partition table
sd 3:0:0:0: Attached scsi disk sde
sd 3:0:0:0: Attached scsi generic sg3 type 0

However if you happen to see messages like

scsi 3:0:0:0: rejecting I/O to dead device
scsi 4:0:0:0: rejecting I/O to dead device
scsi 5:0:0:0: rejecting I/O to dead device

you did not stop using the devices before unplugging (check that you
unmounted all partitions, removed the disk from a raid array, dmsetup,
cryptsetup).  If you have no pending IO to the device, there won't be
'rejects IO to dead device' messages.

- For other chipsets one in addition to stop using the device before
unplugging has to call scsiadd -r to fully remove it, e.g. in the
following example the disk on scsi host 3 channel 0 id 0 lun 0 will be
removed, then on reinserting a disk call scsiadd -s :

# scsiadd -p

Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400620AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05

# scsiadd -r 3 0 0 0
# scsiadd -s

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
