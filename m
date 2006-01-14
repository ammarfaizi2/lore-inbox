Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWANO0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWANO0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWANO0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:26:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3540 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750814AbWANO0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:26:24 -0500
Date: Sat, 14 Jan 2006 15:26:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
Subject: [patch 2.6.15-mm4] sem2mutex: JFFS
Message-ID: <20060114142633.GA17012@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/jffs/inode-v23.c |   86 ++++++++++++++++++++++++++--------------------------
 fs/jffs/intrep.c    |    6 +--
 fs/jffs/jffs_fm.c   |    2 -
 fs/jffs/jffs_fm.h   |    5 +--
 4 files changed, 50 insertions(+), 49 deletions(-)

Index: linux/fs/jffs/inode-v23.c
===================================================================
--- linux.orig/fs/jffs/inode-v23.c
+++ linux/fs/jffs/inode-v23.c
@@ -42,7 +42,7 @@
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
 #include <linux/vfs.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
 
@@ -203,7 +203,7 @@ jffs_setattr(struct dentry *dentry, stru
 	fmc = c->fmc;
 
 	D3(printk (KERN_NOTICE "notify_change(): down biglock\n"));
-	down(&fmc->biglock);
+	mutex_lock(&fmc->biglock);
 
 	f = jffs_find_file(c, inode->i_ino);
 
@@ -211,7 +211,7 @@ jffs_setattr(struct dentry *dentry, stru
 		printk("jffs_setattr(): Invalid inode number: %lu\n",
 		       inode->i_ino);
 		D3(printk (KERN_NOTICE "notify_change(): up biglock\n"));
-		up(&fmc->biglock);
+		mutex_unlock(&fmc->biglock);
 		res = -EINVAL;
 		goto out;
 	});
