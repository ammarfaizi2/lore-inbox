Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUCVG04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCVG04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:26:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:59580 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261778AbUCVGZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:25:57 -0500
Date: Mon, 22 Mar 2004 12:00:34 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>
Subject: Re: [RFC 2/6] sysfs backing store v0.3
Message-ID: <20040322063034.GC5898@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040318063306.GA27107@in.ibm.com> <20040320175708.GQ11010@waste.org> <20040322062842.GA5898@in.ibm.com> <20040322063012.GB5898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322063012.GB5898@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.3
 o corrected dentry ref counting for sysfs_remove_subdir()

=> changes in version 0.2
 o sysfs_rename_dir() used to call d_move() with unhashed new_dentry causing
   panic in d_move(). Added d_add() call for new_dentry before calling d_move.
 o corrected error checking after sysfs_get_dentry() in
   sysfs_open_dir_entries().

=> changes in version 0.1
 o re-diffed for 2.6.3

=> Changes in last version
 o added support for symlink
 o changed logic for sysfs_remove_dir
 o dir dentries now take a ref on the corresponding kobject so as to have
   kobject alive during the lifetime of the dentry.

=====================================================================
o This patch provides the inode operations ->lookup(), ->readdir() and
  ->llseek() for sysfs directories. 

o while sysfs_create_dir() we attach a sysfs_dirent structure to the d_fsdata
  filed of dentry corresponding to the kobject's direcotry. 

o sysfs_lookup does not hash the dentry and we hash the dentry when we have
  attached the sysfs_dirent to it. This was done to cover up a race when
  we attach a negative dentry and instantiate it before updating the d_fsdata
  field. As after instantiating we can get a successfull lookup for the dentry
  but a NULL d_fsdata field. As a result we do not create negative dentries.

o sysfs_readdir() or sysfs_dir_lseek() will bring in the dentries 
  corresponding to the attribute files if the offset is more than 2. These
  are released when we are done with filldir().

o sysfs_d_iput() releases the ref. to the sysfs_dirent() which was taken at
  the time of dentry allocation.



 fs/sysfs/dir.c |  375 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 333 insertions(+), 42 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-leaves-dir fs/sysfs/dir.c
--- linux-2.6.5-rc2/fs/sysfs/dir.c~sysfs-leaves-dir	2004-03-22 10:50:37.000000000 +0530
+++ linux-2.6.5-rc2-maneesh/fs/sysfs/dir.c	2004-03-22 10:58:47.000000000 +0530
@@ -10,29 +10,151 @@
 #include <linux/kobject.h>
 #include "sysfs.h"
 
+struct inode_operations sysfs_dir_inode_operations = {
+	.lookup		= sysfs_lookup,
+};
+
+struct file_operations sysfs_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.llseek		= sysfs_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= sysfs_readdir,
+};
+
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode) 
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd) {
+		sd->s_dentry = NULL;
+		if ((sd->s_type & SYSFS_KOBJECT) ||
+			(sd->s_type & SYSFS_KOBJ_ATTR_GROUP))
+			kobject_put(sd->s_element);
+		sysfs_put(sd);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput		= sysfs_d_iput,
+};
+
+char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	struct attribute * attr;
+	struct bin_attribute * bin_attr;
+	char ** link_names;
+
+	if (!sd || !sd->s_element)
+		BUG();
+
+	switch (sd->s_type) {
+		case SYSFS_KOBJ_ATTR:
+			attr = sd->s_element;
+			return attr->name;
+
+		case SYSFS_KOBJ_BIN_ATTR:
+			bin_attr = sd->s_element;
+			return bin_attr->attr.name;
+
+		case SYSFS_KOBJ_LINK:
+			link_names = sd->s_element;
+			return link_names[0];
+	}
+	return NULL;
+}
+
+static int init_file(struct inode * inode)
+{
+	inode->i_size = PAGE_SIZE;
+	inode->i_fop = &sysfs_file_operations;
+	return 0;
+}
+
 static int init_dir(struct inode * inode)
 {
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_op = &sysfs_dir_inode_operations;
+	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inode->i_nlink++;
 	return 0;
 }
 
