Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSDXXYK>; Wed, 24 Apr 2002 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312817AbSDXXYJ>; Wed, 24 Apr 2002 19:24:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54519 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312590AbSDXXXi>;
	Wed, 24 Apr 2002 19:23:38 -0400
Message-ID: <3CC73E6E.9090405@us.ibm.com>
Date: Wed, 24 Apr 2002 16:23:26 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] shift BKL out of vfs_readdir
Content-Type: multipart/mixed;
 boundary="------------020305080009000400070707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020305080009000400070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Oh boy, here's another one.  This patch takes the BKL out of 
vfs_readdir() and moves it into the individual filesystems, all 35 of 
them.  I have the feeling that this wasn't done before because there are 
a lot of these to change and it was a pain to find them all.  I 
definitely got all of those that were defined in the in the structure 
declaration like this "readdir: fs_readdir;"  vxfs_readdir was assigned 
strangely, but I found it anyway.  I also left devfs out of this one. 
Richard seems confident that devfs has no need for the BKL.

Anyway, patch attached.  Unlike the last one, this one actually compiles :)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------020305080009000400070707
Content-Type: text/plain;
 name="vfs_readdir-bkl_shift-2.5.9-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vfs_readdir-bkl_shift-2.5.9-7.patch"

diff -ur linux-2.5.10/Documentation/filesystems/Locking linux-2.5.10-dirty/Documentation/filesystems/Locking
--- linux-2.5.10/Documentation/filesystems/Locking	Wed Apr 24 00:15:15 2002
+++ linux-2.5.10-dirty/Documentation/filesystems/Locking	Wed Apr 24 16:07:07 2002
@@ -254,7 +254,7 @@
 llseek:		yes	(see below)
 read:		no
 write:		no
-readdir:	yes	(see below)
+readdir: 	no	
 poll:		no
 ioctl:		yes	(see below)
 mmap:		no
diff -ur linux-2.5.10/drivers/isdn/capi/capifs.c linux-2.5.10-dirty/drivers/isdn/capi/capifs.c
--- linux-2.5.10/drivers/isdn/capi/capifs.c	Wed Apr 24 00:15:13 2002
+++ linux-2.5.10-dirty/drivers/isdn/capi/capifs.c	Wed Apr 24 15:50:15 2002
@@ -97,18 +97,20 @@
 	off_t nr;
 	char numbuf[32];
 
+	lock_kernel();
+
 	nr = filp->f_pos;
 
 	switch(nr)
 	{
 	case 0:
 		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	case 1:
 		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	default:
@@ -120,13 +122,15 @@
 				if (np->type) *p++ = np->type;
 				sprintf(p, "%u", np->num);
 				if ( filldir(dirent, numbuf, strlen(numbuf), nr, nr, DT_UNKNOWN) < 0 )
-					return 0;
+					goto out;
 			}
 			filp->f_pos = ++nr;
 		}
 		break;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/adfs/dir.c linux-2.5.10-dirty/fs/adfs/dir.c
--- linux-2.5.10/fs/adfs/dir.c	Wed Apr 24 00:15:10 2002
+++ linux-2.5.10-dirty/fs/adfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -36,6 +36,8 @@
 	struct adfs_dir dir;
 	int ret = 0;
 
+	lock_kernel();	
+
 	if (filp->f_pos >> 32)
 		goto out;
 
@@ -77,6 +79,7 @@
 	ops->free(&dir);
 
 out:
+	unlock_kernel();
 	return ret;
 }
 
diff -ur linux-2.5.10/fs/affs/dir.c linux-2.5.10-dirty/fs/affs/dir.c
--- linux-2.5.10/fs/affs/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/affs/dir.c	Wed Apr 24 15:50:15 2002
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
+#include <linux/smp_lock.h>
 
 static int affs_readdir(struct file *, void *, filldir_t);
 
@@ -63,6 +64,8 @@
 	int			 stored;
 	int			 res;
 
+	lock_kernel();
+	
 	pr_debug("AFFS: readdir(ino=%lu,f_pos=%lx)\n",inode->i_ino,(unsigned long)filp->f_pos);
 
 	stored = 0;
@@ -158,6 +161,7 @@
 	affs_brelse(dir_bh);
 	affs_brelse(fh_bh);
 	affs_unlock_dir(inode);
+	unlock_kernel();
 	pr_debug("AFFS: readdir()=%d\n", stored);
 	return res;
 }
diff -ur linux-2.5.10/fs/autofs/root.c linux-2.5.10-dirty/fs/autofs/root.c
--- linux-2.5.10/fs/autofs/root.c	Wed Apr 24 00:15:19 2002
+++ linux-2.5.10-dirty/fs/autofs/root.c	Wed Apr 24 15:50:15 2002
@@ -47,6 +47,8 @@
 	struct inode * inode = filp->f_dentry->d_inode;
 	off_t onr, nr;
 
+	lock_kernel();
+
 	sbi = autofs_sbi(inode->i_sb);
 	dirhash = &sbi->dirhash;
 	nr = filp->f_pos;
@@ -55,25 +57,27 @@
 	{
 	case 0:
 		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	case 1:
 		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	default:
 		while ( onr = nr, ent = autofs_hash_enum(dirhash,&nr,ent) ) {
 			if ( !ent->dentry || d_mountpoint(ent->dentry) ) {
 				if (filldir(dirent,ent->name,ent->len,onr,ent->ino,DT_UNKNOWN) < 0)
-					return 0;
+					goto out;
 				filp->f_pos = nr;
 			}
 		}
 		break;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/bad_inode.c linux-2.5.10-dirty/fs/bad_inode.c
--- linux-2.5.10/fs/bad_inode.c	Wed Apr 24 00:15:12 2002
+++ linux-2.5.10-dirty/fs/bad_inode.c	Wed Apr 24 15:50:15 2002
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/time.h>
+#include <linux/smp_lock.h>
 
 /*
  * The follow_link operation is special: it must behave as a no-op
diff -ur linux-2.5.10/fs/bfs/dir.c linux-2.5.10-dirty/fs/bfs/dir.c
--- linux-2.5.10/fs/bfs/dir.c	Wed Apr 24 00:15:22 2002
+++ linux-2.5.10-dirty/fs/bfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -32,9 +32,12 @@
 	unsigned int offset;
 	int block;
 
+	lock_kernel();
+
 	if (f->f_pos & (BFS_DIRENT_SIZE-1)) {
 		printf("Bad f_pos=%08lx for %s:%08lx\n", (unsigned long)f->f_pos, 
 			dir->i_sb->s_id, dir->i_ino);
+		unlock_kernel();
 		return -EBADF;
 	}
 
@@ -52,6 +55,7 @@
 				int size = strnlen(de->name, BFS_NAMELEN);
 				if (filldir(dirent, de->name, size, f->f_pos, de->ino, DT_UNKNOWN) < 0) {
 					brelse(bh);
+					unlock_kernel();
 					return 0;
 				}
 			}
@@ -62,6 +66,7 @@
 	}
 
 	UPDATE_ATIME(dir);
+	unlock_kernel();
 	return 0;	
 }
 
diff -ur linux-2.5.10/fs/cramfs/inode.c linux-2.5.10-dirty/fs/cramfs/inode.c
--- linux-2.5.10/fs/cramfs/inode.c	Wed Apr 24 00:15:09 2002
+++ linux-2.5.10-dirty/fs/cramfs/inode.c	Wed Apr 24 15:50:15 2002
@@ -293,6 +293,8 @@
 	if (offset & 3)
 		return -EINVAL;
 
+	lock_kernel();
+
 	copied = 0;
 	while (offset < inode->i_size) {
 		struct cramfs_inode *de;
@@ -313,8 +315,10 @@
 		namelen = de->namelen << 2;
 		nextoffset = offset + sizeof(*de) + namelen;
 		for (;;) {
-			if (!namelen)
+			if (!namelen) {
+				unlock_kernel();
 				return -EIO;
+			}
 			if (name[namelen-1])
 				break;
 			namelen--;
@@ -327,6 +331,7 @@
 		filp->f_pos = offset;
 		copied++;
 	}
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/devpts/root.c linux-2.5.10-dirty/fs/devpts/root.c
--- linux-2.5.10/fs/devpts/root.c	Wed Apr 24 00:15:08 2002
+++ linux-2.5.10-dirty/fs/devpts/root.c	Wed Apr 24 15:50:15 2002
@@ -48,18 +48,20 @@
 	off_t nr;
 	char numbuf[16];
 
+	lock_kernel();
+
 	nr = filp->f_pos;
 
 	switch(nr)
 	{
 	case 0:
 		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	case 1:
 		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
+			goto out;
 		filp->f_pos = ++nr;
 		/* fall through */
 	default:
@@ -68,13 +70,15 @@
 			if ( sbi->inodes[ptynr] ) {
 				genptsname(numbuf, ptynr);
 				if ( filldir(dirent, numbuf, strlen(numbuf), nr, nr, DT_CHR) < 0 )
-					return 0;
+					goto out;
 			}
 			filp->f_pos = ++nr;
 		}
 		break;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/efs/dir.c linux-2.5.10-dirty/fs/efs/dir.c
