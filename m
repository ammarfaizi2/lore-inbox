Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTEZCpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTEZCpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:45:42 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:25865 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263898AbTEZCpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:45:36 -0400
Message-ID: <3ED1831F.30203@torque.net>
Date: Mon, 26 May 2003 12:59:43 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
References: <20030524195123.GA8394@gtf.org>
In-Reply-To: <20030524195123.GA8394@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
<snip/>
> * Serial ATA is looming quickly on the horizon.  Both device and host
>   controller SATA implementations really lend themselves to behaviors
>   that have existed in SCSI for a while.  SATA even defines use of SCSI
>   Enclosure Services.

That last statement is interesting. SATA-1 has a maximum
length of 1 metre and no external connector/cable definitions
(I think). Serial attached SCSI (SAS) uses SATA-1 connector/cable
definitions for internal connections and defines its own
external connector/cable definitions (up to 6 metres). The
SCSI Enclosure Services (SES) command set "is defined for
managing various non-SCSI elements contained within the
enclosure" (according to its draft standard abstract).
So it seems that the 1 metre of SATA may be going to a external
enclosure (e.g. RAID or JBOD). Recent SATA versus SAS
comparisons have noted that even though SATA is a point to
point protocol, fan out devices have been demonstrated.

BTW The SATA people at t13.org signed an agreement with the
SAS folks at t10.org in February this year so hopefully there
will be a convergence in several areas in the future.

This driver is very relevant to a SAS HBA which allows
both SAS disks and SATA disks to be controlled **. The
SAS standard envisages that such SATA disks will be
controlled by a "normal" ATA application layer in the
host machine.

> * The Linux SCSI layer handles hotplugging, and is more modular.
>   It already has refcounted devices and sysfs and such.  Creating a
>   new block device driver from scratch means handling all those
>   little details.
> 
> * SCSI has been doing basic error recovery and queue control for a
>   while now.  Upcoming SATA2 will benefit greatly from this, as well
>   ATA TCQ if I ever get around to implementing the latter.
> 
> * ATAPI is SCSI-like.

The MMC standards that define the command set for CD/DVDs
across ATAPI (as well as other transports, including 1394
and USB) are under the SCSI "umbrella" at t10.org . The MMC
drafts have transport specific appendices that outline some
of the compromises. Is the ATAPI transport used for anything
other than carrying SCSI command sets?

> Build notes
> -----------
<snip>
> 
> * PATA stressed similarly, on one box.

I loaded your patch and built it against lk 2.5.69-bk17.
It compiled clean (without the patch to move the scsi
headers into the ~linux/include/scsi directory), built
and loaded.

However there were no signs of life from my Maxtor
D740X-6L (P)ATA-5 disk. The PATA selection in the .config
file doesn't have a module option. Actually there
seems no specific code for PATA in your patch
(apart from libata.c) and no mention of
CONFIG_SCSI_ATA_PATA in drivers/scsi/Makefile .

> Near-future directions
> ----------------------
> 
> * ATAPI (see below)
> 
> * libata.c DMA and taskfile handling is still host-controller specific.
>   It's the most widely used host controller standard, sure.  But that
>   mainly applies to PATA devices.
> 
>   Future host controllers, with a tiny additional bit of
>   abstracting-out, will simply ignore these functions (provided as
>   defaults for most host controllers) and use their own.
> 
> * Better error handling (see below), and more command queueing work
> 
> 
> ATA notes
> ---------
> 
> * Supports max UDMA/33 for PATA right now.  Temporary limitation because
>   I'm too slack to worry about cable detection.

Perhaps my IDE interface chip isn't supported:

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC
    Bus Master IDE (rev 06)

> * No packet command -- yet.  And thus, no ATAPI cdroms/burners/etc.
>   Coming soon!

Look forward to that.

<snip>


Thinking about how existing applications such as
hdparm and smartmontools will cope with an ATA device
(e.g. a disk) with a device node like "/dev/sdb".
Those apps would make the assumption from the device
name that such a device should be sent a SCSI command
set. So perhaps we need a "transport" indicator in
the sysfs directory for that device (dare I mention
another ioctl).


** When a SATA disk is connected to a SAS HBA there needs
to be an expander in between them that does the physical
and link layer translation.

Doug Gilbert

