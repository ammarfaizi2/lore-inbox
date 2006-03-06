Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWCFS6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWCFS6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWCFS6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:58:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64575 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751354AbWCFS6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:58:17 -0500
Date: Mon, 6 Mar 2006 19:57:07 +0100
From: Jens Axboe <axboe@suse.de>
To: andersen@codepoet.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] bsg, block layer sg
Message-ID: <20060306185707.GO4595@suse.de>
References: <20060302111945.GG4329@suse.de> <20060306183046.GA15179@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306183046.GA15179@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2006, Erik Andersen wrote:
> On Thu Mar 02, 2006 at 12:19:46PM +0100, Jens Axboe wrote:
> > Hi,
> > 
> > After all that SG_IO and cdrecord talk, I decided to brush off the bsg
> > driver I wrote some time ago. Basically this is a full (aims to be at
> > least, probably still some minor bits missing) SG v3 interface. It
> > supports both SG_IO (which we just pass through for now), as well as
> > read/write and readv/writev of sg_io_hdr structures.
> 
> After this is merged I suppose I could then, i.e.  run an SG_IO
> ioctl doing i.e.  INQUIRY_CMD with some random block device, such
> as an /dev/nbd0, or /dev/loop0, or some such.  Which in general
> does not seem to make any sense at all unless the block device
> has some physical device level support for SCSI/ATAPI/MMC.  So
> while it addresses the needs of cdrecord and friends for CD
> burning, does it make sense to implement this as a general
> capability for all block devices?  I'm not objecting or arguing,
> I'm simply puzzled why a generic SG_IO layer for _all_ block
> devices (whether SCSI/ATAPI/MMC capable or not) is useful?

No of course that doesn't make sense. The generic part of this applies
to the transport method, it's only meant to be used for transporting ATA
(through the SCSI opcode pass through method standardized) and SCSI
commands. As such it applies to ATA drives, ATAPI, and SCSI. Or any
other type of device that uses the same command protocol, like usb or
firewire storage. And so on.

You could have the driver flag this in the queue settings, so you would
only register a bsg node for suitable devices. It could also be used as
a transport for other commands - say cciss wanted to use this instead of
some ioctl pass through that most drivers of that type define, they
could just fill whatever they need into the cmdp part as long as it fits
in the 16-byte cdb. Then it would be truly generic.

-- 
Jens Axboe