--- linux-2.5.10/fs/efs/dir.c	Wed Apr 24 00:15:21 2002
+++ linux-2.5.10-dirty/fs/efs/dir.c	Wed Apr 24 15:50:15 2002
@@ -5,6 +5,7 @@
  */
 
 #include <linux/efs_fs.h>
+#include <linux/smp_lock.h>
 
 static int efs_readdir(struct file *, void *, filldir_t);
 
@@ -31,6 +32,8 @@
 	if (inode->i_size & (EFS_DIRBSIZE-1))
 		printk(KERN_WARNING "EFS: WARNING: readdir(): directory size not a multiple of EFS_DIRBSIZE\n");
 
+	lock_kernel();
+
 	/* work out where this entry can be found */
 	block = filp->f_pos >> EFS_DIRBSIZE_BITS;
 
@@ -91,7 +94,7 @@
 				}
 				brelse(bh);
 				filp->f_pos = (block << EFS_DIRBSIZE_BITS) | slot;
-				return 0;
+				goto out;
 			}
 			slot++;
 		}
@@ -102,6 +105,8 @@
 	}
 
 	filp->f_pos = (block << EFS_DIRBSIZE_BITS) | slot;
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/ext2/dir.c linux-2.5.10-dirty/fs/ext2/dir.c
--- linux-2.5.10/fs/ext2/dir.c	Wed Apr 24 00:15:08 2002
+++ linux-2.5.10-dirty/fs/ext2/dir.c	Wed Apr 24 15:50:15 2002
@@ -23,6 +23,7 @@
 
 #include "ext2.h"
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 typedef struct ext2_dir_entry_2 ext2_dirent;
 
@@ -246,6 +247,8 @@
 	unsigned char *types = NULL;
 	int need_revalidate = (filp->f_version != inode->i_version);
 
+	lock_kernel();
+
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		goto done;
 
@@ -290,6 +293,7 @@
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	UPDATE_ATIME(inode);
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/ext3/dir.c linux-2.5.10-dirty/fs/ext3/dir.c
--- linux-2.5.10/fs/ext3/dir.c	Wed Apr 24 00:15:20 2002
+++ linux-2.5.10-dirty/fs/ext3/dir.c	Wed Apr 24 16:10:07 2002
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/smp_lock.h>
 
 static unsigned char ext3_filetype_table[] = {
 	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
@@ -30,7 +31,7 @@
 
 struct file_operations ext3_dir_operations = {
 	read:		generic_read_dir,
-	readdir:	ext3_readdir,		/* BKL held */
+	readdir:	ext3_readdir,		/* we take BKL. needed?*/
 	ioctl:		ext3_ioctl,		/* BKL held */
 	fsync:		ext3_sync_file,		/* BKL held */
 };
@@ -77,6 +78,8 @@
 	int err;
 	struct inode *inode = filp->f_dentry->d_inode;
 
+	lock_kernel();
+
 	sb = inode->i_sb;
 
 	stored = 0;
@@ -150,6 +153,7 @@
 				filp->f_pos = (filp->f_pos |
 						(sb->s_blocksize - 1)) + 1;
 				brelse (bh);
+				unlock_kernel();
 				return stored;
 			}
 			offset += le16_to_cpu(de->rec_len);
@@ -186,5 +190,6 @@
 		brelse (bh);
 	}
 	UPDATE_ATIME(inode);
+	unlock_kernel();
 	return 0;
 }
diff -ur linux-2.5.10/fs/fat/dir.c linux-2.5.10-dirty/fs/fat/dir.c
--- linux-2.5.10/fs/fat/dir.c	Wed Apr 24 00:15:09 2002
+++ linux-2.5.10-dirty/fs/fat/dir.c	Wed Apr 24 15:50:15 2002
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
 #include <linux/dirent.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -363,13 +364,16 @@
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
 	int ino, inum, chi, chl, i, i2, j, last, last_u, dotoffset = 0;
 	loff_t cpos;
+	int ret = 0;
+	
+	lock_kernel();
 
 	cpos = filp->f_pos;
 /* Fake . and .. for the root directory. */
 	if (inode->i_ino == MSDOS_ROOT_INO) {
 		while (cpos < 2) {
 			if (filldir(dirent, "..", cpos+1, cpos, MSDOS_ROOT_INO, DT_DIR) < 0)
-				return 0;
+				goto out;
 			cpos++;
 			filp->f_pos++;
 		}
@@ -379,8 +383,10 @@
 			cpos = 0;
 		}
 	}
-	if (cpos & (sizeof(struct msdos_dir_entry)-1))
-		return -ENOENT;
+	if (cpos & (sizeof(struct msdos_dir_entry)-1)) {
+		ret = -ENOENT;
+		goto out;
+	}
 
  	bh = NULL;
 GetNew:
@@ -414,7 +420,8 @@
 			if (!unicode) {
 				filp->f_pos = cpos;
 				fat_brelse(sb, bh);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out;
 			}
 		}
 ParseLong:
@@ -580,7 +587,9 @@
 	if (unicode) {
 		free_page((unsigned long) unicode);
 	}
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 int fat_readdir(struct file *filp, void *dirent, filldir_t filldir)
diff -ur linux-2.5.10/fs/freevxfs/vxfs_lookup.c linux-2.5.10-dirty/fs/freevxfs/vxfs_lookup.c
--- linux-2.5.10/fs/freevxfs/vxfs_lookup.c	Wed Apr 24 00:15:19 2002
+++ linux-2.5.10-dirty/fs/freevxfs/vxfs_lookup.c	Wed Apr 24 16:20:09 2002
@@ -262,8 +262,10 @@
 
 	pos = fp->f_pos - 2;
 	
-	if (pos > VXFS_DIRROUND(ip->i_size))
+	if (pos > VXFS_DIRROUND(ip->i_size)) {
+		unlock_kernel();
 		return 0;
+	}
 
 	npages = dir_pages(ip);
 	nblocks = dir_blocks(ip);
@@ -322,5 +324,6 @@
 done:
 	fp->f_pos = ((page << PAGE_CACHE_SHIFT) | offset) + 2;
 out:
+	unlock_kernel();
 	return 0;
 }
diff -ur linux-2.5.10/fs/hfs/dir_cap.c linux-2.5.10-dirty/fs/hfs/dir_cap.c
--- linux-2.5.10/fs/hfs/dir_cap.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/hfs/dir_cap.c	Wed Apr 24 15:50:15 2002
@@ -188,6 +188,8 @@
         struct hfs_cat_entry *entry;
 	struct inode *dir = filp->f_dentry->d_inode;
 