@@ -232,7 +232,7 @@ jffs_setattr(struct dentry *dentry, stru
 	if (!(new_node = jffs_alloc_node())) {
 		D(printk("jffs_setattr(): Allocation failed!\n"));
 		D3(printk (KERN_NOTICE "notify_change(): up biglock\n"));
-		up(&fmc->biglock);
+		mutex_unlock(&fmc->biglock);
 		res = -ENOMEM;
 		goto out;
 	}
@@ -319,7 +319,7 @@ jffs_setattr(struct dentry *dentry, stru
 		D(printk("jffs_notify_change(): The write failed!\n"));
 		jffs_free_node(new_node);
 		D3(printk (KERN_NOTICE "n_c(): up biglock\n"));
-		up(&c->fmc->biglock);
+		mutex_unlock(&c->fmc->biglock);
 		goto out;
 	}
 
@@ -327,7 +327,7 @@ jffs_setattr(struct dentry *dentry, stru
 
 	mark_inode_dirty(inode);
 	D3(printk (KERN_NOTICE "n_c(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 out:
 	unlock_kernel();
 	return res;
@@ -461,7 +461,7 @@ jffs_rename(struct inode *old_dir, struc
 		goto jffs_rename_end;
 	}
 	D3(printk (KERN_NOTICE "rename(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 	/* Create a node and initialize as much as needed.  */
 	result = -ENOMEM;
 	if (!(node = jffs_alloc_node())) {
@@ -555,7 +555,7 @@ jffs_rename(struct inode *old_dir, struc
 
 jffs_rename_end:
 	D3(printk (KERN_NOTICE "rename(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return result;
 } /* jffs_rename()  */
@@ -574,14 +574,14 @@ jffs_readdir(struct file *filp, void *di
 	int ddino;
 	lock_kernel();
 	D3(printk (KERN_NOTICE "readdir(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	D2(printk("jffs_readdir(): inode: 0x%p, filp: 0x%p\n", inode, filp));
 	if (filp->f_pos == 0) {
 		D3(printk("jffs_readdir(): \".\" %lu\n", inode->i_ino));
 		if (filldir(dirent, ".", 1, filp->f_pos, inode->i_ino, DT_DIR) < 0) {
 			D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
-			up(&c->fmc->biglock);
+			mutex_unlock(&c->fmc->biglock);
 			unlock_kernel();
 			return 0;
 		}
@@ -598,7 +598,7 @@ jffs_readdir(struct file *filp, void *di
 		D3(printk("jffs_readdir(): \"..\" %u\n", ddino));
 		if (filldir(dirent, "..", 2, filp->f_pos, ddino, DT_DIR) < 0) {
 			D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
-			up(&c->fmc->biglock);
+			mutex_unlock(&c->fmc->biglock);
 			unlock_kernel();
 			return 0;
 		}
@@ -617,7 +617,7 @@ jffs_readdir(struct file *filp, void *di
 		if (filldir(dirent, f->name, f->nsize,
 			    filp->f_pos , f->ino, DT_UNKNOWN) < 0) {
 		        D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
-			up(&c->fmc->biglock);
+			mutex_unlock(&c->fmc->biglock);
 			unlock_kernel();
 			return 0;
 		}
@@ -627,7 +627,7 @@ jffs_readdir(struct file *filp, void *di
 		} while(f && f->deleted);
 	}
 	D3(printk (KERN_NOTICE "readdir(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return filp->f_pos;
 } /* jffs_readdir()  */
@@ -660,7 +660,7 @@ jffs_lookup(struct inode *dir, struct de
 	});
 
 	D3(printk (KERN_NOTICE "lookup(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	r = -ENAMETOOLONG;
 	if (len > JFFS_MAX_NAME_LEN) {
@@ -683,31 +683,31 @@ jffs_lookup(struct inode *dir, struct de
 
 	if ((len == 1) && (name[0] == '.')) {
 		D3(printk (KERN_NOTICE "lookup(): up biglock\n"));
-		up(&c->fmc->biglock);
+		mutex_unlock(&c->fmc->biglock);
 		if (!(inode = iget(dir->i_sb, d->ino))) {
 			D(printk("jffs_lookup(): . iget() ==> NULL\n"));
 			goto jffs_lookup_end_no_biglock;
 		}
 		D3(printk (KERN_NOTICE "lookup(): down biglock\n"));
-		down(&c->fmc->biglock);
+		mutex_lock(&c->fmc->biglock);
 	} else if ((len == 2) && (name[0] == '.') && (name[1] == '.')) {
 	        D3(printk (KERN_NOTICE "lookup(): up biglock\n"));
-		up(&c->fmc->biglock);
+		mutex_unlock(&c->fmc->biglock);
  		if (!(inode = iget(dir->i_sb, d->pino))) {
 			D(printk("jffs_lookup(): .. iget() ==> NULL\n"));
 			goto jffs_lookup_end_no_biglock;
 		}
 		D3(printk (KERN_NOTICE "lookup(): down biglock\n"));
-		down(&c->fmc->biglock);
+		mutex_lock(&c->fmc->biglock);
 	} else if ((f = jffs_find_child(d, name, len))) {
 	        D3(printk (KERN_NOTICE "lookup(): up biglock\n"));
-		up(&c->fmc->biglock);
+		mutex_unlock(&c->fmc->biglock);
 		if (!(inode = iget(dir->i_sb, f->ino))) {
 			D(printk("jffs_lookup(): iget() ==> NULL\n"));
 			goto jffs_lookup_end_no_biglock;
 		}
 		D3(printk (KERN_NOTICE "lookup(): down biglock\n"));
-		down(&c->fmc->biglock);
+		mutex_lock(&c->fmc->biglock);
 	} else {
 		D3(printk("jffs_lookup(): Couldn't find the file. "
 			  "f = 0x%p, name = \"%s\", d = 0x%p, d->ino = %u\n",
@@ -717,13 +717,13 @@ jffs_lookup(struct inode *dir, struct de
 
 	d_add(dentry, inode);
 	D3(printk (KERN_NOTICE "lookup(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return NULL;
 
 jffs_lookup_end:
 	D3(printk (KERN_NOTICE "lookup(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 
 jffs_lookup_end_no_biglock:
 	unlock_kernel();
@@ -753,7 +753,7 @@ jffs_do_readpage_nolock(struct file *fil
 	ClearPageError(page);
 
 	D3(printk (KERN_NOTICE "readpage(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	read_len = 0;
 	result = 0;
@@ -782,7 +782,7 @@ jffs_do_readpage_nolock(struct file *fil
 	kunmap(page);
 
 	D3(printk (KERN_NOTICE "readpage(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 
 	if (result) {
 	        SetPageError(page);
@@ -839,7 +839,7 @@ jffs_mkdir(struct inode *dir, struct den
 
 	c = dir_f->c;
 	D3(printk (KERN_NOTICE "mkdir(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	dir_mode = S_IFDIR | (mode & (S_IRWXUGO|S_ISVTX)
 			      & ~current->fs->umask);
@@ -906,7 +906,7 @@ jffs_mkdir(struct inode *dir, struct den
 	result = 0;
 jffs_mkdir_end:
 	D3(printk (KERN_NOTICE "mkdir(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return result;
 } /* jffs_mkdir()  */
@@ -921,10 +921,10 @@ jffs_rmdir(struct inode *dir, struct den
 	D3(printk("***jffs_rmdir()\n"));
 	D3(printk (KERN_NOTICE "rmdir(): down biglock\n"));
 	lock_kernel();
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 	ret = jffs_remove(dir, dentry, S_IFDIR);
 	D3(printk (KERN_NOTICE "rmdir(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return ret;
 }
@@ -940,10 +940,10 @@ jffs_unlink(struct inode *dir, struct de
 	lock_kernel();
 	D3(printk("***jffs_unlink()\n"));
 	D3(printk (KERN_NOTICE "unlink(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 	ret = jffs_remove(dir, dentry, 0);
 	D3(printk (KERN_NOTICE "unlink(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return ret;
 }
@@ -1086,7 +1086,7 @@ jffs_mknod(struct inode *dir, struct den
 	c = dir_f->c;
 
 	D3(printk (KERN_NOTICE "mknod(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	/* Create and initialize a new node.  */
 	if (!(node = jffs_alloc_node())) {
@@ -1152,7 +1152,7 @@ jffs_mknod_err:
 
 jffs_mknod_end:
 	D3(printk (KERN_NOTICE "mknod(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return result;
 } /* jffs_mknod()  */
@@ -1203,7 +1203,7 @@ jffs_symlink(struct inode *dir, struct d
 		return -ENOMEM;
 	}
 	D3(printk (KERN_NOTICE "symlink(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	node->data_offset = 0;
 	node->removed_size = 0;
@@ -1253,7 +1253,7 @@ jffs_symlink(struct inode *dir, struct d
 	d_instantiate(dentry, inode);
  jffs_symlink_end:
 	D3(printk (KERN_NOTICE "symlink(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return err;
 } /* jffs_symlink()  */
@@ -1306,7 +1306,7 @@ jffs_create(struct inode *dir, struct de
 		return -ENOMEM;
 	}
 	D3(printk (KERN_NOTICE "create(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	node->data_offset = 0;
 	node->removed_size = 0;
@@ -1359,7 +1359,7 @@ jffs_create(struct inode *dir, struct de
 	d_instantiate(dentry, inode);
  jffs_create_end:
 	D3(printk (KERN_NOTICE "create(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	unlock_kernel();
 	return err;
 } /* jffs_create()  */
@@ -1423,7 +1423,7 @@ jffs_file_write(struct file *filp, const
 	thiscount = min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
 
 	D3(printk (KERN_NOTICE "file_write(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	/* Urgh. POSIX says we can do short writes if we feel like it. 
 	 * In practice, we can't. Nothing will cope. So we loop until
@@ -1511,7 +1511,7 @@ jffs_file_write(struct file *filp, const
 	}
  out:
 	D3(printk (KERN_NOTICE "file_write(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 
 	/* Fix things in the real inode.  */
 	if (pos > inode->i_size) {
@@ -1567,7 +1567,7 @@ jffs_ioctl(struct inode *inode, struct f
 		return -EIO;
 	}
 	D3(printk (KERN_NOTICE "ioctl(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 
 	switch (cmd) {
 	case JFFS_PRINT_HASH:
@@ -1609,7 +1609,7 @@ jffs_ioctl(struct inode *inode, struct f
 		ret = -ENOTTY;
 	}
 	D3(printk (KERN_NOTICE "ioctl(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 	return ret;
 } /* jffs_ioctl()  */
 
@@ -1685,12 +1685,12 @@ jffs_read_inode(struct inode *inode)
 	}
 	c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	D3(printk (KERN_NOTICE "read_inode(): down biglock\n"));
-	down(&c->fmc->biglock);
+	mutex_lock(&c->fmc->biglock);
 	if (!(f = jffs_find_file(c, inode->i_ino))) {
 		D(printk("jffs_read_inode(): No such inode (%lu).\n",
 			 inode->i_ino));
 		D3(printk (KERN_NOTICE "read_inode(): up biglock\n"));
-		up(&c->fmc->biglock);
+		mutex_unlock(&c->fmc->biglock);
 		return;
 	}
 	inode->u.generic_ip = (void *)f;
@@ -1732,7 +1732,7 @@ jffs_read_inode(struct inode *inode)
 	}
 
 	D3(printk (KERN_NOTICE "read_inode(): up biglock\n"));
-	up(&c->fmc->biglock);
+	mutex_unlock(&c->fmc->biglock);
 }
 
 
Index: linux/fs/jffs/intrep.c
===================================================================
--- linux.orig/fs/jffs/intrep.c
+++ linux/fs/jffs/intrep.c
@@ -62,7 +62,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/pagemap.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 #include <asm/byteorder.h>
 #include <linux/smp_lock.h>
 #include <linux/time.h>
@@ -3416,7 +3416,7 @@ jffs_garbage_collect_thread(void *ptr)
 		D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): collecting.\n"));
 
 		D3(printk (KERN_NOTICE "g_c_thread(): down biglock\n"));
-		down(&fmc->biglock);
+		mutex_lock(&fmc->biglock);
 		
 		D1(printk("***jffs_garbage_collect_thread(): round #%u, "
 			  "fmc->dirty_size = %u\n", i++, fmc->dirty_size));
@@ -3447,6 +3447,6 @@ jffs_garbage_collect_thread(void *ptr)
 		
 	gc_end:
 		D3(printk (KERN_NOTICE "g_c_thread(): up biglock\n"));
-		up(&fmc->biglock);
+		mutex_unlock(&fmc->biglock);
 	} /* for (;;) */
 } /* jffs_garbage_collect_thread() */
Index: linux/fs/jffs/jffs_fm.c
===================================================================
--- linux.orig/fs/jffs/jffs_fm.c
+++ linux/fs/jffs/jffs_fm.c
@@ -139,7 +139,7 @@ jffs_build_begin(struct jffs_control *c,
 	fmc->tail = NULL;
 	fmc->head_extra = NULL;
 	fmc->tail_extra = NULL;
-	init_MUTEX(&fmc->biglock);
+	mutex_init(&fmc->biglock);
 	return fmc;
 }
 
Index: linux/fs/jffs/jffs_fm.h
===================================================================
--- linux.orig/fs/jffs/jffs_fm.h
+++ linux/fs/jffs/jffs_fm.h
@@ -20,10 +20,11 @@
 #ifndef __LINUX_JFFS_FM_H__
 #define __LINUX_JFFS_FM_H__
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/jffs.h>
 #include <linux/mtd/mtd.h>
-#include <linux/config.h>
+#include <linux/mutex.h>
 
 /* The alignment between two nodes in the flash memory.  */
 #define JFFS_ALIGN_SIZE 4
@@ -97,7 +98,7 @@ struct jffs_fmcontrol
 	struct jffs_fm *tail;
 	struct jffs_fm *head_extra;
 	struct jffs_fm *tail_extra;
-	struct semaphore biglock;
+	struct mutex biglock;
 };
 
 /* Notice the two members head_extra and tail_extra in the jffs_control
