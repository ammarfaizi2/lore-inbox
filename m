Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJ2Q44>; Tue, 29 Oct 2002 11:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSJ2Q4z>; Tue, 29 Oct 2002 11:56:55 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:17166 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262137AbSJ2QyG>; Tue, 29 Oct 2002 11:54:06 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove the fat_cvf stuff (2/3)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Oct 2002 02:00:17 +0900
Message-ID: <87bs5db2ou.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This removes fat_cvf stuff, and adds printk() level. As far as I
know, all the challengers gave up porting of fat_cvf.
(This patch from Christoph Hellwig)

Please apply.

 fs/fat/Makefile             |    2 
 fs/fat/cache.c              |   69 ++++++-----------
 fs/fat/dir.c                |   29 ++-----
 fs/fat/fatfs_syms.c         |    5 -
 fs/fat/file.c               |   41 +---------
 fs/fat/inode.c              |  142 +++++++++--------------------------
 fs/fat/misc.c               |   66 ++++++----------
 fs/msdos/namei.c            |   53 +++++--------
 fs/vfat/namei.c             |   35 ++++----
 include/linux/msdos_fs.h    |   15 ---
 include/linux/msdos_fs_sb.h |    3 
 fs/fat/buffer.c             |   97 ------------------------
 fs/fat/cvf.c                |  176 --------------------------------------------
 include/linux/fat_cvf.h     |   47 -----------
 14 files changed, 144 insertions(+), 636 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- fat-2.5.44/fs/fat/Makefile~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/Makefile	2002-10-24 00:14:05.000000000 +0900
@@ -6,6 +6,6 @@ export-objs := fatfs_syms.o
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := buffer.o cache.o dir.o file.o inode.o misc.o cvf.o fatfs_syms.o
+fat-objs := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
 
 include $(TOPDIR)/Rules.make
--- fat-2.5.44/fs/fat/buffer.c
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,97 +0,0 @@
-/*
- * linux/fs/fat/buffer.c
- *
- *
- */
-
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
-#include <linux/buffer_head.h>
-
-struct buffer_head *fat_bread(struct super_block *sb, int block)
-{
-	return MSDOS_SB(sb)->cvf_format->cvf_bread(sb,block);
-}
-struct buffer_head *fat_getblk(struct super_block *sb, int block)
-{
-	return MSDOS_SB(sb)->cvf_format->cvf_getblk(sb,block);
-}
-void fat_brelse (struct super_block *sb, struct buffer_head *bh)
-{
-	if (bh) 
-		MSDOS_SB(sb)->cvf_format->cvf_brelse(sb,bh);
-}
-void fat_mark_buffer_dirty (
-	struct super_block *sb,
-	struct buffer_head *bh)
-{
-	MSDOS_SB(sb)->cvf_format->cvf_mark_buffer_dirty(sb,bh);
-}
-void fat_set_uptodate (
-	struct super_block *sb,
-	struct buffer_head *bh,
-	int val)
-{
-	MSDOS_SB(sb)->cvf_format->cvf_set_uptodate(sb,bh,val);
-}
-int fat_is_uptodate(struct super_block *sb, struct buffer_head *bh)
-{
-	return MSDOS_SB(sb)->cvf_format->cvf_is_uptodate(sb,bh);
-}
-void fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32])
-{
-	MSDOS_SB(sb)->cvf_format->cvf_ll_rw_block(sb,opr,nbreq,bh);
-}
-
-struct buffer_head *default_fat_bread(struct super_block *sb, int block)
-{
-	return sb_bread(sb, block);
-}
-
-struct buffer_head *default_fat_getblk(struct super_block *sb, int block)
-{
-	return sb_getblk(sb, block);
-}
-
-void default_fat_brelse(struct super_block *sb, struct buffer_head *bh)
-{
-	brelse (bh);
-}
-
-void default_fat_mark_buffer_dirty (
-	struct super_block *sb,
-	struct buffer_head *bh)
-{
-	mark_buffer_dirty (bh);
-}
-
-void default_fat_set_uptodate (
-	struct super_block *sb,
-	struct buffer_head *bh,
-	int val)
-{
-	if (val)
-		set_buffer_uptodate(bh);
-	else
-		clear_buffer_uptodate(bh);
-}
-
-int default_fat_is_uptodate (struct super_block *sb, struct buffer_head *bh)
-{
-	return buffer_uptodate(bh);
-}
-
-void default_fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32])
-{
-	ll_rw_block(opr,nbreq,bh);
-}
--- fat-2.5.44/fs/fat/cache.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/cache.c	2002-10-24 00:14:05.000000000 +0900
@@ -10,31 +10,11 @@
 
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/buffer_head.h>
 
-#if 0
-#  define PRINTK(x) printk x
-#else
-#  define PRINTK(x)
-#endif
-
 static struct fat_cache *fat_cache,cache[FAT_CACHE];
 static spinlock_t fat_cache_lock = SPIN_LOCK_UNLOCKED;
 
-/* Returns the this'th FAT entry, -1 if it is an end-of-file entry. If
-   new_value is != -1, that FAT entry is replaced by it. */
-
-int fat_access(struct super_block *sb,int nr,int new_value)
-{
-	return MSDOS_SB(sb)->cvf_format->fat_access(sb,nr,new_value);
-}
-
-int fat_bmap(struct inode *inode,int sector)
-{
-	return MSDOS_SB(inode->i_sb)->cvf_format->cvf_bmap(inode,sector);
-}
-
 int __fat_access(struct super_block *sb, int nr, int new_value)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -51,17 +31,18 @@ int __fat_access(struct super_block *sb,
 		last = first+1;
 	}
 	b = sbi->fat_start + (first >> sb->s_blocksize_bits);
-	if (!(bh = fat_bread(sb, b))) {
-		printk("FAT: bread(block %d) in fat_access failed\n", b);
+	if (!(bh = sb_bread(sb, b))) {
+		printk(KERN_ERR "FAT: bread(block %d) in"
+		       " fat_access failed\n", b);
 		return -EIO;
 	}
 	if ((first >> sb->s_blocksize_bits) == (last >> sb->s_blocksize_bits)) {
 		bh2 = bh;
 	} else {
-		if (!(bh2 = fat_bread(sb, b+1))) {
-			fat_brelse(sb, bh);
-			printk("FAT: bread(block %d) in fat_access failed\n",
-			       b + 1);
+		if (!(bh2 = sb_bread(sb, b + 1))) {
+			brelse(bh);
+			printk(KERN_ERR "FAT: bread(block %d) in"
+			       " fat_access failed\n", b + 1);
 			return -EIO;
 		}
 	}
@@ -99,35 +80,39 @@ int __fat_access(struct super_block *sb,
 				*p_first = new_value & 0xff;
 				*p_last = (*p_last & 0xf0) | (new_value >> 8);
 			}
-			fat_mark_buffer_dirty(sb, bh2);
+			mark_buffer_dirty(bh2);
 		}
-		fat_mark_buffer_dirty(sb, bh);
+		mark_buffer_dirty(bh);
 		for (copy = 1; copy < sbi->fats; copy++) {
 			b = sbi->fat_start + (first >> sb->s_blocksize_bits)
 				+ sbi->fat_length * copy;
-			if (!(c_bh = fat_bread(sb, b)))
+			if (!(c_bh = sb_bread(sb, b)))
 				break;
 			if (bh != bh2) {
-				if (!(c_bh2 = fat_bread(sb, b+1))) {
-					fat_brelse(sb, c_bh);
+				if (!(c_bh2 = sb_bread(sb, b+1))) {
+					brelse(c_bh);
 					break;
 				}
 				memcpy(c_bh2->b_data, bh2->b_data, sb->s_blocksize);
-				fat_mark_buffer_dirty(sb, c_bh2);
-				fat_brelse(sb, c_bh2);
+				mark_buffer_dirty(c_bh2);
+				brelse(c_bh2);
 			}
 			memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
-			fat_mark_buffer_dirty(sb, c_bh);
-			fat_brelse(sb, c_bh);
+			mark_buffer_dirty(c_bh);
+			brelse(c_bh);
 		}
 	}
-	fat_brelse(sb, bh);
+	brelse(bh);
 	if (bh != bh2)
-		fat_brelse(sb, bh2);
+		brelse(bh2);
 	return next;
 }
 
