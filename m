Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUANJSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbUANJSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:18:11 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:22912 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265660AbUANJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:15:52 -0500
Date: Wed, 14 Jan 2004 10:15:43 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: [PATCH] string fixes for gcc 3.4
Message-ID: <20040114091543.GA2024@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.4 optimizes sprintf(foo,"%s",string) into strcpy. Unfortunately
that isn't seen by the inliner and linux/i386 has no out-of-line strcpy
so you end up with a linker error.

This patch adds out of line copies for most string functions to avoid
this. Actually it doesn't export them to modules yet, that would
be the next step.

BTW In my opinion we shouldn't use inline string functions at all.
The __builtin_str* in modern gcc are better (I used them very successfully
on x86-64) and for the bigger functions like strrchr,strtok et.al. it just
doesn't make any sense to inline them or even code them in assembler.

Also fix the bcopy prototype gcc was complaining about.

-Andi

diff -u linux-34/lib/string.c-o linux-34/lib/string.c
--- linux-34/lib/string.c-o	2003-10-25 22:57:15.000000000 +0200
+++ linux-34/lib/string.c	2004-01-13 14:07:33.000000000 +0100
@@ -18,6 +18,8 @@
  *                    Matthew Hawkins <matt@mh.dropbear.id.au>
  * -  Kissed strtok() goodbye
  */
+
+#define IN_STRING_C 1
  
 #include <linux/types.h>
 #include <linux/string.h>
@@ -437,12 +439,13 @@
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-void bcopy(const char * src, char * dest, int count)
+void bcopy(const void * srcp, void * destp, size_t count)
 {
-	char *tmp = dest;
+	const char *src = srcp;
+	char *dest = destp;
 
 	while (count--)
-		*tmp++ = *src++;
+		*dest++ = *src++;
 }
 #endif
 
diff -u linux-34/include/asm-i386/string.h-o linux-34/include/asm-i386/string.h
--- linux-34/include/asm-i386/string.h-o	2004-01-09 09:27:18.000000000 +0100
+++ linux-34/include/asm-i386/string.h	2004-01-13 14:12:06.000000000 +0100
@@ -23,7 +23,10 @@
  *		consider these trivial functions to be PD.
  */
 
-#define __HAVE_ARCH_STRCPY
+/* AK: in fact I bet it would be better to move this stuff all out of line.
+ */
+#if !defined(IN_STRING_C)
+
 static inline char * strcpy(char * dest,const char *src)
 {
 int d0, d1, d2;
@@ -37,7 +40,6 @@
 return dest;
 }
 
-#define __HAVE_ARCH_STRNCPY
 static inline char * strncpy(char * dest,const char *src,size_t count)
 {
 int d0, d1, d2, d3;
@@ -56,7 +58,6 @@
 return dest;
 }
 
-#define __HAVE_ARCH_STRCAT
 static inline char * strcat(char * dest,const char * src)
 {
 int d0, d1, d2, d3;
@@ -73,7 +74,6 @@
 return dest;
 }
 
-#define __HAVE_ARCH_STRNCAT
 static inline char * strncat(char * dest,const char * src,size_t count)
 {
 int d0, d1, d2, d3;
@@ -96,7 +96,6 @@
 return dest;
 }
 
-#define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char * cs,const char * ct)
 {
 int d0, d1;
@@ -117,7 +116,6 @@
 return __res;
 }
 
-#define __HAVE_ARCH_STRNCMP
 static inline int strncmp(const char * cs,const char * ct,size_t count)
 {
 register int __res;
@@ -140,7 +138,6 @@
 return __res;
 }
 
-#define __HAVE_ARCH_STRCHR
 static inline char * strchr(const char * s, int c)
 {
 int d0;
@@ -159,7 +156,6 @@
 return __res;
 }
 
-#define __HAVE_ARCH_STRRCHR
 static inline char * strrchr(const char * s, int c)
 {
 int d0, d1;
@@ -176,6 +172,8 @@
 return __res;
 }
 
+#endif
+
 #define __HAVE_ARCH_STRLEN
 static inline size_t strlen(const char * s)
 {
