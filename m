Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTAAVdJ>; Wed, 1 Jan 2003 16:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTAAVdJ>; Wed, 1 Jan 2003 16:33:09 -0500
Received: from verein.lst.de ([212.34.181.86]:15885 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S264686AbTAAVdF>;
	Wed, 1 Jan 2003 16:33:05 -0500
Date: Wed, 1 Jan 2003 22:41:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs creptomancy
Message-ID: <20030101224130.A5668@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As already state in the thread about Adam's devfs reimplementation there
is much devfs functionality that is unused or only used by the
arch/ia64/sn/ code that currently doesn't even compile in 2.5 and that
will get it's own filesystem that fits the needs better when SGI moves
to 2.6.

(the first hunk is the only exception to the above rule, but it's just
a debug printk :))

 drivers/media/radio/miropcm20-rds.c |    3
 fs/devfs/base.c                     |  141 ------------------------------------ include/linux/devfs_fs_kernel.h     |   44 -----------
 3 files changed, 2 insertions(+), 186 deletions(-)


--- 1.5/drivers/media/radio/miropcm20-rds.c	Tue Dec  3 13:14:37 2002
+++ edited/drivers/media/radio/miropcm20-rds.c	Wed Jan  1 19:31:32 2003
@@ -119,9 +119,6 @@
 		return -EINVAL;
 
 	printk("miropcm20-rds: userinterface driver loaded.\n");
-#if DEBUG
-	printk("v4l-name: %s\n", devfs_get_name(pcm20_radio.devfs_handle, 0));
-#endif
 	return 0;
 }
 
--- 1.67/fs/devfs/base.c	Mon Dec 30 12:07:24 2002
+++ edited/fs/devfs/base.c	Wed Jan  1 20:24:48 2003
@@ -1764,29 +1764,6 @@
 }   /*  End Function devfs_mk_dir  */
 
 
