Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUABGqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 01:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUABGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 01:46:22 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:48309 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265081AbUABGqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 01:46:00 -0500
Date: Fri, 2 Jan 2004 12:15:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: Re: [RFC 2/5] sysfs backing store (leaves only) - sysfs-leaves-dir.patch
Message-ID: <20040102064503.GA2539@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031229093213.GA1649@in.ibm.com> <20031229093354.GB1649@in.ibm.com> <20031229093434.GC1649@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229093434.GC1649@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please use this patch instead, there was a typo in the previous one in 
remove_dir(). Also corrected the subject line. It is 2/5.

Thanks
Maneesh



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

 fs/sysfs/dir.c |  301 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 292 insertions(+), 9 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-leaves-dir fs/sysfs/dir.c
--- linux-2.6.0/fs/sysfs/dir.c~sysfs-leaves-dir	2003-12-29 12:30:50.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/dir.c	2003-12-29 12:30:56.000000000 +0530
@@ -10,10 +10,54 @@
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
+/* dentry iput only for sysfs leaf dentries */
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode) 
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd)
+		sysfs_put(sd);
+	iput(inode);
+}
+
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput		= sysfs_d_iput,
+};
+
+char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	if (!sd || !sd->s_element)
+		BUG();
+
+	return (sd->s_type & SYSFS_KOBJ_ATTR) ?
+		((struct attribute *)(sd->s_element))->name :
+		((struct bin_attribute *)(sd->s_element))->attr.name;
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
@@ -21,6 +65,61 @@ static int init_dir(struct inode * inode
 }
 
 
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the 
+ * attribute file
+ */
+int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
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
+struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry, 
+				struct nameidata *nd)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if ((sd->s_type == SYSFS_KOBJ_ATTR) 
+			|| (sd->s_type == SYSFS_KOBJ_BIN_ATTR)) {
+			char * name = sysfs_get_name(sd);
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+			err = sysfs_attach_attr(sd, dentry);
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
@@ -29,12 +128,23 @@ static int create_dir(struct kobject * k
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d,
+		error = sysfs_create(*d, 
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
 					 init_dir);
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
+				d_rehash(*d);
+			} else
+				error = -ENOMEM;
 		}
 		dput(*d);
 	} else
@@ -81,9 +191,15 @@ int sysfs_create_dir(struct kobject * ko
 static void remove_dir(struct dentry * d)
 {
 	struct dentry * parent = dget(d->d_parent);
+	struct sysfs_dirent * sd;
+
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
-	simple_rmdir(parent->d_inode,d);
+	sd = d->d_fsdata;
+	list_del_init(&sd->s_sibling);
+	sysfs_put(d->d_fsdata);
+	if (d->d_inode)
+		simple_rmdir(parent->d_inode,d);
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
@@ -133,9 +249,18 @@ void sysfs_remove_dir(struct kobject * k
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
-			d_delete(d);
-			simple_unlink(dentry->d_inode,d);
-			dput(d);
+			if (S_ISREG(d->d_inode->i_mode)) {
+				struct sysfs_dirent * sd = d->d_fsdata;
+
+				list_del_init(&sd->s_sibling);
+				sysfs_put(sd);
+				d_drop(d);
+				simple_unlink(dentry->d_inode,d);
+			} else {
+				d_delete(d);
+				simple_unlink(dentry->d_inode,d);
+				dput(d);
+			}
 			spin_lock(&dcache_lock);
 		}
 		pr_debug(" done\n");
@@ -172,6 +297,164 @@ void sysfs_rename_dir(struct kobject * k
 	up(&parent->d_inode->i_sem);	
 }
 
+/* called under parent inode's i_sem (taken in vfs_readdir */
+static void sysfs_close_attr_files(struct dentry * parent)
+{
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if ((sd->s_type == SYSFS_KOBJ_ATTR) || 
+			(sd->s_type == SYSFS_KOBJ_BIN_ATTR)) {
+			struct dentry * dentry = sd->s_dentry;
+			if (dentry && dentry->d_inode)
+				dput(dentry);
+		}
+	}
+}
+
+/* called under parent inode's i_sem (taken in vfs_readdir */
+static int sysfs_open_attr_files(struct dentry * parent)
+{
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	struct dentry * dentry;
+	int error = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if ((sd->s_type == SYSFS_KOBJ_ATTR) || 
+			(sd->s_type == SYSFS_KOBJ_BIN_ATTR)) {
+			char * name = sysfs_get_name(sd);
+			dentry = sysfs_get_dentry(parent, name);
+			if (IS_ERR(dentry))
+				error = PTR_ERR(dentry);
+			if (!dentry->d_inode) 
+				error = sysfs_attach_attr(sd, dentry);
+			if (error)
+				break;
+		}
+	}
+	if (error) {
+		/* release all successfully opened entires so far*/
+		sysfs_close_attr_files(parent);
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
+			if ((err = sysfs_open_attr_files(dentry)))
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
+			sysfs_close_attr_files(dentry);
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
+			if ((err = sysfs_open_attr_files(file->f_dentry))) {
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
+			sysfs_close_attr_files(file->f_dentry);
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
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
