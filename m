Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSA0SwV>; Sun, 27 Jan 2002 13:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288354AbSA0SwM>; Sun, 27 Jan 2002 13:52:12 -0500
Received: from [195.163.186.27] ([195.163.186.27]:41915 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S287886AbSA0Sv7>;
	Sun, 27 Jan 2002 13:51:59 -0500
Date: Sun, 27 Jan 2002 20:51:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64-bit divide tweaks
Message-ID: <20020127205141.L5808@mea-ext.zmailer.org>
In-Reply-To: <87r8oez0ks.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r8oez0ks.fsf@fadata.bg>; from velco@fadata.bg on Fri, Jan 25, 2002 at 09:34:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 09:34:43PM +0200, Momchil Velikov wrote:
> Hi there,
>   printk, etc. are broken wrt printing 64-bit numbers (%ll, %L).
>   This patch fixes do_div, which did (on some archs) 32-bit divide.

  Wrong.

  Correct one is to supply each arch with their native way to handle
  the division.  Remember, the base (divisor) is SMALLISH (2 to 16).

  Where you are unable to do it, the C code that is still present in
  include/asm-parisc/div64.h   alternate code branch will do it.

  This code is needed because the Linux kernel DOES NOT WANT TO
  use gcc builtin functions normally available via  libgcc.
  This is primarily to detect when 32-bit machine does arbitrary
  (and expensive) divisions on 64-bit values.  E.g. stupid code
  slipped into fast-paths.

> Regards,
> -velco

/Matti Aarnio  (who originally created this %Ld printing code,
                and which others have mutated since then..)

 
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
