Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWGJLQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWGJLQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGJLP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:15:28 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:22479 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751385AbWGJLPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:15:24 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 7/9] -Wshadow: fixes for checksum.h
Date: Mon, 10 Jul 2006 13:13:31 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101313.31310.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Some -Wshadow fixes for include/[asm-i386|net]/checksum.h

 include/asm/checksum.h:185: warning: declaration of 'sum' shadows a parameter
 include/asm/checksum.h:181: warning: shadowed declaration is here
 include/net/checksum.h:33: warning: declaration of 'sum' shadows a parameter
 include/net/checksum.h:31: warning: shadowed declaration is here


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/asm-i386/checksum.h |    4 ++--
 include/net/checksum.h      |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc1-orig/include/asm-i386/checksum.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc1/include/asm-i386/checksum.h	2006-07-09 21:12:34.000000000 +0200
@@ -178,12 +178,12 @@ static __inline__ unsigned short int csu
 #define HAVE_CSUM_COPY_USER
 static __inline__ unsigned int csum_and_copy_to_user(const unsigned char *src,
 						     unsigned char __user *dst,
-						     int len, int sum, 
+						     int len, int csum,
 						     int *err_ptr)
 {
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, dst, len))
-		return csum_partial_copy_generic(src, (__force unsigned char *)dst, len, sum, NULL, err_ptr);
+		return csum_partial_copy_generic(src, (__force unsigned char *)dst, len, csum, NULL, err_ptr);
 
 	if (len)
 		*err_ptr = -EFAULT;
--- linux-2.6.18-rc1-orig/include/net/checksum.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc1/include/net/checksum.h	2006-07-09 21:13:22.000000000 +0200
@@ -28,27 +28,27 @@
 #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
 unsigned int csum_and_copy_from_user (const unsigned char __user *src, unsigned char *dst,
-				      int len, int sum, int *err_ptr)
+				      int len, int csum, int *err_ptr)
 {
 	if (access_ok(VERIFY_READ, src, len))
-		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+		return csum_partial_copy_from_user(src, dst, len, csum, err_ptr);
 
 	if (len)
 		*err_ptr = -EFAULT;
 
-	return sum;
+	return csum;
 }
 #endif
 
 #ifndef HAVE_CSUM_COPY_USER
 static __inline__ unsigned int csum_and_copy_to_user
-(const unsigned char *src, unsigned char __user *dst, int len, unsigned int sum, int *err_ptr)
+(const unsigned char *src, unsigned char __user *dst, int len, unsigned int csum, int *err_ptr)
 {
-	sum = csum_partial(src, len, sum);
+	sum = csum_partial(src, len, csum);
 
 	if (access_ok(VERIFY_WRITE, dst, len)) {
 		if (copy_to_user(dst, src, len) == 0)
-			return sum;
+			return csum;
 	}
 	if (len)
 		*err_ptr = -EFAULT;




