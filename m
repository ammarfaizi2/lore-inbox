Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTDFHRu (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTDFHRu (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:17:50 -0400
Received: from verein.lst.de ([212.34.181.86]:39694 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262865AbTDFHRq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:17:46 -0400
Date: Sun, 6 Apr 2003 09:29:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove DEVFS_FL_*
Message-ID: <20030406092917.A6779@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, all flags are gone from devfs callers, time to remove the gunk
handling it.  devfs_register prototype will change later.


--- 1.80/fs/devfs/base.c	Sat Mar 22 10:38:04 2003
+++ edited/fs/devfs/base.c	Sun Apr  6 07:02:36 2003
@@ -1384,16 +1384,13 @@
 
 static int devfsd_notify_de (struct devfs_entry *de,
 			     unsigned short type, umode_t mode,
-			     uid_t uid, gid_t gid, struct fs_info *fs_info,
-			     int atomic)
+			     uid_t uid, gid_t gid, struct fs_info *fs_info)
 {
     struct devfsd_buf_entry *entry;
     struct devfs_entry *curr;
 
     if ( !( fs_info->devfsd_event_mask & (1 << type) ) ) return (FALSE);
-    if ( ( entry = kmem_cache_alloc (devfsd_buf_cache,
-				     atomic ? SLAB_ATOMIC : SLAB_KERNEL) )
-	 == NULL )
+    if ( ( entry = kmem_cache_alloc (devfsd_buf_cache, SLAB_KERNEL) ) == NULL )
     {
 	atomic_inc (&fs_info->devfsd_overrun_count);
 	return (FALSE);
@@ -1423,12 +1420,11 @@
  *		the event.
  */
 
-static void devfsd_notify (struct devfs_entry *de,unsigned short type,int wait)
+static void devfsd_notify (struct devfs_entry *de,unsigned short type)
 {
-    if (devfsd_notify_de (de, type, de->mode, current->euid,
-			  current->egid, &fs_info, 0) && wait)
-	wait_for_devfsd_finished (&fs_info);
-}   /*  End Function devfsd_notify  */
+	devfsd_notify_de(de, type, de->mode, current->euid,
+			 current->egid, &fs_info, 0);
+} 
 
 
 /**
@@ -1436,7 +1432,7 @@
  *	@dir: The handle to the parent devfs directory entry. If this is %NULL the
  *		new name is relative to the root of the devfs.
  *	@name: The name of the entry.
- *	@flags: A set of bitwise-ORed flags (DEVFS_FL_*).
+ *	@flags: Must be 0
  *	@major: The major number. Not needed for regular files.
  *	@minor: The minor number. Not needed for regular files.
  *	@mode: The default file mode.
@@ -1460,6 +1456,9 @@
     dev_t devnum = 0, dev = MKDEV(major, minor);
     struct devfs_entry *de;
 
+    if (flags)
+	printk(KERN_ERR "%s called with flags != 0, please fix!\n");
+
     if (name == NULL)
     {
 	PRINTK ("(): NULL name pointer\n");
@@ -1501,16 +1500,8 @@
 	return (NULL);
     }
     de->info = info;
-    if (flags & DEVFS_FL_CURRENT_OWNER)
-    {
-	de->inode.uid = current->uid;
-	de->inode.gid = current->gid;
-    }
-    else
-    {
-	de->inode.uid = 0;
-	de->inode.gid = 0;
-    }
+    de->inode.uid = 0;
+    de->inode.gid = 0;
     err = _devfs_append_entry(dir, de, NULL);
     if (err)
     {
@@ -1521,7 +1512,7 @@
     }
     DPRINTK (DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"  pp: %p\n",
 	     name, de, dir, dir->name, dir->parent);
-    devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED, flags & DEVFS_FL_WAIT);
+    devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED);
     devfs_put (dir);
     return de;
 }   /*  End Function devfs_register  */
@@ -1568,7 +1559,7 @@
     write_unlock (&dir->u.dir.lock);
     if (!unhooked) return;
     devfs_get (dir);
-    devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED, 0);
+    devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED);
     free_dentry (de);
     devfs_put (dir);
     if ( !S_ISDIR (de->mode) ) return;
@@ -1673,7 +1664,7 @@
 	err = devfs_do_symlink(NULL, from, to, &de);
 	if (!err) {
 		de->vfs_deletable = TRUE;
-		devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED, 0);
+		devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED);
 	}
 
 	return err;
@@ -1722,7 +1713,7 @@
 	
 	DPRINTK(DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"\n",
 			buf, de, dir, dir->name);
-	devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED, 0);
+	devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED);
 
  out_put:
 	devfs_put(dir);
@@ -1906,7 +1897,7 @@
     buf->u.name = name;
     WRITE_ENTRY_MAGIC (buf, MAGIC_VALUE);
     if ( !devfsd_notify_de (buf, DEVFSD_NOTIFY_LOOKUP, 0,
-			    current->euid, current->egid, fs_info, 0) )
+			    current->euid, current->egid, fs_info) )
 	return -ENOENT;
     /*  Possible success: event has been queued  */
     return 0;
@@ -1949,7 +1940,7 @@
     if ( ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) ) &&
 	 !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_notify_change  */
 
@@ -2376,7 +2367,7 @@
     if (!unhooked) return -ENOENT;
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     free_dentry (de);
     devfs_put (de);
     return 0;
@@ -2410,7 +2401,7 @@
     d_instantiate (dentry, inode);
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_symlink  */
 
@@ -2441,7 +2432,7 @@
     d_instantiate (dentry, inode);
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_mkdir  */
 
@@ -2470,7 +2461,7 @@
     if (err) return err;
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     free_dentry (de);
     devfs_put (de);
     return 0;
@@ -2509,7 +2500,7 @@
     d_instantiate (dentry, inode);
     if ( !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-			  inode->i_uid, inode->i_gid, fs_info, 0);
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_mknod  */
 
--- 1.35/include/linux/devfs_fs_kernel.h	Mon Mar 24 08:59:24 2003
+++ edited/include/linux/devfs_fs_kernel.h	Sun Apr  6 08:00:36 2003
@@ -12,9 +12,7 @@
 #define DEVFS_SUPER_MAGIC                0x1373
 
 #define DEVFS_FL_NONE           0x000 /* This helps to make code more readable
-				       */
-#define DEVFS_FL_WAIT           0x010 /* Wait for devfsd to finish           */
-#define DEVFS_FL_CURRENT_OWNER  0x020 /* Set initial ownership to current    */
+				         no, it doesn't  --hch */
 #define DEVFS_FL_DEFAULT        DEVFS_FL_NONE
 
 
