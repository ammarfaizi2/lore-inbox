Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWEYNAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWEYNAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWEYNAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:00:44 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:38873 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965162AbWEYNAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:00:43 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][24/24]ext2resize modify format strings
Message-Id: <20060525220034sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 22:00:34 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [24/24] modify format strings in print
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr ext2resize-1.1.19/src/ext2.c ext2resize-1.1.19.tmp/src/ext2.c
--- ext2resize-1.1.19/src/ext2.c	2006-05-15 18:28:38.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2.c	2006-05-15 18:30:29.000000000 +0900
@@ -405,7 +405,7 @@ int ext2_block_iterate(struct ext2_fs *f
 			if (udata2[j] == block) {
 				if (action == EXT2_ACTION_DELETE) {
 					if (fs->flags & FL_DEBUG)
-						printf("del %d from dind %d\n",
+						printf("del %u from dind %d\n",
 						       curblock, udata[i]);
 					bh2->dirty = 1;
 					udata2[j] = 0;
@@ -692,15 +692,15 @@ static int ext2_determine_itoffset(struc
 
 		if (fs->gd[group].bg_block_bitmap != bb && fs->flags & FL_DEBUG)
 			fprintf(stderr,
-				"group %d block bitmap has offset %d, not %d\n",
+				"group %d block bitmap has offset %u, not %llu\n",
 				group, fs->gd[group].bg_block_bitmap, bb);
 		if (fs->gd[group].bg_inode_bitmap != ib && fs->flags & FL_DEBUG)
 			fprintf(stderr,
-				"group %d inode bitmap has offset %d, not %d\n",
+				"group %d inode bitmap has offset %u, not %u\n",
 				group, fs->gd[group].bg_inode_bitmap, ib);
 		if (fs->gd[group].bg_inode_table != it) {
 			fprintf(stderr,
-				"group %d inode table has offset %d, not %d\n",
+				"group %d inode table has offset %llu, not %llu\n",
 				group, fs->gd[group].bg_inode_table-start,
 				it-start);
 			/*
@@ -921,7 +921,7 @@ struct ext2_fs *ext2_open(struct ext2_de
 	}
 
 	if (fs->flags & FL_VERBOSE)
-		printf("new filesystem size %d\n", newblocks);
+		printf("new filesystem size %llu\n", newblocks);
 
 	fs->numgroups = howmany((blk64_t)fs->sb.s_blocks_count -
 				fs->sb.s_first_data_block,
@@ -951,8 +951,8 @@ struct ext2_fs *ext2_open(struct ext2_de
 	residue = (newblocks - fs->sb.s_first_data_block) %
 		fs->sb.s_blocks_per_group;
 	if (residue && residue <= fs->inodeblocks + fs->gdblocks + 50) {
-		fprintf(stderr, "%s: %i is a bad size for an ext2 fs! "
-			"rounding down to %i\n",
+		fprintf(stderr, "%s: %lli is a bad size for an ext2 fs! "
+			"rounding down to %lli\n",
 			fs->prog, newblocks, newblocks - residue);
 		newblocks -= residue;
 	}
diff -upNr ext2resize-1.1.19/src/ext2_block_relocator.c ext2resize-1.1.19.tmp/src/ext2_block_relocator.c
--- ext2resize-1.1.19/src/ext2_block_relocator.c	2006-05-15 18:28:38.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_block_relocator.c	2006-05-15 18:30:29.000000000 +0900
@@ -648,8 +648,8 @@ static int ext2_block_relocate_grow(stru
 	inode->i_mtime = 0;
 	state->newallocoffset = newitoffset + fs->inodeblocks;
 	if (fs->flags & FL_DEBUG)
-		printf("moving data (oldgdblocks %d+%d, newgdblocks %d, "
-		       "olditoffset %d, newitoffset %d, newallocoffset %d)\n",
+		printf("moving data (oldgdblocks %u+%u, newgdblocks %u, "
+		       "olditoffset %d, newitoffset %d, newallocoffset %u)\n",
 		       fs->gdblocks, fs->resgdblocks, fs->newgdblocks,
 		       fs->itoffset, newitoffset, state->newallocoffset);
 
@@ -694,26 +694,26 @@ static int ext2_block_relocate_grow(stru
 		 */
 		if (has_sb) {
 			if (fs->flags & FL_DEBUG)
-				printf("new gd table: start=%d, end=%d\n",
+				printf("new gd table: start=%u, end=%u\n",
 				       start + 1, start + fs->newgdblocks);
 			for (j = fs->gdblocks + 1; j <= fs->newgdblocks; j++) {
 				if (j == bb || j == ib) {
 					need_reloc = 1;
 					if (fs->flags & FL_DEBUG)
-						printf("skip bitmap %d\n",
+						printf("skip bitmap %u\n",
 						       start + j);
 					continue;
 				}
 				if (j >= olditoffset && j < olditend) {
 					if (fs->flags & FL_DEBUG)
-						printf("skip inode table %d\n",
+						printf("skip inode table %u\n",
 						       start + j);
 					continue;
 				}
 				if (ext2_block_iterate(fs, inode, start + j,
 						       EXT2_ACTION_FIND) >= 0) {
 					if (fs->flags & FL_DEBUG)
-						printf("skip reserved %d\n",
+						printf("skip reserved %u\n",
 						       start + j);
 					continue;
 				}
@@ -724,7 +724,7 @@ static int ext2_block_relocate_grow(stru
 					ext2_brelse(bh, 0);
 					return 0;
 				} else if (fs->flags & FL_DEBUG)
-					printf("relocating block %d for GDT\n",
+					printf("relocating block %u for GDT\n",
 					       start + j);
 			}
 		}
@@ -738,12 +738,12 @@ static int ext2_block_relocate_grow(stru
 		 * inode table (don't mark old inode or block birmaps).
 		 */
 		if (fs->flags & FL_DEBUG)
-			printf("inode table: old=%d, new=%d\n",
+			printf("inode table: old=%u, new=%u\n",
 			       fs->gd[group].bg_inode_table,
 			       start + newitoffset);
 		for (j = newitoffset; j < newitend; j++) {
 			if (fs->flags & FL_DEBUG)
-				printf("check new inode table %d\n", j + start);
+				printf("check new inode table %u\n", j + start);
 			if (j < olditend || j == bb || j == ib ||
 			    j == new_bb || j == new_ib)
 				continue;
@@ -753,14 +753,14 @@ static int ext2_block_relocate_grow(stru
 				ext2_brelse(bh, 0);
 				return 0;
 			} else if (fs->flags & FL_DEBUG)
-				printf("relocating block %d for itable\n",
+				printf("relocating block %u for itable\n",
 				       start + j);
 		}
 		/* Mark blocks for relocation that fall under the new inode
 		 * or block bitmaps.
 		 */
 		if (fs->flags & FL_DEBUG)
-			printf("checking bb: old %d, new %d\n", start + bb,
+			printf("checking bb: old %u, new %u\n", start + bb,
 			       start + new_bb);
 		if (new_bb != bb && new_bb != ib &&
 		    (new_bb < olditoffset || new_bb >= olditend) &&
@@ -769,10 +769,10 @@ static int ext2_block_relocate_grow(stru
 				ext2_brelse(bh, 0);
 				return 0;
 			} else if (fs->flags & FL_DEBUG)
-				printf("relocating block %d for bb\n", start+j);
+				printf("relocating block %u for bb\n", start+j);
 		}
 		if (fs->flags & FL_DEBUG)
-			printf("checking ib: old %d, new %d\n", start + ib,
+			printf("checking ib: old %u, new %u\n", start + ib,
 			       start + new_ib);
 		if (new_ib != ib && new_ib != bb &&
 		    (new_ib < olditoffset || new_ib >= olditend) &&
@@ -781,7 +781,7 @@ static int ext2_block_relocate_grow(stru
 				ext2_brelse(bh, 0);
 				return 0;
 			} else if (fs->flags & FL_DEBUG)
-				printf("relocating block %d for ib\n", start+j);
+				printf("relocating block %u for ib\n", start+j);
 		}
 
 		ext2_brelse(bh, 0);
@@ -848,7 +848,7 @@ static int ext2_block_relocate_shrink(st
 			/* group is partly chopped off */
 			begin = fs->newblocks - start;
 			if (fs->flags & FL_DEBUG)
-				printf("will truncate group %d at %d blocks\n",
+				printf("will truncate group %d at %u blocks\n",
 				       group, begin);
 
 			/* FIXME need to handle case where RAID bitmaps are
@@ -866,7 +866,7 @@ static int ext2_block_relocate_shrink(st
 				if (delgrp)
 					continue;
 				fprintf(stderr, 
-					"%s: trying to move block %d in itable!\n",
+					"%s: trying to move block %llu in itable!\n",
 					__FUNCTION__,
 					j + start);
 				return 0;
@@ -878,7 +878,7 @@ static int ext2_block_relocate_shrink(st
 				if (delgrp)
 					continue;
 				if (fs->flags & FL_DEBUG)
-					printf("moving RAID %s bitmap at %d\n",
+					printf("moving RAID %s bitmap at %llu\n",
 					       j==bb ?"block":"inode", start+j);
 				if (check_bit(bh->data, new) &&
 				    !ext2_block_relocator_mark(fs, state,
diff -upNr ext2resize-1.1.19/src/ext2_buffer.c ext2resize-1.1.19.tmp/src/ext2_buffer.c
--- ext2resize-1.1.19/src/ext2_buffer.c	2006-05-15 18:28:23.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_buffer.c	2006-05-15 18:30:29.000000000 +0900
@@ -333,7 +333,7 @@ void ext2_bcache_sync(struct ext2_fs *fs
 	for (i = 0, bh = fs->bc->heads; i < fs->bc->size; i++, bh++) {
 		if (bh->dirty) {
 			if (fs->flags & FL_VERBOSE)
-				printf("   ...flushing buffer %d/block %d\r",
+				printf("   ...flushing buffer %d/block %u\r",
 				       i, bh->block);
 			ext2_bh_do_write(bh);
 		}
diff -upNr ext2resize-1.1.19/src/ext2_meta.c ext2resize-1.1.19.tmp/src/ext2_meta.c
--- ext2resize-1.1.19/src/ext2_meta.c	2006-05-15 18:28:33.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_meta.c	2006-05-15 18:30:29.000000000 +0900
@@ -133,8 +133,8 @@ int ext2_metadata_push(struct ext2_fs *f
 		new_ib = (new_bb + 1 >= bpg) ? new_itend : new_bb + 1;
 
 		if (fs->flags & FL_DEBUG)
-			printf("moving group %d (bb %d/%d, ib %d/%d, "
-			       "itend %d/%d)\n", group, start + bb,
+			printf("moving group %d (bb %u/%u, ib %u/%u, "
+			       "itend %u/%u)\n", group, start + bb,
 			       start + new_bb, start + ib, start + new_ib,
 			       start + old_itend, start + new_itend);
 
diff -upNr ext2resize-1.1.19/src/ext2_resize.c ext2resize-1.1.19.tmp/src/ext2_resize.c
--- ext2resize-1.1.19/src/ext2_resize.c	2006-05-15 18:28:38.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_resize.c	2006-05-15 18:30:29.000000000 +0900
@@ -115,7 +115,7 @@ static int ext2_add_group(struct ext2_fs
 	fs->metadirty |= EXT2_META_GD;
 
 	if (fs->flags & FL_DEBUG)
-		printf("group %d %s: bb %d (+%d), ib %d (+%d), it %d (+%d)\n",
+		printf("group %d %s: bb %u (+%u), ib %u (+%u), it %u (+%d)\n",
 		       group, has_sb ? "has sb" : "no sb",
 		       fs->gd[group].bg_block_bitmap, new_bb,
 		       fs->gd[group].bg_inode_bitmap, new_ib,
@@ -125,7 +125,7 @@ static int ext2_add_group(struct ext2_fs
 
 	if (has_sb) {
 		if (fs->flags & FL_DEBUG)
-			printf ("mark backup superblock and %d gdblocks used\n",
+			printf ("mark backup superblock and %u gdblocks used\n",
 				fs->gdblocks);
 		for (i = 0; i <= fs->gdblocks; i++)
 			set_bit(bh->data, i);
@@ -177,7 +177,7 @@ static int ext2_del_group(struct ext2_fs
 
 	if (fs->sb.s_free_blocks_count < bpg - admin) {
 		fprintf(stderr, "%s: filesystem is too full to remove a group "
-			"(%d used blocks)!\n",
+			"(%u used blocks)!\n",
 			fs->prog,
 			fs->sb.s_blocks_count - fs->sb.s_free_blocks_count);
 
@@ -186,7 +186,7 @@ static int ext2_del_group(struct ext2_fs
 
 	if (fs->sb.s_free_inodes_count < fs->sb.s_inodes_per_group) {
 		fprintf(stderr, "%s: filesystem has too many used inodes "
-			"to remove a group (%d used inodes)!\n",
+			"to remove a group (%u used inodes)!\n",
 			fs->prog,
 			fs->sb.s_inodes_count - fs->sb.s_free_inodes_count);
 		return 0;
@@ -195,7 +195,7 @@ static int ext2_del_group(struct ext2_fs
 	if (fs->gd[group].bg_free_inodes_count != fs->sb.s_inodes_per_group) {
 		/* This should not happen anymore */
 		fprintf(stderr,
-			"%s: free inodes != inodes_per_group (%d != %d)!\n",
+			"%s: free inodes != inodes_per_group (%u != %u)!\n",
 			fs->prog, fs->gd[group].bg_free_inodes_count,
 			fs->sb.s_inodes_per_group);
 
@@ -415,8 +415,8 @@ static int ext2_shrink_fs(struct ext2_fs
 	if (fs->sb.s_blocks_count - fs->sb.s_free_blocks_count + fs->itoffset >
 	    fs->newblocks) {
 		fprintf(stderr,
-			"%s: filesystem is too full to resize to %d blocks.\n"
-			"Try resizing it to a larger size first, like %d\n",
+			"%s: filesystem is too full to resize to %u blocks.\n"
+			"Try resizing it to a larger size first, like %u\n",
 			fs->prog, fs->newblocks,
 			fs->sb.s_blocks_count - fs->sb.s_free_blocks_count +
 			fs->itoffset);
@@ -427,7 +427,7 @@ static int ext2_shrink_fs(struct ext2_fs
 	    fs->newgroups * fs->sb.s_inodes_per_group) {
 		fprintf(stderr,
 			"%s: filesystem has too many used inodes to resize"
-			"to %i blocks.\n", fs->prog, fs->newblocks);
+			"to %u blocks.\n", fs->prog, fs->newblocks);
 		return 0;
 	}
 
diff -upNr ext2resize-1.1.19/src/ext2online.c ext2resize-1.1.19.tmp/src/ext2online.c
--- ext2resize-1.1.19/src/ext2online.c	2006-05-15 18:28:38.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2online.c	2006-05-15 18:30:29.000000000 +0900
@@ -204,7 +204,7 @@ static int ext2_check_one_iterate(struct
 
 		for (block = fs->gdblocks; block < fs->newgdblocks; block++) {
 			if (fs->flags & FL_DEBUG)
-				printf("checking for group block %d in Bond\n",
+				printf("checking for group block %u in Bond\n",
 				       gdb + block);
 
 			if (ext2_block_iterate(fs, &fs->resize, gdb + block,
@@ -240,7 +240,7 @@ static int ext2_check_one_rsv(struct ext
 		int last = 0;
 
 		if (dindir_buf[gdb_num % apb] != pri_blk) {
-			fprintf(stderr, "found %d not %d at %d[%d]\n",
+			fprintf(stderr, "found %u not %u at %u[%d]\n",
 				dindir_buf[gdb_num % apb], pri_blk,
 				fs->resize.i_block[EXT2_DIND_BLOCK],
 				gdb_num % apb);
@@ -258,10 +258,10 @@ static int ext2_check_one_rsv(struct ext
 			bku_blk = pri_blk + group * fs->sb.s_blocks_per_group;
 
 			if (fs->flags & FL_DEBUG)
-				printf("checking for group block %d in Bond\n",
+				printf("checking for group block %u in Bond\n",
 				       bku_blk);
 			if (pri_buf[last] != bku_blk) {
-				fprintf(stderr, "found %d not %d at %d[%d]\n",
+				fprintf(stderr, "found %u not %u at %u[%d]\n",
 					pri_buf[last], bku_blk, pri_blk, last);
 				ext2_brelse(pri_bh, 0);
 				ret = 0;
@@ -366,7 +366,7 @@ static blk_t ext2_make_group(struct ext2
 		       fs->gd[group].bg_inode_table + fs->inodeblocks - 1);
 		printf("new group has %d free blocks\n",
 		       fs->gd[group].bg_free_blocks_count);
-		printf("new group has %d free inodes (%d blocks)\n",
+		printf("new group has %d free inodes (%u blocks)\n",
 		       fs->gd[group].bg_free_inodes_count, fs->inodeblocks);
 	}
 
@@ -440,8 +440,8 @@ static blk_t ext2_make_group(struct ext2
 
 	/* Mark unavailable blocks at end of group used */
 	if (fs->flags & FL_DEBUG && bpg != fs->blocksize * 8)
-		printf("mark end blocks 0x%04x-0x%04x used\n",
-			start + bpg, start + fs->blocksize * 8 - 1);
+		printf("mark end blocks 0x%04x-0x%04llx used\n",
+			start + bpg, (blk64_t)start + fs->blocksize * 8 - 1);
 
 	for (i = bpg; i < fs->blocksize * 8; i++)
 		set_bit(bh->data, i);
@@ -482,9 +482,9 @@ static blk_t ext2_online_primary(struct 
 		return fs->newblocks;
 
 	if (fs->flags & FL_DEBUG) {
-		printf("\n%d old groups, %d blocks\n", fs->numgroups,
+		printf("\n%d old groups, %u blocks\n", fs->numgroups,
 			fs->gdblocks);
-		printf("%d new groups, %d blocks\n", fs->newgroups,
+		printf("%d new groups, %u blocks\n", fs->newgroups,
 			fs->newgdblocks);
 	}
 
diff -upNr ext2resize-1.1.19/src/ext2prepare.c ext2resize-1.1.19.tmp/src/ext2prepare.c
--- ext2resize-1.1.19/src/ext2prepare.c	2006-05-15 18:28:35.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2prepare.c	2006-05-15 18:30:29.000000000 +0900
@@ -299,7 +299,7 @@ int main(int argc, char *argv[])
 			fs->newblocks -= fs->sb.s_blocks_per_group;
 		}
 		fprintf(stderr,
-		       "%s: can't prepare for filesystem over %d blocks\n"
+		       "%s: can't prepare for filesystem over %u blocks\n"
 		       "\tuntil the current filesystem grows larger.\n",
 		       progname, fs->newblocks);
 		return 1;



