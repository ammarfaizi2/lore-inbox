Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbREEQ1B>; Sat, 5 May 2001 12:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbREEQ0m>; Sat, 5 May 2001 12:26:42 -0400
Received: from 4dyn183.delft.casema.net ([195.96.105.183]:44812 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132756AbREEQ0c>; Sat, 5 May 2001 12:26:32 -0400
Message-Id: <200105051626.SAA16651@cave.bitwizard.nl>
Subject: Re: Athlon possible fixes
In-Reply-To: <E14vwaq-0000Jk-00@the-village.bc.nu> from Alan Cox at "May 5, 2001
 08:35:06 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 5 May 2001 18:26:30 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +		__asm__ __volatile__ (
> +		"   movq (%0), %%mm0\n"
> +		"   movq 8(%0), %%mm1\n"
> +		"   movq 16(%0), %%mm2\n"
> +		"   movq 24(%0), %%mm3\n"
> +		"   movq %%mm0, (%1)\n"
> +		"   movq %%mm1, 8(%1)\n"
> +		"   movq %%mm2, 16(%1)\n"
> +		"   movq %%mm3, 24(%1)\n"
> +		"   movq 32(%0), %%mm0\n"
> +		"   movq 40(%0), %%mm1\n"
> +		"   movq 48(%0), %%mm2\n"
> +		"   movq 56(%0), %%mm3\n"
> +		"   movq %%mm0, 32(%1)\n"
> +		"   movq %%mm1, 40(%1)\n"
> +		"   movq %%mm2, 48(%1)\n"
> +		"   movq %%mm3, 56(%1)\n"
>  		: : "r" (from), "r" (to) : "memory");
>  		from+=64;
>  		to+=64;

As all this is trying to avoid bus turnarounds (i.e. switching from
reading to writing), wouldn't it be fastest to just trust that the CPU
has at least 4k worth of cache? (and hope for the best that we don't
get interrupted in the meanwhile).

void copy_page (char *dest, char *source)
{
	long *dst = (long *)dest, 
		*src=(long *)source, 
		*end= (long *)(source+PAGE_SIZE);
#if 1
	register int  i;
	long t=0;
	static long tt;

  	for (i=0;i<PAGE_SIZE/sizeof (long);i += cache_line_size()/sizeof(long))
	/* Actually the innards of this loop should be:
		(void) from[i];
	   however, the compiler will probably optimize that away. */ 
     		t += src[i];

	tt = t;
#endif
	while (src < end)
		*dst++ = *src++;

}

So, this is 15 lines of C, and it'd be interesting to benchmark this
against the assembly.

I'm assuming that the "loop variable handling" is not going to
influence the overall performance: that would run at 500 - 1000MHz,
and around 1 clock cycle (1-2ns) per loop. Set this against the stalls
against the memory unit whose output buffer is full, and memory writes
that take on the order of 30 ns per 64bits.

At least, that's what I expect, however, I haven't been optimizing
cycles for quite a while....

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
