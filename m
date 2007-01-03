Return-Path: <linux-kernel-owner+w=401wt.eu-S932116AbXACW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbXACW46 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXACW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:56:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58032 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116AbXACW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:56:57 -0500
Date: Wed, 3 Jan 2007 14:56:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Handle error in sync_sb_inodes()
Message-Id: <20070103145655.c6e0963d.akpm@osdl.org>
In-Reply-To: <459C2E6D.2040406@yahoo.fr>
References: <45958E4F.5080105@yahoo.fr>
	<20070102132645.264d2b89.akpm@osdl.org>
	<459C2E6D.2040406@yahoo.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 23:30:05 +0100
Guillaume Chazarain <guichaz@yahoo.fr> wrote:

> Unfortunately, with your patch and not mine, the problem is still 
> present: msync()
> does not return the error. Both pieces of code (yours and mine) are 
> called for the
> same mapping though, albeit yours more frequently.
> 
> My interpretation (based more on imagination than experience) is that
> __writeback_single_inode() ends up calling __block_write_full_page() which
> sets the page flags (your patch), then calls wait_on_page_writeback_range()
> which clears the flags but returns the error as its return value. And this
> error code is dropped by sync_sb_inodes() (my patch not applied).
> 
> With my patch, wait_on_page_writeback_range() would get the error code
> by some other mean, and sync_sb_inodes() would re-put it in the flags for
> msync() later.

hm, something like that.

There's a lot of sloppiness in there.  Do these two patches fix things up?

From: Andrew Morton <akpm@osdl.org>

Guillame points out that sync_sb_inodes() is failing to propagate error codes
back.  Fix that, and make several other void-returning functions not drop
reportable error codes.

Cc: Guillaume Chazarain <guichaz@yahoo.fr>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/fs-writeback.c         |   55 ++++++++++++++++++++++++++----------
 include/linux/writeback.h |    6 +--
 2 files changed, 44 insertions(+), 17 deletions(-)

