Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289136AbSANK1x>; Mon, 14 Jan 2002 05:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289177AbSANK1o>; Mon, 14 Jan 2002 05:27:44 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:54543 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S289136AbSANK1b>; Mon, 14 Jan 2002 05:27:31 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Marius Gedminas <mgedmin@centras.lt>, linux-kernel@vger.kernel.org
Subject: Re: Hard lock when mounting loopback file
In-Reply-To: <3C3F3267.7050103@actarg.com> <3C413BF0.24576AEC@zip.com.au>
	<3C413BF0.24576AEC@zip.com.au> <20020113115230.GB1955@gintaras>
	<3C41EF9E.8D05D8F7@zip.com.au>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 14 Jan 2002 19:26:11 +0900
In-Reply-To: <3C41EF9E.8D05D8F7@zip.com.au>
Message-ID: <87u1tp44ak.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> > Additional check on the number of followed links could be useful there.
> > No chain should be longer than the number of clusters on the fs.
> > Although on large FAT32 filesystems the number of clusters can be high,
> > a very long loop is still better than an infinite one.  (In cases where
> > we know the file size, this limit can be reduced to
> > file_size/cluster_size + 1 links).
> 
> hmm..  OK, I'll take a look at that approach.

The maximum number of directory entries is 65536 in ordinarily.  The
following patch prevents the infinite loop of a directory (include the
limit to added directory).

I think the following patch is a bit useful.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.2-pre11/fs/fat/dir.c fat_loop/fs/fat/dir.c
--- linux-2.5.2-pre11/fs/fat/dir.c	Sat Oct 13 05:48:42 2001
+++ fat_loop/fs/fat/dir.c	Mon Jan 14 17:40:48 2002
@@ -727,7 +727,13 @@
 	offset = curr = 0;
 	*bh = NULL;
 	row = 0;
