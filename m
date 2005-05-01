Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVEAKWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVEAKWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 06:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEAKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 06:21:52 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:4498 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261581AbVEAKVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 06:21:16 -0400
Subject: [patch 1/1] x86_64: make string func definition work as intended
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       ak@suse.de
From: blaisorblade@yahoo.it
Date: Sun, 01 May 2005 21:08:51 +0200
Message-Id: <20050501190851.5FD5B45EBB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Andi Kleen <ak@suse.de>

In include/asm-x86_64/string.h there are such comments:

/* Use C out of line version for memcmp */ 
#define memcmp __builtin_memcmp
int memcmp(const void * cs,const void * ct,size_t count);

This would mean that if the compiler does not decide to use __builtin_memcmp,
it emits a call to memcmp to be satisfied by the C out-of-line version in
lib/string.c. What happens is that after preprocessing, in lib/string.i you
may find the definition of "__builtin_strcmp".

Actually, by accident, in the object you will find the definition of
strcmp and such (maybe a trick intended to redirect calls to __builtin_memcmp
to the default memcmp when the definition is not expanded); however, this
particular case is not a documented feature as far as I can see.

Also, the EXPORT_SYMBOL does not work, so it's duplicated in the arch.

I simply added some #undef to lib/string.c and removed the (now duplicated)
exports in x86-64 and UML/x86_64 subarchs (the second ones are introduced by
another patch I just posted for -mm).

I agree this can be a bit kludgy, so if you want add another solution.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/sys-x86_64/ksyms.c       |    3 ---
 linux-2.6.12-paolo/arch/x86_64/kernel/x8664_ksyms.c |   13 -------------
 linux-2.6.12-paolo/lib/string.c                     |    4 ++++
 3 files changed, 4 insertions(+), 16 deletions(-)

diff -puN include/asm-x86_64/string.h~x86_64-string-func include/asm-x86_64/string.h
diff -puN lib/string.c~x86_64-string-func lib/string.c
--- linux-2.6.12/lib/string.c~x86_64-string-func	2005-05-01 20:45:29.000000000 +0200
+++ linux-2.6.12-paolo/lib/string.c	2005-05-01 20:45:29.000000000 +0200
@@ -65,6 +65,7 @@ EXPORT_SYMBOL(strnicmp);
  * @dest: Where to copy the string to
  * @src: Where to copy the string from
  */
+#undef strcpy
 char * strcpy(char * dest,const char *src)
 {
 	char *tmp = dest;
@@ -132,6 +133,7 @@ EXPORT_SYMBOL(strlcpy);
  * @dest: The string to be appended to
  * @src: The string to append to it
  */
+#undef strcat
 char * strcat(char * dest, const char * src)
 {
 	char *tmp = dest;
@@ -209,6 +211,7 @@ EXPORT_SYMBOL(strlcat);
  * @cs: One string
  * @ct: Another string
  */
+#undef strcmp
 int strcmp(const char * cs,const char * ct)
 {
 	register signed char __res;
@@ -514,6 +517,7 @@ EXPORT_SYMBOL(memmove);
  * @ct: Another area of memory
  * @count: The size of the area.
  */
+#undef memcmp
 int memcmp(const void * cs,const void * ct,size_t count)
 {
 	const unsigned char *su1, *su2;
diff -puN arch/x86_64/kernel/x8664_ksyms.c~x86_64-string-func arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.12/arch/x86_64/kernel/x8664_ksyms.c~x86_64-string-func	2005-05-01 20:45:29.000000000 +0200
+++ linux-2.6.12-paolo/arch/x86_64/kernel/x8664_ksyms.c	2005-05-01 20:45:29.000000000 +0200
@@ -139,35 +139,23 @@ EXPORT_SYMBOL_GPL(unset_nmi_callback);
 #undef memmove
 #undef memchr
 #undef strlen
-#undef strcpy
 #undef strncmp
 #undef strncpy
 #undef strchr	
-#undef strcmp 
-#undef strcpy 
-#undef strcat
-#undef memcmp
 
 extern void * memset(void *,int,__kernel_size_t);
 extern size_t strlen(const char *);
 extern void * memmove(void * dest,const void *src,size_t count);
-extern char * strcpy(char * dest,const char *src);
-extern int strcmp(const char * cs,const char * ct);
 extern void *memchr(const void *s, int c, size_t n);
 extern void * memcpy(void *,const void *,__kernel_size_t);
 extern void * __memcpy(void *,const void *,__kernel_size_t);
-extern char * strcat(char *, const char *);
-extern int memcmp(const void * cs,const void * ct,size_t count);
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strncat);
 EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(strrchr);
@@ -175,7 +163,6 @@ EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(memcmp);
 
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /* prototypes are wrong, these are assembly with custom calling functions */
diff -puN arch/um/sys-x86_64/ksyms.c~x86_64-string-func arch/um/sys-x86_64/ksyms.c
--- linux-2.6.12/arch/um/sys-x86_64/ksyms.c~x86_64-string-func	2005-05-01 20:45:29.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/ksyms.c	2005-05-01 20:45:29.000000000 +0200
@@ -14,9 +14,6 @@ EXPORT_SYMBOL(__up_wakeup);
 
 /*XXX: we need them because they would be exported by x86_64 */
 EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strcpy);
 
 /* Networking helper routines. */
 /*EXPORT_SYMBOL(csum_partial_copy_from);
_
