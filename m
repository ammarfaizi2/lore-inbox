Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281475AbRKMEzd>; Mon, 12 Nov 2001 23:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281483AbRKMEzY>; Mon, 12 Nov 2001 23:55:24 -0500
Received: from mail.cb.monarch.net ([24.244.11.6]:45574 "EHLO
	baca.cb.monarch.net") by vger.kernel.org with ESMTP
	id <S281475AbRKMEzJ>; Mon, 12 Nov 2001 23:55:09 -0500
Date: Mon, 12 Nov 2001 21:52:15 -0700
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        intermezzo-devel@lists.sourceforge.net
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] small intermezzo fixes
Message-ID: <20011112215215.T4281@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus, 

Can you apply the following small fixes against 2.4.14-pre4? 

[They are fixes for a few error conditions which were handled
wrongly.]

Thanks - and thanks for patching us in the tree!

- Peter -


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="izo-2.4.14-pre4.patch"

diff -ur linux/fs/intermezzo.orig/dcache.c linux/fs/intermezzo/dcache.c
--- linux/fs/intermezzo.orig/dcache.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/dcache.c	Mon Nov 12 22:45:42 2001
@@ -52,9 +52,8 @@
 static void presto_d_release(struct dentry *dentry)
 {
         if (!presto_d2d(dentry)) {
-                printk("VERY BAD: dentry: %p\n", dentry);
-                if (dentry->d_inode)
-                        printk("    inode: %ld\n", dentry->d_inode->i_ino);
+                /* This should really only happen in the case of a dentry
+                 * with no inode. */
                 return;
         }
 
@@ -78,14 +77,18 @@
 void presto_set_dd(struct dentry * dentry)
 {
         ENTRY;
+        if (dentry == NULL)
+                BUG();
+
         if (dentry->d_fsdata) {
                 printk("VERY BAD: dentry: %p\n", dentry);
                 if (dentry->d_inode)
                         printk("    inode: %ld\n", dentry->d_inode->i_ino);
+                EXIT;
                 return;
         }
 
-        if (! dentry->d_inode) {
+        if (dentry->d_inode == NULL) {
                 dentry->d_fsdata = kmem_cache_alloc(presto_dentry_slab,
                                                     SLAB_KERNEL);
                 memset(dentry->d_fsdata, 0, sizeof(struct presto_dentry_data));
@@ -125,7 +128,7 @@
         presto_dentry_slab =
                 kmem_cache_create("presto_cache",
                                   sizeof(struct presto_dentry_data), 0,
-                                  SLAB_HWCACHE_ALIGN|SLAB_POISON, NULL,
+                                  SLAB_HWCACHE_ALIGN, NULL,
                                   NULL);
         EXIT;
 }
diff -ur linux/fs/intermezzo.orig/dir.c linux/fs/intermezzo/dir.c
--- linux/fs/intermezzo.orig/dir.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/dir.c	Mon Nov 12 22:37:44 2001
@@ -163,13 +163,20 @@
                 return ERR_PTR(-EPERM);
         }
         inode = iget(dir->i_sb, ino);
-        if (!inode || !inode->i_nlink || is_bad_inode(inode)) {
+        if (!inode || is_bad_inode(inode)) {
                 CDEBUG(D_PIOCTL, "fatal: invalid inode %ld (%s).\n",
                        ino, inode ? inode->i_nlink ? "bad inode" :
                        "no links" : "NULL");
                 error = -ENOENT;
                 EXIT;
                 goto cleanup_iput;
+        } else if (inode->i_nlink == 0) {
+                /* This is quite evil, but we have little choice.  If we were
+                 * to iput() again with i_nlink == 0, delete_inode would get
+                 * called again, which ext3 really Does Not Like. */
+                atomic_dec(&inode->i_count);
+                EXIT;
+                return ERR_PTR(-ENOENT);
         }
 
         /* We need to make sure we have the right inode (by checking the
@@ -185,6 +192,8 @@
         }
 
         d_instantiate(dentry, inode);
+        dentry->d_flags |= DCACHE_NFSD_DISCONNECTED; /* NFS hack */
+
         EXIT;
         return NULL;
 
diff -ur linux/fs/intermezzo.orig/journal.c linux/fs/intermezzo/journal.c
--- linux/fs/intermezzo.orig/journal.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/journal.c	Mon Nov 12 22:37:44 2001
@@ -106,7 +106,8 @@
         lock_kernel();
         
         if (size_check != inode->i_size) { 
-                fs_up(&inode->i_sem); 
+                unlock_kernel();
+                fs_up(&inode->i_sem);
                 EXIT;
                 return -EALREADY; 
         }
diff -ur linux/fs/intermezzo.orig/journal_xfs.c linux/fs/intermezzo/journal_xfs.c
--- linux/fs/intermezzo.orig/journal_xfs.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/journal_xfs.c	Mon Nov 12 22:45:41 2001
@@ -24,7 +24,7 @@
 #include <linux/intermezzo_kml.h>
 #include <linux/intermezzo_journal.h>
 
-#if defined(CONFIG_XFS_FS)
+#if 0
 
 /* XFS has journalling, but these functions do nothing yet... */
 
diff -ur linux/fs/intermezzo.orig/methods.c linux/fs/intermezzo/methods.c
--- linux/fs/intermezzo.orig/methods.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/methods.c	Mon Nov 12 22:45:40 2001
@@ -163,7 +163,8 @@
 
         if ( strlen(cache_type) == strlen("xfs") &&
              memcmp(cache_type, "xfs", strlen("xfs")) == 0 ) {
-#if defined(CONFIG_XFS_FS) || defined (CONFIG_XFS_FS_MODULE)
+#if 0
+                //#if defined(CONFIG_XFS_FS) || defined (CONFIG_XFS_FS_MODULE)
                 ops->o_trops = &presto_xfs_journal_ops;
 #else
                 ops->o_trops = NULL;
diff -ur linux/fs/intermezzo.orig/presto.c linux/fs/intermezzo/presto.c
--- linux/fs/intermezzo.orig/presto.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/presto.c	Mon Nov 12 20:07:24 2001
@@ -1035,6 +1035,7 @@
                 goto put_out;
         }
 
+	error = 0;
         cache = fset->fset_cache;
         cache->cache_flags &= ~CACHE_FSETROOT_SET;
 
diff -ur linux/fs/intermezzo.orig/vfs.c linux/fs/intermezzo/vfs.c
--- linux/fs/intermezzo.orig/vfs.c	Mon Nov 12 18:07:54 2001
+++ linux/fs/intermezzo/vfs.c	Mon Nov 12 20:07:11 2001
@@ -162,6 +162,9 @@
         return 1;
 }
 
+
+/* XXX fixme: this should not fail, all these dentries are in memory
+   when _we_ call this */
 int presto_settime(struct presto_file_set *fset, 
                    struct dentry *dentry, 
                    struct lento_vfs_context *ctx, 
@@ -194,8 +197,7 @@
 
         error = -EPERM;
         iops = filter_c2cdiops(fset->fset_cache->cache_filter); 
-        if (!iops &&
-            !iops->setattr) {
+        if (!iops) { 
                 EXIT;
                 return error;
         }
@@ -203,7 +205,7 @@
         if (iops->setattr != NULL)
                 error = iops->setattr(dentry, &iattr);
         else {
-		error = 0; // we suppose no error, Arthur
+		error = 0;
                 inode_setattr(dentry->d_inode, &iattr);
 	}
         EXIT;
@@ -391,64 +393,6 @@
         return error;
 }
 
-int presto_do_statfs (struct presto_file_set *fset, 
-                      struct statfs * buf)
-{
-        struct super_operations *sops;
-        struct super_block *sb;
-        int result;
-        ENTRY;
-
-        if ( !fset ) {
-                EXIT;
-                return -EINVAL;
-        }
-        if ( !fset->fset_cache ) {
-                EXIT;
-                return -EINVAL;
-        }
-        if ( !fset->fset_cache->cache_filter ) {
-                EXIT;
-                return -EINVAL;
-        }
-
-        sops = filter_c2csops(fset->fset_cache->cache_filter);
-        if ( ! sops ) {
-                EXIT;
-                return -EINVAL;
-        }
-        if ( ! fset->fset_cache->cache_mtde ) {
-                EXIT;
-                return -EINVAL;
-        }
-
-        if ( ! fset->fset_cache->cache_mtde->d_inode ) {
-                EXIT;
-                return -EINVAL;
-        }
-
-        if ( ! fset->fset_cache->cache_mtde->d_inode->i_sb ) {
-                EXIT;
-                return -EINVAL;
-        }
-        sb = fset->fset_cache->cache_mtde->d_inode->i_sb;
-
-        if (sops->statfs) {
-                mm_segment_t old_fs = get_fs();
-                memset(buf, 0, sizeof(struct statfs));
-                set_fs(get_ds());
-                lock_kernel();
-                result = sops->statfs(sb, buf);
-                unlock_kernel();
-                set_fs(old_fs);
-        } else {
-                result = -EINVAL;
-        }
-
-        EXIT;
-        return result;
-}
-
 int presto_do_create(struct presto_file_set *fset, struct dentry *dir,
                      struct dentry *dentry, int mode,
                      struct lento_vfs_context *info)
@@ -1333,14 +1277,14 @@
         dput(dentry);
 
         presto_debug_fail_blkdev(fset, PRESTO_OP_RMDIR | 0x10);
-        if ( do_kml )
+        if ( !error && do_kml )
                 error = presto_journal_rmdir(&rec, fset, dir, &tgt_dir_ver,
                                              &old_dir_ver,
                                              dentry->d_name.len,
                                              dentry->d_name.name);
 
         presto_debug_fail_blkdev(fset, PRESTO_OP_RMDIR | 0x20);
-        if ( do_expect ) 
+        if ( !error && do_expect ) 
                 error = presto_write_last_rcvd(&rec, fset, info);
 
         presto_debug_fail_blkdev(fset, PRESTO_OP_RMDIR | 0x30);
--- linux/include/linux/intermezzo_fs.h.orig	Mon Nov 12 22:49:40 2001
+++ linux/include/linux/intermezzo_fs.h	Mon Nov 12 22:49:00 2001
@@ -362,8 +362,6 @@
 int presto_do_rename(struct presto_file_set *fset, struct dentry *old_dir,
                      struct dentry *old_dentry, struct dentry *new_dir,
                      struct dentry *new_dentry, struct lento_vfs_context *info);
-int presto_do_statfs (struct presto_file_set *fset, 
-                      struct statfs * buf);
 
 int lento_setattr(const char *name, struct iattr *iattr,
                   struct lento_vfs_context *info);

--ZARJHfwaSJQLOEUz--