-/**
- *	devfs_get_handle - Find the handle of a devfs entry.
- *	@dir: The handle to the parent devfs directory entry. If this is %NULL the
- *		name is relative to the root of the devfs.
- *	@name: The name of the entry.
- *	@traverse_symlinks: If %TRUE then symlink entries in the devfs namespace are
- *		traversed. Symlinks pointing out of the devfs namespace will cause a
- *		failure. Symlink traversal consumes stack space.
- *
- *	Returns a handle which may later be used in a call to
- *	devfs_unregister(), devfs_get_flags(), or devfs_set_flags(). A
- *	subsequent devfs_put() is required to decrement the refcount.
- *	On failure %NULL is returned.
- */
-
-devfs_handle_t devfs_get_handle (devfs_handle_t dir, const char *name,
-				 int traverse_symlinks)
-{
-    if (!name || !name[0])
-	return NULL;
-    return _devfs_find_entry (dir, name, traverse_symlinks);
-}   /*  End Function devfs_get_handle  */
-
 void devfs_remove(const char *fmt, ...)
 {
 	char buf[64];
@@ -1795,27 +1772,13 @@
 
 	va_start(args, fmt);
 	n = vsnprintf(buf, 64, fmt, args);
-	if (n < 64) {
-		devfs_handle_t de = devfs_get_handle(NULL, buf, 0);
+	if (n < 64 && buf[0]) {
+		devfs_handle_t de = _devfs_find_entry(NULL, buf, 0);
 		devfs_unregister(de);
 		devfs_put(de);
 	}
 }
 
-/**
- *	devfs_get_handle_from_inode - Get the devfs handle for a VFS inode.
- *	@inode: The VFS inode.
- *
- *	Returns the devfs handle on success, else %NULL.
- */
-
-devfs_handle_t devfs_get_handle_from_inode (struct inode *inode)
-{
-    if (!inode || !inode->i_sb) return NULL;
-    if (inode->i_sb->s_magic != DEVFS_SUPER_MAGIC) return NULL;
-    return get_devfs_entry_from_vfs_inode (inode);
-}   /*  End Function devfs_get_handle_from_inode  */
-
 
 /**
  *	devfs_generate_path - Generate a pathname for an entry, relative to the devfs root.
@@ -1906,97 +1869,6 @@
 
 
 /**
- *	devfs_get_info - Get the info pointer written to private_data of @de upon open.
- *	@de: The handle to the device entry.
- *
- *	Returns the info pointer.
- */
-void *devfs_get_info (devfs_handle_t de)
-{
-    if (de == NULL) return NULL;
-    VERIFY_ENTRY (de);
-    return de->info;
-}   /*  End Function devfs_get_info  */
-
-
-/**
- *	devfs_set_info - Set the info pointer written to private_data upon open.
- *	@de: The handle to the device entry.
- *	@info: pointer to the data
- *
- *	Returns 0 on success, else a negative error code.
- */
-int devfs_set_info (devfs_handle_t de, void *info)
-{
-    if (de == NULL) return -EINVAL;
-    VERIFY_ENTRY (de);
-    de->info = info;
-    return 0;
-}   /*  End Function devfs_set_info  */
-
-
-/**
- *	devfs_get_parent - Get the parent device entry.
- *	@de: The handle to the device entry.
- *
- *	Returns the parent device entry if it exists, else %NULL.
- */
-devfs_handle_t devfs_get_parent (devfs_handle_t de)
-{
-    if (de == NULL) return NULL;
-    VERIFY_ENTRY (de);
-    return de->parent;
-}   /*  End Function devfs_get_parent  */
-
-
-/**
- *	devfs_get_first_child - Get the first leaf node in a directory.
- *	@de: The handle to the device entry.
- *
- *	Returns the leaf node device entry if it exists, else %NULL.
- */
-
-devfs_handle_t devfs_get_first_child (devfs_handle_t de)
-{
-    if (de == NULL) return NULL;
-    VERIFY_ENTRY (de);
-    if ( !S_ISDIR (de->mode) ) return NULL;
-    return de->u.dir.first;
-}   /*  End Function devfs_get_first_child  */
-
-
-/**
- *	devfs_get_next_sibling - Get the next sibling leaf node. for a device entry.
- *	@de: The handle to the device entry.
- *
- *	Returns the leaf node device entry if it exists, else %NULL.
- */
-
-devfs_handle_t devfs_get_next_sibling (devfs_handle_t de)
-{
-    if (de == NULL) return NULL;
-    VERIFY_ENTRY (de);
-    return de->next;
-}   /*  End Function devfs_get_next_sibling  */
-
-/**
- *	devfs_get_name - Get the name for a device entry in its parent directory.
- *	@de: The handle to the device entry.
- *	@namelen: The length of the name is written here. This may be %NULL.
- *
- *	Returns the name on success, else %NULL.
- */
-
-const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen)
-{
-    if (de == NULL) return NULL;
-    VERIFY_ENTRY (de);
-    if (namelen != NULL) *namelen = de->namelen;
-    return de->name;
-}   /*  End Function devfs_get_name  */
-
-
-/**
  *	devfs_only - returns true if "devfs=only" is a boot option
  *
  *	If "devfs=only" this function will return 1, otherwise 0 is returned.
@@ -2079,17 +1951,8 @@
 EXPORT_SYMBOL(devfs_unregister);
 EXPORT_SYMBOL(devfs_mk_symlink);
 EXPORT_SYMBOL(devfs_mk_dir);
-EXPORT_SYMBOL(devfs_get_handle);
 EXPORT_SYMBOL(devfs_remove);
-EXPORT_SYMBOL(devfs_get_handle_from_inode);
 EXPORT_SYMBOL(devfs_generate_path);
-EXPORT_SYMBOL(devfs_set_file_size);
-EXPORT_SYMBOL(devfs_get_info);
-EXPORT_SYMBOL(devfs_set_info);
-EXPORT_SYMBOL(devfs_get_parent);
-EXPORT_SYMBOL(devfs_get_first_child);
-EXPORT_SYMBOL(devfs_get_next_sibling);
-EXPORT_SYMBOL(devfs_get_name);
 EXPORT_SYMBOL(devfs_only);
 
 
--- 1.26/include/linux/devfs_fs_kernel.h	Tue Dec  3 13:26:32 2002
+++ edited/include/linux/devfs_fs_kernel.h	Wed Jan  1 20:18:35 2003
@@ -53,17 +53,8 @@
 			     devfs_handle_t *handle, void *info);
 extern devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name,
 				    void *info);
-extern devfs_handle_t devfs_get_handle (devfs_handle_t dir, const char *name,
-					int traverse_symlinks);
-extern devfs_handle_t devfs_get_handle_from_inode (struct inode *inode);
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_set_file_size (devfs_handle_t de, unsigned long size);
-extern void *devfs_get_info (devfs_handle_t de);
-extern int devfs_set_info (devfs_handle_t de, void *info);
-extern devfs_handle_t devfs_get_parent (devfs_handle_t de);
-extern devfs_handle_t devfs_get_first_child (devfs_handle_t de);
-extern devfs_handle_t devfs_get_next_sibling (devfs_handle_t de);
-extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
 extern int devfs_only (void);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
@@ -115,19 +106,9 @@
 {
     return NULL;
 }
-static inline devfs_handle_t devfs_get_handle (devfs_handle_t dir,
-					       const char *name,
-					       int traverse_symlinks)
-{
-    return NULL;
-}
 static inline void devfs_remove(const char *fmt, ...)
 {
 }
-static inline devfs_handle_t devfs_get_handle_from_inode (struct inode *inode)
-{
-    return NULL;
-}
 static inline int devfs_generate_path (devfs_handle_t de, char *path,
 				       int buflen)
 {
@@ -136,31 +117,6 @@
 static inline int devfs_set_file_size (devfs_handle_t de, unsigned long size)
 {
     return -ENOSYS;
-}
-static inline void *devfs_get_info (devfs_handle_t de)
-{
-    return NULL;
-}
-static inline int devfs_set_info (devfs_handle_t de, void *info)
-{
-    return 0;
-}
-static inline devfs_handle_t devfs_get_parent (devfs_handle_t de)
-{
-    return NULL;
-}
-static inline devfs_handle_t devfs_get_first_child (devfs_handle_t de)
-{
-    return NULL;
-}
-static inline devfs_handle_t devfs_get_next_sibling (devfs_handle_t de)
-{
-    return NULL;
-}
-static inline const char *devfs_get_name (devfs_handle_t de,
-					  unsigned int *namelen)
-{
-    return NULL;
 }
 static inline int devfs_only (void)
 {
