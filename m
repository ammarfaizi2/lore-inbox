Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUADQze (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUADQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:55:34 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:8461 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265764AbUADQzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:55:23 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH]: Fw: [Bugme-new] [Bug 1242] New: devfs oops with SMP kernel (not in UP mode)
Date: Sun, 4 Jan 2004 19:49:23 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Pavel Roskin <proski@gnu.org>,
       kpfleming@cox.net
References: <20030915212755.5017acc7.akpm@osdl.org> <200401041932.40960.arvidjaar@mail.ru>
In-Reply-To: <200401041932.40960.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TQE+/JDyc9OroKE"
Message-Id: <200401041949.23878.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TQE+/JDyc9OroKE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 04 January 2004 19:32, Andrey Borzenkov wrote:
>
> The attached patch

really attached

--Boundary-00=_TQE+/JDyc9OroKE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-devfs-d_revalidate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-devfs-d_revalidate.patch"

--- linux-2.6.0/fs/devfs/base.c.devfs_revalidate	2003-12-18 05:58:16.000000000 +0300
+++ linux-2.6.0/fs/devfs/base.c	2004-01-04 14:04:22.000000000 +0300
@@ -2185,17 +2185,9 @@ static void devfs_d_iput (struct dentry 
 }   /*  End Function devfs_d_iput  */
 
 static int devfs_d_delete (struct dentry *dentry);
-
-static struct dentry_operations devfs_dops =
-{
-    .d_delete     = devfs_d_delete,
-    .d_release    = devfs_d_release,
-    .d_iput       = devfs_d_iput,
-};
-
 static int devfs_d_revalidate_wait (struct dentry *dentry, struct nameidata *);
 
