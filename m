Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLEQIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLEQIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:08:18 -0500
Received: from codepoet.org ([166.70.99.138]:51601 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264238AbTLEQHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:07:52 -0500
Date: Fri, 5 Dec 2003 09:07:47 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Torsten Scheck <torsten.scheck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
Message-ID: <20031205160746.GA18568@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Torsten Scheck <torsten.scheck@gmx.de>, linux-kernel@vger.kernel.org
References: <3FD0555F.5060608@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD0555F.5060608@gmx.de>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 05, 2003 at 10:52:31AM +0100, Torsten Scheck wrote:
> Dear friends:
> 
> I already sent a message to the VFAT maintainer, but I decided
> to additionally bother this list with a warning. This way some
> readers might avoid data loss.
> 
> 
> I found a critical FAT32 bug when I tried to store data onto an
> internal IDE 160 GB and onto an external USB2/FW-250 GB hard
> disk.

Does this help?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


diff -urN linux-2.4.21.rc4/fs/fat/dir.c linux-2.4.20/fs/fat/dir.c
--- linux-2.4.21.rc4/fs/fat/dir.c	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/fs/fat/dir.c	2003-05-24 01:25:01.000000000 -0600
@@ -198,8 +198,8 @@
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	int ino, chl, i, j, last_u, res = 0;
-	loff_t cpos = 0;
+	int chl, i, j, last_u, res = 0;
+	loff_t ino, cpos = 0;
 
 	while(1) {
 		if (fat_get_entry(inode,&cpos,&bh,&de,&ino) == -1)
@@ -362,14 +362,14 @@
 	unsigned char long_slots;
 	wchar_t *unicode = NULL;
 	char c, work[8], bufname[56], *ptname = bufname;
-	unsigned long lpos, dummy, *furrfu = &lpos;
+	loff_t lpos, dummy, *furrfu = &lpos;
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int isvfat = MSDOS_SB(sb)->options.isvfat;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	int nocase = MSDOS_SB(sb)->options.nocase;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
-	int ino, inum, chi, chl, i, i2, j, last, last_u, dotoffset = 0;
-	loff_t cpos;
+	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
+	loff_t ino, inum, cpos;
 
 	cpos = filp->f_pos;
 /* Fake . and .. for the root directory. */
@@ -693,7 +693,8 @@
 	loff_t pos;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
-	int ino,result = 0;
+	int result = 0;
+	loff_t ino;
 
 	pos = 0;
 	bh = NULL;
@@ -717,7 +718,7 @@
 /* This assumes that size of cluster is above the 32*slots */
 
 int fat_add_entries(struct inode *dir,int slots, struct buffer_head **bh,
-		  struct msdos_dir_entry **de, int *ino)
+		  struct msdos_dir_entry **de, loff_t *ino)
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset, curr;
diff -urN linux-2.4.21.rc4/fs/fat/inode.c linux-2.4.20/fs/fat/inode.c
--- linux-2.4.21.rc4/fs/fat/inode.c	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/fs/fat/inode.c	2003-05-24 02:29:05.000000000 -0600
@@ -83,14 +83,14 @@
 	}
 }
 
-static inline unsigned long fat_hash(struct super_block *sb, int i_pos)
+static inline unsigned long fat_hash(struct super_block *sb, loff_t i_pos)
 {
-	unsigned long tmp = (unsigned long)i_pos | (unsigned long) sb;
+	loff_t tmp = (loff_t)i_pos | (unsigned long) sb;
 	tmp = tmp + (tmp >> FAT_HASH_BITS) + (tmp >> FAT_HASH_BITS * 2);
 	return tmp & FAT_HASH_MASK;
 }
 
-void fat_attach(struct inode *inode, int i_pos)
+void fat_attach(struct inode *inode, loff_t i_pos)
 {
 	spin_lock(&fat_inode_lock);
 	MSDOS_I(inode)->i_location = i_pos;
@@ -108,7 +108,7 @@
 	spin_unlock(&fat_inode_lock);
 }
 
-struct inode *fat_iget(struct super_block *sb, int i_pos)
+struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
 	struct list_head *p = fat_inode_hashtable + fat_hash(sb, i_pos);
 	struct list_head *walk;
