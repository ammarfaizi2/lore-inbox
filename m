Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTLVUDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTLVUCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:02:51 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:45586 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264429AbTLVUCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:02:18 -0500
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] FAT: Support the large partition (> 128GB) for 2.4
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Dec 2003 05:02:01 +0900
Message-ID: <87k74or58m.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some peoples reported the problem of fatfs on large partion (> 128GB),
and fixed by the following patch.


The "directory entry pointer" is position of the directory entry in
the partition. like the following,

in fs/fat/misc.c:fat__get_entry()

    offset &= sb->s_blocksize - 1;
    *de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
    *ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
    ^^^

This is used for updates (not create) of the directory entry, and
overflowed by large partition (> 128GB).

 fs/fat/dir.c               |   31 ++++++-------
 fs/fat/inode.c             |   72 +++++++++++++++---------------
 fs/fat/misc.c              |  105 +++++++++++++++++++++++++--------------------
 fs/msdos/namei.c           |   70 +++++++++++++++---------------
 fs/vfat/namei.c            |   33 +++++++-------
 include/linux/msdos_fs.h   |   23 +++++----
 include/linux/msdos_fs_i.h |    2 
 7 files changed, 179 insertions(+), 157 deletions(-)

diff -puN fs/fat/dir.c~fat_large-disk-2.4 fs/fat/dir.c
--- linux-2.4.24-bk1/fs/fat/dir.c~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/fs/fat/dir.c	2003-12-16 02:29:29.000000000 +0900
@@ -198,11 +198,11 @@ int fat_search_long(struct inode *inode,
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	int ino, chl, i, j, last_u, res = 0;
-	loff_t cpos = 0;
+	int chl, i, j, last_u, res = 0;
+	loff_t i_pos, cpos = 0;
 
 	while(1) {
-		if (fat_get_entry(inode,&cpos,&bh,&de,&ino) == -1)
+		if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
 			goto EODir;
 parse_record:
 		long_slots = 0;
@@ -253,7 +253,7 @@ parse_long:
 				if (ds->id & 0x40) {
 					unicode[offset + 13] = 0;
 				}
-				if (fat_get_entry(inode,&cpos,&bh,&de,&ino)<0)
+				if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos)<0)
 					goto EODir;
 				if (slot == 0)
 					break;
