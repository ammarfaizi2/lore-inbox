Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbULIH1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbULIH1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbULIH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:27:20 -0500
Received: from [61.48.53.158] ([61.48.53.158]:64507 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261460AbULIHY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:24:58 -0500
Date: Wed, 8 Dec 2004 23:13:18 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412090713.iB97DIE27854@adam.yggdrasil.com>
To: greg@kroah.com, maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: [patch?] unpin sysfs directories, saving ~0.5MB
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is a draft patch allowing the kernel to release
inode and dentry structures for sysfs directories.  This patch
basically completes Maneesh's idea of unpinning sysfs inode and
dentry structures (his patch in 2.6.10-rc2 unpinning non-directories
saves about 1.2 megabytes on system, I believe).

	This patch is again a heavily hacked 2.6.10-rc2-bk16 tree,
so it probably just for reading unless you have been following
the other sysfs patches that I have posted.


MEMORY SAVINGS:

	I believe this patch saves about half a megabyte on
the pretty basic 32-bit PC on which I'm composing this message.  On
this system, struct inode is 344 bytes and struct dentry is 160 bytes,
but this patch adds 40 bytes to struct sysfs_dir (sysfs_dir is a
variant of sysfs_dirent I made in a previous patch to avoid
allocation the s_children field for non-directories).  So, 464
bytes per sysfs directory should be unpinned by this patch
(344 + 160 - 40 = 464).  There are 1143 directories currently
in my sysfs tree, not counting the root inode.  464 bytes per
directory times 1143 directories is 530,352 bytes unpinned.

LOCKING:

	Please see the comments in fs/sysfs/sysfs.h for
information about locking.  Basically, there is a new
semaphore sysfs_dir.s_child_sem, which guards sysfs_dirent.s_sibling,
sysfs_dirent.dentry and and the new fields in sysfs_dir.

DIRECTORY TIMES:

	Note that this patch preserves the modification and
create time of directories when the inode structure is
dropped (unlike the non-directory case in the current sysfs),
as well as the link count.  This is done so that programs
that walk the sysfs tree in search of modifications can still
skip directories that have only two links (and therefore
no subdirectories) and have not been modified since the
last time the check was done.  I have a program that does just
this, which I may put to some practical use in the future.
For example, I think perhaps we could generate hotplug events this
way, as it will result in correct coalescing of events and
make it much easier to tell what events can be processed
in parallel to each other, and we would not need things like
sequence numbers.

	The current implementation also saves directory
creation times for now, as I feel a little strange about
using CURRENT_TIME and therefore claiming that the file
was modified after it was created.  Probably I will drop
this and instead initialize both creation and modification
time from the saved modification time, as many sysfs directories
are created before user level code runs and adjusts the clock,
which can give you a big artificial time gap if your PC initially
load the real time from hardware on the incorrect assumption
that the hardware time is UTC, only to have that assumption
corrrected later by boot scripts, long after most of the main
sysfs directories have been created.

OTHER NOTES:

	This is a "draft" patch in that it contains some lines
that probably should be changed or submitted separately for
integration that I've deliberately included either because I
want some feedback or because they are small changes to code
that has moved around a lot in previous patches:

	a) I've commented out some checks in sysfs_update_file that
	   I think are unnecessary.  I'd be interested in hearing
	   if and why my belief is incorrect.

	b) I've left my my ASSERT_SEMAPHORE_HELD macros in, which are
	   not necessary for the patch, but I think they're helpful
	   both for documentation and testing, and they indicate
	   some things that have been tested a bit, in case anyone
	   thinks they see a locking problem.

	c) I've replaced all BUG_ON(x || y) statements with separate
	   BUG_ON(x) and BUG_ON(y) statements.  Separate BUG_ON
	   statements produce more informative messages, sometimes
	   in situations that might not easily be reproducible.
	   It's also conceivable that the compiler might do
	   better branch prediction with separate BUG_ON statements,
	   but perhaps it is smart enough to realize that if it has
	   been told that "x || y" is likely to evaluated to zero,
	   it must also be likely that "x" will evalutate to zero
	   and "y" will evaluate to zero.

	I have run maneesh's test of repeatedly loading and
unloading the network driver while doing recursive find
commands on /sys and reading the files in /class/class/net.
It seems to be okay in that respect.  I am also running the
code as I write this message.

	I don't know if I'm supposed to include a "Signed-of-by:"
line in this case, but I'll do it anyway as I wouldn't actually
object if the patch were integrated as-is, although I expect
there will be comments and consequent changes.

	This patch is against a heavily modified 2.6.10-rc2-bk16.
I hope to try to get caught up to the latest snapshot tomorrow,
and should be able to generate any new patches if requested
at that point.


SOME FUTURE IDEAS:

	By the way, there are still some opportunities to further
reduce the cost of sysfs that I hope to pursue after this patch,
such as not having a struct sysfs_dirent for each attribute that
is a member of an attribute_group, perhaps eliminating
sysfs_dirent.dentry for non-directories, and perhaps moving the
s_children and s_sibling fields into struct kobject to
eliminate the many of the duplicate lists maintained for
lists of devices, lists of drivers and lists of other abstractions.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


Signed-off-by: Adam J. Richter <adam@yggdrasil.com>

diff -u linux/fs/sysfs.old2/bin.c linux/fs/sysfs/bin.c
--- linux/fs/sysfs.old2/bin.c	2004-11-03 15:09:13.000000000 +0800
+++ linux/fs/sysfs/bin.c	2004-12-09 14:13:26.000000000 +0800
@@ -158,9 +158,12 @@
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	BUG_ON(!kobj || !kobj->dentry || !attr);
+	BUG_ON(!kobj);
+	BUG_ON(!kobj->sysfs_dir);
+	BUG_ON(!attr);
 