@@ -133,7 +133,7 @@
 static void fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
 
 struct inode *fat_build_inode(struct super_block *sb,
-				struct msdos_dir_entry *de, int ino, int *res)
+				struct msdos_dir_entry *de, loff_t ino, int *res)
 {
 	struct inode *inode;
 	*res = 0;
@@ -552,8 +552,8 @@
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	char *p;
-	int logical_sector_size, hard_blksize, fat_clusters = 0;
-	unsigned int total_sectors, rootdir_sectors;
+	long logical_sector_size, hard_blksize, fat_clusters = 0;
+	long total_sectors, rootdir_sectors;
 	int fat32, debug, error, fat, cp;
 	struct fat_mount_options opts;
 	char buf[50];
@@ -613,7 +613,7 @@
 		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
 	if (!logical_sector_size
 	    || (logical_sector_size & (logical_sector_size - 1))) {
-		printk("FAT: bogus logical sector size %d\n",
+		printk("FAT: bogus logical sector size %ld\n",
 		       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
@@ -629,7 +629,7 @@
 
 	if (logical_sector_size < hard_blksize) {
 		printk("FAT: logical sector size too small for device"
-		       " (logical sector size = %d)\n", logical_sector_size);
+		       " (logical sector size = %ld)\n", logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -739,14 +739,14 @@
 		       opts.conversion,opts.fs_uid,opts.fs_gid,opts.fs_umask,
 		       MSDOS_CAN_BMAP(sbi) ? ",bmap" : "");
 		printk("[me=0x%x,cs=%d,#f=%d,fs=%d,fl=%ld,ds=%ld,de=%d,data=%ld,"
-		       "se=%u,ts=%u,ls=%d,rc=%ld,fc=%u]\n",
+		       "se=%u,ts=%u,ls=%ld,rc=%ld,fc=%u]\n",
 		       b->media, sbi->cluster_size, sbi->fats,
 		       sbi->fat_start, sbi->fat_length, sbi->dir_start,
 		       sbi->dir_entries, sbi->data_start,
 		       CF_LE_W(get_unaligned((unsigned short *)&b->sectors)),
 		       CF_LE_L(b->total_sect), logical_sector_size,
 		       sbi->root_cluster, sbi->free_clusters);
-		printk ("hard sector size = %d\n", hard_blksize);
+		printk ("hard sector size = %ld\n", hard_blksize);
 	}
 	if (i < 0)
 		if (sbi->clusters + 2 > fat_clusters)
@@ -971,7 +971,7 @@
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
-	unsigned int i_pos;
+	loff_t i_pos;
 
 retry:
 	i_pos = MSDOS_I(inode)->i_location;
@@ -980,7 +980,7 @@
 	}
 	lock_kernel();
 	if (!(bh = fat_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
-		printk("dev = %s, ino = %d\n", kdevname(inode->i_dev), i_pos);
+		printk("dev = %s, ino = %lld\n", kdevname(inode->i_dev), (unsigned long long)i_pos);
 		fat_fs_panic(sb, "msdos_write_inode: unable to read i-node block");
 		unlock_kernel();
 		return;
diff -urN linux-2.4.21.rc4/fs/fat/misc.c linux-2.4.20/fs/fat/misc.c
--- linux-2.4.21.rc4/fs/fat/misc.c	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/fs/fat/misc.c	2003-05-24 02:25:19.000000000 -0600
@@ -316,11 +316,11 @@
  */
 
 int fat__get_entry(struct inode *dir, loff_t *pos,struct buffer_head **bh,
-    struct msdos_dir_entry **de, int *ino)
+    struct msdos_dir_entry **de, loff_t *ino)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int sector, offset;
+	long long sector, offset;
 
 	while (1) {
 		offset = *pos;
@@ -336,7 +336,7 @@
 			return -1; /* beyond EOF */
 		*pos += sizeof(struct msdos_dir_entry);
 		if (!(*bh = fat_bread(sb, sector))) {
-			printk("Directory sread (sector 0x%x) failed\n",sector);
+			printk("Directory sread (sector 0x%llx) failed\n",sector);
 			continue;
 		}
 		PRINTK (("get_entry apres sread\n"));
@@ -400,8 +400,8 @@
 	    (*number)++; \
     }
 
-static int raw_scan_sector(struct super_block *sb,int sector,const char *name,
-    int *number,int *ino,struct buffer_head **res_bh,
+static int raw_scan_sector(struct super_block *sb,long long sector,
+    const char *name, int *number,loff_t *ino,struct buffer_head **res_bh,
     struct msdos_dir_entry **res_de)
 {
 	struct buffer_head *bh;
@@ -448,7 +448,7 @@
  * requested entry is found or the end of the directory is reached.
  */
 
-static int raw_scan_root(struct super_block *sb,const char *name,int *number,int *ino,
+static int raw_scan_root(struct super_block *sb,const char *name,int *number,loff_t *ino,
     struct buffer_head **res_bh,struct msdos_dir_entry **res_de)
 {
 	int count,cluster;
@@ -470,7 +470,7 @@
  */
 
 static int raw_scan_nonroot(struct super_block *sb,int start,const char *name,
-    int *number,int *ino,struct buffer_head **res_bh,struct msdos_dir_entry
+    int *number,loff_t *ino,struct buffer_head **res_bh,struct msdos_dir_entry
     **res_de)
 {
 	int count,cluster;
@@ -506,7 +506,7 @@
  */
 
 static int raw_scan(struct super_block *sb, int start, const char *name,
-    int *number, int *ino, struct buffer_head **res_bh,
+    int *number, loff_t *ino, struct buffer_head **res_bh,
     struct msdos_dir_entry **res_de)
 {
 	if (start)
@@ -543,7 +543,7 @@
  */
 
 int fat_scan(struct inode *dir,const char *name,struct buffer_head **res_bh,
-    struct msdos_dir_entry **res_de,int *ino)
+    struct msdos_dir_entry **res_de,loff_t *ino)
 {
 	int res;
 
diff -urN linux-2.4.21.rc4/fs/msdos/namei.c linux-2.4.20/fs/msdos/namei.c
--- linux-2.4.21.rc4/fs/msdos/namei.c	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/fs/msdos/namei.c	2003-05-24 01:25:01.000000000 -0600
@@ -128,7 +128,7 @@
 
 /***** Locates a directory entry.  Uses unformatted name. */
 static int msdos_find(struct inode *dir,const char *name,int len,
-    struct buffer_head **bh,struct msdos_dir_entry **de,int *ino)
+    struct buffer_head **bh,struct msdos_dir_entry **de,loff_t *ino)
 {
 	int res;
 	char dotsOK;
@@ -214,7 +214,8 @@
 	struct inode *inode = NULL;
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh = NULL;
-	int ino,res;
+	int res;
+	loff_t ino;
 	
 	PRINTK (("msdos_lookup\n"));
 
@@ -243,7 +244,7 @@
 static int msdos_add_entry(struct inode *dir, const char *name,
 			   struct buffer_head **bh,
 			   struct msdos_dir_entry **de,
-			   int *ino,
+			   loff_t *ino,
 			   int is_dir, int is_hid)
 {
 	struct super_block *sb = dir->i_sb;
@@ -279,7 +280,8 @@
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	struct inode *inode;
-	int ino,res,is_hid;
+	int res,is_hid;
+	loff_t ino;
 	char msdos_name[MSDOS_NAME];
 
 	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
@@ -311,7 +313,8 @@
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
-	int res,ino;
+	int res;
+	loff_t ino;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 
@@ -352,7 +355,7 @@
 	struct inode *inode;
 	int res,is_hid;
 	char msdos_name[MSDOS_NAME];
-	int ino;
+	loff_t ino;
 
 	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
@@ -412,7 +415,8 @@
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
-	int res,ino;
+	int res;
+	loff_t ino;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 
@@ -439,13 +443,13 @@
     struct dentry *old_dentry,
     struct inode *new_dir,char *new_name, struct dentry *new_dentry,
     struct buffer_head *old_bh,
-    struct msdos_dir_entry *old_de, int old_ino, int is_hid)
+    struct msdos_dir_entry *old_de, loff_t old_ino, int is_hid)
 {
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *new_bh=NULL,*dotdot_bh=NULL;
 	struct msdos_dir_entry *new_de,*dotdot_de;
 	struct inode *old_inode,*new_inode;
-	int new_ino,dotdot_ino;
+	loff_t new_ino,dotdot_ino;
 	int error;
 	int is_dir;
 
@@ -542,7 +546,8 @@
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh;
 	struct msdos_dir_entry *old_de;
-	int old_ino, error;
+	int error;
+	loff_t old_ino;
 	int is_hid,old_hid; /* if new file and old file are hidden */
 	char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 
@@ -565,7 +570,7 @@
 
 	error = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
 				new_dir, new_msdos_name, new_dentry,
-				old_bh, old_de, (ino_t)old_ino, is_hid);
+				old_bh, old_de, old_ino, is_hid);
 	fat_brelse(sb, old_bh);
 
 rename_done:
diff -urN linux-2.4.21.rc4/fs/vfat/namei.c linux-2.4.20/fs/vfat/namei.c
--- linux-2.4.21.rc4/fs/vfat/namei.c	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/fs/vfat/namei.c	2003-05-24 01:25:01.000000000 -0600
@@ -408,7 +408,8 @@
 {
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh = NULL;
-	int ino,res;
+	int res;
+	loff_t ino;
 
 	res=fat_scan(dir,name,&bh,&de,&ino);
 	fat_brelse(dir->i_sb, bh);
@@ -891,7 +892,7 @@
 	int res, len;
 	struct msdos_dir_entry *dummy_de;
 	struct buffer_head *dummy_bh;
-	int dummy_ino;
+	loff_t dummy_ino;
 	loff_t dummy;
 
 	dir_slots = (struct msdos_dir_slot *)
@@ -1052,7 +1053,8 @@
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset;
-	int i,ino;
+	int i;
+	loff_t ino;
 
 	/* remove the shortname */
 	dir->i_mtime = CURRENT_TIME;
@@ -1170,7 +1172,7 @@
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
 	struct msdos_dir_entry *old_de,*new_de,*dotdot_de;
-	int dotdot_ino;
+	loff_t dotdot_ino;
 	struct inode *old_inode, *new_inode;
 	int res, is_dir;
 	struct vfat_slot_info old_sinfo,sinfo;
diff -urN linux-2.4.21.rc4/include/linux/msdos_fs.h linux-2.4.20/include/linux/msdos_fs.h
--- linux-2.4.21.rc4/include/linux/msdos_fs.h	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/include/linux/msdos_fs.h	2003-05-24 01:25:01.000000000 -0600
@@ -180,7 +180,7 @@
 	int total_slots;	       /* total slots (long and short) */
 	loff_t longname_offset;	       /* dir offset for longname start */
 	loff_t shortname_offset;       /* dir offset for shortname start */
-	int ino;		       /* ino for the file */
+	loff_t ino;		       /* ino for the file */
 };
 
 /* Determine whether this FS has kB-aligned data. */
@@ -264,7 +264,7 @@
 			 unsigned int cmd, unsigned long arg);
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_add_entries(struct inode *dir, int slots, struct buffer_head **bh,
-			   struct msdos_dir_entry **de, int *ino);
+			   struct msdos_dir_entry **de, loff_t *ino);
 extern int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat);
 
 /* fat/file.c */
@@ -280,11 +280,11 @@
 
 /* fat/inode.c */
 extern void fat_hash_init(void);
-extern void fat_attach(struct inode *inode, int i_pos);
+extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
-extern struct inode *fat_iget(struct super_block *sb, int i_pos);
+extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
-				     struct msdos_dir_entry *de, int ino, int *res);
+				     struct msdos_dir_entry *de, loff_t ino, int *res);
 extern void fat_delete_inode(struct inode *inode);
 extern void fat_clear_inode(struct inode *inode);
 extern void fat_put_super(struct super_block *sb);
@@ -307,10 +307,10 @@
 extern void fat_date_unix2dos(int unix_date, unsigned short *time,
 			      unsigned short *date);
 extern int fat__get_entry(struct inode *dir, loff_t *pos, struct buffer_head **bh,
-			  struct msdos_dir_entry **de, int *ino);
+			  struct msdos_dir_entry **de, loff_t *ino);
 static __inline__ int fat_get_entry(struct inode *dir, loff_t *pos,
 				    struct buffer_head **bh,
-				    struct msdos_dir_entry **de, int *ino)
+				    struct msdos_dir_entry **de, loff_t *ino)
 {
 	/* Fast stuff first */
 	if (*bh && *de &&
@@ -325,7 +325,7 @@
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const char *name,
 		    struct buffer_head **res_bh,
-		    struct msdos_dir_entry **res_de, int *ino);
+		    struct msdos_dir_entry **res_de, loff_t *ino);
 
 /* msdos/namei.c  - these are for Umsdos */
 extern void msdos_put_super(struct super_block *sb);
