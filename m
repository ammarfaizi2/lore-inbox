Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTIMTVz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTIMTVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:21:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45043 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262167AbTIMTVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:21:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Date: Sat, 13 Sep 2003 21:24:05 +0200
User-Agent: KMail/1.5
Cc: axboe@suse.de, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org>
In-Reply-To: <20030913184934.GB10047@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309132124.05974.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 of September 2003 20:49, Jeff Garzik wrote:
> On Sat, Sep 13, 2003 at 07:04:36PM +0100, Alan Cox wrote:
> > In 2.7 the SCSI layer split can get finished so it seperates "scsi the
> > protocol" from "queueing engine and handling for an intelligent
> > controller".
>
> Yep, this is exactly my plan.  And exactly why libata must use
> the SCSI layer in 2.4 and 2.6, and in 2.7 use the "queueing engine ..."
> stuff that you describe.
>
> There are a lot of pieces in the SCSI layer that I want to move "up" to
> the block layer in 2.7:  ->queuecommand "queue one" callback and loop
> (Jens has code for this already), error handling thread helper code,
> low-level device driver registration structure[1], personality code
> (disk, cdrom, tape, ....), support for host controllers which may have
> host _or_ device (or both!) TCQ limits, and on and on.
>
> That's a ton of code, and IMO it's not feasible to (a) recreate it
> for 2.6 libata, or (b) do the "move up" in 2.6.0-testX and change ide,
> scsi, block, ... drivers to use the new helpers and new structure.
> Changes are too big this late in the 2.6 game.
>
> As of next week (I'm presenting this at Intel Developer Forum), libata
> will support "AHCI", Intel's next generation SATA controller.  Each PCI
> device supports up to 32 SATA ports (one SATA device each).  Each port
> supports up to 32 outstanding ATA commands (i.e. 32 tags), including a
> 64-bit-DMA-capable scatter-gather table.  The S/G doesn't have the silly
> 64K segment boundary worries, either.
>
> Promise hardware is similar -- up to 10 "packets" (taskfiles) can be
> queued per host... not per device.  SCSI layer handles this with just a
> few knob-turns.
>
> For 2.6, libata (unfortunately) requires the SCSI layer for ATA
> devices, and libata drives real hardware that noone else can drive.
>
> For 2.7, when all this code "moves up" -- basically adding a bunch of
> helper functions to the block layer -- libata won't need to treat ATA
> devices as SCSI devices.

s/ATA/SATA/

ATA and SATA will still need their own driver(s) aware of driver-model,
sysfs, ATA quirks/tuning etc.  I am working on this part currently, so you can
concentrate on new, sexy SATA, leaving all dirty, legacy ATA for me.

For all other stuff described in your mail I can only say: HELL YEAH!.

> Some developers have rightfully pointed out that disks going from
> /dev/hdX to /dev/sdX might create some user confusion.  This hasn't been
> the case in practice.  Partly because LABEL= is fairly prevalent, and
> partly because libata is used for "only SATA" scenarios, which is by
> definition new hardware.
>
>
> On to /dev/disk...
> Another interesting part of this "moving up" is that I want to unify the
> personality code.  The various tape, cdrom, and disk modules for ide,
> scsi, and others are quite similar.  And if you look closer at today's
> block layer, you see that already everything is designed around "struct
> request".  So I envision a more top-down structure, with helper
> functions and callbacks combining to form:  /dev/disk, /dev/cdrom,
> /dev/tape, ...
>
> The generic "disk" personality code would take care of allocating block
> device major/minors (i.e. register_blkdev duties), and generating
> requests.  Existing ->prep_rq helpers will fill in the specific details.
> Subsystem-specfic ioctls can be delivered as REQ_SPECIAL.
>
> cdrom, tape, and friends follow a similar pattern.
>
> "What about /dev/hda!"  Answer:  a simple remapping block device, which
> simulates /dev/hdXX or /dev/sdXX, by remapping all requests to
> /dev/diskXX.
>
> So the next time you hear me say "libata must wait for 2.7 to ditch SCSI"
> this is what I mean ;-)  These aren't unachieveable goals, either.  It's
> mostly code shuffling.  This code mostly already exists today.
>
> 	Jeff
>
>
> [1] low-level driver registers a set of callbacks, which are
> either implemented in the driver itself (cciss, cpqarray) or mostly
> library-based helper functions (ATA or SCSI).

