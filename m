Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTKRV3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKRV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:29:44 -0500
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:11136 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S263792AbTKRV3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:29:35 -0500
Message-ID: <3FBA8F20.3050701@steudten.com>
Date: Tue, 18 Nov 2003 22:29:04 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-alpha@vger.kernel.org, akpm@osdl.org
Subject: Re: SOLVED: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha
 in scsi context ll_rw_blk.c
X-Priority: 4 (low)
References: <3FB92938.8040906@steudten.com> <87r806d6n6.fsf@student.uni-tuebingen.de> <3FB93EF6.807@steudten.com> <87islid5tq.fsf@student.uni-tuebingen.de> <20031118021922.A7816@den.park.msu.ru>
In-Reply-To: <20031118021922.A7816@den.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Authenticated-Sender: user thomas from 192.168.1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With the patch from Ivan, the prefetch problem is gone.
Please add this patch to the mainline for 2.6.0 for alpha.

Regards
Tom

> We shouldn't prefetch the spinlocks on UP.
> 
> Ivan.
> 
> --- 2.6/include/asm-alpha/processor.h	Sat Oct 25 22:44:54 2003
> +++ linux/include/asm-alpha/processor.h	Tue Nov 18 01:48:39 2003
> @@ -78,6 +78,11 @@ unsigned long get_wchan(struct task_stru
>  #define ARCH_HAS_PREFETCHW
>  #define ARCH_HAS_SPINLOCK_PREFETCH
>  
> +#ifndef CONFIG_SMP
> +/* Nothing to prefetch. */
> +#define spin_lock_prefetch(lock)  	do { } while (0)
> +#endif
> +
>  #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
>  extern inline void prefetch(const void *ptr)  
>  { 
> @@ -89,10 +94,13 @@ extern inline void prefetchw(const void 
>  	__builtin_prefetch(ptr, 1, 3);
>  }
>  
> +#ifdef CONFIG_SMP
>  extern inline void spin_lock_prefetch(const void *ptr)  
>  {
>  	__builtin_prefetch(ptr, 1, 3);
>  }
> +#endif
> +
>  #else
>  extern inline void prefetch(const void *ptr)  
>  { 
> @@ -104,10 +112,13 @@ extern inline void prefetchw(const void 
>  	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
>  }
>  
> +#ifdef CONFIG_SMP
>  extern inline void spin_lock_prefetch(const void *ptr)  
>  {
>  	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
>  }
> +#endif
> +
>  #endif /* GCC 3.1 */
>  
>  #endif /* __ASM_ALPHA_PROCESSOR_H */

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?


