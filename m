Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCEUJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCEUJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVCEUGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:06:31 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18181 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261169AbVCETLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:22 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 26/29] FAT: Fix fat_write_inode()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
	<87u0npor9o.fsf_-_@devron.myhome.or.jp>
	<87psydor8t.fsf_-_@devron.myhome.or.jp>
	<87ll91or7y.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:58:21 +0900
In-Reply-To: <87ll91or7y.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:57:53 +0900")
Message-ID: <87hdjpor76.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a missing error check for sync_buffer_dirty().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff -puN fs/fat/inode.c~sync08-fat_tweak6 fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync08-fat_tweak6	2005-03-06 02:37:26.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:37:26.000000000 +0900
@@ -463,18 +463,20 @@ static int fat_write_inode(struct inode 
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
 	loff_t i_pos;
+	int err = 0;
 
 retry:
 	i_pos = MSDOS_I(inode)->i_pos;
-	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos) {
+	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos)
 		return 0;
-	}
+
 	lock_kernel();
-	if (!(bh = sb_bread(sb, i_pos >> sbi->dir_per_block_bits))) {
+	bh = sb_bread(sb, i_pos >> sbi->dir_per_block_bits);
+	if (!bh) {
 		printk(KERN_ERR "FAT: unable to read inode block "
 		       "for updating (i_pos %lld)\n", i_pos);
-		unlock_kernel();
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
 	spin_lock(&sbi->inode_hash_lock);
 	if (i_pos != MSDOS_I(inode)->i_pos) {
@@ -502,11 +504,11 @@ retry:
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
 	if (wait)
-		sync_dirty_buffer(bh);
+		err = sync_dirty_buffer(bh);
 	brelse(bh);
+out:
 	unlock_kernel();
-
-	return 0;
+	return err;
 }
 
 int fat_sync_inode(struct inode *inode)
_
