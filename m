Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVATN3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVATN3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVATN3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:29:31 -0500
Received: from mail.suse.de ([195.135.220.2]:17628 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261916AbVATN3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:29:23 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [patch 5/5] Disallow in-inode attributes for reserved inodes
Date: Thu, 20 Jan 2005 14:29:15 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
References: <20050120020124.110155000@suse.de> <20050120032510.917200000@suse.de> <20050120121606.GF22715@schnapps.adilger.int>
In-Reply-To: <20050120121606.GF22715@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501201429.15681.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 January 2005 13:16, Andreas Dilger wrote:
> On Jan 20, 2005  03:01 +0100, Andreas Gruenbacher wrote:
> > When creating a filesystem with inodes bigger than 128 bytes, mke2fs
> > fails to clear out bytes beyond EXT3_GOOD_OLD_INODE_SIZE in all inodes
> > it creates (the journal, the filesystem root, and lost+found). We would
> > require a zeroed-out i_extra_isize field but we don't get it, so
> > disallow in-inode attributes for those inodes.
> >
> > Add an i_extra_isize sanity check.
>
> I'm not sure I agree with this patch.  It definitely resolves a problem
> I had with the previous patch (4/5), namely that for inodes that were
> created in a large-inode filesystem using a kernel w/o the large-inode
> patch we didn't save EAs into the large-inode space at all.  With this
> patch we will start using that space.

The ea-in-inode patch totally relies on getting all the available inode space 
cleared out by the kernel (or mke2fs, or e2fsck). If this is not the case for 
any inode we find, then i_extra_isize may contain a random number, and we've 
just lost, period: There is no way of sanitizing a random i_extra_isize; we 
cannot know what the right number would be.

We have two options for going forward from here: (a) depend on the fact that 
all inodes have been cleared out for us, or (b) don't rely on that, fix 
e2fsck before going any further, and have the fixed mke2fs and e2fsck set a 
filesystem feature flag that tells us that all the extra space in all inodes 
is "sane".

For (a) we can make an (ugly) exception because we know which inodes mke2fs 
created. As far as I can tell we can also fully rely on the kernel having 
cleared out the extra space for us. e2fsck may currently fail to move the 
extra space around when moving inodes, but that did not matter without 
ea-in-inode, and if we fix it now, that's probably good enough. We don't 
really care which inode's zeroed extra space we look at without ea-in-inode.

> It is debatable whether we should mark inodes bad if the i_extra_isize
> field is bad, or if we should just initialize i_extra_isize in that case.

IMHO it's not debatable. Taking an i_extra_isize that looks odd and simply 
changing it to something we think is better is a really bad idea. We might as 
well find an unusual but still valid i_extra_isize and use it, then a future 
patch allocates a few more fields in the inode, and suddenly we start to see 
garbage.

> On one hand there is very little else we can use to validate the on-disk
> inodes, but on the other hand the EA data isn't critical to reading the
> inode so this would seem to introduce additional failure cases.

You may have an access acl on the inode. Not being able to read an access acl 
is a clear sign of trouble. The same applies for everything else in the 
system.* and security.* namespaces, at least.

> I'm not sure whether an old e2fsck will also clear out the space in a
> large inode that it writes or not (I know that the patched one we use
> validates i_extra_isize).  If it doesn't it may be that there would be a
> largish number of inodes that are marked bad because of this, so having
> the kernel fix this would be good.

Repairing the filesystem has no place in the kernel code. If what you assume 
is the case (and I sure would have assumed you to check before proposing the 
kernel patch for inclusion), we have to go for the filesystem feature flag 
approach.

> If the old e2fsck zeroes the large 
> inodes properly it would be prudent to have an ext3_error() here so that
> the disk corruption triggers an e2fsck the next time the system starts.

That's even better, yes.

> For the root and lost+found inodes it looks like we can never store an
> EA in the extra part of the inode regardless of whether i_extra_isize is
> good or not.  If a bad value is found we could just initialize it and
> start using that space (though not print an ext3_error() in that case,
> an ext3_warning() if anything since this is probably the fault of mke2fs).

I disagree. We cannot just use the space when we think the inode is corrupted.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
