Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWBSRR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWBSRR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBSRR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:17:57 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:12743 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932160AbWBSRR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:17:56 -0500
Date: Sun, 19 Feb 2006 19:17:48 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: zanussi@us.ibm.com, Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060219171748.GA13068@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, zanussi@us.ibm.com,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now with relayfs integrated and the relay_file_operations exported for
use by other file systems, I wonder what people think about adding in a
sysfs attribute for setting up channel buffers.

The conventional relayfs doesn't make a lot of sense for the use cases
where there are multiple devices to stream data from, particularly if
they're already mapped out through the driver model. Rather than
duplicating device enumeration, simply adding this as an attribute seems
to work reasonably well.

Tom did some work on the rchan_callbacks for more easily implementing
relay files in other file systems, and it would be nice to use this in a
non-debug context, without duplicating device enumeration in multiple
locations.

---

 fs/sysfs/Makefile     |    1 
 fs/sysfs/dir.c        |   26 ++++++++++++++++++
 fs/sysfs/inode.c      |    5 +++
 fs/sysfs/relay.c      |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h |   27 ++++++++++++++++++-
 5 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/Makefile b/fs/sysfs/Makefile
index 7a1ceb9..676bf3c 100644
--- a/fs/sysfs/Makefile
+++ b/fs/sysfs/Makefile
@@ -4,3 +4,4 @@
 
 obj-y		:= inode.o file.o dir.o symlink.o mount.o bin.o \
 		   group.o
+obj-$(CONFIG_RELAYFS_FS) += relay.o
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 49bd219..379daa3 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -87,6 +87,20 @@ static int init_file(struct inode * inod
 	return 0;
 }
 
