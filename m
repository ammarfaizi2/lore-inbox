Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbVKBNB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVKBNB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVKBNB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:01:26 -0500
Received: from mivlgu.ru ([81.18.140.87]:30106 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932676AbVKBNB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:01:26 -0500
Date: Wed, 2 Nov 2005 16:01:18 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051102130118.GA23142@master.mivlgu.local>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org> <20051101035816.GA7788@vrfy.org> <20051101195449.GA9162@procyon.home> <20051101213525.GA17207@vrfy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20051101213525.GA17207@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2005 at 10:35:25PM +0100, Kay Sievers wrote:
> On Tue, Nov 01, 2005 at 10:54:49PM +0300, Sergey Vlasov wrote:
> > On Tue, Nov 01, 2005 at 04:58:16AM +0100, Kay Sievers wrote:
> > > On Tue, Nov 01, 2005 at 01:28:46AM +0100, Kay Sievers wrote:
> > > > Ok, makes sense. The attached seems to work for me. If we can get
> > > > something like this, we can remove the superblock claim/release eve=
nts
> > > > completely and just read the events from the /proc/mounts file itse=
lf.
> >=20
> > No, we need both events.  When you need to tell the user when it is
> > safe to disconnect the storage device, the event from detach_mnt() is
> > useless - it happens too early.  In fact, even the current way of
> > sending the event from kill_block_super() is broken, because the event
> > is generated before generic_shutdown_super() and sync_blockdev(), and
> > writing out cached data may take some time.
> >=20
> > We could try to emit busy/free events from bd_claim() and
> > bd_release(); this would be triggered by most "interesting" users
> > (even opens with O_EXCL), but not by things like volume_id.
>=20
> Hmm, HAL polls optical drives every 2 seconds with O_EXCL to detect media
> changes. You need to do it EXCL, cause otherwise some cd burners fail.

Crap...  Then we can only move the bdev_uevent() call in
kill_block_super() later, and other users of block devices will not be
noticed at all.

> > > New patch. Missed a check for namespace =3D=3D NULL in detach_mnt().
[skip]
> > This assumes that there will be only one process per namespace which
> > will call poll() on /proc/mounts.  Even though someone may argue that
> > it is the right approach (have a single process which watches
> > /proc/mounts and broadcasts updates to other interested processes,
> > e.g., over dbus), with the above implementation any unprivileged user
> > can call poll() and interfere with the operation of that designated
> > process.
>=20
> Sure, capable(CAP_SYS_ADMIN) could prevent this.

poll() protected by CAP_SYS_ADMIN?  Ewww.

/proc/bus/usb/devices uses event counters in its poll() implementation;
something like this could be done here too.  What about the following
patch (compile tested only):

-----------------------------------------------------------------------

Add poll support for /proc/.../mounts

Now poll() or select() system calls can be used to wait for mount tree
changes.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 fs/namespace.c            |   19 ++++++++++-
 fs/proc/base.c            |   75 ++++++++++++++++++++++++++++++++++-------=
----
 include/linux/namespace.h |    9 +++++
 3 files changed, 82 insertions(+), 21 deletions(-)

applies-to: b87f06d928e0ea06ae6244c1aeecf3e745f39bb9
1704c384737e1cdbca3194f3471195c9ee4377a5
diff --git a/fs/namespace.c b/fs/namespace.c
index 2fa9fdf..4182210 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -39,6 +39,8 @@ static inline int sysfs_init(void)
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
=20
+DECLARE_WAIT_QUEUE_HEAD(mounts_wait);
+
 static struct list_head *mount_hashtable;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
 static kmem_cache_t *mnt_cache;=20
@@ -120,6 +122,10 @@ static void detach_mnt(struct vfsmount *
 	list_del_init(&mnt->mnt_child);
 	list_del_init(&mnt->mnt_hash);
 	old_nd->dentry->d_mounted--;
+	if (current->namespace) {
+		current->namespace->event++;
+		wake_up_interruptible(&mounts_wait);
+	}
 }
=20
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
@@ -129,6 +135,8 @@ static void attach_mnt(struct vfsmount *
 	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
+	current->namespace->event++;
+	wake_up_interruptible(&mounts_wait);
 }
=20
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
@@ -185,7 +193,8 @@ EXPORT_SYMBOL(__mntput);
 /* iterator */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
-	struct namespace *n =3D m->private;
+	struct proc_mounts_private *private =3D m->private;
+	struct namespace *n =3D private->namespace;
 	struct list_head *p;
 	loff_t l =3D *pos;
=20
@@ -198,7 +207,8 @@ static void *m_start(struct seq_file *m,
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct namespace *n =3D m->private;
+	struct proc_mounts_private *private =3D m->private;
+	struct namespace *n =3D private->namespace;
 	struct list_head *p =3D ((struct vfsmount *)v)->mnt_list.next;
 	(*pos)++;
 	return p=3D=3D&n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
@@ -206,7 +216,8 @@ static void *m_next(struct seq_file *m,=20
=20
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct namespace *n =3D m->private;
+	struct proc_mounts_private *private =3D m->private;
+	struct namespace *n =3D private->namespace;
 	up_read(&n->sem);
 }
=20
@@ -1093,6 +1104,7 @@ int copy_namespace(int flags, struct tas
 	atomic_set(&new_ns->count, 1);
 	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
+	new_ns->event =3D 0;
=20
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
@@ -1394,6 +1406,7 @@ static void __init init_mount_tree(void)
 	init_rwsem(&namespace->sem);
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root =3D mnt;
+	namespace->event =3D 0;
 	mnt->mnt_namespace =3D namespace;
=20
 	init_task.namespace =3D namespace;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a170450..41462c0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -57,6 +57,7 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/string.h>
+#include <linux/poll.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
 #include <linux/namespace.h>
@@ -663,39 +664,77 @@ extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
 {
 	struct task_struct *task =3D proc_task(inode);
-	int ret =3D seq_open(file, &mounts_op);
+	struct proc_mounts_private *private;
+	struct seq_file *m;
+	struct namespace *namespace;
+	int ret =3D -ENOMEM;
+
+	private =3D kmalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		goto out;
+	ret =3D seq_open(file, &mounts_op);
+	if (ret)
+		goto out_free_private;
+	m =3D file->private_data;
+	m->private =3D private;
=20
-	if (!ret) {
-		struct seq_file *m =3D file->private_data;
-		struct namespace *namespace;
-		task_lock(task);
-		namespace =3D task->namespace;
-		if (namespace)
-			get_namespace(namespace);
-		task_unlock(task);
-
-		if (namespace)
-			m->private =3D namespace;
-		else {
-			seq_release(inode, file);
-			ret =3D -EINVAL;
-		}
+	task_lock(task);
+	namespace =3D task->namespace;
+	if (namespace)
+		get_namespace(namespace);
+	task_unlock(task);
+	if (!namespace) {
+		ret =3D -EINVAL;
+		goto out_release;
 	}
+
+	private->namespace =3D namespace;
+	down_read(&namespace->sem);
+	private->last_event =3D namespace->event;
+	up_read(&namespace->sem);
+out:
 	return ret;
+
+out_release:
+	seq_release(inode, file);
+out_free_private:
+	kfree(private);
+	goto out;
 }
=20
 static int mounts_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *m =3D file->private_data;
-	struct namespace *namespace =3D m->private;
-	put_namespace(namespace);
+	struct proc_mounts_private *private =3D m->private;
+	put_namespace(private->namespace);
+	kfree(private);
 	return seq_release(inode, file);
 }
=20
+static unsigned int mounts_poll(struct file *file, poll_table *wait)
+{
+	struct seq_file *m =3D file->private_data;
+	struct proc_mounts_private *private =3D m->private;
+	struct namespace *namespace =3D private->namespace;
+	int ret =3D 0;
+
+	poll_wait(file, &mounts_wait, wait);
+
+	down_read(&namespace->sem);
+	if (private->last_event !=3D namespace->event) {
+		private->last_event =3D namespace->event;
+		ret =3D POLLIN | POLLRDNORM;
+	}
+	up_read(&namespace->sem);
+
+	return ret;
+}
+
 static struct file_operations proc_mounts_operations =3D {
 	.open		=3D mounts_open,
 	.read		=3D seq_read,
 	.llseek		=3D seq_lseek,
+	.poll		=3D mounts_poll,
 	.release	=3D mounts_release,
 };
=20
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
index 0e5a86f..fe5840a 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -10,6 +10,7 @@ struct namespace {
 	struct vfsmount *	root;
 	struct list_head	list;
 	struct rw_semaphore	sem;
+	unsigned int		event;
 };
=20
 extern int copy_namespace(int, struct task_struct *);
@@ -38,5 +39,13 @@ static inline void get_namespace(struct=20
 	atomic_inc(&namespace->count);
 }
=20
+/* /proc/.../mounts file descriptor state */
+struct proc_mounts_private {
+	struct namespace *	namespace;
+	unsigned int		last_event;
+};
+
+extern wait_queue_head_t mounts_wait;
+
 #endif
 #endif
---
0.99.8.GIT

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDaLidW82GfkQfsqIRAgt5AJ45wxQyWKyCL5oBAT4kmBwbyImotwCggRwO
dTlQMKbbYsTmnfMFn0H+HPo=
=ncT7
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
