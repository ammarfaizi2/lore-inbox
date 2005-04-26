Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDZM1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDZM1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDZM1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:27:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49024 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261492AbVDZM1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:27:04 -0400
Date: Tue, 26 Apr 2005 14:27:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Colin Leroy <colin@colino.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't leak sb->s_fs_info and don't oops on bad
 filesystem
In-Reply-To: <20050426100636.2bda6939@colin.toulouse>
Message-ID: <Pine.LNX.4.61.0504261426001.997@scrub.home>
References: <20050426100636.2bda6939@colin.toulouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Apr 2005, Colin Leroy wrote:

> This is the second attempt at fixing two bugs in hfsplus; this patch
> fixes the leak of sb->s_fs_info, and also fixes an oops [1] when trying
> to mount something that isn't hfsplus with hfsplus.
> 
> The first hunk is just a protection, the second one fixes the oops, and 
> the third one fixes the leak.

Close. :) What I had in mind is something like below.

bye, Roman

 hfs/mdb.c       |    5 +++++
 hfs/super.c     |    8 +++-----
 hfsplus/super.c |    6 +++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/fs/hfs/mdb.c
===================================================================
--- linux-2.6-mm.orig/fs/hfs/mdb.c	2005-02-02 11:32:45.000000000 +0100
+++ linux-2.6-mm/fs/hfs/mdb.c	2005-04-26 11:41:12.000000000 +0200
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
Index: linux-2.6-mm/fs/hfs/super.c
===================================================================
--- linux-2.6-mm.orig/fs/hfs/super.c	2005-04-26 11:24:08.000000000 +0200
+++ linux-2.6-mm/fs/hfs/super.c	2005-04-26 11:35:36.000000000 +0200
@@ -297,7 +297,7 @@ static int hfs_fill_super(struct super_b
 	res = -EINVAL;
 	if (!parse_options((char *)data, sbi)) {
 		hfs_warn("hfs_fs: unable to parse mount options.\n");
-		goto bail3;
+		goto bail;
 	}
 
 	sb->s_op = &hfs_super_operations;
@@ -310,7 +310,7 @@ static int hfs_fill_super(struct super_b
 			hfs_warn("VFS: Can't find a HFS filesystem on dev %s.\n",
 				hfs_mdb_name(sb));
 		res = -EINVAL;
-		goto bail2;
+		goto bail;
 	}
 
 	/* try to get the root inode */
@@ -340,10 +340,8 @@ bail_iput:
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
 
Index: linux-2.6-mm/fs/hfsplus/super.c
===================================================================
--- linux-2.6-mm.orig/fs/hfsplus/super.c	2005-04-26 11:24:09.000000000 +0200
+++ linux-2.6-mm/fs/hfsplus/super.c	2005-04-26 14:24:39.000000000 +0200
@@ -208,7 +208,9 @@ static void hfsplus_write_super(struct s
 static void hfsplus_put_super(struct super_block *sb)
 {
 	dprint(DBG_SUPER, "hfsplus_put_super\n");
-	if (!(sb->s_flags & MS_RDONLY)) {
+	if (!sb->s_fs_info)
+		return;
+	if (!(sb->s_flags & MS_RDONLY) && HFSPLUS_SB(sb).s_vhdr) {
 		struct hfsplus_vh *vhdr = HFSPLUS_SB(sb).s_vhdr;
 
 		vhdr->modify_date = hfsp_now2mt();
@@ -226,6 +228,8 @@ static void hfsplus_put_super(struct sup
 	brelse(HFSPLUS_SB(sb).s_vhbh);
 	if (HFSPLUS_SB(sb).nls)
 		unload_nls(HFSPLUS_SB(sb).nls);
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
