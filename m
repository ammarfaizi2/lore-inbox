Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJEP5S>; Sat, 5 Oct 2002 11:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbSJEP5Q>; Sat, 5 Oct 2002 11:57:16 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:18917 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S262386AbSJEP44>; Sat, 5 Oct 2002 11:56:56 -0400
Message-ID: <3D9F0D49.4090006@quark.didntduck.org>
Date: Sat, 05 Oct 2002 12:03:21 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - hpfs
Content-Type: multipart/mixed;
 boundary="------------080803080900070707000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080803080900070707000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove hpfs_sb from struct super_block.

--
				Brian Gerst

--------------080803080900070707000102
Content-Type: text/plain;
 name="sb-hpfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-hpfs-1"

diff -urN linux-2.5.40-bk3/fs/hpfs/alloc.c linux/fs/hpfs/alloc.c
--- linux-2.5.40-bk3/fs/hpfs/alloc.c	Sun Sep 15 22:18:22 2002
+++ linux/fs/hpfs/alloc.c	Sat Oct  5 11:24:03 2002
@@ -24,8 +24,8 @@
 		goto fail1;
 	}
 	hpfs_brelse4(&qbh);
-	if (sec >= s->s_hpfs_dirband_start && sec < s->s_hpfs_dirband_start + s->s_hpfs_dirband_size) {
-		unsigned ssec = (sec - s->s_hpfs_dirband_start) / 4;
+	if (sec >= hpfs_sb(s)->sb_dirband_start && sec < hpfs_sb(s)->sb_dirband_start + hpfs_sb(s)->sb_dirband_size) {
+		unsigned ssec = (sec - hpfs_sb(s)->sb_dirband_start) / 4;
 		if (!(bmp = hpfs_map_dnode_bitmap(s, &qbh))) goto fail;
 		if ((bmp[ssec >> 5] >> (ssec & 0x1f)) & 1) {
 			hpfs_error(s, "sector '%s' - %08x not allocated in directory bitmap", msg, sec);
@@ -48,11 +48,11 @@
 int hpfs_chk_sectors(struct super_block *s, secno start, int len, char *msg)
 {
 	if (start + len < start || start < 0x12 ||
-	    start + len > s->s_hpfs_fs_size) {
+	    start + len > hpfs_sb(s)->sb_fs_size) {
 	    	hpfs_error(s, "sector(s) '%s' badly placed at %08x", msg, start);
 		return 1;
 	}
-	if (s->s_hpfs_chk>=2) {
+	if (hpfs_sb(s)->sb_chk>=2) {
 		int i;
 		for (i = 0; i < len; i++)
 			if (chk_if_allocated(s, start + i, msg)) return 1;
@@ -127,7 +127,7 @@
 	}
 	rt:
 	if (ret) {
-		if (s->s_hpfs_chk && ((ret >> 14) != (bs >> 14) || (bmp[(ret & 0x3fff) >> 5] | ~(((1 << n) - 1) << (ret & 0x1f))) != 0xffffffff)) {
+		if (hpfs_sb(s)->sb_chk && ((ret >> 14) != (bs >> 14) || (bmp[(ret & 0x3fff) >> 5] | ~(((1 << n) - 1) << (ret & 0x1f))) != 0xffffffff)) {
 			hpfs_error(s, "Allocation doesn't work! Wanted %d, allocated at %08x", n, ret);
 			ret = 0;
 			goto b;
@@ -155,14 +155,15 @@
 	secno sec;
 	unsigned i;
 	unsigned n_bmps;
-	int b = s->s_hpfs_c_bitmap;
+	struct hpfs_sb_info *sbi = hpfs_sb(s);
+	int b = sbi->sb_c_bitmap;
 	int f_p = 0;
 	if (forward < 0) {
 		forward = -forward;
 		f_p = 1;
 	}
 	if (lock) hpfs_lock_creation(s);
-	if (near && near < s->s_hpfs_fs_size)
+	if (near && near < sbi->sb_fs_size)
 		if ((sec = alloc_in_bmp(s, near, n, f_p ? forward : forward/4))) goto ret;
 	if (b != -1) {
 		if ((sec = alloc_in_bmp(s, b<<14, n, f_p ? forward : forward/2))) {
@@ -171,25 +172,25 @@
 		}
 		if (b > 0x10000000) if ((sec = alloc_in_bmp(s, (b&0xfffffff)<<14, n, f_p ? forward : 0))) goto ret;
 	}	
-	n_bmps = (s->s_hpfs_fs_size + 0x4000 - 1) >> 14;
+	n_bmps = (sbi->sb_fs_size + 0x4000 - 1) >> 14;
 	for (i = 0; i < n_bmps / 2; i++) {
 		if ((sec = alloc_in_bmp(s, (n_bmps/2+i) << 14, n, forward))) {
-			s->s_hpfs_c_bitmap = n_bmps/2+i;
+			sbi->sb_c_bitmap = n_bmps/2+i;
 			goto ret;
 		}	
 		if ((sec = alloc_in_bmp(s, (n_bmps/2-i-1) << 14, n, forward))) {
-			s->s_hpfs_c_bitmap = n_bmps/2-i-1;
+			sbi->sb_c_bitmap = n_bmps/2-i-1;
 			goto ret;
 		}
 	}
 	if ((sec = alloc_in_bmp(s, (n_bmps-1) << 14, n, forward))) {
-		s->s_hpfs_c_bitmap = n_bmps-1;
+		sbi->sb_c_bitmap = n_bmps-1;
 		goto ret;
 	}
 	if (!f_p) {
 		for (i = 0; i < n_bmps; i++)
 			if ((sec = alloc_in_bmp(s, i << 14, n, 0))) {
-				s->s_hpfs_c_bitmap = 0x10000000 + i;
+				sbi->sb_c_bitmap = 0x10000000 + i;
 				goto ret;
 			}
 	}
@@ -212,17 +213,18 @@
 {
 	unsigned nr = near;
 	secno sec;
-	if (nr < s->s_hpfs_dirband_start)
-		nr = s->s_hpfs_dirband_start;
-	if (nr >= s->s_hpfs_dirband_start + s->s_hpfs_dirband_size)
-		nr = s->s_hpfs_dirband_start + s->s_hpfs_dirband_size - 4;
-	nr -= s->s_hpfs_dirband_start;
+	struct hpfs_sb_info *sbi = hpfs_sb(s);
+	if (nr < sbi->sb_dirband_start)
+		nr = sbi->sb_dirband_start;
+	if (nr >= sbi->sb_dirband_start + sbi->sb_dirband_size)
+		nr = sbi->sb_dirband_start + sbi->sb_dirband_size - 4;
+	nr -= sbi->sb_dirband_start;
 	nr >>= 2;
 	if (lock) hpfs_lock_creation(s);
 	sec = alloc_in_bmp(s, (~0x3fff) | nr, 1, 0);
 	if (lock) hpfs_unlock_creation(s);
 	if (!sec) return 0;
-	return ((sec & 0x3fff) << 2) + s->s_hpfs_dirband_start;
+	return ((sec & 0x3fff) << 2) + sbi->sb_dirband_start;
 }
 
 /* Alloc sector if it's free */
@@ -303,8 +305,8 @@
 
 int hpfs_check_free_dnodes(struct super_block *s, int n)
 {
-	int n_bmps = (s->s_hpfs_fs_size + 0x4000 - 1) >> 14;
-	int b = s->s_hpfs_c_bitmap & 0x0fffffff;
+	int n_bmps = (hpfs_sb(s)->sb_fs_size + 0x4000 - 1) >> 14;
+	int b = hpfs_sb(s)->sb_c_bitmap & 0x0fffffff;
 	int i, j;
 	unsigned *bmp;
 	struct quad_buffer_head qbh;
@@ -320,7 +322,7 @@
 	}
 	hpfs_brelse4(&qbh);
 	i = 0;
-	if (s->s_hpfs_c_bitmap != -1 ) {
+	if (hpfs_sb(s)->sb_c_bitmap != -1 ) {
 		bmp = hpfs_map_bitmap(s, b, &qbh, "chkdn1");
 		goto chk_bmp;
 	}
@@ -349,17 +351,17 @@
 
 void hpfs_free_dnode(struct super_block *s, dnode_secno dno)
 {
-	if (s->s_hpfs_chk) if (dno & 3) {
+	if (hpfs_sb(s)->sb_chk) if (dno & 3) {
 		hpfs_error(s, "hpfs_free_dnode: dnode %08x not aligned", dno);
 		return;
 	}
-	if (dno < s->s_hpfs_dirband_start ||
-	    dno >= s->s_hpfs_dirband_start + s->s_hpfs_dirband_size) {
+	if (dno < hpfs_sb(s)->sb_dirband_start ||
+	    dno >= hpfs_sb(s)->sb_dirband_start + hpfs_sb(s)->sb_dirband_size) {
 		hpfs_free_sectors(s, dno, 4);
 	} else {
 		struct quad_buffer_head qbh;
 		unsigned *bmp;
-		unsigned ssec = (dno - s->s_hpfs_dirband_start) / 4;
+		unsigned ssec = (dno - hpfs_sb(s)->sb_dirband_start) / 4;
 		lock_super(s);
 		if (!(bmp = hpfs_map_dnode_bitmap(s, &qbh))) {
 			unlock_super(s);
@@ -377,7 +379,7 @@
 			 int lock)
 {
 	struct dnode *d;
-	if (hpfs_count_one_bitmap(s, s->s_hpfs_dmap) > FREE_DNODES_ADD) {
+	if (hpfs_count_one_bitmap(s, hpfs_sb(s)->sb_dmap) > FREE_DNODES_ADD) {
 		if (!(*dno = alloc_in_dirband(s, near, lock)))
 			if (!(*dno = hpfs_alloc_sector(s, near, 4, 0, lock))) return NULL;
 	} else {
diff -urN linux-2.5.40-bk3/fs/hpfs/anode.c linux/fs/hpfs/anode.c
--- linux-2.5.40-bk3/fs/hpfs/anode.c	Sun Sep 15 22:18:19 2002
+++ linux/fs/hpfs/anode.c	Sat Oct  5 00:47:59 2002
@@ -20,7 +20,7 @@
 	int i;
 	int c1, c2 = 0;
 	go_down:
-	if (s->s_hpfs_chk) if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_bplus_lookup")) return -1;
+	if (hpfs_sb(s)->sb_chk) if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_bplus_lookup")) return -1;
 	if (btree->internal) {
 		for (i = 0; i < btree->n_used_nodes; i++)
 			if (btree->u.internal[i].file_secno > sec) {
@@ -38,7 +38,7 @@
 		if (btree->u.external[i].file_secno <= sec &&
 		    btree->u.external[i].file_secno + btree->u.external[i].length > sec) {
 			a = btree->u.external[i].disk_secno + sec - btree->u.external[i].file_secno;
-			if (s->s_hpfs_chk) if (hpfs_chk_sectors(s, a, 1, "data")) {
+			if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, a, 1, "data")) {
 				brelse(bh);
 				return -1;
 			}
@@ -88,7 +88,7 @@
 		btree->u.internal[n].file_secno = -1;
 		mark_buffer_dirty(bh);
 		brelse(bh);
-		if (s->s_hpfs_chk)
+		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_add_sector_to_btree #1")) return -1;
 		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
 		btree = &anode->btree;
@@ -164,7 +164,7 @@
 	c2 = 0;
 	while (up != -1) {
 		struct anode *new_anode;
-		if (s->s_hpfs_chk)
+		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, up, &c1, &c2, "hpfs_add_sector_to_btree #2")) return -1;
 		if (up != node || !fnod) {
 			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
@@ -283,7 +283,7 @@
 	while (btree1->internal) {
 		ano = btree1->u.internal[pos].down;
 		if (level) brelse(bh);
-		if (s->s_hpfs_chk)
+		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
 				return;
 		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
@@ -296,7 +296,7 @@
 	go_up:
 	if (!level) return;
 	brelse(bh);
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
 	hpfs_free_sectors(s, ano, 1);
 	oano = ano;
@@ -343,7 +343,7 @@
 			if ((sec = anode_lookup(s, a, pos >> 9)) == -1)
 				return -1;
 		} else sec = a + (pos >> 9);
-		if (s->s_hpfs_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #1")) return -1;
+		if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #1")) return -1;
 		if (!(data = hpfs_map_sector(s, sec, &bh, (len - 1) >> 9)))
 			return -1;
 		l = 0x200 - (pos & 0x1ff); if (l > len) l = len;
@@ -366,7 +366,7 @@
 			if ((sec = anode_lookup(s, a, pos >> 9)) == -1)
 				return -1;
 		} else sec = a + (pos >> 9);
-		if (s->s_hpfs_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #2")) return -1;
+		if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #2")) return -1;
 		if (!(data = hpfs_map_sector(s, sec, &bh, (len - 1) >> 9)))
 			return -1;
 		l = 0x200 - (pos & 0x1ff); if (l > len) l = len;
@@ -440,7 +440,7 @@
 		}
 		node = btree->u.internal[i].down;
 		brelse(bh);
-		if (s->s_hpfs_chk)
+		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, node, &c1, &c2, "hpfs_truncate_btree"))
 				return;
 		if (!(anode = hpfs_map_anode(s, node, &bh))) return;
diff -urN linux-2.5.40-bk3/fs/hpfs/buffer.c linux/fs/hpfs/buffer.c
--- linux-2.5.40-bk3/fs/hpfs/buffer.c	Sun Sep 15 22:18:28 2002
+++ linux/fs/hpfs/buffer.c	Sat Oct  5 00:58:33 2002
@@ -15,7 +15,7 @@
 #ifdef DEBUG_LOCKS
 	printk("lock creation\n");
 #endif
-	down(&s->u.hpfs_sb.hpfs_creation_de);
+	down(&hpfs_sb(s)->hpfs_creation_de);
 }
 
 void hpfs_unlock_creation(struct super_block *s)
@@ -23,7 +23,7 @@
 #ifdef DEBUG_LOCKS
 	printk("unlock creation\n");
 #endif
-	up(&s->u.hpfs_sb.hpfs_creation_de);
+	up(&hpfs_sb(s)->hpfs_creation_de);
 }
 
 void hpfs_lock_iget(struct super_block *s, int mode)
@@ -31,8 +31,8 @@
 #ifdef DEBUG_LOCKS
 	printk("lock iget\n");
 #endif
-	while (s->s_hpfs_rd_inode) sleep_on(&s->s_hpfs_iget_q);
-	s->s_hpfs_rd_inode = mode;
+	while (hpfs_sb(s)->sb_rd_inode) sleep_on(&hpfs_sb(s)->sb_iget_q);
+	hpfs_sb(s)->sb_rd_inode = mode;
 }
 
 void hpfs_unlock_iget(struct super_block *s)
@@ -40,8 +40,8 @@
 #ifdef DEBUG_LOCKS
 	printk("unlock iget\n");
 #endif
-	s->s_hpfs_rd_inode = 0;
-	wake_up(&s->s_hpfs_iget_q);
+	hpfs_sb(s)->sb_rd_inode = 0;
+	wake_up(&hpfs_sb(s)->sb_iget_q);
 }
 
 void hpfs_lock_inode(struct inode *i)
diff -urN linux-2.5.40-bk3/fs/hpfs/dentry.c linux/fs/hpfs/dentry.c
--- linux-2.5.40-bk3/fs/hpfs/dentry.c	Sun Sep 15 22:18:55 2002
+++ linux/fs/hpfs/dentry.c	Sat Oct  5 00:47:59 2002
@@ -28,7 +28,7 @@
 
 	hash = init_name_hash();
 	for (i = 0; i < l; i++)
-		hash = partial_name_hash(hpfs_upcase(dentry->d_sb->s_hpfs_cp_table,qstr->name[i]), hash);
+		hash = partial_name_hash(hpfs_upcase(hpfs_sb(dentry->d_sb)->sb_cp_table,qstr->name[i]), hash);
 	qstr->hash = end_name_hash(hash);
 
 	return 0;
diff -urN linux-2.5.40-bk3/fs/hpfs/dir.c linux/fs/hpfs/dir.c
--- linux-2.5.40-bk3/fs/hpfs/dir.c	Sun Sep 15 22:18:24 2002
+++ linux/fs/hpfs/dir.c	Sat Oct  5 00:47:59 2002
@@ -65,7 +65,7 @@
 	int c1, c2 = 0;
 	int ret = 0;
 
-	if (inode->i_sb->s_hpfs_chk) {
+	if (hpfs_sb(inode->i_sb)->sb_chk) {
 		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode")) {
 			ret = -EFSERROR;
 			goto out;
@@ -75,7 +75,7 @@
 			goto out;
 		}
 	}
-	if (inode->i_sb->s_hpfs_chk >= 2) {
+	if (hpfs_sb(inode->i_sb)->sb_chk >= 2) {
 		struct buffer_head *bh;
 		struct fnode *fno;
 		int e = 0;
@@ -97,7 +97,7 @@
 			goto out;
 		}
 	}
-	lc = inode->i_sb->s_hpfs_lowercase;
+	lc = hpfs_sb(inode->i_sb)->sb_lowercase;
 	if (filp->f_pos == 12) { /* diff -r requires this (note, that diff -r */
 		filp->f_pos = 13; /* also fails on msdos filesystem in 2.0) */
 		goto out;
@@ -114,7 +114,7 @@
 		/* This won't work when cycle is longer than number of dirents
 		   accepted by filldir, but what can I do?
 		   maybe killall -9 ls helps */
-		if (inode->i_sb->s_hpfs_chk)
+		if (hpfs_sb(inode->i_sb)->sb_chk)
 			if (hpfs_stop_cycles(inode->i_sb, filp->f_pos, &c1, &c2, "hpfs_readdir")) {
 				hpfs_unlock_inode(inode);
 				ret = -EFSERROR;
@@ -160,7 +160,7 @@
 				goto out;
 			}
 			if (de->first || de->last) {
-				if (inode->i_sb->s_hpfs_chk) {
+				if (hpfs_sb(inode->i_sb)->sb_chk) {
 					if (de->first && !de->last && (de->namelen != 2 || de ->name[0] != 1 || de->name[1] != 1)) hpfs_error(inode->i_sb, "hpfs_readdir: bad ^A^A entry; pos = %08x", old_pos);
 					if (de->last && (de->namelen != 1 || de ->name[0] != 255)) hpfs_error(inode->i_sb, "hpfs_readdir: bad \\377 entry; pos = %08x", old_pos);
 				}
@@ -241,7 +241,7 @@
 	 * Go find or make an inode.
 	 */
 
-	hpfs_lock_iget(dir->i_sb, de->directory || (de->ea_size && dir->i_sb->s_hpfs_eas) ? 1 : 2);
+	hpfs_lock_iget(dir->i_sb, de->directory || (de->ea_size && hpfs_sb(dir->i_sb)->sb_eas) ? 1 : 2);
 	if (!(result = iget(dir->i_sb, ino))) {
 		hpfs_unlock_iget(dir->i_sb);
 		hpfs_error(dir->i_sb, "hpfs_lookup: can't get inode");
diff -urN linux-2.5.40-bk3/fs/hpfs/dnode.c linux/fs/hpfs/dnode.c
--- linux-2.5.40-bk3/fs/hpfs/dnode.c	Sun Sep 15 22:18:29 2002
+++ linux/fs/hpfs/dnode.c	Sat Oct  5 00:47:59 2002
@@ -134,7 +134,7 @@
 		hpfs_error(s, "set_last_pointer: empty dnode %08x", d->self);
 		return;
 	}
-	if (s->s_hpfs_chk) {
+	if (hpfs_sb(s)->sb_chk) {
 		if (de->down) {
 			hpfs_error(s, "set_last_pointer: dnode %08x has already last pointer %08x",
 				d->self, de_down_pointer(de));
@@ -253,7 +253,7 @@
 		return 1;
 	}
 	go_up_a:
-	if (i->i_sb->s_hpfs_chk)
+	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
 			if (nd) kfree(nd);
@@ -379,7 +379,7 @@
 	int c1, c2 = 0;
 	dno = hpfs_inode->i_dno;
 	down:
-	if (i->i_sb->s_hpfs_chk)
+	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_dirent")) return 1;
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 1;
 	de_end = dnode_end_de(d);
@@ -427,11 +427,11 @@
 	int c1, c2 = 0;
 	dno = from;
 	while (1) {
-		if (i->i_sb->s_hpfs_chk)
+		if (hpfs_sb(i->i_sb)->sb_chk)
 			if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "move_to_top"))
 				return 0;
 		if (!(dnode = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 0;
-		if (i->i_sb->s_hpfs_chk) {
+		if (hpfs_sb(i->i_sb)->sb_chk) {
 			if (dnode->up != chk_up) {
 				hpfs_error(i->i_sb, "move_to_top: up pointer from %08x should be %08x, is %08x",
 					dno, chk_up, dnode->up);
@@ -519,7 +519,7 @@
 		up = dnode->up;
 		de = dnode_first_de(dnode);
 		down = de->down ? de_down_pointer(de) : 0;
-		if (i->i_sb->s_hpfs_chk) if (root && !down) {
+		if (hpfs_sb(i->i_sb)->sb_chk) if (root && !down) {
 			hpfs_error(i->i_sb, "delete_empty_dnode: root dnode %08x is empty", dno);
 			goto end;
 		}
@@ -532,7 +532,7 @@
 			struct buffer_head *bh;
 			struct dnode *d1;
 			struct quad_buffer_head qbh1;
-			if (i->i_sb->s_hpfs_chk) if (up != i->i_ino) {
+			if (hpfs_sb(i->i_sb)->sb_chk) if (up != i->i_ino) {
 				hpfs_error(i->i_sb, "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08x", dno, up, i->i_ino);
 				return;
 			}
@@ -628,14 +628,14 @@
 			dlp = del->down ? de_down_pointer(del) : 0;
 			if (!dlp && down) {
 				if (d1->first_free > 2044) {
-					if (i->i_sb->s_hpfs_chk >= 2) {
+					if (hpfs_sb(i->i_sb)->sb_chk >= 2) {
 						printk("HPFS: warning: unbalanced dnode tree, see hpfs.txt 4 more info\n");
 						printk("HPFS: warning: terminating balancing operation\n");
 					}
 					hpfs_brelse4(&qbh1);
 					goto endm;
 				}
-				if (i->i_sb->s_hpfs_chk >= 2) {
+				if (hpfs_sb(i->i_sb)->sb_chk >= 2) {
 					printk("HPFS: warning: unbalanced dnode tree, see hpfs.txt 4 more info\n");
 					printk("HPFS: warning: goin'on\n");
 				}
@@ -738,12 +738,12 @@
 	int d1, d2 = 0;
 	go_down:
 	if (n_dnodes) (*n_dnodes)++;
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, dno, &c1, &c2, "hpfs_count_dnodes #1")) return;
 	ptr = 0;
 	go_up:
 	if (!(dnode = hpfs_map_dnode(s, dno, &qbh))) return;
-	if (s->s_hpfs_chk) if (odno && odno != -1 && dnode->up != odno)
+	if (hpfs_sb(s)->sb_chk) if (odno && odno != -1 && dnode->up != odno)
 		hpfs_error(s, "hpfs_count_dnodes: bad up pointer; dnode %08x, down %08x points to %08x", odno, dno, dnode->up);
 	de = dnode_first_de(dnode);
 	if (ptr) while(1) {
@@ -774,7 +774,7 @@
 		return;
 	}
 	hpfs_brelse4(&qbh);
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, ptr, &d1, &d2, "hpfs_count_dnodes #2")) return;
 	odno = -1;
 	goto go_up;
@@ -811,11 +811,11 @@
 	int c1, c2 = 0;
 
 	again:
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, d, &c1, &c2, "hpfs_de_as_down_as_possible"))
 			return d;
 	if (!(de = map_nth_dirent(s, d, 1, &qbh, NULL))) return dno;
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (up && ((struct dnode *)qbh.data)->up != up)
 			hpfs_error(s, "hpfs_de_as_down_as_possible: bad up pointer; dnode %08x, down %08x points to %08x", up, d, ((struct dnode *)qbh.data)->up);
 	if (!de->down) {
@@ -901,7 +901,7 @@
 
 	if (!S_ISDIR(inode->i_mode)) hpfs_error(inode->i_sb, "map_dirent: not a directory\n");
 	again:
-	if (inode->i_sb->s_hpfs_chk)
+	if (hpfs_sb(inode->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(inode->i_sb, dno, &c1, &c2, "map_dirent")) return NULL;
 	if (!(dnode = hpfs_map_dnode(inode->i_sb, dno, qbh))) return NULL;
 	
@@ -1046,7 +1046,7 @@
 	if (c < 0 && de->down) {
 		dno = de_down_pointer(de);
 		hpfs_brelse4(qbh);
-		if (s->s_hpfs_chk)
+		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, dno, &c1, &c2, "map_fnode_dirent #1")) {
 			kfree(name2);
 			return NULL;
@@ -1065,7 +1065,7 @@
 	downd = dno;
 	dno = d->up;
 	hpfs_brelse4(qbh);
-	if (s->s_hpfs_chk)
+	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, downd, &d1, &d2, "map_fnode_dirent #2")) {
 			kfree(name2);
 			return NULL;
diff -urN linux-2.5.40-bk3/fs/hpfs/hpfs_fn.h linux/fs/hpfs/hpfs_fn.h
--- linux-2.5.40-bk3/fs/hpfs/hpfs_fn.h	Sun Sep 15 22:18:31 2002
+++ linux/fs/hpfs/hpfs_fn.h	Sat Oct  5 01:41:42 2002
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/hpfs_fs.h>
 #include <linux/hpfs_fs_i.h>
+#include <linux/hpfs_fs_sb.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -58,22 +59,6 @@
 typedef void nonconst; /* What this is for ? */
 
 /*
- * local time (HPFS) to GMT (Unix)
- */
-
-extern inline time_t local_to_gmt(struct super_block *s, time_t t)
-{
-	extern struct timezone sys_tz;
-	return t + sys_tz.tz_minuteswest * 60 + s->s_hpfs_timeshift;
-}
-
-extern inline time_t gmt_to_local(struct super_block *s, time_t t)
-{
-	extern struct timezone sys_tz;
-	return t - sys_tz.tz_minuteswest * 60 - s->s_hpfs_timeshift;
-}
-
-/*
  * conv= options
  */
 
@@ -309,6 +294,11 @@
 	return list_entry(inode, struct hpfs_inode_info, vfs_inode);
 }
 
+static inline struct hpfs_sb_info *hpfs_sb(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 /* super.c */
 
 void hpfs_error(struct super_block *, char *, ...);
@@ -319,3 +309,20 @@
 int hpfs_statfs(struct super_block *, struct statfs *);
 
 extern struct address_space_operations hpfs_aops;
+
+/*
+ * local time (HPFS) to GMT (Unix)
+ */
+
+extern inline time_t local_to_gmt(struct super_block *s, time_t t)
+{
+	extern struct timezone sys_tz;
+	return t + sys_tz.tz_minuteswest * 60 + hpfs_sb(s)->sb_timeshift;
+}
+
+extern inline time_t gmt_to_local(struct super_block *s, time_t t)
+{
+	extern struct timezone sys_tz;
+	return t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
+}
+
diff -urN linux-2.5.40-bk3/fs/hpfs/inode.c linux/fs/hpfs/inode.c
--- linux-2.5.40-bk3/fs/hpfs/inode.c	Sun Sep 15 22:18:25 2002
+++ linux/fs/hpfs/inode.c	Sat Oct  5 00:54:10 2002
@@ -66,10 +66,10 @@
 	unsigned char *ea;
 	int ea_size;
 
-	i->i_uid = sb->s_hpfs_uid;
-	i->i_gid = sb->s_hpfs_gid;
-	i->i_mode = sb->s_hpfs_mode;
-	hpfs_inode->i_conv = sb->s_hpfs_conv;
+	i->i_uid = hpfs_sb(sb)->sb_uid;
+	i->i_gid = hpfs_sb(sb)->sb_gid;
+	i->i_mode = hpfs_sb(sb)->sb_mode;
+	hpfs_inode->i_conv = hpfs_sb(sb)->sb_conv;
 	i->i_blksize = 512;
 	i->i_size = -1;
 	i->i_blocks = -1;
@@ -93,9 +93,9 @@
 	i->i_mtime = 0;
 	i->i_ctime = 0;
 
-	if (!i->i_sb->s_hpfs_rd_inode)
-		hpfs_error(i->i_sb, "read_inode: s_hpfs_rd_inode == 0");
-	if (i->i_sb->s_hpfs_rd_inode == 2) {
+	if (!hpfs_sb(i->i_sb)->sb_rd_inode)
+		hpfs_error(i->i_sb, "read_inode: sb_rd_inode == 0");
+	if (hpfs_sb(i->i_sb)->sb_rd_inode == 2) {
 		i->i_mode |= S_IFREG;
 		i->i_mode &= ~0111;
 		i->i_op = &hpfs_file_iops;
@@ -112,7 +112,7 @@
 		make_bad_inode(i);
 		return;
 	}
-	if (i->i_sb->s_hpfs_eas) {
+	if (hpfs_sb(i->i_sb)->sb_eas) {
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "UID", &ea_size))) {
 			if (ea_size == 2) {
 				i->i_uid = ea[0] + (ea[1] << 8);
@@ -140,7 +140,7 @@
 		}
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "MODE", &ea_size))) {
 			int rdev = 0;
-			umode_t mode = sb->s_hpfs_mode;
+			umode_t mode = hpfs_sb(sb)->sb_mode;
 			if (ea_size == 2) {
 				mode = ea[0] + (ea[1] << 8);
 				hpfs_inode->i_ea_mode = 1;
@@ -171,7 +171,7 @@
 		i->i_fop = &hpfs_dir_ops;
 		hpfs_inode->i_parent_dir = fnode->up;
 		hpfs_inode->i_dno = fnode->u.external[0].disk_secno;
-		if (sb->s_hpfs_chk >= 2) {
+		if (hpfs_sb(sb)->sb_chk >= 2) {
 			struct buffer_head *bh0;
 			if (hpfs_map_fnode(sb, hpfs_inode->i_parent_dir, &bh0)) brelse(bh0);
 		}
@@ -201,24 +201,24 @@
 		/* Some unknown structures like ACL may be in fnode,
 		   we'd better not overwrite them */
 		hpfs_error(i->i_sb, "fnode %08x has some unknown HPFS386 stuctures", i->i_ino);
-	} else if (i->i_sb->s_hpfs_eas >= 2) {
+	} else if (hpfs_sb(i->i_sb)->sb_eas >= 2) {
 		unsigned char ea[4];
-		if ((i->i_uid != i->i_sb->s_hpfs_uid) || hpfs_inode->i_ea_uid) {
+		if ((i->i_uid != hpfs_sb(i->i_sb)->sb_uid) || hpfs_inode->i_ea_uid) {
 			ea[0] = i->i_uid & 0xff;
 			ea[1] = i->i_uid >> 8;
 			hpfs_set_ea(i, fnode, "UID", ea, 2);
 			hpfs_inode->i_ea_uid = 1;
 		}
-		if ((i->i_gid != i->i_sb->s_hpfs_gid) || hpfs_inode->i_ea_gid) {
+		if ((i->i_gid != hpfs_sb(i->i_sb)->sb_gid) || hpfs_inode->i_ea_gid) {
 			ea[0] = i->i_gid & 0xff;
 			ea[1] = i->i_gid >> 8;
 			hpfs_set_ea(i, fnode, "GID", ea, 2);
 			hpfs_inode->i_ea_gid = 1;
 		}
 		if (!S_ISLNK(i->i_mode))
-			if ((i->i_mode != ((i->i_sb->s_hpfs_mode & ~(S_ISDIR(i->i_mode) ? 0 : 0111))
+			if ((i->i_mode != ((hpfs_sb(i->i_sb)->sb_mode & ~(S_ISDIR(i->i_mode) ? 0 : 0111))
 			  | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))
-			  && i->i_mode != ((i->i_sb->s_hpfs_mode & ~(S_ISDIR(i->i_mode) ? 0222 : 0333))
+			  && i->i_mode != ((hpfs_sb(i->i_sb)->sb_mode & ~(S_ISDIR(i->i_mode) ? 0222 : 0333))
 			  | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))) || hpfs_inode->i_ea_mode) {
 				ea[0] = i->i_mode & 0xff;
 				ea[1] = i->i_mode >> 8;
@@ -241,7 +241,7 @@
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	struct inode *parent;
 	if (!i->i_nlink) return;
-	if (i->i_ino == i->i_sb->s_hpfs_root) return;
+	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
 	if (hpfs_inode->i_rddir_off && !atomic_read(&i->i_count)) {
 		if (*hpfs_inode->i_rddir_off) printk("HPFS: write_inode: some position still there\n");
 		kfree(hpfs_inode->i_rddir_off);
@@ -264,9 +264,9 @@
 	struct fnode *fnode;
 	struct quad_buffer_head qbh;
 	struct hpfs_dirent *de;
-	if (i->i_ino == i->i_sb->s_hpfs_root) return;
+	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
 	if (!(fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh))) return;
-	if (i->i_ino != i->i_sb->s_hpfs_root) {
+	if (i->i_ino != hpfs_sb(i->i_sb)->sb_root) {
 		if (!(de = map_fnode_dirent(i->i_sb, i->i_ino, fnode, &qbh))) {
 			brelse(bh);
 			return;
@@ -309,7 +309,7 @@
 	int error=0;
 	lock_kernel();
 	if ( ((attr->ia_valid & ATTR_SIZE) && attr->ia_size > inode->i_size) ||
-	     (inode->i_sb->s_hpfs_root == inode->i_ino) ) {
+	     (hpfs_sb(inode->i_sb)->sb_root == inode->i_ino) ) {
 		error = -EINVAL;
 	} else if ((error = inode_change_ok(inode, attr))) {
 	} else if ((error = inode_setattr(inode, attr))) {
diff -urN linux-2.5.40-bk3/fs/hpfs/map.c linux/fs/hpfs/map.c
--- linux-2.5.40-bk3/fs/hpfs/map.c	Sun Sep 15 22:18:24 2002
+++ linux/fs/hpfs/map.c	Sat Oct  5 00:47:59 2002
@@ -11,19 +11,19 @@
 
 unsigned *hpfs_map_dnode_bitmap(struct super_block *s, struct quad_buffer_head *qbh)
 {
-	return hpfs_map_4sectors(s, s->s_hpfs_dmap, qbh, 0);
+	return hpfs_map_4sectors(s, hpfs_sb(s)->sb_dmap, qbh, 0);
 }
 
 unsigned int *hpfs_map_bitmap(struct super_block *s, unsigned bmp_block,
 			 struct quad_buffer_head *qbh, char *id)
 {
 	secno sec;
-	if (s->s_hpfs_chk) if (bmp_block * 16384 > s->s_hpfs_fs_size) {
+	if (hpfs_sb(s)->sb_chk) if (bmp_block * 16384 > hpfs_sb(s)->sb_fs_size) {
 		hpfs_error(s, "hpfs_map_bitmap called with bad parameter: %08x at %s", bmp_block, id);
 		return NULL;
 	}
-	sec = s->s_hpfs_bmp_dir[bmp_block];
-	if (!sec || sec > s->s_hpfs_fs_size-4) {
+	sec = hpfs_sb(s)->sb_bmp_dir[bmp_block];
+	if (!sec || sec > hpfs_sb(s)->sb_fs_size-4) {
 		hpfs_error(s, "invalid bitmap block pointer %08x -> %08x at %s", bmp_block, sec, id);
 		return NULL;
 	}
@@ -93,7 +93,7 @@
 secno *hpfs_load_bitmap_directory(struct super_block *s, secno bmp)
 {
 	struct buffer_head *bh;
-	int n = (s->s_hpfs_fs_size + 0x200000 - 1) >> 21;
+	int n = (hpfs_sb(s)->sb_fs_size + 0x200000 - 1) >> 21;
 	int i;
 	secno *b;
 	if (!(b = kmalloc(n * 512, GFP_KERNEL))) {
@@ -119,11 +119,11 @@
 struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_head **bhp)
 {
 	struct fnode *fnode;
-	if (s->s_hpfs_chk) if (hpfs_chk_sectors(s, ino, 1, "fnode")) {
+	if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, ino, 1, "fnode")) {
 		return NULL;
 	}
 	if ((fnode = hpfs_map_sector(s, ino, bhp, FNODE_RD_AHEAD))) {
-		if (s->s_hpfs_chk) {
+		if (hpfs_sb(s)->sb_chk) {
 			struct extended_attribute *ea;
 			struct extended_attribute *ea_end;
 			if (fnode->magic != FNODE_MAGIC) {
@@ -168,9 +168,9 @@
 struct anode *hpfs_map_anode(struct super_block *s, anode_secno ano, struct buffer_head **bhp)
 {
 	struct anode *anode;
-	if (s->s_hpfs_chk) if (hpfs_chk_sectors(s, ano, 1, "anode")) return NULL;
+	if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, ano, 1, "anode")) return NULL;
 	if ((anode = hpfs_map_sector(s, ano, bhp, ANODE_RD_AHEAD)))
-		if (s->s_hpfs_chk) {
+		if (hpfs_sb(s)->sb_chk) {
 			if (anode->magic != ANODE_MAGIC || anode->self != ano) {
 				hpfs_error(s, "bad magic on anode %08x", ano);
 				goto bail;
@@ -200,7 +200,7 @@
 			     struct quad_buffer_head *qbh)
 {
 	struct dnode *dnode;
-	if (s->s_hpfs_chk) {
+	if (hpfs_sb(s)->sb_chk) {
 		if (hpfs_chk_sectors(s, secno, 4, "dnode")) return NULL;
 		if (secno & 3) {
 			hpfs_error(s, "dnode %08x not byte-aligned", secno);
@@ -208,7 +208,7 @@
 		}	
 	}
 	if ((dnode = hpfs_map_4sectors(s, secno, qbh, DNODE_RD_AHEAD)))
-		if (s->s_hpfs_chk) {
+		if (hpfs_sb(s)->sb_chk) {
 			unsigned p, pp = 0;
 			unsigned char *d = (char *)dnode;
 			int b = 0;
@@ -234,7 +234,7 @@
 					hpfs_error(s, "namelen does not match dirent size in dnode %08x, dirent %03x, last %03x", secno, p, pp);
 					goto bail;
 				}
-				if (s->s_hpfs_chk >= 2) b |= 1 << de->down;
+				if (hpfs_sb(s)->sb_chk >= 2) b |= 1 << de->down;
 				if (de->down) if (de_down_pointer(de) < 0x10) {
 					hpfs_error(s, "bad down pointer in dnode %08x, dirent %03x, last %03x", secno, p, pp);
 					goto bail;
diff -urN linux-2.5.40-bk3/fs/hpfs/name.c linux/fs/hpfs/name.c
--- linux-2.5.40-bk3/fs/hpfs/name.c	Sun Sep 15 22:18:50 2002
+++ linux/fs/hpfs/name.c	Sat Oct  5 00:47:59 2002
@@ -89,7 +89,7 @@
 {
 	char *to;
 	int i;
-	if (s->s_hpfs_chk >= 2) if (hpfs_is_name_long(from, len) != lng) {
+	if (hpfs_sb(s)->sb_chk >= 2) if (hpfs_is_name_long(from, len) != lng) {
 		printk("HPFS: Long name flag mismatch - name ");
 		for (i=0; i<len; i++) printk("%c", from[i]);
 		printk(" misidentified as %s.\n", lng ? "short" : "long");
@@ -100,7 +100,7 @@
 		printk("HPFS: can't allocate memory for name conversion buffer\n");
 		return from;
 	}
-	for (i = 0; i < len; i++) to[i] = locase(s->s_hpfs_cp_table,from[i]);
+	for (i = 0; i < len; i++) to[i] = locase(hpfs_sb(s)->sb_cp_table,from[i]);
 	return to;
 }
 
@@ -111,8 +111,8 @@
 	unsigned i;
 	if (last) return -1;
 	for (i = 0; i < l; i++) {
-		unsigned char c1 = upcase(s->s_hpfs_cp_table,n1[i]);
-		unsigned char c2 = upcase(s->s_hpfs_cp_table,n2[i]);
+		unsigned char c1 = upcase(hpfs_sb(s)->sb_cp_table,n1[i]);
+		unsigned char c2 = upcase(hpfs_sb(s)->sb_cp_table,n2[i]);
 		if (c1 < c2) return -1;
 		if (c1 > c2) return 1;
 	}
diff -urN linux-2.5.40-bk3/fs/hpfs/namei.c linux/fs/hpfs/namei.c
--- linux-2.5.40-bk3/fs/hpfs/namei.c	Sun Sep 15 22:18:27 2002
+++ linux/fs/hpfs/namei.c	Sat Oct  5 00:47:59 2002
@@ -187,7 +187,7 @@
 	struct inode *result = NULL;
 	int err;
 	if ((err = hpfs_chk_name((char *)name, &len))) return err==-ENOENT ? -EINVAL : err;
-	if (dir->i_sb->s_hpfs_eas < 2) return -EPERM;
+	if (hpfs_sb(dir->i_sb)->sb_eas < 2) return -EPERM;
 	lock_kernel();
 	if (!(fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh))) goto bail;
 	memset(&dee, 0, sizeof dee);
@@ -255,7 +255,7 @@
 	int err;
 	if ((err = hpfs_chk_name((char *)name, &len))) return err==-ENOENT ? -EINVAL : err;
 	lock_kernel();
-	if (dir->i_sb->s_hpfs_eas < 2) {
+	if (hpfs_sb(dir->i_sb)->sb_eas < 2) {
 		unlock_kernel();
 		return -EPERM;
 	}
@@ -559,7 +559,7 @@
 		mark_buffer_dirty(bh);
 		brelse(bh);
 	}
-	hpfs_i(i)->i_conv = i->i_sb->s_hpfs_conv;
+	hpfs_i(i)->i_conv = hpfs_sb(i->i_sb)->sb_conv;
 	hpfs_decide_conv(i, (char *)new_name, new_len);
 	end1:
 	hpfs_unlock_3inodes(old_dir, new_dir, i);
diff -urN linux-2.5.40-bk3/fs/hpfs/super.c linux/fs/hpfs/super.c
--- linux-2.5.40-bk3/fs/hpfs/super.c	Sun Sep 15 22:18:31 2002
+++ linux/fs/hpfs/super.c	Sat Oct  5 11:27:11 2002
@@ -16,7 +16,7 @@
 
 static void mark_dirty(struct super_block *s)
 {
-	if (s->s_hpfs_chkdsk && !(s->s_flags & MS_RDONLY)) {
+	if (hpfs_sb(s)->sb_chkdsk && !(s->s_flags & MS_RDONLY)) {
 		struct buffer_head *bh;
 		struct hpfs_spare_block *sb;
 		if ((sb = hpfs_map_sector(s, 17, &bh, 0))) {
@@ -37,8 +37,8 @@
 	struct hpfs_spare_block *sb;
 	if (s->s_flags & MS_RDONLY) return;
 	if ((sb = hpfs_map_sector(s, 17, &bh, 0))) {
-		sb->dirty = s->s_hpfs_chkdsk > 1 - s->s_hpfs_was_error;
-		sb->old_wrote = s->s_hpfs_chkdsk >= 2 && !s->s_hpfs_was_error;
+		sb->dirty = hpfs_sb(s)->sb_chkdsk > 1 - hpfs_sb(s)->sb_was_error;
+		sb->old_wrote = hpfs_sb(s)->sb_chkdsk >= 2 && !hpfs_sb(s)->sb_was_error;
 		mark_buffer_dirty(bh);
 		brelse(bh);
 	}
@@ -60,12 +60,12 @@
 	printk("HPFS: filesystem error: ");
 	if (buf) printk("%s", buf);
 	else printk("%s\n",m);
-	if (!s->s_hpfs_was_error) {
-		if (s->s_hpfs_err == 2) {
+	if (!hpfs_sb(s)->sb_was_error) {
+		if (hpfs_sb(s)->sb_err == 2) {
 			printk("; crashing the system because you wanted it\n");
 			mark_dirty(s);
 			panic("HPFS panic");
-		} else if (s->s_hpfs_err == 1) {
+		} else if (hpfs_sb(s)->sb_err == 1) {
 			if (s->s_flags & MS_RDONLY) printk("; already mounted read-only\n");
 			else {
 				printk("; remounting read-only\n");
@@ -76,7 +76,7 @@
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
 	if (buf) kfree(buf);
-	s->s_hpfs_was_error = 1;
+	hpfs_sb(s)->sb_was_error = 1;
 }
 
 /* 
@@ -101,9 +101,12 @@
 
 void hpfs_put_super(struct super_block *s)
 {
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
+	struct hpfs_sb_info *sbi = hpfs_sb(s);
+	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
+	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
 	unmark_dirty(s);
+	s->u.generic_sbp = NULL;
+	kfree(sbi);
 }
 
 unsigned hpfs_count_one_bitmap(struct super_block *s, secno secno)
@@ -125,28 +128,29 @@
 static unsigned count_bitmaps(struct super_block *s)
 {
 	unsigned n, count, n_bands;
-	n_bands = (s->s_hpfs_fs_size + 0x3fff) >> 14;
+	n_bands = (hpfs_sb(s)->sb_fs_size + 0x3fff) >> 14;
 	count = 0;
 	for (n = 0; n < n_bands; n++)
-		count += hpfs_count_one_bitmap(s, s->s_hpfs_bmp_dir[n]);
+		count += hpfs_count_one_bitmap(s, hpfs_sb(s)->sb_bmp_dir[n]);
 	return count;
 }
 
 int hpfs_statfs(struct super_block *s, struct statfs *buf)
 {
+	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	lock_kernel();
 
-	/*if (s->s_hpfs_n_free == -1) {*/
-		s->s_hpfs_n_free = count_bitmaps(s);
-		s->s_hpfs_n_free_dnodes = hpfs_count_one_bitmap(s, s->s_hpfs_dmap);
+	/*if (sbi->sb_n_free == -1) {*/
+		sbi->sb_n_free = count_bitmaps(s);
+		sbi->sb_n_free_dnodes = hpfs_count_one_bitmap(s, sbi->sb_dmap);
 	/*}*/
 	buf->f_type = s->s_magic;
 	buf->f_bsize = 512;
-	buf->f_blocks = s->s_hpfs_fs_size;
-	buf->f_bfree = s->s_hpfs_n_free;
-	buf->f_bavail = s->s_hpfs_n_free;
-	buf->f_files = s->s_hpfs_dirband_size / 4;
-	buf->f_ffree = s->s_hpfs_n_free_dnodes;
+	buf->f_blocks = sbi->sb_fs_size;
+	buf->f_bfree = sbi->sb_n_free;
+	buf->f_bavail = sbi->sb_n_free;
+	buf->f_files = sbi->sb_dirband_size / 4;
+	buf->f_ffree = sbi->sb_n_free_dnodes;
 	buf->f_namelen = 254;
 
 	unlock_kernel();
@@ -377,14 +381,15 @@
 	umode_t umask;
 	int lowercase, conv, eas, chk, errs, chkdsk, timeshift;
 	int o;
+	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	
 	*flags |= MS_NOATIME;
 	
-	uid = s->s_hpfs_uid; gid = s->s_hpfs_gid;
-	umask = 0777 & ~s->s_hpfs_mode;
-	lowercase = s->s_hpfs_lowercase; conv = s->s_hpfs_conv;
-	eas = s->s_hpfs_eas; chk = s->s_hpfs_chk; chkdsk = s->s_hpfs_chkdsk;
-	errs = s->s_hpfs_err; timeshift = s->s_hpfs_timeshift;
+	uid = sbi->sb_uid; gid = sbi->sb_gid;
+	umask = 0777 & ~sbi->sb_mode;
+	lowercase = sbi->sb_lowercase; conv = sbi->sb_conv;
+	eas = sbi->sb_eas; chk = sbi->sb_chk; chkdsk = sbi->sb_chkdsk;
+	errs = sbi->sb_err; timeshift = sbi->sb_timeshift;
 
 	if (!(o = parse_opts(data, &uid, &gid, &umask, &lowercase, &conv,
 	    &eas, &chk, &errs, &chkdsk, &timeshift))) {
@@ -395,18 +400,18 @@
 		hpfs_help();
 		return 1;
 	}
-	if (timeshift != s->s_hpfs_timeshift) {
+	if (timeshift != sbi->sb_timeshift) {
 		printk("HPFS: timeshift can't be changed using remount.\n");
 		return 1;
 	}
 
 	unmark_dirty(s);
 
-	s->s_hpfs_uid = uid; s->s_hpfs_gid = gid;
-	s->s_hpfs_mode = 0777 & ~umask;
-	s->s_hpfs_lowercase = lowercase; s->s_hpfs_conv = conv;
-	s->s_hpfs_eas = eas; s->s_hpfs_chk = chk; s->s_hpfs_chkdsk = chkdsk;
-	s->s_hpfs_err = errs; s->s_hpfs_timeshift = timeshift;
+	sbi->sb_uid = uid; sbi->sb_gid = gid;
+	sbi->sb_mode = 0777 & ~umask;
+	sbi->sb_lowercase = lowercase; sbi->sb_conv = conv;
+	sbi->sb_eas = eas; sbi->sb_chk = chk; sbi->sb_chkdsk = chkdsk;
+	sbi->sb_err = errs; sbi->sb_timeshift = timeshift;
 
 	if (!(*flags & MS_RDONLY)) mark_dirty(s);
 
@@ -419,6 +424,7 @@
 	struct hpfs_boot_block *bootblock;
 	struct hpfs_super_block *superblock;
 	struct hpfs_spare_block *spareblock;
+	struct hpfs_sb_info *sbi;
 
 	uid_t uid;
 	gid_t gid;
@@ -431,12 +437,18 @@
 
 	int o;
 
-	s->s_hpfs_bmp_dir = NULL;
-	s->s_hpfs_cp_table = NULL;
+	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	s->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(*sbi));
+
+	sbi->sb_bmp_dir = NULL;
+	sbi->sb_cp_table = NULL;
 
-	s->s_hpfs_rd_inode = 0;
-	init_MUTEX(&s->u.hpfs_sb.hpfs_creation_de);
-	init_waitqueue_head(&s->s_hpfs_iget_q);
+	sbi->sb_rd_inode = 0;
+	init_MUTEX(&sbi->hpfs_creation_de);
+	init_waitqueue_head(&sbi->sb_iget_q);
 
 	uid = current->uid;
 	gid = current->gid;
@@ -459,9 +471,9 @@
 		goto bail0;
 	}
 
-	/*s->s_hpfs_mounting = 1;*/
+	/*sbi->sb_mounting = 1;*/
 	sb_set_blocksize(s, 512);
-	s->s_hpfs_fs_size = -1;
+	sbi->sb_fs_size = -1;
 	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
 	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
 	if (!(spareblock = hpfs_map_sector(s, 17, &bh2, 0))) goto bail3;
@@ -489,30 +501,30 @@
 	s->s_magic = HPFS_SUPER_MAGIC;
 	s->s_op = &hpfs_sops;
 
-	s->s_hpfs_root = superblock->root;
-	s->s_hpfs_fs_size = superblock->n_sectors;
-	s->s_hpfs_bitmaps = superblock->bitmaps;
-	s->s_hpfs_dirband_start = superblock->dir_band_start;
-	s->s_hpfs_dirband_size = superblock->n_dir_band;
-	s->s_hpfs_dmap = superblock->dir_band_bitmap;
-	s->s_hpfs_uid = uid;
-	s->s_hpfs_gid = gid;
-	s->s_hpfs_mode = 0777 & ~umask;
-	s->s_hpfs_n_free = -1;
-	s->s_hpfs_n_free_dnodes = -1;
-	s->s_hpfs_lowercase = lowercase;
-	s->s_hpfs_conv = conv;
-	s->s_hpfs_eas = eas;
-	s->s_hpfs_chk = chk;
-	s->s_hpfs_chkdsk = chkdsk;
-	s->s_hpfs_err = errs;
-	s->s_hpfs_timeshift = timeshift;
-	s->s_hpfs_was_error = 0;
-	s->s_hpfs_cp_table = NULL;
-	s->s_hpfs_c_bitmap = -1;
+	sbi->sb_root = superblock->root;
+	sbi->sb_fs_size = superblock->n_sectors;
+	sbi->sb_bitmaps = superblock->bitmaps;
+	sbi->sb_dirband_start = superblock->dir_band_start;
+	sbi->sb_dirband_size = superblock->n_dir_band;
+	sbi->sb_dmap = superblock->dir_band_bitmap;
+	sbi->sb_uid = uid;
+	sbi->sb_gid = gid;
+	sbi->sb_mode = 0777 & ~umask;
+	sbi->sb_n_free = -1;
+	sbi->sb_n_free_dnodes = -1;
+	sbi->sb_lowercase = lowercase;
+	sbi->sb_conv = conv;
+	sbi->sb_eas = eas;
+	sbi->sb_chk = chk;
+	sbi->sb_chkdsk = chkdsk;
+	sbi->sb_err = errs;
+	sbi->sb_timeshift = timeshift;
+	sbi->sb_was_error = 0;
+	sbi->sb_cp_table = NULL;
+	sbi->sb_c_bitmap = -1;
 	
 	/* Load bitmap directory */
-	if (!(s->s_hpfs_bmp_dir = hpfs_load_bitmap_directory(s, superblock->bitmaps)))
+	if (!(sbi->sb_bmp_dir = hpfs_load_bitmap_directory(s, superblock->bitmaps)))
 		goto bail4;
 	
 	/* Check for general fs errors*/
@@ -557,20 +569,20 @@
 				superblock->dir_band_start, superblock->dir_band_end, superblock->n_dir_band);
 			goto bail4;
 		}
-		a = s->s_hpfs_dirband_size;
-		s->s_hpfs_dirband_size = 0;
+		a = sbi->sb_dirband_size;
+		sbi->sb_dirband_size = 0;
 		if (hpfs_chk_sectors(s, superblock->dir_band_start, superblock->n_dir_band, "dir_band") ||
 		    hpfs_chk_sectors(s, superblock->dir_band_bitmap, 4, "dir_band_bitmap") ||
 		    hpfs_chk_sectors(s, superblock->bitmaps, 4, "bitmaps")) {
 			mark_dirty(s);
 			goto bail4;
 		}
-		s->s_hpfs_dirband_size = a;
+		sbi->sb_dirband_size = a;
 	} else printk("HPFS: You really don't want any checks? You are crazy...\n");
 
 	/* Load code page table */
 	if (spareblock->n_code_pages)
-		if (!(s->s_hpfs_cp_table = hpfs_load_code_page(s, spareblock->code_page_dir)))
+		if (!(sbi->sb_cp_table = hpfs_load_code_page(s, spareblock->code_page_dir)))
 			printk("HPFS: Warning: code page support is disabled\n");
 
 	brelse(bh2);
@@ -578,7 +590,7 @@
 	brelse(bh0);
 
 	hpfs_lock_iget(s, 1);
-	s->s_root = d_alloc_root(iget(s, s->s_hpfs_root));
+	s->s_root = d_alloc_root(iget(s, sbi->sb_root));
 	hpfs_unlock_iget(s);
 	if (!s->s_root || !s->s_root->d_inode) {
 		printk("HPFS: iget failed. Why???\n");
@@ -590,7 +602,7 @@
 	 * find the root directory's . pointer & finish filling in the inode
 	 */
 
-	root_dno = hpfs_fnode_dno(s, s->s_hpfs_root);
+	root_dno = hpfs_fnode_dno(s, sbi->sb_root);
 	if (root_dno)
 		de = map_dirent(s->s_root->d_inode, root_dno, "\001\001", 2, NULL, &qbh);
 	if (!root_dno || !de) hpfs_error(s, "unable to find root dir");
@@ -612,8 +624,10 @@
 bail2:	brelse(bh0);
 bail1:
 bail0:
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
+	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
+	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
+	s->u.generic_sbp = NULL;
+	kfree(sbi);
 	return -EINVAL;
 }
 
diff -urN linux-2.5.40-bk3/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.40-bk3/include/linux/fs.h	Fri Oct  4 13:42:36 2002
+++ linux/include/linux/fs.h	Sat Oct  5 01:30:14 2002
@@ -628,7 +628,6 @@
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
 #include <linux/ext3_fs_sb.h>
-#include <linux/hpfs_fs_sb.h>
 
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
@@ -671,7 +670,6 @@
 
 	union {
 		struct ext3_sb_info	ext3_sb;
-		struct hpfs_sb_info	hpfs_sb;
 		void			*generic_sbp;
 	} u;
 	/*
diff -urN linux-2.5.40-bk3/include/linux/hpfs_fs_sb.h linux/include/linux/hpfs_fs_sb.h
--- linux-2.5.40-bk3/include/linux/hpfs_fs_sb.h	Sun Sep 15 22:18:50 2002
+++ linux/include/linux/hpfs_fs_sb.h	Sat Oct  5 00:31:43 2002
@@ -36,31 +36,4 @@
 	int sb_timeshift;
 };
 
-#define s_hpfs_root u.hpfs_sb.sb_root
-#define s_hpfs_fs_size u.hpfs_sb.sb_fs_size
-#define s_hpfs_bitmaps u.hpfs_sb.sb_bitmaps
-#define s_hpfs_dirband_start u.hpfs_sb.sb_dirband_start
-#define s_hpfs_dirband_size u.hpfs_sb.sb_dirband_size
-#define s_hpfs_dmap u.hpfs_sb.sb_dmap
-#define s_hpfs_uid u.hpfs_sb.sb_uid
-#define s_hpfs_gid u.hpfs_sb.sb_gid
-#define s_hpfs_mode u.hpfs_sb.sb_mode
-#define s_hpfs_n_free u.hpfs_sb.sb_n_free
-#define s_hpfs_n_free_dnodes u.hpfs_sb.sb_n_free_dnodes
-#define s_hpfs_lowercase u.hpfs_sb.sb_lowercase
-#define s_hpfs_conv u.hpfs_sb.sb_conv
-#define s_hpfs_eas u.hpfs_sb.sb_eas
-#define s_hpfs_err u.hpfs_sb.sb_err
-#define s_hpfs_chk u.hpfs_sb.sb_chk
-#define s_hpfs_was_error u.hpfs_sb.sb_was_error
-#define s_hpfs_chkdsk u.hpfs_sb.sb_chkdsk
-/*#define s_hpfs_rd_fnode u.hpfs_sb.sb_rd_fnode*/
-#define s_hpfs_rd_inode u.hpfs_sb.sb_rd_inode
-#define s_hpfs_cp_table u.hpfs_sb.sb_cp_table
-#define s_hpfs_bmp_dir u.hpfs_sb.sb_bmp_dir
-#define s_hpfs_c_bitmap u.hpfs_sb.sb_c_bitmap
-#define s_hpfs_iget_q u.hpfs_sb.sb_iget_q
-/*#define s_hpfs_mounting u.hpfs_sb.sb_mounting*/
-#define s_hpfs_timeshift u.hpfs_sb.sb_timeshift
-
 #endif

--------------080803080900070707000102--

