Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUFRB5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUFRB5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFRB5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:57:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:24965 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264933AbUFRB5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:57:07 -0400
Subject: [PATCH RFC] __bd_forget should wait for inodes using the mapping
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087523668.8002.103.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Jun 2004 21:54:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__bd_forget will change the mapping for filesystem inodes without 
waiting to make sure no users of the block device address space are 
using that mapping.

In the case of background writeout, it is possible for __bd_forget 
to free the block device inode while mpage_writepages is still 
looking through the mapping for dirty pages.  This is because
each device node in the filesystem has a pointer to the block
device address space, and __bd_forget is used to reset those pointers
before the block device inode is freed.  

There is no locking to make sure __bd_forget isn't running 
at the same time as __writeback_single_inode is run on the 
filesystem device node.

Here's an example patch that should fix things, Andi just found
a race where I wasn't holding onto the filesystem inode correctly,
so this rev got a last minute fix before I wander off for the night.

It's quite ugly, I'm hoping we can hash out something better.

Index: linux.t/fs/block_dev.c
===================================================================
--- linux.t.orig/fs/block_dev.c	2004-06-17 21:14:08.000000000 -0400
+++ linux.t/fs/block_dev.c	2004-06-17 21:46:46.203782616 -0400
@@ -24,6 +24,7 @@
 #include <linux/uio.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
+#include <linux/writeback.h>
 
 struct bdev_inode {
 	struct block_device bdev;
@@ -258,11 +259,31 @@ static void init_once(void * foo, kmem_c
 	}
 }
 
+/* 
+ * we have to make sure that we don't free the block
+ * device inode and mapping while one of the inodes using
+ * it is in background writeback. 
+ *
+ * The lock ordering required elsewhere is bdev_lock->inode_lock.
+ */
 static inline void __bd_forget(struct inode *inode)
 {
+	spin_lock(&inode_lock);
+	__iget(inode);
+	while (inode->i_state & I_LOCK) {
+		spin_unlock(&bdev_lock);
+		spin_unlock(&inode_lock);
+		__wait_on_inode(inode);
+		spin_lock(&bdev_lock);
+		spin_lock(&inode_lock);
+	}
 	list_del_init(&inode->i_devices);
 	inode->i_bdev = NULL;
 	inode->i_mapping = &inode->i_data;
+	spin_unlock(&inode_lock);
+	spin_unlock(&bdev_lock);
+	iput(inode);
+	spin_lock(&bdev_lock);
 }
 
 static void bdev_clear_inode(struct inode *inode)


