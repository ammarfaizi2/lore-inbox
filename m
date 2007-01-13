Return-Path: <linux-kernel-owner+w=401wt.eu-S1161305AbXAMHW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbXAMHW5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbXAMHW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:22:56 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:62536 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161305AbXAMHWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:22:55 -0500
Subject: Re: SATA hotplug from the user side ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45A83C22.6050409@gmail.com>
References: <1168588629.5403.7.camel@localhost>
	 <45A7BFB0.9090308@garzik.org> <1168639639.3707.6.camel@localhost>
	 <45A83C22.6050409@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Jan 2007 08:22:46 +0100
Message-Id: <1168672966.3707.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-13 at 10:55 +0900, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > It is true it detects a removal and newly plugged devices immediately...
> > However it still prints warnings and errors that it could not
> > synchronize SCSI cache for the disks. Then it prints regular 'rejects
> > I/O to dead device' warning messages and on replugging the disks puts
> > them to the next free sd device (e.g. sdc -> sdd).
> 
> You need to stop using the devices before unplugging.  If you have no
> pending IO to the device, there won't be 'rejects IO to dead device'
> messages.  You can ignore the SCSI cache sync failure if the device is
> properly closed before being unplugged.

Jeff & Tejun thanks *a lot* for clarifying this. I am quite happy to see
that this is working very reliably!

> > These messages sound eval - so now the question is should I care ?
> > ( On the other hand it did not crash the machine )
> 
> So, no, you don't really have to care.  Just make sure the device is
> unmounted prior to unplugging.

OK, but then this really should be in the SATA hotplug FAQ (or can one
fix this somehow?)... No user will ignore messages like this. What is
especially annoying is that udev on the first remove/insert cycle
created a new device node so the disk became /dev/sde (was /dev/sdd):
dmesg output of reinserting the disk 2 times follows:

<remove /dev/sdd>
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

<insert>
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

<remove now /dev/sde>
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
Synchronizing SCSI cache for disk sde: 
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

<insert>
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

remains /dev/sde ... 

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