+	lock_kernel();
+
 	entry = HFS_I(dir)->entry;
 	type = HFS_ITYPE(dir->i_ino);
 	skip_dirs = (type == HFS_CAP_RDIR);
@@ -195,7 +197,7 @@
 	if (filp->f_pos == 0) {
 		/* Entry 0 is for "." */
 		if (filldir(dirent, DOT->Name, DOT_LEN, 0, dir->i_ino, DT_DIR)) {
-			return 0;
+			goto out;
 		}
 		filp->f_pos = 1;
 	}
@@ -212,7 +214,7 @@
 
 		if (filldir(dirent, DOT_DOT->Name,
 			    DOT_DOT_LEN, 1, ntohl(cnid), DT_DIR)) {
-			return 0;
+			goto out;
 		}
 		filp->f_pos = 2;
 	}
@@ -223,11 +225,11 @@
 
 	    	if (hfs_cat_open(entry, &brec) ||
 	    	    hfs_cat_next(entry, &brec, filp->f_pos - 2, &cnid, &type)) {
-			return 0;
+			goto out;
 		}
 		while (filp->f_pos < (dir->i_size - 3)) {
 			if (hfs_cat_next(entry, &brec, 1, &cnid, &type)) {
-				return 0;
+				goto out;
 			}
 			if (!skip_dirs || (type != HFS_CDR_DIR)) {
 				ino_t ino;
@@ -240,7 +242,7 @@
 				if (filldir(dirent, tmp_name, len,
 					    filp->f_pos, ino, DT_UNKNOWN)) {
 					hfs_cat_close(entry, &brec);
-					return 0;
+					goto out;
 				}
 			}
 			++filp->f_pos;
@@ -256,7 +258,7 @@
 				    DOT_ROOTINFO_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_CAP_FNDR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
@@ -269,7 +271,7 @@
 				    DOT_FINDERINFO_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_CAP_FDIR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
@@ -282,12 +284,14 @@
 				    DOT_RESOURCE_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_CAP_RDIR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/hfs/dir_dbl.c linux-2.5.10-dirty/fs/hfs/dir_dbl.c
--- linux-2.5.10/fs/hfs/dir_dbl.c	Wed Apr 24 00:15:15 2002
+++ linux-2.5.10-dirty/fs/hfs/dir_dbl.c	Wed Apr 24 15:50:15 2002
@@ -182,13 +182,15 @@
         struct hfs_cat_entry *entry;
 	struct inode *dir = filp->f_dentry->d_inode;
 
+	lock_kernel();
+
 	entry = HFS_I(dir)->entry;
 
 	if (filp->f_pos == 0) {
 		/* Entry 0 is for "." */
 		if (filldir(dirent, DOT->Name, DOT_LEN, 0, dir->i_ino,
 			    DT_DIR)) {
-			return 0;
+			goto out;
 		}
 		filp->f_pos = 1;
 	}
@@ -197,7 +199,7 @@
 		/* Entry 1 is for ".." */
 		if (filldir(dirent, DOT_DOT->Name, DOT_DOT_LEN, 1,
 			    hfs_get_hl(entry->key.ParID), DT_DIR)) {
-			return 0;
+			goto out;	
 		}
 		filp->f_pos = 2;
 	}
@@ -209,7 +211,7 @@
 		if (hfs_cat_open(entry, &brec) ||
 		    hfs_cat_next(entry, &brec, (filp->f_pos - 1) >> 1,
 				 &cnid, &type)) {
-			return 0;
+			goto out;
 		}
 
 		while (filp->f_pos < (dir->i_size - 1)) {
@@ -226,7 +228,7 @@
 			} else {
 				if (hfs_cat_next(entry, &brec, 1,
 							&cnid, &type)) {
-					return 0;
+					goto out;
 				}
 				ino = ntohl(cnid);
 				len = hfs_namein(dir, tmp_name,
@@ -236,7 +238,7 @@
 			if (filldir(dirent, tmp_name, len, filp->f_pos, ino,
 				    DT_UNKNOWN)) {
 				hfs_cat_close(entry, &brec);
-				return 0;
+				goto out;
 			}
 			++filp->f_pos;
 		}
@@ -250,12 +252,14 @@
 				    PCNT_ROOTINFO_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_DBL_HDR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/hfs/dir_nat.c linux-2.5.10-dirty/fs/hfs/dir_nat.c
--- linux-2.5.10/fs/hfs/dir_nat.c	Wed Apr 24 00:15:23 2002
+++ linux-2.5.10-dirty/fs/hfs/dir_nat.c	Wed Apr 24 15:50:15 2002
@@ -188,6 +188,8 @@
         struct hfs_cat_entry *entry;
 	struct inode *dir = filp->f_dentry->d_inode;
 
+	lock_kernel();
+	
 	entry = HFS_I(dir)->entry;
 	type = HFS_ITYPE(dir->i_ino);
 	skip_dirs = (type == HFS_NAT_HDIR);
@@ -196,7 +198,7 @@
 		/* Entry 0 is for "." */
 		if (filldir(dirent, DOT->Name, DOT_LEN, 0, dir->i_ino,
 			    DT_DIR)) {
-			return 0;
+			goto out;
 		}
 		filp->f_pos = 1;
 	}
@@ -213,7 +215,7 @@
 
 		if (filldir(dirent, DOT_DOT->Name,
 			    DOT_DOT_LEN, 1, ntohl(cnid), DT_DIR)) {
-			return 0;
+			goto out;
 		}
 		filp->f_pos = 2;
 	}
@@ -224,11 +226,11 @@
 
 	    	if (hfs_cat_open(entry, &brec) ||
 		    hfs_cat_next(entry, &brec, filp->f_pos - 2, &cnid, &type)) {
-			return 0;
+			goto out;
 		}
 		while (filp->f_pos < (dir->i_size - 2)) {
 			if (hfs_cat_next(entry, &brec, 1, &cnid, &type)) {
-				return 0;
+				goto out;
 			}
 			if (!skip_dirs || (type != HFS_CDR_DIR)) {
 				ino_t ino;
@@ -241,7 +243,7 @@
 				if (filldir(dirent, tmp_name, len,
 					    filp->f_pos, ino, DT_UNKNOWN)) {
 					hfs_cat_close(entry, &brec);
-					return 0;
+					goto out;
 				}
 			}
 			++filp->f_pos;
@@ -256,7 +258,7 @@
 				    DOT_APPLEDOUBLE_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_NAT_HDIR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		} else if (type == HFS_NAT_HDIR) {
 			/* In .AppleDouble entry 2 is for ".Parent" */
@@ -264,7 +266,7 @@
 				    DOT_PARENT_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_NAT_HDR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
@@ -278,12 +280,14 @@
 				    ROOTINFO_LEN, filp->f_pos,
 				    ntohl(entry->cnid) | HFS_NAT_HDR,
 				    DT_UNKNOWN)) {
-				return 0;
+				goto out;
 			}
 		}
 		++filp->f_pos;
 	}
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/hpfs/dir.c linux-2.5.10-dirty/fs/hpfs/dir.c
--- linux-2.5.10/fs/hpfs/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/hpfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -62,19 +62,26 @@
 	long old_pos;
 	char *tempname;
 	int c1, c2 = 0;