-int default_fat_access(struct super_block *sb, int nr, int new_value)
+/* 
+ * Returns the this'th FAT entry, -1 if it is an end-of-file entry. If
+ * new_value is != -1, that FAT entry is replaced by it.
+ */
+int fat_access(struct super_block *sb, int nr, int new_value)
 {
 	int next;
 
@@ -150,7 +135,7 @@ out:
 
 void fat_cache_init(void)
 {
-	static int initialized = 0;
+	static int initialized;
 	int count;
 
 	spin_lock(&fat_cache_lock);
@@ -227,8 +212,8 @@ void fat_cache_add(struct inode *inode,i
 		    && walk->start_cluster == first
 		    && walk->file_cluster == f_clu) {
 			if (walk->disk_cluster != d_clu) {
-				printk("FAT: cache corruption inode=%lu\n",
-					inode->i_ino);
+				printk(KERN_ERR "FAT: cache corruption"
+				       " (ino %lu)\n", inode->i_ino);
 				spin_unlock(&fat_cache_lock);
 				fat_cache_inval_inode(inode);
 				return;
@@ -317,7 +302,7 @@ static int fat_get_cluster(struct inode 
 	return nr;
 }
 
-int default_fat_bmap(struct inode *inode,int sector)
+int fat_bmap(struct inode *inode, int sector)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
--- fat-2.5.44/fs/fat/cvf.c
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,176 +0,0 @@
-/* 
- * CVF extensions for fat-based filesystems
- *
- * written 1997,1998 by Frank Gockel <gockel@sent13.uni-duisburg.de>
- *
- * please do not remove the next line, dmsdos needs it for verifying patches
- * CVF-FAT-VERSION-ID: 1.2.0
- *
- */
- 
-#include <linux/fs.h>
-#include <linux/msdos_fs.h>
-#include <linux/msdos_fs_sb.h>
-#include <linux/fat_cvf.h>
-#include <linux/config.h>
-#include <linux/buffer_head.h>
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
-
-#define MAX_CVF_FORMATS 3
-
-struct buffer_head *default_fat_bread(struct super_block *,int);
-struct buffer_head *default_fat_getblk(struct super_block *, int);
-void default_fat_brelse(struct super_block *, struct buffer_head *);
-void default_fat_mark_buffer_dirty (struct super_block *, struct buffer_head *);
-void default_fat_set_uptodate (struct super_block *, struct buffer_head *,int);
-int default_fat_is_uptodate(struct super_block *, struct buffer_head *);
-int default_fat_access(struct super_block *sb,int nr,int new_value);
-void default_fat_ll_rw_block (struct super_block *sb, int opr, int nbreq,
-			      struct buffer_head *bh[32]);
-int default_fat_bmap(struct inode *inode,int block);
-ssize_t default_fat_file_write(struct file *filp, const char *buf,
-			       size_t count, loff_t *ppos);
-
-struct cvf_format default_cvf = {
-	cvf_version: 		0,	/* version - who cares? */	
-	cvf_version_text: 	"plain",
-	flags:			0,	/* flags - who cares? */
-	cvf_bread:		default_fat_bread,
-	cvf_getblk:		default_fat_getblk,
-	cvf_brelse:		default_fat_brelse,
-	cvf_mark_buffer_dirty:	default_fat_mark_buffer_dirty,
-	cvf_set_uptodate:	default_fat_set_uptodate,
-	cvf_is_uptodate:	default_fat_is_uptodate,
-	cvf_ll_rw_block:	default_fat_ll_rw_block,
-	fat_access:		default_fat_access,
-	cvf_bmap:		default_fat_bmap,
-	cvf_file_read:		generic_file_read,
-	cvf_file_write:		default_fat_file_write,
-};
-
-struct cvf_format *cvf_formats[MAX_CVF_FORMATS];
-int cvf_format_use_count[MAX_CVF_FORMATS];
-
-int register_cvf_format(struct cvf_format*cvf_format)
-{ int i,j;
-
-  for(i=0;i<MAX_CVF_FORMATS;++i)
-  { if(cvf_formats[i]==NULL)
-    { /* free slot found, now check version */
-      for(j=0;j<MAX_CVF_FORMATS;++j)
-      { if(cvf_formats[j])
-        { if(cvf_formats[j]->cvf_version==cvf_format->cvf_version)
-          { printk("register_cvf_format: version %d already registered\n",
-                   cvf_format->cvf_version);
-            return -1;
-          }
-        }
-      }
-      cvf_formats[i]=cvf_format;
-      cvf_format_use_count[i]=0;
-      printk("CVF format %s (version id %d) successfully registered.\n",
-             cvf_format->cvf_version_text,cvf_format->cvf_version);
-      return 0;
-    }
-  }
-  
-  printk("register_cvf_format: too many formats\n");
-  return -1;
-}
-
-int unregister_cvf_format(struct cvf_format*cvf_format)
-{ int i;
-
-  for(i=0;i<MAX_CVF_FORMATS;++i)
-  { if(cvf_formats[i])
-    { if(cvf_formats[i]->cvf_version==cvf_format->cvf_version)
-      { if(cvf_format_use_count[i])
-        { printk("unregister_cvf_format: format %d in use, cannot remove!\n",
-          cvf_formats[i]->cvf_version);
-          return -1;
-        }
-      
-        printk("CVF format %s (version id %d) successfully unregistered.\n",
-        cvf_formats[i]->cvf_version_text,cvf_formats[i]->cvf_version);
-        cvf_formats[i]=NULL;
-        return 0;
-      }
-    }
-  }
-  
-  printk("unregister_cvf_format: format %d is not registered\n",
-         cvf_format->cvf_version);
-  return -1;
-}
-
-void dec_cvf_format_use_count_by_version(int version)
-{ int i;
-
-  for(i=0;i<MAX_CVF_FORMATS;++i)
-  { if(cvf_formats[i])
-    { if(cvf_formats[i]->cvf_version==version)
-      { --cvf_format_use_count[i];
-        if(cvf_format_use_count[i]<0)
-        { cvf_format_use_count[i]=0;
-          printk(KERN_EMERG "FAT FS/CVF: This is a bug in cvf_version_use_count\n");
-        }
-        return;
-      }
-    }
-  }
-  
-  printk("dec_cvf_format_use_count_by_version: version %d not found ???\n",
-         version);
-}
-
-int detect_cvf(struct super_block*sb,char*force)
-{ int i;
-  int found=0;
-  int found_i=-1;
-
-  if(force)
-    if(strcmp(force,"autoload")==0)
-    {
-#ifdef CONFIG_KMOD
-      request_module("cvf_autoload");
-      force=NULL;
-#else
-      printk("cannot autoload CVF modules: kmod support is not compiled into kernel\n");
-      return -1;
-#endif
-    }
-    
-#ifdef CONFIG_KMOD
-  if(force)
-    if(*force)
-      request_module(force);
-#endif
-
-  if(force)
-  { if(*force)
-    { for(i=0;i<MAX_CVF_FORMATS;++i)
-      { if(cvf_formats[i])
-        { if(!strcmp(cvf_formats[i]->cvf_version_text,force))
-            return i;
-        }
-      }
-      printk("CVF format %s unknown (module not loaded?)\n",force);
-      return -1;
-    }
-  }
-
-  for(i=0;i<MAX_CVF_FORMATS;++i)
-  { if(cvf_formats[i])
-    { if(cvf_formats[i]->detect_cvf(sb))
-      { ++found;
-        found_i=i;
-      }
-    }
-  }
-  
-  if(found==1)return found_i;
-  if(found>1)printk("CVF detection ambiguous, please use cvf_format=xxx option\n"); 
-  return -1;
-}
--- fat-2.5.44/fs/fat/dir.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/dir.c	2002-10-24 00:14:05.000000000 +0900
@@ -22,8 +22,6 @@
 
 #include <asm/uaccess.h>
 
-#define PRINTK(X)
-
 struct file_operations fat_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	fat_readdir,
@@ -219,7 +217,7 @@ parse_record:
 				unicode = (wchar_t *)
 					__get_free_page(GFP_KERNEL);
 				if (!unicode) {
-					fat_brelse(sb, bh);
+					brelse(bh);
 					return -ENOMEM;
 				}
 			}
@@ -335,7 +333,7 @@ Found:
 	*spos = cpos - sizeof(struct msdos_dir_entry);
 	*lpos = cpos - res*sizeof(struct msdos_dir_entry);
 EODir:
-	fat_brelse(sb, bh);
+	brelse(bh);
 	if (unicode) {
 		free_page((unsigned long) unicode);
 	}
@@ -417,7 +415,7 @@ GetNew:
 				__get_free_page(GFP_KERNEL);
 			if (!unicode) {
 				filp->f_pos = cpos;
-				fat_brelse(sb, bh);
+				brelse(bh);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -578,7 +576,7 @@ EODir:
 	filp->f_pos = cpos;
 FillFailed:
 	if (bh)
-		fat_brelse(sb, bh);
+		brelse(bh);
 	if (unicode) {
 		free_page((unsigned long) unicode);
 	}
@@ -636,8 +634,6 @@ static int vfat_ioctl_fill(
 		put_user(0, d1->d_name+len);
 		put_user(len, &d1->d_reclen);
 	}
-	PRINTK(("FAT d1=%p d2=%p len=%d, name_len=%d\n",
-		d1, d2, len, name_len));
 
 	return 0;
 }
@@ -672,11 +668,6 @@ int fat_dir_ioctl(struct inode * inode, 
 				    vfat_ioctl_fill, 1, 1);
 	}
 	default:
-		/* forward ioctl to CVF extension */
-	       if (MSDOS_SB(inode->i_sb)->cvf_format &&
-		   MSDOS_SB(inode->i_sb)->cvf_format->cvf_dir_ioctl)
-		       return MSDOS_SB(inode->i_sb)->cvf_format
-			       ->cvf_dir_ioctl(inode,filp,cmd,arg);
 		return -EINVAL;
 	}
 
@@ -704,9 +695,8 @@ int fat_dir_empty(struct inode *dir)
 			break;
 		}
 	}
