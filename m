Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWA2Hvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWA2Hvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWA2Hvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:51:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWA2Hva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:51:30 -0500
Date: Sat, 28 Jan 2006 23:51:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: Add a temporary to make put_user more type safe.
Message-Id: <20060128235113.697e3a2c.akpm@osdl.org>
In-Reply-To: <m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<20060128223917.4e5c3dd9.akpm@osdl.org>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> > Sounds sane.  We could make it warn if typeof(x)!=typeof(*ptr) by adding
>  > another temporary for the pointer, give it type typeof(x)*, but I haven't
>  > tried it.
> 
>  I guess we could do that.  However if we don't use the value we will probably
>  get an unused variable warning.  

No, that's OK, we can use the temporary.

Something like this:

--- devel/include/asm-i386/uaccess.h~x86-tighten-uaccess-type-checking	2006-01-28 23:45:16.000000000 -0800
+++ devel-akpm/include/asm-i386/uaccess.h	2006-01-28 23:48:31.000000000 -0800
@@ -149,14 +149,16 @@ extern void __get_user_4(void);
 #define get_user(x,ptr)							\
 ({	int __ret_gu;							\
 	unsigned long __val_gu;						\
+	__typeof__(x)*_p_;						\
+	_p_ = ptr;							\
 	__chk_user_ptr(ptr);						\
-	switch(sizeof (*(ptr))) {					\
-	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
-	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
-	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		\
-	default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;		\
+	switch(sizeof (*(_p_))) {					\
+	case 1:  __get_user_x(1, __ret_gu, __val_gu, _p_); break;	\
+	case 2:  __get_user_x(2, __ret_gu, __val_gu, _p_); break;	\
+	case 4:  __get_user_x(4, __ret_gu, __val_gu, _p_); break;	\
+	default: __get_user_x(X, __ret_gu, __val_gu, _p_); break;	\
 	}								\
-	(x) = (__typeof__(*(ptr)))__val_gu;				\
+	(x) = __val_gu;							\
 	__ret_gu;							\
 })
 
@@ -198,13 +200,17 @@ extern void __put_user_8(void);
 #define put_user(x,ptr)						\
 ({	int __ret_pu;						\
 	__chk_user_ptr(ptr);					\
-	__typeof__(*(ptr)) __pu_val = x;			\
+	__typeof__(x)*_p_;					\
+	__typeof__(x)__pu_val;					\
+								\
+	_p_ = ptr;						\
+	__pu_val = x;						\
 	switch(sizeof(*(ptr))) {				\
-	case 1: __put_user_1(__pu_val, ptr); break;		\
-	case 2: __put_user_2(__pu_val, ptr); break;		\
-	case 4: __put_user_4(__pu_val, ptr); break;		\
-	case 8: __put_user_8(__pu_val, ptr); break;		\
-	default:__put_user_X(__pu_val, ptr); break;		\
+	case 1: __put_user_1(__pu_val, _p_); break;		\
+	case 2: __put_user_2(__pu_val, _p_); break;		\
+	case 4: __put_user_4(__pu_val, _p_); break;		\
+	case 8: __put_user_8(__pu_val, _p_); break;		\
+	default:__put_user_X(__pu_val, _p_); break;		\
 	}							\
 	__ret_pu;						\
 })
_


It gives ~100 warnings on my usual test config.  It's a bit awkward because
get_user/put_user/etc aren't allowed to evaluate their args multiple times
- code likes to do

	get_user(v, p++);

I guess fixing those 100-odd warnings might find some warts -
compiler-caused truncation or sign-extension during uaccess copies is a bit
of a worry.

But I have enough things to be going on with :(
