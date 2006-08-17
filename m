Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWHQTyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWHQTyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWHQTyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:54:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34010 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030227AbWHQTyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:54:25 -0400
Subject: [RFC][PATCH 2/8] Integrity Service API and dummy provider
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:53:12 -0700
Message-Id: <1155844392.6788.56.camel@localhost.localdomain>
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

Updated to use more standard error returning per comments.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
 include/linux/integrity.h  |   90 +++++++++++++++++++++++++++++++++++
 security/Makefile          |    1
 security/integrity.c       |   45 +++++++++++++++++
 security/integrity_dummy.c |   77 +++++++++++++++++++++++++++++
 security/integrity_dummy.h |   12 ++++
 5 files changed, 225 insertions(+)

--- linux-2.6.18-rc3/security/integrity.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/integrity.c	2006-08-01 12:19:20.000000000 -0500
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
--- linux-2.6.18-rc3/security/integrity_dummy.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/integrity_dummy.c	2006-08-04 15:30:41.000000000 -0500
@@ -0,0 +1,77 @@
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
+				 int *status)
+{
+	char *value;
+	int size;
+	int error;
+
+	if (!xattr_value || !xattr_value_len || !status)
+		return -EINVAL;
+
+	if (!dentry || !dentry->d_inode || !dentry->d_inode->i_op
+	    || !dentry->d_inode->i_op->getxattr) {
+		return -EOPNOTSUPP;
+	}
+
+	size = dentry->d_inode->i_op->getxattr(dentry, xattr_name, NULL, 0);
+	if (size < 0) {
+		if (size == -ENODATA) {
+			*status = INTEGRITY_NOLABEL;
+			return 0;
+		}
+		return size;
+	}
+
+	value = kzalloc(size + 1, GFP_KERNEL);
+	if (!value) 
+		return -ENOMEM;
+
+	error = dentry->d_inode->i_op->getxattr(dentry, xattr_name,
+						value, size);
+	*xattr_value_len = size;
+	*xattr_value = value;
+	*status = INTEGRITY_PASS;
+	return error;
+}
+
+static int dummy_verify_data(struct dentry *dentry, int *status)
+{
+	if (status)
+		*status = INTEGRITY_PASS;
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
--- linux-2.6.18-rc3/include/linux/integrity.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/include/linux/integrity.h	2006-08-04 15:30:41.000000000 -0500
@@ -0,0 +1,90 @@
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
+ *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
+ * 		INTEGRITY_NOLABEL
+ *	Return 0 on success or errno values
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
+ *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
+ * 		INTEGRITY_NOLABEL
+ *	Return 0 on success or errno values
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
+#define PASS_STR "INTEGRITY_PASS"
+#define FAIL_STR "INTEGRITY_FAIL"
+#define NOLABEL_STR "INTEGRITY_NOLABEL"
+
+struct integrity_operations {
+	int (*verify_metadata) (struct dentry *dentry, char *xattr_name,
+			char **xattr_value, int *xattr_val_len, int *status);
+	int (*verify_data) (struct dentry *dentry, int *status);
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
+			int *xattr_val_len, int *status)
+{
+	return integrity_ops->verify_metadata(dentry, xattr_name,
+			xattr_value, xattr_val_len, status);
+}
+
+static inline int integrity_verify_data(struct dentry *dentry, 
+					int *status)
+{
+	return integrity_ops->verify_data(dentry, status);
+}
+
+static inline void integrity_measure(struct dentry *dentry,
+			const unsigned char *filename, int mask)
+{
+	return integrity_ops->measure(dentry, filename, mask);
+}
+#endif
--- linux-2.6.18-rc3/security/Makefile	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/security/Makefile	2006-08-01 12:21:24.000000000 -0500
@@ -12,6 +13,7 @@ endif
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
+obj-$(CONFIG_SECURITY)			+= integrity.o integrity_dummy.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
--- linux-2.6.18-rc3/security/integrity_dummy.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/integrity_dummy.h	2006-08-01 12:19:20.000000000 -0500
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


