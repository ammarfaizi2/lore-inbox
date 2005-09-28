Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVI1XMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVI1XMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVI1XMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:12:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21414 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751223AbVI1XMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:12:14 -0400
Date: Thu, 29 Sep 2005 00:12:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ia64 basic __user annotations
Message-ID: <20050928231213.GG7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* document places where we pass kernel address to low-level
primitive that deals with kernel/user addresses
	* uintptr_t is unsigned long, not long
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-armv-iomem/include/asm-ia64/uaccess.h RC14-rc2-git6-ia64-user/include/asm-ia64/uaccess.h
--- RC14-rc2-git6-armv-iomem/include/asm-ia64/uaccess.h	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git6-ia64-user/include/asm-ia64/uaccess.h	2005-09-28 13:02:04.000000000 -0400
@@ -187,8 +187,8 @@
 ({											\
 	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);				\
 	__typeof__ (size) __gu_size = (size);						\
-	long __gu_err = -EFAULT, __gu_val = 0;						\
-											\
+	long __gu_err = -EFAULT;							\
+	unsigned long __gu_val = 0;							\
 	if (!check || __access_ok(__gu_ptr, size, segment))				\
 		switch (__gu_size) {							\
 		      case 1: __get_user_size(__gu_val, __gu_ptr, 1, __gu_err); break;	\
@@ -240,13 +240,13 @@
 static inline unsigned long
 __copy_to_user (void __user *to, const void *from, unsigned long count)
 {
-	return __copy_user(to, (void __user *) from, count);
+	return __copy_user(to, (__force void __user *) from, count);
 }
 
 static inline unsigned long
 __copy_from_user (void *to, const void __user *from, unsigned long count)
 {
-	return __copy_user((void __user *) to, from, count);
+	return __copy_user((__force void __user *) to, from, count);
 }
 
 #define __copy_to_user_inatomic		__copy_to_user
@@ -258,7 +258,7 @@
 	long __cu_len = (n);								\
 											\
 	if (__access_ok(__cu_to, __cu_len, get_fs()))					\
-		__cu_len = __copy_user(__cu_to, (void __user *) __cu_from, __cu_len);	\
+		__cu_len = __copy_user(__cu_to, (__force void __user *) __cu_from, __cu_len);	\
 	__cu_len;									\
 })
 
@@ -270,7 +270,7 @@
 											\
 	__chk_user_ptr(__cu_from);							\
 	if (__access_ok(__cu_from, __cu_len, get_fs()))					\
-		__cu_len = __copy_user((void __user *) __cu_to, __cu_from, __cu_len);	\
+		__cu_len = __copy_user((__force void __user *) __cu_to, __cu_from, __cu_len);	\
 	__cu_len;									\
 })
 