+	int ret = 0;
 
 	if (inode->i_sb->s_hpfs_chk) {
-		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode"))
-			return -EFSERROR;
-		if (hpfs_chk_sectors(inode->i_sb, hpfs_inode->i_dno, 4, "dir_dnode"))
-			return -EFSERROR;
+		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode")) {
+			ret = -EFSERROR;
+			goto out;
+		}
+		if (hpfs_chk_sectors(inode->i_sb, hpfs_inode->i_dno, 4, "dir_dnode")) {
+			ret = -EFSERROR;
+			goto out;
+		}
 	}
 	if (inode->i_sb->s_hpfs_chk >= 2) {
 		struct buffer_head *bh;
 		struct fnode *fno;
 		int e = 0;
-		if (!(fno = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh)))
-			return -EIOERROR;
+		if (!(fno = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) {
+			ret = -EIOERROR;
+			goto out;
+		}
 		if (!fno->dirflag) {
 			e = 1;
 			hpfs_error(inode->i_sb, "not a directory, fnode %08x",inode->i_ino);
@@ -84,14 +91,20 @@
 			hpfs_error(inode->i_sb, "corrupted inode: i_dno == %08x, fnode -> dnode == %08x", hpfs_inode->i_dno, fno->u.external[0].disk_secno);
 		}
 		brelse(bh);
-		if (e) return -EFSERROR;
+		if (e) {
+			ret = -EFSERROR;
+			goto out;
+		}
 	}
 	lc = inode->i_sb->s_hpfs_lowercase;
 	if (filp->f_pos == 12) { /* diff -r requires this (note, that diff -r */
 		filp->f_pos = 13; /* also fails on msdos filesystem in 2.0) */
-		return 0;
+		goto out;
+	}
+	if (filp->f_pos == 13) {
+		ret = -ENOENT;
+		goto out;
 	}
-	if (filp->f_pos == 13) return -ENOENT;
 	
 	hpfs_lock_inode(inode);
 	
@@ -103,28 +116,29 @@
 		if (inode->i_sb->s_hpfs_chk)
 			if (hpfs_stop_cycles(inode->i_sb, filp->f_pos, &c1, &c2, "hpfs_readdir")) {
 				hpfs_unlock_inode(inode);
-				return -EFSERROR;
+				ret = -EFSERROR;
+				goto out;
 			}
 		if (filp->f_pos == 12) {
 			hpfs_unlock_inode(inode);
-			return 0;
+			goto out;
 		}
 		if (filp->f_pos == 3 || filp->f_pos == 4 || filp->f_pos == 5) {
 			printk("HPFS: warning: pos==%d\n",(int)filp->f_pos);
 			hpfs_unlock_inode(inode);
-			return 0;
+			goto out;
 		}
 		if (filp->f_pos == 0) {
 			if (filldir(dirent, ".", 1, filp->f_pos, inode->i_ino, DT_DIR) < 0) {
 				hpfs_unlock_inode(inode);
-				return 0;
+				goto out;
 			}
 			filp->f_pos = 11;
 		}
 		if (filp->f_pos == 11) {
 			if (filldir(dirent, "..", 2, filp->f_pos, hpfs_inode->i_parent_dir, DT_DIR) < 0) {
 				hpfs_unlock_inode(inode);
-				return 0;
+				goto out;
 			}
 			filp->f_pos = 1;
 		}
@@ -135,12 +149,14 @@
 		}
 			/*if (filp->f_version != inode->i_version) {
 				hpfs_unlock_inode(inode);
-				return -ENOENT;
+				ret = -ENOENT;
+				goto out;
 			}*/	
 			old_pos = filp->f_pos;
 			if (!(de = map_pos_dirent(inode, &filp->f_pos, &qbh))) {
 				hpfs_unlock_inode(inode);
-				return -EIOERROR;
+				ret = -EIOERROR;
+				goto out;
 			}
 			if (de->first || de->last) {
 				if (inode->i_sb->s_hpfs_chk) {
@@ -156,11 +172,14 @@
 				if (tempname != (char *)de->name) kfree(tempname);
 				hpfs_brelse4(&qbh);
 				hpfs_unlock_inode(inode);
-				return 0;
+				goto out;
 			}
 			if (tempname != (char *)de->name) kfree(tempname);
 			hpfs_brelse4(&qbh);
 	}
+out:
+	unlock_kernel();
+	return ret;
 }
 
 /*
diff -ur linux-2.5.10/fs/isofs/dir.c linux-2.5.10-dirty/fs/isofs/dir.c
--- linux-2.5.10/fs/isofs/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/isofs/dir.c	Wed Apr 24 15:50:15 2002
@@ -21,6 +21,7 @@
 #include <linux/time.h>
 #include <linux/locks.h>
 #include <linux/config.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -253,6 +254,8 @@
 	struct iso_directory_record * tmpde;
 	struct inode *inode = filp->f_dentry->d_inode;
 
+	lock_kernel();
+
 	tmpname = (char *) __get_free_page(GFP_KERNEL);
 	if (!tmpname)
 		return -ENOMEM;
@@ -261,5 +264,6 @@
 	result = do_isofs_readdir(inode, filp, dirent, filldir, tmpname, tmpde);
 
 	free_page((unsigned long) tmpname);
+	unlock_kernel();
 	return result;
 }
diff -ur linux-2.5.10/fs/jffs/inode-v23.c linux-2.5.10-dirty/fs/jffs/inode-v23.c
--- linux-2.5.10/fs/jffs/inode-v23.c	Wed Apr 24 00:15:20 2002
+++ linux-2.5.10-dirty/fs/jffs/inode-v23.c	Wed Apr 24 15:50:15 2002
@@ -48,6 +48,7 @@
 #include <linux/stat.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
+#include <linux/smp_lock.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
@@ -568,6 +569,7 @@
 	struct jffs_control *c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
 	int j;
 	int ddino;
+	lock_kernel();
 	D3(printk (KERN_NOTICE "readdir(): down biglock\n"));
 	down(&c->fmc->biglock);
 
@@ -577,6 +579,7 @@
 		if (filldir(dirent, ".", 1, filp->f_pos, inode->i_ino, DT_DIR) < 0) {
 			D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
 			up(&c->fmc->biglock);
+			unlock_kernel();
 			return 0;
 		}
 		filp->f_pos = 1;
@@ -593,6 +596,7 @@
 		if (filldir(dirent, "..", 2, filp->f_pos, ddino, DT_DIR) < 0) {
 			D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
 			up(&c->fmc->biglock);
+			unlock_kernel();
 			return 0;
 		}
 		filp->f_pos++;
@@ -611,6 +615,7 @@
 			    filp->f_pos , f->ino, DT_UNKNOWN) < 0) {
 		        D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
 			up(&c->fmc->biglock);
+			unlock_kernel();
 			return 0;
 		}
 		filp->f_pos++;
@@ -620,6 +625,7 @@
 	}
 	D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
 	up(&c->fmc->biglock);
+	unlock_kernel();
 	return filp->f_pos;
 } /* jffs_readdir()  */
 
diff -ur linux-2.5.10/fs/jffs2/dir.c linux-2.5.10-dirty/fs/jffs2/dir.c
--- linux-2.5.10/fs/jffs2/dir.c	Wed Apr 24 00:15:13 2002
+++ linux-2.5.10-dirty/fs/jffs2/dir.c	Wed Apr 24 15:50:15 2002
@@ -45,6 +45,7 @@
 #include <linux/jffs2_fs_i.h>
 #include <linux/jffs2_fs_sb.h>
 #include <linux/time.h>
+#include <linux/smp_lock.h>
 #include "nodelist.h"
 
 static int jffs2_readdir (struct file *, void *, filldir_t);
@@ -143,6 +144,8 @@
 
 	D1(printk(KERN_DEBUG "jffs2_readdir() for dir_i #%lu\n", filp->f_dentry->d_inode->i_ino));
 
+	lock_kernel();
+
 	f = JFFS2_INODE_INFO(inode);
 	c = JFFS2_SB_INFO(inode->i_sb);
 
@@ -186,6 +189,7 @@
 	up(&f->sem);
  out:
 	filp->f_pos = offset;
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/jfs/jfs_dtree.c linux-2.5.10-dirty/fs/jfs/jfs_dtree.c
--- linux-2.5.10/fs/jfs/jfs_dtree.c	Wed Apr 24 00:15:12 2002
+++ linux-2.5.10-dirty/fs/jfs/jfs_dtree.c	Wed Apr 24 15:50:15 2002
@@ -102,6 +102,7 @@
 
 #include <linux/fs.h>
 #include <linux/locks.h>