-	return sysfs_add_file(kobj->dentry, &attr->attr, SYSFS_KOBJ_BIN_ATTR);
+	return sysfs_add_file(kobj->sysfs_dir, &attr->attr,
+			      SYSFS_KOBJ_BIN_ATTR);
 }
 
 
@@ -173,7 +176,7 @@
 
 int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->attr.name);
+	sysfs_hash_and_remove(kobj->sysfs_dir, attr->attr.name);
 	return 0;
 }
 
diff -u linux/fs/sysfs.old2/dir.c linux/fs/sysfs/dir.c
--- linux/fs/sysfs.old2/dir.c	2004-12-09 13:14:03.000000000 +0800
+++ linux/fs/sysfs/dir.c	2004-12-09 13:34:53.000000000 +0800
@@ -15,11 +15,21 @@
 static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
 {
 	struct sysfs_dirent * sd = dentry->d_fsdata;
+	struct sysfs_dir * parent_sd;
 
 	if (sd) {
 		BUG_ON(sd->s_dentry != dentry);
+
+		parent_sd = dentry_to_sysfs_dir(dentry->d_parent);
+
+		/* Because we down the semaphore here, calls to dput()
+		   that might drop a reference count to zero must by
+		   done when parent_sd->s_child_sem is not held. */
+
+		down(&parent_sd->s_child_sem);
 		sd->s_dentry = NULL;
 		sysfs_put(sd);
+		up(&parent_sd->s_child_sem);
 	}
 	iput(inode);
 }
@@ -28,20 +38,66 @@
 	.d_iput		= sysfs_d_iput,
 };
 
+/* sysfs_dirent_dget is the *only* way we get a file system
+   abstraction from a kobject abstraction. */
+struct dentry *sysfs_dirent_dget(struct sysfs_dir *parent,
+				 struct sysfs_dirent *sd)
+{
+	struct dentry *dentry;
+	struct dentry *result = NULL;
+
+	/* so we are allowed to read sd->s_dentry: */
+	ASSERT_SEMAPHORE_HELD(&parent->s_child_sem);
+
+	dentry = sd->s_dentry;
+
+	/* dentry can be non-NULL and yet dentry->d_count can be zero if
+	   sysfs_d_iput is being called on the dentry.
+	   This can occur if the dentry is in the process of being
+	   released by sysfs_d_iput, and sysfs_d_iput has not yet taken
+	   parent_sd->s_child_sem.  In that case, it is guaranteed that
+	   the there will be no further vfs operations on the dentry
+	   until by sysfs_d_iput completes removal of the inode, so
+	   we can act as if sd->s_dentry had already been set to NULL.
+
+	   Also, we have to take dentry->d_lock to avoid a race
+	   where we look at dentry->d_count just before dput
+	   decrements it.
+	*/
+
+	if (dentry != NULL) {
+		spin_lock(&dentry->d_lock);
+
+		if (atomic_read(&dentry->d_count) != 0)
+			result = dget(dentry);
+
+		spin_unlock(&dentry->d_lock);
+	}
+
+	return result;
+}
+
+
 /*
  * Allocates a new sysfs_dirent and links it to the parent sysfs_dirent
+ * Caller holds parent_sd->s_child_sem.
  */
 static struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dir * parent_sd,
 					      void * element, int type)
 {
 	struct sysfs_dirent * sd;
 
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+
 	if (sysfs_type_dir(type)) {
 		struct sysfs_dir * sdir;
 		sdir = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
 		if (!sdir)
 			return NULL;
+		sema_init(&sdir->s_child_sem, 1);
 		INIT_LIST_HEAD(&sdir->s_children);
+		sdir->s_mtime = sdir->s_ctime = CURRENT_TIME;
+		sdir->s_nlink = 2;
 		sd = &sdir->s_ent;
 	} else {
 		sd = kmem_cache_alloc(sysfs_dirent_cachep, GFP_KERNEL);
@@ -57,6 +113,23 @@
 	return sd;
 }
 
+/* Caller holds parent_sd->s_child_sem. */
+struct sysfs_dirent *sysfs_make_dirent(struct sysfs_dir * parent_sd,
+				       void * element, umode_t mode, int type)
+{
+	struct sysfs_dirent * sd;
+
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+
+	sd = sysfs_new_dirent(parent_sd, element, type);
+	if (sd) {
+		sd->s_mode = mode;
+		parent_sd->s_mtime = CURRENT_TIME;
+	}
+
+	return sd;
+}
+
 void release_sysfs_dirent(struct sysfs_dirent * sd)
 {
 	if (sd->s_type & SYSFS_KOBJ_LINK) {
@@ -71,32 +144,10 @@
 		kmem_cache_free(sysfs_dirent_cachep, sd);
 }
 
-int sysfs_make_dirent(struct sysfs_dir * parent_sd, struct dentry * dentry,
-			void * element, umode_t mode, int type)
-{
-	struct sysfs_dirent * sd;
-
-	sd = sysfs_new_dirent(parent_sd, element, type);
-	if (!sd)
-		return -ENOMEM;
-
-	sd->s_mode = mode;
-	sd->s_dentry = dentry;
-	if (dentry) {
-		dentry->d_fsdata = sd;
-		dentry->d_op = &sysfs_dentry_ops;
-	}
-
-	return 0;
-}
-
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &sysfs_dir_inode_operations;
 	inode->i_fop = &sysfs_dir_operations;
-
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
 	return 0;
 }
 
@@ -113,42 +164,38 @@
 	return 0;
 }
 
