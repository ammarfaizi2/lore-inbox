Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVCLQ4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVCLQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVCLQ4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:56:21 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6823 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261966AbVCLQ4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:56:01 -0500
Message-ID: <42331F1D.6090202@colorfullife.com>
Date: Sat, 12 Mar 2005 17:55:57 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix put_user for 80386
Content-Type: multipart/mixed;
 boundary="------------030602000407050003090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030602000407050003090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Linus noticed that put_user doesn't to the manual page table lookup that 
is required for cpus without a working WP flag. The solution is simple: 
if CONFIG_X86_WP_WORKS_OK is not set, then the put_user macros must call 
__copy_to_user_ll(). That function contains the required checks.
This is already implemented for __put_user_size(), somehow I overlooked 
__put_user_{1,2,4,8,X}.

What do you think?
Patch against 2.6.11-mm2, test booted with bochs.

--
    Manfred

--------------030602000407050003090302
Content-Type: text/plain;
 name="patch-uaccess-80386"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-uaccess-80386"

--- 2.6/include/asm-i386/uaccess.h	2005-03-12 01:05:49.000000000 +0100
+++ build-2.6/include/asm-i386/uaccess.h	2005-03-12 17:37:27.938115959 +0100
@@ -217,6 +217,8 @@
  *
  * Returns zero on success, or -EFAULT on error.
  */
+#ifdef CONFIG_X86_WP_WORKS_OK
+
 #define put_user(x,ptr)						\
 ({	int __ret_pu;						\
 	__chk_user_ptr(ptr);					\
@@ -230,6 +232,21 @@
 	__ret_pu;						\
 })
 
+#else
+#define put_user(x,ptr)						\
+({								\
+ 	int __ret_pu;						\
+	__typeof__(*(ptr)) __pus_tmp = x;			\
+	__ret_pu=0;						\
+	if(unlikely(__copy_to_user_ll(ptr, &__pus_tmp,		\
+				sizeof(*(ptr))) != 0))		\
+ 		__ret_pu=-EFAULT;				\
+ 	__ret_pu;						\
+ })
+
+
+#endif
+
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
  * @x:   Variable to store result.

--------------030602000407050003090302--
