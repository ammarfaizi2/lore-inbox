Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUEEMxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUEEMxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUEEMxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:53:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21944 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264635AbUEEMvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:51:39 -0400
Date: Wed, 5 May 2004 18:28:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>
Subject: [RFC 2/6] sysfs backing store ver 0.5
Message-ID: <20040505125815.GC1244@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040505125702.GA1244@in.ibm.com> <20040505125755.GB1244@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505125755.GB1244@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.5
 o Changed ->read_dir & ->lseek logic. The ->read_dir and ->lseek
   logic is now based on the sysfs_dirent tree instead of dentry
   based tree. Now we don't have to dget/dput children while
   opening a dir. The earlier logic was wrong in the sense as we might
   end up in doing dput() for dentrys which were not opened by us.

 o Code changes to accomodate latest sysfs changes like in sysfs_rename_dir,
   sysfs_remove_dir and symlinks handling.

 o BUG_ON in sysfs_d_iput() to check if there are any cases of mismatch
   in dentry and ((struct sysfs_dirent *) dentry->d_fsdata)->s_dentry

=> changes in version 0.4
 o Do not take reference to kobject while creating a dir dentry for it as it
   can lead to rmmod hang or certain modules due to current limitation of 
   module/kobject refcounting code.

=> changes in version 0.3a
 o call sysfs_close_dir_entries() when filldir() returns error in 
   sysfs_readdir().

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



 fs/sysfs/dir.c |  350 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 308 insertions(+), 42 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-leaves-dir fs/sysfs/dir.c
--- linux-2.6.6-rc3-mm1/fs/sysfs/dir.c~sysfs-leaves-dir	2004-05-05 10:55:12.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/dir.c	2004-05-05 10:55:12.000000000 +0530
@@ -12,31 +12,181 @@
 
 DECLARE_RWSEM(sysfs_rename_sem);
 
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
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode) 
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd) {
+		BUG_ON(sd->s_dentry != dentry);
+		sd->s_dentry = NULL;
+		sysfs_put(sd);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput		= sysfs_d_iput,
+};
+
+const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	struct attribute * attr;
+	struct bin_attribute * bin_attr;
+	struct sysfs_symlink  * sl;
+
+	if (!sd || !sd->s_element)
+		BUG();
+
+	switch (sd->s_type) {
+		case SYSFS_KOBJECT:
+		case SYSFS_KOBJ_ATTR_GROUP:
+			/* Always have a dentry so use that */
+			return sd->s_dentry->d_name.name;
+
+		case SYSFS_KOBJ_ATTR:
+			attr = sd->s_element;
+			return attr->name;
+
+		case SYSFS_KOBJ_BIN_ATTR:
+			bin_attr = sd->s_element;
+			return bin_attr->attr.name;
+
+		case SYSFS_KOBJ_LINK:
+			sl = sd->s_element;
+			return sl->link_name;
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
 
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the 
+ * attribute file
+ */
+static int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	struct attribute * attr = NULL;
+	struct bin_attribute * bin_attr = NULL;
+        int (* init) (struct inode *) = NULL;
+	int error = 0;
+
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
+}
+
+static int sysfs_attach_link(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	int err = 0;
+
+	err = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
+	if (!err) {
+		dentry->d_op = &sysfs_dentry_ops;
+		dentry->d_fsdata = sysfs_get(sd);
+		sd->s_dentry = dentry;
+		d_rehash(dentry);
+	}
+	return err;
+}
+
+struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry, 
+				struct nameidata *nd)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			const unsigned char * name = sysfs_get_name(sd);
+
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+
+			if (sd->s_type & SYSFS_KOBJ_LINK) 
+				err = sysfs_attach_link(sd, dentry);
+			else
+				err = sysfs_attach_attr(sd, dentry);
+			break;
+		}
+	}
 
+	return ERR_PTR(err);
+}
+  
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
 {
 	int error;
+	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d,
-					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
-					 init_dir);
+		error = sysfs_create(*d, mode, init_dir);
 		if (!error) {
-			(*d)->d_fsdata = k;
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
+				sd->s_element = k;
+				sd->s_dentry = *d;
+				sd->s_mode = mode;
+				d_rehash(*d);
+			} else
+				error = -ENOMEM;
 		}
 		dput(*d);
 	} else
