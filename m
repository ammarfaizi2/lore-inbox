Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVCGARQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVCGARQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCGARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:17:16 -0500
Received: from mail.dif.dk ([193.138.115.101]:691 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261617AbVCFXy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:54:27 -0500
Date: Mon, 7 Mar 2005 00:55:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok
In-Reply-To: <20050306232450.104fd7b7.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.LNX.4.62.0503070050390.2971@dragon.hygekrogen.localhost>
References: <20050306232450.104fd7b7.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005, Yoichi Yuasa wrote:

> This patch converts verify_area to access_ok for include/asm-mips.
> 
Yeah, that's one of the few bits I had not done yet. Thank you for taking 
a look at that.

I don't believe your patch is correct though. See below for what I think 
is a better one.


> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
> diff -urN -X dontdiff a-orig/include/asm-mips/uaccess.h a/include/asm-mips/uaccess.h
> --- a-orig/include/asm-mips/uaccess.h	Sat Mar  5 04:15:22 2005
> +++ a/include/asm-mips/uaccess.h	Sun Mar  6 15:51:02 2005
> @@ -254,13 +254,11 @@
>  ({									\
>  	__typeof__(*(ptr)) __gu_val = 0;				\
>  	long __gu_addr;							\
> -	long __gu_err;							\
> +	long __gu_err = -EFAULT;					\
>  									\
>  	might_sleep();							\
>  	__gu_addr = (long) (ptr);					\
> -	__gu_err = verify_area(VERIFY_READ, (void *) __gu_addr, size);	\
> -									\
> -	if (likely(!__gu_err)) {					\
> +	if (access_ok(VERIFY_READ, (void *) __gu_addr, size)) {		\
>  		switch (size) {						\
>  		case 1: __get_user_asm("lb", __gu_err); break;		\
>  		case 2: __get_user_asm("lh", __gu_err); break;		\

with this change, __gu_err will always be -EFAULT. With the original code 
it was either -EFAULT or 0 depending on the return value from verify_area. 
Same goes for the next hunk in your patch.

I believe a more correct patch would be this :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm1-orig/include/asm-mips/uaccess.h linux-2.6.11-mm1/include/asm-mips/uaccess.h
--- linux-2.6.11-mm1-orig/include/asm-mips/uaccess.h	2005-03-05 00:39:40.000000000 +0100
+++ linux-2.6.11-mm1/include/asm-mips/uaccess.h	2005-03-07 00:49:24.000000000 +0100
@@ -258,7 +258,8 @@ struct __large_struct { unsigned long bu
 									\
 	might_sleep();							\
 	__gu_addr = (long) (ptr);					\
-	__gu_err = verify_area(VERIFY_READ, (void *) __gu_addr, size);	\
+	__gu_err = access_ok(VERIFY_READ, (void *) __gu_addr, size)	\
+				? 0 : -EFAULT;				\
 									\
 	if (likely(!__gu_err)) {					\
 		switch (size) {						\
@@ -353,7 +354,8 @@ extern void __get_user_unknown(void);
 	might_sleep();							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__pu_err = verify_area(VERIFY_WRITE, (void *) __pu_addr, size);	\
+	__pu_err = access_ok(VERIFY_WRITE, (void *) __pu_addr, size)	\
+				? 0 : -EFAULT;				\
 									\
 	if (likely(!__pu_err)) {					\
 		switch (size) {						\




It preserves the exact behaviour of the original.


-- 
Jesper 


