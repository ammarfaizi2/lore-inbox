Return-Path: <linux-kernel-owner+w=401wt.eu-S1751154AbXAUEDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXAUEDi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 23:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAUEDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 23:03:38 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:37495 "EHLO
	mail20.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbXAUEDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 23:03:38 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 23:03:37 EST
Date: Sun, 21 Jan 2007 14:50:58 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Ricardo Correia <rcorreia@wizy.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to flush the disk write cache from userspace
Message-ID: <20070121035058.GB4658@kernel.dk>
References: <fa.y+HJNAxqDqX5AHUxcmThAo20Ivo@ifi.uio.no> <fa.xbdrjhFpvWMJeTroG2DpPE4wd+M@ifi.uio.no> <fa.lqQRZqIqMX2chyIAM888fc1jCuY@ifi.uio.no> <45B0123C.3080506@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B0123C.3080506@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18 2007, Robert Hancock wrote:
> Ricardo Correia wrote:
> >On Tuesday 16 January 2007 00:38, you wrote:
> >>As always with these things, the devil is in the details. It requires
> >>the device to support a ->prepare_flush() queue hook, and not all
> >>devices do that. It will work for IDE/SATA/SCSI, though. In some devices
> >>you don't want/need to do a real disk flush, it depends on the write
> >>cache settings, battery backing, etc.
> >
> >Is there any chance that someone could implement this (I don't have the 
> >skills, unfortunately)? Maybe add a new ioctl() to block devices, so that 
> >it doesn't break any existing code?
> 
> I think we really should have support for doing cache flushes 
> automatically on fsync, etc. User space code should not have to worry 
> about this problem, it's pretty silly that for example MySQL has to 
> advise people to use hdparm -W 0 to disable the write cache on their IDE 
> drives in order to get proper data integrity guarantees - and disabling 
> the cache on IDE without command queueing really slaughters the 
> performance, unnecessarily in this case.

Completely agree. If you have barriers enabled in your filesystem, then
it should Just Work when you do fsync(). At least that is the case for
reiserfs and XFS, I'm not completely sure that ext3 also handles it
correctly.

For direct block device access, fsync() does need to provide a commit to
stable storage as well though.

> There may be some cases where the controller provides a battery-backed 
> cache and thus we don't want to actually force the controller to flush 
> everything out to the drive on fsync, so we may need to be able to 
> disable this, but these controllers may ignore flushes anyway. I know 
> IBM ServeRAID appears to fail requests for write cache info and so the 
> kernel assumes drive cache: write through and doesn't do any flushes.

That would be the preferable approach, just have the hardware that
doesn't need a flush ignore the FLUSH_CACHE. That would also need to
ignore the FUA bit on writes then. I'm not sure what the spec has to say
on this, basically the requirement is just that data is on stable
storage (eg survives power failure and so on), then that would be fine.
And I would hope it is, it'd be hard to specify anything else.

> >I believe it's a very useful (and relatively simple) feature that 
> >increases data integrity and reliability for applications that need this 
> >functionality.
> >
> >I think it must be considered that most people have disk write caches 
> >enabled and are using IDE, SATA or SCSI disks.
> >
> >I also think there's no point in disabling disks' write caches, since it 
> >slows writes and decreases disks' lifetime, and because there's a better 
> >solution.
> 
> Yes, ideally doing all writes to the drive with write cache enabled and 
> then flushing them out afterwards would be much more efficient (at least 
>  when no command queueing is involved) since the drive can choose what 
> order to complete the writes in.

That only works if you just care about the stream of writes going to
stable storage and don't care about ordering. But the above is
essentially how the barriers work on write back cache + non queued
devices. When the barrier write is received, we commit the previous
writes first with a flush and then write the barrier (followed by
another flush, or possibly not if we have FUA).

-- 
Jens Axboe

