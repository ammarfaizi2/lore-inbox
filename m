Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUFROUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUFROUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUFROUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:20:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:12735 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265168AbUFROUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:20:01 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1087568445.8002.138.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 10:20:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 22:10, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, Jun 17, 2004 at 09:54:28PM -0400, Chris Mason wrote:
> > __bd_forget will change the mapping for filesystem inodes without 
> > waiting to make sure no users of the block device address space are 
> > using that mapping.

Well, here's a new patch, I'm confident you'll like it even less. My
fixes so far will trigger iput on inode B during the clear_inode call of
inode A.  Even if this is legal today, it seems doomed to cause bugs
later on.

Another option is to inc the reference count of the block device inode
during background write out.  But, since we're racing with the block
device clear_inode call here, that will need to involve the bdev
spinlock somewhere along the way, and has lock ordering issues since the
block device code already takes inode_lock under bdev_lock.

-chris
---

__bd_forget will change the mapping for an inode without waiting to make
sure no users of the inode are using that mapping.  In the case of
background writeout, it is possible for __bd_forget to free the
block device inode while mpage_writepages is still looking through the
mapping for dirty pages.

Index: linux.t/fs/block_dev.c
===================================================================
--- linux.t.orig/fs/block_dev.c	2004-06-17 21:14:08.000000000 -0400
+++ linux.t/fs/block_dev.c	2004-06-18 09:21:41.000000000 -0400
@@ -24,6 +24,7 @@
 #include <linux/uio.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
+#include <linux/writeback.h>
 
 struct bdev_inode {
 	struct block_device bdev;
@@ -258,11 +259,48 @@ static void init_once(void * foo, kmem_c
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
+	int iget_done = 0;
+	spin_lock(&inode_lock);
+
+	/* when the inode is being freed, we could be racing
+	 * with its clear_inode call.  The only thing saving us
+	 * is the bdev_lock, inode->i_bdev is still not null
+	 * and the clear_inode call will need to get the bdev lock
+	 * before it can zero it.
+	 *
+	 * don't __iget, wait on the inode, or iput in this case,
+	 */
+	if (inode->i_state & I_FREEING)
+		goto clear_it;			
+
+	__iget(inode);
+	iget_done = 1;
+	while (inode->i_state & I_LOCK) {
+		spin_unlock(&bdev_lock);
+		spin_unlock(&inode_lock);
+		__wait_on_inode(inode);
+		spin_lock(&bdev_lock);
+		spin_lock(&inode_lock);
+	}
+clear_it:
 	list_del_init(&inode->i_devices);
 	inode->i_bdev = NULL;
 	inode->i_mapping = &inode->i_data;
+	spin_unlock(&inode_lock);
+	if (iget_done) {
+		spin_unlock(&bdev_lock);
+		iput(inode);
+		spin_lock(&bdev_lock);
+	}
 }
 
 static void bdev_clear_inode(struct inode *inode)