-static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the 
+ * attribute file
+ */
+static int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
 {
-	struct kobject * kobj = dentry->d_fsdata;
+	struct attribute * attr = NULL;
+	struct bin_attribute * bin_attr = NULL;
+        int (* init) (struct inode *) = NULL;
+	int error = 0;
 
-	if (kobj)
-		kobject_put(kobj);
-	iput(inode);
+        if (sd->s_type & SYSFS_KOBJ_BIN_ATTR) {
+                bin_attr = sd->s_element;
+                attr = &bin_attr->attr;
+        } else {
+                attr = sd->s_element;
+                init = init_file;
+        }
+
+	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	if (error)
+		return error;
+
+        if (bin_attr) {
+		dentry->d_inode->i_size = bin_attr->size;
+		dentry->d_inode->i_fop = &bin_fops;
+	}
+	dentry->d_op = &sysfs_dentry_ops;
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
+	d_rehash(dentry);
+
+	return 0;
 }
 
-static struct dentry_operations sysfs_dentry_operations = {
-	.d_iput	= &sysfs_d_iput,
-};
+static int sysfs_attach_link(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	struct inode * dir = dentry->d_parent->d_inode;
+	char ** link_names = sd->s_element;
+	int err = 0;
+
+	err = sysfs_symlink(dir, dentry, link_names[1]);
+	if (!err) {
+		dentry->d_op = &sysfs_dentry_ops;
+		dentry->d_fsdata = sysfs_get(sd);
+		sd->s_dentry = dentry;
+		d_rehash(dentry);
+	}
+	return err;
+}
 
+struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry, 
+				struct nameidata *nd)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			char * name = sysfs_get_name(sd);
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+			if (sd->s_type & SYSFS_KOBJ_LINK) 
+				err = sysfs_attach_link(sd, dentry);
+			else
+				err = sysfs_attach_attr(sd, dentry);
+			break;
+		}
+	}
+
+	return ERR_PTR(err);
+}
+  
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
 {
@@ -45,9 +167,21 @@ static int create_dir(struct kobject * k
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
 					 init_dir);
 		if (!error) {
-			(*d)->d_op = &sysfs_dentry_operations;
-			(*d)->d_fsdata = kobject_get(k);
-			p->d_inode->i_nlink++;
+			struct sysfs_dirent * sd, * parent_sd;
+			parent_sd = p->d_fsdata;
+			sd = sysfs_new_dirent(parent_sd, k, 
+						(parent_sd->s_element == k) ? 
+						SYSFS_KOBJ_ATTR_GROUP : 
+						SYSFS_KOBJECT);
+			if (sd) {
+				(*d)->d_fsdata = sysfs_get(sd);
+				(*d)->d_op = &sysfs_dentry_ops;
+				p->d_inode->i_nlink++;
+				sd->s_element = kobject_get(k);
+				sd->s_dentry = *d;
+				d_rehash(*d);
+			} else
+				error = -ENOMEM;
 		}
 		dput(*d);
 	} else
@@ -56,7 +190,6 @@ static int create_dir(struct kobject * k
 	return error;
 }
 
