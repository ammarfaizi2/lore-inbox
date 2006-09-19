Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWISHas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWISHas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWISHas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 03:30:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751215AbWISHaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 03:30:46 -0400
Date: Tue, 19 Sep 2006 00:30:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of
 ilog2() on a constant [try #3]
Message-Id: <20060919003031.166d08a4.akpm@osdl.org>
In-Reply-To: <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 19:35:31 +0100
David Howells <dhowells@redhat.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Alter get_order() so that it can make use of ilog2() on a constant to produce a
> constant value, retaining the ability for an arch to override it in the
> non-const case.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  include/asm-generic/page.h |   14 --------------
>  include/linux/log2.h       |   45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index a96b5d9..a7e374e 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -6,20 +6,6 @@ #ifndef __ASSEMBLY__
>  
>  #include <linux/compiler.h>
>  
> -/* Pure 2^n version of get_order */
> -static __inline__ __attribute_const__ int get_order(unsigned long size)
> -{
> -	int order;
> -
> -	size = (size - 1) >> (PAGE_SHIFT - 1);
> -	order = -1;
> -	do {
> -		size >>= 1;
> -		order++;
> -	} while (size);
> -	return order;
> -}
> -
>  #endif	/* __ASSEMBLY__ */
>  #endif	/* __KERNEL__ */
>  
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index 6ce81b7..88b7b0e 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -25,6 +25,7 @@ int ____ilog2_NaN(void);
>   * non-constant log of base 2 calculators
>   * - the arch may override these in asm/bitops.h if they can be implemented
>   *   more efficiently than using fls() and fls64()
> + * - the arch is not required to handle n==0 if implementing the fallback
>   */
>  #ifndef ARCH_HAS_ILOG2_U32
>  static inline __attribute__((const))
> @@ -42,6 +43,36 @@ int __ilog2_u64(u64 n)
>  }
>  #endif
>  
> +/*
> + * non-const pure 2^n version of get_order
> + * - the arch may override these in asm/bitops.h if they can be implemented
> + *   more efficiently than using the arch log2 routines
> + * - we use the non-const log2() instead if the arch has defined one suitable
> + */
> +#ifndef ARCH_HAS_GET_ORDER
> +static inline __attribute__((const))
> +int __get_order(unsigned long size, int page_shift)
> +{
> +#if BITS_PER_LONG == 32 && defined(ARCH_HAS_ILOG2_U32)
> +	int order = __ilog2_u32(size) - page_shift;
> +	return order >= 0 ? order : 0;
> +#elif BITS_PER_LONG == 64 && defined(ARCH_HAS_ILOG2_U64)
> +	int order = __ilog2_u64(size) - page_shift;
> +	return order >= 0 ? order : 0;
> +#else

This breaks ia64:

In file included from include/asm/ptrace.h:234,
                 from include/asm/processor.h:19,
                 from include/linux/prefetch.h:14,
                 from include/linux/list.h:8,
                 from include/linux/wait.h:22,
                 from include/linux/fs.h:266,
                 from init/do_mounts_initrd.c:3:
include/asm/page.h:165: error: syntax error before '?' token
include/asm/page.h:170: warning: type defaults to `int' in declaration of `order'
include/asm/page.h:170: error: conflicting types for 'order'
include/asm/page.h:168: error: previous declaration of 'order' was here
include/asm/page.h:170: error: braced-group within expression allowed only inside a function
include/asm/page.h:170: warning: type defaults to `int' in declaration of `ia64_intri_res'

But for some reason putting ARCH_HAS_GET_ORDER into
include/asm-ia64/bitops.h and including linux/log2.h in
include/asm-ia64/page.h doesn't fix it.

I didn't pursue it further, because sprinkling ARCH_HAS_FOO things into
bitops.h(!) is all rather hacky.  Better to use CONFIG_* so they're always
visible and one knows where to go to find things.

