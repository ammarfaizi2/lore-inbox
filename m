Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTINLR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTINLRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:17:17 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:50078 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262366AbTINLRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:17:14 -0400
Message-ID: <3F644E36.5010402@colorfullife.com>
Date: Sun, 14 Sep 2003 13:17:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add likely around access_ok for uaccess
Content-Type: multipart/mixed;
 boundary="------------050303000609020108050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050303000609020108050308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

while trying to figure out why sysv msg is around 30% slower than pipes 
for data transfers I noticed that gcc's autodetection (3.2.2) guesses 
the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
into the direct path and the copy out of line.

The attached patch adds likely to the tests - any objections? What about 
the archs except i386?

--
    Manfred

--------------050303000609020108050308
Content-Type: text/plain;
 name="patch-uaccess-likely"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-uaccess-likely"

--- 2.6/include/asm-i386/uaccess.h	2003-09-12 21:53:58.000000000 +0200
+++ build-2.6/include/asm-i386/uaccess.h	2003-09-14 12:56:19.000000000 +0200
@@ -300,7 +300,7 @@
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
 	might_sleep();						\
-	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
+	if (likely(access_ok(VERIFY_WRITE,__pu_addr,size)))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
 	__pu_err;							\
 })							
@@ -510,7 +510,7 @@
 direct_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_sleep();
-	if (access_ok(VERIFY_WRITE, to, n))
+	if (likely(access_ok(VERIFY_WRITE, to, n)))
 		n = __direct_copy_to_user(to, from, n);
 	return n;
 }
@@ -535,7 +535,7 @@
 direct_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
-	if (access_ok(VERIFY_READ, from, n))
+	if (likely(access_ok(VERIFY_READ, from, n)))
 		n = __direct_copy_from_user(to, from, n);
 	else
 		memset(to, 0, n);

--------------050303000609020108050308--

