Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEYIwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEYIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 04:52:41 -0400
Received: from smtp01.web.de ([217.72.192.180]:32533 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261603AbTEYIwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 04:52:37 -0400
Date: Sun, 25 May 2003 11:21:50 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-Id: <20030525112150.3994df9b.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about just adding a sane
> 
> 	int copy_string(char *dest, const char *src, int len)
> 	{
> 		int size;
> 
> 		if (!len)
> 			return 0;
> 		size = strlen(src);
> 		if (size >= len)
> 			size = len-1;
> 		memcpy(dest, src, size);
> 		dest[size] = '\0';
> 		return size;
> 	}
> 
> which is what pretty much everybody really _wants_ to have anyway? We 
> should deprecate "strncpy()" within the kernel entirely.

This looks suspiciously like strlcpy() from the *BSDs. Why not name it
so?

The following patch is based on Samba's implementation (found in
source/lib/replace.c). I just reformatted it somewhat, there are no
functional changes. What do you think?

René



diff -ur linux-a/kernel/ksyms.c linux-b/kernel/ksyms.c
--- linux-a/kernel/ksyms.c	2003-05-05 01:52:49.000000000 +0200
+++ linux-b/kernel/ksyms.c	2003-05-25 11:02:22.000000000 +0200
@@ -588,6 +588,7 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(strlcpy);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -ur linux-a/lib/string.c linux-b/lib/string.c
--- linux-a/lib/string.c	2003-05-05 01:53:40.000000000 +0200
+++ linux-b/lib/string.c	2003-05-25 11:12:58.000000000 +0200
@@ -527,3 +527,28 @@
 }
 
 #endif
+
+#ifndef __HAVE_ARCH_STRLCPY
+/**
+ * strlcpy - Copy a length-limited, %NUL-terminated string
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @bufsize: Size of the destination buffer
+ *
+ * Returns the length of @src, or 0 if @bufsize is 0. Unlike strncpy(),
+ * strlcpy() always NUL-terminates @dest and does no padding.
+ */
+size_t strlcpy(char *dest, const char *src, size_t bufsize)
+{
+	size_t len = strlen(src);
+	size_t ret = len;
+
+	if (bufsize == 0)
+		return 0;
+	if (len >= bufsize)
+		len = bufsize-1;
+	memcpy(dest, src, len);
+	dest[len] = '\0';   
+	return ret;
+}
+#endif
