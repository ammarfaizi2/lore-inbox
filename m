Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVKEJAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVKEJAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVKEJAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:00:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13585 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751302AbVKEJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:00:22 -0500
Date: Sat, 5 Nov 2005 09:00:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2/5] atomic: cmpxchg
Message-ID: <20051105090010.GA18926@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <436C655F.2080703@yahoo.com.au> <436C65B1.5020508@yahoo.com.au> <436C65E8.8080501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436C65E8.8080501@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:57:28PM +1100, Nick Piggin wrote:
> Index: linux-2.6/include/asm-arm/atomic.h
> ===================================================================
> --- linux-2.6.orig/include/asm-arm/atomic.h
> +++ linux-2.6/include/asm-arm/atomic.h
> @@ -80,6 +80,23 @@ static inline int atomic_sub_return(int 
>  	return result;
>  }
>  
> +static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
> +{
> +	u32 oldval, res;
> +
> +	do {
> +		__asm__ __volatile__("@ atomic_cmpxchg\n"
> +		"ldrex	%1, [%2]\n"
> +		"teq	%1, %3\n"
> +		"strexeq %0, %4, [%2]\n"
> +		    : "=&r" (res), "=&r" (oldval)
> +		    : "r" (&ptr->counter), "r" (old), "r" (new)
> +		    : "cc");
> +	} while (res);
> +
> +	return oldval;
> +}
> +
>  static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>  {
>  	unsigned long tmp, tmp2;
> @@ -131,6 +148,21 @@ static inline int atomic_sub_return(int 
>  	return val;
>  }
>  
> +static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	ret = v->counter;
> +	if (likely(ret == old))
> +		v->counter = new;
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>  static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)

This is obviously going to break ARM...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
