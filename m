Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288284AbSA0SEl>; Sun, 27 Jan 2002 13:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288288AbSA0SEW>; Sun, 27 Jan 2002 13:04:22 -0500
Received: from altus.drgw.net ([209.234.73.40]:3594 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S288284AbSA0SEU>;
	Sun, 27 Jan 2002 13:04:20 -0500
Date: Sun, 27 Jan 2002 12:04:11 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64-bit divide tweaks
Message-ID: <20020127120410.B14725@altus.drgw.net>
In-Reply-To: <87r8oez0ks.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87r8oez0ks.fsf@fadata.bg>; from velco@fadata.bg on Fri, Jan 25, 2002 at 09:34:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 09:34:43PM +0200, Momchil Velikov wrote:
> Hi there,
> 
> printk, etc. are broken wrt printing 64-bit numbers (%ll, %L).
> 
> This patch fixes do_div, which did (on some archs) 32-bit divide.

Have you tried compiling any of these arches? 

Anything that doesn't include libgcc will die a link missing symbols for 
__udivdi3 and __umoddi3.

> 
> Regards,
> -velco
> 
> ===== drivers/net/sk98lin/skproc.c 1.1 vs edited =====
> --- 1.1/drivers/net/sk98lin/skproc.c	Sat Dec  8 02:14:15 2001
> +++ edited/drivers/net/sk98lin/skproc.c	Fri Jan 25 21:20:06 2002
> @@ -339,17 +339,6 @@
>   return (Rest);
>  }
>  
> -
> -#if 0
> -#define do_div(n,base) ({ \
> -long long __res; \
> -__res = ((unsigned long long) n) % (unsigned) base; \
> -n = ((unsigned long long) n) / (unsigned) base; \
> -__res; })
> -
> -#endif
> -
> -
>  /*****************************************************************************
>   *
>   * SkNumber - Print results
> ===== include/asm-arm/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-arm/div64.h	Sat Dec  8 02:13:45 2001
> +++ edited/include/asm-arm/div64.h	Fri Jan 25 21:21:56 2002
> @@ -1,12 +1,11 @@
>  #ifndef __ASM_ARM_DIV64
>  #define __ASM_ARM_DIV64
>  
> -/* We're not 64-bit, but... */
>  #define do_div(n,base)						\
>  ({								\
>  	int __res;						\
> -	__res = ((unsigned long)n) % (unsigned int)base;	\
> -	n = ((unsigned long)n) / (unsigned int)base;		\
> +	__res = ((unsigned long long)n) % (unsigned int)base;	\
> +	n = ((unsigned long long)n) / (unsigned int)base;		\
>  	__res;							\
>  })
>  
> ===== include/asm-cris/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-cris/div64.h	Sat Dec  8 02:13:57 2001
> +++ edited/include/asm-cris/div64.h	Fri Jan 25 21:22:19 2002
> @@ -3,12 +3,11 @@
>  
>  /* copy from asm-arm */
>  
> -/* We're not 64-bit, but... */
>  #define do_div(n,base)						\
>  ({								\
>  	int __res;						\
> -	__res = ((unsigned long)n) % (unsigned int)base;	\
> -	n = ((unsigned long)n) / (unsigned int)base;		\
> +	__res = ((unsigned long long)n) % (unsigned int)base;	\
> +	n = ((unsigned long long)n) / (unsigned int)base;	\
>  	__res;							\
>  })
>  
> ===== include/asm-m68k/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-m68k/div64.h	Sat Dec  8 02:13:35 2001
> +++ edited/include/asm-m68k/div64.h	Fri Jan 25 21:23:59 2002
> @@ -26,8 +26,8 @@
>  #else
>  #define do_div(n,base) ({					\
>  	int __res;						\
> -	__res = ((unsigned long) n) % (unsigned) base;		\
> -	n = ((unsigned long) n) / (unsigned) base;		\
> +	__res = ((unsigned long long) n) % (unsigned) base;	\
> +	n = ((unsigned long long) n) / (unsigned) base;		\
>  	__res;							\
>  })
>  #endif
> ===== include/asm-ppc/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-ppc/div64.h	Sat Dec  8 02:13:37 2001
> +++ edited/include/asm-ppc/div64.h	Fri Jan 25 21:28:49 2002
> @@ -4,10 +4,9 @@
>  #ifndef __PPC_DIV64
>  #define __PPC_DIV64
>  
> -#define do_div(n,base) ({ \
> -int __res; \
> -__res = ((unsigned long) n) % (unsigned) base; \
> -n = ((unsigned long) n) / (unsigned) base; \
> -__res; })
> -
> +#define do_div(n,base) ({					\
> +	int __res;						\
> +	__res = ((unsigned long long) n) % (unsigned) base;	\
> +	n = ((unsigned long long) n) / (unsigned) base;		\
> +	__res; })
>  #endif
> ===== include/asm-sh/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-sh/div64.h	Sat Dec  8 02:13:46 2001
> +++ edited/include/asm-sh/div64.h	Fri Jan 25 21:29:31 2002
> @@ -1,10 +1,9 @@
>  #ifndef __ASM_SH_DIV64
>  #define __ASM_SH_DIV64
>  
> -#define do_div(n,base) ({ \
> -int __res; \
> -__res = ((unsigned long) n) % (unsigned) base; \
> -n = ((unsigned long) n) / (unsigned) base; \
> -__res; })
> -
> +#define do_div(n,base) ({					\
> +	int __res;						\
> +	__res = ((unsigned long long) n) % (unsigned) base;	\
> +	n = ((unsigned long long) n) / (unsigned) base;		\
> +	__res; })
>  #endif /* __ASM_SH_DIV64 */
> ===== include/asm-sparc/div64.h 1.1 vs edited =====
> --- 1.1/include/asm-sparc/div64.h	Sat Dec  8 02:13:36 2001
> +++ edited/include/asm-sparc/div64.h	Fri Jan 25 21:25:39 2002
> @@ -1,11 +1,10 @@
>  #ifndef __SPARC_DIV64
>  #define __SPARC_DIV64
>  
> -/* We're not 64-bit, but... */
>  #define do_div(n,base) ({ \
>  	int __res; \
> -	__res = ((unsigned long) n) % (unsigned) base; \
> -	n = ((unsigned long) n) / (unsigned) base; \
> +	__res = ((unsigned long long) n) % (unsigned) base; \
> +	n = ((unsigned long long) n) / (unsigned) base; \
>  	__res; })
>  
>  #endif /* __SPARC_DIV64 */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
