Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVCTLn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVCTLn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCTLn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:43:57 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33293 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261152AbVCTLnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:43:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: race between __sync_single_inode() and
 iput()/bdev_clear_inode()
References: <87zmwzzaem.fsf@devron.myhome.or.jp>
	<20050319223843.04b31ae5.akpm@osdl.org>
	<87acoyo8u8.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 20 Mar 2005 20:43:36 +0900
In-Reply-To: <87acoyo8u8.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 20 Mar 2005 20:27:59 +0900")
Message-ID: <87y8cimtjr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

Grr.. that patch was calling iput() under inode_lock. Fixed patch is below.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/block_dev.c    |   27 ++++++++++++++++++++++++++-
 fs/fs-writeback.c |   34 ++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff -puN fs/block_dev.c~bdev-inode-sync fs/block_dev.c
--- linux-2.6.12-rc1/fs/block_dev.c~bdev-inode-sync	2005-03-20 04:49:31.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/fs/block_dev.c	2005-03-20 07:14:43.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
+#include <linux/writeback.h>
 #include <asm/uaccess.h>
 
 struct bdev_inode {
@@ -282,11 +283,35 @@ static inline void __bd_forget(struct in
 
 static void bdev_clear_inode(struct inode *inode)
 {
+	extern void wait_inode_ilock(struct inode *inode);
 	struct block_device *bdev = &BDEV_I(inode)->bdev;
 	struct list_head *p;
+	struct inode *i;
+
 	spin_lock(&bdev_lock);
 	while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
-		__bd_forget(list_entry(p, struct inode, i_devices));
+		inode = list_entry(p, struct inode, i_devices);
+		i = igrab(inode);
+		spin_unlock(&bdev_lock);
+		/*
+		 * Preparation for changeing the ->i_mapping.  Make
+		 * sure this inode is not in __sync_single_inode().
+		 */
+		if (i) {
+			spin_lock(&inode_lock);
+			wait_inode_ilock(i);
+			inode->i_state |= I_LOCK;
+			spin_unlock(&inode_lock);
+		}
+		spin_lock(&bdev_lock);
+		spin_lock(&inode_lock);
+		__bd_forget(inode);
+		if (i) {
+			inode->i_state &= ~I_LOCK;
+			wake_up_inode(i);
+		}
+		spin_unlock(&inode_lock);
+		iput(i);
 	}
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
diff -puN fs/fs-writeback.c~bdev-inode-sync fs/fs-writeback.c
--- linux-2.6.12-rc1/fs/fs-writeback.c~bdev-inode-sync	2005-03-20 04:49:31.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/fs/fs-writeback.c	2005-03-20 04:49:31.000000000 +0900
@@ -140,6 +140,25 @@ static int write_inode(struct inode *ino
 	return 0;
 }
 
+/* Called under inode_lock. */
+void wait_inode_ilock(struct inode *inode)
+{
+	wait_queue_head_t *wqh;
+	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LOCK);
+
+	if (!(inode->i_state & I_LOCK))
+		return;
+
+	wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
+	do {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		__wait_on_bit(wqh, &wq, inode_wait, TASK_UNINTERRUPTIBLE);
+		iput(inode);
+		spin_lock(&inode_lock);
+	} while (inode->i_state & I_LOCK);
+}
+
 /*
  * Write a single inode's dirty pages and inode data out to disk.
  * If `wait' is set, wait on the writeout.
@@ -244,8 +263,6 @@ static int
 __writeback_single_inode(struct inode *inode,
 			struct writeback_control *wbc)
 {
-	wait_queue_head_t *wqh;
-
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return 0;
@@ -254,19 +271,8 @@ __writeback_single_inode(struct inode *i
 	/*
 	 * It's a data-integrity sync.  We must wait.
 	 */
-	if (inode->i_state & I_LOCK) {
-		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LOCK);
+	wait_inode_ilock(inode);
 
-		wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
-		do {
-			__iget(inode);
-			spin_unlock(&inode_lock);
-			__wait_on_bit(wqh, &wq, inode_wait,
-							TASK_UNINTERRUPTIBLE);
-			iput(inode);
-			spin_lock(&inode_lock);
-		} while (inode->i_state & I_LOCK);
-	}
 	return __sync_single_inode(inode, wbc);
 }
 
_
