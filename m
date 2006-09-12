Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWILR7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWILR7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWILR6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:58:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46258 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030312AbWILR56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:57:58 -0400
Subject: [PATCH 4/7] SLIM: secfs patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:57:52 -0700
Message-Id: <1158083873.18137.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the securityfs used by SLIM.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
 security/slim/slm_secfs.c |   73 ++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+)

--- linux-2.6.18/security/slim/slm_secfs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-working/security/slim/slm_secfs.c	2006-09-06 11:49:09.000000000 -0700
@@ -0,0 +1,73 @@
+/*
+ * SLIM securityfs support: debugging control files
+ *
+ * Copyright (C) 2005, 2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *	   Kylene Hall <kjhall@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <asm/uaccess.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/debugfs.h>
+#include "slim.h"
+
+static struct dentry *slim_sec_dir, *slim_level;
+
+static ssize_t slm_read_level(struct file *file, char __user *buf,
+			      size_t buflen, loff_t *ppos)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+	ssize_t len;
+	char data[28]; 
+	if (is_kernel_thread(current))
+		len = snprintf(data, sizeof(data), "KERNEL\n");
+	else if (!cur_tsec)
+		len = snprintf(data, sizeof(data), "UNKNOWN\n");
+	else {
+		if (cur_tsec->iac_wx != cur_tsec->iac_r)
+			len = snprintf(data, sizeof(data), "GUARD wx:%s r:%s\n",
+				      slm_iac_str[cur_tsec->iac_wx],
+				      slm_iac_str[cur_tsec->iac_r]);
+		else
+			len = snprintf(data, sizeof(data), "%s\n",
+				      slm_iac_str[cur_tsec->iac_wx]);
+	}
+	return simple_read_from_buffer(buf, buflen, ppos, data, len);
+}
+
+static struct file_operations slm_level_ops = {
+	.read = slm_read_level,
+};
+
+int __init slm_init_secfs(void)
+{
+	if (!slim_enabled)
+		return 0;
+
+	slim_sec_dir = securityfs_create_dir("slim", NULL);
+	if (!slim_sec_dir || IS_ERR(slim_sec_dir))
+		return -EFAULT;
+	slim_level = securityfs_create_file("level", S_IRUGO,
+					    slim_sec_dir, NULL, &slm_level_ops);
+	if (!slim_level || IS_ERR(slim_level)) {
+		securityfs_remove(slim_sec_dir);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+__initcall(slm_init_secfs);
+
+void __exit slm_cleanup_secfs(void)
+{
+	securityfs_remove(slim_level);
+	securityfs_remove(slim_sec_dir);
+}
+


