Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWFCOYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWFCOYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWFCOYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:24:51 -0400
Received: from mx2.mail.ru ([194.67.23.122]:38971 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751680AbWFCOYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:24:50 -0400
Date: Sat, 3 Jun 2006 18:29:15 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5]: ufs: little directory lookup optimization
Message-ID: <20060603142915.GA16285@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch make little optimization of ufs_find_entry
like "ext2" does. Save number of page and reuse it again in the
next call.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc5-mm1/include/linux/ufs_fs_i.h
===================================================================
--- linux-2.6.17-rc5-mm1.orig/include/linux/ufs_fs_i.h
+++ linux-2.6.17-rc5-mm1/include/linux/ufs_fs_i.h
@@ -27,6 +27,7 @@ struct ufs_inode_info {
 	__u32	i_oeftflag;
 	__u16	i_osync;
 	__u32	i_lastfrag;
+	__u32   i_dir_start_lookup;
 	struct inode vfs_inode;
 };
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/dir.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/dir.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/dir.c
@@ -252,6 +252,7 @@ struct ufs_dir_entry *ufs_find_entry(str
 	unsigned long start, n;
 	unsigned long npages = ufs_dir_pages(dir);
 	struct page *page = NULL;
+	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
 
 	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
@@ -262,8 +263,8 @@ struct ufs_dir_entry *ufs_find_entry(str
 	/* OFFSET_CACHE */
 	*res_page = NULL;
 
-	/* start = ei->i_dir_start_lookup; */
-	start = 0;
+	start = ui->i_dir_start_lookup;
+
 	if (start >= npages)
 		start = 0;
 	n = start;
@@ -295,7 +296,7 @@ out:
 
 found:
 	*res_page = page;
-	/* ei->i_dir_start_lookup = n; */
+	ui->i_dir_start_lookup = n;
 	return de;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/ialloc.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/ialloc.c
@@ -264,6 +264,7 @@ cg_found:
 	ufsi->i_shadow = 0;
 	ufsi->i_osync = 0;
 	ufsi->i_oeftflag = 0;
+	ufsi->i_dir_start_lookup = 0;
 	memset(&ufsi->i_u1, 0, sizeof(ufsi->i_u1));
 
 	insert_inode_hash(inode);
Index: linux-2.6.17-rc5-mm1/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/inode.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/inode.c
@@ -628,12 +628,12 @@ void ufs_read_inode (struct inode * inod
 	ufsi->i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 	ufsi->i_lastfrag = (inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;
+	ufsi->i_dir_start_lookup = 0;
 	
 	if (S_ISCHR(mode) || S_ISBLK(mode) || inode->i_blocks) {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR); i++)
 			ufsi->i_u1.i_data[i] = ufs_inode->ui_u2.ui_addr.ui_db[i];
-	}
-	else {
+	} else {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR) * 4; i++)
 			ufsi->i_u1.i_symlink[i] = ufs_inode->ui_u2.ui_symlink[i];
 	}

-- 
/Evgeniy

