Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUHWSRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUHWSRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUHWSRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:17:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39147 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266349AbUHWSPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:15:20 -0400
Date: Mon, 23 Aug 2004 14:15:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/7] xattr consolidation - libfs
In-Reply-To: <Xine.LNX.4.44.0408231408030.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch consolidates common xattr handling logic into libfs, for
use by ext2, ext3 and devpts, as well as upcoming ramfs and tmpfs xattr code.


 fs/libfs.c         |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |   23 ++++++++++
 2 files changed, 134 insertions(+)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/libfs.c linux-2.6.8.1-mm2.w/fs/libfs.c
--- linux-2.6.8.1-mm2.p/fs/libfs.c	2004-08-19 10:32:52.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/libfs.c	2004-08-23 00:36:10.438262984 -0400
@@ -521,6 +521,112 @@ int simple_transaction_release(struct in
 	return 0;
 }
 
+int simple_xattr_register(struct simple_xattr_info *info, int idx, struct simple_xattr_handler *handler)
+{
+	int ret = -EINVAL;
+	
+	if (idx > 0 && idx <= SIMPLE_XATTR_MAX) {
+		write_lock(&info->lock);
+		if (!info->handlers[idx - 1]) {
+			info->handlers[idx - 1] = handler;
+			ret = 0;
+		}
+		write_unlock(&info->lock);
+	}
+	return ret;
+}
+
+void simple_xattr_unregister(struct simple_xattr_info *info, int idx, struct simple_xattr_handler *handler)
+{
+	if (idx > 0 || idx <= SIMPLE_XATTR_MAX) {
+		write_lock(&info->lock);
+		info->handlers[idx - 1] = NULL;
+		write_unlock(&info->lock);
+	}
+}
+
+static const char *strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+struct simple_xattr_handler *simple_xattr_resolve_name(struct simple_xattr_info *info, const char **name)
+{
+	struct simple_xattr_handler *handler = NULL;
+	int i;
+
+	if (!*name)
+		return NULL;
+
+	read_lock(&info->lock);
+	for (i = 0; i < SIMPLE_XATTR_MAX; i++) {
+		if (info->handlers[i]) {
+			const char *n = strcmp_prefix(*name,
+						info->handlers[i]->prefix);
+			if (n) {
+				handler = info->handlers[i];
+				*name = n;
+				break;
+			}
+		}
+	}
+	read_unlock(&info->lock);
+	return handler;
+}
+
+struct simple_xattr_handler *simple_xattr_handler(struct simple_xattr_info *info, int idx)
+{
+	struct simple_xattr_handler *handler = NULL;
+	if (idx > 0 && idx <= SIMPLE_XATTR_MAX) {
+		read_lock(&info->lock);
+		handler = info->handlers[idx - 1];
+		read_unlock(&info->lock);
+	}
+	return handler;
+}
+
+size_t simple_xattr_list(struct simple_xattr_info *info, struct dentry *dentry, char *buffer, size_t buffer_size)
+{
+	struct simple_xattr_handler *handler = NULL;
+	struct inode *inode = dentry->d_inode;
+	int i, error = 0;
+	unsigned int size = 0;
+	char *buf;
+
+	read_lock(&info->lock);
+
+	for (i = 0; i < SIMPLE_XATTR_MAX; i++) {
+		handler = info->handlers[i];
+		if (handler)
+			size += handler->list(inode, NULL, NULL, 0);
+	}
+
+	if (!buffer) {
+		error = size;
+		goto out;
+	} else {
+		error = -ERANGE;
+		if (size > buffer_size)
+			goto out;
+	}
+
+	buf = buffer;
+	for (i = 0; i < SIMPLE_XATTR_MAX; i++) {
+		handler = info->handlers[i];
+		if (handler)
+			buf += handler->list(inode, buf, NULL, 0);
+	}
+	error = size;
+
+out:
+	read_unlock(&info->lock);
+	return size;
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -547,3 +653,8 @@ EXPORT_SYMBOL(simple_read_from_buffer);
 EXPORT_SYMBOL(simple_transaction_get);
 EXPORT_SYMBOL(simple_transaction_read);
 EXPORT_SYMBOL(simple_transaction_release);
+EXPORT_SYMBOL(simple_xattr_register);
+EXPORT_SYMBOL(simple_xattr_unregister);
+EXPORT_SYMBOL(simple_xattr_resolve_name);
+EXPORT_SYMBOL(simple_xattr_handler);
+EXPORT_SYMBOL(simple_xattr_list);
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/include/linux/fs.h linux-2.6.8.1-mm2.w/include/linux/fs.h
--- linux-2.6.8.1-mm2.p/include/linux/fs.h	2004-08-19 10:32:53.000000000 -0400
+++ linux-2.6.8.1-mm2.w/include/linux/fs.h	2004-08-23 00:24:43.985619648 -0400
@@ -1646,6 +1646,29 @@ static inline ino_t parent_ino(struct de
 	return res;
 }
 
+#define SIMPLE_XATTR_MAX 10
+
+struct simple_xattr_handler {
+	char *prefix;
+	size_t (*list)(struct inode *inode, char *list, const char *name,
+		       int name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+struct simple_xattr_info {
+	rwlock_t lock;
+	struct simple_xattr_handler **handlers;
+};
+
+int simple_xattr_register(struct simple_xattr_info *info, int idx, struct simple_xattr_handler *handler);
+void simple_xattr_unregister(struct simple_xattr_info *info, int idx, struct simple_xattr_handler *handler);
+struct simple_xattr_handler *simple_xattr_resolve_name(struct simple_xattr_info *info, const char **name);
+struct simple_xattr_handler *simple_xattr_handler(struct simple_xattr_info *info, int idx);
+size_t simple_xattr_list(struct simple_xattr_info *info, struct dentry *dentry, char *buffer, size_t size);
+
 /* kernel/fork.c */
 extern int unshare_files(void);
 

