Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWCGKm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWCGKm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWCGKm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:42:27 -0500
Received: from ozlabs.org ([203.10.76.45]:7078 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752051AbWCGKm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:42:27 -0500
To: Greg Kroah-Hartman <greg@kroah.com>, <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Mar 2006 21:41:59 +1100
Subject: [PATCH] debugfs: Add debugfs_create_blob() helper for exporting binary data
Message-Id: <20060307104225.E0DDA679E6@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to export a binary blob via debugfs, and although it was pretty easy
it seems like it'd be easier if there was a helper for it. It's a pity we need
the wrapper struct but I can't see a cleaner way to do it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 fs/debugfs/file.c       |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |   15 +++++++++++++++
 2 files changed, 61 insertions(+)

Index: kdump/fs/debugfs/file.c
===================================================================
--- kdump.orig/fs/debugfs/file.c
+++ kdump/fs/debugfs/file.c
@@ -251,3 +251,49 @@ struct dentry *debugfs_create_bool(const
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
 
+static ssize_t read_file_blob(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct debugfs_blob_wrapper *blob = file->private_data;
+	return simple_read_from_buffer(user_buf, count, ppos, blob->data,
+			blob->size);
+}
+
+static struct file_operations fops_blob = {
+	.read =		read_file_blob,
+	.open =		default_open,
+};
+
+/**
+ * debugfs_create_blob - create a file in the debugfs filesystem that is
+ * used to read and write a binary blob.
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @blob: a pointer to a struct debugfs_blob_wrapper which contains a pointer
+ *        to the blob data and the size of the data.
+ *
+ * This function creates a file in debugfs with the given name that exports
+ * @blob->data as a binary blob. If the @mode variable is so set it can be
+ * read from. Writing is not supported.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_blob(const char *name, mode_t mode,
+				   struct dentry *parent,
+				   struct debugfs_blob_wrapper *blob)
+{
+	return debugfs_create_file(name, mode, parent, blob, &fops_blob);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_blob);
Index: kdump/include/linux/debugfs.h
===================================================================
--- kdump.orig/include/linux/debugfs.h
+++ kdump/include/linux/debugfs.h
@@ -21,6 +21,11 @@
 
 struct file_operations;
 
+struct debugfs_blob_wrapper {
+	void *data;
+	unsigned long size;
+};
+
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
@@ -39,6 +44,9 @@ struct dentry *debugfs_create_u32(const 
 struct dentry *debugfs_create_bool(const char *name, mode_t mode,
 				  struct dentry *parent, u32 *value);
 
+struct dentry *debugfs_create_blob(const char *name, mode_t mode,
+				  struct dentry *parent,
+				  struct debugfs_blob_wrapper *blob);
 #else
 
 #include <linux/err.h>
@@ -94,6 +102,13 @@ static inline struct dentry *debugfs_cre
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_blob(const char *name, mode_t mode,
+				  struct dentry *parent,
+				  struct debugfs_blob_wrapper *blob)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 #endif
 
 #endif
