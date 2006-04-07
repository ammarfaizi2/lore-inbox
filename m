Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWDGOlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWDGOlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWDGOlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:41:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38673 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932354AbWDGOlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:41:05 -0400
Date: Fri, 7 Apr 2006 15:40:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Al Viro <viro@ftp.uk.linux.org>,
       Jens Axboe <axboe@suse.de>
Cc: Mikkel Erup <mikkelerup@yahoo.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: sdhci driver produces kernel oops on ejecting the card
Message-ID: <20060407144046.GA21049@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
	Mikkel Erup <mikkelerup@yahoo.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060403221936.58274.qmail@web52113.mail.yahoo.com> <4436273A.9000504@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4436273A.9000504@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 10:47:54AM +0200, Pierre Ossman wrote:
> Mikkel Erup wrote:
> > 
> > It happens with 2.6.16-git20 as well.
> > Attached are the log file and kernel .config
> > 
> 
> Since it ooopses during umount, I'm guessing that it's a problem
> somewhere in mmc_block. I'll try to get some time to look closer at it
> during the weekend. Perhaps Russell has some idea until then?

$ grep -n driverfs_dev block/genhd.c
558:    physdev = disk->driverfs_dev;
$

Hmm, okay, genhd contains a reference to a device object, but there's
no sign of _any_ refcounting in sight.

What's happening is that the MMC card block device is setup and registered
with genhd.  We set md->disk->driverfs_dev to point at the owning device
structure.

This generates a uevent, which causes disk->driverfs_dev to be dereferenced.
All fine here.  We mount the partition, which causes another uevent to be
generated, again dereferencing disk->driverfs_dev.

If we remove the MMC card, we destroy the MMC card block device.  This
seems to generate another uevent for the block device.  At this point,
the counted references to the MMC card block device fall to zero.

But wait!  There's still uncounted disk->driverfs_dev reference waiting
for...

You unmount the partition.  This calls block_uevent, which dereferences
disk->driverfs_dev.  You know what happens now.

The levels above genhd can't do the refcounting because they don't know
when stuff has finished with driverfs_dev.  So the only place for sane
refcounting seems to be genhd.c, as per the patch below.

Comments?

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git a/block/genhd.c b/block/genhd.c
--- a/block/genhd.c	Sat Feb 18 10:31:37 2006
+++ b/block/genhd.c	Fri Apr  7 15:22:21 2006
@@ -262,6 +262,7 @@ static int exact_lock(dev_t dev, void *d
  */
 void add_disk(struct gendisk *disk)
 {
+	get_device(disk->driverfs_dev);
 	disk->flags |= GENHD_FL_UP;
 	blk_register_region(MKDEV(disk->major, disk->first_minor),
 			    disk->minors, NULL, exact_match, exact_lock, disk);
@@ -507,6 +508,7 @@ static struct attribute * default_attrs[
 static void disk_release(struct kobject * kobj)
 {
 	struct gendisk *disk = to_disk(kobj);
+	put_device(disk->driverfs_dev);
 	kfree(disk->random);
 	kfree(disk->part);
 	free_disk_stats(disk);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
