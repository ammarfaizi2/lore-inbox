Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317383AbSFHGuy>; Sat, 8 Jun 2002 02:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317384AbSFHGux>; Sat, 8 Jun 2002 02:50:53 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:30473 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317383AbSFHGur>; Sat, 8 Jun 2002 02:50:47 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove the fat_cvf
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 08 Jun 2002 15:50:00 +0900
Message-ID: <87d6v2p8mf.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the fat_cvf stuff. It seems the fat_cvf wasn't used
for a long time.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.20/Documentation/filesystems/fat_cvf.txt fat-remove_cvf/Documentation/filesystems/fat_cvf.txt
--- linux-2.5.20/Documentation/filesystems/fat_cvf.txt	Wed Jun  5 21:46:08 2002
+++ fat-remove_cvf/Documentation/filesystems/fat_cvf.txt	Thu Jan  1 09:00:00 1970
@@ -1,210 +0,0 @@
-This is the main documentation for the CVF-FAT filesystem extension.  18Nov1998
-
-
-Table of Contents:
-
-1. The idea of CVF-FAT
-2. Restrictions
-3. Mount options
-4. Description of the CVF-FAT interface
-5. CVF Modules
-
-------------------------------------------------------------------------------
-
-
-1. The idea of CVF-FAT
-------------------------------------------------------------------------------
-
-CVF-FAT is a FAT filesystem extension that provides a generic interface for
-Compressed Volume Files in FAT partitions. Popular CVF software, for
-example, are Microsoft's Doublespace/Drivespace and Stac's Stacker.
-Using the CVF-FAT interface, it is possible to load a module that handles
-all the low-level disk access that has to do with on-the-fly compression
-and decompression. Any other part of FAT filesystem access is still handled
-by the FAT, MSDOS or VFAT or even UMSDOS driver.
-
-CVF access works by redirecting certain low-level routines from the FAT
-driver to a loadable, CVF-format specific module. This module must fake
-a normal FAT filesystem to the FAT driver while doing all the extra stuff
-like compression and decompression silently.
-
-
-2. Restrictions
-------------------------------------------------------------------------------
-
-- BMAP problems
-
-  CVF filesystems cannot do bmap. It's impossible in principle. Thus
-  all actions that require bmap do not work (swapping, writable mmapping).
-  Read-only mmapping works because the FAT driver has a hack for this
-  situation :) Well, writable mmapping should now work using the readpage
-  interface function which has been hacked into the FAT driver just for 
-  CVF-FAT :)
-  
-- attention, DOSEmu users 
-
-  You may have to unmount all CVF partitions before running DOSEmu depending 
-  on your configuration. If DOSEmu is configured to use wholedisk or 
-  partition access (this is often the case to let DOSEmu access 
-  compressed partitions) there's a risk of destroying your compressed 
-  partitions or crashing your system because of confused drivers.
-  
-  Note that it is always safe to redirect the compressed partitions with 
-  lredir or emufs.sys. Refer to the DOSEmu documentation for details.
-
-
-3. Mount options
-------------------------------------------------------------------------------
-
-The CVF-FAT extension currently adds the following options to the FAT
-driver's standard options:
-
-  cvf_format=xxx
-    Forces the driver to use the CVF module "xxx" instead of auto-detection.
-    Without this option, the CVF-FAT interface asks all currently loaded
-    CVF modules whether they recognize the CVF. Therefore, this option is
-    only necessary if the CVF format is not recognized correctly
-    because of bugs or incompatibilities in the CVF modules. (It skips
-    the detect_cvf call.) "xxx" may be the text "none" (without the quotes)
-    to inhibit using any of the loaded CVF modules, just in case a CVF
-    module insists on mounting plain FAT filesystems by misunderstanding.
-    "xxx" may also be the text "autoload", which has a special meaning for
-    a module loader, but does not skip auto-detection.
-
-    If the kernel supports kmod, the cvf_format=xxx option also controls
-    on-demand CVF module loading. Without this option, nothing is loaded
-    on demand. With cvf_format=xxx, a module "xxx" is requested automatically
-    before mounting the compressed filesystem (unless "xxx" is "none"). In 
-    case there is a difference between the CVF format name and the module 
-    name, setup aliases in your modules configuration. If the string "xxx" 
-    is "autoload", a non-existent module "cvf_autoload" is requested which 
-    can be used together with a special modules configuration (alias and 
-    pre-install statements) in order to load more than one CVF module, let 
-    them detect automatically which kind of CVF is to be mounted, and only 
-    keep the "right" module in memory. For examples please refer to the 
-    dmsdos documentation (ftp and http addresses see below).
-
-  cvf_options=yyy
-    Option string passed to the CVF module. I.e. only the "yyy" is passed
-    (without the quotes). The documentation for each CVF module should 
-    explain it since it is interpreted only by the CVF module. Note that 
-    the string must not contain a comma (",") - this would lead to 
-    misinterpretation by the FAT driver, which would recognize the text 
-    after a comma as a FAT driver option and might get confused or print 
-    strange error messages. The documentation for the CVF module should 
-    offer a different separation symbol, for example the dot "." or the
-    plus sign "+", which is only valid inside the string "yyy".
-
-
-4. Description of the CVF-FAT interface
-------------------------------------------------------------------------------
-
-Assuming you want to write your own CVF module, you need to write a lot of
-interface functions. Most of them are covered in the kernel documentation
-you can find on the net, and thus won't be described here. They have been
-marked with "[...]" :-) Take a look at include/linux/fat_cvf.h.
-
-struct cvf_format
-{ int cvf_version;
-  char* cvf_version_text;
-  unsigned long int flags;
-  int (*detect_cvf) (struct super_block*sb);
-  int (*mount_cvf) (struct super_block*sb,char*options);
-  int (*unmount_cvf) (struct super_block*sb);
-  [...]
-  void (*zero_out_cluster) (struct inode*, int clusternr);
-}
-
-This structure defines the capabilities of a CVF module. It must be filled
-out completely by a CVF module. Consider it as a kind of form that is used
-to introduce the module to the FAT/CVF-FAT driver.
-
-It contains...
-  - cvf_version:
-      A version id which must be unique. Choose one.
-  - cvf_version_text:
-      A human readable version string that should be one short word 
-      describing the CVF format the module implements. This text is used
-      for the cvf_format option. This name must also be unique.
-  - flags:
-      Bit coded flags, currently only used for a readpage/mmap hack that 
-      provides both mmap and readpage functionality. If CVF_USE_READPAGE
-      is set, mmap is set to generic_file_mmap and readpage is caught
-      and redirected to the cvf_readpage function. If it is not set,
-      readpage is set to generic_readpage and mmap is caught and redirected
-      to cvf_mmap. (If you want writable mmap use the readpage interface.)
-  - detect_cvf:
-      A function that is called to decide whether the filesystem is a CVF of
-      the type the module supports. The detect_cvf function must return 0
-      for "NO, I DON'T KNOW THIS GARBAGE" or anything >0 for "YES, THIS IS
-      THE KIND OF CVF I SUPPORT". The function must maintain the module
-      usage counters for safety, i.e. do MOD_INC_USE_COUNT at the beginning
-      and MOD_DEC_USE_COUNT at the end. The function *must not* assume that
-      successful recognition would lead to a call of the mount_cvf function
-      later. 
-  - mount_cvf:
-      A function that sets up some values or initializes something additional
-      to what has to be done when a CVF is mounted. This is called at the
-      end of fat_read_super and must return 0 on success. Definitely, this
-      function must increment the module usage counter by MOD_INC_USE_COUNT.
-      This mount_cvf function is also responsible for interpreting a CVF
-      module specific option string (the "yyy" from the FAT mount option
-      "cvf_options=yyy") which cannot contain a comma (use for example the
-      dot "." as option separator symbol).
-  - unmount_cvf:
-      A function that is called when the filesystem is unmounted. Most likely
-      it only frees up some memory and calls MOD_DEC_USE_COUNT. The return
-      value might be ignored (it currently is ignored).
-  - [...]:
-      All other interface functions are "caught" FAT driver functions, i.e.
-      are executed by the FAT driver *instead* of the original FAT driver
-      functions. NULL means use the original FAT driver functions instead.
-      If you really want "no action", write a function that does nothing and 
-      hang it in instead.
-  - zero_out_cluster:
-      The zero_out_cluster function is called when the fat driver wants to
-      zero out a (new) cluster. This is important for directories (mkdir).
-      If it is NULL, the FAT driver defaults to overwriting the whole
-      cluster with zeros. Note that clusternr is absolute, not relative
-      to the provided inode.
-
-Notes:
-  1. The cvf_bmap function should be ignored. It really should never
-     get called from somewhere. I recommend redirecting it to a panic
-     or fatal error message so bugs show up immediately.
-  2. The cvf_writepage function is ignored. This is because the fat
-     driver doesn't support it. This might change in future. I recommend
-     setting it to NULL (i.e use default).
-
-int register_cvf_format(struct cvf_format*cvf_format);
-  If you have just set up a variable containing the above structure,
-  call this function to introduce your CVF format to the FAT/CVF-FAT
-  driver. This is usually done in init_module. Be sure to check the
-  return value. Zero means success, everything else causes a kernel
-  message printed in the syslog describing the error that occurred.
-  Typical errors are:
-    - a module with the same version id is already registered or 
-    - too many CVF formats. Hack fs/fat/cvf.c if you need more.
-
-int unregister_cvf_format(struct cvf_format*cvf_format);
-  This is usually called in cleanup_module. Return value =0 means
-  success. An error only occurs if you try to unregister a CVF format
-  that has not been previously registered. The code uses the version id
-  to distinguish the modules, so be sure to keep it unique.
-
-5. CVF Modules
-------------------------------------------------------------------------------
-
-Refer to the dmsdos module (the successor of the dmsdos filesystem) for a
-sample implementation.  It can currently be found at
-
-  ftp://fb9nt.uni-duisburg.de/pub/linux/dmsdos/dmsdos-x.y.z.tgz
-  ftp://sunsite.unc.edu/pub/Linux/system/Filesystems/dosfs/dmsdos-x.y.z.tgz
-  ftp://ftp.uni-stuttgart.de/pub/systems/linux/local/system/dmsdos-x.y.z.tgz
-
-(where x.y.z is to be replaced with the actual version number). Full
-documentation about dmsdos is included in the dmsdos package, but can also
-be found at
-
-  http://fb9nt.uni-duisburg.de/mitarbeiter/gockel/software/dmsdos/index.html
-  http://www.yk.rim.or.jp/~takafumi/dmsdos/index.html (in Japanese).
diff -urN linux-2.5.20/fs/fat/Makefile fat-remove_cvf/fs/fat/Makefile
--- linux-2.5.20/fs/fat/Makefile	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/Makefile	Wed Jun  5 00:03:17 2002
@@ -6,6 +6,6 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := buffer.o cache.o dir.o file.o inode.o misc.o cvf.o fatfs_syms.o
+fat-objs := buffer.o cache.o dir.o file.o inode.o misc.o fatfs_syms.o
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.20/fs/fat/buffer.c fat-remove_cvf/fs/fat/buffer.c
--- linux-2.5.20/fs/fat/buffer.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/buffer.c	Wed Jun  5 00:02:59 2002
@@ -7,91 +7,37 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/buffer_head.h>
 
 struct buffer_head *fat_bread(struct super_block *sb, int block)
 {
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
 	return sb_bread(sb, block);
 }
