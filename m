Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWCRNDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWCRNDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWCRNDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:03:34 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:40697 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932126AbWCRNDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:03:33 -0500
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ext2/3: Change the max filesize limit (e2fsprogs-1.38)
Message-Id: <20060318220325sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 18 Mar 2006 22:03:25 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modification to change the max file size limit in e2fsprogs-1.38.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN e2fsprogs-1.38.org/debugfs/debugfs.c e2fsprogs-1.38-bigfile/debugfs/debugfs.c
--- e2fsprogs-1.38.org/debugfs/debugfs.c	2005-05-06 22:04:36.000000000 +0900
+++ e2fsprogs-1.38-bigfile/debugfs/debugfs.c	2006-02-27 15:55:25.000000000 +0900
@@ -525,7 +525,7 @@ void internal_dump_inode(FILE *out, cons
 		fprintf(out, "%sFile ACL: %d    Directory ACL: %d\n",
 			prefix,
 			inode->i_file_acl, LINUX_S_ISDIR(inode->i_mode) ? inode->i_dir_acl : 0);
-	fprintf(out, "%sLinks: %d   Blockcount: %d\n", 
+	fprintf(out, "%sLinks: %d   Blockcount: %u\n", 
 		prefix, inode->i_links_count, inode->i_blocks);
 	switch (os) {
 	    case EXT2_OS_LINUX:
@@ -822,6 +822,7 @@ void do_modify_inode(int argc, char *arg
 	const char	*hex_format = "0x%x";
 	const char	*octal_format = "0%o";
 	const char	*decimal_format = "%d";
+	const char	*unsignedlong_format = "%lu";
 	
 	if (common_inode_args_process(argc, argv, &inode_num, CHECK_FS_RW))
 		return;
@@ -834,13 +835,16 @@ void do_modify_inode(int argc, char *arg
 	modify_u16(argv[0], "Mode", octal_format, &inode.i_mode);
 	modify_u16(argv[0], "User ID", decimal_format, &inode.i_uid);
 	modify_u16(argv[0], "Group ID", decimal_format, &inode.i_gid);
-	modify_u32(argv[0], "Size", decimal_format, &inode.i_size);
+	modify_u32(argv[0], "Size", unsignedlong_format, &inode.i_size);
 	modify_u32(argv[0], "Creation time", decimal_format, &inode.i_ctime);
 	modify_u32(argv[0], "Modification time", decimal_format, &inode.i_mtime);
 	modify_u32(argv[0], "Access time", decimal_format, &inode.i_atime);
 	modify_u32(argv[0], "Deletion time", decimal_format, &inode.i_dtime);
 	modify_u16(argv[0], "Link count", decimal_format, &inode.i_links_count);
-	modify_u32(argv[0], "Block count", decimal_format, &inode.i_blocks);
+	if (current_fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
+		modify_u32(argv[0], "Block count (fsblocks)", unsignedlong_format, &inode.i_blocks);
+	else
+		modify_u32(argv[0], "Block count", unsignedlong_format, &inode.i_blocks);
 	modify_u32(argv[0], "File flags", hex_format, &inode.i_flags);
 	modify_u32(argv[0], "Generation", hex_format, &inode.i_generation);
 #if 0
diff -uprN e2fsprogs-1.38.org/debugfs/set_fields.c e2fsprogs-1.38-bigfile/debugfs/set_fields.c
--- e2fsprogs-1.38.org/debugfs/set_fields.c	2005-02-04 10:38:52.000000000 +0900
+++ e2fsprogs-1.38-bigfile/debugfs/set_fields.c	2006-02-27 15:55:25.000000000 +0900
@@ -399,6 +399,11 @@ static void print_possible_fields(struct
 		else if (ss->func == parse_bmap)
 			type = "set physical->logical block map";
 		strcpy(name, ss->name);
+
+		if ((current_fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK) &&
+			(fields == inode_fields) && (!strcmp(name, "blocks")))
+				strcat(name, " (fsblocks)");
+
 		if (ss->flags & FLAG_ARRAY) {
 			if (ss->max_idx > 0) 
 				sprintf(idx, "[%d]", ss->max_idx);
diff -uprN e2fsprogs-1.38.org/e2fsck/pass1.c e2fsprogs-1.38-bigfile/e2fsck/pass1.c
--- e2fsprogs-1.38.org/e2fsck/pass1.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-bigfile/e2fsck/pass1.c	2006-02-27 15:55:25.000000000 +0900
@@ -1388,7 +1388,10 @@ static void check_blocks(e2fsck_t ctx, s
 	pb.previous_block = 0;
 	pb.is_dir = LINUX_S_ISDIR(inode->i_mode);
 	pb.is_reg = LINUX_S_ISREG(inode->i_mode);
-	pb.max_blocks = 1 << (31 - fs->super->s_log_block_size);
+	if (fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
+		pb.max_blocks = ((unsigned long)1 << 31) - 1;
+	else
+		pb.max_blocks = 1 << (31 - fs->super->s_log_block_size);
 	pb.inode = inode;
 	pb.pctx = pctx;
 	pb.ctx = ctx;

