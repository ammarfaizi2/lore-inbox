Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbUKRS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUKRS4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUKRSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:54:22 -0500
Received: from colino.net ([213.41.131.56]:58870 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261155AbUKRSvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:51:49 -0500
Date: Thu, 18 Nov 2004 19:51:29 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp
Subject: [PATCH] let vfat handle MS_SYNCHRONOUS flag
Message-ID: <20041118195129.432f4110.colin@colino.net>
In-Reply-To: <20041118194959.3f1a3c8e.colin@colino.net>
References: <20041118194959.3f1a3c8e.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2004 at 19h11, Colin Leroy wrote:

Hi, 
Same patch for vfat.

Signed-off-by: Colin Leroy <colin@colino.net>
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
