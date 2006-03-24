Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWCXSNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCXSNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXSNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:30 -0500
Received: from [198.99.130.12] ([198.99.130.12]:38550 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751036AbWCXSN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:29 -0500
Message-Id: <200603241814.k2OIESh7005500@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/16] UML - Fix build warnings in __get_user
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a gcc warning about losing qualifiers to the first argument of
copy_from_user.  The typeof change for correctness, and fixes a lot
of the warnings, but there are some cases where x has some extra
qualifiers, like volatile, which copy_from_user can't know about.
For these, the void * cast seems to be necessary.

Also cleaned up some of the whitespace and got rid of the emacs comment
at the bottom.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.16.orig/include/asm-um/uaccess.h	2006-03-23 17:49:25.000000000 -0500
+++ linux-2.6.16/include/asm-um/uaccess.h	2006-03-23 18:41:57.000000000 -0500
@@ -41,16 +41,16 @@
 
 #define __get_user(x, ptr) \
 ({ \
-        const __typeof__(ptr) __private_ptr = ptr; \
-        __typeof__(*(__private_ptr)) __private_val; \
-        int __private_ret = -EFAULT; \
-        (x) = (__typeof__(*(__private_ptr)))0; \
-	if (__copy_from_user(&__private_val, (__private_ptr), \
-	    sizeof(*(__private_ptr))) == 0) {\
-        	(x) = (__typeof__(*(__private_ptr))) __private_val; \
-		__private_ret = 0; \
-	} \
-        __private_ret; \
+	const __typeof__(ptr) __private_ptr = ptr;	\
+	__typeof__(x) __private_val;			\
+	int __private_ret = -EFAULT;			\
+	(x) = (__typeof__(*(__private_ptr)))0;				\
+	if (__copy_from_user((void *) &__private_val, (__private_ptr),	\
+			     sizeof(*(__private_ptr))) == 0) {		\
+		(x) = (__typeof__(*(__private_ptr))) __private_val;	\
+		__private_ret = 0;					\
+	}								\
+	__private_ret;							\
 }) 
 
 #define get_user(x, ptr) \
@@ -89,14 +89,3 @@ struct exception_table_entry
 };
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