diff -urN linux-2.4.21.rc4/include/linux/msdos_fs_i.h linux-2.4.20/include/linux/msdos_fs_i.h
--- linux-2.4.21.rc4/include/linux/msdos_fs_i.h	2003-05-24 02:31:40.000000000 -0600
+++ linux-2.4.20/include/linux/msdos_fs_i.h	2003-05-24 01:25:01.000000000 -0600
@@ -11,7 +11,7 @@
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
 	int i_ctime_ms;	/* unused change time in milliseconds */
-	int i_location;	/* on-disk position of directory entry or 0 */
+	loff_t i_location;		/* on-disk position of directory entry or 0 */
 	struct inode *i_fat_inode;	/* struct inode of this one */
 	struct list_head i_fat_hash;	/* hash by i_location */
 };
--- orig/fs/buffer.c	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/fs/buffer.c	2003-11-19 12:16:51.000000000 -0700
@@ -1903,7 +1903,7 @@
  * We may have to extend the file.
  */
 
-int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, unsigned long *bytes)
+int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
--- orig/fs/fat/file.c	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/fs/fat/file.c	2003-11-19 12:16:51.000000000 -0700
@@ -62,7 +62,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
--- orig/fs/fat/inode.c	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/fs/fat/inode.c	2003-11-19 12:16:51.000000000 -0700
@@ -406,7 +406,7 @@
 	}
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -647,6 +647,7 @@
 		fat32 = 1;
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
+		sb->s_maxbytes = 0xffffffff;
 
 		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		/* MC - if info_sector is 0, don't multiply by 0 */
