Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965436AbWJBVy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbWJBVy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbWJBVy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:54:26 -0400
Received: from cpe-70-113-217-93.austin.res.rr.com ([70.113.217.93]:22486 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id S965436AbWJBVyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:54:25 -0400
Date: Mon, 2 Oct 2006 16:54:10 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
cc: linux-scsi@vger.kernel.org
Subject: sata_promise driver disables IRQ for entire card when one device
 removed
Message-ID: <Pine.LNX.4.62.0610021627170.10249@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AMD64 Dual Opteron system with a self-compiled kernel from stock sources, 
Debian base.

SATA card is a Promise SATAII300 TX4, here is the lspci entry:

0000:01:03.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d17 (rev 02)

I was tracking 2.6.16 all the way up to .27, when it showed this 
behavior.  I then tried tried 2.6.17.13, and got the same result.  The logs 
below are from the attempt with 2.6.17.13.

During normal system operation, with no load, I tried pulling a SATA drive 
from the promise controller (in this case "ata1" which is sda) in order to 
test the system being able to handle a drive failure.

I immediately got this in the syslog:

Oct  2 16:14:43 stock kernel: irq 16: nobody cared (try booting with the "irqpoll" option)
Oct  2 16:14:43 stock kernel:
Oct  2 16:14:43 stock kernel: Call Trace: <IRQ> <ffffffff80299dd0>{__report_bad_irq+48}
Oct  2 16:14:43 stock kernel:        <ffffffff80299eec>{note_interrupt+140} <ffffffff80299584>{__do_IRQ+196}
Oct  2 16:14:43 stock kernel:        <ffffffff8025f352>{do_IRQ+66} <ffffffff8025c540>{default_idle+0}
Oct  2 16:14:43 stock kernel:        <ffffffff802545b8>{ret_from_intr+0} <EOI> <ffffffff80256ce0>{thread_return+0}
Oct  2 16:14:43 stock kernel:        <ffffffff8025c56f>{default_idle+47} <ffffffff8024092b>{cpu_idle+107}
Oct  2 16:14:43 stock kernel: handlers:
Oct  2 16:14:43 stock kernel: [pdc_interrupt+0/512] (pdc_interrupt+0x0/0x200)
Oct  2 16:14:43 stock kernel: Disabling IRQ #16

After this, all four of the disks on the Promise controller stopped working, 
I am assuming because of the interrupt being disabled, even though the other 
three should have been just fine.

This is a partial log of console errors after the IRQ was disabled (all that 
I was able to grab since I couldn't access any disks anymore).

ata1: command timeout
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
     Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 976767923
ata4: command timeout
ata4: status=0x50 { DriveReady SeekComplete }
sdd: Current<3>ata2: command timeout
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x301036
: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x301036
ata3: command timeout
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x301036
sdc: Current: sense key: No Sense
     Additional sense: No additional sense information
ata4: command timeout
ata4: status=0x50 { DriveReady SeekComplete }
ata2: command timeout
ata2: status=0x50 { DriveReady SeekComplete }
ata3: command timeout
ata3: status=0x50 { DriveReady SeekComplete }
ata4: command timeout
ata4: status=0x50 { DriveReady SeekComplete }
sdd: Current<3>ata2: command timeout
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x917e
: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x917e
ata3: command timeout
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x917e

Similar messages continued to be printed to the console, and any disk 
accesses continued to fail.  I waited about a half hour to see if the system 
would ever recover, and it never did.

I'd be happy to provide any additional information that may be helpful.

Evan
