Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbTIMV10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTIMV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:27:26 -0400
Received: from havoc.gtf.org ([63.247.75.124]:51093 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262205AbTIMV1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:27:23 -0400
Date: Sat, 13 Sep 2003 17:27:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913212723.GA21426@gtf.org>
References: <1063484193.1781.48.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063484193.1781.48.camel@mulgrave>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 03:16:09PM -0500, James Bottomley wrote:
> 
>     Oh, and I'm pondering the best way to deliver out-of-bang ATA taskfiles
>     and SCSI cdbs to a device.  (for the uninitiated, this is lower level
>     than block devices / cdrom devices / etc.)
>     
>      ... AF_BLOCK is not out of the question ;-)
>     
>     
> Well, I think the main issue to doing this is one of layering.  What
> SAM-3 did for SCSI was essentially give us a 3 layer stack which the
> kernel represents as the upper, the mid and the lower layers  (Note,
> these layers are subdividable too).
> 
> For SCSI commands, queuecommand() is a natural handoff point from the
> mid to lower layer representing a pure scsi command with no transport
> dependent details.
> 
> For ATA, a task file does contain transport dependent knowledge, thus it
> should enter the stack at a slightly lower level (and a level which the
> current SCSI model doesn't even represent).

This is a good point, and I admit I don't have a good response.

On one hand, the current kernel interface presented to userland is
the same for ATA and SCSI:  "an ioctl, which sends packet to device"
So from the standpoint of the userland ABI, that rebuts layering to
a certain extent.  We even have ioctls in today's ATA layer to send
SCSI CDBs to ATA devices!  ;-)

So from that angle, it all looks like a packet to me.
Or struct request, shall I say.  or skb.  after a while they are all the
same to me...


> Thus, the two ways of approaching this would seem to be either to derive
> somehow a way of removing the transport dependence from the taskfile (a
> sort of Task CDB for ATA), or redo the driver model stack to subdivide
> the current low level drivers correctly.  I think the latter will
> probably be more productive, particularly if the subdivision is made
> optional (and thus wouldn't affect most of the drivers currently in the
> tree).  Even in SCSI, there are certain register based SCSI Parallel
> cards that would benefit from being driven at the same level as a task
> file.

"the latter" is what I'm shooting for, with /dev/disk.  Or maybe
a better moniker is storage API.  I think that parallels a theme I am
pursuing in 2.7:

Make the low-level driver interface for ATA devices, RAID devices
like cciss, etc. look strikingly similar to the SCSI low-level driver
interface.  At that point we call it the "storage LLD interface".
This would IMO encompass the low-level driver subdivision you describe.

Ideally an ata/scsi/raid driver shouldn't be doing much more than
h/w queue processing, and some hooks for unusual events like power
management or h/w-specific device enumeration.

Overall I'd like to get "low level drivers" at pretty much the same
level.  ATA and SCSI drivers would be fairly small, with a lot of their
functionality handled by helper functions.  RAID drivers would be
largers.

Another thorny tangent to throw out there:

IMO, we need to move users from a [probe-]order-based device and bus
enumeration to some system based on unique ids.  I'm of the opinion
that _both_ block devices and filesystems need some sort of GUID.
Luckily, a lot of blkdevs/fs's are already there.

If you look at current usage out there, order isn't _terribly_ important
given today's tools (such as LABEL=).  More important IMO is figuring
out which spindle is your boot disk, and which is your root disk.
Red Hat handles root disks by doing LABEL= from initrd.  But discovering
the boot disk is still largely an unsolved problem AFAIK...

	Jeff



