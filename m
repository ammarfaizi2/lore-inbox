Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUFXL5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUFXL5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUFXL5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:57:14 -0400
Received: from ltgp.iram.es ([150.214.224.138]:27781 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S264299AbUFXL5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:57:02 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 24 Jun 2004 13:51:46 +0200
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624115146.GA7513@iram.es>
References: <20040624070936.GB30057@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624070936.GB30057@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:09:36AM +0200, Arjan van de Ven wrote:
> Hi,
> 
> gcc 3.4 gained support for several typical bitops as builtin directives.
> Using these over inline asm has a few advantages:
> * gcc can optimize constants into these better
> * gcc can reorder and schedule the code better
> * gcc can allocate registers etc better for the code
> 
> The question is if we consider it desirable to go down this road or not. In
> order to help that discussion I've attached a patch below that switches the
> i386 ffz() function to the gcc builtin version, conditional on gcc having
> support for this. Before I go down the road of converting more functions
> and/or architectures.... is this worth doing?
> 
> Greetings,
>    Arjan van de Ven
> 
> 
> --- linux-2.6.7/include/asm-i386/bitops.h~	2004-06-23 23:45:06.048614387 +0200
> +++ linux-2.6.7/include/asm-i386/bitops.h	2004-06-23 23:45:06.048614387 +0200
> @@ -344,6 +344,8 @@
>   *
>   * Undefined if no zero exists, so code should check against ~0UL first.
>   */
> + 
> +#ifndef HAVE_BUILTIN_CTZL
>  static inline unsigned long ffz(unsigned long word)
>  {
>  	__asm__("bsfl %1,%0"
> @@ -351,6 +353,12 @@
>  		:"r" (~word));
>  	return word;
>  }
> +#else
> +static inline unsigned long ffz (unsigned long word) 
> +{ 
> +	return __builtin_ctzl (~word); 
> +}
> +#endif
>  
>  /**
>   * __ffs - find first bit in word.
> --- linux-2.6.7/include/linux/compiler-gcc3.h~	2004-06-24 09:26:04.123455290 +0200
> +++ linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-24 09:26:04.123455290 +0200
> @@ -19,6 +19,11 @@
>  # define __attribute_used__	__attribute__((__unused__))
>  #endif
>  
> +#if __GNUC_MINOR__ >= 4

Please do no test only on minor. People have been arguing
whether the next major release of GCC should be called 3.5
or 4.0 since tree-ssa has been merged.

This said, I'd rather use GCC intrinsics when they can
perform the task, especially the ones that expand
to more than one machine instruction.

> +#define HAVE_BUILTIN_CTZL
> +#endif

	Gabriel
