Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSETHVr>; Mon, 20 May 2002 03:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSETHVq>; Mon, 20 May 2002 03:21:46 -0400
Received: from stingr.net ([212.193.32.15]:50369 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S312681AbSETHVo>;
	Mon, 20 May 2002 03:21:44 -0400
Date: Mon, 20 May 2002 11:21:40 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Funny but maybe useful change
Message-ID: <20020520072140.GA6021@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It speaks about itself

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.404   -> 1.405  
#	        lib/Makefile	1.7     -> 1.8    
#	include/linux/string.h	1.2     -> 1.3    
#	               (new)	        -> 1.1     lib/strlcpy.c  
#	               (new)	        -> 1.1     lib/strlcat.c  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/18	stingray@proxy.sgu.ru	1.405
# Add strlcpy and strlcat (basic)
# --------------------------------------------
#
diff -Nru a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	Mon May 20 11:05:11 2002
+++ b/include/linux/string.h	Mon May 20 11:05:11 2002
@@ -60,6 +60,13 @@
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_STRLCPY
+extern __kernel_size_t strlcpy(char *, const char *, __kernel_size_t);
+#endif
+#ifndef __HAVE_ARCH_STRLCAT
+extern __kernel_size_t strlcat(char *, const char *, __kernel_size_t);
+#endif
+
 
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Mon May 20 11:05:11 2002
+++ b/lib/Makefile	Mon May 20 11:05:11 2002
@@ -11,6 +11,7 @@
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y += strlcat.o strlcpy.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/strlcat.c b/lib/strlcat.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/strlcat.c	Mon May 20 11:05:11 2002
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+
+#ifndef __HAVE_ARCH_STRLCAT
+
+/**
+ * Appends src to string dst of size siz (unlike strncat, siz is the
+ * full size of dst, not space left).  At most siz-1 characters
+ * will be copied.  Always NUL terminates (unless siz <= strlen(dst)).
+ * Returns strlen(src) + MIN(siz, strlen(initial dst)).
+ * If retval >= siz, truncation occurred.
+ */
+size_t strlcat(char* dst, const char* src, size_t siz)
+{
+	register char *d = dst;
+	register const char *s = src;
+	register size_t n = siz;
+	size_t dlen;
+
+	/* Find the end of dst and adjust bytes left but don't go past end */
+	while (n-- != 0 && *d != '\0')
+		d++;
+	dlen = d - dst;
+	n = siz - dlen;
+
+	if (n == 0)
+		return(dlen + strlen(s));
+	while (*s != '\0') {
+		if (n != 1) {
+			*d++ = *s;
+			n--;
+		}
+		s++;
+	}
+	*d = '\0';
+
+	return(dlen + (s - src));	/* count does not include NUL */
+}
+
+#endif
diff -Nru a/lib/strlcpy.c b/lib/strlcpy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/strlcpy.c	Mon May 20 11:05:11 2002
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+
+#ifndef __HAVE_ARCH_STRLCPY
+
+/**
+ * Copy src to string dst of size siz.  At most siz-1 characters
+ * will be copied.  Always NUL terminates (unless siz == 0).
+ * Returns strlen(src); if retval >= siz, truncation occurred.
+ * 
+ */
+size_t strlcpy(char* dst, const char* src, size_t siz)
+{
+	register char *d = dst;
+	register const char *s = src;
+	register size_t n = siz;
+
+	/* Copy as many bytes as will fit */
+	if (n != 0 && --n != 0) {
+		do {
+			if ((*d++ = *s++) == 0)
+				break;
+		} while (--n != 0);
+	}
+
+	/* Not enough room in dst, add NUL and traverse rest of src */
+	if (n == 0) {
+		if (siz != 0)
+			*d = '\0';		/* NUL-terminate dst */
+		while (*s++)
+			;
+	}
+
+	return(s - src - 1);	/* count does not include NUL */
+}
+#endif


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