-static int create_dir(void *element, struct dentry * p,
-		      const char * n, struct dentry ** d, int type)
+static int create_dir(struct kobject *parent_kobj,
+		      void *element,
+		      const char * n, struct sysfs_dir ** sdir_out, int type)
 {
+	struct sysfs_dir * parent_sd;
 	int error;
-	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
-	struct sysfs_dir *parent_sd;
+	const umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
+	struct sysfs_dirent *sd;
+
+	parent_sd = parent_kobj ? parent_kobj->sysfs_dir : &sysfs_root;
+
+	down(&parent_sd->s_child_sem);
+
+	error = -ENOMEM;
+	sd = sysfs_make_dirent(parent_sd, element, mode, type);
+	if (sd != NULL) {
+		*sdir_out = to_sysfs_dir(sd);
+		error = 0;
+		parent_sd->s_nlink++;
+	}
+
+	up(&parent_sd->s_child_sem);
 
-	down(&p->d_inode->i_sem);
-	*d = sysfs_get_dentry(p,n);
-	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d, mode, init_dir);
-		if (!error) {
-			parent_sd = dentry_to_sysfs_dir(p);
-			error = sysfs_make_dirent(parent_sd, *d, element,
-						  mode, type);
-			if (!error) {
-				p->d_inode->i_nlink++;
-				(*d)->d_op = &sysfs_dentry_ops;
-				d_rehash(*d);
-			}
-		}
-		if (error && (error != -EEXIST))
-			d_drop(*d);
-		dput(*d);
-	} else
-		error = PTR_ERR(*d);
-	up(&p->d_inode->i_sem);
 	return error;
 }
 
 
 int sysfs_create_subdir(struct kobject * k,
 			const struct attribute_group *grp,
-			struct dentry ** d)
+			struct sysfs_dir ** sdir_out)
 {
-	return create_dir((void*)grp, k->dentry, grp->name, d,
+	return create_dir(k, (void*)grp, grp->name, sdir_out,
 			  SYSFS_ATTR_GROUP);
 }
 
@@ -160,27 +207,42 @@
 
 int sysfs_create_dir(struct kobject * kobj)
 {
-	struct dentry * dentry = NULL;
-	struct dentry * parent;
+	struct sysfs_dir *sdir;
 	int error = 0;
 
 	BUG_ON(!kobj);
 
-	if (kobj->parent)
-		parent = kobj->parent->dentry;
-	else if (sysfs_mount && sysfs_mount->mnt_sb)
-		parent = sysfs_mount->mnt_sb->s_root;
-	else
-		return -EFAULT;
-
-	error = create_dir(kobj,parent,kobject_name(kobj),&dentry, SYSFS_DIR);
+	error = create_dir(kobj->parent, kobj, kobject_name(kobj), &sdir,
+			   SYSFS_DIR);
 	if (!error)
-		kobj->dentry = dentry;
+		kobj->sysfs_dir = sdir;
 	return error;
 }
 
+static int sysfs_attach_dir(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	struct inode *inode;
+	int error;
+
+	error = sysfs_create(dentry, sd->s_mode, init_dir);
+	if (error)
+		return error;
+
+	inode = dentry->d_inode;
+
+	inode->i_atime = CURRENT_TIME;
+
+	dentry->d_op = &sysfs_dentry_ops;
+	dentry->d_fsdata = sd;
+	sd->s_dentry = dentry;
+	d_rehash(dentry);
+	return 0;
+}
+
+
 /* attaches attribute's sysfs_dirent to the dentry corresponding to the
  * attribute file
+ * Called with parent directory's s_child_sem held.
  */
 static int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
 {
@@ -197,7 +259,9 @@
                 init = init_file;
         }
 
-	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	error = sysfs_create(dentry,
+			     ((attr->mode | sd->s_mode) & S_IALLUGO) | S_IFREG,
+			     init);
 	if (error)
 		return error;
 
@@ -213,6 +277,7 @@
 	return 0;
 }
 
+/* Called with parent directory's s_child_sem held. */
 static int sysfs_attach_link(struct sysfs_dirent * sd, struct dentry * dentry)
 {
 	int err = 0;
@@ -227,60 +292,126 @@
 	return err;
 }
 
+struct sysfs_dirent *sysfs_find_by_name(struct sysfs_dir *parent_sd,
+					const char *name)
+{
+	struct sysfs_dirent *sd;
+
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+	
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+
+		if (!strcmp(sysfs_get_name(sd), name))
+			return sd;
+	}
+
+	return NULL;
+}
+
 static struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
-				struct nameidata *nd)
+				    struct nameidata *nd)
 {
 	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry->d_parent);
 	struct sysfs_dirent * sd;
 	int err = 0;
 
-	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (sd->s_type & SYSFS_NOT_PINNED) {
-			const unsigned char * name = sysfs_get_name(sd);
+	BUG_ON(dentry->d_parent->d_inode != dir);
 
-			if (strcmp(name, dentry->d_name.name))
-				continue;
+	ASSERT_SEMAPHORE_HELD(&dir->i_sem);
 
-			if (sd->s_type & SYSFS_KOBJ_LINK)
-				err = sysfs_attach_link(sd, dentry);
-			else
-				err = sysfs_attach_attr(sd, dentry);
+	down(&parent_sd->s_child_sem);
+
+	sd = sysfs_find_by_name(parent_sd, dentry->d_name.name);
+	if (sd) {
+		switch(sd->s_type) {
+		case SYSFS_KOBJ_LINK:
+			err = sysfs_attach_link(sd, dentry);
+			break;
+		case SYSFS_KOBJ_ATTR:
+		case SYSFS_KOBJ_BIN_ATTR:
+			err = sysfs_attach_attr(sd, dentry);
+			break;
+		case SYSFS_DIR:
+		case SYSFS_ATTR_GROUP:
+			err = sysfs_attach_dir(sd, dentry);
+			break;
+		default:
 			break;
 		}
 	}
+	up(&parent_sd->s_child_sem);
 
 	return ERR_PTR(err);
 }
 
