Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWELVcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWELVcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWELVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:32:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbWELVcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:32:35 -0400
Date: Fri, 12 May 2006 14:32:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512211853.GB26708@suse.de>
Message-ID: <Pine.LNX.4.64.0605121430110.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
 <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512211853.GB26708@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Greg KH wrote:
> 
> No, I don't know, that's why I just asked :)
> 
> And this bug doesn't have anything to do with why my mmc/sd cards are
> suddenly not showing up at all anymore in my laptop, right?  I need to
> track that regression from 2.6.17-rc1 down...

Well, that's certainly an interesting regression to look into too..

Here's all I know as back-ground.. Russell's patch certainly _looked_ ok, 
which is why it then got acked and merged, but that was before we had 
multiple people reporting that it breaks things for them.

		Linus

--
On Thu, 4 May 2006, Russell King wrote:
>
> Linus,
> 
> This has been confirmed to fix an issue which Mikkel discovered, and
> I'm now seeing reports from other people about this.
> 
> I'm not getting any response on it from either Al or Jens and it
> appears to be otherwise ignored - help!  Would you take this patch
> direct from me?
> 
> ----- Forwarded message from Russell King <rmk+lkml@arm.linux.org.uk> -----
> 
> Date:	Fri, 7 Apr 2006 15:40:46 +0100
> From:	Russell King <rmk+lkml@arm.linux.org.uk>
> To:	Pierre Ossman <drzeus-list@drzeus.cx>,
> 	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>
> Cc:	Mikkel Erup <mikkelerup@yahoo.com>, Greg KH <greg@kroah.com>,
> 	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
> Subject: Re: sdhci driver produces kernel oops on ejecting the card
> 
> On Fri, Apr 07, 2006 at 10:47:54AM +0200, Pierre Ossman wrote:
> > Mikkel Erup wrote:
> > > 
> > > It happens with 2.6.16-git20 as well.
> > > Attached are the log file and kernel .config
> > > 
> > 
> > Since it ooopses during umount, I'm guessing that it's a problem
> > somewhere in mmc_block. I'll try to get some time to look closer at it
> > during the weekend. Perhaps Russell has some idea until then?
> 
> $ grep -n driverfs_dev block/genhd.c
> 558:    physdev = disk->driverfs_dev;
> $
> 
> Hmm, okay, genhd contains a reference to a device object, but there's
> no sign of _any_ refcounting in sight.
> 
> What's happening is that the MMC card block device is setup and registered
> with genhd.  We set md->disk->driverfs_dev to point at the owning device
> structure.
> 
> This generates a uevent, which causes disk->driverfs_dev to be dereferenced.
> All fine here.  We mount the partition, which causes another uevent to be
> generated, again dereferencing disk->driverfs_dev.
> 
> If we remove the MMC card, we destroy the MMC card block device.  This
> seems to generate another uevent for the block device.  At this point,
> the counted references to the MMC card block device fall to zero.
> 
> But wait!  There's still uncounted disk->driverfs_dev reference waiting
> for...
> 
> You unmount the partition.  This calls block_uevent, which dereferences
> disk->driverfs_dev.  You know what happens now.
> 
> The levels above genhd can't do the refcounting because they don't know
> when stuff has finished with driverfs_dev.  So the only place for sane
> refcounting seems to be genhd.c, as per the patch below.
> 
> Comments?
> 
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git a/block/genhd.c b/block/genhd.c
> --- a/block/genhd.c	Sat Feb 18 10:31:37 2006
> +++ b/block/genhd.c	Fri Apr  7 15:22:21 2006
> @@ -262,6 +262,7 @@ static int exact_lock(dev_t dev, void *d
>   */
>  void add_disk(struct gendisk *disk)
>  {
> +	get_device(disk->driverfs_dev);
>  	disk->flags |= GENHD_FL_UP;
>  	blk_register_region(MKDEV(disk->major, disk->first_minor),
>  			    disk->minors, NULL, exact_match, exact_lock, disk);
> @@ -507,6 +508,7 @@ static struct attribute * default_attrs[
>  static void disk_release(struct kobject * kobj)
>  {
>  	struct gendisk *disk = to_disk(kobj);
> +	put_device(disk->driverfs_dev);
>  	kfree(disk->random);
>  	kfree(disk->part);
>  	free_disk_stats(disk);
> 
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> ----- End forwarded message -----
> 
> -- 
> Russell King
> 