-
-struct buffer_head *default_fat_getblk(struct super_block *sb, int block)
+struct buffer_head *fat_getblk(struct super_block *sb, int block)
 {
 	return sb_getblk(sb, block);
 }
-
-void default_fat_brelse(struct super_block *sb, struct buffer_head *bh)
+void fat_brelse (struct super_block *sb, struct buffer_head *bh)
 {
 	brelse (bh);
 }
-
-void default_fat_mark_buffer_dirty (
-	struct super_block *sb,
-	struct buffer_head *bh)
+void fat_mark_buffer_dirty (struct super_block *sb, struct buffer_head *bh)
 {
 	mark_buffer_dirty (bh);
 }
-
-void default_fat_set_uptodate (
-	struct super_block *sb,
-	struct buffer_head *bh,
-	int val)
+void fat_set_uptodate (struct super_block *sb, struct buffer_head *bh, int val)
 {
 	if (val)
 		set_buffer_uptodate(bh);
 	else
 		clear_buffer_uptodate(bh);
 }
-
-int default_fat_is_uptodate (struct super_block *sb, struct buffer_head *bh)
+int fat_is_uptodate(struct super_block *sb, struct buffer_head *bh)
 {
 	return buffer_uptodate(bh);
 }
-
-void default_fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32])
+void fat_ll_rw_block (struct super_block *sb, int opr, int nbreq,
+		      struct buffer_head *bh[32])
 {
-	ll_rw_block(opr,nbreq,bh);
+	ll_rw_block(opr, nbreq, bh);
 }
