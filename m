Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTKLM2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKLM1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:27:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:32926 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261925AbTKLM0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:26:52 -0500
Date: Wed, 12 Nov 2003 17:55:29 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 2/5] sysfs-dir.patch
Message-ID: <20031112122529.GF14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <20031112122503.GE14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122503.GE14580@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This is the main part of the sysfs backing store patch set. It provides the
  lookup routine, and open, release, readdir, lseek routines for sysfs 
  directories. As we don't create sysfs entires in sysfs_create_xxxx() calls, 
  we create the dentries  when we actually look for them in sysfs_lookup and 
  We parse the kobject hierachy for the required object and if found and not
  already created we go ahead and create the sysfs entry for it.


 fs/sysfs/dir.c |  396 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 341 insertions(+), 55 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-dir fs/sysfs/dir.c
--- linux-2.6.0-test9/fs/sysfs/dir.c~sysfs-dir	2003-11-12 16:20:20.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/dir.c	2003-11-12 16:20:20.000000000 +0530
@@ -10,84 +10,205 @@
 #include <linux/kobject.h>
 #include "sysfs.h"
 
+struct inode_operations sysfs_dir_inode_operations = {
+	.lookup		= sysfs_lookup,
+};
+
+struct file_operations sysfs_dir_operations = {
+	.open		= sysfs_dir_open,
+	.release	= sysfs_dir_close,
+	.llseek		= sysfs_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= sysfs_readdir,
+};
+
+static void sysfs_d_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	sd->s_dentry = NULL;
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dops = {
+	.d_iput		= sysfs_d_iput,
+};
+
+char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	struct kobject * k;
+	struct attribute * a;
+	struct bin_attribute * bin_attr;
+	struct attribute_group * grp;
+        char ** link_names;
+                                                                                
+	if (!sd || !sd->s_element) {
+		return NULL;
+	}
+
+	switch(sd->s_type) {
+		case SYSFS_KOBJECT:	
+				k = (struct kobject *) sd->s_element;
+				return kobject_name(k);
+
+		case SYSFS_KOBJ_ATTR:
+				a = (struct attribute *) sd->s_element;
+				return a->name;
+
+		case SYSFS_KOBJ_ATTR_GROUP:
+				grp = (struct attribute_group *) sd->s_element;
+				return grp->name;
+
+                case SYSFS_KOBJ_BIN_ATTR:
+                                bin_attr = (struct bin_attribute *) sd->s_element;
+                                return bin_attr->attr.name;
+		case SYSFS_KOBJ_LINK:
+                                link_names = sd->s_element;
+                                return link_names[0];
+		default:
+				return "/";
+
+	}
+}
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
 
-
-static int create_dir(struct kobject * k, struct dentry * p,
-		      const char * n, struct dentry ** d)
+static int create_dir(struct sysfs_dirent * sd, struct dentry * dentry)
 {
 	int error;
+       
+	error = sysfs_create(dentry, S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
+				 init_dir);
+	if (!error) {
+		dentry->d_inode->i_nlink += sysfs_get_link_count(sd);
+		return 0;
+	}
+	dput(dentry);
 
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
 	return error;
 }
 
+static  int create_attr_file(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	const struct attribute * attr = NULL;
+	struct bin_attribute * bin_attr = NULL;
+	int (* init) (struct inode *) = NULL;
+	int err = 0;
+
+	if (sd->s_type == SYSFS_KOBJ_ATTR) {
+		attr = sd->s_element;
+		init = sysfs_init_file;
+	} else {
+		bin_attr = sd->s_element;
+		attr = &bin_attr->attr;
+	}
+	
+	err = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	if (err)
+		return err;
+
+	if (sd->s_type == SYSFS_KOBJ_BIN_ATTR) {
+		dentry->d_inode->i_size = bin_attr->size;
+		dentry->d_inode->i_fop = &bin_fops;
+	}
 
-int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
+	return 0;
+}
+
+static int sysfs_create_dirent(struct sysfs_dirent * sd, struct dentry * dentry)
 {
-	return create_dir(k,k->dentry,n,d);
+	int err = 0;
+        char ** link_names;
+
+	switch(sd->s_type) {
+		case SYSFS_KOBJ_ATTR:
+		case SYSFS_KOBJ_BIN_ATTR:
+			err = create_attr_file(sd, dentry);
+			break;
+                case SYSFS_KOBJ_LINK:
+                        link_names = sd->s_element;
+                        err = sysfs_symlink(dentry->d_parent->d_inode, dentry,
+                                       link_names[1]);
+                        break;
+		default:
+			err = create_dir(sd, dentry);
+	}
+	if (!err) {
+		dentry->d_fsdata = sd;
+		dentry->d_op = &sysfs_dops;
+		sd->s_dentry = dentry;
+	}
+
+	return err;
+}
+
+struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	char * name;
+	int err = -ENOENT;
+
+	down_read(&parent_sd->s_rwsem);
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		name = sysfs_get_name(sd);
+		if (strcmp(name, dentry->d_name.name))
+			continue;
+		err = sysfs_create_dirent(sd, dentry);
+		break;
+	}
+	up_read(&parent_sd->s_rwsem);
+
+	if (err == -ENOENT) {
+		d_add(dentry, NULL);
+		err = 0;
+	}
+
+	return ERR_PTR(err);
 }
 
 /**
  *	sysfs_create_dir - create a directory for an object.
- *	@parent:	parent parent object.
  *	@kobj:		object we're creating directory for. 
  */
