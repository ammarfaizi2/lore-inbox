Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTARCre>; Fri, 17 Jan 2003 21:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTARCre>; Fri, 17 Jan 2003 21:47:34 -0500
Received: from brown.csi.cam.ac.uk ([131.111.8.14]:54676 "EHLO
	brown.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262040AbTARCr3>; Fri, 17 Jan 2003 21:47:29 -0500
Date: Sat, 18 Jan 2003 02:56:28 +0000
From: Paul Evans <nerd@freeuk.com>
To: chaffee@cs.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kernel 2.4.20 FAT fdmode
Message-Id: <20030118025628.482f3322.nerd@freeuk.com>
X-Mailer: Sylpheed version 0.8.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that as of kernel 2.4.16, the FAT filing system marks all
files as executable. In my opinion, the required default operation is that
directories are executable, files are not.

As a result of this I have written this patch to the FAT module. It adds
two extra parameters, that can be specified on mount. fmode and dmode set
permission bits that are ANDed with whatever else is in effect - so by
defaulting fmode=0666 and dmode=0777 the above operation is restored. Note
also that these values can be specified at mount time, so other policies
can be implemented.

Since this patch effectively restores pre-2.4.16 operation, I consider it
a bug fix. However, the current operation, as it stands, is not
technically a bug, so perhaps this patch is more correctly a feature
enhancement. Due to the small size and simple operation of the patch I
also 

This patch file is also available on my website:

http://www.srcf.ucam.org/~pe208/programming/patches/index.html

-- 
Paul Evans

(3rd Year CompSci at Pembroke College, Cambridge, England)

pe208@cam.ac.uk (university)
nerd@freeuk.com (alternate)
ICQ# 4135350
Registered Linux User: 179460
http://www.srcf.ucam.org/~pe208/

-----------------

diff -urN linux-2.4.20/fs/fat/inode.c linux-2.4.20-leo/fs/fat/inode.c
--- linux-2.4.20/fs/fat/inode.c	Sat Aug  3 01:39:45 2002
+++ linux-2.4.20-leo/fs/fat/inode.c	Wed Jan  1 22:10:44 2003
@@ -8,6 +8,12 @@
  *  Fixes:
  *
  *  	Max Cohan: Fixed invalid FSINFO offset when info_sector is 0
+ *
+ *  Added:
+ *
+ *      Paul Evans: Added fmode/dmode options for separate file/dir
permissions
+ *                  See also include/linux/msdos_fs_sb.h
+ *
  */
 
 #include <linux/module.h>
@@ -75,6 +81,9 @@
 static struct list_head fat_inode_hashtable[FAT_HASH_SIZE];
 spinlock_t fat_inode_lock = SPIN_LOCK_UNLOCKED;
 
+/* mask for inode permission bits - used by fmode/dmode */
+#define MODEMASK (~0777)
+
 void fat_hash_init(void)
 {
 	int i;
@@ -220,6 +229,8 @@
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
 	opts->fs_umask = current->fs->umask;
+	opts->fs_fmode = 0666; /* rw-rw-rw- */
+	opts->fs_dmode = 0777; /* rwxrwxrwx */
 	opts->quiet = opts->sys_immutable = opts->dotsOK = opts->showexec
= 0;
 	opts->codepage = 0;
 	opts->nocase = 0;
@@ -299,6 +310,20 @@
 				if (*value) ret = 0;
 			}
 		}
