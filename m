Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbTGZQEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTGZQCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:02:42 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:40210 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S268559AbTGZP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:59:47 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6.0-test1] redesign - stack corruption in devfs_lookup
Date: Sat, 26 Jul 2003 18:58:24 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <200307062058.40797.arvidjaar@mail.ru> <20030706120315.261732bb.akpm@osdl.org>
In-Reply-To: <20030706120315.261732bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QcpI/G4o40gkrAj"
Message-Id: <200307261858.25144.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QcpI/G4o40gkrAj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 06 July 2003 23:03, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > When devfs_lookup needs to call devfsd it arranges for other lookups for
> > the same name to wait. It is using local variable as wait queue head.
> > After devfsd returns devfs_lookup wakes up all waiters and returns.
> > Unfortunately there is no garantee all waiters will actually get chance
> > to run and clean up before devfs_lookup returns. so some of them attempt
> > to access already freed storage on stack.
>
> OK, but I think there is a simpler fix.  We can rely on the side-effects of
> prepare_to_wait() and finish_wait().
>

and here is even more simple fix. there is no need to ever bother about wait 
queue because it dies soon without our intervention. This is exactly what 
code in 2.4 does - somebody "improved" code in 2.5 (again) :(

the patch against 2.6.0-test1 removes my previous patch and adds comment in 
revalidate_wait to prevent it from hapenning again. It is basically 2.4 code 
except one spinlock acquisition has been moved a bit earlier (probably does 
not matter just looks better). This probably should use wake_up_all instead 
of wake_up to make intention more clear.

It is tested using the same test case. Also 2.4 never had this problem as 
well.

-andrey

--Boundary-00=_QcpI/G4o40gkrAj
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test1-devfs_stack_corruption-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test1-devfs_stack_corruption-3.patch"

--- linux-2.6.0-test1/fs/devfs/base.c.2.6.0-test1	2003-07-26 12:11:38.000000000 +0400
+++ linux-2.6.0-test1/fs/devfs/base.c	2003-07-26 12:11:06.000000000 +0400
@@ -2208,46 +2208,8 @@ struct devfs_lookup_struct
 {
     devfs_handle_t de;
     wait_queue_head_t wait_queue;
-    atomic_t count;
 };
 
-static struct devfs_lookup_struct *
-new_devfs_lookup_struct(void)
-{
-	struct devfs_lookup_struct *p = kmalloc(sizeof(*p), GFP_KERNEL);
-
-	if (!p)
-		return NULL;
-
-	init_waitqueue_head (&p->wait_queue);
-	atomic_set(&p->count, 1);
-	return p;
-}
-
-static void
-get_devfs_lookup_struct(struct devfs_lookup_struct *info)
-{
-	if (info)
-		atomic_inc(&info->count);
-	else {
-		printk(KERN_ERR "null devfs_lookup_struct pointer\n");
-		dump_stack();
-	}
-}
-
-static void
-put_devfs_lookup_struct(struct devfs_lookup_struct *info)
-{
-	if (info) {
-		if (!atomic_dec_and_test(&info->count))
-			return;
-		kfree(info);
-	} else {
-		printk(KERN_ERR "null devfs_lookup_struct pointer\n");
-		dump_stack();
-	}
-}
-
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
 static int devfs_d_revalidate_wait (struct dentry *dentry, struct nameidata *nd)
@@ -2290,13 +2252,19 @@ static int devfs_d_revalidate_wait (stru
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
-	get_devfs_lookup_struct(lookup_info);
 	set_current_state (TASK_UNINTERRUPTIBLE);
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
 	schedule ();
-	remove_wait_queue (&lookup_info->wait_queue, &wait);
-	put_devfs_lookup_struct(lookup_info);
+	/*
+	 * This does not need nor should remove wait from wait_queue.
+	 * Wait queue head is never reused - nothing is ever added to it
+	 * after all waiters have been waked up and head itself disappears
+	 * very soon after it. Moreover it is local variable on stack that
+	 * is likely to have already disappeared so any reference to it
+	 * at this point is buggy.
+	 */
+
     }
     else read_unlock (&parent->u.dir.lock);
     return 1;
@@ -2308,7 +2276,7 @@ static int devfs_d_revalidate_wait (stru
 static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
-    struct devfs_lookup_struct *lookup_info;
+    struct devfs_lookup_struct lookup_info;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
@@ -2325,10 +2293,9 @@ static struct dentry *devfs_lookup (stru
     read_lock (&parent->u.dir.lock);
     de = _devfs_search_dir (parent, dentry->d_name.name, dentry->d_name.len);
     read_unlock (&parent->u.dir.lock);
-    lookup_info = new_devfs_lookup_struct();
-    if (!lookup_info) return ERR_PTR(-ENOMEM);
-    lookup_info->de = de;
-    dentry->d_fsdata = lookup_info;
+    lookup_info.de = de;
+    init_waitqueue_head (&lookup_info.wait_queue);
+    dentry->d_fsdata = &lookup_info;
     if (de == NULL)
     {   /*  Try with devfsd. For any kind of failure, leave a negative dentry
 	    so someone else can deal with it (in the case where the sysadmin
@@ -2338,7 +2305,6 @@ static struct dentry *devfs_lookup (stru
 	if (try_modload (parent, fs_info,
 			 dentry->d_name.name, dentry->d_name.len, &tmp) < 0)
 	{   /*  Lookup event was not queued to devfsd  */
-	    put_devfs_lookup_struct(lookup_info);
 	    d_add (dentry, NULL);
 	    return NULL;
 	}
@@ -2350,7 +2316,7 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
-    de = lookup_info->de;
+    de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
     if (dentry->d_inode) goto out;
@@ -2377,8 +2343,7 @@ out:
     write_lock (&parent->u.dir.lock);
     dentry->d_op = &devfs_dops;
     dentry->d_fsdata = NULL;
-    wake_up (&lookup_info->wait_queue);
-    put_devfs_lookup_struct(lookup_info);
+    wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
     down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);

--Boundary-00=_QcpI/G4o40gkrAj--

