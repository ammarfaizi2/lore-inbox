Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266102AbSKEAsN>; Mon, 4 Nov 2002 19:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSKEApw>; Mon, 4 Nov 2002 19:45:52 -0500
Received: from dp.samba.org ([66.70.73.150]:27071 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265607AbSKEApi>;
	Mon, 4 Nov 2002 19:45:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module loader against 2.5.46: 4/9 
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:31:41 +1100
Message-Id: <20021105005213.EC9672C0F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now we reintroduce features: first a trivial patch to implement
"strcspn" for module parameter parsing.

Linus, please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: strcspn patch
Author: Rusty Russell
Status: Experimental

D: This patch implements a generic strcspn.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17889-2.5.36-param.pre/include/linux/string.h .17889-2.5.36-param/include/linux/string.h
--- .17889-2.5.36-param.pre/include/linux/string.h	2002-06-06 21:38:40.000000000 +1000
+++ .17889-2.5.36-param/include/linux/string.h	2002-09-19 16:15:20.000000000 +1000
@@ -15,7 +15,7 @@ extern "C" {
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+extern __kernel_size_t strcspn(const char *,const char *);
 
 /*
  * Include machine specific inline routines
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17889-2.5.36-param.pre/lib/string.c .17889-2.5.36-param/lib/string.c
--- .17889-2.5.36-param.pre/lib/string.c	2002-05-24 15:20:35.000000000 +1000
+++ .17889-2.5.36-param/lib/string.c	2002-09-19 16:15:20.000000000 +1000
@@ -272,6 +272,29 @@ size_t strspn(const char *s, const char 
 }
 #endif
 
+/**
+ * strcspn - Calculate the length of the initial substring of @s which does
+ * 	not contain letters in @reject
+ * @s: The string to be searched
+ * @reject: The string to avoid
+ */
+size_t strcspn(const char *s, const char *reject)
+{
+	const char *p;
+	const char *r;
+	size_t count = 0;
+
+	for (p = s; *p != '\0'; ++p) {
+		for (r = reject; *r != '\0'; ++r) {
+			if (*p == *r)
+				return count;
+		}
+		++count;
+	}
+
+	return count;
+}	
+
 #ifndef __HAVE_ARCH_STRPBRK
 /**
  * strpbrk - Find the first occurrence of a set of characters
