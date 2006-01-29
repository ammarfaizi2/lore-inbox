Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWA2Gjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWA2Gjg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWA2Gjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:39:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWA2Gjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:39:35 -0500
Date: Sat, 28 Jan 2006 22:39:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: Add a temporary to make put_user more type safe.
Message-Id: <20060128223917.4e5c3dd9.akpm@osdl.org>
In-Reply-To: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> 
> In some code I am developing I had occasion to change the type of a
> variable.  This made the value put_user was putting to user space
> wrong.  But the code continued to build cleanly without errors.

What do you mean by "wrong"?  What combinations of types do you think
should be disallowed here?  put_user(char, int*), for example, or what?

We had one instance recently where code was doing put_user() of an
eight-byte struct and that sailed through x86 testing but made the sparc64
compiler ICE.  Certainly we should stamp out tricks like that at compile
time, but how far should we go?

There's probably a good case for ensuring that typeof(x)==typeof(*ptr), but
I suspect that'd create a lot of noise.

> Introducing a temporary fixes this problem and at least with gcc-3.3.5
> does not cause gcc any problems with optimizing out the temporary.
> gcc-4.x using SSA internally ought to be even better at optimizing out
> temporaries, so I don't expect a temporary to become a problem.
> Especially because in all correct cases the types on both sides of the
> assignment to the temporary are the same.
> 

Sounds sane.  We could make it warn if typeof(x)!=typeof(*ptr) by adding
another temporary for the pointer, give it type typeof(x)*, but I haven't
tried it.


> 
> 
> ---
> 
>  include/asm-i386/uaccess.h |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> dd1215e541bfe2ed94a902f7fb263ca44b7e8afa
> diff --git a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
> index 3f1337c..1641613 100644
> --- a/include/asm-i386/uaccess.h
> +++ b/include/asm-i386/uaccess.h
> @@ -198,12 +198,13 @@ extern void __put_user_8(void);
>  #define put_user(x,ptr)						\
>  ({	int __ret_pu;						\
>  	__chk_user_ptr(ptr);					\
> +	__typeof__(*(ptr)) __pu_val = x;			\
>  	switch(sizeof(*(ptr))) {				\
> -	case 1: __put_user_1(x, ptr); break;			\
> -	case 2: __put_user_2(x, ptr); break;			\
> -	case 4: __put_user_4(x, ptr); break;			\
> -	case 8: __put_user_8(x, ptr); break;			\
> -	default:__put_user_X(x, ptr); break;			\
> +	case 1: __put_user_1(__pu_val, ptr); break;		\
> +	case 2: __put_user_2(__pu_val, ptr); break;		\
> +	case 4: __put_user_4(__pu_val, ptr); break;		\
> +	case 8: __put_user_8(__pu_val, ptr); break;		\
> +	default:__put_user_X(__pu_val, ptr); break;		\
>  	}							\
>  	__ret_pu;						\
>  })
> -- 
> 1.1.5.g3480
