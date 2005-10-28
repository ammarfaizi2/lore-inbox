Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVJ1Qeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVJ1Qeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVJ1Qeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:34:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2978 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030241AbVJ1Qeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:34:37 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: EDAC - clean up atomic stuff
References: <1129902050.26367.50.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 10:33:55 -0600
In-Reply-To: <1129902050.26367.50.camel@localhost.localdomain> (Alan Cox's
 message of "Fri, 21 Oct 2005 14:40:50 +0100")
Message-ID: <m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Various proposals were made about the problem of u32 in atomic.h. I've
> followed Andi Kleen's comments here - that atomic.h is about atomic_t
> not atomic operations in general. I've moved the header bits to edac.h
>
> Avi Kivity also observed the x86_64 one was wrong and I've fixed that
> too

First thanks for getting this code merged.

I think I am the original author of this bit of scrub code and
I had thought it had disappeared long ago, because of maintenance
issues.  I at least had an identical implementation.

A couple of questions
- Why a u32 for length and not just unsigned?
- Why is the x86_64 version clearing 32bit words and not 64bit words,
  that should be noticeably faster if we ever need to use that
  code.
- Is KM_BOUNCE_READ a safe atomic_kmap entry to be using?
  I'm not certain, but my gut feel is that scrubbing probably
  wants it's own kmap type. 
  I remember doing some looking when I first wrote this and thinking
  that KM_BOUNCE_READ looked safe and was good enough until the code
  got merged into the kernel.

Eric


> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/atomic.h
> linux-2.6.14-rc4-mm1/include/asm-i386/atomic.h
> --- linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/atomic.h 2005-10-20
> 16:12:41.000000000 +0100
> +++ linux-2.6.14-rc4-mm1/include/asm-i386/atomic.h 2005-10-21 11:36:54.000000000
> +0100
> @@ -237,15 +237,4 @@
>  #define smp_mb__before_atomic_inc()	barrier()
>  #define smp_mb__after_atomic_inc()	barrier()
>  
> -/* ECC atomic, DMA, SMP and interrupt safe scrub function */
> -
> -static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
> -{
> -	u32 i;
> -	for (i = 0; i < size / 4; i++, virt_addr++)
> -		/* Very carefully read and write to memory atomically
> -		 * so we are interrupt, DMA and SMP safe.
> -		 */
> -		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
> -}
>  #endif
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/edac.h
> linux-2.6.14-rc4-mm1/include/asm-i386/edac.h
> --- linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/edac.h 1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.14-rc4-mm1/include/asm-i386/edac.h 2005-10-21 11:37:54.000000000
> +0100
> @@ -0,0 +1,18 @@
> +#ifndef ASM_EDAC_H
> +#define ASM_EDAC_H
> +
> +/* ECC atomic, DMA, SMP and interrupt safe scrub function */
> +
> +static __inline__ void atomic_scrub(void *va, u32 size)
> +{
> +	unsigned long *virt_addr = va;
> +	u32 i;
> +
> +	for (i = 0; i < size / 4; i++, virt_addr++)
> +		/* Very carefully read and write to memory atomically
> +		 * so we are interrupt, DMA and SMP safe.
> +		 */
> +		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
> +}
> +
> +#endif
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/edac.h
> linux-2.6.14-rc4-mm1/include/asm-x86_64/edac.h
> --- linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/edac.h 1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.14-rc4-mm1/include/asm-x86_64/edac.h 2005-10-21 11:38:34.000000000
> +0100
> @@ -0,0 +1,18 @@
> +#ifndef ASM_EDAC_H
> +#define ASM_EDAC_H
> +
> +/* ECC atomic, DMA, SMP and interrupt safe scrub function */
> +
> +static __inline__ void atomic_scrub(void *va, u32 size)
> +{
> +	unsigned int *virt_addr = va;
> +	u32 i;
> +
> +	for (i = 0; i < size / 4; i++, virt_addr++)
> +		/* Very carefully read and write to memory atomically
> +		 * so we are interrupt, DMA and SMP safe.
> +		 */
> +		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
> +}
> +
> +#endif
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