diff -urN linux-2.5.20/fs/fat/cache.c fat-remove_cvf/fs/fat/cache.c
--- linux-2.5.20/fs/fat/cache.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/cache.c	Tue Jun  4 23:57:32 2002
@@ -10,7 +10,6 @@
 
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/buffer_head.h>
 
 #if 0
@@ -22,19 +21,6 @@
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
@@ -127,7 +113,11 @@
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
 
@@ -317,7 +307,7 @@
 	return nr;
 }
 
-int default_fat_bmap(struct inode *inode,int sector)
+int fat_bmap(struct inode *inode, int sector)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
diff -urN linux-2.5.20/fs/fat/cvf.c fat-remove_cvf/fs/fat/cvf.c
--- linux-2.5.20/fs/fat/cvf.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/cvf.c	Thu Jan  1 09:00:00 1970
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
diff -urN linux-2.5.20/fs/fat/dir.c fat-remove_cvf/fs/fat/dir.c
--- linux-2.5.20/fs/fat/dir.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/dir.c	Wed Jun  5 00:03:08 2002
@@ -672,11 +672,6 @@
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
 
diff -urN linux-2.5.20/fs/fat/fatfs_syms.c fat-remove_cvf/fs/fat/fatfs_syms.c
--- linux-2.5.20/fs/fat/fatfs_syms.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/fatfs_syms.c	Wed Jun  5 00:03:28 2002
@@ -10,7 +10,6 @@
 
 #include <linux/mm.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 
 EXPORT_SYMBOL(fat_new_dir);
 EXPORT_SYMBOL(fat_get_block);
