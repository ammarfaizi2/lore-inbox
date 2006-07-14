Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWGNRYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWGNRYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWGNRYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:24:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61357 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422662AbWGNRYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:24:37 -0400
Subject: [RFC][PATCH 4/6] slim: secfs patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:24:42 -0700
Message-Id: <1152897882.23584.7.camel@localhost.localdomain>
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

--- linux-2.6.17/security/slim/slm_secfs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17/security/slim/slm_secfs.c	2006-07-13 16:28:17.000000000 -0700
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
+	char *page = (char *)__get_free_page(GFP_KERNEL);
+	
+	if (!page)
+		return -ENOMEM;
+
+	if (is_kernel_thread(current))
+		len = sprintf(page, "level: KERNEL\n");
+	else if (!cur_tsec)
+		len = sprintf(page, "level: UNKNOWN\n");
+	else {
+		if (cur_tsec->iac_wx != cur_tsec->iac_r)
+			len = sprintf(page, "level: GUARD wx:%s r:%s\n",
+				      slm_iac_str[cur_tsec->iac_wx],
+				      slm_iac_str[cur_tsec->iac_r]);
+		else
+			len = sprintf(page, "level: %s\n",
+				      slm_iac_str[cur_tsec->iac_wx]);
+	}
+	len = simple_read_from_buffer(buf, buflen, ppos, page, len);
+	free_page((unsigned long)page);
+	return len;
+}
+
+static struct file_operations slm_level_ops = {
+	.read = slm_read_level,
+};
+
+int __init slm_init_secfs(void)
+{
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
+void __exit slm_cleanup_secfs(void)
+{
+	securityfs_remove(slim_level);
+	securityfs_remove(slim_sec_dir);
+}


