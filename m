Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285418AbRLNRHr>; Fri, 14 Dec 2001 12:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbRLNRHi>; Fri, 14 Dec 2001 12:07:38 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52901 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285418AbRLNRHc>; Fri, 14 Dec 2001 12:07:32 -0500
Date: Fri, 14 Dec 2001 10:07:42 -0700
Message-Id: <200112141707.fBEH7gL05367@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <Pine.GSO.4.21.0112140318290.22724-100000@weyl.math.psu.edu>
In-Reply-To: <200112131826.fBDIQ2J28188@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0112140318290.22724-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Thu, 13 Dec 2001, Richard Gooch wrote:
> 
> > > Sigh...  Please, take a look at sys_swapon() or get_sb_bdev() or
> > > devfs_open().  Any version starting with 2.3.46-pre<something> when
> > > devfs went into the tree.
> > 
> > Wait a minute. Before poking holes at other code paths, can you please
> > answer the question I'm asking? I repeat: for the devfs revalidate
> > code, do you see any remaining problems if I increment the module
> > usage count?
> 
> For revalidate - yes.

Really? So what problem remains for revalidate? Below is my current
implementation of this code. Note that this function has a refcount on
the devfs entry, so it can't be freed at this point, although it can
be unregistered (unhooked from it's parent's list). At the point I
unlock the parent directory, the module cannot be unloaded, and it
isn't already unloading. So the bdops calls should be safe now.

static int check_disc_changed (struct devfs_entry *de)
{
    int tmp;
    int retval = 0;
    kdev_t dev = MKDEV (de->u.fcb.u.device.major, de->u.fcb.u.device.minor);
    struct block_device_operations *bdops = de->u.fcb.ops;
    extern int warn_no_part;

    if (!S_ISBLK (de->mode) || !bdops) return 0;
    read_lock (&de->parent->u.dir.lock);  /*  Prevent module from unloading  */
    if ( (de->next == de) || !try_inc_mod_count (bdops->owner) )
    {   /*  Entry is already unhooked or module is unloading  */
	read_unlock (&de->parent->u.dir.lock);
	return 0;
    }
    read_unlock (&de->parent->u.dir.lock);  /*  Module can continue unloading*/
    if (bdops->check_media_change == NULL) goto out;
    if ( !bdops->check_media_change (dev) ) goto out;
    retval = 1;
    printk ( KERN_DEBUG "VFS: Disk change detected on device %s\n",
	     kdevname (dev) );
    if (invalidate_device(dev, 0))
	printk("VFS: busy inodes on changed media..\n");
    /*  Ugly hack to disable messages about unable to read partition table  */
    tmp = warn_no_part;
    warn_no_part = 0;
    if (bdops->revalidate) bdops->revalidate (dev);
    warn_no_part = tmp;
out:
    if (bdops->owner) __MOD_DEC_USE_COUNT (bdops->owner);
    return retval;
}   /*  End Function check_disc_changed  */


> > > All of them have ->bd_op set from devfs handle and follow that with
> > > blkdev_get() - directly or indirectly via def_blk_fops.open().  That
> > > function blocks.  Think what will happen if entry is removed while
> > > blkdev_get() sleeps on semaphore.
> > 
> > When you say "entry is removed", are you actually referring to a devfs
> > entry being removed? Or are you talking more generally about the
> > module being removed?
> 
> devfs_unregister() being called.
> 
> > For the case where devfs_open() is running, the devfs entry remains
> > valid over the lifetime of the open(). In fact, it remains valid over
> > the lifetime of the dentry.
> 
> That it does, but it doesn't keep its contents alive.  In particular,
> pointer to methods table is junk as soon as devfs_unregister() is done
> with it.
>  
> > > BTW, I'd described that to you several times - last one couple of
> > > months ago on l-k.
> > 
> > And since then the refcounting code has gone in, and many of your old
> > concerns have been addressed. I'm trying to engage you in a productive
> > dialogue to resolve any remaining issues.
> 
> This one is unaffected by refcounting of devfs objects - what happens is
> 
> 	* find devfs object
> 	* check that it's alive and pick data from it
> 	* store that data (outside of devfs).  At that point devfs object
> is not involved anymore.
> 	* block (outside of devfs)
> 	* use that data (outside of devfs)
> 	* die, since the module had told devfs to invalidate the contents of
> devfs object and freed the methods table that used to be pointed to by
> data stored in devfs object.
> 
> And any attempt to pick that data from devfs would fail (as it
> should).  The trouble being, we'd already picked it - before
> devfs_unregister() had been called.

Yes, so the solution I sent you last night should fix the sequence of
events you describe above. This is what I said:

I've been wading through the various code paths. It seems to me that
devfs_get_ops() should bump the module refcount, and the 4 places
which call devfs_get_ops() should be changed to make a call to
devfs_put_ops() once they have done their stuff (or at least
implicitely bumped the module refcount again). A new function
devfs_put_ops() should be added.

As an addendum to that, after I fired off that message I decided I
should clean up the way external code gets hold of a devfs handle
(basically push forward the worked tagged by that FIXME in
devfs_find_handle()). I'll create a new function devfs_get_handle()
which keeps the refcount to the entry, and export devfs_put().

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