@@ -368,8 +368,9 @@ static int fat_readdirx(struct inode *in
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	int nocase = MSDOS_SB(sb)->options.nocase;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	int ino, inum, chi, chl, i, i2, j, last, last_u, dotoffset = 0;
-	loff_t cpos;
+	unsigned long inum;
+	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
+	loff_t i_pos, cpos;
 
 	cpos = filp->f_pos;
 /* Fake . and .. for the root directory. */
@@ -392,7 +393,7 @@ static int fat_readdirx(struct inode *in
  	bh = NULL;
 GetNew:
 	long_slots = 0;
-	if (fat_get_entry(inode,&cpos,&bh,&de,&ino) == -1)
+	if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
 		goto EODir;
 	/* Check for long filename entry */
 	if (isvfat) {
@@ -449,7 +450,7 @@ ParseLong:
 			if (ds->id & 0x40) {
 				unicode[offset + 13] = 0;
 			}
-			if (fat_get_entry(inode,&cpos,&bh,&de,&ino) == -1)
+			if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
 				goto EODir;
 			if (slot == 0)
 				break;
@@ -541,7 +542,7 @@ ParseLong:
 /*		inum = fat_parent_ino(inode,0); */
 		inum = filp->f_dentry->d_parent->d_inode->i_ino;
 	} else {
-		struct inode *tmp = fat_iget(sb, ino);
+		struct inode *tmp = fat_iget(sb, i_pos);
 		if (tmp) {
 			inum = tmp->i_ino;
 			iput(tmp);
@@ -690,14 +691,14 @@ int fat_dir_ioctl(struct inode * inode, 
 /***** See if directory is empty */
 int fat_dir_empty(struct inode *dir)
 {
-	loff_t pos;
+	loff_t pos, i_pos;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
-	int ino,result = 0;
+	int result = 0;
 
 	pos = 0;
 	bh = NULL;
-	while (fat_get_entry(dir,&pos,&bh,&de,&ino) > -1) {
+	while (fat_get_entry(dir,&pos,&bh,&de,&i_pos) > -1) {
 		/* Ignore vfat longname entries */
 		if (de->attr == ATTR_EXT)
 			continue;
@@ -717,7 +718,7 @@ int fat_dir_empty(struct inode *dir)
 /* This assumes that size of cluster is above the 32*slots */
 
 int fat_add_entries(struct inode *dir,int slots, struct buffer_head **bh,
-		  struct msdos_dir_entry **de, int *ino)
+		  struct msdos_dir_entry **de, loff_t *i_pos)
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset, curr;
@@ -727,7 +728,7 @@ int fat_add_entries(struct inode *dir,in
 	offset = curr = 0;
 	*bh = NULL;
 	row = 0;
-	while (fat_get_entry(dir,&curr,bh,de,ino) > -1) {
+	while (fat_get_entry(dir,&curr,bh,de,i_pos) > -1) {
 		if (IS_FREE((*de)->name)) {
 			if (++row == slots)
 				return offset;
@@ -742,7 +743,7 @@ int fat_add_entries(struct inode *dir,in
 	if (!new_bh)
 		return -ENOSPC;
 	fat_brelse(sb, new_bh);
-	do fat_get_entry(dir,&curr,bh,de,ino); while (++row<slots);
+	do fat_get_entry(dir,&curr,bh,de,i_pos); while (++row<slots);
 	return offset;
 }
 
diff -puN fs/fat/inode.c~fat_large-disk-2.4 fs/fat/inode.c
--- linux-2.4.24-bk1/fs/fat/inode.c~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/fs/fat/inode.c	2003-12-16 02:29:29.000000000 +0900
@@ -83,17 +83,17 @@ void fat_hash_init(void)
 	}
 }
 
-static inline unsigned long fat_hash(struct super_block *sb, int i_pos)
+static inline unsigned long fat_hash(struct super_block *sb, loff_t i_pos)
 {
 	unsigned long tmp = (unsigned long)i_pos | (unsigned long) sb;
 	tmp = tmp + (tmp >> FAT_HASH_BITS) + (tmp >> FAT_HASH_BITS * 2);
 	return tmp & FAT_HASH_MASK;
 }
 
-void fat_attach(struct inode *inode, int i_pos)
+void fat_attach(struct inode *inode, loff_t i_pos)
 {
 	spin_lock(&fat_inode_lock);
-	MSDOS_I(inode)->i_location = i_pos;
+	MSDOS_I(inode)->i_pos = i_pos;
 	list_add(&MSDOS_I(inode)->i_fat_hash,
 		fat_inode_hashtable + fat_hash(inode->i_sb, i_pos));
 	spin_unlock(&fat_inode_lock);
@@ -102,13 +102,13 @@ void fat_attach(struct inode *inode, int
 void fat_detach(struct inode *inode)
 {
 	spin_lock(&fat_inode_lock);
-	MSDOS_I(inode)->i_location = 0;
+	MSDOS_I(inode)->i_pos = 0;
 	list_del(&MSDOS_I(inode)->i_fat_hash);
 	INIT_LIST_HEAD(&MSDOS_I(inode)->i_fat_hash);
 	spin_unlock(&fat_inode_lock);
 }
 
-struct inode *fat_iget(struct super_block *sb, int i_pos)
+struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
 	struct list_head *p = fat_inode_hashtable + fat_hash(sb, i_pos);
 	struct list_head *walk;
@@ -120,7 +120,7 @@ struct inode *fat_iget(struct super_bloc
 		i = list_entry(walk, struct msdos_inode_info, i_fat_hash);
 		if (i->i_fat_inode->i_sb != sb)
 			continue;
-		if (i->i_location != i_pos)
+		if (i->i_pos != i_pos)
 			continue;
 		inode = igrab(i->i_fat_inode);
 		if (inode)
@@ -133,11 +133,11 @@ struct inode *fat_iget(struct super_bloc
 static void fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
 
 struct inode *fat_build_inode(struct super_block *sb,
-				struct msdos_dir_entry *de, int ino, int *res)
+			struct msdos_dir_entry *de, loff_t i_pos, int *res)
 {
 	struct inode *inode;
 	*res = 0;
-	inode = fat_iget(sb, ino);
+	inode = fat_iget(sb, i_pos);
 	if (inode)
 		goto out;
 	inode = new_inode(sb);
@@ -147,7 +147,7 @@ struct inode *fat_build_inode(struct sup
 	*res = 0;
 	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
 	fat_fill_inode(inode, de);
-	fat_attach(inode, ino);
+	fat_attach(inode, i_pos);
 	insert_inode_hash(inode);
 out:
 	return inode;
@@ -379,7 +379,7 @@ static void fat_read_root(struct inode *
 	int nr;
 
 	INIT_LIST_HEAD(&MSDOS_I(inode)->i_fat_hash);
-	MSDOS_I(inode)->i_location = 0;
+	MSDOS_I(inode)->i_pos = 0;
 	MSDOS_I(inode)->i_fat_inode = inode;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
@@ -421,9 +421,10 @@ static void fat_read_root(struct inode *
  *  0/  i_ino - for fast, reliable lookup if still in the cache
  *  1/  i_generation - to see if i_ino is still valid
  *          bit 0 == 0 iff directory
- *  2/  i_location - if ino has changed, but still in cache
- *  3/  i_logstart - to semi-verify inode found at i_location
- *  4/  parent->i_logstart - maybe used to hunt for the file on disc
+ *  2/  i_pos - if ino has changed, but still in cache (hi)
+ *  3/  i_pos - if ino has changed, but still in cache (low)
+ *  4/  i_logstart - to semi-verify inode found at i_location
+ *  5/  parent->i_logstart - maybe used to hunt for the file on disc
  *
  */
 struct dentry *fat_fh_to_dentry(struct super_block *sb, __u32 *fh,
@@ -435,7 +436,7 @@ struct dentry *fat_fh_to_dentry(struct s
 
 	if (fhtype != 3)
 		return ERR_PTR(-ESTALE);
-	if (len < 5)
+	if (len < 6)
 		return ERR_PTR(-ESTALE);
 	/* We cannot find the parent,
 	   It better just *be* there */
@@ -449,13 +450,15 @@ struct dentry *fat_fh_to_dentry(struct s
 		inode = NULL;
 	}
 	if (!inode) {
-		/* try 2 - see if i_location is in F-d-c
+		loff_t i_pos = ((loff_t)fh[2] << 32) | fh[3];
+
+		/* try 2 - see if i_pos is in F-d-c
 		 * require i_logstart to be the same
 		 * Will fail if you truncate and then re-write
 		 */
 
-		inode = fat_iget(sb, fh[2]);
-		if (inode && MSDOS_I(inode)->i_logstart != fh[3]) {
+		inode = fat_iget(sb, i_pos);
+		if (inode && MSDOS_I(inode)->i_logstart != fh[4]) {
 			iput(inode);
 			inode = NULL;
 		}
@@ -514,14 +517,15 @@ int fat_dentry_to_fh(struct dentry *de, 
 	int len = *lenp;
 	struct inode *inode =  de->d_inode;
 	
-	if (len < 5)
+	if (len < 6)
 		return 255; /* no room */
-	*lenp = 5;
+	*lenp = 6;
 	fh[0] = inode->i_ino;
 	fh[1] = inode->i_generation;
-	fh[2] = MSDOS_I(inode)->i_location;
-	fh[3] = MSDOS_I(inode)->i_logstart;
-	fh[4] = MSDOS_I(de->d_parent->d_inode)->i_logstart;
+	fh[2] = (__u32)(MSDOS_I(inode)->i_pos >> 32);
+	fh[3] = (__u32)MSDOS_I(inode)->i_pos;
+	fh[4] = MSDOS_I(inode)->i_logstart;
+	fh[5] = MSDOS_I(de->d_parent->d_inode)->i_logstart;
 	return 3;
 }
 
@@ -891,7 +895,7 @@ static void fat_fill_inode(struct inode 
 	int nr;
 
 	INIT_LIST_HEAD(&MSDOS_I(inode)->i_fat_hash);
-	MSDOS_I(inode)->i_location = 0;
+	MSDOS_I(inode)->i_pos = 0;
 	MSDOS_I(inode)->i_fat_inode = inode;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
@@ -906,10 +910,9 @@ static void fat_fill_inode(struct inode 
 		inode->i_fop = &fat_dir_operations;
 
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
-		if (sbi->fat_bits == 32) {
-			MSDOS_I(inode)->i_start |=
-				(CF_LE_W(de->starthi) << 16);
-		}
+		if (sbi->fat_bits == 32)
+			MSDOS_I(inode)->i_start |= (CF_LE_W(de->starthi) << 16);
+
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
 		inode->i_nlink = fat_subdirs(inode);
 		    /* includes .., compensating for "self" */
@@ -937,10 +940,9 @@ static void fat_fill_inode(struct inode 
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
 		    & ~sbi->options.fs_umask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
-		if (sbi->fat_bits == 32) {
-			MSDOS_I(inode)->i_start |=
-				(CF_LE_W(de->starthi) << 16);
-		}
+		if (sbi->fat_bits == 32)
+			MSDOS_I(inode)->i_start |= (CF_LE_W(de->starthi) << 16);
+
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
 		inode->i_size = CF_LE_L(de->size);
 	        inode->i_op = &fat_file_inode_operations;
@@ -970,22 +972,22 @@ void fat_write_inode(struct inode *inode
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
-	unsigned int i_pos;
+	loff_t i_pos;
 
 retry:
-	i_pos = MSDOS_I(inode)->i_location;
+	i_pos = MSDOS_I(inode)->i_pos;
 	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos) {
 		return;
 	}
 	lock_kernel();
 	if (!(bh = fat_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
-		printk("dev = %s, ino = %d\n", kdevname(inode->i_dev), i_pos);
+		printk("dev = %s, i_pos = %llu\n", kdevname(inode->i_dev), i_pos);
 		fat_fs_panic(sb, "msdos_write_inode: unable to read i-node block");
 		unlock_kernel();
 		return;
 	}
 	spin_lock(&fat_inode_lock);
-	if (i_pos != MSDOS_I(inode)->i_location) {
+	if (i_pos != MSDOS_I(inode)->i_pos) {
 		spin_unlock(&fat_inode_lock);
 		fat_brelse(sb, bh);
 		unlock_kernel();
diff -puN fs/fat/misc.c~fat_large-disk-2.4 fs/fat/misc.c
--- linux-2.4.24-bk1/fs/fat/misc.c~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/fs/fat/misc.c	2003-12-16 02:29:29.000000000 +0900
@@ -316,11 +316,12 @@ void fat_date_unix2dos(int unix_date,uns
  */
 
 int fat__get_entry(struct inode *dir, loff_t *pos,struct buffer_head **bh,
-    struct msdos_dir_entry **de, int *ino)
+		   struct msdos_dir_entry **de, loff_t *i_pos)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int sector, offset;
+	int sector;
+	loff_t offset;
 
 	while (1) {
 		offset = *pos;
@@ -343,7 +344,7 @@ int fat__get_entry(struct inode *dir, lo
 
 		offset &= sb->s_blocksize - 1;
 		*de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
-		*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
+		*i_pos = ((loff_t)sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
 
 		return 0;
 	}
@@ -383,7 +384,7 @@ int fat__get_entry(struct inode *dir, lo
     done = !IS_FREE(data[entry].name) \
       && ( \
            ( \
-             (MSDOS_SB(sb)->fat_bits != 32) ? 0 : (CF_LE_W(data[entry].starthi) << 16) \
+             (sbi->fat_bits != 32) ? 0 : (CF_LE_W(data[entry].starthi) << 16) \
            ) \
            | CF_LE_W(data[entry].start) \
          ) == *number;
@@ -400,35 +401,38 @@ int fat__get_entry(struct inode *dir, lo
 	    (*number)++; \
     }
 
-static int raw_scan_sector(struct super_block *sb,int sector,const char *name,
-    int *number,int *ino,struct buffer_head **res_bh,
-    struct msdos_dir_entry **res_de)
+static int raw_scan_sector(struct super_block *sb, int sector,
+			   const char *name, int *number, loff_t *i_pos,
+			   struct buffer_head **res_bh,
+			   struct msdos_dir_entry **res_de)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *data;
 	int entry,start,done;
 
-	if (!(bh = fat_bread(sb,sector)))
+	if (!(bh = fat_bread(sb, sector)))
 		return -EIO;
 	data = (struct msdos_dir_entry *) bh->b_data;
-	for (entry = 0; entry < MSDOS_SB(sb)->dir_per_block; entry++) {
+	for (entry = 0; entry < sbi->dir_per_block; entry++) {
 /* RSS_COUNT:  if (data[entry].name == name) done=true else done=false. */
 		if (name) {
 			RSS_NAME
 		} else {
-			if (!ino) RSS_COUNT
+			if (!i_pos) RSS_COUNT
 			else {
 				if (number) RSS_START
 				else RSS_FREE
 			}
 		}
 		if (done) {
-			if (ino)
-				*ino = sector * MSDOS_SB(sb)->dir_per_block + entry;
+			if (i_pos) {
+				*i_pos = ((loff_t)sector << sbi->dir_per_block_bits) + entry;
+			}
 			start = CF_LE_W(data[entry].start);
-			if (MSDOS_SB(sb)->fat_bits == 32) {
+			if (sbi->fat_bits == 32)
 				start |= (CF_LE_W(data[entry].starthi) << 16);
-			}
+
 			if (!res_bh)
 				fat_brelse(sb, bh);
 			else {
@@ -448,16 +452,19 @@ static int raw_scan_sector(struct super_
  * requested entry is found or the end of the directory is reached.
  */
 
-static int raw_scan_root(struct super_block *sb,const char *name,int *number,int *ino,
-    struct buffer_head **res_bh,struct msdos_dir_entry **res_de)
+static int raw_scan_root(struct super_block *sb, const char *name,
+			 int *number, loff_t *i_pos,
+			 struct buffer_head **res_bh,
+			 struct msdos_dir_entry **res_de)
 {
 	int count,cluster;
 
 	for (count = 0;
 	     count < MSDOS_SB(sb)->dir_entries / MSDOS_SB(sb)->dir_per_block;
 	     count++) {
-		if ((cluster = raw_scan_sector(sb,MSDOS_SB(sb)->dir_start+count,
-					       name,number,ino,res_bh,res_de)) >= 0)
+		cluster = raw_scan_sector(sb, MSDOS_SB(sb)->dir_start + count,
+					  name, number, i_pos, res_bh, res_de);
+		if (cluster >= 0)
 			return cluster;
 	}
 	return -ENOENT;
@@ -469,20 +476,24 @@ static int raw_scan_root(struct super_bl
  * requested entry is found or the end of the directory is reached.
  */
 
-static int raw_scan_nonroot(struct super_block *sb,int start,const char *name,
-    int *number,int *ino,struct buffer_head **res_bh,struct msdos_dir_entry
-    **res_de)
+static int raw_scan_nonroot(struct super_block *sb, int start, const char *name,
+			    int *number, loff_t *i_pos,
+			    struct buffer_head **res_bh,
+			    struct msdos_dir_entry **res_de)
 {
-	int count,cluster;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int count, cluster, sector;
 
 #ifdef DEBUG
 	printk("raw_scan_nonroot: start=%d\n",start);
 #endif
 	do {
-		for (count = 0; count < MSDOS_SB(sb)->cluster_size; count++) {
-			if ((cluster = raw_scan_sector(sb,(start-2)*
-			    MSDOS_SB(sb)->cluster_size+MSDOS_SB(sb)->data_start+
-			    count,name,number,ino,res_bh,res_de)) >= 0)
+		for (count = 0; count < sbi->cluster_size; count++) {
+			sector = (start - 2) * sbi->cluster_size
+				+ count + sbi->data_start;
+			cluster = raw_scan_sector(sb, sector, name, number,
+						  i_pos, res_bh, res_de);
+			if (cluster >= 0)
 				return cluster;
 		}
 		if (!(start = fat_access(sb,start,-1))) {
@@ -506,13 +517,13 @@ static int raw_scan_nonroot(struct super
  */
 
 static int raw_scan(struct super_block *sb, int start, const char *name,
-    int *number, int *ino, struct buffer_head **res_bh,
-    struct msdos_dir_entry **res_de)
+		    loff_t *i_pos, struct buffer_head **res_bh,
+		    struct msdos_dir_entry **res_de)
 {
 	if (start)
-		return raw_scan_nonroot(sb,start,name,number,ino,res_bh,res_de);
+		return raw_scan_nonroot(sb,start,name,NULL,i_pos,res_bh,res_de);
 	else
-		return raw_scan_root(sb,name,number,ino,res_bh,res_de);
+		return raw_scan_root(sb,name,NULL,i_pos,res_bh,res_de);
 }
 
 /*
@@ -521,19 +532,21 @@ static int raw_scan(struct super_block *
  */
 int fat_subdirs(struct inode *dir)
 {
-	int count;
+	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	int number;
 
-	count = 0;
-	if ((dir->i_ino == MSDOS_ROOT_INO) &&
-	    (MSDOS_SB(dir->i_sb)->fat_bits != 32)) {
-		(void) raw_scan_root(dir->i_sb,NULL,&count,NULL,NULL,NULL);
-	} else {
-		if ((dir->i_ino != MSDOS_ROOT_INO) &&
-		    !MSDOS_I(dir)->i_start) return 0; /* in mkdir */
-		else (void) raw_scan_nonroot(dir->i_sb,MSDOS_I(dir)->i_start,
-		    NULL,&count,NULL,NULL,NULL);
+	number = 0;
+	if ((dir->i_ino == MSDOS_ROOT_INO) && (sbi->fat_bits != 32))
+		raw_scan_root(dir->i_sb, NULL, &number, NULL, NULL, NULL);
+	else {
+		if ((dir->i_ino != MSDOS_ROOT_INO) && !MSDOS_I(dir)->i_start)
+			return 0; /* in mkdir */
+		else {
+			raw_scan_nonroot(dir->i_sb, MSDOS_I(dir)->i_start,
+					 NULL, &number, NULL, NULL, NULL);
+		}
 	}
-	return count;
+	return number;
 }
 
 
@@ -542,12 +555,12 @@ int fat_subdirs(struct inode *dir)
  * for an empty directory slot (name is NULL). Returns an error code or zero.
  */
 
-int fat_scan(struct inode *dir,const char *name,struct buffer_head **res_bh,
-    struct msdos_dir_entry **res_de,int *ino)
+int fat_scan(struct inode *dir, const char *name, struct buffer_head **res_bh,
+	     struct msdos_dir_entry **res_de, loff_t *i_pos)
 {
 	int res;
 
-	res = raw_scan(dir->i_sb,MSDOS_I(dir)->i_start,
-		       name, NULL, ino, res_bh, res_de);
-	return res<0 ? res : 0;
+	res = raw_scan(dir->i_sb, MSDOS_I(dir)->i_start, name, i_pos,
+		       res_bh, res_de);
+	return (res < 0) ? res : 0;
 }
diff -puN fs/msdos/namei.c~fat_large-disk-2.4 fs/msdos/namei.c
--- linux-2.4.24-bk1/fs/msdos/namei.c~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/fs/msdos/namei.c	2003-12-16 02:29:29.000000000 +0900
@@ -127,8 +127,9 @@ static int msdos_format_name(const char 
 }
 
 /***** Locates a directory entry.  Uses unformatted name. */
-static int msdos_find(struct inode *dir,const char *name,int len,
-    struct buffer_head **bh,struct msdos_dir_entry **de,int *ino)
+static int msdos_find(struct inode *dir, const char *name, int len,
+		      struct buffer_head **bh, struct msdos_dir_entry **de,
+		      loff_t *i_pos)
 {
 	int res;
 	char dotsOK;
@@ -138,7 +139,7 @@ static int msdos_find(struct inode *dir,
 	res = msdos_format_name(name,len, msdos_name,&MSDOS_SB(dir->i_sb)->options);
 	if (res < 0)
 		return -ENOENT;
-	res = fat_scan(dir,msdos_name,bh,de,ino);
+	res = fat_scan(dir, msdos_name, bh, de, i_pos);
 	if (!res && dotsOK) {
 		if (name[0]=='.') {
 			if (!((*de)->attr & ATTR_HIDDEN))
@@ -149,7 +150,6 @@ static int msdos_find(struct inode *dir,
 		}
 	}
 	return res;
-
 }
 
 /*
@@ -214,20 +214,20 @@ struct dentry *msdos_lookup(struct inode
 	struct inode *inode = NULL;
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh = NULL;
-	int ino,res;
+	loff_t i_pos;
+	int res;
 	
 	PRINTK (("msdos_lookup\n"));
 
 	dentry->d_op = &msdos_dentry_operations;
 
 	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &bh,
-			&de, &ino);
-
+			 &de, &i_pos);
 	if (res == -ENOENT)
 		goto add;
 	if (res < 0)
 		goto out;
-	inode = fat_build_inode(sb, de, ino, &res);
+	inode = fat_build_inode(sb, de, i_pos, &res);
 	if (res)
 		goto out;
 add:
@@ -243,13 +243,13 @@ out:
 static int msdos_add_entry(struct inode *dir, const char *name,
 			   struct buffer_head **bh,
 			   struct msdos_dir_entry **de,
-			   int *ino,
-			   int is_dir, int is_hid)
+			   loff_t *i_pos, int is_dir, int is_hid)
 {
 	struct super_block *sb = dir->i_sb;
 	int res;
 
-	if ((res = fat_add_entries(dir, 1, bh, de, ino))<0)
+	res = fat_add_entries(dir, 1, bh, de, i_pos);
+ 	if (res < 0)
 		return res;
 	/*
 	 * XXX all times should be set by caller upon successful completion.
@@ -279,7 +279,8 @@ int msdos_create(struct inode *dir,struc
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	struct inode *inode;
-	int ino,res,is_hid;
+	loff_t i_pos;
+	int res, is_hid;
 	char msdos_name[MSDOS_NAME];
 
 	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
@@ -288,15 +289,15 @@ int msdos_create(struct inode *dir,struc
 		return res;
 	is_hid = (dentry->d_name.name[0]=='.') && (msdos_name[0]!='.');
 	/* Have to do it due to foo vs. .foo conflicts */
-	if (fat_scan(dir,msdos_name,&bh,&de,&ino) >= 0) {
+	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0) {
 		fat_brelse(sb, bh);
 		return -EINVAL;
  	}
 	inode = NULL;
-	res = msdos_add_entry(dir, msdos_name, &bh, &de, &ino, 0, is_hid);
+	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 0, is_hid);
 	if (res)
 		return res;
-	inode = fat_build_inode(dir->i_sb, de, ino, &res);
+	inode = fat_build_inode(dir->i_sb, de, i_pos, &res);
 	fat_brelse(sb, bh);
 	if (!inode)
 		return res;
@@ -311,13 +312,14 @@ int msdos_rmdir(struct inode *dir, struc
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
-	int res,ino;
+	loff_t i_pos;
+	int res;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 
 	bh = NULL;
 	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len,
-				&bh, &de, &ino);
+			 &bh, &de, &i_pos);
 	if (res < 0)
 		goto rmdir_done;
 	/*
@@ -352,7 +354,7 @@ int msdos_mkdir(struct inode *dir,struct
 	struct inode *inode;
 	int res,is_hid;
 	char msdos_name[MSDOS_NAME];
-	int ino;
+	loff_t i_pos;
 
 	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
@@ -360,13 +362,13 @@ int msdos_mkdir(struct inode *dir,struct
 		return res;
 	is_hid = (dentry->d_name.name[0]=='.') && (msdos_name[0]!='.');
 	/* foo vs .foo situation */
-	if (fat_scan(dir,msdos_name,&bh,&de,&ino) >= 0)
+	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0)
 		goto out_exist;
 
-	res = msdos_add_entry(dir, msdos_name, &bh, &de, &ino, 1, is_hid);
+	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 1, is_hid);
 	if (res)
 		goto out_unlock;
-	inode = fat_build_inode(dir->i_sb, de, ino, &res);
+	inode = fat_build_inode(dir->i_sb, de, i_pos, &res);
 	if (!inode) {
 		fat_brelse(sb, bh);
 		goto out_unlock;
@@ -412,13 +414,14 @@ int msdos_unlink( struct inode *dir, str
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
-	int res,ino;
+	loff_t i_pos;
+	int res;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 
 	bh = NULL;
 	res = msdos_find(dir, dentry->d_name.name, dentry->d_name.len,
-			&bh, &de, &ino);
+			 &bh, &de, &i_pos);
 	if (res < 0)
 		goto unlink_done;
 
@@ -439,13 +442,13 @@ static int do_msdos_rename(struct inode 
     struct dentry *old_dentry,
     struct inode *new_dir,char *new_name, struct dentry *new_dentry,
     struct buffer_head *old_bh,
-    struct msdos_dir_entry *old_de, int old_ino, int is_hid)
+    struct msdos_dir_entry *old_de, loff_t old_i_pos, int is_hid)
 {
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *new_bh=NULL,*dotdot_bh=NULL;
 	struct msdos_dir_entry *new_de,*dotdot_de;
 	struct inode *old_inode,*new_inode;
-	int new_ino,dotdot_ino;
+	loff_t new_i_pos, dotdot_i_pos;
 	int error;
 	int is_dir;
 
@@ -453,7 +456,8 @@ static int do_msdos_rename(struct inode 
 	new_inode = new_dentry->d_inode;
 	is_dir = S_ISDIR(old_inode->i_mode);
 
-	if (fat_scan(new_dir,new_name,&new_bh,&new_de,&new_ino)>=0 &&!new_inode)
+	if (fat_scan(new_dir, new_name, &new_bh, &new_de, &new_i_pos) >= 0
+	    && !new_inode)
 		goto degenerate_case;
 	if (is_dir) {
 		if (new_inode) {
@@ -462,7 +466,7 @@ static int do_msdos_rename(struct inode 
 				goto out;
 		}
 		error = fat_scan(old_inode, MSDOS_DOTDOT, &dotdot_bh,
-				&dotdot_de, &dotdot_ino);
+				&dotdot_de, &dotdot_i_pos);
 		if (error < 0) {
 			printk(KERN_WARNING
 				"MSDOS: %s/%s, get dotdot failed, ret=%d\n",
@@ -473,7 +477,7 @@ static int do_msdos_rename(struct inode 
 	}
 	if (!new_bh) {
 		error = msdos_add_entry(new_dir, new_name, &new_bh, &new_de,
-					&new_ino, is_dir, is_hid);
+					&new_i_pos, is_dir, is_hid);
 		if (error)
 			goto out;
 	}
@@ -486,7 +490,7 @@ static int do_msdos_rename(struct inode 
 	old_de->name[0] = DELETED_FLAG;
 	fat_mark_buffer_dirty(sb, old_bh);
 	fat_detach(old_inode);
-	fat_attach(old_inode, new_ino);
+	fat_attach(old_inode, new_i_pos);
 	if (is_hid)
 		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
 	else
@@ -542,8 +546,8 @@ int msdos_rename(struct inode *old_dir,s
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh;
 	struct msdos_dir_entry *old_de;
-	int old_ino, error;
-	int is_hid,old_hid; /* if new file and old file are hidden */
+	loff_t old_i_pos;
+	int error, is_hid, old_hid; /* if new file and old file are hidden */
 	char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 
 	error = msdos_format_name(old_dentry->d_name.name,
@@ -559,13 +563,13 @@ int msdos_rename(struct inode *old_dir,s
 
 	is_hid  = (new_dentry->d_name.name[0]=='.') && (new_msdos_name[0]!='.');
 	old_hid = (old_dentry->d_name.name[0]=='.') && (old_msdos_name[0]!='.');
-	error = fat_scan(old_dir, old_msdos_name, &old_bh, &old_de, &old_ino);
+	error = fat_scan(old_dir, old_msdos_name, &old_bh, &old_de, &old_i_pos);
 	if (error < 0)
 		goto rename_done;
 
 	error = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
 				new_dir, new_msdos_name, new_dentry,
-				old_bh, old_de, (ino_t)old_ino, is_hid);
+				old_bh, old_de, old_i_pos, is_hid);
 	fat_brelse(sb, old_bh);
 
 rename_done:
diff -puN fs/vfat/namei.c~fat_large-disk-2.4 fs/vfat/namei.c
--- linux-2.4.24-bk1/fs/vfat/namei.c~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/fs/vfat/namei.c	2003-12-16 02:29:29.000000000 +0900
@@ -408,9 +408,10 @@ static int vfat_find_form(struct inode *
 {
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh = NULL;
-	int ino,res;
+	loff_t i_pos;
+	int res;
 
-	res=fat_scan(dir,name,&bh,&de,&ino);
+	res = fat_scan(dir, name, &bh, &de, &i_pos);
 	fat_brelse(dir->i_sb, bh);
 	if (res<0)
 		return -ENOENT;
@@ -891,7 +892,7 @@ static int vfat_add_entry(struct inode *
 	int res, len;
 	struct msdos_dir_entry *dummy_de;
 	struct buffer_head *dummy_bh;
-	int dummy_ino;
+	loff_t dummy_i_pos;
 	loff_t dummy;
 
 	dir_slots = (struct msdos_dir_slot *)
@@ -917,7 +918,7 @@ static int vfat_add_entry(struct inode *
 		goto cleanup;
 
 	/* build the empty directory entry of number of slots */
-	offset = fat_add_entries(dir, slots, &dummy_bh, &dummy_de, &dummy_ino);
+	offset = fat_add_entries(dir, slots, &dummy_bh, &dummy_de, &dummy_i_pos);
 	if (offset < 0) {
 		res = offset;
 		goto cleanup;
@@ -927,7 +928,7 @@ static int vfat_add_entry(struct inode *
 	/* Now create the new entry */
 	*bh = NULL;
 	for (slot = 0; slot < slots; slot++) {
-		if (fat_get_entry(dir, &offset, bh, de, &sinfo_out->ino) < 0) {
+		if (fat_get_entry(dir, &offset, bh, de, &sinfo_out->i_pos) < 0) {
 			res = -EIO;
 			goto cleanup;
 		}
@@ -972,7 +973,7 @@ static int vfat_find(struct inode *dir,s
 			&offset,&sinfo->longname_offset);
 	if (res>0) {
 		sinfo->long_slots = res-1;
-		if (fat_get_entry(dir,&offset,last_bh,last_de,&sinfo->ino)>=0)
+		if (fat_get_entry(dir,&offset,last_bh,last_de,&sinfo->i_pos)>=0)
 			return 0;
 		res = -EIO;
 	} 
@@ -1001,7 +1002,7 @@ struct dentry *vfat_lookup(struct inode 
 		table++;
 		goto error;
 	}
-	inode = fat_build_inode(dir->i_sb, de, sinfo.ino, &res);
+	inode = fat_build_inode(dir->i_sb, de, sinfo.i_pos, &res);
 	fat_brelse(dir->i_sb, bh);
 	if (res)
 		return ERR_PTR(res);
@@ -1034,7 +1035,7 @@ int vfat_create(struct inode *dir,struct
 	res = vfat_add_entry(dir, &dentry->d_name, 0, &sinfo, &bh, &de);
 	if (res < 0)
 		return res;
-	inode = fat_build_inode(sb, de, sinfo.ino, &res);
+	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
 	fat_brelse(sb, bh);
 	if (!inode)
 		return res;
@@ -1051,8 +1052,8 @@ static void vfat_remove_entry(struct ino
      struct buffer_head *bh, struct msdos_dir_entry *de)
 {
 	struct super_block *sb = dir->i_sb;
-	loff_t offset;
-	int i,ino;
+	loff_t offset, i_pos;
+	int i;
 
 	/* remove the shortname */
 	dir->i_mtime = CURRENT_TIME;
@@ -1064,7 +1065,7 @@ static void vfat_remove_entry(struct ino
 	/* remove the longname */
 	offset = sinfo->longname_offset; de = NULL;
 	for (i = sinfo->long_slots; i > 0; --i) {
-		if (fat_get_entry(dir, &offset, &bh, &de, &ino) < 0)
+		if (fat_get_entry(dir, &offset, &bh, &de, &i_pos) < 0)
 			continue;
 		de->name[0] = DELETED_FLAG;
 		de->attr = 0;
@@ -1133,7 +1134,7 @@ int vfat_mkdir(struct inode *dir,struct 
 	res = vfat_add_entry(dir, &dentry->d_name, 1, &sinfo, &bh, &de);
 	if (res < 0)
 		return res;
-	inode = fat_build_inode(sb, de, sinfo.ino, &res);
+	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
 	if (!inode)
 		goto out;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
@@ -1170,7 +1171,7 @@ int vfat_rename(struct inode *old_dir,st
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
 	struct msdos_dir_entry *old_de,*new_de,*dotdot_de;
-	int dotdot_ino;
+	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
 	int res, is_dir;
 	struct vfat_slot_info old_sinfo,sinfo;
@@ -1185,13 +1186,13 @@ int vfat_rename(struct inode *old_dir,st
 	is_dir = S_ISDIR(old_inode->i_mode);
 
 	if (is_dir && (res = fat_scan(old_inode,MSDOS_DOTDOT,&dotdot_bh,
-				&dotdot_de,&dotdot_ino)) < 0)
+				&dotdot_de,&dotdot_i_pos)) < 0)
 		goto rename_done;
 
 	if (new_dentry->d_inode) {
 		res = vfat_find(new_dir,&new_dentry->d_name,&sinfo,&new_bh,
 				&new_de);
-		if (res < 0 || MSDOS_I(new_inode)->i_location != sinfo.ino) {
+		if (res < 0 || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
 			goto rename_done;
@@ -1215,7 +1216,7 @@ int vfat_rename(struct inode *old_dir,st
 	vfat_remove_entry(old_dir,&old_sinfo,old_bh,old_de);
 	old_bh=NULL;
 	fat_detach(old_inode);
-	fat_attach(old_inode, sinfo.ino);
+	fat_attach(old_inode, sinfo.i_pos);
 	mark_inode_dirty(old_inode);
 
 	old_dir->i_version = ++event;
diff -puN include/linux/msdos_fs.h~fat_large-disk-2.4 include/linux/msdos_fs.h
--- linux-2.4.24-bk1/include/linux/msdos_fs.h~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/include/linux/msdos_fs.h	2003-12-16 02:29:29.000000000 +0900
@@ -180,7 +180,7 @@ struct vfat_slot_info {
 	int total_slots;	       /* total slots (long and short) */
 	loff_t longname_offset;	       /* dir offset for longname start */
 	loff_t shortname_offset;       /* dir offset for shortname start */
-	int ino;		       /* ino for the file */
+	loff_t i_pos;		       /* on-disk position of directory entry */
 };
 
 /* Determine whether this FS has kB-aligned data. */
@@ -264,7 +264,7 @@ extern int fat_dir_ioctl(struct inode * 
 			 unsigned int cmd, unsigned long arg);
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_add_entries(struct inode *dir, int slots, struct buffer_head **bh,
-			   struct msdos_dir_entry **de, int *ino);
+			struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat);
 
 /* fat/file.c */
@@ -280,11 +280,11 @@ extern void fat_truncate(struct inode *i
 
 /* fat/inode.c */
 extern void fat_hash_init(void);
-extern void fat_attach(struct inode *inode, int i_pos);
+extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
-extern struct inode *fat_iget(struct super_block *sb, int i_pos);
+extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
-				     struct msdos_dir_entry *de, int ino, int *res);
+			struct msdos_dir_entry *de, loff_t i_pos, int *res);
 extern void fat_delete_inode(struct inode *inode);
 extern void fat_clear_inode(struct inode *inode);
 extern void fat_put_super(struct super_block *sb);
@@ -306,26 +306,27 @@ extern struct buffer_head *fat_extend_di
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, unsigned short *time,
 			      unsigned short *date);
-extern int fat__get_entry(struct inode *dir, loff_t *pos, struct buffer_head **bh,
-			  struct msdos_dir_entry **de, int *ino);
+extern int fat__get_entry(struct inode *dir, loff_t *pos,
+			  struct buffer_head **bh,
+			  struct msdos_dir_entry **de, loff_t *i_pos);
 static __inline__ int fat_get_entry(struct inode *dir, loff_t *pos,
 				    struct buffer_head **bh,
-				    struct msdos_dir_entry **de, int *ino)
+				    struct msdos_dir_entry **de, loff_t *i_pos)
 {
 	/* Fast stuff first */
 	if (*bh && *de &&
 	    (*de - (struct msdos_dir_entry *)(*bh)->b_data) < MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
 		*pos += sizeof(struct msdos_dir_entry);
 		(*de)++;
-		(*ino)++;
+		(*i_pos)++;
 		return 0;
 	}
-	return fat__get_entry(dir,pos,bh,de,ino);
+	return fat__get_entry(dir, pos, bh, de, i_pos);
 }
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const char *name,
 		    struct buffer_head **res_bh,
-		    struct msdos_dir_entry **res_de, int *ino);
+		    struct msdos_dir_entry **res_de, loff_t *i_pos);
 
 /* msdos/namei.c  - these are for Umsdos */
 extern void msdos_put_super(struct super_block *sb);
diff -puN include/linux/msdos_fs_i.h~fat_large-disk-2.4 include/linux/msdos_fs_i.h
--- linux-2.4.24-bk1/include/linux/msdos_fs_i.h~fat_large-disk-2.4	2003-12-16 02:29:29.000000000 +0900
+++ linux-2.4.24-bk1-hirofumi/include/linux/msdos_fs_i.h	2003-12-16 02:29:29.000000000 +0900
@@ -11,7 +11,7 @@ struct msdos_inode_info {
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
 	int i_ctime_ms;	/* unused change time in milliseconds */
-	int i_location;	/* on-disk position of directory entry or 0 */
+	loff_t i_pos;	/* on-disk position of directory entry or 0 */
 	struct inode *i_fat_inode;	/* struct inode of this one */
 	struct list_head i_fat_hash;	/* hash by i_location */
 };

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
