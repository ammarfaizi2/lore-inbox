Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTIMSth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbTIMSth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:49:37 -0400
Received: from havoc.gtf.org ([63.247.75.124]:43411 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261649AbTIMStf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:49:35 -0400
Date: Sat, 13 Sep 2003 14:49:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913184934.GB10047@gtf.org>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 07:04:36PM +0100, Alan Cox wrote:
> In 2.7 the SCSI layer split can get finished so it seperates "scsi the
> protocol" from "queueing engine and handling for an intelligent
> controller".

Yep, this is exactly my plan.  And exactly why libata must use
the SCSI layer in 2.4 and 2.6, and in 2.7 use the "queueing engine ..."
stuff that you describe.

There are a lot of pieces in the SCSI layer that I want to move "up" to
the block layer in 2.7:  ->queuecommand "queue one" callback and loop
(Jens has code for this already), error handling thread helper code,
low-level device driver registration structure[1], personality code
(disk, cdrom, tape, ....), support for host controllers which may have
host _or_ device (or both!) TCQ limits, and on and on.

That's a ton of code, and IMO it's not feasible to (a) recreate it
for 2.6 libata, or (b) do the "move up" in 2.6.0-testX and change ide,
scsi, block, ... drivers to use the new helpers and new structure.
Changes are too big this late in the 2.6 game.

As of next week (I'm presenting this at Intel Developer Forum), libata
will support "AHCI", Intel's next generation SATA controller.  Each PCI
device supports up to 32 SATA ports (one SATA device each).  Each port
supports up to 32 outstanding ATA commands (i.e. 32 tags), including a
64-bit-DMA-capable scatter-gather table.  The S/G doesn't have the silly
64K segment boundary worries, either.

Promise hardware is similar -- up to 10 "packets" (taskfiles) can be
queued per host... not per device.  SCSI layer handles this with just a
few knob-turns.

For 2.6, libata (unfortunately) requires the SCSI layer for ATA
devices, and libata drives real hardware that noone else can drive.

For 2.7, when all this code "moves up" -- basically adding a bunch of
helper functions to the block layer -- libata won't need to treat ATA
devices as SCSI devices.

Some developers have rightfully pointed out that disks going from
/dev/hdX to /dev/sdX might create some user confusion.  This hasn't been
the case in practice.  Partly because LABEL= is fairly prevalent, and
partly because libata is used for "only SATA" scenarios, which is by
definition new hardware.


On to /dev/disk...
Another interesting part of this "moving up" is that I want to unify the
personality code.  The various tape, cdrom, and disk modules for ide,
scsi, and others are quite similar.  And if you look closer at today's
block layer, you see that already everything is designed around "struct
request".  So I envision a more top-down structure, with helper
functions and callbacks combining to form:  /dev/disk, /dev/cdrom,
/dev/tape, ...

The generic "disk" personality code would take care of allocating block
device major/minors (i.e. register_blkdev duties), and generating
requests.  Existing ->prep_rq helpers will fill in the specific details.
Subsystem-specfic ioctls can be delivered as REQ_SPECIAL.

cdrom, tape, and friends follow a similar pattern.

"What about /dev/hda!"  Answer:  a simple remapping block device, which
simulates /dev/hdXX or /dev/sdXX, by remapping all requests to
/dev/diskXX.

So the next time you hear me say "libata must wait for 2.7 to ditch SCSI"
this is what I mean ;-)  These aren't unachieveable goals, either.  It's
mostly code shuffling.  This code mostly already exists today.

	Jeff


[1] low-level driver registers a set of callbacks, which are
either implemented in the driver itself (cciss, cpqarray) or mostly
library-based helper functions (ATA or SCSI).