-
 int sysfs_create_dir(struct kobject * kobj)
 {
-	struct dentry * dentry = NULL;
-	struct dentry * parent;
-	int error = 0;
+	struct sysfs_dirent * sd; 
+	struct sysfs_dirent * parent_sd;
 
 	if (!kobj)
 		return -EINVAL;
 
-	if (kobj->parent)
-		parent = kobj->parent->dentry;
-	else if (sysfs_mount && sysfs_mount->mnt_sb)
-		parent = sysfs_mount->mnt_sb->s_root;
+	if (kobj->parent) 
+		parent_sd = kobj->parent->s_dirent;
 	else
-		return -EFAULT;
+		parent_sd = &sysfs_root;
 
-	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
-	if (!error)
-		kobj->dentry = dentry;
-	return error;
-}
+	sd = sysfs_alloc_dirent(parent_sd, kobj, SYSFS_KOBJECT);
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
+	kobj->s_dirent = sd;
 
+	return 0;
+}
 
 static void remove_dir(struct dentry * d)
 {
 	struct dentry * parent = dget(d->d_parent);
+
 	down(&parent->d_inode->i_sem);
-	d_delete(d);
+	d_drop(d);
 	simple_rmdir(parent->d_inode,d);
-
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
-
 	up(&parent->d_inode->i_sem);
 	dput(parent);
 }