+#include <linux/smp_lock.h>
 #include "jfs_incore.h"
 #include "jfs_superblock.h"
 #include "jfs_filsys.h"
@@ -2868,6 +2869,8 @@
 	if (filp->f_pos == DIREND)
 		return 0;
 
+	lock_kernel();
+
 	if (DO_INDEX(ip)) {
 		/*
 		 * persistent index is stored in directory entries.
@@ -2885,12 +2888,14 @@
 
 			if (dtEmpty(ip)) {
 				filp->f_pos = DIREND;
+				unlock_kernel();
 				return 0;
 			}
 		      repeat:
 			rc = get_index(ip, dir_index, &dirtab_slot);
 			if (rc) {
 				filp->f_pos = DIREND;
+				unlock_kernel();
 				return rc;
 			}
 			if (dirtab_slot.flag == DIR_INDEX_FREE) {
@@ -2898,11 +2903,13 @@
 					jERROR(1, ("jfs_readdir detected "
 						   "infinite loop!\n"));
 					filp->f_pos = DIREND;
+					unlock_kernel();
 					return 0;
 				}
 				dir_index = le32_to_cpu(dirtab_slot.addr2);
 				if (dir_index == -1) {
 					filp->f_pos = DIREND;
+					unlock_kernel();
 					return 0;
 				}
 				goto repeat;
@@ -2912,12 +2919,14 @@
 			DT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
 			if (rc) {
 				filp->f_pos = DIREND;
+				unlock_kernel();
 				return 0;
 			}
 			if (p->header.flag & BT_INTERNAL) {
 				jERROR(1,("jfs_readdir: bad index table\n"));
 				DT_PUTPAGE(mp);
 				filp->f_pos = -1;
+				unlock_kernel();
 				return 0;
 			}
 		} else {
@@ -2927,27 +2936,34 @@
 				 */
 				filp->f_pos = 0;
 				if (filldir(dirent, ".", 1, 0, ip->i_ino,
-					    DT_DIR))
+					    DT_DIR)) {
+					unlock_kernel();	
 					return 0;
+				}
 			}
 			/*
 			 * parent ".."
 			 */
 			filp->f_pos = 1;
 			if (filldir
-			    (dirent, "..", 2, 1, PARENT(ip), DT_DIR))
+			    (dirent, "..", 2, 1, PARENT(ip), DT_DIR)) {
+				unlock_kernel();
 				return 0;
+			}
 
 			/*
 			 * Find first entry of left-most leaf
 			 */
 			if (dtEmpty(ip)) {
 				filp->f_pos = DIREND;
+				unlock_kernel();
 				return 0;
 			}
 
-			if ((rc = dtReadFirst(ip, &btstack)))
+			if ((rc = dtReadFirst(ip, &btstack))) {
+				unlock_kernel();
 				return -rc;
+			}
 
 			DT_GETSEARCH(ip, btstack.top, bn, mp, p, index);
 		}
@@ -2966,8 +2982,10 @@
 			/* build "." entry */
 
 			if (filldir(dirent, ".", 1, filp->f_pos, ip->i_ino,
-				    DT_DIR))
+				    DT_DIR)) {
+				unlock_kernel();
 				return 0;
+			}
 			dtoffset->index = 1;
 		}
 
@@ -2976,8 +2994,10 @@
 				/* build ".." entry */
 
 				if (filldir(dirent, "..", 2, filp->f_pos,
-					    PARENT(ip), DT_DIR))
+					    PARENT(ip), DT_DIR)) {
+					unlock_kernel();
 					return 0;
+				}
 			} else {
 				jERROR(1,
 				       ("jfs_readdir called with invalid offset!\n"));
@@ -2988,6 +3008,7 @@
 
 		if (dtEmpty(ip)) {
 			filp->f_pos = DIREND;
+			unlock_kernel();
 			return 0;
 		}
 
@@ -2996,6 +3017,7 @@
 			       ("jfs_readdir: unexpected rc = %d from dtReadNext\n",
 				rc));
 			filp->f_pos = DIREND;
+			unlock_kernel();
 			return 0;
 		}
 		/* get start leaf page and index */
@@ -3004,6 +3026,7 @@
 		/* offset beyond directory eof ? */
 		if (bn < 0) {
 			filp->f_pos = DIREND;
+			unlock_kernel();
 			return 0;
 		}
 	}
@@ -3013,6 +3036,7 @@
 		DT_PUTPAGE(mp);
 		jERROR(1, ("jfs_readdir: kmalloc failed!\n"));
 		filp->f_pos = DIREND;
+		unlock_kernel();
 		return 0;
 	}
 	while (1) {
@@ -3087,6 +3111,7 @@
 		DT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
 		if (rc) {
 			kfree(d_name);
+			unlock_kernel();
 			return -rc;
 		}
 
@@ -3102,7 +3127,7 @@
       out:
 	kfree(d_name);
 	DT_PUTPAGE(mp);
-
+	unlock_kernel();
 	return rc;
 }
 
diff -ur linux-2.5.10/fs/libfs.c linux-2.5.10-dirty/fs/libfs.c
--- linux-2.5.10/fs/libfs.c	Wed Apr 24 00:15:08 2002
+++ linux-2.5.10-dirty/fs/libfs.c	Wed Apr 24 15:50:15 2002
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 int simple_statfs(struct super_block *sb, struct statfs *buf)
 {
@@ -40,6 +41,8 @@
 	int i;
 	struct dentry *dentry = filp->f_dentry;
 
+	lock_kernel();
+
 	i = filp->f_pos;
 	switch (i) {
 		case 0:
@@ -64,6 +67,7 @@
 			for (;;) {
 				if (list == &dentry->d_subdirs) {
 					spin_unlock(&dcache_lock);
+					unlock_kernel();
 					return 0;
 				}
 				if (!j)
@@ -94,6 +98,7 @@
 			}
 		}
 	}
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/minix/dir.c linux-2.5.10-dirty/fs/minix/dir.c
--- linux-2.5.10/fs/minix/dir.c	Wed Apr 24 00:15:13 2002
+++ linux-2.5.10-dirty/fs/minix/dir.c	Wed Apr 24 15:50:15 2002
@@ -7,6 +7,7 @@
  */
 
 #include "minix.h"
+#include <linux/smp_lock.h>
 
 typedef struct minix_dir_entry minix_dirent;
 
@@ -78,6 +79,8 @@
 	struct minix_sb_info *sbi = minix_sb(sb);
 	unsigned chunk_size = sbi->s_dirsize;
 
+	lock_kernel();
+
 	pos = (pos + chunk_size-1) & ~(chunk_size-1);
 	if (pos >= inode->i_size)
 		goto done;
@@ -113,6 +116,7 @@
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	UPDATE_ATIME(inode);
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/ncpfs/dir.c linux-2.5.10-dirty/fs/ncpfs/dir.c
--- linux-2.5.10/fs/ncpfs/dir.c	Wed Apr 24 00:15:08 2002
+++ linux-2.5.10-dirty/fs/ncpfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -400,6 +400,8 @@
 	int result, mtime_valid = 0;
 	time_t mtime = 0;
 
+	lock_kernel();
+
 	ctl.page  = NULL;
 	ctl.cache = NULL;
 
@@ -533,6 +535,7 @@
 		page_cache_release(ctl.page);
 	}
 out:
+	unlock_kernel();
 	return result;
 }
 
diff -ur linux-2.5.10/fs/nfs/dir.c linux-2.5.10-dirty/fs/nfs/dir.c
--- linux-2.5.10/fs/nfs/dir.c	Wed Apr 24 00:15:19 2002
+++ linux-2.5.10-dirty/fs/nfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -355,9 +355,13 @@
 	struct nfs_entry my_entry;
 	long		res;
 
