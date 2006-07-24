Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWGXRx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWGXRx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWGXRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:51:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:33495 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932250AbWGXRvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:51:08 -0400
Subject: [RFC][PATCH 2/6] Integrity Service API and dummy provider
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:51:19 -0700
Message-Id: <1153763479.5171.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a framework and dummy provider for an
integrity service. The three integrity functions provided are:

	integrity_verify_metadata
	integrity_verity_data
	integrity_measure

(Details on the calls and their exact arguments are in
linux/integrity.h, included in the patch.)

Normally these functions would be called by an LSM module
during d_instantiate. The first function is used to retrieve
a requested dentry's label (xattr, such as security.selinux, or
security.slim.level), along with the result of integrity
verification of the label.

Based on the result of this call, the LSM module may also choose
to use integrity_verify_data to request a verification of the
file's data, and integrity_measure, to commit the file's
measurement to some form of logging/attestation service, such
as a TPM.

The latter two functions are separate calls, so that the LSM
module can optimize performance by using them only as needed.
For example, if the integrity_verify_metadata call shows that
the label is not trustworthy, it is probably not necessary to
hash and measure the file, as the current LSM check will
likely be denied anyway.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
 include/linux/integrity.h  |   85 +++++++++++++++++++++++++++++++++++
 security/Makefile          |    1
 security/integrity.c       |   45 ++++++++++++++++++
 security/integrity_dummy.c |   78 ++++++++++++++++++++++++++++++++
 security/integrity_dummy.h |   12 ++++
 5 files changed, 221 insertions(+)

