Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVH2TnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVH2TnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVH2TnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:43:24 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:24904 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751471AbVH2TnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:43:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XzpqmAkxeFbE8RTzDZwegLg9IqtMZj2JOWSpWviE9YN/W4IqOThIicbdm+uefthxnQ94ZMRNYVqdOtanjh3l/gPfiRFyz1wGW1yvQu1VYjVGecgoBrky39jJMuxXyM826PZcg/MIJpIXKvQK4WiQkr7SCLguF8nPed/zDm59ETE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Zankel <zankel@tensilica.com>
Subject: Re: We also need to get rid of verify_area in entry.S
Date: Mon, 29 Aug 2005 21:44:11 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200508291954.27026.jesper.juhl@gmail.com> <43135211.50109@tensilica.com>
In-Reply-To: <43135211.50109@tensilica.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292144.11941.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 20:21, Chris Zankel wrote:
> Jesper,
> 
> Thanks for the patches. I'll take a look at the entry.S one and will 
> pass it along to Andres, and will incorporate the signal.c patch.
> 
Thank you.

I was originally planning to submit a single patch that removes 
verify_area across the board, but I guess it might be easier if I just 
hand you the bit of the patch that handles xtensa (instead of waiting for 
those bits to hit -mm) and then submit the rest along with a note that 
similar patches for xtensa will arrive later via you.

So, here's the final bit that removes verify_area completely from xtensa :


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-xtensa/checksum.h linux-2.6.13/include/asm-xtensa/checksum.h
--- linux-2.6.13-orig/include/asm-xtensa/checksum.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-xtensa/checksum.h	2005-08-29 03:46:34.000000000 +0200
@@ -45,7 +45,7 @@ asmlinkage unsigned int csum_partial_cop
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 extern __inline__
 unsigned int csum_partial_copy_nocheck ( const char *src, char *dst,
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-xtensa/uaccess.h linux-2.6.13/include/asm-xtensa/uaccess.h
--- linux-2.6.13-orig/include/asm-xtensa/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-xtensa/uaccess.h	2005-08-29 03:47:18.000000000 +0200
@@ -154,35 +154,6 @@
 .Laccess_ok_\@:
 	.endm
 
-/*
- * verify_area determines whether a memory access is allowed.  It's
- * mostly an unnecessary wrapper for access_ok, but we provide it as a
- * duplicate of the verify_area() C inline function below.  See the
- * equivalent C version below for clarity.
- *
- * On error, verify_area branches to a label indicated by parameter
- * <error>.  This implies that the macro falls through to the next
- * instruction on success.
- *
- * Note that we assume success is the common case, and we optimize the
- * branch fall-through case on success.
- *
- * On Entry:
- * 	<aa>	register containing memory address
- * 	<as>	register containing memory size
- * 	<at>	temp register
- * 	<error>	label to branch to on error; implies fall-through
- * 		macro on success
- * On Exit:
- * 	<aa>	preserved
- * 	<as>	preserved
- * 	<at>	destroyed
- */
-	.macro	verify_area	aa, as, at, sp, error
-	access_ok  \at, \aa, \as, \sp, \error
-	.endm
-
-
 #else /* __ASSEMBLY__ not defined */
 
 #include <linux/sched.h>
@@ -211,11 +182,6 @@
 #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-extern inline int verify_area(int type, const void * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * These are the main single-value transfer routines.  They
  * automatically use the right size if we just have the right pointer
