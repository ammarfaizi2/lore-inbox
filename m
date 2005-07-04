Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGDT3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGDT3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVGDT3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:29:24 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:52927 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261579AbVGDT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:28:29 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 4 Jul 2005 20:28:06 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Robert Love <rml@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] Fix inotify umount hangs.
Message-ID: <Pine.LNX.4.60.0507042009170.7572@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Robert,

The below patch against 2.6.13-rc1-mm1 fixes the umount hangs caused by 
inotify.

It excludes more inodes from being messed around with in 
inotify_unmount_inodes(): the ones with zero i_count as they cannot have 
any watches and the I_WILL_FREE ones which it is not allowed to do 
__iget() on.

Note that at this stage MS_ACTIVE is cleared on the superblock which means 
that iput() does not need shrink_icache_memory(), it evicts the inodes 
reaching zero i_count itself and immediately thus if inotify does __iget 
and then iput on such zero i_count inode it will evict it from icache and 
from the i_sb_list!  So the assumption that i_sb_list does not change 
whilts inotify_umount_inodes is running is bogus.  Even with this patch 
the list changes, e.g. when watches are removed i_count can hit zero and 
the iput at the bottom of the list_for_each_safe() loop _will_ modify 
i_sb_list by evicting the inode from icache there and then.

Further to this NTFS drops references to internal system inodes (also in 
icache) during its ->put_inode() method, e.g. this happens for directory 
inodes, their bitmap inode is iput when the directory has its final iput 
done on it which can be triggered by a removed inotify watch.  This can 
cause the "next_i" inode to also be evicted which leads to hangs and 
crashes since it no longer is on i_sb_list and is indeed freed memory 
which it is illegal to access.

This patch solves this by taking a reference on next_i for as long as it 
is needed, again with the same constraits as placed on taking a reference 
on the inode itself.

This may not be the prettiest but it works.  (-:

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

NB. A cleaner solution _might_ be (I am not sure, haven't tried to 
write it) to do-your-own for loop instead of list_for_each_safe() and 
protect the current inode with a reference and only drop the reference 
when the next inode has had a reference obtained on it but this pretty 
much amounts to what I do in this patch...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.6.13-rc1-mm1-vanilla/fs/inotify.c	2005-07-01 14:51:09.000000000 +0100
+++ linux-2.6.13-rc1-mm1/fs/inotify.c	2005-07-04 20:04:31.000000000 +0100
@@ -560,43 +560,65 @@ EXPORT_SYMBOL_GPL(inotify_get_cookie);
  */
 void inotify_unmount_inodes(struct list_head *list)
 {
-	struct inode *inode, *next_i;
+	struct inode *inode, *next_i, *need_iput = NULL;
 
 	list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
+		struct inode *need_iput_tmp;
 		struct inotify_watch *watch, *next_w;
 		struct list_head *watches;
 
 		/*
-		 * We cannot __iget() an inode in state I_CLEAR or I_FREEING,
-		 * which is fine becayse by that point the inode cannot have
-		 * any associated watches.
+		 * If i_count is zero, the inode cannot have any watches and
+		 * doing an __iget/iput with MS_ACTIVE clear would actually
+		 * evict all inodes with zero i_count from icache which is
+		 * unnecessarily violent and may in fact be illegal to do.
 		 */
-		if (inode->i_state & (I_CLEAR | I_FREEING))
+		if (!atomic_read(&inode->i_count))
 			continue;
-
-		/* In case the remove_watch() drops a reference */
-		__iget(inode);
-
 		/*
-		 * We can safely drop inode_lock here because the per-sb list
-		 * of inodes must not change during unmount and iprune_sem
-		 * keeps shrink_icache_memory() away.
+		 * We cannot __iget() an inode in state I_CLEAR, I_FREEING, or
+		 * I_WILL_FREE which is fine because by that point the inode
+		 * cannot have any associated watches.
+		 */
+		if (inode->i_state & (I_CLEAR | I_FREEING | I_WILL_FREE))
+			continue;
+		need_iput_tmp = need_iput;
+		need_iput = NULL;
+		/* In case the remove_watch() drops a reference. */
+		if (inode != need_iput_tmp)
+			__iget(inode);
+		else
+			need_iput_tmp = NULL;
+		/* In case the dropping of a reference would nuke next_i. */
+		if ((&next_i->i_sb_list != list) &&
+				atomic_read(&next_i->i_count) &&
+				!(next_i->i_state & (I_CLEAR | I_FREEING |
+				I_WILL_FREE))) {
+			__iget(next_i);
+			need_iput = next_i;
+		}
+		/*
+		 * We can safely drop inode_lock here because we hold
+		 * references on both inode and next_i.  Also no new inodes
+		 * will be added since the umount has begun.  Finally,
+		 * iprune_sem keeps shrink_icache_memory() away.
 		 */
 		spin_unlock(&inode_lock);
-
-		/* for each watch, send IN_UNMOUNT and then remove it */
+		if (need_iput_tmp)
+			iput(need_iput_tmp);
+		/* For each watch, send IN_UNMOUNT and then remove it. */
 		down(&inode->inotify_sem);
 		watches = &inode->inotify_watches;
 		list_for_each_entry_safe(watch, next_w, watches, i_list) {
 			struct inotify_device *dev = watch->dev;
 			down(&dev->sem);
-			inotify_dev_queue_event(dev, watch, IN_UNMOUNT,0,NULL);
+			inotify_dev_queue_event(dev, watch, IN_UNMOUNT, 0,
+					NULL);
 			remove_watch(watch, dev);
 			up(&dev->sem);
 		}
 		up(&inode->inotify_sem);
 		iput(inode);
-
 		spin_lock(&inode_lock);
 	}
 }
