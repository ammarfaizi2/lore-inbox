Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUBWTbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUBWTbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:31:39 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:22533 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262007AbUBWTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:31:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Mon, 23 Feb 2004 22:28:07 +0300
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH][2.6.3-mm2] unregister path on devfs_remove
Message-ID: <20040223192807.GA4359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patch implements cleanup of device path on devfs_remove. It does not
use extra counters as was suggested once - rather it simply removes all
empty directories. Manually created directories (and connecting paths)
are preserved and cleaned up on rmdir/unlink.

The creation/removing of path is not atomic; it will be addressed later.
It apparently requires replacing per-directory locks with global one;
using extra counters does not actually helps here.

This patch will cause devfs_remove on directories emit warning in most
cases. Removing connecting directories makes no sense with this change
so if it is agreed upon I send patch that removes all
devfs_remove("directory") from kernel. It was never done consistently
anyway. I would actually make
devfs_mk_dir noop except for two places - /dev/pts and /dev/shm.

regards

-andrey

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.3-mm2-devfs_path_removal-1.patch"

--- ../tmp/linux-2.6.3-mm2/fs/devfs/base.c	2004-02-22 20:25:14.000000000 +0300
+++ linux-2.6.3-mm2/fs/devfs/base.c	2004-02-22 23:44:24.000000000 +0300
@@ -783,7 +783,6 @@ struct devfs_entry
 #ifdef CONFIG_DEVFS_DEBUG
     unsigned int magic_number;
 #endif
-    void *info;
     atomic_t refcount;           /*  When this drops to zero, it's unused    */
     union 
     {
@@ -799,7 +798,7 @@ struct devfs_entry
     struct devfs_inode inode;
     umode_t mode;
     unsigned short namelen;      /*  I think 64k+ filenames are a way off... */
-    unsigned char vfs:1;/*  Whether the VFS may delete the entry   */
+    unsigned char vfs:1;	 /*  Entry was created by VFS                */
     char name[1];                /*  This is just a dummy: the allocated array
 				     is bigger. This is NULL-terminated      */
 };
