Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCETzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCETzB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVCETyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:54:31 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:21765 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261191AbVCETLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] FAT: Use synchronous update for
 {vfat,msdos}_add_entry()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
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
	<87hdjpor76.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:58:52 +0900
In-Reply-To: <87hdjpor76.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:58:21 +0900")
Message-ID: <87d5udor6b.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the synchronous updates, in order to guarantee that the writing to
a disk is completeing when a system call returns.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |    5 ++++-
 fs/vfat/namei.c  |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN fs/msdos/namei.c~sync08-fat_tweak7 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync08-fat_tweak7	2005-03-06 02:37:29.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:37:29.000000000 +0900
@@ -278,7 +278,10 @@ static int msdos_add_entry(struct inode 
 		return err;
 
 	dir->i_ctime = dir->i_mtime = *ts;
-	mark_inode_dirty(dir);
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
 
 	return 0;
 }
diff -puN fs/vfat/namei.c~sync08-fat_tweak7 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync08-fat_tweak7	2005-03-06 02:37:29.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:37:29.000000000 +0900
@@ -684,7 +684,10 @@ static int vfat_add_entry(struct inode *
 
 	/* update timestamp */
 	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
-	mark_inode_dirty(dir);
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
 cleanup:
 	kfree(slots);
 	return err;
_
