Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCEUJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCEUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCEUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:08:43 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18693 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261177AbVCETLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 20/29] FAT: Use fat_remove_entries() for msdos
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
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
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:55:00 +0900
In-Reply-To: <87br9xq5y8.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:54:23 +0900")
Message-ID: <877jklq5x7.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff -puN fs/msdos/namei.c~sync07-fat_dir7 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync07-fat_dir7	2005-03-06 02:37:00.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:37:00.000000000 +0900
@@ -346,16 +346,15 @@ static int msdos_rmdir(struct inode *dir
 	if (err)
 		goto out;
 
-	sinfo.de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(sinfo.bh);
-	brelse(sinfo.bh);
-	fat_detach(inode);
+	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err)
+		goto out;
+	dir->i_nlink--;
+
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	inode->i_ctime = CURRENT_TIME_SEC;
+	fat_detach(inode);
 	mark_inode_dirty(inode);
-
-	dir->i_nlink--;
-	mark_inode_dirty(dir);
 out:
 	unlock_kernel();
 
@@ -430,18 +429,16 @@ static int msdos_unlink(struct inode *di
 	lock_kernel();
 	err = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo);
 	if (err)
-		goto unlink_done;
+		goto out;
 
-	sinfo.de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(sinfo.bh);
-	brelse(sinfo.bh);
-	fat_detach(inode);
+	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err)
+		goto out;
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	inode->i_ctime = CURRENT_TIME_SEC;
+	fat_detach(inode);
 	mark_inode_dirty(inode);
-
-	mark_inode_dirty(dir);
-unlink_done:
+out:
 	unlock_kernel();
 
 	return err;
@@ -526,10 +523,10 @@ static int do_msdos_rename(struct inode 
 	}
 	new_dir->i_version++;
 
-	old_sinfo.de->name[0] = DELETED_FLAG;
-	mark_buffer_dirty(old_sinfo.bh);
-	brelse(old_sinfo.bh);
+	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
+	if (err)
+		goto out;
 	if (is_dir)
 		old_dir->i_nlink--;
 	fat_detach(old_inode);
_