+static int sysfs_dir_getattr(struct vfsmount *mnt,
+			     struct dentry *dentry,
+			     struct kstat *kstat)
+{
+	struct sysfs_dir *sdir = dentry_to_sysfs_dir(dentry);
+
+	down(&sdir->s_child_sem);
+
+	generic_fillattr(dentry->d_inode, kstat);
+
+	kstat->nlink = sdir->s_nlink;
+	kstat->ctime = sdir->s_ctime;
+	kstat->mtime = sdir->s_mtime;
+
+	up(&sdir->s_child_sem);
+
+	return 0;
+}
+
 struct inode_operations sysfs_dir_inode_operations = {
 	.lookup		= sysfs_lookup,
+	.getattr	= sysfs_dir_getattr,
 };
 
-static void remove_dir(struct dentry * d)
+static void remove_dir(struct kobject *parent_kobj, struct sysfs_dir * sd)
 {
-	struct dentry * parent = dget(d->d_parent);
-	struct sysfs_dirent * sd;
+	struct sysfs_dir *parent_sd =
+		parent_kobj ? parent_kobj->sysfs_dir : &sysfs_root;
 
-	down(&parent->d_inode->i_sem);
-	d_delete(d);
-	sd = d->d_fsdata;
- 	list_del_init(&sd->s_sibling);
-	sysfs_put(sd);
-	if (d->d_inode)
-		simple_rmdir(parent->d_inode,d);
+	struct dentry * d;
+
+	down(&parent_sd->s_child_sem);
+
+	d = sysfs_dirent_dget(parent_sd, &sd->s_ent);
+
+	unhook_sysfs_dirent(parent_sd, &sd->s_ent);
+
+	if (d)
+		d_delete(d);
+
+	up(&parent_sd->s_child_sem);
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
 
-	up(&parent->d_inode->i_sem);
-	dput(parent);
+	dput(d);
 }
 
-void sysfs_remove_subdir(struct dentry * d)
+void sysfs_remove_subdir(struct kobject *parent, struct sysfs_dir * d)
 {
-	remove_dir(d);
+	remove_dir(parent, d);
 }
 
+static struct sysfs_dirent *first_nonpinned_child(struct sysfs_dir *parent_sd)
+{
+	struct sysfs_dirent *sd;
+
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_element && (sd->s_type & SYSFS_NOT_PINNED))
+			return sd;
+	}
+
+	return NULL;
+}
 
 /**
  *	sysfs_remove_dir - remove an object's directory.
@@ -293,36 +424,36 @@
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
-	struct dentry * dentry = dget(kobj->dentry);
-	struct sysfs_dir * parent_sd;
-	struct sysfs_dirent * sd, * tmp;
+	struct sysfs_dir	*kobj_sd = kobj->sysfs_dir;
+	struct dentry		*child_dentry;
+	struct sysfs_dirent	*child_sd;
 
-	if (!dentry)
-		return;
+	down(&kobj_sd->s_child_sem);
+	while ((child_sd = first_nonpinned_child(kobj_sd)) != NULL) {
 
-	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
-	down(&dentry->d_inode->i_sem);
-	parent_sd = dentry_to_sysfs_dir(dentry);
-	list_for_each_entry_safe(sd,tmp,&parent_sd->s_children,s_sibling) {
-		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
-			continue;
-		sysfs_drop_dentry(sd, dentry);
-		list_del_init(&sd->s_sibling);
-		sysfs_put(sd);
+		child_dentry = sysfs_dirent_dget(kobj_sd, child_sd);
+
+		unhook_sysfs_dirent(kobj_sd, child_sd);
+
+		if (child_dentry) {
+			sysfs_drop_dentry(child_dentry);
+
+			up(&kobj_sd->s_child_sem);
+			dput(child_dentry);
+			down(&kobj_sd->s_child_sem);
+		}
 	}
-	up(&dentry->d_inode->i_sem);
 
-	remove_dir(dentry);
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
+	up(&kobj_sd->s_child_sem);
+
+	remove_dir(kobj->parent, kobj_sd);
 }
 
 int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
 {
 	int error = 0;
 	struct dentry * new_dentry, * parent;
+	struct sysfs_dir *parent_sd;
 
 	if (!strcmp(kobject_name(kobj), new_name))
 		return -EINVAL;
@@ -331,24 +462,31 @@
 		return -EINVAL;
 
 	down_write(&sysfs_rename_sem);
-	parent = kobj->parent->dentry;
+	parent_sd = kobj->parent->sysfs_dir;
+	parent = parent_sd->s_ent.s_dentry;
 
-	down(&parent->d_inode->i_sem);
+	down(&parent->d_inode->i_sem);	
 
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
+			down(&parent_sd->s_child_sem);
+
 			error = kobject_set_name(kobj, "%s", new_name);
 			if (!error) {
 				d_add(new_dentry, NULL);
-				d_move(kobj->dentry, new_dentry);
+				d_move(kobj->sysfs_dir->s_ent.s_dentry,
+				       new_dentry);
 			}
 			else
 				d_drop(new_dentry);
+
+			up(&parent_sd->s_child_sem);
 		} else
 			error = -EEXIST;
 		dput(new_dentry);
 	}
+	parent_sd->s_mtime = CURRENT_TIME;
 	up(&parent->d_inode->i_sem);	
 	up_write(&sysfs_rename_sem);
 
@@ -357,27 +495,35 @@
 
 static int sysfs_dir_open(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
-	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry);
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(file->f_dentry);
+
+	BUG_ON(file->f_dentry->d_inode != inode);
 
-	down(&dentry->d_inode->i_sem);
+	down(&parent_sd->s_child_sem);
 	file->private_data = sysfs_new_dirent(parent_sd, NULL, SYSFS_CURSOR);
-	up(&dentry->d_inode->i_sem);
+	up(&parent_sd->s_child_sem);
 
-	return file->private_data ? 0 : -ENOMEM;
+	if (file->private_data) {
 
+		down(&inode->i_sem);
+		inode->i_atime = CURRENT_TIME;
+		up(&inode->i_sem);
+
+		return 0;
+	}
+	else
+		return -ENOMEM;
 }
 
 static int sysfs_dir_close(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
 	struct sysfs_dirent * cursor = file->private_data;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(file->f_dentry);
 
-	down(&dentry->d_inode->i_sem);
-	list_del_init(&cursor->s_sibling);
-	up(&dentry->d_inode->i_sem);
+	down(&parent_sd->s_child_sem);
+	list_del(&cursor->s_sibling);
+	up(&parent_sd->s_child_sem);
 
-	BUG_ON(cursor->s_dentry != NULL);
 	release_sysfs_dirent(cursor);
 
 	return 0;
@@ -414,6 +560,7 @@
 			i++;
 			/* fallthrough */
 		default:
+			down(&parent_sd->s_child_sem);
 			if (filp->f_pos == 2) {
 				list_del(q);
 				list_add(q, &parent_sd->s_children);
@@ -437,14 +584,17 @@
 					ino = iunique(sysfs_sb, 2);
 
 				if (filldir(dirent, name, len, filp->f_pos, ino,
-						 dt_type(next)) < 0)
+					    dt_type(next)) < 0) {
+					up(&parent_sd->s_child_sem);
 					return 0;
+				}
 
 				list_del(q);
 				list_add(q, p);
 				p = q;
 				filp->f_pos++;
 			}
+			up(&parent_sd->s_child_sem);
 	}
 	return 0;
 }
@@ -452,8 +602,8 @@
 static loff_t sysfs_dir_lseek(struct file * file, loff_t offset, int origin)
 {
 	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry);
 
-	down(&dentry->d_inode->i_sem);
 	switch (origin) {
 		case 1:
 			offset += file->f_pos;
@@ -461,9 +611,9 @@
 			if (offset >= 0)
 				break;
 		default:
-			up(&file->f_dentry->d_inode->i_sem);
 			return -EINVAL;
 	}
+	down(&parent_sd->s_child_sem);
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
 		if (file->f_pos >= 2) {
@@ -485,7 +635,7 @@
 			list_add_tail(&cursor->s_sibling, p);
 		}
 	}
-	up(&dentry->d_inode->i_sem);
+	up(&parent_sd->s_child_sem);
 	return offset;
 }
 
diff -u linux/fs/sysfs.old2/file.c linux/fs/sysfs/file.c
--- linux/fs/sysfs.old2/file.c	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/file.c	2004-12-09 14:13:18.000000000 +0800
@@ -355,15 +355,16 @@
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
+int sysfs_add_file(struct sysfs_dir * parent_sd,
+		const struct attribute * attr, int type)
 {
-	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dir);
 	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
-	down(&dir->d_inode->i_sem);
-	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
-	up(&dir->d_inode->i_sem);
+	down(&parent_sd->s_child_sem);
+	if (sysfs_make_dirent(parent_sd, (void *) attr, mode, type) == NULL)
+		error = -ENOMEM;
+	up(&parent_sd->s_child_sem);
 
 	return error;
 }
@@ -377,10 +378,11 @@
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	BUG_ON(!kobj || !kobj->dentry || !attr);
-
-	return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
+	BUG_ON(!kobj);
+	BUG_ON(!kobj->sysfs_dir);
+	BUG_ON(!attr);
 
+	return sysfs_add_file(kobj->sysfs_dir, attr, SYSFS_KOBJ_ATTR);
 }
 
 
@@ -394,33 +396,38 @@
  */
 int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
 {
-	struct dentry * dir = kobj->dentry;
-	struct dentry * victim;
+	struct sysfs_dir *parent_sd = kobj->sysfs_dir;
+	struct sysfs_dirent *sd;
+	struct dentry * victim = NULL;
 	int res = -ENOENT;
 
-	down(&dir->d_inode->i_sem);
-	victim = sysfs_get_dentry(dir, attr->name);
-	if (!IS_ERR(victim)) {
+	down(&parent_sd->s_child_sem);
+
+	sd = sysfs_find_element(parent_sd, SYSFS_KOBJ_ATTR, attr);
+
+	if (sd)
+		victim = dget(sd->s_dentry);
+
+	up(&parent_sd->s_child_sem);
+
+	if (victim) {
+#if 0
 		/* make sure dentry is really there */
+		/* AJR FIXME.  Is this test really necessary? */
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
 			dnotify_parent(victim, DN_MODIFY);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
 			res = 0;
 		} else
 			d_drop(victim);
-		
-		/**
-		 * Drop the reference acquired from sysfs_get_dentry() above.
-		 */
+#else
+		victim->d_inode->i_mtime = CURRENT_TIME;
+		dnotify_parent(victim, DN_MODIFY);
+#endif
+
 		dput(victim);
 	}
-	up(&dir->d_inode->i_sem);
 
 	return res;
 }
@@ -436,7 +443,7 @@
 
 void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->name);
+	sysfs_hash_and_remove(kobj->sysfs_dir,attr->name);
 }
 
 
diff -u linux/fs/sysfs.old2/group.c linux/fs/sysfs/group.c
--- linux/fs/sysfs.old2/group.c	2004-12-02 14:51:01.000000000 +0800
+++ linux/fs/sysfs/group.c	2004-12-09 14:14:00.000000000 +0800
@@ -15,7 +15,7 @@
 #include "sysfs.h"
 
 