@@ -904,12 +903,13 @@ static void devfs_put (devfs_handle_t de
 {
     if (!de) return;
     VERIFY_ENTRY (de);
-    if (de->info == POISON_PTR) OOPS ("(%p): poisoned pointer\n", de);
+    if (de->parent == POISON_PTR) OOPS ("(%p): poisoned pointer\n", de);
     if ( !atomic_dec_and_test (&de->refcount) ) return;
     if (de == root_entry) OOPS ("(%p): root entry being freed\n", de);
     DPRINTK (DEBUG_FREE, "(%s): de: %p, parent: %p \"%s\"\n",
 	     de->name, de, de->parent,
 	     de->parent ? de->parent->name : "no parent");
+    devfs_put(de->parent);
     if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
@@ -919,7 +919,7 @@ static void devfs_put (devfs_handle_t de
     if ( S_ISLNK (de->mode) ) stat_num_bytes -= de->u.symlink.length + 1;
     spin_unlock (&stat_lock);
 #endif
-    de->info = POISON_PTR;
+    de->parent = POISON_PTR;
     kfree (de);
 }   /*  End Function devfs_put  */
 
@@ -1032,7 +1032,7 @@ static int _devfs_append_entry (devfs_ha
 	else devfs_put (old);
 	if (old == NULL)
 	{
-	    de->parent = dir;
+	    de->parent = devfs_get(dir);
 	    de->prev = dir->u.dir.last;
 	    /*  Append to the directory's list of children  */
 	    if (dir->u.dir.first == NULL) dir->u.dir.first = de;
@@ -1368,8 +1368,8 @@ static int wait_for_devfsd_finished (str
 
 /**
  *	devfsd_notify_de - Notify the devfsd daemon of a change.
- *	@de: The devfs entry that has changed. This and all parent entries will
- *            have their reference counts incremented if the event was queued.
+ *	@de: The devfs entry that has changed. This will have reference
+ *		count incremented if the event was queued.
  *	@type: The type of change.
  *	@mode: The mode of the entry.
  *	@uid: The user ID.
@@ -1384,7 +1384,6 @@ static int devfsd_notify_de (struct devf
 			     uid_t uid, gid_t gid, struct fs_info *fs_info)
 {
     struct devfsd_buf_entry *entry;
-    struct devfs_entry *curr;
 
     if ( !( fs_info->devfsd_event_mask & (1 << type) ) ) return (FALSE);
     if ( ( entry = kmem_cache_alloc (devfsd_buf_cache, SLAB_KERNEL) ) == NULL )
@@ -1392,8 +1391,7 @@ static int devfsd_notify_de (struct devf
 	atomic_inc (&fs_info->devfsd_overrun_count);
 	return (FALSE);
     }
-    for (curr = de; curr != NULL; curr = curr->parent) devfs_get (curr);
-    entry->de = de;
+    entry->de = devfs_get(de);
     entry->type = type;
     entry->mode = mode;
     entry->uid = uid;
@@ -1518,39 +1516,74 @@ static int _devfs_unhook (struct devfs_e
 
 
 /**
- *	_devfs_unregister - Unregister a device entry from its parent.
+ *	_devfs_unregister - Unregister a device path starting from bottom
  *	@dir: The parent directory.
  *	@de: The entry to unregister.
  *
  *	The caller must have a write lock on the parent directory, which is
  *	unlocked by this function.
+ *
+ *	Caller must devfs_get @de to ensure the path won't disappear
+ *	while we traverse it from bottom up
+ *
+ *	If @dir becomes empty we unregister it too recursively unless
+ *	it has been created by user
+ *
+ *	Returns true if entry was really unhooked, false otherwise.
  */
 
-static void _devfs_unregister (struct devfs_entry *dir, struct devfs_entry *de)
+static int _devfs_unregister (struct devfs_entry *dir, struct devfs_entry *de)
 {
-    int unhooked = _devfs_unhook (de);
+	int unhooked;
+	struct devfs_entry *leaf = de;
+	int followup;
 
-    write_unlock (&dir->u.dir.lock);
-    if (!unhooked) return;
-    devfs_get (dir);
-    devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED);
-    free_dentry (de);
-    devfs_put (dir);
-    if ( !S_ISDIR (de->mode) ) return;
+repeat:
+	followup = 0;
+	unhooked = _devfs_unhook(de);
+	if (dir->u.dir.first == NULL && dir->u.dir.last == NULL &&
+	    !dir->vfs && dir != root_entry && unhooked) {
+		dir->u.dir.no_more_additions = TRUE;
+		followup = 1;
+	}
+	write_unlock(&dir->u.dir.lock);
+
+	if (!unhooked) {
+		if (de != leaf)
+			goto kill_subtree;
+		else
+			return 0;
+	}
+
+	free_dentry(de);
+	devfs_put(de);
+
+	/* remove parent if it became empty */
+	if (followup) {
+		de = dir;
+		dir = de->parent;
+		write_lock(&dir->u.dir.lock);
+		goto repeat;
+	}
+
+kill_subtree:
+    if ( !S_ISDIR (leaf->mode) ) return 1;
     while (TRUE)  /*  Recursively unregister: this is a stack chomper  */
     {
 	struct devfs_entry *child;
 
-	write_lock (&de->u.dir.lock);
-	de->u.dir.no_more_additions = TRUE;
-	child = de->u.dir.first;
+	write_lock (&leaf->u.dir.lock);
+	leaf->u.dir.no_more_additions = TRUE;
+	child = devfs_get(leaf->u.dir.first);
 	VERIFY_ENTRY (child);
-	_devfs_unregister (de, child);
+	_devfs_unregister (leaf, child);
 	if (!child) break;
 	DPRINTK (DEBUG_UNREGISTER, "(%s): child: %p  refcount: %d\n",
 		 child->name, child, atomic_read (&child->refcount) );
 	devfs_put (child);
     }
+
+    return 1;
 }   /*  End Function _devfs_unregister  */
 
 static int devfs_do_symlink (devfs_handle_t dir, const char *name,
@@ -1584,7 +1617,6 @@ static int devfs_do_symlink (devfs_handl
 	kfree (newlink);
 	return -ENOTDIR;
     }
-    de->info = NULL;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
     if ( ( err = _devfs_append_entry (dir, de, NULL) ) != 0 )
@@ -1699,9 +1731,12 @@ void devfs_remove(const char *fmt, ...)
 			return;
 		}
 
-		write_lock(&de->parent->u.dir.lock);
-		_devfs_unregister(de->parent, de);
-		devfs_put(de);
+		/* no way to return an error; should be EPERM */
+		if (!de->vfs) {
+			write_lock(&de->parent->u.dir.lock);
+			if (_devfs_unregister(de->parent, de))
+				devfsd_notify(de, DEVFSD_NOTIFY_UNREGISTERED);
+		}
 		devfs_put(de);
 	}
 }
@@ -2330,7 +2365,6 @@ out:
 
 static int devfs_unlink (struct inode *dir, struct dentry *dentry)
 {
-    int unhooked;
     struct devfs_entry *de;
     struct inode *inode = dentry->d_inode;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
@@ -2340,14 +2374,11 @@ static int devfs_unlink (struct inode *d
     if (de == NULL) return -ENOENT;
     if (!de->vfs) return -EPERM;
     write_lock (&de->parent->u.dir.lock);
-    unhooked = _devfs_unhook (de);
-    write_unlock (&de->parent->u.dir.lock);
-    if (!unhooked) return -ENOENT;
+    if (!_devfs_unregister(de->parent, de))
+	return -ENOENT;
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
 			  inode->i_uid, inode->i_gid, fs_info);
-    free_dentry (de);
-    devfs_put (de);
     return 0;
 }   /*  End Function devfs_unlink  */
 
@@ -2434,14 +2465,11 @@ static int devfs_rmdir (struct inode *di
     if (err) return err;
     /*  Now unhook the directory from its parent  */
     write_lock (&de->parent->u.dir.lock);
-    if ( !_devfs_unhook (de) ) err = -ENOENT;
-    write_unlock (&de->parent->u.dir.lock);
-    if (err) return err;
+    if (!_devfs_unregister(de->parent, de))
+	return -ENOENT;
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
 			  inode->i_uid, inode->i_gid, fs_info);
-    free_dentry (de);
-    devfs_put (de);
     return 0;
 }   /*  End Function devfs_rmdir  */
 
@@ -2653,17 +2681,11 @@ static ssize_t devfsd_read (struct file 
     tlen = rpos - *ppos;
     if (done)
     {
-	devfs_handle_t parent;
-
 	spin_lock (&fs_info->devfsd_buffer_lock);
 	fs_info->devfsd_first_event = entry->next;
 	if (entry->next == NULL) fs_info->devfsd_last_event = NULL;
 	spin_unlock (&fs_info->devfsd_buffer_lock);
-	for (; de != NULL; de = parent)
-	{
-	    parent = de->parent;
-	    devfs_put (de);
-	}
+	devfs_put (de);
 	kmem_cache_free (devfsd_buf_cache, entry);
 	if (ival > 0) atomic_sub (ival, &fs_info->devfsd_overrun_count);
 	*ppos = 0;

--GvXjxJ+pjyke8COw--
