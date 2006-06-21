Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWFUACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWFUACI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFUACI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:02:08 -0400
Received: from xenotime.net ([66.160.160.81]:15752 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750824AbWFUACH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:02:07 -0400
Date: Tue, 20 Jun 2006 17:04:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Masatake YAMATO <jet@gyve.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sharing maximum errno symbol used in __syscall_return
 (i386)
Message-Id: <20060620170450.e2fd1e02.rdunlap@xenotime.net>
In-Reply-To: <20060620.184010.225581173.jet@gyve.org>
References: <20060620.184010.225581173.jet@gyve.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 18:40:10 +0900 (JST) Masatake YAMATO wrote:

> Hi,
> 
> __syscall_return in unistd.h is maintained?
> 
> In the macro the value returned from system call is
> compared with the maximum error number defined in a header file 
> to know the call is successful or not. However, the maximum error number 
> is hard-coded and is not updated.

Ack, this certainly needs some care & fixing.

> Here is an example(i386):
> 
>  /*
>   * user-visible error numbers are in the range -1 - -128: see
>   * <asm-i386/errno.h>
>   */
>  #define __syscall_return(type, res) \
>  do { \
> 	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
>  		errno = -(res); \
>  		res = -1; \
>  	} \
> 
> The comment says the maximum errno is 128.
> However, the actual C code says 128 + 1. What does "+ 1" mean?

I don't understand the -1 either.  A few asm-*/unistd.h files
use that, but most of them do not.


> Look at <asm-i386/errno.h>:
> 
>     #ifndef _I386_ERRNO_H
>     #define _I386_ERRNO_H
> 
>     #include <asm-generic/errno.h>
> 
>     #endif
> 
> The look at <asm-generic/errno.h>:
> 
>     #define	EKEYREVOKED	128	/* Key has been revoked */
>     #define	EKEYREJECTED	129	/* Key was rejected by service */
> 
>     /* for robust mutexes */
>     #define	EOWNERDEAD	130	/* Owner died */
>     #define	ENOTRECOVERABLE	131	/* State not recoverable */
> 
> Here the maximum errno is 131. 
> 
> 
> In many architectures, <asm-foo/errno.h> just includes 
> <asm-generic/errno.h>. So I think <asm-generic/errno.h> should
> exports the real maximum errno and the other headers can
> use it. So in many cases, we can just maintain
> the real maximum errno in <asm-generic/errno.h>.
> 
> Here is the patch for i386. If this patch is approved, I will write
> patches for the other architectures. (However, it may be better to be
> done by each architecture's maintainer.)

I like the patch.

> Signed-off-by: Masatake YAMATO <jet@gyve.org>
> 
> diff --git a/include/asm-generic/errno.h b/include/asm-generic/errno.h
> index e8852c0..4e1238e 100644
> --- a/include/asm-generic/errno.h
> +++ b/include/asm-generic/errno.h
> @@ -106,4 +106,8 @@ #define	EKEYREJECTED	129	/* Key was reje
>  #define	EOWNERDEAD	130	/* Owner died */
>  #define	ENOTRECOVERABLE	131	/* State not recoverable */
>  
> +/* 
> + * If you add a new error, Don't forget to update `GENERIC_ERRNO_MAX' 
> + */
> +#define GENERIC_ERRNO_MAX ENOTRECOVERABLE
>  #endif
> diff --git a/include/asm-i386/errno.h b/include/asm-i386/errno.h
> index 969b343..9892b2d 100644
> --- a/include/asm-i386/errno.h
> +++ b/include/asm-i386/errno.h
> @@ -2,5 +2,5 @@ #ifndef _I386_ERRNO_H
>  #define _I386_ERRNO_H
>  
>  #include <asm-generic/errno.h>
> -
> +#define  i386_ERRNO_MAX GENERIC_ERRNO_MAX
>  #endif
> diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
> index eb4b152..f52ec68 100644
> --- a/include/asm-i386/unistd.h
> +++ b/include/asm-i386/unistd.h
> @@ -326,12 +326,13 @@ #define __NR_vmsplice		316
>  #define NR_syscalls 317
>  
>  /*
> - * user-visible error numbers are in the range -1 - -128: see
> - * <asm-i386/errno.h>
> + * user-visible error numbers are in the range -1 - -i386_ERRNO_MAX
>   */
> +#include <asm-i386/errno.h>
> +
>  #define __syscall_return(type, res) \
>  do { \
> -	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
> +	if ((unsigned long)(res) >= (unsigned long)(-(i386_ERRNO_MAX))) { \
>  		errno = -(res); \
>  		res = -1; \
>  	} \
> -

Thanks.
---
~Randy