@@ -30,8 +29,6 @@
 EXPORT_SYMBOL(fat_scan);
 EXPORT_SYMBOL(fat_statfs);
 EXPORT_SYMBOL(fat_write_inode);
-EXPORT_SYMBOL(register_cvf_format);
-EXPORT_SYMBOL(unregister_cvf_format);
 EXPORT_SYMBOL(fat_dir_ioctl);
 EXPORT_SYMBOL(fat_add_entries);
 EXPORT_SYMBOL(fat_dir_empty);
diff -urN linux-2.5.20/fs/fat/file.c fat-remove_cvf/fs/fat/file.c
--- linux-2.5.20/fs/fat/file.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/file.c	Wed Jun  5 00:05:20 2002
@@ -8,16 +8,18 @@
 
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
 #define PRINTK(x)
 #define Printk(x) printk x
 
+static ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
+			      loff_t *ppos);
+
 struct file_operations fat_file_operations = {
 	llseek:		generic_file_llseek,
-	read:		fat_file_read,
+	read:		generic_file_read,
 	write:		fat_file_write,
 	mmap:		generic_file_mmap,
 	fsync:		file_fsync,
@@ -28,18 +30,6 @@
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
 int fat_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
@@ -76,23 +66,8 @@
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
diff -urN linux-2.5.20/fs/fat/inode.c fat-remove_cvf/fs/fat/inode.c
--- linux-2.5.20/fs/fat/inode.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/inode.c	Wed Jun  5 00:15:53 2002
@@ -15,15 +15,12 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/msdos_fs.h>
-#include <linux/fat_cvf.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 
 //#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern struct cvf_format default_cvf;
-
 /* #define FAT_PARANOIA 1 */
 #define DEBUG_LEVEL 0
 #ifdef FAT_DEBUG
@@ -174,10 +171,6 @@
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	if (sbi->cvf_format->cvf_version) {
-		dec_cvf_format_use_count_by_version(sbi->cvf_format->cvf_version);
-		sbi->cvf_format->unmount_cvf(sb);
-	}
 	fat_clusters_flush(sb);
 	fat_cache_inval_dev(sb);
 	if (sbi->nls_disk) {
@@ -203,8 +196,7 @@
 
 
 static int parse_options(char *options, int *debug,
-			 struct fat_mount_options *opts,
-			 char *cvf_format, char *cvf_options)
+			 struct fat_mount_options *opts)
 {
 	char *this_char,*value,save,*savep;
 	char *p;
@@ -340,16 +332,6 @@
 					ret = 0;
 			}
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
 
 		if (this_char != options) *(this_char-1) = ',';
 		if (value) *savep = save;
@@ -643,9 +625,6 @@
 	unsigned char media;
 	long error = -EIO;
 	char buf[50];
-	int i;
-	char cvf_format[21];
-	char cvf_options[101];
 
 	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -653,19 +632,13 @@
 	sb->u.generic_sbp = sbi;
 	memset(sbi, 0, sizeof(struct msdos_sb_info));
 
-	cvf_format[0] = '\0';
-	cvf_options[0] = '\0';
-	sbi->private_data = NULL;
-
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
 	sb->s_export_op = &fat_export_ops;
 	sbi->options.isvfat = isvfat;
 	sbi->dir_ops = fs_dir_inode_ops;
-	sbi->cvf_format = &default_cvf;
 
-	if (!parse_options((char *)data, &debug, &sbi->options,
-			   cvf_format, cvf_options))
+	if (!parse_options((char *)data, &debug, &sbi->options))
 		goto out_fail;
 
 	fat_cache_init();
@@ -848,15 +821,6 @@
 		goto out_invalid;
 	}
 
