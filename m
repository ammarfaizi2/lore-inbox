Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJ0RMu>; Sat, 27 Oct 2001 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJ0RMk>; Sat, 27 Oct 2001 13:12:40 -0400
Received: from calais.pt.lu ([194.154.192.52]:41161 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S273065AbRJ0RMf>;
	Sat, 27 Oct 2001 13:12:35 -0400
Message-Id: <200110271712.f9RHCgf02886@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sat, 27 Oct 2001 11:15:45 EDT."
             <Pine.GSO.4.21.0110271103560.21545-100000@weyl.math.psu.edu> 
Date: Sat, 27 Oct 2001 19:12:41 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Sat, 27 Oct 2001, Alain Knaff wrote:
>
>> Appended to this mail is a patch meant to fix the "non-cached floppy"
>> problem.
>
>a) you _still_ need to stop all pending IO (readaheads in progress)
>before final ->release()

Ok. Didn't know about that. Maybe we should add a variant of
invalidate_bdev which stops IO in progress, but which wouldn't throw
away data that has already been read? This same variant could also
make sure that no dirty buffers were around, as a sanity check.

>b) at which point do you flush the cache?  It definitely shouldn't
>survive rmmod.

In the case of the floppy driver, the following would happen: after
rmmod, followed by insmod, the floppy driver would assume the disk has
been changed an throw away the cache (by returning 1 from
check_media_change). This is actually a side-effect of the way how the
physical DCL status is cleared: after an insmod, the floppy driver has
no way of knowing whether DCL was set at some point in the past, but
then cleared by another driver (i.e. ftape), so it errs on the safe
side, and assumes the disk has been changed.

Other block device drivers may behave differently of course...

>  And no, unregister_blkdev() is not a solution, courtesy
>of devfs with its insane devfs=only option.


Do you mean this:

int devfs_unregister_blkdev (unsigned int major, const char *name)
{
    if (boot_options & OPTION_ONLY) return 0;
    return unregister_blkdev (major, name);
}   /*  End Function devfs_unregister_blkdev  */

It seems to me that the root of the problem here is that the normal
major->device mapping is no longer the only way to "find" a device.

Cursory examination of floppy.c (as an example of a block device
driver) showed that bdops are also registered using devfs_register and
register_disk (what's THAT for?!? Floppies don't have partitions...)

Apparently, devfs_register allows a direct mapping from the device's
name to its driver, without going through its major/minor number.

Thus, a possible solution would be to equip all possible paths leading
to the driver's block_device_operations with correct "teardown"
function. Thus, not only unregister_blkdev would dump the cache, but
also devfs_unregister (maybe near the place in unregister() where
de->u.fcb.ops = NULL is done?). Best make this call generic, such as
free_bd_ops(handle), so that other unregister actions could easily be
tucked on top of it later on, should the need arise.

All this begs of course the following question: what kind of
idnetifier does the buffer cache code actually use to refer to the
block device, if there is no longer a major?

Is a pointer to some kind of structure used as the identifier? If so,
what structure is this? The device driver's block_device_operations
structure? No, won't work, because there may be minors. Or is it
something which is allocated on the fly when the device is opened? If
it is indeed the latter, I think I understand why the cache is gone
after re-opening the device: maybe it just gets a different handle
(mapping)? The cache may still be there, but the VFS would no longer
"find" it because the identifier of the device has changed. Should we
maybe use a _combination_ of pointer to block_device_operations and
minor number as the identifier for the device? That should stay valid
all the time while the module is loaded.

>There is a related problem which is much nastier than short-living caches:
>code that does bdev->bd_op = <stuff from devfs>;  blkdev_get(bdev, ...);
>Think what happens if rmmod comes while blkdev_get() sleeps ob ->bd_sem.
>Notice that it had been there since the moment when devfs went into the
>tree.  Sigh...

I'm not sure I understand the full extent of the problem, but at a
quick glance, it seems to be that the only operation exposed would be
blkdev_open, as all other operations do need an open handle, which
would prevent rmmod because module usage count would not be zero (at
least, if the module is correctly implemented...).

We would thus need to protect bd_op between the time it has been
fetched via get_blkfops, and bd_op->open. After bd_op->open, we would
be safe because of module usage count.

We could either use bdev->bd_sem (awkward, as many drivers implement
multiple bdev's), or a new per-major device lock to protect that
section.

unregister_blkdev would need to acquire the same lock while zero-ing
blkdevs[major].bdops.

Right now, block_dev.c's do_open already holds the kernel lock, so
wouldn't it be enough to also lock_kernel() in unregister_blkdev ?

A symetric situation might occur if a bd_op was called after
bd_op->release. But as far as I could see, this is not the case. Even
my own patch added the call to bd_op->can_trust_media_change _before_
the bd_op->release.

Ok, so the above only describes the solution where a device is
accessed via its major. To transpose this to devfs' direct
name-to-device mappings, a similar lock would need to be held between
the time the bd_op pointer is established, and the time it is
opened. But this may not practical, because too many software
components would be involved in that critical section. So maybe
do_open could "revalidate" the bd_op pointer (i.e. somehow check
whether the block device driver has not yet been unregistered in the
meantime) just before using it, and have the critical section only
enclose the revalidate and bd_op->open operation.

Something like the following (do_open):

	down(&bdev->bd_sem);
	lock_kernel();
+       if(bdev->bd_op && !devfs_is_bdop_still_valid(inode,bdev)) {
+               unlock_kernel();
+               up(&bdev->bd_sem);
+               return -ENODEV;
+       }
	if (!bdev->bd_op)
		bdev->bd_op = get_blkfops(MAJOR(dev));
	if (bdev->bd_op) {
		ret = 0;
		if (bdev->bd_op->open)
			ret = bdev->bd_op->open(inode, file);
		if (!ret) {
			bdev->bd_openers++;
			bdev->bd_inode->i_size = blkdev_size(dev);
			bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
		} else if (!bdev->bd_openers)
			bdev->bd_op = NULL;
	}
	unlock_kernel();
	up(&bdev->bd_sem);


Regards,

Alain
