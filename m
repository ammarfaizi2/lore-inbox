Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267296AbSKPPgP>; Sat, 16 Nov 2002 10:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSKPPgP>; Sat, 16 Nov 2002 10:36:15 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:30659 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267296AbSKPPgO>; Sat, 16 Nov 2002 10:36:14 -0500
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <87d6p63ui2.fsf@goat.bogus.local> <3DD5E65A.59243812@digeo.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2.5.47: strdup()
Date: Sat, 16 Nov 2002 16:42:55 +0100
Message-ID: <87y97t34hs.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Olaf Dietsche wrote:
>> 
>> +char *strdup(const char *s)
>> +{
>> +       char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
>> +       if (p)
>> +               strcpy(p, s);
>> +
>> +       return p;
>>  }
>
> It's best to not assume GFP_KERNEL in there.  Make the caller
> pass in the required allocation mode.

Ok, here is my next try, trying to include your and the other
suggestions. As before, it compiles, but is untested.

Regards, Olaf.

diff -urN a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	Sat Oct  5 18:42:33 2002
+++ b/include/linux/string.h	Sat Nov 16 16:23:40 2002
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/gfp.h>		/* for GFP_KERNEL */
 
 #ifdef __cplusplus
 extern "C" {
@@ -15,7 +16,11 @@
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
+extern void *kmemdup(const void *, size_t, int);
 
+static inline char *kstrdup(const char *s, int flags)
+	{ return kmemdup(s, strlen(s) + 1, flags); }
+static inline char *strdup(const char *s) { return kstrdup(s, GFP_KERNEL); }
 
 /*
  * Include machine specific inline routines
diff -urN a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Nov 12 17:56:02 2002
+++ b/kernel/ksyms.c	Sat Nov 16 16:26:37 2002
@@ -576,6 +576,7 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(kmemdup);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -urN a/lib/string.c b/lib/string.c
--- a/lib/string.c	Sat Oct  5 18:42:33 2002
+++ b/lib/string.c	Sat Nov 16 16:22:46 2002
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -479,6 +480,20 @@
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
+void *kmemdup(const void *s, size_t n, int flags)
+{
+	void *p = kmalloc(n, flags);
+	if (p)
+		memcpy(p, s, n);
+
+	return p;
 }
 #endif
 