-static void remove_files(struct dentry * dir, 
+static void remove_files(struct sysfs_dir * dir, 
 			 const struct attribute_group * grp)
 {
 	struct attribute *const* attr;
@@ -24,7 +24,7 @@
 		sysfs_hash_and_remove(dir,(*attr)->name);
 }
 
-static int create_files(struct dentry * dir,
+static int create_files(struct sysfs_dir * dir,
 			const struct attribute_group * grp)
 {
 	struct attribute *const* attr;
@@ -42,41 +42,54 @@
 int sysfs_create_group(struct kobject * kobj, 
 		       const struct attribute_group * grp)
 {
-	struct dentry * dir;
+	struct sysfs_dir * dir;
 	int error;
 
-	BUG_ON(!kobj || !kobj->dentry);
+	BUG_ON(!kobj);
+	BUG_ON(!kobj->sysfs_dir);
 
 	if (grp->name) {
 		error = sysfs_create_subdir(kobj, grp, &dir);
 		if (error)
 			return error;
 	} else
-		dir = kobj->dentry;
-	dir = dget(dir);
+		dir = kobj->sysfs_dir;
 	if ((error = create_files(dir,grp))) {
 		if (grp->name)
-			sysfs_remove_subdir(dir);
+			sysfs_remove_subdir(kobj, dir);
 	}
-	dput(dir);
 	return error;
 }
 
+static inline struct sysfs_dir *
+find_group_dir(struct sysfs_dir *parent_sd,
+	       const struct attribute_group *group)
+{
+	struct sysfs_dirent *group_ent;
+
+	down(&parent_sd->s_child_sem);
+
+	group_ent = sysfs_find_element(parent_sd, SYSFS_ATTR_GROUP, group);
+	BUG_ON(group_ent == NULL);
+
+	up(&parent_sd->s_child_sem);
+	return to_sysfs_dir(group_ent);
+}
+
 void sysfs_remove_group(struct kobject * kobj, 
-			const struct attribute_group * grp)
+			const struct attribute_group * group)
 {
-	struct dentry * dir;
+	struct sysfs_dir *kobj_sdir = kobj->sysfs_dir;
+	struct sysfs_dir *group_sdir;
 
-	if (grp->name)
-		dir = sysfs_get_dentry(kobj->dentry,grp->name);
+	if (group->name)
+		group_sdir = find_group_dir(kobj_sdir, group);
 	else
-		dir = dget(kobj->dentry);
+		group_sdir = kobj_sdir;
 
-	remove_files(dir,grp);
-	if (grp->name)
-		sysfs_remove_subdir(dir);
-	/* release the ref. taken in this routine */
-	dput(dir);
+	remove_files(group_sdir, group);
+	if (group->name)
+		sysfs_remove_subdir(kobj, group_sdir);
 }
 
 
diff -u linux/fs/sysfs.old2/inode.c linux/fs/sysfs/inode.c
--- linux/fs/sysfs.old2/inode.c	2004-12-09 13:14:21.000000000 +0800
+++ linux/fs/sysfs/inode.c	2004-12-09 13:39:52.000000000 +0800
@@ -35,7 +35,9 @@
 		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime =
+			inode->i_mtime =
+			inode->i_ctime = CURRENT_TIME;
 		inode->i_mapping->a_ops = &sysfs_aops;
 		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
 	}
@@ -66,20 +68,37 @@
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error) {
+	if (!error)
 		d_instantiate(dentry, inode);
-		if (S_ISDIR(mode))
-			dget(dentry);  /* pin only directory dentry in core */
-	} else
+	else
 		iput(inode);
  Done:
 	return error;
 }
 
+/* Caller holds parent_sd->s_child_sem */
+struct sysfs_dirent * sysfs_find_element(struct sysfs_dir *parent_sd,
+					 int type,
+					 const void *element)
+{
+	struct sysfs_dirent *sd;
+
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type == type && sd->s_element == element)
+			return sd;
+	}
+	
+	return NULL;
+}
+
 struct dentry * sysfs_get_dentry(struct dentry * parent, const char * name)
 {
 	struct qstr qstr;
 
+	ASSERT_SEMAPHORE_HELD(&parent->d_inode->i_sem);
+
 	qstr.name = name;
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name,qstr.len);
@@ -128,40 +147,67 @@
 /*
  * Unhashes the dentry corresponding to given sysfs_dirent
  * Called with parent inode's i_sem held.
+ * dentry must not be NULL.
  */
-void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
+void sysfs_drop_dentry(struct dentry * dentry)
 {
-	struct dentry * dentry = sd->s_dentry;
+	struct dentry *parent = dentry->d_parent;
 
-	if (dentry) {
-		spin_lock(&dcache_lock);
-		if (!(d_unhashed(dentry) && dentry->d_inode)) {
-			dget_locked(dentry);
-			__d_drop(dentry);
-			spin_unlock(&dcache_lock);
-			simple_unlink(parent->d_inode, dentry);
-		} else
-			spin_unlock(&dcache_lock);
-	}
+	ASSERT_SEMAPHORE_HELD(&parent->d_inode->i_sem);
+
+	spin_lock(&dcache_lock);
+	if (!(d_unhashed(dentry) && dentry->d_inode)) {
+		dget_locked(dentry);
+		__d_drop(dentry);
+		spin_unlock(&dcache_lock);
+		simple_unlink(parent->d_inode, dentry);
+	} else
+		spin_unlock(&dcache_lock);
 }
 
-void sysfs_hash_and_remove(struct dentry * dir, const char * name)
+void unhook_sysfs_dirent(struct sysfs_dir *parent_sd, struct sysfs_dirent *sd)
 {
+	ASSERT_SEMAPHORE_HELD(&parent_sd->s_child_sem);
+
+	if (sysfs_type_dir(sd->s_type))
+		parent_sd->s_nlink--;
+
+ 	list_del_init(&sd->s_sibling);
+	sysfs_put(sd);
+}
+
+void sysfs_hash_and_remove(struct sysfs_dir *parent_sd, const char * name)
+{
+	struct semaphore *parent_i_sem;
 	struct sysfs_dirent * sd;
-	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dir);
+	struct dentry *dentry = NULL;
 