@@ -110,10 +231,15 @@ void sysfs_remove_subdir(struct dentry *
 void sysfs_remove_dir(struct kobject * kobj)
 {
 	struct list_head * node;
-	struct dentry * dentry = dget(kobj->dentry);
+	struct dentry * dentry = kobj->s_dirent->s_dentry;
+	struct sysfs_dirent * parent_sd;
 
 	if (!dentry)
-		return;
+		goto exit;
+		
+	spin_lock(&dcache_lock);
+	dentry = dget_locked(dentry);
+	spin_unlock(&dcache_lock);
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
@@ -124,7 +250,7 @@ void sysfs_remove_dir(struct kobject * k
 		struct dentry * d = list_entry(node,struct dentry,d_child);
 		list_del_init(node);
 
-		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
+		pr_debug(" o %s (%d):",d->d_name.name,atomic_read(&d->d_count));
 		if (d->d_inode) {
 			d = dget_locked(d);
 			pr_debug("removing");
@@ -132,10 +258,9 @@ void sysfs_remove_dir(struct kobject * k
 			/**
 			 * Unlink and unhash.
 			 */
+			__d_drop(d);
 			spin_unlock(&dcache_lock);
-			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
-			dput(d);
 			spin_lock(&dcache_lock);
 		}
 		pr_debug(" done\n");
@@ -146,10 +271,15 @@ void sysfs_remove_dir(struct kobject * k
 	up(&dentry->d_inode->i_sem);
 
 	remove_dir(dentry);
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
 	dput(dentry);
+
+exit:
+	sysfs_free_children(kobj->s_dirent);
+	if (kobj->parent)
+		parent_sd = kobj->parent->s_dirent;
+	else
+		parent_sd = &sysfs_root;
+	sysfs_free_dirent(parent_sd, kobject_name(kobj));
 }
 
 void sysfs_rename_dir(struct kobject * kobj, const char *new_name)
@@ -162,14 +292,170 @@ void sysfs_rename_dir(struct kobject * k
 	if (!kobj->parent)
 		return;
 
-	parent = kobj->parent->dentry;
+	parent = kobj->parent->s_dirent->s_dentry;
+	if (parent) {
+		spin_lock(&dcache_lock);
+		dget_locked(parent);
+		spin_unlock(&dcache_lock);
+
+		down(&parent->d_inode->i_sem);
+		new_dentry = sysfs_get_dentry(parent, new_name);
+		if (!IS_ERR(new_dentry))
+			d_move(kobj->s_dirent->s_dentry, new_dentry);
+		up(&parent->d_inode->i_sem);	
+		dput(parent);
+	}
+	kobject_set_name(kobj,new_name);
+}
 
-	down(&parent->d_inode->i_sem);
+int sysfs_dir_close(struct inode *inode, struct file *filp)
+{
+	struct dentry * dentry = filp->f_dentry;
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	struct sysfs_dirent * cursor = filp->private_data;
+	
+	down_write(&sd->s_rwsem);
+	list_del(&cursor->s_sibling);
+	kfree(cursor);
+	up_write(&sd->s_rwsem);
+	
+	return 0;
+}
 
-	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
-	up(&parent->d_inode->i_sem);	
+int sysfs_dir_open(struct inode *inode, struct file *filp)
+{
+	struct dentry * parent = filp->f_dentry;
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dirent * cursor;
+
+	down(&inode->i_sem);
+	cursor = sysfs_alloc_dirent(parent_sd, NULL, 0);
+	up(&inode->i_sem);
+	if (IS_ERR(cursor))
+		return PTR_ERR(cursor);
+	filp->private_data = cursor;
+	return 0;
+}
+
+loff_t sysfs_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+	struct dentry * dentry = file->f_dentry;
+
+	down(&dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct list_head *p;
+			struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+			struct sysfs_dirent * cursor = file->private_data;
+			loff_t n = file->f_pos - 2;
+
+			down_write(&parent_sd->s_rwsem);
+			p = parent_sd->s_children.next;
+			while (n && p != &parent_sd->s_children) {
+				struct sysfs_dirent * next_sd;
+				struct dentry *next;
+				char * name;
+				next_sd = list_entry(p, struct sysfs_dirent, s_sibling);
+				if (!next_sd->s_element)
+					continue;
+				name = sysfs_get_name(next_sd);
+				up_write(&parent_sd->s_rwsem);
+				next = sysfs_get_dentry(dentry, name);
+				down_write(&parent_sd->s_rwsem);
+				if (IS_ERR(next))
+					break;
+				if (!d_unhashed(next) && next->d_inode)
+					n--;
+				p = p->next;
+				dput(next);
+			}
+			list_del(&cursor->s_sibling);
+			list_add_tail(&cursor->s_sibling, p);
+			up_write(&parent_sd->s_rwsem);
+		}
+	}
+	up(&dentry->d_inode->i_sem);
+	return offset;
+	return 0;
+}
+
+/* Relationship between i_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct inode *inode)
+{
+	return (inode->i_mode >> 12) & 15;
+}
+
+int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+	struct sysfs_dirent *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->s_sibling;
+	ino_t ino;
+	int i = filp->f_pos;
+	int err = 0;
+
+	switch (i) {
+		case 0:
+			ino = dentry->d_inode->i_ino;
+			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		case 1:
+			ino = parent_ino(dentry);
+			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		default:
+			down_write(&sd->s_rwsem);
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &sd->s_children);
+			}
+			for (p = q->next; p != &sd->s_children; p = p->next) {
+				struct sysfs_dirent *next_sd;
+				struct dentry * next;
+				char * name;
+
+				next_sd = list_entry(p, struct sysfs_dirent, 
+						   s_sibling);
+				if (!next_sd->s_element)
+					continue;
+				name = sysfs_get_name(next_sd);
+				up_write(&sd->s_rwsem);
+				next = sysfs_get_dentry(dentry, name);
+				down_write(&sd->s_rwsem);
+				if (IS_ERR(next))
+					break;
+				if (!next || !next->d_inode)
+					continue;
+				err = filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode));
+				dput(next);
+				if (err < 0) 
+					break;
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
+			}
+			up_write(&sd->s_rwsem);
+	}
+	return 0;
 }
 
 EXPORT_SYMBOL(sysfs_create_dir);

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
