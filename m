Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267167AbTGGSwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbTGGSwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:52:53 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:39181 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S267167AbTGGSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:52:19 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined patch
Date: Mon, 7 Jul 2003 23:06:15 +0400
User-Agent: KMail/1.5
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <20030706120315.261732bb.akpm@osdl.org> <20030706175405.518f680d.akpm@osdl.org>
In-Reply-To: <20030706175405.518f680d.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nScC/Bk6DiZ1tYs"
Message-Id: <200307072306.15995.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nScC/Bk6DiZ1tYs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 07 July 2003 04:54, you wrote:
> Actually, don't bother.  This idea can be made to work, but
> we already have enough tricky stuff in the wait/wakeup area.
>
> Let's run with your original patch.
>

I finally hit a painfully trivial way to reproduce another long standing devfs 
problem - deadlock between devfs_lookup and devfs_d_revalidate_wait. When 
devfs_lookup releases directory i_sem devfs_d_revalidate_wait grabs it (it 
happens not for every path) and goes to wait to be waked up. Unfortunately, 
devfs_lookup attempts to acquire directory i_sem before ever waking it up ...

To reproduce (2.5.74 UP or SMP - does not matter, single CPU system)

ls /dev/foo & rm -f /dev/foo &

or possibly in a loop but then it easily fills up process table. In my case it 
hangs 100% reliably - on 2.5 OR 2.4.

The current fix is to move re-acquire of i_sem after all 
devfs_d_revalidate_wait waiters have been waked up. Much better fix would be 
to ensure that ->d_revalidate either is always called under i_sem or always 
without. But that means the very heart of VFS and I do not dare to touch it.

The fix has been tested on 2.4 (and is part of unofficial Mandrake Club 
kernel); I expected the same bug is in 2.5; I just was stupid not seeing the 
way to reproduce it before.

Attached is combined patch and fix for deadlock only (to show it alone). 
Andrew, I slightly polished original stack corruption version to look more 
consistent with the rest of devfs; also removed NULL pointer checks - let it 
just BUG in this case if it happens.

I have already sent the patch for 2.4 two times - please, could somebody 
finally either apply it or explain what is wrong with it. Richard is out of 
reach apparently and the bug is real and seen by many people.

regards

-andrey
--Boundary-00=_nScC/Bk6DiZ1tYs
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.5.74-devfs_combined.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.74-devfs_combined.patch"

--- linux-2.5.74-smp/fs/devfs/base.c.deadlock	2003-06-23 19:46:44.000000000 +0400
+++ linux-2.5.74-smp/fs/devfs/base.c	2003-07-07 22:38:35.000000000 +0400
@@ -2208,8 +2208,38 @@ struct devfs_lookup_struct
 {
     devfs_handle_t de;
     wait_queue_head_t wait_queue;
+    atomic_t count;
 };
 
+static struct devfs_lookup_struct *new_devfs_lookup_struct (void)
+{
+    struct devfs_lookup_struct *info = kmalloc (sizeof (*info), GFP_KERNEL);
+
+    if (info == NULL) {
+	PRINTK ("(): cannot allocate memory\n");
+	return NULL;
+    }
+
+    init_waitqueue_head (&info->wait_queue);
+    atomic_set (&info->count, 1);
+    DPRINTK (DEBUG_I_LOOKUP, "(%p): allocated\n", info);
+    return info;
+}
+
+static inline void get_devfs_lookup_struct (struct devfs_lookup_struct *info)
+{
+    atomic_inc (&info->count);
+}
+
+static inline void put_devfs_lookup_struct (struct devfs_lookup_struct *info)
+{
+    if (!atomic_dec_and_test (&info->count))
+	return;
+
+    DPRINTK (DEBUG_I_LOOKUP, "(%p): freed\n", info);
+    kfree (info);
+}
+
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
 static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
@@ -2252,11 +2282,13 @@ static int devfs_d_revalidate_wait (stru
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
+	get_devfs_lookup_struct (lookup_info);
 	set_current_state (TASK_UNINTERRUPTIBLE);
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
 	schedule ();
 	remove_wait_queue (&lookup_info->wait_queue, &wait);
+	put_devfs_lookup_struct (lookup_info);
     }
     else read_unlock (&parent->u.dir.lock);
     return 1;
@@ -2268,7 +2300,7 @@ static int devfs_d_revalidate_wait (stru
 static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry)
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
-    struct devfs_lookup_struct lookup_info;
+    struct devfs_lookup_struct *lookup_info;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
@@ -2285,9 +2317,10 @@ static struct dentry *devfs_lookup (stru
     read_lock (&parent->u.dir.lock);
     de = _devfs_search_dir (parent, dentry->d_name.name, dentry->d_name.len);
     read_unlock (&parent->u.dir.lock);
-    lookup_info.de = de;
-    init_waitqueue_head (&lookup_info.wait_queue);
-    dentry->d_fsdata = &lookup_info;
+    lookup_info = new_devfs_lookup_struct ();
+    if (lookup_info == NULL) return ERR_PTR (-ENOMEM);
+    lookup_info->de = de;
+    dentry->d_fsdata = lookup_info;
     if (de == NULL)
     {   /*  Try with devfsd. For any kind of failure, leave a negative dentry
 	    so someone else can deal with it (in the case where the sysadmin
@@ -2297,6 +2330,7 @@ static struct dentry *devfs_lookup (stru
 	if (try_modload (parent, fs_info,
 			 dentry->d_name.name, dentry->d_name.len, &tmp) < 0)
 	{   /*  Lookup event was not queued to devfsd  */
+	    put_devfs_lookup_struct (lookup_info);
 	    d_add (dentry, NULL);
 	    return NULL;
 	}
@@ -2308,8 +2342,7 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
-    de = lookup_info.de;
+    de = lookup_info->de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
     if (dentry->d_inode) goto out;
@@ -2333,11 +2366,13 @@ static struct dentry *devfs_lookup (stru
 	     de->name, de->inode.ino, inode, de, current->comm);
     d_instantiate (dentry, inode);
 out:
+    write_lock (&parent->u.dir.lock);
     dentry->d_op = &devfs_dops;
     dentry->d_fsdata = NULL;
-    write_lock (&parent->u.dir.lock);
-    wake_up (&lookup_info.wait_queue);
+    wake_up (&lookup_info->wait_queue);
+    put_devfs_lookup_struct (lookup_info);
     write_unlock (&parent->u.dir.lock);
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */

--Boundary-00=_nScC/Bk6DiZ1tYs
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.5.74-devfs_lookup_deadlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.74-devfs_lookup_deadlock.patch"

--- linux-2.5.74-smp/fs/devfs/base.c.orig	2003-07-07 20:58:36.000000000 +0400
+++ linux-2.5.74-smp/fs/devfs/base.c	2003-07-07 20:58:50.000000000 +0400
@@ -2308,7 +2308,6 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
@@ -2338,6 +2337,7 @@ out:
     write_lock (&parent->u.dir.lock);
     wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */

--Boundary-00=_nScC/Bk6DiZ1tYs--

