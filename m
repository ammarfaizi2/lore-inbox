Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbSKPGOV>; Sat, 16 Nov 2002 01:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267230AbSKPGOV>; Sat, 16 Nov 2002 01:14:21 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:50882 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267229AbSKPGOT>; Sat, 16 Nov 2002 01:14:19 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] 2.5.47: strdup()
Date: Sat, 16 Nov 2002 07:21:09 +0100
Message-ID: <87d6p63ui2.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch adds strdup(). There are about five or six
different strdup() implementations in various parts of the kernel.

Regards, Olaf.

diff -urN a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	Sat Oct  5 18:42:33 2002
+++ b/include/linux/string.h	Sat Nov 16 03:09:42 2002
@@ -15,7 +15,7 @@
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+extern char *strdup(const char *);
 
 /*
  * Include machine specific inline routines
diff -urN a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Nov 12 17:56:02 2002
+++ b/kernel/ksyms.c	Sat Nov 16 06:53:09 2002
@@ -576,6 +576,7 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(strdup);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -urN a/lib/string.c b/lib/string.c
--- a/lib/string.c	Sat Oct  5 18:42:33 2002
+++ b/lib/string.c	Sat Nov 16 07:18:16 2002
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
+#ifndef __HAVE_ARCH_STRDUP
+/**
+ * strdup - allocate memory and duplicate a string
+ */
+char *strdup(const char *s)
+{
+	char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
+	if (p)
+		strcpy(p, s);
+
+	return p;
 }
 #endif
 
