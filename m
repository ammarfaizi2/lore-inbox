Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJFJGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTJFJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:06:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48369 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263370AbTJFJCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:02:53 -0400
Date: Mon, 6 Oct 2003 14:33:11 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 6/6] sysfs-dir.patch
Message-ID: <20031006090311.GK4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com> <20031006090107.GH4220@in.ibm.com> <20031006090139.GI4220@in.ibm.com> <20031006090214.GJ4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090214.GJ4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This is the main part of the sysfs backing store patch set. It provides the
  lookup routine, open and release routines for sysfs directories. As we don't
  create sysfs entires in sysfs_create_xxxx() calls, we create the dentries 
  when we actually look for them in sysfs_lookup and sysfs_open_dir. We parse
  the kobject hierachy for the required object and if found we go ahead and 
  create the sysfs file or directory for it.


 fs/sysfs/dir.c        |  442 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/sysfs/inode.c      |   65 ++++++-
 fs/sysfs/sysfs.h      |   17 +
 include/linux/sysfs.h |    1 
 4 files changed, 475 insertions(+), 50 deletions(-)

diff -puN fs/sysfs/inode.c~sysfs-dir fs/sysfs/inode.c
--- linux-2.6.0-test6/fs/sysfs/inode.c~sysfs-dir	2003-10-06 12:15:07.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/inode.c	2003-10-06 12:15:07.000000000 +0530
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include "sysfs.h"
+
 extern struct super_block * sysfs_sb;
 
 static struct address_space_operations sysfs_aops = {
@@ -59,10 +61,9 @@ int sysfs_create(struct dentry * dentry,
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error) {
-		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
-	} else
+	if (!error) 
+		d_add(dentry, inode);
+	else
 		iput(inode);
  Done:
 	return error;
@@ -73,6 +74,22 @@ int sysfs_mknod(struct inode *dir, struc
 	return sysfs_create(dentry, mode, NULL);
 }
 
+struct dentry * sysfs_get_new_dentry(struct dentry * parent, const char * name)
+{
+	struct qstr qstr;
+	struct dentry * dentry;
+	
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name,qstr.len);
+	
+	dentry = d_alloc(parent, &qstr);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
+	return dentry;
+}
+
 struct dentry * sysfs_get_dentry(struct dentry * parent, const char * name)
 {
 	struct qstr qstr;
@@ -87,6 +104,9 @@ void sysfs_hash_and_remove(struct dentry
 {
 	struct dentry * victim;
 
+	if (!dir)
+		return;
+
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir,name);
 	if (!IS_ERR(victim)) {
@@ -107,4 +127,41 @@ void sysfs_hash_and_remove(struct dentry
 	up(&dir->d_inode->i_sem);
 }
 
+/* called under down_read(k_rwsem)
+ */
+int sysfs_get_link_count(struct dentry * dentry)
+{
+	int count = 1; /* all directory link count starts with 2 */
+	struct kobject * k, * kobj;
+	struct kobject_attr * k_attr;
+	struct kobject_attr_group *k_attr_grp;
+
+	if (!dentry) {
+		struct subsystem * s;
+		list_for_each_entry(s, &kobj_subsystem_list, next)
+			count++;
+		return count;
+	}
+	kobj = dentry->d_fsdata;
+	if (dentry->d_parent->d_fsdata == kobj) {
+		struct attribute_group * grp;
+		struct attribute **attr;
+
+		list_for_each_entry(k_attr_grp, &kobj->attr_group, list) {
+			if (!strcmp(k_attr_grp->attr_group->name, dentry->d_name.name)) 
+			break;
+		}
+		grp = k_attr_grp->attr_group;
+		for (attr = grp->attrs; *attr ; attr++) 
+			count++;
+		return count;
+	}
+	list_for_each_entry(k, &kobj->k_children, k_sibling)
+		count++;
+	list_for_each_entry(k_attr, &kobj->attr, list)
+		count++;
+	list_for_each_entry(k_attr_grp, &kobj->attr_group, list)
+		count++;
 
+	return count;
+}
diff -puN fs/sysfs/dir.c~sysfs-dir fs/sysfs/dir.c
--- linux-2.6.0-test6/fs/sysfs/dir.c~sysfs-dir	2003-10-06 12:15:07.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/dir.c	2003-10-06 12:15:22.000000000 +0530
@@ -8,47 +8,342 @@
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/kobject.h>
+#include <linux/namei.h>
 #include "sysfs.h"
 
+struct inode_operations sysfs_dir_inode_operations = {
+	.lookup		= sysfs_lookup,
+};
+
+struct file_operations sysfs_dir_operations = {
+	.open		= sysfs_dir_open,
+	.release	= sysfs_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= dcache_readdir,
+};
+
 static int init_dir(struct inode * inode)
 {
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_op = &sysfs_dir_inode_operations;
+	inode->i_fop = &sysfs_dir_operations;
 
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
 	return 0;
 }
 
 
-static int create_dir(struct kobject * k, struct dentry * p,
-		      const char * n, struct dentry ** d)
+static struct dentry * __create_dir(struct kobject * k, struct dentry * dentry)
 {
 	int error;
+       
+	error = sysfs_create(dentry, S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
+				 init_dir);
+	if (!error) {
+		dentry->d_fsdata = k;
+		dentry->d_inode->i_nlink += sysfs_get_link_count(dentry);
+		return dentry;
+	}
+	dput(dentry);
+
+	return ERR_PTR(error);;
+}
+
+int kobject_dentry_exist(struct dentry * parent, const char * name)
+{
+	struct list_head * next;
+
+	if (!name)
+		return 1;
+
+	spin_lock(&dcache_lock);
+	next = parent->d_subdirs.next;
+	while (next != &parent->d_subdirs) {
+		struct dentry * d = list_entry(next, struct dentry, d_child);
+		if (!strcmp(d->d_name.name, name)) {
+			dget_locked(d);
+			spin_unlock(&dcache_lock);
+			return 1;
+		}
+		next = next->next;
+	}
+	spin_unlock(&dcache_lock);
 
-	down(&p->d_inode->i_sem);
-	*d = sysfs_get_dentry(p,n);
-	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d,
-					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
-					 init_dir);
-		if (!error) {
-			(*d)->d_fsdata = k;
-			p->d_inode->i_nlink++;
-		}
-		dput(*d);
-	} else
-		error = PTR_ERR(*d);
-	up(&p->d_inode->i_sem);
-	return error;
+	return 0;
+	
 }
 
+static inline struct dentry * 
+create_one_kobject_dir(struct kobject *k, struct dentry * dentry)
+{
+	struct dentry * new = NULL;
+	int err = 0;
+
+	if (k->k_symlink) {
+		err = sysfs_symlink(dentry->d_parent->d_inode, dentry, 
+					k->k_symlink);
+		new = dentry;
+		if (err)
+			new = ERR_PTR(err);
+	} else {
+		new =  __create_dir(k, dentry);
+		if (!IS_ERR(new))
+			k->dentry = dentry;
+	}
+
+	return new;
+}
+
+static int create_kobject_dir(struct kobject * kobj, struct dentry * dentry)
+{
+	struct kobject * k;
+	const char * name;
+	struct dentry * p = kobj->dentry;
+	struct dentry * new = NULL;
+	int err = 0;
+
+	list_for_each_entry(k, &kobj->k_children, k_sibling) {
+		name = kobject_name(k);
+		if (dentry) {
+                	if (!strcmp(name, dentry->d_name.name)) {
+				new = create_one_kobject_dir(k, dentry);
+				break;
+			}
+		} else if (!(kobject_dentry_exist(p, name))) {
+				new = sysfs_get_new_dentry(p, name);
+				if (!IS_ERR(new))
+					new = create_one_kobject_dir(k, new);
+				if (IS_ERR(new))
+					break;
+			}
+	}
+	if (!new)
+		return -ENOENT;
+
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+
+	return err;
+}
+
+static int create_attr_group(struct kobject *kobj, struct dentry * dentry)
+{
+	struct kobject_attr_group * grp;
+	struct dentry * p = kobj->dentry;
+        struct dentry * new = NULL;
+	int err = 0;
+
+	list_for_each_entry(grp, &kobj->attr_group, list) {
+		if (dentry) {
+			const char * name = dentry->d_name.name;
+			if (!strcmp(grp->attr_group->name, name)) {
+				new =  __create_dir(kobj, dentry);
+				break;
+			}
+		} else if (!kobject_dentry_exist(p, grp->attr_group->name)) {
+			new = sysfs_get_new_dentry(p, grp->attr_group->name);
+			if (!IS_ERR(new)) 
+				new = __create_dir(kobj, new);
+			else
+				break;
+		}
+	}	
+	if (!new)
+		return -ENOENT;
+
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+	return err;
+}
+
+static inline struct dentry *
+create_one_attr_file(struct kobject_attr * k_attr, struct dentry * dentry)
+{
+	const struct attribute * attr = NULL;
+	int (* init) (struct inode *) = NULL;
+	int err = 0;
+
+	attr = kobject_attr(k_attr);
+
+	if (k_attr->flags & KOBJ_TEXT_ATTR) 
+		init = sysfs_init_file;
+	
+	err = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	if (err)
+		return ERR_PTR(err);
+
+	if (k_attr->flags & KOBJ_TEXT_ATTR) 
+		dentry->d_fsdata = (void *) attr;
+	else {
+		dentry->d_fsdata = (void *)k_attr->attr_u.bin_attr;
+		dentry->d_inode->i_size = k_attr->attr_u.bin_attr->size;
+		dentry->d_inode->i_fop = &bin_fops;
+	}
+	return dentry;
+}
+
+static int create_attr_file(struct kobject * kobj, struct dentry * dentry)
+{
+	struct kobject_attr * k_attr;
+	struct dentry * p = kobj->dentry;
+        struct dentry *new = NULL;
+	int err = 0;
+
+	list_for_each_entry(k_attr, &kobj->attr, list) {
+		char * name = kobject_attr(k_attr)->name;
+		if (dentry) {
+			if (!strcmp(name, dentry->d_name.name)) {
+				new = create_one_attr_file(k_attr, dentry);
+				break;
+			}	
+		} else if (!kobject_dentry_exist(p, name)) {
+			new = sysfs_get_new_dentry(p, name);
+			if (!IS_ERR(new))
+				new = create_one_attr_file(k_attr, new);
+			if (IS_ERR(new))
+				break;
+		}
+	}
+	if (!new)
+		return -ENOENT;
+
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+	return err;
+}
+
+static int create_attr_group_files(struct kobject * kobj, 
+					struct dentry * dentry, int all)
+{
+	struct dentry * new = NULL;
+	struct dentry * parent = (all) ? dentry : dentry->d_parent;
+	struct attribute *const* attr;
+	const struct attribute_group * grp = NULL;
+	struct kobject_attr_group * k_attr_grp;
+	struct kobject_attr k_attr;
+	int err = 0;
+
+	list_for_each_entry(k_attr_grp, &kobj->attr_group, list) {
+		if (!strcmp(k_attr_grp->attr_group->name, parent->d_name.name)) 
+			break;
+	}
+
+	grp = k_attr_grp->attr_group;
+	if (!grp)
+		return -ENOENT;
+
+	for (attr = grp->attrs; *attr && !err; attr++) {
+		k_attr.attr_u.attr = *attr,
+		k_attr.flags = KOBJ_TEXT_ATTR;
+		if (!all) {
+			if (!strcmp((*attr)->name, dentry->d_name.name)) {
+				new = create_one_attr_file(&k_attr, dentry);
+				break;
+			}
+		} else if (!kobject_dentry_exist(parent, (*attr)->name)) {
+			new = sysfs_get_new_dentry(parent, (*attr)->name);
+			if (!IS_ERR(new)) 
+				new = create_one_attr_file(&k_attr, new);
+			if (IS_ERR(new))
+				break;
+		}
+	}
+	if (!new)
+		return -ENOENT;
+
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+	return err;
+}
 
-int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
+static int create_subsystem_dir(struct dentry * dentry)
 {
-	return create_dir(k,k->dentry,n,d);
+	struct subsystem * s;
+	struct kobject * k;
+	struct dentry * p = sysfs_mount->mnt_root;
+	struct dentry * new = NULL;
+	const char * name = NULL;
+	int err = 0;
+	
+	spin_lock(&kobj_subsystem_lock);
+	list_for_each_entry(s, &kobj_subsystem_list, next) {
+		k = &s->kset.kobj;
+		if (dentry) {
+			name = dentry->d_name.name;
+			if (!strcmp(kobject_name(k), name)) { 
+				spin_unlock(&kobj_subsystem_lock);
+				new = __create_dir(k, dentry);
+				spin_lock(&kobj_subsystem_lock);
+				if (!IS_ERR(new)) 
+					k->dentry = dentry;
+				break;
+			}
+		} else {
+			name = kobject_name(k);
+			if (!kobject_dentry_exist(p, name) && !(k->parent)) {
+				spin_unlock(&kobj_subsystem_lock);
+				new = sysfs_get_new_dentry(p, kobject_name(k));
+				if (!IS_ERR(new)) {
+					new = __create_dir(k, new);
+					if (!IS_ERR(new))
+						k->dentry = new;
+				}
+				spin_lock(&kobj_subsystem_lock);
+				if (IS_ERR(new))
+					break;
+			}
+		}
+	}
+	spin_unlock(&kobj_subsystem_lock);
+	if (!new)
+		return -ENOENT;
+
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+	return err;
 }
 
+struct dentry *sysfs_lookup(struct inode *dir, struct dentry *dentry, 
+				struct nameidata *nd)
+{
+	struct dentry * parent = dentry->d_parent;
+	struct kobject *parent_kobj = NULL;
+	int err = 0;
+	
+	if (parent == sysfs_mount->mnt_root) {
+		err = create_subsystem_dir(dentry);
+		goto exit;
+	}
+
+	parent_kobj = kobject_get(parent->d_fsdata);
+	down_read(&parent_kobj->k_rwsem);
+
+	err = create_kobject_dir(parent_kobj, dentry);
+	if (err != -ENOENT)
+		goto exit_unlock;
+
+	err = create_attr_file(parent_kobj, dentry);
+	if (err != -ENOENT)
+		goto exit_unlock;
+
+	err = create_attr_group(parent_kobj, dentry);
+	if (err != -ENOENT)
+		goto exit_unlock;
+
+	if (parent->d_fsdata == parent->d_parent->d_fsdata) 
+		err = create_attr_group_files(parent_kobj, dentry, 0);
+
+exit_unlock:
+	up_read(&parent_kobj->k_rwsem);
+	kobject_put(parent_kobj);
+exit:
+	if (err == -ENOENT) {
+		d_add(dentry, NULL);
+		err = 0;
+	}
+
+	return ERR_PTR(err);
+  }
+
 /**
  *	sysfs_create_dir - create a directory for an object.
  *	@parent:	parent parent object.
@@ -57,24 +352,10 @@ int sysfs_create_subdir(struct kobject *
 
 int sysfs_create_dir(struct kobject * kobj)
 {
-	struct dentry * dentry = NULL;
-	struct dentry * parent;
-	int error = 0;
-
 	if (!kobj)
 		return -EINVAL;
 
-	if (kobj->parent)
-		parent = kobj->parent->dentry;
-	else if (sysfs_mount && sysfs_mount->mnt_sb)
-		parent = sysfs_mount->mnt_sb->s_root;
-	else
-		return -EFAULT;
-
-	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
-	if (!error)
-		kobj->dentry = dentry;
-	return error;
+	return 0;
 }
 
 
@@ -133,7 +414,6 @@ void sysfs_remove_dir(struct kobject * k
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
-			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			spin_lock(&dcache_lock);
@@ -162,14 +442,86 @@ void sysfs_rename_dir(struct kobject * k
 	if (!kobj->parent)
 		return;
 
-	parent = kobj->parent->dentry;
+	kobject_set_name(kobj,new_name);
+	if (sysfs_mount) {
+		parent = kobj->parent->dentry;
+		down(&parent->d_inode->i_sem);
+		new_dentry = sysfs_get_dentry(parent, new_name);
+		d_move(kobj->dentry, new_dentry);
+		up(&parent->d_inode->i_sem);	
+	}
+}
 
-	down(&parent->d_inode->i_sem);
 
-	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
-	up(&parent->d_inode->i_sem);	
+
+int sysfs_open_dir_entries(struct dentry * parent)
+{
+	struct kobject * kobj;
+	int err = 0;
+	
+	if (parent == sysfs_mount->mnt_root) 
+		return create_subsystem_dir(NULL);
+
+	kobj = kobject_get(parent->d_fsdata);
+	down_read(&kobj->k_rwsem);
+
+	if (parent->d_fsdata == parent->d_parent->d_fsdata) {
+		err = create_attr_group_files(kobj, parent, 1);
+		goto exit_unlock;
+	}
+
+	err = create_kobject_dir(kobj, NULL);
+	if (err && (err != -ENOENT))
+		goto exit_unlock;
+
+	err = create_attr_file(kobj, NULL);
+	if (err && (err != -ENOENT))
+		goto exit_unlock;
+
+	err = create_attr_group(kobj, NULL);
+
+exit_unlock:
+	up_read(&kobj->k_rwsem);
+	kobject_put(kobj);
+	
+	return err;
+}
+
+
+int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+	static struct qstr cursor_name = {.len = 1, .name = "."};
+	int err = 0;
+
+	err = sysfs_open_dir_entries(file->f_dentry);
+	if (err && (err != -ENOENT)) {
+		printk("err opening dir %s %d\n", file->f_dentry->d_name.name, err);
+		return err;
+	}
+
+	file->private_data = d_alloc(file->f_dentry, &cursor_name);
+
+	return file->private_data ? 0 : -ENOMEM;
+}
+
+int sysfs_dir_close(struct inode *inode, struct file *file)
+{
+	struct list_head * tmp;
+	struct dentry * parent = file->f_dentry;
+
+	spin_lock(&dcache_lock);
+	tmp = parent->d_subdirs.next;
+	while (tmp != &parent->d_subdirs) {
+		struct dentry * d = list_entry(tmp, struct dentry, d_child);
+
+		tmp = tmp->next;
+		spin_unlock(&dcache_lock);
+		dput(d);
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
+	dput(file->private_data);
+	return 0;
 }
 
 EXPORT_SYMBOL(sysfs_create_dir);
diff -puN fs/sysfs/sysfs.h~sysfs-dir fs/sysfs/sysfs.h
--- linux-2.6.0-test6/fs/sysfs/sysfs.h~sysfs-dir	2003-10-06 12:15:07.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/sysfs.h	2003-10-06 12:15:07.000000000 +0530
@@ -1,3 +1,4 @@
+#include <linux/fs.h>
 
 extern struct vfsmount * sysfs_mount;
 
@@ -5,9 +6,23 @@ extern struct inode * sysfs_new_inode(mo
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
+extern struct dentry * sysfs_get_new_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+extern int sysfs_get_link_count(struct dentry * dentry);
+
+extern int sysfs_init_file(struct inode * inode);
+extern int sysfs_symlink(struct inode *, struct dentry *, const char * );
+
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct file_operations sysfs_dir_operations;
+extern struct dentry_operations sysfs_dentry_operations;
+extern struct file_operations bin_fops;
+
+struct dentry * sysfs_lookup(struct inode *, struct dentry *, struct nameidata *);
+int sysfs_dir_open(struct inode *inode, struct file *file);
+int sysfs_dir_close(struct inode *inode, struct file *file);
+void sysfs_d_iput(struct dentry *, struct inode *);
diff -puN include/linux/sysfs.h~sysfs-dir include/linux/sysfs.h
--- linux-2.6.0-test6/include/linux/sysfs.h~sysfs-dir	2003-10-06 12:15:07.000000000 +0530
+++ linux-2.6.0-test6-maneesh/include/linux/sysfs.h	2003-10-06 12:15:07.000000000 +0530
@@ -57,6 +57,7 @@ sysfs_create_link(struct kobject * kobj,
 extern void
 sysfs_remove_link(struct kobject *, char * name);
 
+extern struct vfsmount * sysfs_mount;
 
 struct attribute_group {
 	char			* name;

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
