Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbUKXJjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUKXJjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUKXJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:39:52 -0500
Received: from colino.net ([213.41.131.56]:10488 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262565AbUKXJj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:39:29 -0500
Date: Wed, 24 Nov 2004 10:38:16 +0100
From: Colin Leroy <colin@colino.net>
To: Raj <inguva@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Delay in unmounting a USB pen drive
Message-ID: <20041124103816.0a8d4183@pirandello>
In-Reply-To: <b2fa632f041124012543876b61@mail.gmail.com>
References: <b2fa632f041124012543876b61@mail.gmail.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs163.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=Multipart_Wed__24_Nov_2004_10_38_16_+0100_Ie53c5L2FaxrKe06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Wed__24_Nov_2004_10_38_16_+0100_Ie53c5L2FaxrKe06
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 24 Nov 2004 at 14h11, Raj wrote:

Hi, 

> - Why is it taking a long time to unmount ?

It's syncing last writes

> - Is it safe to remove the pen drive from it's slot when the umount is still in
>   progress ?? ( I tried this the first time & maybe lucky me, the
> files copied were fine )

Lucky you :) If your key is fat or vfat, you could try these two patches 
and mount your USB key with -o sync option, your feedback interests me. 
It should make the copies to key slower, but the umount immediate.

-- 
Colin

--Multipart_Wed__24_Nov_2004_10_38_16_+0100_Ie53c5L2FaxrKe06
Content-Type: text/plain; name=fat_sync.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=fat_sync.patch

--- a/fs/fat/cache.c	2004-11-18 19:42:41.701778200 +0100
+++ b/fs/fat/cache.c	2004-11-18 18:40:25.000000000 +0100
@@ -271,6 +271,7 @@
 			mark_buffer_dirty(bh2);
 		}
 		mark_buffer_dirty(bh);
+
 		for (copy = 1; copy < sbi->fats; copy++) {
 			b = sbi->fat_start + (first >> sb->s_blocksize_bits)
 				+ sbi->fat_length * copy;
--- a/fs/fat/dir.c	2004-11-18 19:42:41.704777744 +0100
+++ b/fs/fat/dir.c	2004-11-18 14:36:44.000000000 +0100
@@ -736,6 +736,7 @@
 {
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
+	struct super_block *sb;
 	__le16 date, time;
 
 	bh = fat_extend_dir(dir);
@@ -764,6 +765,11 @@
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
+	sb = dir->i_sb;
+
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+
 	return 0;
 }
 
--- a/fs/fat/file.c	2004-10-18 23:53:44.000000000 +0200
+++ b/fs/fat/file.c	2004-11-18 14:57:03.000000000 +0100
@@ -74,21 +74,34 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh = NULL;
 
 	retval = generic_file_write(filp, buf, count, ppos);
 	if (retval > 0) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
+		if (sb->s_flags & MS_SYNCHRONOUS) {
+			bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
+			if (bh != NULL) {
+				sync_dirty_buffer(bh);
+				brelse(bh);
+			} else {
+				BUG_ON(1);
+			}
+		}
 	}
 	return retval;
 }
 
 void fat_truncate(struct inode *inode)
 {
+	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
+	struct buffer_head *bh = NULL;
 
 	/* 
 	 * This protects against truncating a file bigger than it was then
@@ -105,4 +118,8 @@
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
+	if (sb->s_flags & MS_SYNCHRONOUS) {
+		bh = sb_bread(sb, sbi->fsinfo_sector);
+		sync_dirty_buffer(bh);
+	}
 }
--- a/fs/fat/inode.c	2004-11-18 19:42:41.710776832 +0100
+++ b/fs/fat/inode.c	2004-11-18 15:00:55.000000000 +0100
@@ -1273,8 +1273,12 @@
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
-	brelse(bh);
 	unlock_kernel();
+
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+	brelse(bh);
+
 	return 0;
 }
 

--Multipart_Wed__24_Nov_2004_10_38_16_+0100_Ie53c5L2FaxrKe06
Content-Type: text/plain; name=vfat_sync.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=vfat_sync.patch

--- a/fs/vfat/namei.c	2004-10-18 23:54:37.000000000 +0200
+++ b/fs/vfat/namei.c	2004-11-18 18:41:52.000000000 +0100
@@ -743,6 +743,8 @@
 	(*de)->adate = (*de)->cdate = (*de)->date;
 
 	mark_buffer_dirty(*bh);
+	if (dir->i_sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(*bh);
 
 	/* slots can't be less than 1 */
 	sinfo_out->long_slots = slots - 1;
@@ -844,7 +846,6 @@
 	if (res < 0)
 		goto out;
 	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
-	brelse(bh);
 	if (!inode)
 		goto out;
 	res = 0;
@@ -854,7 +855,10 @@
 	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry,inode);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
 out:
+	brelse(bh);
 	unlock_kernel();
 	return res;
 }
@@ -871,6 +875,7 @@
 	mark_inode_dirty(dir);
 	de->name[0] = DELETED_FLAG;
 	mark_buffer_dirty(bh);
+
 	/* remove the longname */
 	offset = sinfo->longname_offset; de = NULL;
 	for (i = sinfo->long_slots; i > 0; --i) {
@@ -880,6 +885,9 @@
 		de->attr = ATTR_NONE;
 		mark_buffer_dirty(bh);
 	}
+	if (dir->i_sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+
 	brelse(bh);
 }
 
@@ -903,7 +911,7 @@
 	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
-	/* releases bh */
+	/* releases bh and syncs it if necessary */
 	vfat_remove_entry(dir,&sinfo,bh,de);
 	dir->i_nlink--;
 out:
@@ -926,7 +934,7 @@
 	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
-	/* releases bh */
+	/* releases bh and syncs it if necessary */
 	vfat_remove_entry(dir,&sinfo,bh,de);
 out:
 	unlock_kernel();
@@ -956,6 +964,10 @@
 	dir->i_version++;
 	dir->i_nlink++;
 	inode->i_nlink = 2; /* no need to mark them dirty */
+
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+	
 	res = fat_new_dir(inode, dir, 1);
 	if (res < 0)
 		goto mkdir_failed;
@@ -972,7 +984,7 @@
 	inode->i_mtime = inode->i_atime = CURRENT_TIME;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
-	/* releases bh */
+	/* releases bh ands syncs if necessary */
 	vfat_remove_entry(dir,&sinfo,bh,de);
 	iput(inode);
 	dir->i_nlink--;
@@ -1057,6 +1069,8 @@
 			new_dir->i_nlink++;
 			mark_inode_dirty(new_dir);
 		}
+		if (new_dir->i_sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(dotdot_bh);
 	}
 
 rename_done:

--Multipart_Wed__24_Nov_2004_10_38_16_+0100_Ie53c5L2FaxrKe06--
