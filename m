Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTINQth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 12:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTINQth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 12:49:37 -0400
Received: from zero.aec.at ([193.170.194.10]:43529 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261199AbTINQtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 12:49:36 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
References: <vD5l.6Wt.19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 14 Sep 2003 18:49:08 +0200
In-Reply-To: <vD5l.6Wt.19@gated-at.bofh.it> (Manfred Spraul's message of
 "Sun, 14 Sep 2003 13:20:15 +0200")
Message-ID: <m3znh7xqm3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> The attached patch adds likely to the tests - any objections? What
> about the archs except i386?

I fixed x86-64 get/put_user, although it doesn't matter much there because
it compiles with -fno-reorder-blocks by default. 

(generates smaller code and makes the assembly output much more readable)

But:

>
> --
>     Manfred
> --- 2.6/include/asm-i386/uaccess.h	2003-09-12 21:53:58.000000000 +0200
> +++ build-2.6/include/asm-i386/uaccess.h	2003-09-14 12:56:19.000000000 +0200
> @@ -300,7 +300,7 @@
>  	long __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
>  	might_sleep();						\
> -	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
> +	if (likely(access_ok(VERIFY_WRITE,__pu_addr,size)))			\
>  		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
>  	__pu_err;							\
>  })							
> @@ -510,7 +510,7 @@
>  direct_copy_to_user(void __user *to, const void *from, unsigned long n)

My copy of 2.6.0test5 doesn't have a "direct_copy_to_user", so I'm wondering
at what tree you're looking.

And more importantly I think the i386 uaccess.h copy_{from/to}_user should 
be fixed to not do the access_ok()/memset check inline. It can be as well done
out of line. This would likely save some code size. Doing it inline
just doesn't make any sense.

[x86-64 does it this way]

-Andi
