Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVBLB7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVBLB7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVBLB7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:59:42 -0500
Received: from siaag1ad.compuserve.com ([149.174.40.6]:10221 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261961AbVBLB7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:59:21 -0500
Date: Fri, 11 Feb 2005 20:55:16 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: out-of-line x86 "put_user()" implementation
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@twiddle.net>, Ingo Molnar <mingo@elte.hu>
Message-ID: <200502112058_MC3-1-95CC-5FF1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 at 18:27:08 -0800, Linus Torvalds wrote:

> +/*
> + * Strange magic calling convention: pointer in %ecx,
> + * value in %eax(:%edx), return value in %eax, no clobbers.
> + */
> +extern void __put_user_1(void);
> +extern void __put_user_2(void);
> +extern void __put_user_4(void);
> +extern void __put_user_8(void);
> +
> +#define __put_user_1(x, ptr) __asm__ __volatile__("call __put_user_1":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
> +#define __put_user_2(x, ptr) __asm__ __volatile__("call __put_user_2":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
> +#define __put_user_4(x, ptr) __asm__ __volatile__("call __put_user_4":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
> +#define __put_user_8(x, ptr) __asm__ __volatile__("call __put_user_8":"=a" (__ret_pu):"A" ((typeof(*(ptr)))(x)), "c" (ptr))
> +#define __put_user_X(x, ptr) __asm__ __volatile__("call __put_user_X":"=a" (__ret_pu):"c" (ptr))
> +

  Should "cc" be on the clobber list since all the called functions alter EFLAGS?

  And in any case is it too much to ask for an 80-column limit? ;)

#define __put_user_1(x, ptr)                    \
__asm__ __volatile__(                           \
        "call __put_user_1"                     \
        : "=a" (__ret_pu)                       \
        : "0" ((typeof(*(ptr)))(x)), "c" (ptr)  \
        : "cc")
#define __put_user_2(x, ptr)                    \
__asm__ __volatile__(                           \
        "call __put_user_2"                     \
        : "=a" (__ret_pu)                       \
        : "0" ((typeof(*(ptr)))(x)), "c" (ptr)  \
        : "cc")
#define __put_user_4(x, ptr)                    \
__asm__ __volatile__(                           \
        "call __put_user_4"                     \
        : "=a" (__ret_pu)                       \
        : "0" ((typeof(*(ptr)))(x)), "c" (ptr)  \
        : "cc")
#define __put_user_8(x, ptr)                    \
__asm__ __volatile__(                           \
        "call __put_user_8"                     \
        : "=a" (__ret_pu)                       \
        : "A" ((typeof(*(ptr)))(x)), "c" (ptr)  \
        : "cc")
#define __put_user_X(x, ptr)                    \
__asm__ __volatile__(                           \
        "call __put_user_X"                     \
        : "=a" (__ret_pu)                       \
        : "c" (ptr)                             \
        : "cc")

--
Chuck
