Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUDSKPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUDSKPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:15:54 -0400
Received: from mail.shareable.org ([81.29.64.88]:4260 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264366AbUDSKOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:14:52 -0400
Date: Mon, 19 Apr 2004 11:14:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add 64-bit get_user and __get_user for i386
Message-ID: <20040419101446.GC13007@mail.shareable.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com> <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org> <20040419004657.GD11064@mail.shareable.org> <Pine.LNX.4.58.0404182220470.2808@ppc970.osdl.org> <20040419094408.GA13007@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419094408.GA13007@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the previous patch.  It didn't include the access_ok() check in
64-bit get_user().  Use this instead.

Enjoy,
-- Jamie

Subject: [PATCH] Add 64-bit get_user and __get_user for i386
Patch: uaccess64-2.6.5-jl2

Add 64-bit get_user and __get_user for i386.
This time, include the access_ok() check.
Don't ask me how, but this shrinks the kernel too.

--- orig-2.6.5/include/asm-i386/uaccess.h	2003-12-18 02:58:16.000000000 +0000
+++ uaccess64-2.6.5/include/asm-i386/uaccess.h	2004-04-19 11:06:52.000000000 +0100
@@ -168,17 +168,19 @@
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr)							\
-({	int __ret_gu,__val_gu;						\
-	switch(sizeof (*(ptr))) {					\
-	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
-	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
-	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		\
-	default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;		\
-	}								\
-	(x) = (__typeof__(*(ptr)))__val_gu;				\
-	__ret_gu;							\
-})
+#define get_user(x,ptr)							      \
+(sizeof (*(ptr)) == 8 ? (copy_from_user((void *)&(x),(ptr),8) ? -EFAULT : 0): \
+({									      \
+  	int __ret_gu,__val_gu;						      \
+	switch(sizeof (*(ptr))) {					      \
+	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		      \
+	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		      \
+	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		      \
+	default: __get_user_bad(); break;				      \
+	}								      \
+	(x) = (__typeof__(*(ptr)))__val_gu;				      \
+	__ret_gu;							      \
+}))
 
 extern void __put_user_bad(void);
 
@@ -333,13 +335,14 @@
 		: ltype (x), "m"(__m(addr)), "i"(errret), "0"(err))
 
 
-#define __get_user_nocheck(x,ptr,size)				\
-({								\
-	long __gu_err, __gu_val;				\
-	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);\
-	(x) = (__typeof__(*(ptr)))__gu_val;			\
-	__gu_err;						\
-})
+#define __get_user_nocheck(x,ptr,size)					     \
+((size) == 8 ? (__copy_from_user_ll((void *)&(x), (ptr), 8) ? -EFAULT : 0) : \
+({									     \
+	long __gu_err, __gu_val;					     \
+	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);	     \
+	(x) = (__typeof__(*(ptr)))__gu_val;				     \
+	__gu_err;							     \
+}))
 
 extern long __get_user_bad(void);
 


> 
> Enjoy,
> -- Jamie
> 
> Subject: [PATCH] Add 64-bit get_user and __get_user for i386
> Patch: uaccess64-2.6.5
> 
> Add 64-bit get_user and __get_user for i386.
> Don't ask me how, but this shrinks the kernel too.
> 
> --- orig-2.6.5/include/asm-i386/uaccess.h	2003-12-18 02:58:16.000000000 +0000
> +++ uaccess64-2.6.5/include/asm-i386/uaccess.h	2004-04-19 10:33:20.000000000 +0100
> @@ -169,16 +169,19 @@
>   * On error, the variable @x is set to zero.
>   */
>  #define get_user(x,ptr)							\
> -({	int __ret_gu,__val_gu;						\
> +(sizeof (*(ptr)) == 8							\
> + ? (__copy_from_user_ll((void *)&(x), (ptr), 8) ? -EFAULT : 0) :	\
> +({									\
> +  	int __ret_gu,__val_gu;						\
>  	switch(sizeof (*(ptr))) {					\
>  	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
>  	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
>  	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		\
> -	default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;		\
> +	default: __get_user_bad(); break;				\
>  	}								\
>  	(x) = (__typeof__(*(ptr)))__val_gu;				\
>  	__ret_gu;							\
> -})
> +}))
>  
>  extern void __put_user_bad(void);
>  
> @@ -333,13 +336,14 @@
>  		: ltype (x), "m"(__m(addr)), "i"(errret), "0"(err))
>  
>  
> -#define __get_user_nocheck(x,ptr,size)				\
> -({								\
> -	long __gu_err, __gu_val;				\
> -	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);\
> -	(x) = (__typeof__(*(ptr)))__gu_val;			\
> -	__gu_err;						\
> -})
> +#define __get_user_nocheck(x,ptr,size)					     \
> +((size) == 8 ? (__copy_from_user_ll((void *)&(x), (ptr), 8) ? -EFAULT : 0) : \
> +({									     \
> +	long __gu_err, __gu_val;					     \
> +	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);	     \
> +	(x) = (__typeof__(*(ptr)))__gu_val;				     \
> +	__gu_err;							     \
> +}))
>  
>  extern long __get_user_bad(void);
>  
