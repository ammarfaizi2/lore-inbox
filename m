Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWD0SwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWD0SwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWD0SwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:52:13 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:24495 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750748AbWD0SwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:52:12 -0400
Subject: Re: [RFC: 2.6 patch] fs/read_write.c: unexport iov_shorten
From: Badari Pulavarty <pbadari@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060427180331.GK3570@stusta.de>
References: <20060427180331.GK3570@stusta.de>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 11:52:58 -0700
Message-Id: <1146163983.8365.28.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 20:03 +0200, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(iov_shorten).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 23 Apr 2006
> 
> --- linux-2.6.17-rc1-mm3-full/fs/read_write.c.old	2006-04-23 15:51:52.000000000 +0200
> +++ linux-2.6.17-rc1-mm3-full/fs/read_write.c	2006-04-23 15:52:02.000000000 +0200
> @@ -436,8 +436,6 @@
>  	return seg;
>  }
>  
> -EXPORT_SYMBOL(iov_shorten);
> -
>  /* A write operation does a read from user space and vice versa */
>  #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
>  

How about this ? Wondering if we need to make this "inline" also (since
its used only in one place).

Thanks,
Badari

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

 fs/read_write.c     |   22 ----------------------
 include/linux/uio.h |   22 +++++++++++++++++++++-
 2 files changed, 21 insertions(+), 23 deletions(-)

Index: linux-2.6.17-rc2/fs/read_write.c
===================================================================
--- linux-2.6.17-rc2.orig/fs/read_write.c	2006-04-18 20:00:49.000000000 -0700
+++ linux-2.6.17-rc2/fs/read_write.c	2006-04-27 11:57:05.000000000 -0700
@@ -416,28 +416,6 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 	return ret;
 }
 
-/*
- * Reduce an iovec's length in-place.  Return the resulting number of segments
- */
-unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to)
-{
-	unsigned long seg = 0;
-	size_t len = 0;
-
-	while (seg < nr_segs) {
-		seg++;
-		if (len + iov->iov_len >= to) {
-			iov->iov_len = to - len;
-			break;
-		}
-		len += iov->iov_len;
-		iov++;
-	}
-	return seg;
-}
-
-EXPORT_SYMBOL(iov_shorten);
-
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
Index: linux-2.6.17-rc2/include/linux/uio.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/uio.h	2006-04-18 20:00:49.000000000 -0700
+++ linux-2.6.17-rc2/include/linux/uio.h	2006-04-27 11:57:27.000000000 -0700
@@ -61,6 +61,26 @@ static inline size_t iov_length(const st
 	return ret;
 }
 
-unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to);
+
+/*
+ * Reduce an iovec's length in-place.  Return the resulting number of segments
+ */
+static
+unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to)
+{
+	unsigned long seg = 0;
+	size_t len = 0;
+
+	while (seg < nr_segs) {
+		seg++;
+		if (len + iov->iov_len >= to) {
+			iov->iov_len = to - len;
+			break;
+		}
+		len += iov->iov_len;
+		iov++;
+	}
+	return seg;
+}
 
 #endif


