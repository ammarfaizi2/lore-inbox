Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUFRUZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUFRUZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUFRUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:25:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:29863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262020AbUFRUXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:23:55 -0400
Date: Fri, 18 Jun 2004 13:26:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
 mapping
Message-Id: <20040618132628.45e1d364.akpm@osdl.org>
In-Reply-To: <1087574752.8002.194.camel@watt.suse.com>
References: <1087523668.8002.103.camel@watt.suse.com>
	<20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	<1087563810.8002.116.camel@watt.suse.com>
	<20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
	<1087570031.8002.153.camel@watt.suse.com>
	<20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
	<1087573303.8002.172.camel@watt.suse.com>
	<20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
	<1087574752.8002.194.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> Maybe the real bug is the FS inode should never have ended up in the
> dirty list.

It'd be interesting to find out where and why it is being dirtied (atime?),
but even if we can prevent that from happening, people can still do things
like chmod on it, so we're back in the same situation.

There's tight coupling between writing back the inode and writing back its
pages, and at times it has caused problems.  It's not clear _why_ there
should be such a coupling but it's never been a sufficient problem to
justify ripping it all up.

>  This should all work fine if the bdev inode were the only
> one to ever hit a dirty list.

Something like this?

--- 25/fs/fs-writeback.c~dont-writeback-fd-bdev-inodes	Fri Jun 18 12:54:08 2004
+++ 25-akpm/fs/fs-writeback.c	Fri Jun 18 13:25:16 2004
@@ -156,7 +156,8 @@ __sync_single_inode(struct inode *inode,
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	int wait = wbc->sync_mode == WB_SYNC_ALL;
-	int ret;
+	int is_fs_bdev;		/* Is a block-special node */
+	int ret = 0;
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -167,13 +168,23 @@ __sync_single_inode(struct inode *inode,
 
 	spin_unlock(&inode_lock);
 
-	ret = do_writepages(mapping, wbc);
+	/*
+	 * blockdev address_spaces are always written back via their internal
+	 * inodes, not via their /dev/hdXX inodes, so use is_fs_bdev to skip
+	 * them here.  We still need to write back the inode itself.
+	 * And we cannot touch ->i_mapping of /dev/hdXX inodes at all, because
+	 * umount can change their ->i_mapping.
+	 */
+	is_fs_bdev = S_ISBLK(inode->i_mode) && (sb != blockdev_superblock);
+
+	if (!is_fs_bdev)
+		ret = do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
 
-	if (wait) {
+	if (wait && !is_fs_bdev) {
 		int err = filemap_fdatawait(mapping);
 		if (ret == 0)
 			ret = err;
@@ -182,7 +193,7 @@ __sync_single_inode(struct inode *inode,
 	spin_lock(&inode_lock);
 	inode->i_state &= ~I_LOCK;
 	if (!(inode->i_state & I_FREEING)) {
-		if (!(inode->i_state & I_DIRTY) &&
+		if (!(inode->i_state & I_DIRTY) && !is_fs_bdev &&
 		    mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
 			/*
 			 * We didn't write back all the pages.  nfs_writepages()
_