@@ -955,7 +956,7 @@
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
--- orig/include/linux/adfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/adfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
@@ -11,7 +11,7 @@
  * adfs file system inode data in memory
  */
 struct adfs_inode_info {
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 	unsigned long	parent_id;	/* object id of parent		*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
--- orig/include/linux/affs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/affs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
@@ -36,7 +36,7 @@
 	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
 	u32	 i_ext_last;			/* last accessed extended block */
 	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	unsigned long mmu_private;
+	loff_t	 mmu_private;
 	u32	 i_protect;			/* unused attribute bits */
 	u32	 i_lastalloc;			/* last allocated block */
 	int	 i_pa_cnt;			/* number of preallocated blocks */
--- orig/include/linux/fs.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/fs.h	2003-11-19 12:16:51.000000000 -0700
@@ -1466,7 +1466,7 @@
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 extern int generic_cont_expand(struct inode *inode, loff_t size) ;
 extern int block_commit_write(struct page *page, unsigned from, unsigned to);
 extern int block_sync_page(struct page *);
--- orig/include/linux/hfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/hfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
@@ -19,7 +19,7 @@
 struct hfs_inode_info {
 	int				magic;     /* A magic number */
 
-	unsigned long			mmu_private;
+	loff_t				mmu_private;
 	struct hfs_cat_entry		*entry;
 
 	/* For a regular or header file */
--- orig/include/linux/hpfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/hpfs_fs_i.h	2003-11-19 12:16:51.000000000 -0700
@@ -2,7 +2,7 @@
 #define _HPFS_FS_I
 
 struct hpfs_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	ino_t i_parent_dir;	/* (directories) gives fnode of parent dir */
 	unsigned i_dno;		/* (directories) root dnode */
 	unsigned i_dpos;	/* (directories) temp for readdir */
--- orig/include/linux/msdos_fs_i.h	2003-11-19 12:16:51.000000000 -0700
+++ linux-2.4.22/include/linux/msdos_fs_i.h	2003-11-19 12:16:51.000000000 -0700
@@ -6,7 +6,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