-static struct dentry_operations devfs_wait_dops =
+static struct dentry_operations devfs_dops =
 {
     .d_delete     = devfs_d_delete,
     .d_release    = devfs_d_release,
@@ -2212,8 +2204,8 @@ static int devfs_d_delete (struct dentry
 {
     struct inode *inode = dentry->d_inode;
 
-    if (dentry->d_op == &devfs_wait_dops) dentry->d_op = &devfs_dops;
     /*  Unhash dentry if negative (has no inode)  */
+    /* FIXME should we check for d_fsdata? */
     if (inode == NULL)
     {
 	DPRINTK (DEBUG_D_DELETE, "(%p): dropping negative dentry\n", dentry);
@@ -2230,6 +2222,11 @@ struct devfs_lookup_struct
 
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
+/*
+ * This relies on the fact that d_revalidate is called under parent i_sem
+ * providing mutual exclusion with devfs_lookup and protection for
+ * dentry->d_fsdata
+ */
 static int devfs_d_revalidate_wait (struct dentry *dentry, struct nameidata *nd)
 {
     struct inode *dir = dentry->d_parent->d_inode;
@@ -2238,6 +2235,10 @@ static int devfs_d_revalidate_wait (stru
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
 
+    /* Ordinary case - nothing to revalidate */
+    if (lookup_info == NULL) return 1;  /*  Early termination  */
+
+    /* Called from devfsd action - cannot block. */
     if ( is_devfsd_or_child (fs_info) )
     {
 	devfs_handle_t de = lookup_info->de;
@@ -2266,25 +2267,22 @@ static int devfs_d_revalidate_wait (stru
 	d_instantiate (dentry, inode);
 	return 1;
     }
-    if (lookup_info == NULL) return 1;  /*  Early termination  */
-    read_lock (&parent->u.dir.lock);
-    if (dentry->d_fsdata)
-    {
-	set_current_state (TASK_UNINTERRUPTIBLE);
-	add_wait_queue (&lookup_info->wait_queue, &wait);
-	read_unlock (&parent->u.dir.lock);
-	schedule ();
-	/*
-	 * This does not need nor should remove wait from wait_queue.
-	 * Wait queue head is never reused - nothing is ever added to it
-	 * after all waiters have been waked up and head itself disappears
-	 * very soon after it. Moreover it is local variable on stack that
-	 * is likely to have already disappeared so any reference to it
-	 * at this point is buggy.
-	 */
 
-    }
-    else read_unlock (&parent->u.dir.lock);
+    /* Not devfsd - must wait for devfsd to return */
+    set_current_state (TASK_UNINTERRUPTIBLE);
+    add_wait_queue (&lookup_info->wait_queue, &wait);
+    up(&dir->i_sem);
+    schedule ();
+    down(&dir->i_sem);
+    /*
+     * This does not need nor should remove wait from wait_queue.
+     * Wait queue head is never reused - nothing is ever added to it
+     * after all waiters have been waked up and head itself disappears
+     * very soon after it. Moreover it is local variable on stack that
+     * is likely to have already disappeared so any reference to it
+     * at this point is buggy.
+     */
+
     return 1;
 }   /*  End Function devfs_d_revalidate_wait  */
 
@@ -2323,17 +2321,18 @@ static struct dentry *devfs_lookup (stru
 	if (try_modload (parent, fs_info,
 			 dentry->d_name.name, dentry->d_name.len, &tmp) < 0)
 	{   /*  Lookup event was not queued to devfsd  */
+	    dentry->d_fsdata = NULL;
 	    d_add (dentry, NULL);
 	    return NULL;
 	}
     }
-    dentry->d_op = &devfs_wait_dops;
     d_add (dentry, NULL);  /*  Open the floodgates  */
     /*  Unlock directory semaphore, which will release any waiters. They
 	will get the hashed dentry, and may be forced to wait for
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
@@ -2358,12 +2357,8 @@ static struct dentry *devfs_lookup (stru
 	     de->name, de->inode.ino, inode, de, current->comm);
     d_instantiate (dentry, inode);
 out:
-    write_lock (&parent->u.dir.lock);
-    dentry->d_op = &devfs_dops;
     dentry->d_fsdata = NULL;
     wake_up (&lookup_info.wait_queue);
-    write_unlock (&parent->u.dir.lock);
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */
@@ -2606,6 +2601,7 @@ static struct file_system_type devfs_fs_
     .name	= DEVFS_NAME,
     .get_sb	= devfs_get_sb,
     .kill_sb	= kill_anon_super,
+    .fs_flags	= FS_ODD_REVALIDATE,
 };
 
 /*  File operations for devfsd follow  */
--- linux-2.6.0/fs/namei.c.devfs_revalidate	2003-12-18 05:58:40.000000000 +0300
+++ linux-2.6.0/fs/namei.c	2004-01-04 14:06:15.000000000 +0300
@@ -274,6 +274,9 @@ void path_release(struct nameidata *nd)
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
+/*
+ * This seems to always be called under parent->i_sem locked
+ */
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, struct nameidata *nd)
 {
 	struct dentry * dentry = __d_lookup(parent, name);
@@ -342,6 +345,7 @@ static struct dentry * real_lookup(struc
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
+	int needlock = dir->i_sb->s_type->fs_flags & FS_ODD_REVALIDATE;
 
 	down(&dir->i_sem);
 	/*
@@ -377,13 +381,16 @@ static struct dentry * real_lookup(struc
 	 * Uhhuh! Nasty case: the cache was re-populated while
 	 * we waited on the semaphore. Need to revalidate.
 	 */
-	up(&dir->i_sem);
+	if (!needlock)
+		up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
 		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
 			dput(result);
 			result = ERR_PTR(-ENOENT);
 		}
 	}
+	if (needlock)
+		up(&dir->i_sem);
 	return result;
 }
 
@@ -528,11 +535,17 @@ static int do_lookup(struct nameidata *n
 {
 	struct vfsmount *mnt = nd->mnt;
 	struct dentry *dentry = __d_lookup(nd->dentry, name);
+	int needlock = mnt->mnt_sb->s_type->fs_flags & FS_ODD_REVALIDATE;
 
 	if (!dentry)
 		goto need_lookup;
+	if (needlock)
+		down(&nd->dentry->d_inode->i_sem);
 	if (dentry->d_op && dentry->d_op->d_revalidate)
 		goto need_revalidate;
+unlock:
+	if (needlock)
+		up(&nd->dentry->d_inode->i_sem);
 done:
 	path->mnt = mnt;
 	path->dentry = dentry;
@@ -546,9 +559,11 @@ need_lookup:
 
 need_revalidate:
 	if (dentry->d_op->d_revalidate(dentry, nd))
-		goto done;
+		goto unlock;
 	if (d_invalidate(dentry))
-		goto done;
+		goto unlock;
+	if (needlock)
+		up(&nd->dentry->d_inode->i_sem);
 	dput(dentry);
 	goto need_lookup;
 
--- linux-2.6.0/include/linux/fs.h.devfs_revalidate	2003-12-28 15:57:45.000000000 +0300
+++ linux-2.6.0/include/linux/fs.h	2004-01-04 18:47:11.000000000 +0300
@@ -94,6 +94,7 @@ extern int leases_enable, dir_notify_ena
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
 				  */
+#define FS_ODD_REVALIDATE	(1<<16) /* d_revalidate needs lock on i_sem */
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  */

--Boundary-00=_TQE+/JDyc9OroKE--

