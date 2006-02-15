Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWBOUXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWBOUXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWBOUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:23:13 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:37574 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWBOUXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:23:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=N95ZOhTYNWCVQN9Wk9yVwR/evO7ww6Gsic8IurUC5akLEezzErzyrkiZzuskPIjz8fXkGS2MzNmsdGhgXcbQ190RJyRJzMf81lbsq5UYZfU6MH47T0E53qJJrn4J/NVIxHRwEqcq9PbjXeuM3jhzRNTiAIT2O6ve6yFekJmczN0=
Date: Wed, 15 Feb 2006 18:22:58 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: torvalds@osdl.org
Cc: davi.arnaut@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] strndup_user, v2
Message-Id: <20060215182258.03505613.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series creates a strndup_user() function in order to avoid duplicated
and error-prone (userspace modifying the string after the strlen_user()) code.

v2: Inline strdup_user and fixed a bogus strdup_user usage.

The diffstat:

 include/linux/string.h |    7 ++
 kernel/module.c        |   19 +-------
 mm/util.c              |   37 +++++++++++++++
 security/keys/keyctl.c |  116 ++++++++++---------------------------------------
 4 files changed, 72 insertions(+), 107 deletions(-)


Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/include/linux/string.h b/include/linux/string.h
index 369be32..8fbf139 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -18,6 +18,13 @@ extern char * strsep(char **,const char 
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
 
+extern char *strndup_user(const char __user *, long);
+
+static inline char *strdup_user(const char __user *s)
+{
+	return strndup_user(s, 4096);
+}
+
 /*
  * Include machine specific inline routines
  */
diff --git a/mm/util.c b/mm/util.c
index 5f4bb59..09c2c3b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1,6 +1,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/err.h>
+#include <asm/uaccess.h>
 
 /**
  * kzalloc - allocate memory. The memory is set to zero.
@@ -37,3 +39,38 @@ char *kstrdup(const char *s, gfp_t gfp)
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
+
+/*
+ * strndup_user - duplicate an existing string from user space
+ *
+ * @s: The string to duplicate
+ * @n: Maximum number of bytes to copy, including the trailing NUL.
+ */
+char *strndup_user(const char __user *s, long n)
+{
+	char *p;
+	long length;
+
+	length = strlen_user(s);
+
+	if (!length)
+		return ERR_PTR(-EFAULT);
+
+	if (length > n)
+		length = n;
+
+	p = kmalloc(length, GFP_KERNEL);
+
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (strncpy_from_user(p, s, length) < 0) {
+		kfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+
+	p[length - 1] = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL(strndup_user);
