Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUCRMhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUCRMhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:37:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262597AbUCRMhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:37:13 -0500
Date: Thu, 18 Mar 2004 13:37:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040318123711.GQ22234@suse.de>
References: <1079572101.2748.711.camel@abyss.local> <20040318064757.GA1072@suse.de> <20040318113453.GB6864@merlin.emma.line.org> <20040318115544.GN22234@suse.de> <20040318122145.GA9175@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318122145.GA9175@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Matthias Andree wrote:
> > > All these ATA fsync() vs. write cache issues have been open for much too
> > > long - no reproaches, but it's a pity we haven't been able to have data
> > > consistency for data bases and fast bulk writes (that need the write
> > > cache without TCQ) in the same drive for so long. I have seen Linux
> > > introduce TCQ for PATA early in 2.5, then drop it again. Similarly,
> > > FreeBSD ventured into TCQ for ATA but appears to have dropped it again
> > > as well.
> > 
> > That's because PATA TCQ sucks :-)
> 
> True. Few drives support it, and many of these you would not want to run
> in production...

Plus, the spec is broken.

> > > May I ask that the information whether a particular driver (file system,
> > > hardware) supports write barriers be exposed in a standard way, for
> > > instance in the Kconfig help lines?
> > 
> > Since reiser is the first implementation of it, it gets to chose how
> > this works. Currently that's done by giving -o barrier=flush (=ordered
> > used to exist as well, it will probably return - right now we just
> > played with IDE).
> 
> This looks as though this was not the default and required the user to
> know what he's doing. Would it be possible to choose a sane default
> (like flush for ATA or ordered for SCSI when the underlying driver
> supports ordered tags) and leave the user just the chance to override
> this?

When things have matured, might not be a bad idea to default to using
barriers.

> > Only PATA core needs to support it, not the chipset drivers. md and dm
> 
> Hum, I know the older Promise chips were blacklisted for PATA TCQ in
> FreeBSD. Might "ordered" cause situations where similar things happen to
> Linux?  How about SCSI/libata? Is the situation the same there?

Don't confuse TCQ and barriers, it has nothing to do with each other for
IDE. I can't imagine any chipsets having problems with a syncronize
cache command.

> > aren't a difficult to implement now that unplug/congestion already
> > iterates the device list and I added a blkdev_issue_flush() command.
> 
> So this would - for SCSI - be an sd issue rather than a driver issue as
> well?

No, for scsi it's a low level driver issue. IDE chipset 'drivers' really
aren't anything but setup stuff, and maybe a few hooks to deal with dma.
All the action is in the ide core.

-- 
Jens Axboe