+#ifdef CONFIG_RELAYFS_FS
+static int init_relay_file(struct inode * inode)
+{
+	extern struct file_operations relay_file_operations;
+	inode->i_fop = &relay_file_operations;
+	return 0;
+}
+#else
+static int init_relay_file(struct inode * inode)
+{
+	return -EINVAL;
+}
+#endif
+
 static int init_symlink(struct inode * inode)
 {
 	inode->i_op = &sysfs_symlink_inode_operations;
@@ -165,6 +179,7 @@ int sysfs_create_dir(struct kobject * ko
 static int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
 {
 	struct attribute * attr = NULL;
+	struct relay_attribute * rel_attr = NULL;
 	struct bin_attribute * bin_attr = NULL;
 	int (* init) (struct inode *) = NULL;
 	int error = 0;
@@ -172,6 +187,10 @@ static int sysfs_attach_attr(struct sysf
         if (sd->s_type & SYSFS_KOBJ_BIN_ATTR) {
                 bin_attr = sd->s_element;
                 attr = &bin_attr->attr;
+	} else if (sd->s_type & SYSFS_KOBJ_RELAY_ATTR) {
+		rel_attr = sd->s_element;
+		attr = &rel_attr->attr;
+		init = init_relay_file;
         } else {
                 attr = sd->s_element;
                 init = init_file;
@@ -189,6 +208,13 @@ static int sysfs_attach_attr(struct sysf
 		dentry->d_inode->i_size = bin_attr->size;
 		dentry->d_inode->i_fop = &bin_fops;
 	}
+
+	if (rel_attr) {
+		unsigned int size = rel_attr->subbuf_size * rel_attr->n_subbufs;
+		dentry->d_inode->i_size = ((size - 1) & PAGE_MASK) + PAGE_SIZE;
+		dentry->d_inode->u.generic_ip = rel_attr->rchan_buf;
+	}
+
 	dentry->d_op = &sysfs_dentry_ops;
 	d_rehash(dentry);
 
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 689f7bc..d41cb6d 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -174,6 +174,7 @@ const unsigned char * sysfs_get_name(str
 {
 	struct attribute * attr;
 	struct bin_attribute * bin_attr;
+	struct relay_attribute * rel_attr;
 	struct sysfs_symlink  * sl;
 
 	if (!sd || !sd->s_element)
@@ -192,6 +193,10 @@ const unsigned char * sysfs_get_name(str
 			bin_attr = sd->s_element;
 			return bin_attr->attr.name;
 
+		case SYSFS_KOBJ_RELAY_ATTR:
+			rel_attr = sd->s_element;
+			return rel_attr->attr.name;
+
 		case SYSFS_KOBJ_LINK:
 			sl = sd->s_element;
 			return sl->link_name;
--- linux-2.6/fs/sysfs/relay.c	2005-06-14 13:29:20.446304896 +0300
+++ linux-2.6/fs/sysfs/relay.c	2006-02-19 18:54:21.583577778 +0200
@@ -0,0 +1,70 @@
+/*
+ * relay.c - relay channel buffer support for sysfs
+ *
+ * Copyright (C) 2006 Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/relayfs_fs.h>
+#include <linux/namei.h>
+#include <linux/module.h>
+#include "sysfs.h"
+
+static struct dentry *
+sysfs_create_buf_file(const char *filename, struct dentry *dentry, int mode,
+		      struct rchan_buf *buf, int *is_global)
+{
+	struct relay_attribute *attr = (struct relay_attribute *)dentry;
+	struct dentry *parent = attr->kobj->dentry;
+	int ret;
+
+	attr->attr.mode = mode;
+	attr->rchan_buf = buf;
+
+	ret = sysfs_add_file(parent, &attr->attr, SYSFS_KOBJ_RELAY_ATTR);
+	if (unlikely(ret != 0))
+		return NULL;
+
+	dentry = lookup_one_len(filename, parent, strlen(filename));
+	if (IS_ERR(dentry))
+		sysfs_hash_and_remove(parent, filename);
+
+	return dentry;
+}
+
+static int sysfs_remove_buf_file(struct dentry *dentry)
+{
+	sysfs_hash_and_remove(dentry, dentry->d_name.name);
+	return 0;
+}
+
+struct rchan_callbacks sysfs_rchan_callbacks = {
+	.create_buf_file	= sysfs_create_buf_file,
+	.remove_buf_file	= sysfs_remove_buf_file,
+};
+
+int sysfs_create_relay_file(struct kobject *kobj, struct relay_attribute *attr)
+{
+	BUG_ON(!kobj || !kobj->dentry || !attr);
+
+	attr->kobj = kobj;
+
+	attr->rchan = relay_open(attr->attr.name, (void *)attr,
+				 attr->subbuf_size, attr->n_subbufs,
+				 &sysfs_rchan_callbacks);
+	if (IS_ERR(attr->rchan))
+		return PTR_ERR(attr->rchan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sysfs_create_relay_file);
+
+void sysfs_remove_relay_file(struct kobject *kobj, struct relay_attribute *attr)
+{
+	BUG_ON(!attr);
+
+	relay_close(attr->rchan);
+}
+EXPORT_SYMBOL_GPL(sysfs_remove_relay_file);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 392da5a..2e75d49 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -60,6 +60,15 @@ struct bin_attribute {
 		    struct vm_area_struct *vma);
 };
 
+struct relay_attribute {
+	struct attribute	attr;
+	struct rchan		*rchan;
+	struct rchan_buf	*rchan_buf;
+	struct kobject		*kobj;
+	size_t			subbuf_size;
+	size_t			n_subbufs;
+};
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
@@ -81,7 +90,23 @@ struct sysfs_dirent {
 #define SYSFS_KOBJ_ATTR 	0x0004
 #define SYSFS_KOBJ_BIN_ATTR	0x0008
 #define SYSFS_KOBJ_LINK 	0x0020
-#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+#define SYSFS_KOBJ_RELAY_ATTR	0x0040
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | \
+				 SYSFS_KOBJ_LINK | SYSFS_KOBJ_RELAY_ATTR)
+
+#if defined(CONFIG_RELAYFS_FS) && defined(CONFIG_SYSFS)
+int sysfs_create_relay_file(struct kobject *, struct relay_attribute *);
+void sysfs_remove_relay_file(struct kobject *, struct relay_attribute *);
+#else
+static inline int sysfs_create_relay_file(struct kobject *kobj, struct relay_attribute *attr)
+{
+	return 0;
+}
+
+static inline void sysfs_remove_relay_file(struct kobject *kobj, struct relay_attribute *attr)
+{
+}
+#endif /* CONFIG_RELAYFS_FS && CONFIG_SYSFS */
 
 #ifdef CONFIG_SYSFS
