Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWG3Qit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWG3Qit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWG3Qit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:38:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:11307 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932362AbWG3Qis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f+FhjB/0WNAAXX4noug7no/pw1DJQurMOs33i7EMVwjB4rCzOUYxukkH70cTW1jv6T7lJ9LXgY8ig1LiS/ja/TLdjLIqciquaF69OY0MP/fP2NakOXqzsb7YIFWFWCsvU+JYYIi5sSs+AWJA09CnxCiIDMXCyWaWaEWTViVZBwE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] making the kernel -Wshadow clean - fix checksum
Date: Sun, 30 Jul 2006 18:39:50 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301839.50258.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some -Wshadow fixes for include/[asm-i386|net]/checksum.h

 include/asm/checksum.h:185: warning: declaration of 'sum' shadows a parameter
 include/asm/checksum.h:181: warning: shadowed declaration is here
 include/net/checksum.h:33: warning: declaration of 'sum' shadows a parameter
 include/net/checksum.h:31: warning: shadowed declaration is here

these show up several times each.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/asm-i386/checksum.h |    4 ++--
 include/net/checksum.h      |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc2-orig/include/asm-i386/checksum.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/include/asm-i386/checksum.h	2006-07-18 22:03:59.000000000 +0200
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
--- linux-2.6.18-rc2-orig/include/net/checksum.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/include/net/checksum.h	2006-07-18 22:03:59.000000000 +0200
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



