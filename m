Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWEMAUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWEMAUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWEMAUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:20:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27039 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932227AbWEMAUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 20:20:38 -0400
Date: Sat, 13 May 2006 01:20:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060513002036.GX27946@ftp.linux.org.uk>
References: <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org> <20060512222816.GS27946@ftp.linux.org.uk> <20060512224804.GT27946@ftp.linux.org.uk> <20060512225101.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121559490.3866@g5.osdl.org> <20060512232131.GV27946@ftp.linux.org.uk> <20060512233711.GW27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121647250.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121647250.3866@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 04:50:32PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 13 May 2006, Al Viro wrote:
> > 
> > BTW, the best option is to kill bdev_uevent() again.  Short of that,
> > skip PHYSDEV mess if disk doesn't have GENHD_FL_UP.
> 
> I do think the mount/umount events are valid and interesting, so I'd much 
> rather see the second version.

mount/umount events are BS, but that's a separate story.  In case you've
missed the original discussion:
	* mount/umount is not tied to block device; if you really want
to track mount tree changes, you need much more; if you want to track
the set of filesystems being active, you _still_ need more.
	* "block device is used by fs" is valid, but bdev_uevent() is _NOT_
that; we miss e.g. journals.
	* "block device is being claimed exclusively" - even more interesting,
and again, bdev_uevent() isn't it.
	* "underlying object of _the_ block device used by a filesystem"
is not well-defined, to put it mildly.

IOW, it's a big mess.  Note that if you care about real mount events
("set of mounts has changed") you can do that already, and get _all_
of them - including mount --move, etc.  poll(2) on /proc/mounts
will do that for you.  And you don't need to be priveleged for that,
while we are at it.

That's what hald wanted bdev_uevent() for.  All attempts to find what
other users are really trying to get had not brought anything.

I'm not saying that we don't need something similar, but let's try to make
sure it makes _sense_ and isn't just "oh, my userland code rereads too
often; guess if I would see when kernel reaches this, this and that point
I would be able to reduce the frequency of rereads and wouldn't miss too
much in the cases I've ran into so far".

In the current form bdev_uevent() makes no sense.  It pushes a lot of
vaguely related stuff and doesn't cover _any_ sane use fully.

So yeah, I'm seriously pissed off at the bdev_uevent() merge - at hald
crowd for pushing it to gregkh, at gregkh for blindly passing it on
and at myself for missing it back then.  Note that as soon as hald folks
_did_ explain what they really wanted, they've got a sane solution (and
are using it now just fine).

> However, that does beg the question: wouldn't that effectively be what the 
> patch I posted would do? Notably the "disk->driverfs_dev = NULL" part 
> after we've dropped it (the "KOBJ_REMOVE" event move is a separate issue, 
> mixed here into the same patch, but should result in possibly better name 
> generation for the event).
> 
> Basically, onces driverfs_dev has been dropped, we NULL it out, and then 
> the people who use it automatically get the right result.

More or less.  We don't want to mess with refcounts at all; aside of that,
yes, checking if it's NULL is OK.  subsystem mutex should be enough, AFAICS.