+	lock_kernel();
+
 	res = nfs_revalidate(dentry);
-	if (res < 0)
+	if (res < 0) {
+		unlock_kernel();
 		return res;
+	}
 
 	/*
 	 * filp->f_pos points to the file offset in the page cache.
@@ -394,6 +398,7 @@
 			break;
 		}
 	}
+	unlock_kernel();
 	if (desc->error < 0)
 		return desc->error;
 	if (res < 0)
diff -ur linux-2.5.10/fs/nfs/nfs3proc.c linux-2.5.10-dirty/fs/nfs/nfs3proc.c
--- linux-2.5.10/fs/nfs/nfs3proc.c	Wed Apr 24 00:15:19 2002
+++ linux-2.5.10-dirty/fs/nfs/nfs3proc.c	Wed Apr 24 15:50:15 2002
@@ -14,6 +14,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
+#include <linux/smp_lock.h>
 
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
@@ -560,6 +561,8 @@
 	u32			*verf = NFS_COOKIEVERF(dir);
 	int			status;
 
+	lock_kernel();
+
 	arg.buffer  = entry;
 	arg.bufsiz  = size;
 	arg.verf[0] = verf[0];
@@ -580,6 +583,7 @@
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_refresh_inode(dir, &dir_attr);
 	dprintk("NFS reply readdir: %d\n", status);
+	unlock_kernel();
 	return status;
 }
 
diff -ur linux-2.5.10/fs/nfs/proc.c linux-2.5.10-dirty/fs/nfs/proc.c
--- linux-2.5.10/fs/nfs/proc.c	Wed Apr 24 00:15:16 2002
+++ linux-2.5.10-dirty/fs/nfs/proc.c	Wed Apr 24 15:50:15 2002
@@ -41,6 +41,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
+#include <linux/smp_lock.h>
 
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
@@ -440,6 +441,8 @@
 	};
 	int			status;
 
+	lock_kernel();
+
 	arg.fh = NFS_FH(dir);
 	arg.cookie = cookie;
 	arg.buffer = entry;
@@ -451,6 +454,7 @@
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 
 	dprintk("NFS reply readdir: %d\n", status);
+	unlock_kernel();
 	return status;
 }
 
diff -ur linux-2.5.10/fs/ntfs/fs.c linux-2.5.10-dirty/fs/ntfs/fs.c
--- linux-2.5.10/fs/ntfs/fs.c	Wed Apr 24 00:15:12 2002
+++ linux-2.5.10-dirty/fs/ntfs/fs.c	Wed Apr 24 15:50:15 2002
@@ -250,6 +250,8 @@
 	int err;
 	struct ntfs_filldir cb;
 
+	lock_kernel();
+
 	cb.ret_code = 0;
 	cb.pl = filp->f_pos & 0xffff;
 	cb.ph = (filp->f_pos >> 16) & 0x7fff;
@@ -312,10 +314,12 @@
 					"returned %i, returning 0, f_pos "
 					"0x%Lx.\n", cb.ret_code, filp->f_pos);
 #endif
+		unlock_kernel();
 		return 0;
 	}
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning %i, f_pos 0x%Lx.\n",
 			err, filp->f_pos);
+	unlock_kernel();
 	return err;
 }
 
diff -ur linux-2.5.10/fs/openpromfs/inode.c linux-2.5.10-dirty/fs/openpromfs/inode.c
--- linux-2.5.10/fs/openpromfs/inode.c	Wed Apr 24 00:15:18 2002
+++ linux-2.5.10-dirty/fs/openpromfs/inode.c	Wed Apr 24 15:50:15 2002
@@ -756,12 +756,14 @@
 	u16 node;
 	char *p;
 	char buffer2[64];
+
+	lock_kernel();
 	
 	ino = inode->i_ino;
 	i = filp->f_pos;
 	switch (i) {
 	case 0:
-		if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0) return 0;
+		if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0) goto out;
 		i++;
 		filp->f_pos++;
 		/* fall thru */
@@ -769,7 +771,7 @@
 		if (filldir(dirent, "..", 2, i, 
 			(NODE(ino).parent == 0xffff) ? 
 			OPENPROM_ROOT_INO : NODE2INO(NODE(ino).parent), DT_DIR) < 0) 
-			return 0;
+			goto out;
 		i++;
 		filp->f_pos++;
 		/* fall thru */
@@ -782,17 +784,17 @@
 		}
 		while (node != 0xffff) {
 			if (prom_getname (nodes[node].node, buffer, 128) < 0)
-				return 0;
+				goto out;
 			if (filldir(dirent, buffer, strlen(buffer),
 				    filp->f_pos, NODE2INO(node), DT_DIR) < 0)
-				return 0;
+				goto out;
 			filp->f_pos++;
 			node = nodes[node].next;
 		}
 		j = NODEP2INO(NODE(ino).first_prop);
 		if (!i) {
 			if (filldir(dirent, ".node", 5, filp->f_pos, j, DT_REG) < 0)
-				return 0;
+				goto out;
 			filp->f_pos++;
 		} else
 			i--;
@@ -802,7 +804,7 @@
 				if (alias_names [i]) {
 					if (filldir (dirent, alias_names [i], 
 						strlen (alias_names [i]), 
-						filp->f_pos, j, DT_REG) < 0) return 0;
+						filp->f_pos, j, DT_REG) < 0) goto out; 
 					filp->f_pos++;
 				}
 			}
@@ -815,12 +817,14 @@
 				else {
 					if (filldir(dirent, p, strlen(p),
 						    filp->f_pos, j, DT_REG) < 0)
-						return 0;
+						goto out;
 					filp->f_pos++;
 				}
 			}
 		}
 	}
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/proc/base.c linux-2.5.10-dirty/fs/proc/base.c
--- linux-2.5.10/fs/proc/base.c	Wed Apr 24 00:15:10 2002
+++ linux-2.5.10-dirty/fs/proc/base.c	Wed Apr 24 15:50:15 2002
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/mm.h>
+#include <linux/smp_lock.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -571,6 +572,8 @@
 	struct dentry *de;
 	struct vfsmount *mnt = NULL;
 
+	lock_kernel();
+
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
 	error = proc_check_root(inode);
@@ -585,6 +588,7 @@
 	dput(de);
 	mntput(mnt);
 out:
+	unlock_kernel();
 	return error;
 }
 
@@ -665,38 +669,49 @@
 	int pid;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pid_entry *p;
+	int ret = 0;
+
+	lock_kernel();
 
 	pid = proc_task(inode)->pid;
-	if (!pid)
-		return -ENOENT;
+	if (!pid) {
+		ret = -ENOENT;
+		goto out;
+	}
 	i = filp->f_pos;
 	switch (i) {
 		case 0:
 			if (filldir(dirent, ".", 1, i, inode->i_ino, DT_DIR) < 0)
-				return 0;
+				goto out;
 			i++;
 			filp->f_pos++;
 			/* fall through */
 		case 1:
 			if (filldir(dirent, "..", 2, i, PROC_ROOT_INO, DT_DIR) < 0)
-				return 0;
+				goto out;
 			i++;
 			filp->f_pos++;
 			/* fall through */
 		default:
 			i -= 2;
-			if (i>=sizeof(base_stuff)/sizeof(base_stuff[0]))
-				return 1;
+			if (i>=sizeof(base_stuff)/sizeof(base_stuff[0])) {
+				ret = 1;
+				goto out;
+			}
 			p = base_stuff + i;
 			while (p->name) {
 				if (filldir(dirent, p->name, p->len, filp->f_pos,
 					    fake_ino(pid, p->type), p->mode >> 12) < 0)
-					return 0;
+					goto out;
 				filp->f_pos++;
 				p++;
 			}
 	}
