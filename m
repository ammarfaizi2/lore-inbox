Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269519AbUINRXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269519AbUINRXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUINRMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:12:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51848 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269506AbUINRAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:00:46 -0400
Message-ID: <414723B0.1090600@pobox.com>
Date: Tue, 14 Sep 2004 13:00:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca>
In-Reply-To: <41471163.10709@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> My first attempt at posting this seems to have gone AWOL,
> so here it comes again.  Also being posted to linux-scsi.

There is that CC feature in your mailer, you know... :)

Repeating what I posted to linux-scsi:


> Here is the first public release of the 2.6.xx driver
> source code for the Pacific Digital Corporation QStor SATA/RAID chip.
> 
> This 4-channel chip has hardware-assisted RAID0/RAID1/RAID10,
> host-queuing, per-request TCQ/NCQ support, support for hot insertion
> and removal of drives, etc..  The 64-bit/66Mhz chip shows throughput
> in excess of 200MByte/sec on my ancient P3-1GHz test system,
> and can do much better when installed in a PCI-X slot.

How much of the RAID is actually hardware-assisted?

This looks pretty much like an ATA driver to me.

Linus vetoed future SCSI->ATA translators.  He only allowed libata 
because I promised to remove the translation and make it a native block 
driver in the future, which I have been working towards (see struct 
ata_queued_cmd, etc.)


> The driver (attached) supports most of the chip features,
> including host, native and legacy tagged queuing,
> but does not yet include boot-from-raid support (coming soon).
> 
> Both hdparm and smartmontools are fully supported by this driver.

Actual comments on the code:
0) so far, this driver looks like fake RAID to me...  if so that's a big 
veto.  if it's real RAID, only the following grumbles apply :)

1) not endian safe at all

2) I am dubious about including Yet Another set of event logging functions

3) in qstor_read_events you unlock the spinlock without first locking 
it, in one path (wait_event_interruptible rc==0)

4) qstor_extract_id_string appears to be generic across IDE/libata/qstor

5) new procfs stuff discouraged

6) style:  ditch braces on single statements, e.g.,

+               if (drive != NULL) {
+                       qstor_destroy_device(drive);
+               }


7) double spin_unlock_irq possible in qstor_create_device

8) use msleep() rather than schedule_timeout()

9) use of do_sleep paradigm is dubious:  you should instead try to keep 
your locked code regions as small as possible.  in general, this code 
has far too many unlock-doit-lock sections.

Experience has shown that too much unlock-doit-lock leads to bugs and 
increases the pain when analyzing your locking.

In particular, releasing the lock and sleeping would be very wrong in 
the ->queuecommand and error handling paths (alas...  I would love to 
sleep in the fine-grained eh hooks)

10) in qstor_scsi_done, when is cmd->scsi_done ever NULL?

11) do you properly keep track of the 'done' function passed to you in 
->queuecommand?  or do you mistakenly assume that cmd->scsi_done is the 
same as the ->queuecommand argument?

12) fix the sd.c code, don't add silly driver-specific workarounds:

+       buf[0] = TYPE_DISK;     // Cannot use TYPE_RAID -- sd.c rejects it

13) doh!  check for pci_map_xxx failure

14) use sg_dma_len() macro, not sg->length

15) Bart and I are slowly moving over to using linux/ata.h for 
ATA-generic constants and enums.  Please use ATA_CMD_xxx (and add 
constants to that header as required).

16) There are WAY too many magic numbers in this driver :(

17) Are you 100% certain of your queued error handling?  The reason why 
libata doesn't do NCQ is purely because error handling is so 
complicated.  Potential problems I don't see you handling (but I could 
be missing something!):

	a) on a bus error (not device error), one has _no idea_ which
	commands complete etc.
	b) if SERVICE interrupt is enabled, you may not get back the
	correct D2H Register FIS showing the errored device in question
	c) even if you receive the correct D2H Register FIS, you may
	need to manually abort the queue with a NOP

Queueing is easy.  Picking up the pieces when it fails isn't.

libata's error handling is dumb, but also easy to review and verify.

18) return -EFOO values from your PCI probe function

19) propagate return value from pci_enable_device

20) check (and return) pci_set_dma_mask retval

21) use the proper ULL suffix for pci_set_dma_mask argument

22) use pci_set_consistent_dma_mask also

23) use pci_request_regions to reserve resources

24) when qstor_probe fails, don't just return!  undo the stuff that 
occurred before the error (such as calling pci_disable_device or 
pci_release_regions or iounmap)

25) propagate return value from request_irq

26) check scsi_add_host return value

27) the following is highly silly.  you are locking a function, just so 
you can unlock a function so you can sleep.

+       spin_lock_irqsave(uhba->lock, flags);
+       qstor_reset(uhba);
+       spin_unlock_irqrestore(uhba->lock, flags);

28) "SECTOR_BYTES" -- how many more definitions of the 512-byte sector 
do we need?  :)

29) You use QSTOR_PACKED_STRUCTURE when not needed, which causes gcc to 
generate horribly sub-optimal code

30) style:  use u32/u64 as kernel standard.

+       unsigned pLEN           :32;    // Byte count
+       unsigned spare32        :32;    // 0

31) none of your bitfield structures are endian-safe

