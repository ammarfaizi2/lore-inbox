Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSFPKA1>; Sun, 16 Jun 2002 06:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSFPKA0>; Sun, 16 Jun 2002 06:00:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:40081 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316051AbSFPKAZ>;
	Sun, 16 Jun 2002 06:00:25 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 11:59:55 +0200 (MEST)
Message-Id: <UTC200206160959.g5G9xtM29126.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

    > > Wrong.  That breaks for anything with ->follow_link() that
    > > can't be expressed as a single lookup on some path.
    > 
    > I don't know what interesting out-of-tree filesystems you
    > have in mind, but it looks like this would work for all
    > systems in the current tree.

    Trivial counterexample: procfs.

That is trivially handled:

static inline int
do_follow_link(struct dentry *dentry, struct nameidata *nd) {
	const char *link = NULL;
	struct page *page = NULL;
	int err;

	...
	err = dentry->d_inode->i_op->prepare_follow_link(dentry, nd, &link, &page);
	if (nd->flags & FOLLOW_DONE)
		nd->flags &= ~FOLLOW_DONE;
	else if (err = 0)
		err = __vfs_follow_link(nd, link);
	if (page) {
		kunmap(page);
		page_cache_release(page);
	}
	...
	return err;
}

You must come with more serious objections before I believe your
claim that this doesn't work.

----------     
    > You are replacing kdev_t by struct block device *, that I
    > consider as a refcounted reference to the device. Fine.
    > But kdev_t is created by the driver, at the moment the
    > device is detected, while struct block device * is created
    > at open() time. Thus, the question arises where you plan to
...
    > store permanent device data like size or sectorsize.

    Sector size is kept in the queue.  Disk size - in per-disk objects
    that are yet to be introduced in the tree.

Yes - it is these per-disk objects that I was referring to.
Recently I was polishing some SCSI code, and the next step
would have been unification with some IDE code that did precisely
the same things in an entirely different way. But in order to
remove this driver code I needed what I still think of as kdev_t
structs. So you will be introducing them after all. Good.

----------
    Notice that your "permanent" data is not quite permanent - e.g.
    information about partitioning can be lost (in all kernels since
    2.0, if not earlier) at any moment when nobody has devices opened.
    rmmod -a and there you go...

    IMO correct approach to such data is that it's generated on demand
    (as it is right now - again, consider modular driver; then we don't
    see _anything_ about devices until somebody attempts to open one
    of them and triggers module loading)

Yes, when the disk is removed, or when the driver is removed
it does not matter that information is lost.
But it is very bad to generate a partition table on each open.
Indeed, it is wrong.

User space can tell the kernel what the partitions are.
Opening a disk device must not destroy that information.
So some permanent info of the gendisk type is needed.

Andries