-	return 1;
+
+	ret = 1;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 /* building an inode */
diff -ur linux-2.5.10/fs/proc/generic.c linux-2.5.10-dirty/fs/proc/generic.c
--- linux-2.5.10/fs/proc/generic.c	Wed Apr 24 00:15:23 2002
+++ linux-2.5.10-dirty/fs/proc/generic.c	Wed Apr 24 15:50:15 2002
@@ -304,16 +304,21 @@
 	unsigned int ino;
 	int i;
 	struct inode *inode = filp->f_dentry->d_inode;
+	int ret = 0;
+
+	lock_kernel();
 
 	ino = inode->i_ino;
 	de = PDE(inode);
-	if (!de)
-		return -EINVAL;
+	if (!de) {
+		ret = -EINVAL;
+		goto out;
+	}
 	i = filp->f_pos;
 	switch (i) {
 		case 0:
 			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
-				return 0;
+				goto out;
 			i++;
 			filp->f_pos++;
 			/* fall through */
@@ -321,7 +326,7 @@
 			if (filldir(dirent, "..", 2, i,
 				    parent_ino(filp->f_dentry),
 				    DT_DIR) < 0)
-				return 0;
+				goto out;
 			i++;
 			filp->f_pos++;
 			/* fall through */
@@ -329,8 +334,10 @@
 			de = de->subdir;
 			i -= 2;
 			for (;;) {
-				if (!de)
-					return 1;
+				if (!de) {
+					ret = 1;
+					goto out;
+				}
 				if (!i)
 					break;
 				de = de->next;
@@ -340,12 +347,14 @@
 			do {
 				if (filldir(dirent, de->name, de->namelen, filp->f_pos,
 					    de->low_ino, de->mode >> 12) < 0)
-					return 0;
+					goto out;
 				filp->f_pos++;
 				de = de->next;
 			} while (de);
 	}
-	return 1;
+	ret = 1;
+out:	unlock_kernel();
+	return ret;	
 }
 
 /*
diff -ur linux-2.5.10/fs/proc/root.c linux-2.5.10-dirty/fs/proc/root.c
--- linux-2.5.10/fs/proc/root.c	Wed Apr 24 00:15:21 2002
+++ linux-2.5.10-dirty/fs/proc/root.c	Wed Apr 24 15:50:15 2002
@@ -98,15 +98,22 @@
 	void * dirent, filldir_t filldir)
 {
 	unsigned int nr = filp->f_pos;
+	int ret;
+
+	lock_kernel();
 
 	if (nr < FIRST_PROCESS_ENTRY) {
 		int error = proc_readdir(filp, dirent, filldir);
-		if (error <= 0)
+		if (error <= 0) {
+			unlock_kernel();
 			return error;
+		}
 		filp->f_pos = FIRST_PROCESS_ENTRY;
 	}
 
-	return proc_pid_readdir(filp, dirent, filldir);
+	ret = proc_pid_readdir(filp, dirent, filldir);
+	unlock_kernel();
+	return ret;
 }
 
 /*
diff -ur linux-2.5.10/fs/qnx4/dir.c linux-2.5.10-dirty/fs/qnx4/dir.c
--- linux-2.5.10/fs/qnx4/dir.c	Wed Apr 24 00:15:20 2002
+++ linux-2.5.10-dirty/fs/qnx4/dir.c	Wed Apr 24 15:50:15 2002
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
 #include <linux/stat.h>
+#include <linux/smp_lock.h>
 
 
 static int qnx4_readdir(struct file *filp, void *dirent, filldir_t filldir)
@@ -33,6 +34,8 @@
 	QNX4DEBUG(("qnx4_readdir:i_size = %ld\n", (long) inode->i_size));
 	QNX4DEBUG(("filp->f_pos         = %ld\n", (long) filp->f_pos));
 
+	lock_kernel();
+
 	while (filp->f_pos < inode->i_size) {
 		blknum = qnx4_block_map( inode, filp->f_pos >> QNX4_BLOCK_SIZE_BITS );
 		bh = sb_bread(inode->i_sb, blknum);
@@ -63,7 +66,7 @@
 					}
 					if (filldir(dirent, de->di_fname, size, filp->f_pos, ino, DT_UNKNOWN) < 0) {
 						brelse(bh);
-						return 0;
+						goto out;
 					}
 				}
 			}
@@ -74,6 +77,8 @@
 	}
 	UPDATE_ATIME(inode);
 
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/readdir.c linux-2.5.10-dirty/fs/readdir.c
--- linux-2.5.10/fs/readdir.c	Wed Apr 24 00:15:18 2002
+++ linux-2.5.10-dirty/fs/readdir.c	Wed Apr 24 15:50:15 2002
@@ -23,9 +23,7 @@
 	down(&inode->i_sem);
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
-		lock_kernel();
 		res = file->f_op->readdir(file, buf, filler);
-		unlock_kernel();
 	}
 	up(&inode->i_sem);
 out:
diff -ur linux-2.5.10/fs/reiserfs/dir.c linux-2.5.10-dirty/fs/reiserfs/dir.c
--- linux-2.5.10/fs/reiserfs/dir.c	Wed Apr 24 00:15:20 2002
+++ linux-2.5.10-dirty/fs/reiserfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -47,7 +47,9 @@
     loff_t next_pos;
     char small_buf[32] ; /* avoid kmalloc if we can */
     struct reiserfs_dir_entry de;
+    int ret = 0;
 
+    lock_kernel();
 
     reiserfs_check_lock_depth("readdir") ;
 
@@ -66,7 +68,8 @@
 	if (search_res == IO_ERROR) {
 	    // FIXME: we could just skip part of directory which could
 	    // not be read
-	    return -EIO;
+	    ret = -EIO;
+	    goto out;
 	}
 	entry_num = de.de_entry_num;
 	bh = de.de_bh;
@@ -118,7 +121,8 @@
 		    local_buf = reiserfs_kmalloc(d_reclen, GFP_NOFS, inode->i_sb) ;
 		    if (!local_buf) {
 			pathrelse (&path_to_entry);
-			return -ENOMEM ;
+			ret = -ENOMEM ;
+			goto out;
 		    }
 		    if (item_moved (&tmp_ih, &path_to_entry)) {
 			reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
@@ -181,7 +185,9 @@
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
     UPDATE_ATIME(inode) ;
-    return 0;
+ out:
+    unlock_kernel();
+    return ret;
 }
 
 /* compose directory item containing "." and ".." entries (entries are
diff -ur linux-2.5.10/fs/romfs/inode.c linux-2.5.10-dirty/fs/romfs/inode.c
--- linux-2.5.10/fs/romfs/inode.c	Wed Apr 24 00:15:21 2002
+++ linux-2.5.10-dirty/fs/romfs/inode.c	Wed Apr 24 15:50:15 2002
@@ -273,13 +273,15 @@
 	int stored = 0;
 	char fsname[ROMFS_MAXFN];	/* XXX dynamic? */
 
+	lock_kernel();
+	
 	maxoff = i->i_sb->u.romfs_sb.s_maxsize;
 
 	offset = filp->f_pos;
 	if (!offset) {
 		offset = i->i_ino & ROMFH_MASK;
 		if (romfs_copyfrom(i, &ri, offset, ROMFH_SIZE) <= 0)
-			return stored;
+			goto out;
 		offset = ntohl(ri.spec) & ROMFH_MASK;
 	}
 
@@ -288,17 +290,17 @@
 		if (!offset || offset >= maxoff) {
 			offset = maxoff;
 			filp->f_pos = offset;
-			return stored;
+			goto out;
 		}
 		filp->f_pos = offset;
 
 		/* Fetch inode info */
 		if (romfs_copyfrom(i, &ri, offset, ROMFH_SIZE) <= 0)
-			return stored;
+			goto out;
 
 		j = romfs_strnlen(i, offset+ROMFH_SIZE, sizeof(fsname)-1);
 		if (j < 0)