+		else if (!strcmp(this_char,"fmode")) {
+			if (!value || !*value) ret = 0;
+			else {
+				opts->fs_fmode = simple_strtoul(value,&value,8);
+				if (*value) ret = 0;
+			}
+		}
+		else if (!strcmp(this_char,"dmode")) {
+			if (!value || !*value) ret = 0;
+			else {
+				opts->fs_dmode = simple_strtoul(value,&value,8);
+				if (*value) ret = 0;
+			}
+		}
 		else if (!strcmp(this_char,"debug")) {
 			if (value) ret = 0;
 			else *debug = 1;
@@ -385,7 +410,7 @@
 	inode->i_gid = sbi->options.fs_gid;
 	inode->i_version = ++event;
 	inode->i_generation = 0;
-	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_umask) | S_IFDIR;
+	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_umask &
(sbi->options.fs_dmode | MODEMASK)) | S_IFDIR;
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
 	if (sbi->fat_bits == 32) {
@@ -731,9 +756,10 @@
 	if (error || debug) {
 		/* The MSDOS_CAN_BMAP is obsolete, but left just to remember */
 		printk("[MS-DOS FS Rel. 12,FAT %d,check=%c,conv=%c,"
-		       "uid=%d,gid=%d,umask=%03o%s]\n",
+		       "uid=%d,gid=%d,umask=%03o,fmode=%03o,dmode=%03o%s]\n",
 		       sbi->fat_bits,opts.name_check,
 		       opts.conversion,opts.fs_uid,opts.fs_gid,opts.fs_umask,
+		       opts.fs_fmode,opts.fs_dmode,
 		       MSDOS_CAN_BMAP(sbi) ? ",bmap" : "");
 		printk("[me=0x%x,cs=%d,#f=%d,fs=%d,fl=%ld,ds=%ld,de=%d,data=%ld,"
 		       "se=%u,ts=%u,ls=%d,rc=%ld,fc=%u]\n",
@@ -900,7 +926,7 @@
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,S_IRWXUGO &
-		    ~sbi->options.fs_umask) | S_IFDIR;
+		    ~sbi->options.fs_umask & (sbi->options.fs_dmode | MODEMASK)) |
S_IFDIR;
 		inode->i_op = sbi->dir_ops;
 		inode->i_fop = &fat_dir_operations;
 
@@ -934,7 +960,7 @@
 		    ((sbi->options.showexec &&
 		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
-		    & ~sbi->options.fs_umask) | S_IFREG;
+		    & ~sbi->options.fs_umask & (sbi->options.fs_fmode | MODEMASK))
| S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
 		if (sbi->fat_bits == 32) {
 			MSDOS_I(inode)->i_start |=
@@ -1026,6 +1052,7 @@
 	struct super_block *sb = dentry->d_sb;
 	struct inode *inode = dentry->d_inode;
 	int error;
+	unsigned int mode;
 
 	/* FAT cannot truncate to a longer file */
 	if (attr->ia_valid & ATTR_SIZE) {
@@ -1052,12 +1079,17 @@
 	if (error)
 		return error;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		inode->i_mode |= S_IXUGO;
+		mode = ~MSDOS_SB(sb)->options.fs_umask &
(MSDOS_SB(sb)->options.fs_dmode | MODEMASK);
+		}
+	else
+		mode = ~MSDOS_SB(sb)->options.fs_umask &
(MSDOS_SB(sb)->options.fs_fmode | MODEMASK);
+
+	inode->i_mode = ((inode->i_mode & S_IFMT) | 
+			 ((((inode->i_mode & S_IRWXU & mode) | S_IRUSR) >> 6)*S_IXUGO)
+			) & mode;
 
-	inode->i_mode = ((inode->i_mode & S_IFMT) | ((((inode->i_mode & S_IRWXU
-	    & ~MSDOS_SB(sb)->options.fs_umask) | S_IRUSR) >> 6)*S_IXUGO)) &
-	    ~MSDOS_SB(sb)->options.fs_umask;
 	return 0;
 }
 MODULE_LICENSE("GPL");
diff -urN linux-2.4.20/include/linux/msdos_fs_sb.h
linux-2.4.20-leo/include/linux/msdos_fs_sb.h
--- linux-2.4.20/include/linux/msdos_fs_sb.h	Fri Oct 12 21:48:42 2001
+++ linux-2.4.20-leo/include/linux/msdos_fs_sb.h	Wed Jan  1 22:13:20 2003
@@ -9,7 +9,9 @@
 struct fat_mount_options {
 	uid_t fs_uid;
 	gid_t fs_gid;
-	unsigned short fs_umask;
+	unsigned short fs_umask;  /* global mask that masks off bits from either
following two fields */
+	unsigned short fs_fmode;  /* mode bits for files for fdmode */
+	unsigned short fs_dmode;  /* mode bits for directories for fdmode */
 	unsigned short codepage;  /* Codepage for shortname conversions */
 	char *iocharset;          /* Charset used for filename
input/display */
 	unsigned short shortname; /* flags for shortname display/create
rule */
