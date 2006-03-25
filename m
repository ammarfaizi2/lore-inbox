Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWCYNe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWCYNe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWCYNe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:34:27 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:3508 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751397AbWCYNe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:34:26 -0500
To: pbadari@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-Id: <20060325223430sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 25 Mar 2006 22:34:30 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>
>>More information. I ran the test with "-onoreservation" thinking that
>>the patch didn't address "reservation code" issues and I still ran
>>into block allocation problems. Hope this helps.
>
>As you said, my patches were corrupted because of my poor mailer.
>So, I resend it.
>I ran fsx with them, it wasn't reproduced.

Here is the patch for e2fsprogs.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN e2fsprogs-1.38.org/debugfs/debugfs.c e2fsprogs-1.38-4g/debugfs/debugfs.c
--- e2fsprogs-1.38.org/debugfs/debugfs.c	2005-05-06 22:04:36.000000000 +0900
+++ e2fsprogs-1.38-4g/debugfs/debugfs.c	2006-02-25 19:42:22.000000000 +0900
@@ -301,9 +301,9 @@ void do_show_super_stats(int argc, char 
 	
 	gdp = &current_fs->group_desc[0];
 	for (i = 0; i < current_fs->group_desc_count; i++, gdp++)
-		fprintf(out, " Group %2d: block bitmap at %d, "
-		        "inode bitmap at %d, "
-		        "inode table at %d\n"
+		fprintf(out, " Group %2d: block bitmap at %u, "
+		        "inode bitmap at %u, "
+		        "inode table at %u\n"
 		        "           %d free %s, "
 		        "%d free %s, "
 		        "%d used %s\n",
@@ -351,9 +351,9 @@ static void finish_range(struct list_blo
 	else
 		fprintf(lb->f, ", ");
 	if (lb->first_block == lb->last_block)
-		fprintf(lb->f, "(%lld):%d", lb->first_bcnt, lb->first_block);
+		fprintf(lb->f, "(%lld):%u", lb->first_bcnt, lb->first_block);
 	else
-		fprintf(lb->f, "(%lld-%lld):%d-%d", lb->first_bcnt,
+		fprintf(lb->f, "(%lld-%lld):%u-%u", lb->first_bcnt,
 			lb->last_bcnt, lb->first_block, lb->last_block);
 	lb->first_block = 0;
 }
@@ -395,11 +395,11 @@ static int list_blocks_proc(ext2_filsys 
 	else
 		fprintf(lb->f, ", ");
 	if (blockcnt == -1)
-		fprintf(lb->f, "(IND):%d", *blocknr);
+		fprintf(lb->f, "(IND):%u", *blocknr);
 	else if (blockcnt == -2)
-		fprintf(lb->f, "(DIND):%d", *blocknr);
+		fprintf(lb->f, "(DIND):%u", *blocknr);
 	else if (blockcnt == -3)
-		fprintf(lb->f, "(TIND):%d", *blocknr);
+		fprintf(lb->f, "(TIND):%u", *blocknr);
 	return 0;
 }
 
@@ -431,7 +431,7 @@ void internal_dump_inode_extra(FILE *out
 	int storage_size;
 	int i;
 
-	fprintf(out, "Size of extra inode fields: %d\n", inode->i_extra_isize);
+	fprintf(out, "Size of extra inode fields: %u\n", inode->i_extra_isize);
 	if (inode->i_extra_isize > EXT2_INODE_SIZE(current_fs->super) -
 			EXT2_GOOD_OLD_INODE_SIZE) {
 		fprintf(stderr, "invalid inode->i_extra_isize (%u)\n",
@@ -462,7 +462,7 @@ void internal_dump_inode_extra(FILE *out
 			fprintf(out, " = \"");
 			dump_xattr_string(out, start + entry->e_value_offs,
 						entry->e_value_size);
-			fprintf(out, "\" (%d)\n", entry->e_value_size);
+			fprintf(out, "\" (%u)\n", entry->e_value_size);
 			entry = next;
 		}
 	}
@@ -525,7 +525,7 @@ void internal_dump_inode(FILE *out, cons
 		fprintf(out, "%sFile ACL: %d    Directory ACL: %d\n",
 			prefix,
 			inode->i_file_acl, LINUX_S_ISDIR(inode->i_mode) ? inode->i_dir_acl : 0);
-	fprintf(out, "%sLinks: %d   Blockcount: %d\n", 
+	fprintf(out, "%sLinks: %d   Blockcount: %u\n", 
 		prefix, inode->i_links_count, inode->i_blocks);
 	switch (os) {
 	    case EXT2_OS_LINUX:
@@ -704,7 +704,7 @@ void do_freeb(int argc, char *argv[])
 		return;
 	while (count-- > 0) {
 		if (!ext2fs_test_block_bitmap(current_fs->block_map,block))
-			com_err(argv[0], 0, "Warning: block %d already clear",
+			com_err(argv[0], 0, "Warning: block %u already clear",
 				block);
 		ext2fs_unmark_block_bitmap(current_fs->block_map,block);
 		block++;
@@ -723,7 +723,7 @@ void do_setb(int argc, char *argv[])
 		return;
 	while (count-- > 0) {
 		if (ext2fs_test_block_bitmap(current_fs->block_map,block))
-			com_err(argv[0], 0, "Warning: block %d already set",
+			com_err(argv[0], 0, "Warning: block %u already set",
 				block);
 		ext2fs_mark_block_bitmap(current_fs->block_map,block);
 		block++;
@@ -740,9 +740,9 @@ void do_testb(int argc, char *argv[])
 		return;
 	while (count-- > 0) {
 		if (ext2fs_test_block_bitmap(current_fs->block_map,block))
-			printf("Block %d marked in use\n", block);
+			printf("Block %u marked in use\n", block);
 		else
-			printf("Block %d not in use\n", block);
+			printf("Block %u not in use\n", block);
 		block++;
 	}
 }
@@ -822,6 +822,7 @@ void do_modify_inode(int argc, char *arg
 	const char	*hex_format = "0x%x";
 	const char	*octal_format = "0%o";
 	const char	*decimal_format = "%d";
+	const char	*unsignedlong_format = "%lu";
 	
 	if (common_inode_args_process(argc, argv, &inode_num, CHECK_FS_RW))
 		return;
@@ -834,13 +835,13 @@ void do_modify_inode(int argc, char *arg
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
+	modify_u32(argv[0], "Block count", unsignedlong_format, &inode.i_blocks);
 	modify_u32(argv[0], "File flags", hex_format, &inode.i_flags);
 	modify_u32(argv[0], "Generation", hex_format, &inode.i_generation);
 #if 0
@@ -1151,7 +1152,7 @@ void do_find_free_block(int argc, char *
 			com_err("ext2fs_new_block", retval, "");
 			return;
 		} else
-			printf("%d ", free_blk);
+			printf("%u ", free_blk);
 	}
  	printf("\n");
 }
@@ -1660,10 +1661,10 @@ void do_bmap(int argc, char *argv[])
 	errcode = ext2fs_bmap(current_fs, ino, 0, 0, 0, blk, &pblk);
 	if (errcode) {
 		com_err("argv[0]", errcode,
-			"while mapping logical block %d\n", blk);
+			"while mapping logical block %u\n", blk);
 		return;
 	}
-	printf("%d\n", pblk);
+	printf("%u\n", pblk);
 }
 
 void do_imap(int argc, char *argv[])
diff -uprN e2fsprogs-1.38.org/debugfs/htree.c e2fsprogs-1.38-4g/debugfs/htree.c
--- e2fsprogs-1.38.org/debugfs/htree.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-4g/debugfs/htree.c	2006-02-25 19:41:29.000000000 +0900
@@ -43,14 +43,14 @@ static void htree_dump_leaf_node(ext2_fi
 	errcode = ext2fs_bmap(fs, ino, inode, buf, 0, blk, &pblk);
 	if (errcode) {
 		com_err("htree_dump_leaf_node", errcode,
-			"while mapping logical block %d\n", blk);
+			"while mapping logical block %u\n", blk);
 		return;
 	}
 
 	errcode = ext2fs_read_dir_block2(current_fs, pblk, buf, 0);
 	if (errcode) {
 		com_err("htree_dump_leaf_node", errcode,
-			"while 	reading block %d\n", blk);
+			"while 	reading block %u\n", blk);
 		return;
 	}
 
@@ -60,7 +60,7 @@ static void htree_dump_leaf_node(ext2_fi
 		    (dirent->rec_len < 8) ||
 		    ((dirent->rec_len % 4) != 0) ||
 		    (((dirent->name_len & 0xFF)+8) > dirent->rec_len)) {
-			fprintf(pager, "Corrupted directory block (%d)!\n", blk);
+			fprintf(pager, "Corrupted directory block (%u)!\n", blk);
 			break;
 		}
 		thislen = ((dirent->name_len & 0xFF) < EXT2_NAME_LEN) ?
@@ -124,7 +124,7 @@ static void htree_dump_int_node(ext2_fil
 	for (i=0; i < limit.count; i++) {
 		e.hash = ext2fs_le32_to_cpu(ent[i].hash);
 		e.block = ext2fs_le32_to_cpu(ent[i].block);
-		fprintf(pager, "Entry #%d: Hash 0x%08x, block %d\n", i,
+		fprintf(pager, "Entry #%d: Hash 0x%08x, block %u\n", i,
 		       i ? e.hash : 0, e.block);
 		if (level)
 			htree_dump_int_block(fs, ino, inode, rootnode,
@@ -155,14 +155,14 @@ static void htree_dump_int_block(ext2_fi
 	errcode = ext2fs_bmap(fs, ino, inode, buf, 0, blk, &pblk);
 	if (errcode) {
 		com_err("htree_dump_int_block", errcode,
-			"while mapping logical block %d\n", blk);
+			"while mapping logical block %u\n", blk);
 		return;
 	}
 
 	errcode = io_channel_read_blk(current_fs->io, pblk, 1, buf);
 	if (errcode) {
 		com_err("htree_dump_int_block", errcode,
-			"while 	reading block %d\n", blk);
+			"while 	reading block %u\n", blk);
 		return;
 	}
 
@@ -241,7 +241,7 @@ void do_htree_dump(int argc, char *argv[
 	rootnode = (struct ext2_dx_root_info *) (buf + 24);
 
 	fprintf(pager, "Root node dump:\n");
-	fprintf(pager, "\t Reserved zero: %d\n", rootnode->reserved_zero);
+	fprintf(pager, "\t Reserved zero: %u\n", rootnode->reserved_zero);
 	fprintf(pager, "\t Hash Version: %d\n", rootnode->hash_version);
 	fprintf(pager, "\t Info length: %d\n", rootnode->info_length);
 	fprintf(pager, "\t Indirect levels: %d\n", rootnode->indirect_levels);
@@ -372,9 +372,9 @@ static int search_dir_block(ext2_filsys 
 		    strncmp(p->search_name, dirent->name,
 			    p->len) == 0) {
 			printf("Entry found at logical block %lld, "
-			       "phys %d, offset %d\n", blockcnt,
+			       "phys %u, offset %u\n", blockcnt,
 			       *blocknr, offset);
-			printf("offset %d\n", offset);
+			printf("offset %u\n", offset);
 			return BLOCK_ABORT;
 		}
 		offset += dirent->rec_len;
diff -uprN e2fsprogs-1.38.org/debugfs/unused.c e2fsprogs-1.38-4g/debugfs/unused.c
--- e2fsprogs-1.38.org/debugfs/unused.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-4g/debugfs/unused.c	2006-02-25 19:41:29.000000000 +0900
@@ -45,7 +45,7 @@ void do_dump_unused(int argc EXT2FS_ATTR
 				break;
 		if (i >= current_fs->blocksize)
 			continue;
-		printf("\nUnused block %ld contains non-zero data:\n\n",
+		printf("\nUnused block %lu contains non-zero data:\n\n",
 		       blk);
 		for (i=0; i < current_fs->blocksize; i++)
 			fputc(buf[i], stdout);
diff -uprN e2fsprogs-1.38.org/e2fsck/emptydir.c e2fsprogs-1.38-4g/e2fsck/emptydir.c
--- e2fsprogs-1.38.org/e2fsck/emptydir.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/emptydir.c	2006-02-25 19:41:29.000000000 +0900
@@ -94,7 +94,7 @@ void add_empty_dirblock(empty_dir_info e
 	if (db->ino == 11)
 		return;		/* Inode number 11 is usually lost+found */
 
-	printf(_("Empty directory block %d (#%d) in inode %d\n"),
+	printf(_("Empty directory block %u (#%d) in inode %d\n"),
 	       db->blk, db->blockcnt, db->ino);
 
 	ext2fs_mark_block_bitmap(edi->empty_dir_blocks, db->blk);
diff -uprN e2fsprogs-1.38.org/e2fsck/message.c e2fsprogs-1.38-4g/e2fsck/message.c
--- e2fsprogs-1.38.org/e2fsck/message.c	2005-06-19 22:41:08.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/message.c	2006-02-25 19:41:29.000000000 +0900
@@ -418,7 +418,7 @@ static _INLINE_ void expand_percent_expr
 		print_pathname(fs, ctx->dir, ctx->ino);
 		break;
 	case 'S':
-		printf("%d", get_backup_sb(NULL, fs, NULL, NULL));
+		printf("%u", get_backup_sb(NULL, fs, NULL, NULL));
 		break;
 	case 's':
 		printf("%s", ctx->str ? ctx->str : "NULL");
diff -uprN e2fsprogs-1.38.org/e2fsck/pass1b.c e2fsprogs-1.38-4g/e2fsck/pass1b.c
--- e2fsprogs-1.38.org/e2fsck/pass1b.c	2005-04-15 06:10:12.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/pass1b.c	2006-02-25 19:41:29.000000000 +0900
@@ -555,7 +555,7 @@ static int delete_file_block(ext2_filsys
 			decrement_badcount(ctx, *block_nr, p);
 		} else
 			com_err("delete_file_block", 0,
-			    _("internal error; can't find dup_blk for %d\n"),
+			    _("internal error; can't find dup_blk for %u\n"),
 				*block_nr);
 	} else {
 		ext2fs_unmark_block_bitmap(ctx->block_found_map, *block_nr);
@@ -692,7 +692,7 @@ static int clone_file_block(ext2_filsys 
 			return BLOCK_CHANGED;
 		} else
 			com_err("clone_file_block", 0,
-			    _("internal error; can't find dup_blk for %d\n"),
+			    _("internal error; can't find dup_blk for %u\n"),
 				*block_nr);
 	}
 	return 0;
diff -uprN e2fsprogs-1.38.org/e2fsck/pass2.c e2fsprogs-1.38-4g/e2fsck/pass2.c
--- e2fsprogs-1.38.org/e2fsck/pass2.c	2005-04-15 03:06:09.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/pass2.c	2006-02-25 19:41:29.000000000 +0900
@@ -543,7 +543,7 @@ static void parse_int_node(ext2_filsys f
 		
 #ifdef DX_DEBUG
 		printf("Root node dump:\n");
-		printf("\t Reserved zero: %d\n", root->reserved_zero);
+		printf("\t Reserved zero: %u\n", root->reserved_zero);
 		printf("\t Hash Version: %d\n", root->hash_version);
 		printf("\t Info length: %d\n", root->info_length);
 		printf("\t Indirect levels: %d\n", root->indirect_levels);
@@ -582,7 +582,7 @@ static void parse_int_node(ext2_filsys f
 		prev_hash = hash;
 		hash = i ? (ext2fs_le32_to_cpu(ent[i].hash) & ~1) : 0;
 #ifdef DX_DEBUG
-		printf("Entry #%d: Hash 0x%08x, block %d\n", i,
+		printf("Entry #%d: Hash 0x%08x, block %u\n", i,
 		       hash, ext2fs_le32_to_cpu(ent[i].block));
 #endif
 		blk = ext2fs_le32_to_cpu(ent[i].block) & 0x0ffffff;
diff -uprN e2fsprogs-1.38.org/e2fsck/recovery.c e2fsprogs-1.38-4g/e2fsck/recovery.c
--- e2fsprogs-1.38.org/e2fsck/recovery.c	2003-12-08 02:11:38.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/recovery.c	2006-02-25 19:41:29.000000000 +0900
@@ -435,7 +435,7 @@ static int do_one_pass(journal_t *journa
 					success = err;
 					printk (KERN_ERR 
 						"JBD: IO error %d recovering "
-						"block %ld in log\n",
+						"block %lu in log\n",
 						err, io_block);
 				} else {
 					unsigned long blocknr;
diff -uprN e2fsprogs-1.38.org/e2fsck/unix.c e2fsprogs-1.38-4g/e2fsck/unix.c
--- e2fsprogs-1.38.org/e2fsck/unix.c	2005-06-20 21:35:27.000000000 +0900
+++ e2fsprogs-1.38-4g/e2fsck/unix.c	2006-02-25 19:41:29.000000000 +0900
@@ -98,7 +98,8 @@ static void usage(e2fsck_t ctx)
 static void show_stats(e2fsck_t	ctx)
 {
 	ext2_filsys fs = ctx->fs;
-	int inodes, inodes_used, blocks, blocks_used;
+	int inodes, inodes_used;
+	blk_t blocks, blocks_used;
 	int dir_links;
 	int num_files, num_links;
 	int frag_percent;
@@ -117,7 +118,7 @@ static void show_stats(e2fsck_t	ctx)
 	frag_percent = (frag_percent + 5) / 10;
 	
 	if (!verbose) {
-		printf(_("%s: %d/%d files (%0d.%d%% non-contiguous), %d/%d blocks\n"),
+		printf(_("%s: %d/%d files (%0d.%d%% non-contiguous), %u/%u blocks\n"),
 		       ctx->device_name, inodes_used, inodes,
 		       frag_percent / 10, frag_percent % 10,
 		       blocks_used, blocks);
@@ -131,7 +132,7 @@ static void show_stats(e2fsck_t	ctx)
 		ctx->fs_fragmented, frag_percent / 10, frag_percent % 10);
 	printf (_("         # of inodes with ind/dind/tind blocks: %d/%d/%d\n"),
 		ctx->fs_ind_count, ctx->fs_dind_count, ctx->fs_tind_count);
-	printf (P_("%8d block used (%d%%)\n", "%8d blocks used (%d%%)\n",
+	printf (P_("%8u block used (%d%%)\n", "%8u blocks used (%d%%)\n",
 		   blocks_used),
 		blocks_used, (int) ((long long) 100 * blocks_used / blocks));
 	printf (P_("%8d bad block\n", "%8d bad blocks\n",
@@ -289,7 +290,7 @@ static void check_if_skip(e2fsck_t ctx)
 		fputs(_(", check forced.\n"), stdout);
 		return;
 	}
-	printf(_("%s: clean, %d/%d files, %d/%d blocks"), ctx->device_name,
+	printf(_("%s: clean, %d/%d files, %u/%u blocks"), ctx->device_name,
 	       fs->super->s_inodes_count - fs->super->s_free_inodes_count,
 	       fs->super->s_inodes_count,
 	       fs->super->s_blocks_count - fs->super->s_free_blocks_count,
diff -uprN e2fsprogs-1.38.org/lib/ext2fs/bitops.h e2fsprogs-1.38-4g/lib/ext2fs/bitops.h
--- e2fsprogs-1.38.org/lib/ext2fs/bitops.h	2005-07-01 08:40:17.000000000 +0900
+++ e2fsprogs-1.38-4g/lib/ext2fs/bitops.h	2006-02-25 19:41:29.000000000 +0900
@@ -130,6 +130,7 @@ extern int ext2fs_unmark_generic_bitmap(
 #endif
 #endif
 
+#define _EXT2_USE_C_VERSIONS_
 #if ((defined __GNUC__) && !defined(_EXT2_USE_C_VERSIONS_) && \
      (defined(__i386__) || defined(__i486__) || defined(__i586__)))
 
@@ -264,7 +265,7 @@ _INLINE_ __u16 ext2fs_swab16(__u16 val)
 
 #endif	/* i386 */
 
-#ifdef __mc68000__
+#if (defined(__mc68000__) && !defined(_EXT2_USE_C_VERSIONS_))
 
 #define _EXT2_HAVE_ASM_BITOPS_
 
diff -uprN e2fsprogs-1.38.org/misc/dumpe2fs.c e2fsprogs-1.38-4g/misc/dumpe2fs.c
--- e2fsprogs-1.38.org/misc/dumpe2fs.c	2005-06-20 21:35:27.000000000 +0900
+++ e2fsprogs-1.38-4g/misc/dumpe2fs.c	2006-02-25 19:41:29.000000000 +0900
@@ -244,12 +244,12 @@ static void print_journal_information(ex
 		exit(1);
 	}
 
-	printf(_("\nJournal block size:       %d\n"
-		 "Journal length:           %d\n"
-		 "Journal first block:      %d\n"
+	printf(_("\nJournal block size:       %u\n"
+		 "Journal length:           %u\n"
+		 "Journal first block:      %u\n"
 		 "Journal sequence:         0x%08x\n"
-		 "Journal start:            %d\n"
-		 "Journal number of users:  %d\n"),
+		 "Journal start:            %u\n"
+		 "Journal number of users:  %lu\n"),
 	       ntohl(jsb->s_blocksize),  ntohl(jsb->s_maxlen),
 	       ntohl(jsb->s_first), ntohl(jsb->s_sequence),
 	       ntohl(jsb->s_start), ntohl(jsb->s_nr_users));
diff -uprN e2fsprogs-1.38.org/misc/e2image.c e2fsprogs-1.38-4g/misc/e2image.c
--- e2fsprogs-1.38.org/misc/e2image.c	2005-01-27 01:37:46.000000000 +0900
+++ e2fsprogs-1.38-4g/misc/e2image.c	2006-02-25 19:41:29.000000000 +0900
@@ -329,7 +329,7 @@ static void write_block(int fd, char *bu
 				err = errno;
 			else
 				err = 0;
-			com_err(program_name, err, "error writing block %d", 
+			com_err(program_name, err, "error writing block %u", 
 				block);
 		}
 	}
diff -uprN e2fsprogs-1.38.org/misc/findsuper.c e2fsprogs-1.38-4g/misc/findsuper.c
--- e2fsprogs-1.38.org/misc/findsuper.c	2005-06-20 21:35:27.000000000 +0900
+++ e2fsprogs-1.38-4g/misc/findsuper.c	2006-02-25 19:41:29.000000000 +0900
@@ -182,15 +182,15 @@ int main(int argc, char *argv[])
 		if (ext2.s_magic != EXT2_SUPER_MAGIC)
 			continue;
 		if (ext2.s_log_block_size > 4)
-			WHY("log block size > 4 (%d)\n", ext2.s_log_block_size);
+			WHY("log block size > 4 (%u)\n", ext2.s_log_block_size);
 		if (ext2.s_r_blocks_count > ext2.s_blocks_count)
-			WHY("r_blocks_count > blocks_count (%d > %d)\n",
+			WHY("r_blocks_count > blocks_count (%u > %u)\n",
 			    ext2.s_r_blocks_count, ext2.s_blocks_count);
 		if (ext2.s_free_blocks_count > ext2.s_blocks_count)
-			WHY("free_blocks_count > blocks_count\n (%d > %d)\n",
+			WHY("free_blocks_count > blocks_count\n (%u > %u)\n",
 			    ext2.s_free_blocks_count, ext2.s_blocks_count);
 		if (ext2.s_free_inodes_count > ext2.s_inodes_count)
-			WHY("free_inodes_count > inodes_count (%d > %d)\n",
+			WHY("free_inodes_count > inodes_count (%u > %u)\n",
 			    ext2.s_free_inodes_count, ext2.s_inodes_count);
 
 		tm = ext2.s_mtime;
diff -uprN e2fsprogs-1.38.org/misc/mke2fs.c e2fsprogs-1.38-4g/misc/mke2fs.c
--- e2fsprogs-1.38.org/misc/mke2fs.c	2005-07-01 09:00:40.000000000 +0900
+++ e2fsprogs-1.38-4g/misc/mke2fs.c	2006-02-25 19:41:29.000000000 +0900
@@ -302,7 +302,7 @@ static void handle_bad_blocks(ext2_filsy
 		if (ext2fs_badblocks_list_test(bb_list, i)) {
 			fprintf(stderr, _("Block %d in primary "
 				"superblock/group descriptor area bad.\n"), i);
-			fprintf(stderr, _("Blocks %d through %d must be good "
+			fprintf(stderr, _("Blocks %u through %d must be good "
 				"in order to build a filesystem.\n"),
 				fs->super->s_first_data_block, must_be_good);
 			fputs(_("Aborting....\n"), stderr);
@@ -325,7 +325,7 @@ static void handle_bad_blocks(ext2_filsy
 						       group_block + j)) {
 				if (!group_bad) 
 					fprintf(stderr,
-_("Warning: the backup superblock/group descriptors at block %d contain\n"
+_("Warning: the backup superblock/group descriptors at block %u contain\n"
 "	bad blocks.\n\n"),
 						group_block);
 				group_bad++;
@@ -489,7 +489,7 @@ static void write_inode_tables(ext2_fils
 		retval = zero_blocks(fs, blk, num, 0, &blk, &num);
 		if (retval) {
 			fprintf(stderr, _("\nCould not write %d blocks "
-				"in inode table starting at %d: %s\n"),
+				"in inode table starting at %u: %s\n"),
 				num, blk, error_message(retval));
 			exit(1);
 		}
@@ -692,7 +692,7 @@ static void show_stats(ext2_filsys fs)
 	int			need, col_left;
 	
 	if (param.s_blocks_count != s->s_blocks_count)
-		fprintf(stderr, _("warning: %d blocks unused.\n\n"),
+		fprintf(stderr, _("warning: %u blocks unused.\n\n"),
 		       param.s_blocks_count - s->s_blocks_count);
 
 	memset(buf, 0, sizeof(buf));
diff -uprN e2fsprogs-1.38.org/resize/main.c e2fsprogs-1.38-4g/resize/main.c
--- e2fsprogs-1.38.org/resize/main.c	2005-05-10 05:22:17.000000000 +0900
+++ e2fsprogs-1.38-4g/resize/main.c	2006-02-25 19:41:29.000000000 +0900
@@ -276,13 +276,13 @@ int main (int argc, char ** argv)
 	}
 	if (!force && (new_size > max_size)) {
 		fprintf(stderr, _("The containing partition (or device)"
-			" is only %d (%dk) blocks.\nYou requested a new size"
-			" of %d blocks.\n\n"), max_size,
+			" is only %u (%dk) blocks.\nYou requested a new size"
+			" of %u blocks.\n\n"), max_size,
 			fs->blocksize / 1024, new_size);
 		exit(1);
 	}
 	if (new_size == fs->super->s_blocks_count) {
-		fprintf(stderr, _("The filesystem is already %d blocks "
+		fprintf(stderr, _("The filesystem is already %u blocks "
 			"long.  Nothing to do!\n\n"), new_size);
 		exit(0);
 	}
@@ -293,7 +293,7 @@ int main (int argc, char ** argv)
 			device_name);
 		exit(1);
 	}
-	printf("Resizing the filesystem on %s to %d (%dk) blocks.\n",
+	printf("Resizing the filesystem on %s to %u (%dk) blocks.\n",
 	       device_name, new_size, fs->blocksize / 1024);
 	retval = resize_fs(fs, &new_size, flags,
 			   ((flags & RESIZE_PERCENT_COMPLETE) ?
@@ -304,7 +304,7 @@ int main (int argc, char ** argv)
 		ext2fs_close (fs);
 		exit(1);
 	}
-	printf(_("The filesystem on %s is now %d blocks long.\n\n"),
+	printf(_("The filesystem on %s is now %u blocks long.\n\n"),
 	       device_name, new_size);
 	return (0);
 }
diff -uprN e2fsprogs-1.38.org/resize/resize2fs.c e2fsprogs-1.38-4g/resize/resize2fs.c
--- e2fsprogs-1.38.org/resize/resize2fs.c	2005-05-10 05:22:17.000000000 +0900
+++ e2fsprogs-1.38-4g/resize/resize2fs.c	2006-02-25 19:41:29.000000000 +0900
@@ -108,7 +108,7 @@ errcode_t resize_fs(ext2_filsys fs, blk_
 
 #ifdef RESIZE2FS_DEBUG
 	if (rfs->flags & RESIZE_DEBUG_BMOVE)
-		printf("Number of free blocks: %d/%d, Needed: %d\n",
+		printf("Number of free blocks: %u/%u, Needed: %d\n",
 		       rfs->old_fs->super->s_free_blocks_count,
 		       rfs->new_fs->super->s_free_blocks_count,
 		       rfs->needed_blocks);