-			return stored;
+			goto out;
 
 		fsname[j]=0;
 		romfs_copyfrom(i, fsname, offset+ROMFH_SIZE, j);
@@ -309,11 +311,14 @@
 			ino = ntohl(ri.spec);
 		if (filldir(dirent, fsname, j, offset, ino,
 			    romfs_dtype_table[nextfh & ROMFH_TYPE]) < 0) {
-			return stored;
+			goto out;
 		}
 		stored++;
 		offset = nextfh & ROMFH_MASK;
 	}
+out:
+	unlock_kernel();
+	return stored;
 }
 
 static struct dentry *
diff -ur linux-2.5.10/fs/smbfs/dir.c linux-2.5.10-dirty/fs/smbfs/dir.c
--- linux-2.5.10/fs/smbfs/dir.c	Wed Apr 24 00:15:17 2002
+++ linux-2.5.10-dirty/fs/smbfs/dir.c	Wed Apr 24 15:50:15 2002
@@ -75,6 +75,9 @@
 		DENTRY_PATH(dentry),  (int) filp->f_pos);
 
 	result = 0;
+
+	lock_kernel();
+
 	switch ((unsigned int) filp->f_pos) {
 	case 0:
 		if (filldir(dirent, ".", 1, 0, dir->i_ino, DT_DIR) < 0)
@@ -207,6 +210,7 @@
 		page_cache_release(ctl.page);
 	}
 out:
+	unlock_kernel();
 	return result;
 }
 
diff -ur linux-2.5.10/fs/smbfs/proc.c linux-2.5.10-dirty/fs/smbfs/proc.c
--- linux-2.5.10/fs/smbfs/proc.c	Wed Apr 24 00:15:11 2002
+++ linux-2.5.10-dirty/fs/smbfs/proc.c	Wed Apr 24 15:50:15 2002
@@ -17,6 +17,7 @@
 #include <linux/dcache.h>
 #include <linux/dirent.h>
 #include <linux/nls.h>
+#include <linux/smp_lock.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
@@ -1906,6 +1907,8 @@
 
 	VERBOSE("%s/%s\n", DENTRY_PATH(dir));
 
+	lock_kernel();
+
 	smb_lock_server(server);
 
 	first = 1;
@@ -2012,6 +2015,7 @@
 
 unlock_return:
 	smb_unlock_server(server);
+	unlock_kernel();
 	return result;
 }
 
@@ -2172,6 +2176,8 @@
 		len:	1,
 	};
 
+	lock_kernel();
+
 	/*
 	 * use info level 1 for older servers that don't do 260
 	 */
@@ -2357,6 +2363,7 @@
 
 unlock_return:
 	smb_unlock_server(server);
+	unlock_kernel();
 	return result;
 }
 
diff -ur linux-2.5.10/fs/sysv/dir.c linux-2.5.10-dirty/fs/sysv/dir.c
--- linux-2.5.10/fs/sysv/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/sysv/dir.c	Wed Apr 24 15:54:03 2002
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/sysv_fs.h>
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 static int sysv_readdir(struct file *, void *, filldir_t);
 
@@ -79,6 +80,8 @@
 	unsigned long n = pos >> PAGE_CACHE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 
+	lock_kernel();
+
 	pos = (pos + SYSV_DIRSIZE-1) & ~(SYSV_DIRSIZE-1);
 	if (pos >= inode->i_size)
 		goto done;
@@ -116,6 +119,7 @@
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	UPDATE_ATIME(inode);
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/udf/dir.c linux-2.5.10-dirty/fs/udf/dir.c
--- linux-2.5.10/fs/udf/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/udf/dir.c	Wed Apr 24 15:50:15 2002
@@ -35,6 +35,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -83,15 +84,20 @@
 	struct inode *dir = filp->f_dentry->d_inode;
 	int result;
 
+	lock_kernel();
+
 	if ( filp->f_pos == 0 ) 
 	{
-		if (filldir(dirent, ".", 1, filp->f_pos, dir->i_ino, DT_DIR) < 0)
+		if (filldir(dirent, ".", 1, filp->f_pos, dir->i_ino, DT_DIR) < 0) {
+			unlock_kernel();
 			return 0;
+		}
 		filp->f_pos ++;
 	}
  
 	result = do_udf_readdir(dir, filp, filldir, dirent);
 	UPDATE_ATIME(dir);
+	unlock_kernel();
  	return result;
 }
 
diff -ur linux-2.5.10/fs/ufs/dir.c linux-2.5.10-dirty/fs/ufs/dir.c
--- linux-2.5.10/fs/ufs/dir.c	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dirty/fs/ufs/dir.c	Wed Apr 24 15:50:15 2002
@@ -17,6 +17,7 @@
 #include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
+#include <linux/smp_lock.h>
 
 #include "swab.h"
 #include "util.h"
@@ -62,6 +63,8 @@
 	int de_reclen;
 	unsigned flags;
 
+	lock_kernel();
+
 	sb = inode->i_sb;
 	flags = sb->u.ufs_sb.s_flags;
 
@@ -117,6 +120,7 @@
 				              (sb->s_blocksize - 1)) +
 				               sb->s_blocksize;
 				brelse(bh);
+				unlock_kernel();
 				return stored;
 			}
 			if (!ufs_check_dir_entry ("ufs_readdir", inode, de,
@@ -127,6 +131,7 @@
 				              (sb->s_blocksize - 1)) +
 					       1;
 				brelse (bh);
+				unlock_kernel();
 				return stored;
 			}
 			offset += fs16_to_cpu(sb, de->d_reclen);
@@ -161,6 +166,7 @@
 		brelse (bh);
 	}
 	UPDATE_ATIME(inode);
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.10/fs/umsdos/dir.c linux-2.5.10-dirty/fs/umsdos/dir.c
--- linux-2.5.10/fs/umsdos/dir.c	Wed Apr 24 00:15:18 2002
+++ linux-2.5.10-dirty/fs/umsdos/dir.c	Wed Apr 24 15:50:15 2002
@@ -17,6 +17,7 @@
 #include <linux/umsdos_fs.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 #define UMSDOS_SPECIAL_DIRFPOS	3
 extern struct dentry *saved_root;
@@ -302,6 +303,8 @@
 	int ret = 0, count = 0;
 	struct UMSDOS_DIR_ONCE bufk;
 
+	lock_kernel();
+
 	bufk.dirbuf = dirbuf;
 	bufk.filldir = filldir;
 	bufk.stop = 0;
@@ -317,6 +320,7 @@
 			break;
 		count += bufk.count;
 	}
+	unlock_kernel();
 	Printk (("UMSDOS_readdir out %d count %d pos %Ld\n", 
 		ret, count, filp->f_pos));
 	return count ? : ret;
diff -ur linux-2.5.10/fs/umsdos/rdir.c linux-2.5.10-dirty/fs/umsdos/rdir.c
--- linux-2.5.10/fs/umsdos/rdir.c	Wed Apr 24 00:15:12 2002
+++ linux-2.5.10-dirty/fs/umsdos/rdir.c	Wed Apr 24 15:50:15 2002
@@ -15,6 +15,7 @@
 #include <linux/limits.h>
 #include <linux/umsdos_fs.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -63,11 +64,15 @@
 {
 	struct inode *dir = filp->f_dentry->d_inode;
 	struct RDIR_FILLDIR bufk;
+	int ret;
 
+	lock_kernel();
 	bufk.filldir = filldir;
 	bufk.dirbuf = dirbuf;
 	bufk.real_root = pseudo_root && (dir == saved_root->d_inode);
-	return fat_readdir (filp, &bufk, rdir_filldir);
+	ret = fat_readdir (filp, &bufk, rdir_filldir);
+	unlock_kernel();
+	return ret;
 }
 
 

--------------020305080009000400070707--

