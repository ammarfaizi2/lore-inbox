Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTANLkO>; Tue, 14 Jan 2003 06:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbTANLkO>; Tue, 14 Jan 2003 06:40:14 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:54414 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262384AbTANLkK>; Tue, 14 Jan 2003 06:40:10 -0500
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
References: <20030114025452.656612C385@lists.samba.org>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Date: Tue, 14 Jan 2003 12:48:11 +0100
Message-ID: <87bs2kkl50.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Everyone loves reimplementing strdup.

Really? ;-) SCNR

Please consider this one or parts of it:
<http://groups.google.com/groups?selm=87y97t34hs.fsf%40goat.bogus.local>

Rediffed against 2.5.58 below.

Regards, Olaf.

diff -urN a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	Mon Nov 18 10:33:57 2002
+++ b/include/linux/string.h	Tue Jan 14 12:37:29 2003
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/gfp.h>		/* for GFP_KERNEL */
 
 #ifdef __cplusplus
 extern "C" {
@@ -16,6 +17,11 @@
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
+extern void *kmemdup(const void *, __kernel_size_t, int);
+  
+static inline char *kstrdup(const char *s, int flags)
+	{ return kmemdup(s, strlen(s) + 1, flags); }
+static inline char *strdup(const char *s) { return kstrdup(s, GFP_KERNEL); }
 
 /*
  * Include machine specific inline routines
diff -urN a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Jan 14 12:31:42 2003
+++ b/kernel/ksyms.c	Tue Jan 14 12:33:41 2003
@@ -586,6 +586,7 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(kmemdup);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -urN a/lib/string.c b/lib/string.c
--- a/lib/string.c	Mon Nov 18 10:33:58 2002
+++ b/lib/string.c	Tue Jan 14 12:39:55 2003
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -502,6 +503,20 @@
 		s1++;
 	}
 	return NULL;
+}
+#endif
+
+#ifndef __HAVE_ARCH_KMEMDUP
+/**
+ * kmemdup - allocate memory and duplicate a string
+ */
+void *kmemdup(const void *s, __kernel_size_t n, int flags)
+{
+	void *p = kmalloc(n, flags);
+	if (p)
+		memcpy(p, s, n);
+
+	return p;
 }
 #endif
 
