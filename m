Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUIKXH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUIKXH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUIKXHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 19:07:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:46214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268355AbUIKXHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 19:07:51 -0400
Date: Sat, 11 Sep 2004 16:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: kaigai@ak.jp.nec.com (Kaigai Kohei)
Cc: hugh@veritas.com, ak@muc.de, wli@holomorphy.com,
       takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_inc_return() for i386[1/5] (Re:
 atomic_inc_return)
Message-Id: <20040911160532.07216174.akpm@osdl.org>
In-Reply-To: <200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
	<200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaigai@ak.jp.nec.com (Kaigai Kohei) wrote:
>
> 
> [1/5] atomic_inc_return-linux-2.6.9-rc1.i386.patch
>   This patch implements atomic_inc_return() and so on for i386,
>   and includes runtime check whether CPU is legacy 386.
>   It is same as I posted to LKML and Andi Kleen at '04/09/01.
> 

Can we not use the `alternative instruction' stuff to eliminate the runtime
test?


> 
> diff -rNU4 linux-2.6.9-rc1/include/asm-i386/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-i386/atomic.h
> --- linux-2.6.9-rc1/include/asm-i386/atomic.h	2004-08-24 16:02:24.000000000 +0900
> +++ linux-2.6.9-rc1.atomic_inc_return/include/asm-i386/atomic.h	2004-09-10 10:15:18.000000000 +0900
> @@ -1,8 +1,10 @@
>  #ifndef __ARCH_I386_ATOMIC__
>  #define __ARCH_I386_ATOMIC__
>  
>  #include <linux/config.h>
> +#include <linux/compiler.h>
> +#include <asm/processor.h>
>  
>  /*
>   * Atomic operations that C can't guarantee us.  Useful for
>   * resource counting etc..
> @@ -175,8 +177,48 @@
>  		:"ir" (i), "m" (v->counter) : "memory");
>  	return c;
>  }
>  
> +/**
> + * atomic_add_return - add and return
> + * @v: pointer of type atomic_t
> + * @i: integer value to add
> + *
> + * Atomically adds @i to @v and returns @i + @v
> + */
> +static __inline__ int atomic_add_return(int i, atomic_t *v)
> +{
> +	int __i;
> +#ifdef CONFIG_M386
> +	if(unlikely(boot_cpu_data.x86==3))
> +		goto no_xadd;
> +#endif
> +	/* Modern 486+ processor */
> +	__i = i;
> +	__asm__ __volatile__(
> +		LOCK "xaddl %0, %1;"
> +		:"=r"(i)
> +		:"m"(v->counter), "0"(i));
> +	return i + __i;
> +
> +#ifdef CONFIG_M386
> +no_xadd: /* Legacy 386 processor */
> +	local_irq_disable();
> +	__i = atomic_read(v);
> +	atomic_set(v, i + __i);
> +	local_irq_enable();
> +	return i + __i;
> +#endif
> +}
> +
> +static __inline__ int atomic_sub_return(int i, atomic_t *v)
> +{
> +	return atomic_add_return(-i,v);
> +}
> +
> +#define atomic_inc_return(v)  (atomic_add_return(1,v))
> +#define atomic_dec_return(v)  (atomic_sub_return(1,v))
> +
>  /* These are x86-specific, used by some header files */
>  #define atomic_clear_mask(mask, addr) \
>  __asm__ __volatile__(LOCK "andl %0,%1" \
>  : : "r" (~(mask)),"m" (*addr) : "memory")
