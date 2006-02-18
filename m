Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWBRNgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWBRNgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBRNgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:36:04 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:44938 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751249AbWBRNgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:36:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HQdfSXWQ503KiWmmrxgQAR1aTMTF0Qeo5+jQnFIAafayPOw5NdEfUq8Vwz6k0g/tzlVFIRFR7d7MnRKAJJIwGp1vMI+HCYJffYzbYDScOwMwOooDTkTRa0VYoBDXGxQF9icTV/BnD+JUkt+a52PQ0qOnKoUo7Dw1Vwqdpaqo4pM=
Date: Sat, 18 Feb 2006 11:35:48 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: akpm@osdl.org
Cc: davi.arnaut@gmail.com, vsu@altlinux.ru, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] strndup_user, v3
Message-Id: <20060218113548.8ee8845c.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch series creates a strndup_user() function in order to avoid duplicated
and error-prone (userspace modifying the string after the strlen_user()) code.

v3: Removed strdup_user in favor of only strndup_user.

I hope to have addressed all concerns.

The diffstat:

 include/linux/string.h |    2
 kernel/module.c        |   19 +-------
 mm/util.c              |   37 +++++++++++++++
 security/keys/keyctl.c |  116 ++++++++++---------------------------------------
 4 files changed, 67 insertions(+), 107 deletions(-)

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/include/linux/string.h b/include/linux/string.h
index 369be32..dee2214 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -18,6 +18,8 @@ extern char * strsep(char **,const char 
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
 
+extern char *strndup_user(const char __user *, long);
+
 /*
  * Include machine specific inline routines
  */
diff --git a/mm/util.c b/mm/util.c
index 5f4bb59..49e29f7 100644
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
+	length = strnlen_user(s, n);
+
+	if (!length)
+		return ERR_PTR(-EFAULT);
+
+	if (length > n)
+		return ERR_PTR(-EINVAL);
+
+	p = kmalloc(length, GFP_KERNEL);
+
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(p, s, length)) {
+		kfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+
+	p[length - 1] = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL(strndup_user);