-	down(&dir->d_inode->i_sem);
-	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element)
-			continue;
-		if (!strcmp(sysfs_get_name(sd), name)) {
-			sysfs_drop_dentry(sd, dir);
-			list_del_init(&sd->s_sibling);
-			sysfs_put(sd);
-			break;
-		}
+	down(&parent_sd->s_child_sem);
+
+	sd = sysfs_find_by_name(parent_sd, name);
+
+	if (sd) {
+		dentry = sysfs_dirent_dget(parent_sd, sd);
+		if (!dentry)
+			unhook_sysfs_dirent(parent_sd, sd);
+	}
+
+	up(&parent_sd->s_child_sem);
+
+	if (dentry) {
+		parent_i_sem = &dentry->d_parent->d_inode->i_sem;
+
+		down(parent_i_sem);
+		down(&parent_sd->s_child_sem);
+
+		unhook_sysfs_dirent(parent_sd, sd);
+		sysfs_drop_dentry(dentry);
+
+		up(&parent_sd->s_child_sem);
+		up(parent_i_sem);
+
+		dput(dentry);
 	}
-	up(&dir->d_inode->i_sem);
 }
 
 struct kobject *sysfs_get_kobject(struct dentry *dentry)
diff -u linux/fs/sysfs.old2/mount.c linux/fs/sysfs/mount.c
--- linux/fs/sysfs.old2/mount.c	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/mount.c	2004-12-06 10:43:28.000000000 +0800
@@ -24,13 +24,15 @@
 	.drop_inode	= generic_delete_inode,
 };
 
-static struct sysfs_dir sysfs_root = {
+struct sysfs_dir sysfs_root = {
 	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_child_sem	= __MUTEX_INITIALIZER(sysfs_root.s_child_sem),
+	.s_nlink	= 2,
 	.s_ent		= {
 		.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_ent.s_sibling),
 		.s_element	= NULL,
 		.s_type		= SYSFS_ROOT,
-	}
+	},
 };
 
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -49,7 +51,7 @@
 		inode->i_op = &sysfs_dir_inode_operations;
 		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;	
+		inode->i_nlink++;
 	} else {
 		pr_debug("sysfs: could not get root inode\n");
 		return -ENOMEM;
@@ -62,6 +64,7 @@
 		return -ENOMEM;
 	}
 	root->d_fsdata = &sysfs_root.s_ent;
+	sysfs_root.s_ent.s_dentry = root;
 	sb->s_root = root;
 	return 0;
 }
diff -u linux/fs/sysfs.old2/symlink.c linux/fs/sysfs/symlink.c
--- linux/fs/sysfs.old2/symlink.c	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/symlink.c	2004-12-07 21:33:42.000000000 +0800
@@ -43,13 +43,13 @@
 	}
 }
 
-static int sysfs_add_link(struct dentry * parent, char * name, struct kobject * target)
+static int sysfs_add_link(struct sysfs_dir *parent_sd,
+			  char * name,
+			  struct kobject * target)
 {
-	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(parent);
 	struct sysfs_symlink * sl;
-	int error = 0;
+	int error = -ENOMEM;
 
-	error = -ENOMEM;
 	sl = kmalloc(sizeof(*sl), GFP_KERNEL);
 	if (!sl)
 		goto exit1;
@@ -61,8 +61,14 @@
 	strcpy(sl->link_name, name);
 	sl->target_kobj = kobject_get(target);
 
-	error = sysfs_make_dirent(parent_sd, NULL, sl, S_IFLNK|S_IRWXUGO,
-				SYSFS_KOBJ_LINK);
+	down(&parent_sd->s_child_sem);
+
+	if (sysfs_make_dirent(parent_sd, sl, S_IFLNK|S_IRWXUGO,
+			      SYSFS_KOBJ_LINK) != NULL)
+		error = 0;
+
+	up(&parent_sd->s_child_sem);
+
 	if (!error)
 		return 0;
 
@@ -81,15 +87,16 @@
  */
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
-	struct dentry * dentry = kobj->dentry;
-	int error = 0;
+	struct sysfs_dir *sdir;
 
-	BUG_ON(!kobj || !kobj->dentry || !name);
+	BUG_ON(!kobj);
+	BUG_ON(!name);
 
-	down(&dentry->d_inode->i_sem);
-	error = sysfs_add_link(dentry, name, target);
-	up(&dentry->d_inode->i_sem);
-	return error;
+	sdir = kobj->sysfs_dir;
+
+	BUG_ON(!sdir);
+
+	return sysfs_add_link(sdir, name, target);
 }
 
 
