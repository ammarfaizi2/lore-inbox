Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTEYSf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTEYSf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:35:57 -0400
Received: from smtp03.web.de ([217.72.192.158]:52746 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261985AbTEYSfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:35:54 -0400
Date: Sun, 25 May 2003 21:05:09 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>, Ben Collins <bcollins@debian.org>
Cc: Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-Id: <20030525210509.09429aaa.l.s.r@web.de>
In-Reply-To: <3ED0FC58.D1F04381@gmx.de>
References: <20030525112150.3994df9b.l.s.r@web.de>
	<3ED0FC58.D1F04381@gmx.de>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 19:24:40 +0200 Edgar Toernig <froese@gmx.de> wrote:
> René Scharfe wrote:
> > +       if (bufsize == 0)
> > +               return 0;
> 
>                   return ret; ???

Yes, Samba's and the BSDs' strlcpy() deviate in that point. It's a very
unusual case to have a zero-sized buffer, though, so probably it doesn't
matter much.

Anyway, I corrected this. Patch below contains a "BSD-compatible" version,
and also a strlcat().

Ben, I think this one is better than your's because it's shorter and
already GPL'd (there's not more license than C code :). Linus?

René



diff -ur linux-a/include/linux/string.h linux-b/include/linux/string.h
--- linux-a/include/linux/string.h	2003-05-05 01:53:13.000000000 +0200
+++ linux-b/include/linux/string.h	2003-05-25 19:25:01.000000000 +0200
@@ -77,6 +77,12 @@
 #ifndef __HAVE_ARCH_MEMCHR
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_STRLCPY
+__kernel_size_t strlcpy(char *, const char *, __kernel_size_t);
+#endif
+#ifndef __HAVE_ARCH_STRLCAT
+__kernel_size_t strlcat(char *, const char *, __kernel_size_t);
+#endif
 
 #ifdef __cplusplus
 }
diff -ur linux-a/kernel/ksyms.c linux-b/kernel/ksyms.c
--- linux-a/kernel/ksyms.c	2003-05-05 01:52:49.000000000 +0200
+++ linux-b/kernel/ksyms.c	2003-05-25 19:25:21.000000000 +0200
@@ -588,6 +588,8 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(strlcpy);
+EXPORT_SYMBOL(strlcat);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -ur linux-a/lib/string.c linux-b/lib/string.c
--- linux-a/lib/string.c	2003-05-05 01:53:40.000000000 +0200
+++ linux-b/lib/string.c	2003-05-25 20:54:34.000000000 +0200
@@ -5,6 +5,11 @@
  */
 
 /*
+ * The implementations of strlcpy() and strlcat() are taken from Samba, and
+ * Copyright (C) 2001 Andrew Tridgell.
+ */
+
+/*
  * stupid library routines.. The optimized versions should generally be found
  * as inline code in <asm-xx/string.h>
  *
@@ -527,3 +532,54 @@
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
+ * Returns the length of @src. Unlike strncpy(), strlcpy() always
+ * %NUL-terminates @dest (unless @bufsize is 0) and does no padding.
+ */
+size_t strlcpy(char *dest, const char *src, size_t bufsize)
+{
+	size_t len = strlen(src);
+	size_t ret = len;
+
+	if (bufsize > 0)
+		return ret;
+	if (len >= bufsize)
+		len = bufsize-1;
+	memcpy(dest, src, len);
+	dest[len] = '\0';   
+	return ret;
+}
+#endif
+
+#ifndef __HAVE_ARCH_STRLCAT
+/**
+ * strlcat - Append a length-limited, %NUL-terminated string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ * @bufsize: Size of the destination buffer
+ *
+ * Returns the sum of the initial lengths of @src and @dest. The resulting
+ * string is always %NUL-terminated (unless @bufsize is 0).
+ */
+size_t strlcat(char *dest, const char *src, size_t bufsize)
+{
+	size_t len1 = strlen(dest);
+	size_t len2 = strlen(src);
+	size_t ret = len1 + len2;
+
+	if (len1+len2 >= bufsize)
+		len2 = bufsize - (len1+1);
+	if (len2 > 0) {
+		memcpy(dest+len1, src, len2);
+		dest[len1+len2] = '\0';
+	}
+	return ret;
+}
+#endif
