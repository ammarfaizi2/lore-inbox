Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263692AbUEMAU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUEMAU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUEMAU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:20:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:38882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263692AbUEMAUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:20:54 -0400
Date: Wed, 12 May 2004 17:20:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: marcus hall <marcus@tuells.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block device swamping disk cache
Message-Id: <20040512172022.78d35f19.akpm@osdl.org>
In-Reply-To: <20040512133329.GA20030@bastille.tuells.org>
References: <20040511191124.GA16014@bastille.tuells.org>
	<20040511201936.A19384@infradead.org>
	<20040511172643.36df7c94.akpm@osdl.org>
	<20040512133329.GA20030@bastille.tuells.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marcus hall <marcus@tuells.org> wrote:
>
> On Tue, May 11, 2004 at 05:26:43PM -0700, Andrew Morton wrote:
>  > no, sorry, it'll still happen.  I haven't fixed the ramdisk driver yet.
>  > 
>  > The problem is that ->memory_backed means both "doesn't contribute
>  > to dirty memory" and also "doesn't need writeback".
>  > 
>  > These concepts need to be split apart for the ramdisk driver.  I'll do it
>  > for 2.6.7, promise.
> 
>  Well, I believe that the inodes that are marked as memory_backed are
>  for the ramdisk, and that isn't really a problem.  The block device
>  that I am writing to is a compact flash, so it's going through the ide-disk
>  device.  I do not see this inode show up on any superblock's dirty queue
>  (since it doesn't appear that mark_inode_dirty() is being called for
>  it).  So the question I am asking is, what strategy is *supposed* to be
>  in place to flush the blocks out?  (Or is this a hole that isn't plugged?)

Not sure why you're stuck running Krufty Old Kernels, but this patch from
June 2003 should fix it.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2003/06/13 17:43:10-07:00 akpm@digeo.com 
#   [PATCH] fix writeback for dirty ramdisk blockdev inodes
#   
#   Once the blockdev inode for /dev/ram0 is dirtied we have a memory-backed
#   inode on the blockdev superblock's s_dirty list.
#   
#   sync_sb_inodes() sees the memory-backed inode on the superblock and assumes
#   that all the other inodes on the superblock are also memory-backed.  This is
#   not true for the blockdev superblock!  We forget to write out dirty pages
#   against the following blockdevs.
#   
#   Fix this by just leaving the inode dirty and moving on to inspect the other
#   blockdev inodes on sb->s_io.
#   
#   (This is a little inefficient: an alternative is to leave dirtied
#   memory-backed inodes on inode_in_use, so nobody ever even considers them for
#   writeout.  But that introduces an inconsistency and is a bit kludgey).
# 
# fs/fs-writeback.c
#   2003/06/13 08:39:48-07:00 akpm@digeo.com +14 -1
#   fix writeback for dirty ramdisk blockdev inodes
# 
diff -Nru a/fs/fs-writeback.c b/fs/fs-writeback.c
--- a/fs/fs-writeback.c	Wed May 12 17:18:54 2004
+++ b/fs/fs-writeback.c	Wed May 12 17:18:54 2004
@@ -260,8 +260,21 @@
 		struct address_space *mapping = inode->i_mapping;
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 
-		if (bdi->memory_backed)
+		if (bdi->memory_backed) {
+			if (sb == blockdev_superblock) {
+				/*
+				 * Dirty memory-backed blockdev: the ramdisk
+				 * driver does this.
+				 */
+				list_move(&inode->i_list, &sb->s_dirty);
+				continue;
+			}
+			/*
+			 * Assume that all inodes on this superblock are memory
+			 * backed.  Skip the superblock.
+			 */
 			break;
+		}
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion = 1;