@@ -45,7 +195,6 @@ static int create_dir(struct kobject * k
 	return error;
 }
 
-
 int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
 {
 	return create_dir(k,k->dentry,n,d);
@@ -79,12 +228,16 @@ int sysfs_create_dir(struct kobject * ko
 	return error;
 }
 
-
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
 
@@ -112,8 +265,9 @@ void sysfs_remove_subdir(struct dentry *
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
-	struct list_head * node;
 	struct dentry * dentry = dget(kobj->dentry);
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * sd, * tmp;
 
 	if (!dentry)
 		return;
@@ -121,38 +275,19 @@ void sysfs_remove_dir(struct kobject * k
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
 
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
-			__d_drop(d);
-			spin_unlock(&dcache_lock);
-			/* release the target kobject in case of 
-			 * a symlink
-			 */
-			if (S_ISLNK(d->d_inode->i_mode))
-				kobject_put(d->d_fsdata);
-			
-			simple_unlink(dentry->d_inode,d);
-			dput(d);
-			pr_debug(" done\n");
-			spin_lock(&dcache_lock);
-			/* re-acquired dcache_lock, need to restart */
-			goto restart;
-		}
-	}
-	spin_unlock(&dcache_lock);
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			const unsigned char * name = sysfs_get_name(sd);
+			struct dentry * d = sysfs_get_dentry(dentry, name);
+
+			if (!IS_ERR(d) && d->d_inode) {
+				list_del_init(&sd->s_sibling);
+				sysfs_put(sd);
+				d_drop(d);
+				simple_unlink(dentry->d_inode, d);
+			}
+  		}
+  	}
 	up(&dentry->d_inode->i_sem);
 
 	remove_dir(dentry);
@@ -192,6 +327,137 @@ int sysfs_rename_dir(struct kobject * ko
 	return error;
 }
 
+int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+
+	down(&dentry->d_inode->i_sem);
+	file->private_data = sysfs_new_dirent(parent_sd, NULL, 0);
+	up(&dentry->d_inode->i_sem);
+
+	return file->private_data ? 0 : -ENOMEM;
+
+}
+
+int sysfs_dir_close(struct inode *inode, struct file *file)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dirent * cursor = file->private_data;
+
+	down(&dentry->d_inode->i_sem);
+	list_del_init(&cursor->s_sibling);
+	up(&dentry->d_inode->i_sem);
+	sysfs_put(file->private_data);
+
+	return 0;
+}
+
+/* Relationship between s_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct sysfs_dirent *sd)
+{
+	return (sd->s_mode >> 12) & 15;
+}
+
+int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->s_sibling;
+	ino_t ino;
+	int i = filp->f_pos;
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
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &parent_sd->s_children);
+			}
+			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
+				struct sysfs_dirent *next;
+				const char * name;
+				int len;
+
+				next = list_entry(p, struct sysfs_dirent, 
+						   s_sibling);
+				if (!next->s_element)
+					continue;
+
+				name = sysfs_get_name(next);
+				len = strlen(name);
+				if (next->s_dentry)
+					ino = next->s_dentry->d_inode->i_ino;
+				else
+					ino = iunique(sysfs_sb, 2);
+
+				if (filldir(dirent, name, len, filp->f_pos, ino,
+						 dt_type(next)) < 0)
+					return 0;
+
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
+			}
+	}
+	return 0;
+}
+
+loff_t sysfs_dir_lseek(struct file * file, loff_t offset, int origin)
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
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct sysfs_dirent *sd = dentry->d_fsdata;
+			struct sysfs_dirent *cursor = file->private_data;
+			struct list_head *p;
+			loff_t n = file->f_pos - 2;
+
+			list_del(&cursor->s_sibling);
+			p = sd->s_children.next;
+			while (n && p != &sd->s_children) {
+				struct sysfs_dirent *next;
+				next = list_entry(p, struct sysfs_dirent, 
+						   s_sibling);
+				if (next->s_element)
+					n--;
+				p = p->next;
+			}
+			list_add_tail(&cursor->s_sibling, p);
+		}
+	}
+	up(&dentry->d_inode->i_sem);
+	return offset;
+}
+
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
