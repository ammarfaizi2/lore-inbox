Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422878AbWBNXsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422878AbWBNXsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWBNXsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:48:00 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:38591 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422875AbWBNXr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:47:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IwtLwizRFI4VFvKPc4a9P0zYo+4HP1r7KvWO+YH0LUEpfQQLQb7e6LQ1QDko5s0HDTfL99BIIUekv6r62dr8JmTB9wxJJ3sCmdIkcntUuF8sNmU+RhTPMMFwzYcP2FsJTODGjsBjr6rKWuiBbQwr/O376J3gyAUiln/G/vfXnko=
Date: Tue, 14 Feb 2006 21:47:47 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: akpm@osdl.org
Cc: davi.arnaut@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATH 0/2] strndup_user, description
Message-Id: <20060214214747.ef05e4d8.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series creates a strndup_user() function in order to avoid duplicated
and error-prone (userspace modifying the string after the strlen_user()) code.

The diffstat:

 include/linux/string.h |    3 +
 kernel/module.c        |   19 +-------
 mm/util.c              |   37 +++++++++++++++
 security/keys/keyctl.c |  116 ++++++++++---------------------------------------
 4 files changed, 68 insertions(+), 107 deletions(-)

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/include/linux/string.h b/include/linux/string.h
index 369be32..2cb2dc8 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -18,6 +18,9 @@ extern char * strsep(char **,const char 
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
 
+#define strdup_user(s)	strndup_user(s, PAGE_SIZE)
+extern char *strndup_user(const char __user *, long);
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