Index: linux-2.6.17/security/integrity.c
===================================================================
--- /dev/null
+++ linux-2.6.17/security/integrity.c
@@ -0,0 +1,45 @@
+/*
+ * integrity.c
+ *
+ * register integrity subsystem
+ *
+ * Copyright (C) 2005,2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/integrity.h>
+
+#include "integrity_dummy.h"
+
+struct integrity_operations *integrity_ops = &dummy_integrity_ops;
+
+int register_integrity(struct integrity_operations *ops)
+{
+	if (integrity_ops != &dummy_integrity_ops)
+		return -EAGAIN;
+
+	integrity_ops = ops;
+	return 0;
+}
+
+int unregister_integrity(struct integrity_operations *ops)
+{
+	if (ops != integrity_ops)
+		return -EINVAL;
+
+	integrity_ops = &dummy_integrity_ops;
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(register_integrity);
+EXPORT_SYMBOL_GPL(unregister_integrity);
+EXPORT_SYMBOL_GPL(integrity_ops);
Index: linux-2.6.17/security/integrity_dummy.c
===================================================================
--- /dev/null
+++ linux-2.6.17/security/integrity_dummy.c
@@ -0,0 +1,78 @@
+/*
+ * integrity_dummy.c
+ *
+ * Instantiate integrity subsystem
+ *
+ * Copyright (C) 2005,2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/integrity.h>
+
+/*
+ *  Return the extended attribute
+ */
+static int dummy_verify_metadata(struct dentry *dentry, char *xattr_name,
+				 char **xattr_value, int *xattr_value_len,
+				 int *xattr_status)
+{
+	char *value;
+	int size;
+	int error;
+
+	if (!xattr_value || !xattr_value_len || !xattr_status)
+		return 0;
+
+	if (!dentry || !dentry->d_inode || !dentry->d_inode->i_op
+	    || !dentry->d_inode->i_op->getxattr) {
+		*xattr_status = -EOPNOTSUPP;
+		return 0;
+	}
+
+	size = dentry->d_inode->i_op->getxattr(dentry, xattr_name, NULL, 0);
+	if (size < 0) {
+		*xattr_value_len = 0;
+		*xattr_status = size;
+		return 0;
+	}
+
+	value = kzalloc(size + 1, GFP_KERNEL);
+	if (!value) {
+		*xattr_value_len = 0;
+		*xattr_status = -ENOMEM;
+		return 0;
+	}
+
+	error = dentry->d_inode->i_op->getxattr(dentry, xattr_name,
+						value, size);
+	*xattr_value_len = size;
+	*xattr_value = value;
+	*xattr_status = error;
+	return 0;
+}
+
+static int dummy_verify_data(struct dentry *dentry)
+{
+	return 0;
+}
+
+static void dummy_measure(struct dentry *dentry,
+			  const unsigned char *filename, int mask)
+{
+	return;
+}
+
+struct integrity_operations dummy_integrity_ops = {
+	.verify_metadata = dummy_verify_metadata,
+	.verify_data = dummy_verify_data,
+	.measure = dummy_measure
+};
+
Index: linux-2.6.17/include/linux/integrity.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/linux/integrity.h
@@ -0,0 +1,85 @@
+/*
+ * integrity.h
+ *
+ * Copyright (C) 2005,2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#ifndef _LINUX_INTEGRITY_H
+#define _LINUX_INTEGRITY_H
+
+#include <linux/fs.h>
+
+/*
+ * struct integrity_operations - main integrity structure
+ *
+ * @verify_data:
+ *	Verify the integrity of a dentry.
+ *	@dentry contains the dentry structure to be verified.
+ *	Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
+ * 		INTEGRITY_NOLABEL
+ *
+ * @verify_metadata:
+ *	Verify the integrity of a dentry's metadata; return the value
+ * 	of the requested xattr_name and the verification result of the
+ *	dentry's metadata.
+ *	@dentry contains the dentry structure of the metadata to be verified.
+ *	@xattr_name, if not null, contains the name of the xattr
+ *		 being requested.
+ *	@xattr_value, if not null, is a pointer for the xattr value.
+ *	@xattr_val_len will be set to the length of the xattr value.
+ *	@xattr_status is the result of the getxattr request for the xattr.
+ *	Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
+ *		INTEGRITY_NOLABEL, -EOPNOTSUPP, -ENOMEM,
+ *
+ * @measure:
+ *	Update an aggregate integrity value with the inode's measurement.
+ *	The aggregate integrity value is maintained in secure storage such
+ *	as in a TPM PCR.
+ *	@dentry contains the dentry structure of the inode to be measured.
+ *	@filename either contains the full pathname/short file name.
+ *	@mask contains the filename permission status(i.e. read, write, append).
+ *
+ */
+
+struct integrity_operations {
+	int (*verify_metadata) (struct dentry *dentry, char *xattr_name,
+			char **xattr_value, int *xattr_val_len,
+			int *xattr_status);
+	int (*verify_data) (struct dentry *dentry);
+	void (*measure) (struct dentry *dentry,
+			const unsigned char *filename, int mask);
+};
+extern int register_integrity(struct integrity_operations *ops);
+extern int unregister_integrity(struct integrity_operations *ops);
+
+/* global variables */
+extern struct integrity_operations *integrity_ops;
+enum integrity_verify_status {
+	INTEGRITY_PASS = 0, INTEGRITY_FAIL = -1, INTEGRITY_NOLABEL = -2
+};
+
+/* inline stuff */
+static inline int integrity_verify_metadata(struct dentry *dentry,
+			char *xattr_name, char **xattr_value,
+			int *xattr_val_len, int *xattr_status)
+{
+	return integrity_ops->verify_metadata(dentry, xattr_name,
+			xattr_value, xattr_val_len, xattr_status);
+}
+
+static inline int integrity_verify_data(struct dentry *dentry)
+{
+	return integrity_ops->verify_data(dentry);
+}
+
+static inline void integrity_measure(struct dentry *dentry,
+			const unsigned char *filename, int mask)
+{
+	return integrity_ops->measure(dentry, filename, mask);
+}
+#endif
Index: linux-2.6.17/security/Makefile
===================================================================
--- linux-2.6.17.orig/security/Makefile
+++ linux-2.6.17/security/Makefile
@@ -12,6 +12,7 @@ endif
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
+obj-$(CONFIG_SECURITY)			+= integrity.o integrity_dummy.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
Index: linux-2.6.17/security/integrity_dummy.h
===================================================================
--- /dev/null
+++ linux-2.6.17/security/integrity_dummy.h
@@ -0,0 +1,12 @@
+/*
+ * integrity_dummy.h
+ *
+ * Copyright (C) 2005,2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+extern struct integrity_operations dummy_integrity_ops;


