Return-Path: <linux-kernel-owner+w=401wt.eu-S932308AbWLLSCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWLLSCF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWLLSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:02:05 -0500
Received: from science.horizon.com ([192.35.100.1]:16327 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932306AbWLLSCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:02:03 -0500
Date: 12 Dec 2006 13:02:01 -0500
Message-ID: <20061212180201.12051.qmail@science.horizon.com>
From: linux@horizon.com
To: jlayton@redhat.com, linux@horizon.com
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <457EDCC9.3070409@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Good catch on the inlining. I had meant to do that and missed it.

Er... if you want it to *be* inlined, you have to put it into the .h
file so the compiler knows about it at the call site.  "static inline"
tells gcc not avoid emitting a callable version.

Something like this the following.  (You'll also need to add
a "#include <stdbool.h>", unless you expand the "bool", "false" and
"true" macros to their values "_Bool", "0" and "1" by hand.)

--- linux-2.6/include/linux/fs.h.super	2006-12-12 08:53:34.000000000 -0500
+++ linux-2.6/include/linux/fs.h	2006-12-12 08:54:14.000000000 -0500
@@ -1879,7 +1879,32 @@
  extern struct inode_operations simple_dir_inode_operations;
  struct tree_descr { char *name; const struct file_operations *ops; int mode; };
  struct dentry *d_alloc_name(struct dentry *, const char *);
-extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
+extern int __simple_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files, bool registered);
  extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
  extern void simple_release_fs(struct vfsmount **mount, int *count);

+/*
+ * Fill a superblock with a standard set of fields, and add the entries in the
+ * "files" struct. Assign i_ino values to the files sequentially. This function
+ * is appropriate for filesystems that need a particular i_ino value assigned
+ * to a particular "files" entry.
+ */
+static inline int simple_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, false);
+}
+
+/*
+ * Just like simple_fill_super, but does an iunique_register on the inodes
+ * created for "files" entries. This function is appropriate when you don't
+ * need a particular i_ino value assigned to each files entry, and when the
+ * filesystem will have other registered inodes.
+ */
+static inline int registered_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, true);
+}
+