-	while (fat_get_entry(dir,&curr,bh,de,ino) > -1) {
+	while (fat_get_entry(dir, &curr, bh, de, ino) > -1) {
+		/* check the maximum size of directory */
+		if (curr >= FAT_MAX_DIR_SIZE) {
+			fat_brelse(sb, *bh);
+			return -ENOSPC;
+		}
+
 		if (IS_FREE((*de)->name)) {
 			if (++row == slots)
 				return offset;
@@ -742,7 +748,10 @@
 	if (!new_bh)
 		return -ENOSPC;
 	fat_brelse(sb, new_bh);
-	do fat_get_entry(dir,&curr,bh,de,ino); while (++row<slots);
+	do {
+		fat_get_entry(dir, &curr, bh, de, ino);
+	} while (++row < slots);
+
 	return offset;
 }
 
diff -urN linux-2.5.2-pre11/fs/fat/inode.c fat_loop/fs/fat/inode.c
--- linux-2.5.2-pre11/fs/fat/inode.c	Mon Jan 14 18:35:34 2002
+++ fat_loop/fs/fat/inode.c	Mon Jan 14 03:45:33 2002
@@ -373,11 +373,37 @@
 	return ret;
 }
 
+static void fat_calc_dir_size(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	int nr;
+
+	inode->i_size = 0;
+	if (MSDOS_I(inode)->i_start == 0)
+		return;
+
+	nr = MSDOS_I(inode)->i_start;
+	do {
+		inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
+		if (!(nr = fat_access(sb, nr, -1))) {
+			printk("FAT: Directory %ld: bad FAT\n",
+			       inode->i_ino);
+			break;
+		}
+		if (inode->i_size > FAT_MAX_DIR_SIZE) {
+			fat_fs_panic(sb, "Directory %ld: "
+				     "exceeded the maximum size of directory",
+				     inode->i_ino);
+			inode->i_size = FAT_MAX_DIR_SIZE;
+			break;
+		}
+	} while (nr != -1);
+}
+
 static void fat_read_root(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int nr;
 
 	INIT_LIST_HEAD(&MSDOS_I(inode)->i_fat_hash);
 	MSDOS_I(inode)->i_location = 0;
@@ -391,16 +417,7 @@
 	inode->i_fop = &fat_dir_operations;
 	if (sbi->fat_bits == 32) {
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
-		if ((nr = MSDOS_I(inode)->i_start) != 0) {
-			while (nr != -1) {
-				inode->i_size += 1 << sbi->cluster_bits;
-				if (!(nr = fat_access(sb, nr, -1))) {
-					printk("Directory %ld: bad FAT\n",
-					       inode->i_ino);
-					break;
-				}
-			}
-		}
+		fat_calc_dir_size(inode);
 	} else {
 		MSDOS_I(inode)->i_start = 0;
 		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
@@ -882,7 +899,6 @@
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int nr;
 
 	INIT_LIST_HEAD(&MSDOS_I(inode)->i_fat_hash);
 	MSDOS_I(inode)->i_location = 0;
@@ -913,15 +929,7 @@
 			inode->i_nlink = 1;
 		}
 #endif
-		if ((nr = MSDOS_I(inode)->i_start) != 0)
-			while (nr != -1) {
-				inode->i_size += 1 << sbi->cluster_bits;
-				if (!(nr = fat_access(sb, nr, -1))) {
-					printk("Directory %ld: bad FAT\n",
-					    inode->i_ino);
-					break;
-				}
-			}
+		fat_calc_dir_size(inode);
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	} else { /* not a directory */
 		inode->i_generation |= 1;
diff -urN linux-2.5.2-pre11/fs/fat/misc.c fat_loop/fs/fat/misc.c
--- linux-2.5.2-pre11/fs/fat/misc.c	Mon Jan 14 18:35:34 2002
+++ fat_loop/fs/fat/misc.c	Mon Jan 14 06:13:24 2002
@@ -38,15 +38,25 @@
  * read-only. The file system can be made writable again by remounting it.
  */
 
-void fat_fs_panic(struct super_block *s,const char *msg)
+static char panic_msg[512];
+
+void fat_fs_panic(struct super_block *s, const char *fmt, ...)
 {
 	int not_ro;
+	va_list args;
+
+	va_start (args, fmt);
+	vsnprintf (panic_msg, sizeof(panic_msg), fmt, args);
+	va_end (args);
 
 	not_ro = !(s->s_flags & MS_RDONLY);
-	if (not_ro) s->s_flags |= MS_RDONLY;
-	printk("Filesystem panic (dev %s).\n  %s\n", s->s_id, msg);
 	if (not_ro)
-		printk("  File system has been set read-only\n");
+		s->s_flags |= MS_RDONLY;
+
+	printk("FAT: Filesystem panic (dev %s)\n"
+	       "    %s\n", s->s_id, panic_msg);
+	if (not_ro)
+		printk("    File system has been set read-only\n");
 }
 
 
@@ -472,11 +482,13 @@
     int *number,int *ino,struct buffer_head **res_bh,struct msdos_dir_entry
     **res_de)
 {
-	int count,cluster;
+	int count, cluster;
+	unsigned long dir_size;
 
 #ifdef DEBUG
 	printk("raw_scan_nonroot: start=%d\n",start);
 #endif
+	dir_size = 0;
 	do {
 		for (count = 0; count < MSDOS_SB(sb)->cluster_size; count++) {
 			if ((cluster = raw_scan_sector(sb,(start-2)*
@@ -484,6 +496,13 @@
 			    count,name,number,ino,res_bh,res_de)) >= 0)
 				return cluster;
 		}
+		dir_size += 1 << MSDOS_SB(sb)->cluster_bits;
+		if (dir_size > FAT_MAX_DIR_SIZE) {
+			fat_fs_panic(sb, "Directory %d: "
+				     "exceeded the maximum size of directory",
+				     start);
+			break;
+		}
 		if (!(start = fat_access(sb,start,-1))) {
 			fat_fs_panic(sb,"FAT error");
 			break;
@@ -491,8 +510,8 @@
 #ifdef DEBUG
 	printk("next start: %d\n",start);
 #endif
-	}
-	while (start != -1);
+	} while (start != -1);
+
 	return -ENOENT;
 }
 
diff -urN linux-2.5.2-pre11/include/linux/msdos_fs.h fat_loop/include/linux/msdos_fs.h
--- linux-2.5.2-pre11/include/linux/msdos_fs.h	Mon Jan 14 18:35:41 2002
+++ fat_loop/include/linux/msdos_fs.h	Mon Jan 14 05:33:06 2002
@@ -19,6 +19,10 @@
 #define MSDOS_DPS_BITS	4 /* log2(MSDOS_DPS) */
 #define MSDOS_DIR_BITS	5 /* log2(sizeof(struct msdos_dir_entry)) */
 
+/* directory limit */
+#define FAT_MAX_DIR_ENTRIES	(65536)
+#define FAT_MAX_DIR_SIZE	(FAT_MAX_DIR_ENTRIES << MSDOS_DIR_BITS)
+
 #define MSDOS_SUPER_MAGIC 0x4d44 /* MD */
 
 #define FAT_CACHE    8 /* FAT cache size */
@@ -297,7 +301,7 @@
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
 /* fat/misc.c */
-extern void fat_fs_panic(struct super_block *s, const char *msg);
+extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
 extern int fat_is_binary(char conversion, char *extension);
 extern void lock_fat(struct super_block *sb);
 extern void unlock_fat(struct super_block *sb);