-
 int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
 {
 	return create_dir(k,k->dentry,n,d);
@@ -94,8 +227,13 @@ int sysfs_create_dir(struct kobject * ko
 static void remove_dir(struct dentry * d)
 {
 	struct dentry * parent = dget(d->d_parent);
+	struct sysfs_dirent * sd;
+
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
+	sd = d->d_fsdata;
+ 	list_del_init(&sd->s_sibling);
+ 	sysfs_put(d->d_fsdata);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -123,41 +261,29 @@ void sysfs_remove_subdir(struct dentry *
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
-	struct list_head * node;
 	struct dentry * dentry = dget(kobj->dentry);
+	struct dentry * d;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * sd, * tmp;
+	char * name;
 
 	if (!dentry)
 		return;
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
-
-	spin_lock(&dcache_lock);
-restart:
-	node = dentry->d_subdirs.next;
-	while (node != &dentry->d_subdirs) {
-		struct dentry * d = list_entry(node,struct dentry,d_child);
-
-		node = node->next;
-		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
-		if (!d_unhashed(d) && (d->d_inode)) {
-			d = dget_locked(d);
-			pr_debug("removing");
-
-			/**
-			 * Unlink and unhash.
-			 */
-			spin_unlock(&dcache_lock);
-			d_delete(d);
-			simple_unlink(dentry->d_inode,d);
-			dput(d);
-			pr_debug(" done\n");
-			spin_lock(&dcache_lock);
-			/* re-acquired dcache_lock, need to restart */
-			goto restart;
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			name = sysfs_get_name(sd);
+			d = sysfs_get_dentry(dentry, name);
+			if (!IS_ERR(d) && d->d_inode) {
+				list_del_init(&sd->s_sibling);
+				sysfs_put(sd);
+				d_drop(d);
+				simple_unlink(dentry->d_inode, d);
+			}
 		}
 	}
-	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 
 	remove_dir(dentry);
@@ -182,11 +308,176 @@ void sysfs_rename_dir(struct kobject * k
 	down(&parent->d_inode->i_sem);
 
 	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
+	if (!IS_ERR(new_dentry)) {
+		d_add(new_dentry, NULL);
+		d_move(kobj->dentry, new_dentry);
+		kobject_set_name(kobj,new_name);
+	}
 	up(&parent->d_inode->i_sem);	
 }
 
+/* called under parent inode's i_sem */
+static void sysfs_close_dir_entries(struct dentry * parent)
+{
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dirent * sd, * tmp;
+
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			struct dentry * dentry = sd->s_dentry;
+			if (dentry && dentry->d_inode)
+				dput(dentry);
+		}
+	}
+}
+
+/* called under parent inode's i_sem */
+static int sysfs_open_dir_entries(struct dentry * parent)
+{
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	struct dentry * dentry;
+	int error = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			char * name = sysfs_get_name(sd);
+			dentry = sysfs_get_dentry(parent, name);
+			if (IS_ERR(dentry)) {
+				error = PTR_ERR(dentry);
+				break;
+			}
+			if (!dentry->d_inode) {
+				if (sd->s_type & SYSFS_KOBJ_LINK)
+					error = sysfs_attach_link(sd, dentry);
+				else
+					error = sysfs_attach_attr(sd, dentry);
+			}
+			if (error)
+				break;
+		}
+	}
+	if (error) {
+		/* release all successfully opened entires so far*/
+		sysfs_close_dir_entries(parent);
+	}
+
+	return error;
+}
+
+/* Relationship between i_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct inode *inode)
+{
+	return (inode->i_mode >> 12) & 15;
+}
+
+/*
+ * Directory is locked and all positive dentries in it are safe, since
+ * for ramfs-type trees they can't go away without unlink() or rmdir(),
+ * both impossible due to the lock on directory.
+ */
+
+int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct dentry *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->d_child;
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
+			if ((err = sysfs_open_dir_entries(dentry)))
+				return err;
+	
+			spin_lock(&dcache_lock);
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &dentry->d_subdirs);
+			}
+			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (d_unhashed(next) || !next->d_inode)
+					continue;
+
+				spin_unlock(&dcache_lock);
+				if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode)) < 0)
+					return 0;
+				spin_lock(&dcache_lock);
+				/* next is still alive */
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
+			}
+			spin_unlock(&dcache_lock);
+			sysfs_close_dir_entries(dentry);
+	}
+	return 0;
+}
+
+loff_t sysfs_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+	int err = 0;
+
+	down(&file->f_dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct list_head *p;
+			struct dentry *cursor = file->private_data;
+			loff_t n = file->f_pos - 2;
+
+			if ((err = sysfs_open_dir_entries(file->f_dentry))) {
+				offset = err;
+				goto exit;
+			}
+
+			spin_lock(&dcache_lock);
+			list_del(&cursor->d_child);
+			p = file->f_dentry->d_subdirs.next;
+			while (n && p != &file->f_dentry->d_subdirs) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (!d_unhashed(next) && next->d_inode)
+					n--;
+				p = p->next;
+			}
+			list_add_tail(&cursor->d_child, p);
+			spin_unlock(&dcache_lock);
+			sysfs_close_dir_entries(file->f_dentry);
+		}
+	}
+exit:
+	up(&file->f_dentry->d_inode->i_sem);
+	return offset;
+}
 EXPORT_SYMBOL(sysfs_create_dir);
 EXPORT_SYMBOL(sysfs_remove_dir);
 EXPORT_SYMBOL(sysfs_rename_dir);

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
