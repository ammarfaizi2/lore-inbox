Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVCSTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVCSTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVCSTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:47:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11024 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261714AbVCSTqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:46:54 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: race between __sync_single_inode() and iput()/bdev_clear_inode()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 20 Mar 2005 04:46:25 +0900
Message-ID: <87zmwzzaem.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

EIP is at filemap_fdatawait+0xe/0x80
eax: e7461ad8   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: e5334c40   edi: 6b6b6b6b   ebp: de239e88   esp: de239e70
ds: 007b   es: 007b   ss: 0068
Process fsstress (pid: 31048, threadinfo=de239000 task=e60cd020)
Stack: e7d34358 de239e88 c01834f7 00000000 e5334c40 e7461ad8 de239eb0 c01836bf 
       e7461ad8 00000001 00000000 00000001 e7f0eac8 e5334c40 e7f0eac8 e7d2ddf4 
       de239f0c c0183777 e5334c40 de239f4c e5334c40 e7f0eac8 e7d2ddf4 de239f0c 
Call Trace:
 [show_stack+127/160] show_stack+0x7f/0xa0
 [show_registers+351/464] show_registers+0x15f/0x1d0
 [die+244/384] die+0xf4/0x180
 [do_page_fault+886/1749] do_page_fault+0x376/0x6d5
 [error_code+43/48] error_code+0x2b/0x30
 [__sync_single_inode+447/512] __sync_single_inode+0x1bf/0x200
 [__writeback_single_inode+119/352] __writeback_single_inode+0x77/0x160
 [sync_sb_inodes+452/736] sync_sb_inodes+0x1c4/0x2e0
 [sync_inodes_sb+126/144] sync_inodes_sb+0x7e/0x90
 [sync_inodes+140/176] sync_inodes+0x8c/0xb0
 [do_sync+90/144] do_sync+0x5a/0x90
 [sys_sync+18/32] sys_sync+0x12/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: ab 89 1c 24 8b 75 e4 8b 45 ec 89 74 24 08 89 44 24 04 e8 16 fd ff ff eb 93 8d 74 26 00 55 89 e5 57 56 53 83 ec 0c 8b 45 08 8b 38 <8b> 97 5c 01 00 00 8d b6 00 00 00 00 8d bf 00 00 00 00 89 d0 f0

Dump of assembler code for function filemap_fdatawait:
0xc013e290 <filemap_fdatawait+0>:  push   %ebp
0xc013e291 <filemap_fdatawait+1>:  mov    %esp,%ebp
0xc013e293 <filemap_fdatawait+3>:  push   %edi
0xc013e294 <filemap_fdatawait+4>:  push   %esi
0xc013e295 <filemap_fdatawait+5>:  push   %ebx
0xc013e296 <filemap_fdatawait+6>:  sub    $0xc,%esp
0xc013e299 <filemap_fdatawait+9>:  mov    0x8(%ebp),%eax     <- %eax is mapping
0xc013e29c <filemap_fdatawait+12>: mov    (%eax),%edi        <- %edi is mapping->host
0xc013e29e <filemap_fdatawait+14>: mov    0x15c(%edi),%edx   <- Oops here
0xc013e2a4 <filemap_fdatawait+20>: lea    0x0(%esi),%esi


I got the above Oops while doing fs stress test.

The cause of this was race condition between __sync_single_inode() and
iput()/bdev_clear_inode().

This race seems following condition.

          cpu0 (fs's inode)                 cpu1 (bdev's inode)
------------------------------------------------------------------------
                                               close("/dev/hda2")
                                       [...]
__sync_single_inode()
   /* copy the bdev's ->i_mapping */
   mapping = inode->i_mapping;

                                       generic_forget_inode()
                                          bdev_clear_inode()
					     /* restre the fs's ->i_mapping */
				             inode->i_mapping = &inode->i_data;
				          /* bdev's inode was freed */
                                          destroy_inode(inode);

   if (wait) {
      /* dereference a freed bdev's mapping->host */
      filemap_fdatawait(mapping);  /* Oops */


I wrote the attached patch for making sure fs's inode is not in
__sync_single_inode().

What do you think of this?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/block_dev.c    |   27 ++++++++++++++++++++++++++-
 fs/fs-writeback.c |   34 ++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff -puN fs/block_dev.c~bdev-inode-sync fs/block_dev.c
--- linux-2.6.12-rc1/fs/block_dev.c~bdev-inode-sync	2005-03-20 02:59:24.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/fs/block_dev.c	2005-03-20 03:59:54.000000000 +0900
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
+		if (i) {
+			inode->i_state &= ~I_LOCK;
+			wake_up_inode(i);
+			iput(i);
+		}
+		__bd_forget(inode);
+		spin_unlock(&inode_lock);
 	}
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
diff -puN fs/fs-writeback.c~bdev-inode-sync fs/fs-writeback.c
--- linux-2.6.12-rc1/fs/fs-writeback.c~bdev-inode-sync	2005-03-20 02:59:24.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/fs/fs-writeback.c	2005-03-20 04:00:15.000000000 +0900
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