diff -puN fs/fs-writeback.c~sync_sb_inodes-propagate-errors fs/fs-writeback.c
--- a/fs/fs-writeback.c~sync_sb_inodes-propagate-errors
+++ a/fs/fs-writeback.c
@@ -302,15 +302,18 @@ __writeback_single_inode(struct inode *i
  * on the writer throttling path, and we get decent balancing between many
  * throttled threads: we don't want them all piling up on __wait_on_inode.
  */
-static void
+static int
 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
 {
 	const unsigned long start = jiffies;	/* livelock avoidance */
+	int ret = 0;
 
 	if (!wbc->for_kupdate || list_empty(&sb->s_io))
 		list_splice_init(&sb->s_dirty, &sb->s_io);
 
 	while (!list_empty(&sb->s_io)) {
+		int err;
+
 		struct inode *inode = list_entry(sb->s_io.prev,
 						struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
@@ -365,7 +368,9 @@ sync_sb_inodes(struct super_block *sb, s
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
 		pages_skipped = wbc->pages_skipped;
-		__writeback_single_inode(inode, wbc);
+		err = __writeback_single_inode(inode, wbc);
+		if (!ret)
+			ret = err;
 		if (wbc->sync_mode == WB_SYNC_HOLD) {
 			inode->dirtied_when = jiffies;
 			list_move(&inode->i_list, &sb->s_dirty);
@@ -386,7 +391,7 @@ sync_sb_inodes(struct super_block *sb, s
 		if (wbc->nr_to_write <= 0)
 			break;
 	}
-	return;		/* Leave any unwritten inodes on s_io */
+	return ret;		/* Leave any unwritten inodes on s_io */
 }
 
 /*
@@ -408,10 +413,10 @@ sync_sb_inodes(struct super_block *sb, s
  * sync_sb_inodes will seekout the blockdev which matches `bdi'.  Maybe not
  * super-efficient but we're about to do a ton of I/O...
  */
-void
-writeback_inodes(struct writeback_control *wbc)
+int writeback_inodes(struct writeback_control *wbc)
 {
 	struct super_block *sb;
+	int ret = 0;
 
 	might_sleep();
 	spin_lock(&sb_lock);
@@ -429,9 +434,13 @@ restart:
 			 */
 			if (down_read_trylock(&sb->s_umount)) {
 				if (sb->s_root) {
+					int err;
+
 					spin_lock(&inode_lock);
-					sync_sb_inodes(sb, wbc);
+					err = sync_sb_inodes(sb, wbc);
 					spin_unlock(&inode_lock);
+					if (!ret)
+						ret = err;
 				}
 				up_read(&sb->s_umount);
 			}
@@ -443,6 +452,7 @@ restart:
 			break;
 	}
 	spin_unlock(&sb_lock);
+	return ret;
 }
 
 /*
@@ -456,7 +466,7 @@ restart:
  * We add in the number of potentially dirty inodes, because each inode write
  * can dirty pagecache in the underlying blockdev.
  */
-void sync_inodes_sb(struct super_block *sb, int wait)
+int sync_inodes_sb(struct super_block *sb, int wait)
 {
 	struct writeback_control wbc = {
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
@@ -465,14 +475,16 @@ void sync_inodes_sb(struct super_block *
 	};
 	unsigned long nr_dirty = global_page_state(NR_FILE_DIRTY);
 	unsigned long nr_unstable = global_page_state(NR_UNSTABLE_NFS);
+	int ret;
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
 			nr_dirty + nr_unstable;
 	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
 	spin_lock(&inode_lock);
-	sync_sb_inodes(sb, &wbc);
+	ret = sync_sb_inodes(sb, &wbc);
 	spin_unlock(&inode_lock);
+	return ret;
 }
 
 /*
@@ -508,13 +520,16 @@ static void set_sb_syncing(int val)
  * outstanding dirty inodes, the writeback goes block-at-a-time within the
  * filesystem's write_inode().  This is extremely slow.
  */
-static void __sync_inodes(int wait)
+static int __sync_inodes(int wait)
 {
 	struct super_block *sb;
+	int ret = 0;
 
 	spin_lock(&sb_lock);
 restart:
 	list_for_each_entry(sb, &super_blocks, s_list) {
+		int err;
+
 		if (sb->s_syncing)
 			continue;
 		sb->s_syncing = 1;
@@ -522,8 +537,12 @@ restart:
 		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
 		if (sb->s_root) {
-			sync_inodes_sb(sb, wait);
-			sync_blockdev(sb->s_bdev);
+			err = sync_inodes_sb(sb, wait);
+			if (!ret)
+				ret = err;
+			err = sync_blockdev(sb->s_bdev);
+			if (!ret)
+				ret = err;
 		}
 		up_read(&sb->s_umount);
 		spin_lock(&sb_lock);
@@ -531,17 +550,25 @@ restart:
 			goto restart;
 	}
 	spin_unlock(&sb_lock);
+	return ret;
 }
 
-void sync_inodes(int wait)
+int sync_inodes(int wait)
 {
+	int ret;
+
 	set_sb_syncing(0);
-	__sync_inodes(0);
+	ret = __sync_inodes(0);
 
 	if (wait) {
+		int err;
+
 		set_sb_syncing(0);
-		__sync_inodes(1);
+		err = __sync_inodes(1);
+		if (!ret)
+			ret = err;
 	}
+	return ret;
 }
 
 /**
diff -puN include/linux/writeback.h~sync_sb_inodes-propagate-errors include/linux/writeback.h
--- a/include/linux/writeback.h~sync_sb_inodes-propagate-errors
+++ a/include/linux/writeback.h
@@ -64,11 +64,11 @@ struct writeback_control {
 /*
  * fs/fs-writeback.c
  */	
-void writeback_inodes(struct writeback_control *wbc);
+int writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
 int inode_wait(void *);
-void sync_inodes_sb(struct super_block *, int wait);
-void sync_inodes(int wait);
+int sync_inodes_sb(struct super_block *, int wait);
+int sync_inodes(int wait);
 
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
_



From: Andrew Morton <akpm@osdl.org>

block_write_full_page() forgot to propagate ENPSOC into the address_space.

Cc: Guillaume Chazarain <guichaz@yahoo.fr>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/buffer.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/buffer.c~block_write_full_page-handle-enospc fs/buffer.c
--- a/fs/buffer.c~block_write_full_page-handle-enospc
+++ a/fs/buffer.c
@@ -1740,6 +1740,7 @@ recover:
 	} while ((bh = bh->b_this_page) != head);
 	SetPageError(page);
 	BUG_ON(PageWriteback(page));
+	mapping_set_error(page->mapping, err);
 	set_page_writeback(page);
 	unlock_page(page);
 	do {
_

