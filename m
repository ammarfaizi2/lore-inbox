Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUJNULR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUJNULR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUJNT67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:58:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43696 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267451AbUJNTzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:55:01 -0400
Subject: [PATCH 1/1] discard ext2 preallocation in last iput
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041014114142.GA24727@lst.de>
References: <20041014114142.GA24727@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2004 12:55:56 -0700
Message-Id: <1097783763.7900.531.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 04:41, Christoph Hellwig wrote:
> Hi Mingming,
> 
> you'd been reworking ext3 reservations to be dropped in ->clear_inode
> instead of the previous bogus call in ->put_inode in
> ext3-lazy-discard-reservation-window-patch.patch in -mm.
> 
> Any chance you could submit a similar change (not the full reservations
> rework) for ext2?
> 
Andrew,

Here is the patch for ext2. The patch is against 2.6.9-rc4. I have done
basic testing: it passed the fsstress test from LTP on a ext2 partition.

Thanks,
Mingming

Currently the ext2 preallocation is discarded on every iput()(via ext2_put_inode()). We should only discard the preallocation on the last iput()(via ext3_clear_inode()).


---

 linux-2.6.9-rc4-ming/fs/ext2/ext2.h  |    1 -
 linux-2.6.9-rc4-ming/fs/ext2/inode.c |   13 -------------
 linux-2.6.9-rc4-ming/fs/ext2/super.c |   10 ++++------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff -puN fs/ext2/inode.c~ext2_discard_prealloc_fix fs/ext2/inode.c
--- linux-2.6.9-rc4/fs/ext2/inode.c~ext2_discard_prealloc_fix	2004-10-14 18:02:38.458168192 -0700
+++ linux-2.6.9-rc4-ming/fs/ext2/inode.c	2004-10-14 18:12:03.002344432 -0700
@@ -53,19 +53,6 @@ static inline int ext2_inode_is_fast_sym
 }
 
 /*
- * Called at each iput().
- *
- * The inode may be "bad" if ext2_read_inode() saw an error from
- * ext2_get_inode(), so we need to check that to avoid freeing random disk
- * blocks.
- */
-void ext2_put_inode(struct inode *inode)
-{
-	if (!is_bad_inode(inode))
-		ext2_discard_prealloc(inode);
-}
-
-/*
  * Called at the last iput() if i_nlink is zero.
  */
 void ext2_delete_inode (struct inode * inode)
diff -puN fs/ext2/super.c~ext2_discard_prealloc_fix fs/ext2/super.c
--- linux-2.6.9-rc4/fs/ext2/super.c~ext2_discard_prealloc_fix	2004-10-14 18:06:55.525088080 -0700
+++ linux-2.6.9-rc4-ming/fs/ext2/super.c	2004-10-14 19:05:47.943078920 -0700
@@ -181,10 +181,9 @@ static void destroy_inodecache(void)
 		printk(KERN_INFO "ext2_inode_cache: not all structures were freed\n");
 }
 
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-
 static void ext2_clear_inode(struct inode *inode)
 {
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
 	struct ext2_inode_info *ei = EXT2_I(inode);
 
 	if (ei->i_acl && ei->i_acl != EXT2_ACL_NOT_CACHED) {
@@ -195,18 +194,17 @@ static void ext2_clear_inode(struct inod
 		posix_acl_release(ei->i_default_acl);
 		ei->i_default_acl = EXT2_ACL_NOT_CACHED;
 	}
+#endif
+	if (!is_bad_inode(inode))
+		ext2_discard_prealloc(inode);
 }
 
-#else
-# define ext2_clear_inode NULL
-#endif
 
 static struct super_operations ext2_sops = {
 	.alloc_inode	= ext2_alloc_inode,
 	.destroy_inode	= ext2_destroy_inode,
 	.read_inode	= ext2_read_inode,
 	.write_inode	= ext2_write_inode,
-	.put_inode	= ext2_put_inode,
 	.delete_inode	= ext2_delete_inode,
 	.put_super	= ext2_put_super,
 	.write_super	= ext2_write_super,
diff -puN fs/ext2/ext2.h~ext2_discard_prealloc_fix fs/ext2/ext2.h
--- linux-2.6.9-rc4/fs/ext2/ext2.h~ext2_discard_prealloc_fix	2004-10-14 18:59:22.688646496 -0700
+++ linux-2.6.9-rc4-ming/fs/ext2/ext2.h	2004-10-14 18:59:33.820954128 -0700
@@ -116,7 +116,6 @@ extern unsigned long ext2_count_free (st
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
 extern int ext2_write_inode (struct inode *, int);
-extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);

_