-	if (!strcmp(cvf_format, "none"))
-		i = -1;
-	else
-		i = detect_cvf(sb, cvf_format);
-	if (i >= 0) {
-		if (cvf_formats[i]->mount_cvf(sb, cvf_options))
-			goto out_invalid;
-	}
-
 	cp = sbi->options.codepage ? sbi->options.codepage : 437;
 	sprintf(buf, "cp%d", cp);
 	sbi->nls_disk = load_nls(buf);
@@ -904,10 +868,7 @@
 		printk("FAT: get root inode failed\n");
 		goto out_fail;
 	}
-	if(i >= 0) {
-		sbi->cvf_format = cvf_formats[i];
-		++cvf_format_use_count[i];
-	}
+
 	return 0;
 
 out_invalid:
@@ -922,9 +883,6 @@
 		unload_nls(sbi->nls_disk);
 	if (sbi->options.iocharset)
 		kfree(sbi->options.iocharset);
-	if (sbi->private_data)
-		kfree(sbi->private_data);
-	sbi->private_data = NULL;
 	sb->u.generic_sbp = NULL;
 	kfree(sbi);
 
@@ -935,11 +893,6 @@
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
diff -urN linux-2.5.20/fs/fat/misc.c fat-remove_cvf/fs/fat/misc.c
--- linux-2.5.20/fs/fat/misc.c	Wed Jun  5 21:47:28 2002
+++ fat-remove_cvf/fs/fat/misc.c	Wed Jun  5 00:04:08 2002
@@ -233,27 +233,21 @@
 	
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
+		if (!(bh = fat_getblk(sb, sector)))
+			printk("FAT: fat_getblk() failed\n");
+		else {
+			memset(bh->b_data, 0, sb->s_blocksize);
+			fat_set_uptodate(sb, bh, 1);
+			fat_mark_buffer_dirty(sb, bh);
+			if (!res)
+				res = bh;
+			else
+				fat_brelse(sb, bh);
 		}
-		if (res == NULL)
-			res = ERR_PTR(-EIO);
 	}
+	if (res == NULL)
+		res = ERR_PTR(-EIO);
 	if (inode->i_size & (sb->s_blocksize - 1)) {
 		fat_fs_panic(sb, "Odd directory size");
 		inode->i_size = (inode->i_size + sb->s_blocksize)
diff -urN linux-2.5.20/include/linux/fat_cvf.h fat-remove_cvf/include/linux/fat_cvf.h
--- linux-2.5.20/include/linux/fat_cvf.h	Wed Jun  5 21:47:52 2002
+++ fat-remove_cvf/include/linux/fat_cvf.h	Thu Jan  1 09:00:00 1970
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
diff -urN linux-2.5.20/include/linux/msdos_fs.h fat-remove_cvf/include/linux/msdos_fs.h
--- linux-2.5.20/include/linux/msdos_fs.h	Wed Jun  5 21:47:53 2002
+++ fat-remove_cvf/include/linux/msdos_fs.h	Wed Jun  5 00:32:14 2002
@@ -273,12 +273,8 @@
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
diff -urN linux-2.5.20/include/linux/msdos_fs_sb.h fat-remove_cvf/include/linux/msdos_fs_sb.h
--- linux-2.5.20/include/linux/msdos_fs_sb.h	Wed Jun  5 21:47:53 2002
+++ fat-remove_cvf/include/linux/msdos_fs_sb.h	Tue Jun  4 23:56:15 2002
@@ -46,9 +46,7 @@
 	struct fat_mount_options options;
 	struct nls_table *nls_disk;  /* Codepage used on disk */
 	struct nls_table *nls_io;    /* Charset used for input and display */
-	struct cvf_format* cvf_format;
 	void *dir_ops;		     /* Opaque; default directory operations */
-	void *private_data;
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
 };
