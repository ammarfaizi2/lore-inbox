Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUCRL4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUCRL4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:56:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6032 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262528AbUCRLzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:55:47 -0500
Date: Thu, 18 Mar 2004 12:55:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: matthias.andree@gmx.de
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040318115544.GN22234@suse.de>
References: <1079572101.2748.711.camel@abyss.local> <20040318064757.GA1072@suse.de> <20040318113453.GB6864@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318113453.GB6864@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(btw - maybe you don't like to be cc'ed on kernel posts, but I do. it's
lkml etiquette to do so, and it makes sure that I see your mail.
otherwise I might not, especially true for bigger threads. so please, cc
people. thanks)

On Thu, Mar 18 2004, Matthias Andree wrote:
> On Thu, 18 Mar 2004, Jens Axboe wrote:
> 
> > Chris and I have working real fsync() with the barrier patches. I'll
> > clean it up and post a patch for vanilla 2.6.5-rc today.
> 
> This is good news.
> 
> The barrier stuff is long overdue^UI'm looking forward to this.
> 
> I'm using the term "TCQ" liberally although it may be inexact for older
> (parallel) ATA generations:
> 
> All these ATA fsync() vs. write cache issues have been open for much too
> long - no reproaches, but it's a pity we haven't been able to have data
> consistency for data bases and fast bulk writes (that need the write
> cache without TCQ) in the same drive for so long. I have seen Linux
> introduce TCQ for PATA early in 2.5, then drop it again. Similarly,
> FreeBSD ventured into TCQ for ATA but appears to have dropped it again
> as well.

That's because PATA TCQ sucks :-)

> May I ask that the information whether a particular driver (file system,
> hardware) supports write barriers be exposed in a standard way, for
> instance in the Kconfig help lines?

Since reiser is the first implementation of it, it gets to chose how
this works. Currently that's done by giving -o barrier=flush (=ordered
used to exist as well, it will probably return - right now we just
played with IDE).

> If I recall correctly from earlier patches, the barrier stuff is 1.
> command model (ATA vs.  SCSI) specific and 2. driver and hardware
> specific and 3. requires that the file system knows how to use this
> properly.

Yes.

> Given that file systems have certain write ordering requirements if they
> are to be recoverable after a crash, I suspect Linux has _not_ been able
> to guarantee on-disk consistency for any time for years, which means
> that a crash in the wrong moment can kill the file system itself if the
> drive has reordered writes - only ext3 without write cache seems to
> behave better in this respect (data=ordered).
> 
> I would like to have a document that shows which file system, which
> chipset driver for PATA, which chipset driver for ATA, which low-level
> SCSI host adaptor driver, which file system support write barrier. We
> will probably also need to check if intermediate layers such as md and
> dm-mod propagate such information.

Only PATA core needs to support it, not the chipset drivers. md and dm
aren't a difficult to implement now that unplug/congestion already
iterates the device list and I added a blkdev_issue_flush() command.

> Given the necessary information, I can hack together a HTML document to
> provide this information; this offer has however not seen any response
> in the past. I am however not acquainted with the drivers and need
> information from the kernel hackers. Without such support, such a
> documentation effort is doomed.

Usual approach - just start writing, it's a lot easier to get
corrections (people seem to be several times more willing to point out
your errors than give you recomendations for something you haven't
started yet).

> BTW, I should very much like to be able to trace the low-level write
> information that goes out to the device, possibly including the payload
> - something like tcpdump for the ATA or SCSI commands that are sent to
> the driver. Is such a facility available?

No.

-- 
Jens Axboe