@@ -101,7 +108,7 @@
 
 void sysfs_remove_link(struct kobject * kobj, char * name)
 {
-	sysfs_hash_and_remove(kobj->dentry,name);
+	sysfs_hash_and_remove(kobj->sysfs_dir, name);
 }
 
 static int sysfs_get_target_path(struct kobject * kobj, struct kobject * target,
diff -u linux/fs/sysfs.old2/sysfs.h linux/fs/sysfs/sysfs.h
--- linux/fs/sysfs.old2/sysfs.h	2004-12-09 13:09:40.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-09 14:13:50.000000000 +0800
@@ -1,5 +1,6 @@
 #include <linux/time.h>
 #include <linux/sysfs.h>
+#include <linux/time.h>
 
 #define SYSFS_CURSOR		0
 #define SYSFS_ROOT		0x0001
@@ -8,7 +9,7 @@
 #define SYSFS_KOBJ_BIN_ATTR	0x0008
 #define SYSFS_ATTR_GROUP	0x0010
 #define SYSFS_KOBJ_LINK 	0x0020
-#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+#define SYSFS_NOT_PINNED	(SYSFS_DIR | SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_ATTR_GROUP | SYSFS_KOBJ_LINK)
 
 struct sysfs_dirent {
 	struct list_head	s_sibling;
@@ -18,30 +19,110 @@
 	struct dentry		* s_dentry;
 };
 
+/* Notes on synchronization.
+
+   About sysfs_dir.s_child_sem.
+
+   sysfs_dir.s_child_sem in a directory protects
+   	1. sysfs_dir.s_children in the directory
+   	2. sysfs_dir.s_{nlink,mtime,ctime} in the directory
+   	3. sysfs_dirent.s_sibling in all children
+	4. sysfs_dirent.s_dentry in all children
+
+   Nesting rule for sysfs_dir.s_child_sem and dir_inode->i_sem:
+
+   If dir_inode->i_sem is to be held, it should be taken before
+   sysfs_dir.s_child_sem is taken.  This ordering is because many VFS
+   routines are called with dir_inode->i_sem already held.  If you
+   need to do it in the reverse order, you can usually use the following
+   trick:
+   	down(&sysfs_dir->s_child_sem);
+	dentry = ent->s_dentry;
+	if (dentry)
+		dget(dentry);
+	up(&sysfs_dir->s_child_sem);
+	// If some other operation was holding i_sem and waiting on
+	// s_child_sem, the following line will cause us to wait for it
+	// to copmlete.
+	down(&dentry->d_inode->i_sem);
+	down(&sysfs_dor->s_child_sem);
+	//...do something useful... 
+	up(&sysfs_dor->s_child_sem);
+	up(&dentry->d_inode->i_sem);
+
+   Note that there is no requirement to hold dir_inode->i_sem just because
+   you are going to hold sysfs_dir.s_child_sem, especially considering that
+   the dir_inode might not even exist.  It's just that you can't take
+   dir_inode->i_sem if you are already holding sysfs_dir.s_child_sem.
+
+   Why is sysfs_dir.s_child_sem just a plain semaphore?  Why not an
+   rw_semaphore, so that sysfs_lookup and sysfs_readdir could just take
+   a shared lock?  Unfortunately, vfs calls the lookup code with
+   parent_dir->i_sem held, and sysfs_readdir really does modify to
+   the s_children list by moving its own "cursor" element through
+   the chain.  So, there currently would be no benefit.
+
+   WARNING: Do not call dput(dentry) while holding the parent directory's
+   sysfs_dir->s_child_sem.  This is because the dput can call
+   sysfs_d_iput, which will try to take sysfs_dir->s_child_sem.
+   Instead, call dput after s_child_sem has been released.
+
+
+   About sysfs_dirent.s_dentry:
+	Writers: sysfs_lookup, sysfs_d_iput.
+   	Readers: sysfs_readdir, sysfs_put.
+
+   The only purposes of sysfs_dirent.s_dentry is to allow readdir
+   to pass accurate inode numbers for nodes that happen to to be in
+   and to act as a flag to indicate whether there is a corresponding
+   dentry currently pointing back to the sysfs_dirent.  Perhaps, in
+   the future, sysfs_dirent.s_dentry could be deleted.
+
+   Why is sysfs_dirent.s_dentry protected by the parent directory's
+   sysfs_dir.s_child_sem?  Why isn't it just protected by
+   parent_inode->i_sem?  Because sysfs_put can be called by
+   sysfs_remove_{dir,file,link,bin_file,group} at times when there
+   might not even be a struct inode corresponding the object.
+
+*/
 struct sysfs_dir {
+	struct semaphore	s_child_sem;
 	struct list_head	s_children;
+	struct timespec		s_mtime;
+	struct timespec		s_ctime;
+	unsigned int		s_nlink;
 	struct sysfs_dirent	s_ent;
 };
 
 extern struct vfsmount * sysfs_mount;
 extern kmem_cache_t *sysfs_dir_cachep;
 extern kmem_cache_t *sysfs_dirent_cachep;
+extern struct sysfs_dir sysfs_root;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
-extern int sysfs_make_dirent(struct sysfs_dir *, struct dentry *, void *,
-				umode_t, int);
+struct sysfs_dirent *sysfs_make_dirent(struct sysfs_dir * parent_sd,
+				       void * element, umode_t mode, int type);
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
-extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern struct sysfs_dirent * sysfs_find_element(struct sysfs_dir *parent_sd,
+						int type, const void *element);
+
+extern struct sysfs_dirent *sysfs_find_by_name(struct sysfs_dir *parent_sd,
+					       const char *name);
 
-extern int sysfs_create_subdir(struct kobject *, const struct attribute_group *, struct dentry **);
-extern void sysfs_remove_subdir(struct dentry *);
+extern int sysfs_add_file(struct sysfs_dir *, const struct attribute *, int);
+extern void unhook_sysfs_dirent(struct sysfs_dir *parent_sd,
+				struct sysfs_dirent *sd);
+extern void sysfs_hash_and_remove(struct sysfs_dir *parent, const char * name);
+
+extern int sysfs_create_subdir(struct kobject *, const struct attribute_group *, struct sysfs_dir **);
+extern void sysfs_remove_subdir(struct kobject *parent,
+				struct sysfs_dir * d);
 
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
-extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
+void sysfs_drop_dentry(struct dentry * dentry);
 
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
@@ -50,6 +131,8 @@
 extern struct file_operations bin_fops;
 extern struct inode_operations sysfs_dir_inode_operations;
 extern struct inode_operations sysfs_symlink_inode_operations;
+struct dentry *sysfs_dirent_dget(struct sysfs_dir *parent,
+				 struct sysfs_dirent *sd);
 
 struct sysfs_symlink {
 	char * link_name;
@@ -106,3 +189,9 @@
 	if (list_empty(&sd->s_sibling) && sd->s_dentry == NULL)
 		release_sysfs_dirent(sd);
 }
+
+#ifdef SYSFS_DEBUG_SEMAPHORES
+# define ASSERT_SEMAPHORE_HELD(sem) 	BUG_ON(down_trylock(sem) == 0)
+#else
+# define ASSERT_SEMAPHORE_HELD(sem) 	do { } while(0)
+#endif