-	if (bh)
-		fat_brelse(dir->i_sb, bh);
 
+	brelse(bh);
 	return result;
 }
 
@@ -726,7 +716,7 @@ int fat_add_entries(struct inode *dir,in
 	while (fat_get_entry(dir, &curr, bh, de, ino) > -1) {
 		/* check the maximum size of directory */
 		if (curr >= FAT_MAX_DIR_SIZE) {
-			fat_brelse(sb, *bh);
+			brelse(*bh);
 			return -ENOSPC;
 		}
 
@@ -743,7 +733,7 @@ int fat_add_entries(struct inode *dir,in
 	new_bh = fat_extend_dir(dir);
 	if (IS_ERR(new_bh))
 		return PTR_ERR(new_bh);
-	fat_brelse(sb, new_bh);
+	brelse(new_bh);
 	do {
 		fat_get_entry(dir, &curr, bh, de, ino);
 	} while (++row < slots);
@@ -753,7 +743,6 @@ int fat_add_entries(struct inode *dir,in
 
 int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat)
 {
-	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	__u16 date, time;
@@ -779,8 +768,8 @@ int fat_new_dir(struct inode *dir, struc
 	de[0].starthi = CT_LE_W(MSDOS_I(dir)->i_logstart>>16);
 	de[1].start = CT_LE_W(MSDOS_I(parent)->i_logstart);
 	de[1].starthi = CT_LE_W(MSDOS_I(parent)->i_logstart>>16);
-	fat_mark_buffer_dirty(sb, bh);
-	fat_brelse(sb, bh);
+	mark_buffer_dirty(bh);
+	brelse(bh);
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
--- fat-2.5.44/fs/fat/fatfs_syms.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/fatfs_syms.c	2002-10-24 00:14:05.000000000 +0900
@@ -10,7 +10,6 @@
 
 #include <linux/mm.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 
 EXPORT_SYMBOL(fat_new_dir);
 EXPORT_SYMBOL(fat_get_block);
@@ -18,7 +17,6 @@ EXPORT_SYMBOL(fat_clear_inode);
 EXPORT_SYMBOL(fat_date_unix2dos);
 EXPORT_SYMBOL(fat_delete_inode);
 EXPORT_SYMBOL(fat__get_entry);
-EXPORT_SYMBOL(fat_mark_buffer_dirty);
 EXPORT_SYMBOL(fat_notify_change);
 EXPORT_SYMBOL(fat_put_super);
 EXPORT_SYMBOL(fat_attach);
@@ -30,13 +28,10 @@ EXPORT_SYMBOL(fat_readdir);
 EXPORT_SYMBOL(fat_scan);
 EXPORT_SYMBOL(fat_statfs);
 EXPORT_SYMBOL(fat_write_inode);
-EXPORT_SYMBOL(register_cvf_format);
-EXPORT_SYMBOL(unregister_cvf_format);
 EXPORT_SYMBOL(fat_dir_ioctl);
 EXPORT_SYMBOL(fat_add_entries);
 EXPORT_SYMBOL(fat_dir_empty);
 EXPORT_SYMBOL(fat_truncate);
-EXPORT_SYMBOL(fat_brelse);
 
 int __init fat_init_inodecache(void);
 void __exit fat_destroy_inodecache(void);
--- fat-2.5.44/fs/fat/file.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/file.c	2002-10-24 00:14:05.000000000 +0900
@@ -8,16 +8,15 @@
 
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
-#define PRINTK(x)
-#define Printk(x) printk x
+static ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
+			      loff_t *ppos);
 
 struct file_operations fat_file_operations = {
 	llseek:		generic_file_llseek,
-	read:		fat_file_read,
+	read:		generic_file_read,
 	write:		fat_file_write,
 	mmap:		generic_file_mmap,
 	fsync:		file_fsync,
@@ -29,19 +28,8 @@ struct inode_operations fat_file_inode_o
 	setattr:	fat_notify_change,
 };
 
-ssize_t fat_file_read(
-	struct file *filp,
-	char *buf,
-	size_t count,
-	loff_t *ppos)
-{
-	struct inode *inode = filp->f_dentry->d_inode;
-	return MSDOS_SB(inode->i_sb)->cvf_format
-			->cvf_file_read(filp,buf,count,ppos);
-}
-
-
-int fat_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+int fat_get_block(struct inode *inode, sector_t iblock,
+		  struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned long phys;
@@ -77,23 +65,8 @@ int fat_get_block(struct inode *inode, s
 	return 0;
 }
 
-ssize_t fat_file_write(
-	struct file *filp,
-	const char *buf,
-	size_t count,
-	loff_t *ppos)
-{
-	struct inode *inode = filp->f_dentry->d_inode;
-	struct super_block *sb = inode->i_sb;
-	return MSDOS_SB(sb)->cvf_format
-			->cvf_file_write(filp,buf,count,ppos);
-}
-
-ssize_t default_fat_file_write(
-	struct file *filp,
-	const char *buf,
-	size_t count,
-	loff_t *ppos)
+static ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
+			      loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
--- fat-2.5.44/fs/fat/inode.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/inode.c	2002-10-24 00:14:05.000000000 +0900
@@ -16,28 +16,10 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
-
-//#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern struct cvf_format default_cvf;
-
-/* #define FAT_PARANOIA 1 */
-#define DEBUG_LEVEL 0
-#ifdef FAT_DEBUG
-#  define PRINTK(x) printk x
-#else
-#  define PRINTK(x)
-#endif
-#if (DEBUG_LEVEL >= 1)
-#  define PRINTK1(x) printk x
-#else
-#  define PRINTK1(x)
-#endif
-
 /*
  * New FAT inode stuff. We do the following:
  *	a) i_ino is constant and has nothing with on-disk location.
@@ -175,10 +157,6 @@ void fat_put_super(struct super_block *s
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	if (sbi->cvf_format->cvf_version) {
-		dec_cvf_format_use_count_by_version(sbi->cvf_format->cvf_version);
-		sbi->cvf_format->unmount_cvf(sb);
-	}
 	fat_clusters_flush(sb);
 	fat_cache_inval_dev(sb);
 	if (sbi->nls_disk) {
@@ -279,8 +257,7 @@ static int fat_show_options(struct seq_f
 }
 
 static int parse_options(char *options, int is_vfat, int *debug,
-			 struct fat_mount_options *opts,
-			 char *cvf_format, char *cvf_options)
+			 struct fat_mount_options *opts)
 {
 	char *this_char, *value, *p;
 	int ret = 1, val, len;
@@ -323,7 +300,7 @@ static int parse_options(char *options, 
 			else ret = 0;
 		}
 		else if (!strcmp(this_char,"conv") && value) {
-			printk("FAT: conv option is obsolete, "
+			printk(KERN_INFO "FAT: conv option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"nocase")) {
@@ -371,7 +348,7 @@ static int parse_options(char *options, 
 			else *debug = 1;
 		}
 		else if (!strcmp(this_char,"fat")) {
-			printk("FAT: fat option is obsolete, "
+			printk(KERN_INFO "FAT: fat option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"quiet")) {
@@ -379,7 +356,7 @@ static int parse_options(char *options, 
 			else opts->quiet = 1;
 		}
 		else if (!strcmp(this_char,"blocksize")) {
-			printk("FAT: blocksize option is obsolete, "
+			printk(KERN_INFO "FAT: blocksize option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"sys_immutable")) {
@@ -390,16 +367,6 @@ static int parse_options(char *options, 
 			opts->codepage = simple_strtoul(value,&value,0);
 			if (*value) ret = 0;
 		}
-		else if (!strcmp(this_char,"cvf_format")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_format,value,20);
-		}
-		else if (!strcmp(this_char,"cvf_options")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_options,value,100);
-		}
 
 		/* msdos specific */
 		else if (!is_vfat && !strcmp(this_char,"dots")) {
@@ -445,7 +412,7 @@ static int parse_options(char *options, 
 			if (ret) opts->unicode_xlate = val;
 		}
 		else if (is_vfat && !strcmp(this_char,"posix")) {
-			printk("FAT: posix option is obsolete, "
+			printk(KERN_INFO "FAT: posix option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (is_vfat && !strcmp(this_char,"nonumtail")) {
@@ -470,7 +437,7 @@ static int parse_options(char *options, 
 			else
 				ret = 0;
 		} else {
-			printk("FAT: Unrecognized mount option %s\n",
+			printk(KERN_ERR "FAT: Unrecognized mount option %s\n",
 			       this_char);
 			ret = 0;
 		}
@@ -632,7 +599,6 @@ struct dentry *fat_get_dentry(struct sup
 	result->d_op = sb->s_root->d_op;
 	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
-		
 }
 
 int fat_encode_fh(struct dentry *de, __u32 *fh, int *lenp, int connectable)
@@ -682,7 +648,7 @@ struct dentry *fat_get_parent(struct den
 
  out:
 	if(bh)
-		fat_brelse(child->d_sb, bh);
+		brelse(bh);
 	unlock_kernel();
 	if (res)
 		return ERR_PTR(res);
@@ -770,9 +736,6 @@ int fat_fill_super(struct super_block *s
 	unsigned char media;
 	long error;
 	char buf[50];
-	int i;
-	char cvf_format[21];
-	char cvf_options[101];
 
 	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -780,19 +743,13 @@ int fat_fill_super(struct super_block *s
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct msdos_sb_info));
 
-	cvf_format[0] = '\0';
-	cvf_options[0] = '\0';
-	sbi->private_data = NULL;
-
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
 	sb->s_export_op = &fat_export_ops;
 	sbi->dir_ops = fs_dir_inode_ops;
-	sbi->cvf_format = &default_cvf;
 
 	error = -EINVAL;
-	if (!parse_options((char *)data, isvfat, &debug, &sbi->options,
-			   cvf_format, cvf_options))
+	if (!parse_options(data, isvfat, &debug, &sbi->options))
 		goto out_fail;
 
 	fat_cache_init();
@@ -803,39 +760,40 @@ int fat_fill_super(struct super_block *s
 	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
 	if (bh == NULL) {
-		printk("FAT: unable to read boot sector\n");
+		printk(KERN_ERR "FAT: unable to read boot sector\n");
 		goto out_fail;
 	}
 
 	b = (struct fat_boot_sector *) bh->b_data;
 	if (!b->reserved) {
 		if (!silent)
-			printk("FAT: bogus number of reserved sectors\n");
+			printk(KERN_ERR "FAT: bogus number of reserved sectors\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->fats) {
 		if (!silent)
-			printk("FAT: bogus number of FAT structure\n");
+			printk(KERN_ERR "FAT: bogus number of FAT structure\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->secs_track) {
 		if (!silent)
-			printk("FAT: bogus sectors-per-track value\n");
+			printk(KERN_ERR "FAT: bogus sectors-per-track value\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->heads) {
 		if (!silent)
-			printk("FAT: bogus number-of-heads value\n");
+			printk(KERN_ERR "FAT: bogus number-of-heads value\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	media = b->media;
 	if (!FAT_VALID_MEDIA(media)) {
 		if (!silent)
-			printk("FAT: invalid media value (0x%02x)\n", media);
+			printk(KERN_ERR "FAT: invalid media value (0x%02x)\n",
+			       media);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -846,7 +804,7 @@ int fat_fill_super(struct super_block *s
 	    || (logical_sector_size < 512)
 	    || (PAGE_CACHE_SIZE < logical_sector_size)) {
 		if (!silent)
-			printk("FAT: bogus logical sector size %d\n",
+			printk(KERN_ERR "FAT: bogus logical sector size %d\n",
 			       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
@@ -855,14 +813,14 @@ int fat_fill_super(struct super_block *s
 	if (!sbi->cluster_size
 	    || (sbi->cluster_size & (sbi->cluster_size - 1))) {
 		if (!silent)
-			printk("FAT: bogus cluster size %d\n",
+			printk(KERN_ERR "FAT: bogus cluster size %d\n",
 			       sbi->cluster_size);
 		brelse(bh);
 		goto out_invalid;
 	}
 
 	if (logical_sector_size < sb->s_blocksize) {
-		printk("FAT: logical sector size too small for device"
+		printk(KERN_ERR "FAT: logical sector size too small for device"
 		       " (logical sector size = %d)\n", logical_sector_size);
 		brelse(bh);
 		goto out_fail;
@@ -871,13 +829,13 @@ int fat_fill_super(struct super_block *s
 		brelse(bh);
 
 		if (!sb_set_blocksize(sb, logical_sector_size)) {
-			printk("FAT: unable to set blocksize %d\n",
+			printk(KERN_ERR "FAT: unable to set blocksize %d\n",
 			       logical_sector_size);
 			goto out_fail;
 		}
 		bh = sb_bread(sb, 0);
 		if (bh == NULL) {
-			printk("FAT: unable to read boot sector"
+			printk(KERN_ERR "FAT: unable to read boot sector"
 			       " (logical sector size = %lu)\n",
 			       sb->s_blocksize);
 			goto out_fail;
@@ -912,7 +870,7 @@ int fat_fill_super(struct super_block *s
 
 		fsinfo_bh = sb_bread(sb, sbi->fsinfo_sector);
 		if (fsinfo_bh == NULL) {
-			printk("FAT: bread failed, FSINFO block"
+			printk(KERN_ERR "FAT: bread failed, FSINFO block"
 			       " (sector = %lu)\n", sbi->fsinfo_sector);
 			brelse(bh);
 			goto out_fail;
@@ -920,7 +878,8 @@ int fat_fill_super(struct super_block *s
 
 		fsinfo = (struct fat_boot_fsinfo *)fsinfo_bh->b_data;
 		if (!IS_FSINFO(fsinfo)) {
-			printk("FAT: Did not find valid FSINFO signature.\n"
+			printk(KERN_WARNING
+			       "FAT: Did not find valid FSINFO signature.\n"
 			       "     Found signature1 0x%08x signature2 0x%08x"
 			       " (sector = %lu)\n",
 			       CF_LE_L(fsinfo->signature1),
@@ -940,7 +899,7 @@ int fat_fill_super(struct super_block *s
 	sbi->dir_entries =
 		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
-		printk("FAT: bogus directroy-entries per block\n");
+		printk(KERN_ERR "FAT: bogus directroy-entries per block\n");
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -971,7 +930,7 @@ int fat_fill_super(struct super_block *s
 	}
 	if (FAT_FIRST_ENT(sb, media) != first) {
 		if (!silent) {
-			printk("FAT: invalid first entry of FAT "
+			printk(KERN_ERR "FAT: invalid first entry of FAT "
 			       "(0x%x != 0x%x)\n",
 			       FAT_FIRST_ENT(sb, media), first);
 		}
@@ -979,22 +938,13 @@ int fat_fill_super(struct super_block *s
 	}
 
 	error = -EINVAL;
-	if (!strcmp(cvf_format, "none"))
-		i = -1;
-	else
-		i = detect_cvf(sb, cvf_format);
-	if (i >= 0) {
-		if (cvf_formats[i]->mount_cvf(sb, cvf_options))
-			goto out_fail;
-	}
-
 	cp = sbi->options.codepage ? sbi->options.codepage : 437;
 	sprintf(buf, "cp%d", cp);
 	sbi->nls_disk = load_nls(buf);
-	if (! sbi->nls_disk) {
+	if (!sbi->nls_disk) {
 		/* Fail only if explicit charset specified */
 		if (sbi->options.codepage != 0) {
-			printk("FAT: codepage %s not found\n", buf);
+			printk(KERN_ERR "FAT: codepage %s not found\n", buf);
 			goto out_fail;
 		}
 		sbi->options.codepage = 0; /* already 0?? */
@@ -1006,7 +956,8 @@ int fat_fill_super(struct super_block *s
 		if (sbi->options.iocharset != NULL) {
 			sbi->nls_io = load_nls(sbi->options.iocharset);
 			if (!sbi->nls_io) {
-				printk("FAT: IO charset %s not found\n",
+				printk(KERN_ERR
+				       "FAT: IO charset %s not found\n",
 				       sbi->options.iocharset);
 				goto out_fail;
 			}
@@ -1027,13 +978,10 @@ int fat_fill_super(struct super_block *s
 	insert_inode_hash(root_inode);
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root) {
-		printk("FAT: get root inode failed\n");
+		printk(KERN_ERR "FAT: get root inode failed\n");
 		goto out_fail;
 	}
-	if(i >= 0) {
-		sbi->cvf_format = cvf_formats[i];
-		++cvf_format_use_count[i];
-	}
+
 	return 0;
 
 out_invalid:
@@ -1051,12 +999,8 @@ out_fail:
 		unload_nls(sbi->nls_disk);
 	if (sbi->options.iocharset)
 		kfree(sbi->options.iocharset);
-	if (sbi->private_data)
-		kfree(sbi->private_data);
-	sbi->private_data = NULL;
 	sb->s_fs_info = NULL;
 	kfree(sbi);
-
 	return error;
 }
 
@@ -1064,11 +1008,6 @@ int fat_statfs(struct super_block *sb,st
 {
 	int free,nr;
        
-	if (MSDOS_SB(sb)->cvf_format &&
-	    MSDOS_SB(sb)->cvf_format->cvf_statfs)
-		return MSDOS_SB(sb)->cvf_format->cvf_statfs(sb,buf,
-						sizeof(struct statfs));
-	  
 	lock_fat(sb);
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		free = MSDOS_SB(sb)->free_clusters;
@@ -1172,13 +1111,6 @@ static int fat_fill_inode(struct inode *
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
 		inode->i_nlink = fat_subdirs(inode);
-		    /* includes .., compensating for "self" */
-#ifdef DEBUG
-		if (!inode->i_nlink) {
-			printk("directory %lu: i_nlink == 0\n",inode->i_ino);
-			inode->i_nlink = 1;
-		}
-#endif
 	} else { /* not a directory */
 		inode->i_generation |= 1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
@@ -1230,16 +1162,16 @@ retry:
 		return;
 	}
 	lock_kernel();
-	if (!(bh = fat_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
-		printk("dev = %s, ino = %d\n", sb->s_id, i_pos);
-		fat_fs_panic(sb, "msdos_write_inode: unable to read i-node block");
+	if (!(bh = sb_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
+		fat_fs_panic(sb, "unable to read i-node block (ino %lu)",
+			     i_pos);
 		unlock_kernel();
 		return;
 	}
 	spin_lock(&fat_inode_lock);
 	if (i_pos != MSDOS_I(inode)->i_location) {
 		spin_unlock(&fat_inode_lock);
-		fat_brelse(sb, bh);
+		brelse(bh);
 		unlock_kernel();
 		goto retry;
 	}
@@ -1268,8 +1200,8 @@ retry:
 		raw_entry->cdate = CT_LE_W(raw_entry->cdate);
 	}
 	spin_unlock(&fat_inode_lock);
-	fat_mark_buffer_dirty(sb, bh);
-	fat_brelse(sb, bh);
+	mark_buffer_dirty(bh);
+	brelse(bh);
 	unlock_kernel();
 }
 
--- fat-2.5.44/fs/fat/misc.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/misc.c	2002-10-24 00:14:05.000000000 +0900
@@ -10,13 +10,6 @@
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
 
-#if 0
-#  define PRINTK(x)	printk x
-#else
-#  define PRINTK(x)
-#endif
-#define Printk(x)	printk x
-
 /*
  * fat_fs_panic reports a severe file system problem and sets the file system
  * read-only. The file system can be made writable again by remounting it.
@@ -37,10 +30,10 @@ void fat_fs_panic(struct super_block *s,
 	if (not_ro)
 		s->s_flags |= MS_RDONLY;
 
-	printk("FAT: Filesystem panic (dev %s)\n"
+	printk(KERN_ERR "FAT: Filesystem panic (dev %s)\n"
 	       "    %s\n", s->s_id, panic_msg);
 	if (not_ro)
-		printk("    File system has been set read-only\n");
+		printk(KERN_ERR "    File system has been set read-only\n");
 }
 
 void lock_fat(struct super_block *sb)
@@ -65,25 +58,25 @@ void fat_clusters_flush(struct super_blo
 	if (MSDOS_SB(sb)->free_clusters == -1)
 		return;
 
-	bh = fat_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
+	bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
 	if (bh == NULL) {
-		printk("FAT bread failed in fat_clusters_flush\n");
+		printk(KERN_ERR "FAT bread failed in fat_clusters_flush\n");
 		return;
 	}
 
 	fsinfo = (struct fat_boot_fsinfo *)bh->b_data;
 	/* Sanity check */
 	if (!IS_FSINFO(fsinfo)) {
-		printk("FAT: Did not find valid FSINFO signature.\n"
+		printk(KERN_ERR "FAT: Did not find valid FSINFO signature.\n"
 		       "     Found signature1 0x%08x signature2 0x%08x"
 		       " (sector = %lu)\n",
 		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
 		       MSDOS_SB(sb)->fsinfo_sector);
 	} else {
 		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
-		fat_mark_buffer_dirty(sb, bh);
+		mark_buffer_dirty(bh);
 	}
-	fat_brelse(sb, bh);
+	brelse(bh);
 }
 
 /*
@@ -167,7 +160,7 @@ int fat_add_cluster(struct inode *inode)
 		mark_inode_dirty(inode);
 	}
 	if (file_cluster != (inode->i_blocks >> (cluster_bits - 9))) {
-		printk ("file_cluster badly computed!!! %d <> %ld\n",
+		printk (KERN_ERR "file_cluster badly computed!!! %d <> %ld\n",
 			file_cluster, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
@@ -195,27 +188,19 @@ struct buffer_head *fat_extend_dir(struc
 	
 	sector = MSDOS_SB(sb)->data_start + (nr - 2) * cluster_size;
 	last_sector = sector + cluster_size;
-	if (MSDOS_SB(sb)->cvf_format
-	    && MSDOS_SB(sb)->cvf_format->zero_out_cluster) {
-		res = ERR_PTR(-EIO);
-		MSDOS_SB(sb)->cvf_format->zero_out_cluster(inode, nr);
-	} else {
-		for ( ; sector < last_sector; sector++) {
-			if (!(bh = fat_getblk(sb, sector)))
-				printk("FAT: fat_getblk() failed\n");
-			else {
-				memset(bh->b_data, 0, sb->s_blocksize);
-				fat_set_uptodate(sb, bh, 1);
-				fat_mark_buffer_dirty(sb, bh);
-				if (!res)
-					res = bh;
-				else
-					fat_brelse(sb, bh);
-			}
+	for ( ; sector < last_sector; sector++) {
+		if ((bh = sb_getblk(sb, sector))) {
+			memset(bh->b_data, 0, sb->s_blocksize);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			if (!res)
+				res = bh;
+			else
+				brelse(bh);
 		}
-		if (res == NULL)
-			res = ERR_PTR(-EIO);
 	}
+	if (res == NULL)
+		res = ERR_PTR(-EIO);
 	if (inode->i_size & (sb->s_blocksize - 1)) {
 		fat_fs_panic(sb, "Odd directory size");
 		inode->i_size = (inode->i_size + sb->s_blocksize)
@@ -309,7 +294,7 @@ int fat__get_entry(struct inode *dir, lo
 next:
 	offset = *pos;
 	if (*bh)
-		fat_brelse(sb, *bh);
+		brelse(*bh);
 
 	*bh = NULL;
 	iblock = *pos >> sb->s_blocksize_bits;
@@ -317,9 +302,10 @@ next:
 	if (sector <= 0)
 		return -1;	/* beyond EOF or error */
 
-	*bh = fat_bread(sb, sector);
+	*bh = sb_bread(sb, sector);
 	if (*bh == NULL) {
-		printk("FAT: Directory bread(block %d) failed\n", sector);
+		printk(KERN_ERR "FAT: Directory bread(block %d) failed\n",
+		       sector);
 		/* skip this block */
 		*pos = (iblock + 1) << sb->s_blocksize_bits;
 		goto next;
@@ -392,7 +378,7 @@ static int raw_scan_sector(struct super_
 	struct msdos_dir_entry *data;
 	int entry,start,done;
 
-	if (!(bh = fat_bread(sb,sector)))
+	if (!(bh = sb_bread(sb,sector)))
 		return -EIO;
 	data = (struct msdos_dir_entry *) bh->b_data;
 	for (entry = 0; entry < MSDOS_SB(sb)->dir_per_block; entry++) {
@@ -414,7 +400,7 @@ static int raw_scan_sector(struct super_
 				start |= (CF_LE_W(data[entry].starthi) << 16);
 			}
 			if (!res_bh)
-				fat_brelse(sb, bh);
+				brelse(bh);
 			else {
 				*res_bh = bh;
 				*res_de = &data[entry];
@@ -422,7 +408,7 @@ static int raw_scan_sector(struct super_
 			return start;
 		}
 	}
-	fat_brelse(sb, bh);
+	brelse(bh);
 	return -ENOENT;
 }
 
--- fat-2.5.44/fs/msdos/namei.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/msdos/namei.c	2002-10-24 00:14:05.000000000 +0900
@@ -7,17 +7,13 @@
  */
 
 #include <linux/module.h>
-
 #include <linux/time.h>
 #include <linux/buffer_head.h>
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
-#define MSDOS_DEBUG 0
-#define PRINTK(x)
 
 /* MS-DOS "device special files" */
-
 static const char *reserved_names[] = {
     "CON     ","PRN     ","NUL     ","AUX     ",
     "LPT1    ","LPT2    ","LPT3    ","LPT4    ",
@@ -26,7 +22,6 @@ static const char *reserved_names[] = {
 };
 
 /* Characters that are undesirable in an MS-DOS file name */
-  
 static char bad_chars[] = "*?<>|\"";
 static char bad_if_strict_pc[] = "+=,; ";
 static char bad_if_strict_atari[] = " "; /* GEMDOS is less restrictive */
@@ -206,8 +201,6 @@ struct dentry *msdos_lookup(struct inode
 	struct buffer_head *bh = NULL;
 	int ino,res;
 	
-	PRINTK (("msdos_lookup\n"));
-
 	dentry->d_op = &msdos_dentry_operations;
 
 	lock_kernel();
@@ -227,8 +220,7 @@ add:
 	if (dentry)
 		dentry->d_op = &msdos_dentry_operations;
 out:
-	if (bh)
-		fat_brelse(sb, bh);
+	brelse(bh);
 	unlock_kernel();
 	if (!res)
 		return dentry;
@@ -242,11 +234,12 @@ static int msdos_add_entry(struct inode 
 			   int *ino,
 			   int is_dir, int is_hid)
 {
-	struct super_block *sb = dir->i_sb;
 	int res;
 
-	if ((res = fat_add_entries(dir, 1, bh, de, ino))<0)
+	res = fat_add_entries(dir, 1, bh, de, ino);
+	if (res < 0)
 		return res;
+
 	/*
 	 * XXX all times should be set by caller upon successful completion.
 	 */
@@ -260,7 +253,7 @@ static int msdos_add_entry(struct inode 
 	(*de)->starthi = 0;
 	fat_date_unix2dos(dir->i_mtime,&(*de)->time,&(*de)->date);
 	(*de)->size = 0;
-	fat_mark_buffer_dirty(sb, *bh);
+	mark_buffer_dirty(*bh);
 	return 0;
 }
 
@@ -288,7 +281,7 @@ int msdos_create(struct inode *dir,struc
 	is_hid = (dentry->d_name.name[0]=='.') && (msdos_name[0]!='.');
 	/* Have to do it due to foo vs. .foo conflicts */
 	if (fat_scan(dir,msdos_name,&bh,&de,&ino) >= 0) {
-		fat_brelse(sb, bh);
+		brelse(bh);
 		unlock_kernel();
 		return -EINVAL;
  	}
@@ -299,7 +292,7 @@ int msdos_create(struct inode *dir,struc
 		return res;
 	}
 	inode = fat_build_inode(dir->i_sb, de, ino, &res);
-	fat_brelse(sb, bh);
+	brelse(bh);
 	if (!inode) {
 		unlock_kernel();
 		return res;
@@ -314,7 +307,6 @@ int msdos_create(struct inode *dir,struc
 /***** Remove a directory */
 int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
 	int res,ino;
 	struct buffer_head *bh;
@@ -335,7 +327,7 @@ int msdos_rmdir(struct inode *dir, struc
 		goto rmdir_done;
 
 	de->name[0] = DELETED_FLAG;
-	fat_mark_buffer_dirty(sb, bh);
+	mark_buffer_dirty(bh);
 	fat_detach(inode);
 	inode->i_nlink = 0;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -345,7 +337,7 @@ int msdos_rmdir(struct inode *dir, struc
 	res = 0;
 
 rmdir_done:
-	fat_brelse(sb, bh);
+	brelse(bh);
 	unlock_kernel();
 	return res;
 }
@@ -378,7 +370,7 @@ int msdos_mkdir(struct inode *dir,struct
 		goto out_unlock;
 	inode = fat_build_inode(dir->i_sb, de, ino, &res);
 	if (!inode) {
-		fat_brelse(sb, bh);
+		brelse(bh);
 		goto out_unlock;
 	}
 	res = 0;
@@ -390,7 +382,7 @@ int msdos_mkdir(struct inode *dir,struct
 	if (res)
 		goto mkdir_error;
 
-	fat_brelse(sb, bh);
+	brelse(bh);
 	d_instantiate(dentry, inode);
 	res = 0;
 
@@ -406,14 +398,14 @@ mkdir_error:
 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);
 	de->name[0] = DELETED_FLAG;
-	fat_mark_buffer_dirty(sb, bh);
-	fat_brelse(sb, bh);
+	mark_buffer_dirty(bh);
+	brelse(bh);
 	fat_detach(inode);
 	iput(inode);
 	goto out_unlock;
 
 out_exist:
-	fat_brelse(sb, bh);
+	brelse(bh);
 	res = -EINVAL;
 	goto out_unlock;
 }
@@ -421,7 +413,6 @@ out_exist:
 /***** Unlink a file */
 int msdos_unlink( struct inode *dir, struct dentry *dentry)
 {
-	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
 	int res,ino;
 	struct buffer_head *bh;
@@ -435,9 +426,9 @@ int msdos_unlink( struct inode *dir, str
 		goto unlink_done;
 
 	de->name[0] = DELETED_FLAG;
-	fat_mark_buffer_dirty(sb, bh);
+	mark_buffer_dirty(bh);
 	fat_detach(inode);
-	fat_brelse(sb, bh);
+	brelse(bh);
 	inode->i_nlink = 0;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -454,7 +445,6 @@ static int do_msdos_rename(struct inode 
     struct buffer_head *old_bh,
     struct msdos_dir_entry *old_de, int old_ino, int is_hid)
 {
-	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *new_bh=NULL,*dotdot_bh=NULL;
 	struct msdos_dir_entry *new_de,*dotdot_de;
 	struct inode *old_inode,*new_inode;
@@ -497,7 +487,7 @@ static int do_msdos_rename(struct inode 
 	if (new_inode)
 		fat_detach(new_inode);
 	old_de->name[0] = DELETED_FLAG;
-	fat_mark_buffer_dirty(sb, old_bh);
+	mark_buffer_dirty(old_bh);
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_ino);
 	if (is_hid)
@@ -516,7 +506,7 @@ static int do_msdos_rename(struct inode 
 	if (dotdot_bh) {
 		dotdot_de->start = CT_LE_W(MSDOS_I(new_dir)->i_logstart);
 		dotdot_de->starthi = CT_LE_W((MSDOS_I(new_dir)->i_logstart) >> 16);
-		fat_mark_buffer_dirty(sb, dotdot_bh);
+		mark_buffer_dirty(dotdot_bh);
 		old_dir->i_nlink--;
 		mark_inode_dirty(old_dir);
 		if (new_inode) {
@@ -529,8 +519,8 @@ static int do_msdos_rename(struct inode 
 	}
 	error = 0;
 out:
-	fat_brelse(sb, new_bh);
-	fat_brelse(sb, dotdot_bh);
+	brelse(new_bh);
+	brelse(dotdot_bh);
 	return error;
 
 degenerate_case:
@@ -552,7 +542,6 @@ degenerate_case:
 int msdos_rename(struct inode *old_dir,struct dentry *old_dentry,
 		 struct inode *new_dir,struct dentry *new_dentry)
 {
-	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh;
 	struct msdos_dir_entry *old_de;
 	int old_ino, error;
@@ -580,7 +569,7 @@ int msdos_rename(struct inode *old_dir,s
 	error = do_msdos_rename(old_dir, old_msdos_name, old_dentry,
 				new_dir, new_msdos_name, new_dentry,
 				old_bh, old_de, (ino_t)old_ino, is_hid);
-	fat_brelse(sb, old_bh);
+	brelse(old_bh);
 
 rename_done:
 	unlock_kernel();
--- fat-2.5.44/fs/vfat/namei.c~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/vfat/namei.c	2002-10-24 00:14:05.000000000 +0900
@@ -319,9 +319,9 @@ static int vfat_find_form(struct inode *
 	struct buffer_head *bh = NULL;
 	int ino,res;
 
-	res=fat_scan(dir,name,&bh,&de,&ino);
-	fat_brelse(dir->i_sb, bh);
-	if (res<0)
+	res = fat_scan(dir,name,&bh,&de,&ino);
+	brelse(bh);
+	if (res < 0)
 		return -ENOENT;
 	return 0;
 }
@@ -793,7 +793,6 @@ static int vfat_add_entry(struct inode *
 			  int is_dir, struct vfat_slot_info *sinfo_out,
 			  struct buffer_head **bh, struct msdos_dir_entry **de)
 {
-	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_slot *dir_slots;
 	loff_t offset;
 	int slots, slot;
@@ -821,7 +820,7 @@ static int vfat_add_entry(struct inode *
 		res = offset;
 		goto cleanup;
 	}
-	fat_brelse(sb, dummy_bh);
+	brelse(dummy_bh);
 
 	/* Now create the new entry */
 	*bh = NULL;
@@ -831,7 +830,7 @@ static int vfat_add_entry(struct inode *
 			goto cleanup;
 		}
 		memcpy(*de, dir_slots + slot, sizeof(struct msdos_dir_slot));
-		fat_mark_buffer_dirty(sb, *bh);
+		mark_buffer_dirty(*bh);
 	}
 
 	res = 0;
@@ -843,7 +842,7 @@ static int vfat_add_entry(struct inode *
 	(*de)->ctime = (*de)->time;
 	(*de)->adate = (*de)->cdate = (*de)->date;
 
-	fat_mark_buffer_dirty(sb, *bh);
+	mark_buffer_dirty(*bh);
 
 	/* slots can't be less than 1 */
 	sinfo_out->long_slots = slots - 1;
@@ -902,7 +901,7 @@ struct dentry *vfat_lookup(struct inode 
 		goto error;
 	}
 	inode = fat_build_inode(dir->i_sb, de, sinfo.ino, &res);
-	fat_brelse(dir->i_sb, bh);
+	brelse(bh);
 	if (res) {
 		unlock_kernel();
 		return ERR_PTR(res);
@@ -946,7 +945,7 @@ int vfat_create(struct inode *dir,struct
 		return res;
 	}
 	inode = fat_build_inode(sb, de, sinfo.ino, &res);
-	fat_brelse(sb, bh);
+	brelse(bh);
 	if (!inode) {
 		unlock_kernel();
 		return res;
@@ -964,7 +963,6 @@ int vfat_create(struct inode *dir,struct
 static void vfat_remove_entry(struct inode *dir,struct vfat_slot_info *sinfo,
      struct buffer_head *bh, struct msdos_dir_entry *de)
 {
-	struct super_block *sb = dir->i_sb;
 	loff_t offset;
 	int i,ino;
 
@@ -974,7 +972,7 @@ static void vfat_remove_entry(struct ino
 	dir->i_version++;
 	mark_inode_dirty(dir);
 	de->name[0] = DELETED_FLAG;
-	fat_mark_buffer_dirty(sb, bh);
+	mark_buffer_dirty(bh);
 	/* remove the longname */
 	offset = sinfo->longname_offset; de = NULL;
 	for (i = sinfo->long_slots; i > 0; --i) {
@@ -982,9 +980,9 @@ static void vfat_remove_entry(struct ino
 			continue;
 		de->name[0] = DELETED_FLAG;
 		de->attr = ATTR_NONE;
-		fat_mark_buffer_dirty(sb, bh);
+		mark_buffer_dirty(bh);
 	}
-	if (bh) fat_brelse(sb, bh);
+	brelse(bh);
 }
 
 int vfat_rmdir(struct inode *dir,struct dentry* dentry)
@@ -1075,7 +1073,7 @@ int vfat_mkdir(struct inode *dir,struct 
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_instantiate(dentry,inode);
 out:
-	fat_brelse(sb, bh);
+	brelse(bh);
 	unlock_kernel();
 	return res;
 
@@ -1096,7 +1094,6 @@ mkdir_failed:
 int vfat_rename(struct inode *old_dir,struct dentry *old_dentry,
 		struct inode *new_dir,struct dentry *new_dentry)
 {
-	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
 	struct msdos_dir_entry *old_de,*new_de,*dotdot_de;
 	int dotdot_ino;
@@ -1160,7 +1157,7 @@ int vfat_rename(struct inode *old_dir,st
 		int start = MSDOS_I(new_dir)->i_logstart;
 		dotdot_de->start = CT_LE_W(start);
 		dotdot_de->starthi = CT_LE_W(start>>16);
-		fat_mark_buffer_dirty(sb, dotdot_bh);
+		mark_buffer_dirty(dotdot_bh);
 		old_dir->i_nlink--;
 		if (new_inode) {
 			new_inode->i_nlink--;
@@ -1171,9 +1168,9 @@ int vfat_rename(struct inode *old_dir,st
 	}
 
 rename_done:
-	fat_brelse(sb, dotdot_bh);
-	fat_brelse(sb, old_bh);
-	fat_brelse(sb, new_bh);
+	brelse(dotdot_bh);
+	brelse(old_bh);
+	brelse(new_bh);
 	unlock_kernel();
 	return res;
 
--- fat-2.5.44/include/linux/fat_cvf.h
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,47 +0,0 @@
-#ifndef _FAT_CVF
-#define _FAT_CVF
-
-#define CVF_USE_READPAGE  0x0001
-
-struct cvf_format
-{ int cvf_version;
-  char* cvf_version_text;
-  unsigned long flags;
-  int (*detect_cvf) (struct super_block*sb);
-  int (*mount_cvf) (struct super_block*sb,char*options);
-  int (*unmount_cvf) (struct super_block*sb);
-  struct buffer_head* (*cvf_bread) (struct super_block*sb,int block);
-  struct buffer_head* (*cvf_getblk) (struct super_block*sb,int block);
-  void (*cvf_brelse) (struct super_block *sb,struct buffer_head *bh);
-  void (*cvf_mark_buffer_dirty) (struct super_block *sb,
-                              struct buffer_head *bh);
-  void (*cvf_set_uptodate) (struct super_block *sb,
-                         struct buffer_head *bh,
-                         int val);
-  int (*cvf_is_uptodate) (struct super_block *sb,struct buffer_head *bh);
-  void (*cvf_ll_rw_block) (struct super_block *sb,
-                        int opr,
-                        int nbreq,
-                        struct buffer_head *bh[32]);
-  int (*fat_access) (struct super_block *sb,int nr,int new_value);
-  int (*cvf_statfs) (struct super_block *sb,struct statfs *buf, int bufsiz);
-  int (*cvf_bmap) (struct inode *inode,int block);
-  ssize_t (*cvf_file_read) ( struct file *, char *, size_t, loff_t *);
-  ssize_t (*cvf_file_write) ( struct file *, const char *, size_t, loff_t *);
-  int (*cvf_mmap) (struct file *, struct vm_area_struct *);
-  int (*cvf_readpage) (struct inode *, struct page *);
-  int (*cvf_writepage) (struct inode *, struct page *);
-  int (*cvf_dir_ioctl) (struct inode * inode, struct file * filp,
-                        unsigned int cmd, unsigned long arg);
-  void (*zero_out_cluster) (struct inode*, int clusternr);
-};
-
-int register_cvf_format(struct cvf_format*cvf_format);
-int unregister_cvf_format(struct cvf_format*cvf_format);
-void dec_cvf_format_use_count_by_version(int version);
-int detect_cvf(struct super_block*sb,char*force);
-
-extern struct cvf_format *cvf_formats[];
-extern int cvf_format_use_count[];
-
-#endif
--- fat-2.5.44/include/linux/msdos_fs.h~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/include/linux/msdos_fs.h	2002-10-24 00:14:05.000000000 +0900
@@ -235,17 +235,6 @@ static inline void fatwchar_to16(__u8 *d
 #endif
 }
 
-/* fat/buffer.c */
-extern struct buffer_head *fat_bread(struct super_block *sb, int block);
-extern struct buffer_head *fat_getblk(struct super_block *sb, int block);
-extern void fat_brelse(struct super_block *sb, struct buffer_head *bh);
-extern void fat_mark_buffer_dirty(struct super_block *sb, struct buffer_head *bh);
-extern void fat_set_uptodate(struct super_block *sb, struct buffer_head *bh,
-			     int val);
-extern int fat_is_uptodate(struct super_block *sb, struct buffer_head *bh);
-extern void fat_ll_rw_block(struct super_block *sb, int opr, int nbreq,
-			    struct buffer_head *bh[32]);
-
 /* fat/cache.c */
 extern int fat_access(struct super_block *sb, int nr, int new_value);
 extern int __fat_access(struct super_block *sb, int nr, int new_value);
@@ -273,12 +262,8 @@ extern int fat_new_dir(struct inode *dir
 /* fat/file.c */
 extern struct file_operations fat_file_operations;
 extern struct inode_operations fat_file_inode_operations;
-extern ssize_t fat_file_read(struct file *filp, char *buf, size_t count,
-			     loff_t *ppos);
 extern int fat_get_block(struct inode *inode, sector_t iblock,
 			 struct buffer_head *bh_result, int create);
-extern ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
-			      loff_t *ppos);
 extern void fat_truncate(struct inode *inode);
 
 /* fat/inode.c */
--- fat-2.5.44/include/linux/msdos_fs_sb.h~fat_kill_cvf	2002-10-24 00:14:05.000000000 +0900
+++ fat-2.5.44-hirofumi/include/linux/msdos_fs_sb.h	2002-10-24 00:14:05.000000000 +0900
@@ -1,6 +1,5 @@
 #ifndef _MSDOS_FS_SB
 #define _MSDOS_FS_SB
-#include<linux/fat_cvf.h>
 
 /*
  * MS-DOS file system in-core superblock data
@@ -45,9 +44,7 @@ struct msdos_sb_info {
 	struct fat_mount_options options;
 	struct nls_table *nls_disk;  /* Codepage used on disk */
 	struct nls_table *nls_io;    /* Charset used for input and display */
-	struct cvf_format* cvf_format;
 	void *dir_ops;		     /* Opaque; default directory operations */
-	void *private_data;
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
 };
