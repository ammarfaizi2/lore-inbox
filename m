Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTIPIHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbTIPIHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:07:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:65130 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261553AbTIPIHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:07:31 -0400
Date: Tue, 16 Sep 2003 10:07:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com, jakub@redhat.com
Subject: Add function attribute to copy_from_user to warn for unchecked results
Message-ID: <20030916100729.B19768@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gcc 3.4 (CVS) has a new function attribute (warn_unused_result) that
will make gcc spit out a warning in the event that a "marked" function's
result is ignored by the caller. The patch below adds a #define for this
attribute (conditional on compiler version), and uses this for
copy_from_user() and copy_to_user().
Callers of either of these functions basically are required for checking the return value
(quite often a missing check can be a security hole), now gcc will
generate a warning for this. Hopefully this will prevent future (security)
bugs due to this happening.

Greetings,
    Arjan van de Ven


diff -purN linux-2.6.0-test5/include.org/asm-i386/uaccess.h linux-2.6.0-test5/include/asm-i386/uaccess.h
--- linux-2.6.0-test5/include.org/asm-i386/uaccess.h	2003-09-08 21:49:53.000000000 +0200
+++ linux-2.6.0-test5/include/asm-i386/uaccess.h	2003-09-11 17:17:35.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <linux/string.h>
+#include <linux/compiler.h>
 #include <asm/page.h>
 
 #define VERIFY_READ 0
@@ -371,8 +371,8 @@ do {									\
 		: "m"(__m(addr)), "i"(errret), "0"(err))
 
 
-unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n);
-unsigned long __copy_from_user_ll(void *to, const void __user *from, unsigned long n);
+unsigned long __must_check __copy_to_user_ll(void __user *to, const void *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll(void *to, const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -395,7 +395,7 @@ unsigned long __copy_from_user_ll(void *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (__builtin_constant_p(n)) {
@@ -433,7 +433,7 @@ __copy_to_user(void __user *to, const vo
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (__builtin_constant_p(n)) {
@@ -467,7 +467,7 @@ __copy_from_user(void *to, const void __
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_sleep();
@@ -492,7 +492,7 @@ copy_to_user(void __user *to, const void
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
diff -purN linux-2.6.0-test5/include.org/linux/compiler.h linux-2.6.0-test5/include/linux/compiler.h
--- linux-2.6.0-test5/include.org/linux/compiler.h	2003-09-08 21:50:08.000000000 +0200
+++ linux-2.6.0-test5/include/linux/compiler.h	2003-09-11 17:15:52.000000000 +0200
@@ -15,6 +15,17 @@
 #define __inline	__inline__ __attribute__((always_inline))
 #endif
 
+/*
+ * GCC 3.4 and later have an attribute to mark a function in a way
+ * that if the calling code does not look at the return value, a warning
+ * is generated. Useful for things like copy_from_user().
+ */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
+#define __must_check __attribute__((warn_unused_result))
+#else
+#define __must_check 
+#endif
+
 /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
    a mechanism by which the user can annotate likely branch directions and
    expect the blocks to be reordered appropriately.  Define __builtin_expect
--- linux-2.6.0-test5/include/linux/poll.h~	2003-09-11 18:59:53.000000000 +0200
+++ linux-2.6.0-test5/include/linux/poll.h	2003-09-11 18:59:53.000000000 +0200
@@ -81,11 +81,13 @@
 	return 0;
 }
 
+/* warning: this function has no way to return -EFAULT on bad userspace access */
 static inline
 void set_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
 {
+	int dummy;
 	if (ufdset)
-		__copy_to_user(ufdset, fdset, FDS_BYTES(nr));
+		dummy = __copy_to_user(ufdset, fdset, FDS_BYTES(nr));
 }
 
 static inline
