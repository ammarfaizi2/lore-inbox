Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVFIAFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVFIAFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFIADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:03:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:54407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262243AbVFIABs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:01:48 -0400
Date: Wed, 8 Jun 2005 17:00:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Colin Leroy <colin@colino.net>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 03/09] fix hfsplus oops, hfs and hfsplus leak
Message-ID: <20050609000009.GJ13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the leak of sb->s_fs_info in both the HFS and HFS+
modules. In addition to this, it fixes an oops happening when trying to
mount a non-hfsplus filesystem using hfsplus. This patch is from Roman
Zippel, based off patches sent by myself. It's been included in 2.6.12-
rc4. See
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=945b092011c6af71a0107be96e119c8c08776f3f

(chrisw: backport to -stable)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Colin Leroy <colin@colino.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>

 fs/hfs/mdb.c       |    5 +++++
 fs/hfs/super.c     |    8 +++-----
 fs/hfsplus/super.c |    6 +++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

Index: release-2.6.11/fs/hfs/mdb.c
===================================================================
--- release-2.6.11.orig/fs/hfs/mdb.c
+++ release-2.6.11/fs/hfs/mdb.c
@@ -333,6 +333,8 @@ void hfs_mdb_close(struct super_block *s
  * Release the resources associated with the in-core MDB.  */
 void hfs_mdb_put(struct super_block *sb)
 {
+	if (!HFS_SB(sb))
+		return;
 	/* free the B-trees */
 	hfs_btree_close(HFS_SB(sb)->ext_tree);
 	hfs_btree_close(HFS_SB(sb)->cat_tree);
@@ -340,4 +342,7 @@ void hfs_mdb_put(struct super_block *sb)
 	/* free the buffers holding the primary and alternate MDBs */
 	brelse(HFS_SB(sb)->mdb_bh);
 	brelse(HFS_SB(sb)->alt_mdb_bh);
+
+	kfree(HFS_SB(sb));
+	sb->s_fs_info = NULL;
 }
Index: release-2.6.11/fs/hfs/super.c
===================================================================
--- release-2.6.11.orig/fs/hfs/super.c
+++ release-2.6.11/fs/hfs/super.c
@@ -263,7 +263,7 @@ static int hfs_fill_super(struct super_b
 	res = -EINVAL;
 	if (!parse_options((char *)data, sbi)) {
 		hfs_warn("hfs_fs: unable to parse mount options.\n");
-		goto bail3;
+		goto bail;
 	}
 
 	sb->s_op = &hfs_super_operations;
@@ -276,7 +276,7 @@ static int hfs_fill_super(struct super_b
 			hfs_warn("VFS: Can't find a HFS filesystem on dev %s.\n",
 				hfs_mdb_name(sb));
 		res = -EINVAL;
-		goto bail2;
+		goto bail;
 	}
 
 	/* try to get the root inode */
@@ -306,10 +306,8 @@ bail_iput:
 	iput(root_inode);
 bail_no_root:
 	hfs_warn("hfs_fs: get root inode failed.\n");
+bail:
 	hfs_mdb_put(sb);
-bail2:
-bail3:
-	kfree(sbi);
 	return res;
 }
 
Index: release-2.6.11/fs/hfsplus/super.c
===================================================================
--- release-2.6.11.orig/fs/hfsplus/super.c
+++ release-2.6.11/fs/hfsplus/super.c
@@ -207,7 +207,9 @@ static void hfsplus_write_super(struct s
 static void hfsplus_put_super(struct super_block *sb)
 {
 	dprint(DBG_SUPER, "hfsplus_put_super\n");
-	if (!(sb->s_flags & MS_RDONLY)) {
+	if (!sb->s_fs_info)
+		return;
+	if (!(sb->s_flags & MS_RDONLY) && HFSPLUS_SB(sb).s_vhdr) {
 		struct hfsplus_vh *vhdr = HFSPLUS_SB(sb).s_vhdr;
 
 		vhdr->modify_date = hfsp_now2mt();
@@ -223,6 +225,8 @@ static void hfsplus_put_super(struct sup
 	iput(HFSPLUS_SB(sb).alloc_file);
 	iput(HFSPLUS_SB(sb).hidden_dir);
 	brelse(HFSPLUS_SB(sb).s_vhbh);
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
