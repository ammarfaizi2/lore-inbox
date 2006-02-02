Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWBBOLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWBBOLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWBBOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:11:08 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:3022 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id S1751078AbWBBOLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:11:05 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 2 Feb 2006 02:26:38 +0100
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
       Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
       Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Linus Torvalds <torvalds@osdl.org>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Hirokazu Takata <takata@linux-m32r.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-m68k@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
       dev-etrax@axis.com, ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
       Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Message-ID: <20060202012637.GA25093@iram.es>
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.905071000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201090325.905071000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:02:38PM +0900, Akinobu Mita wrote:
> 
> This patch introduces the C-language equivalents of the functions below:
> 
> unsigned int hweight32(unsigned int w);
> unsigned int hweight16(unsigned int w);
> unsigned int hweight8(unsigned int w);
> unsigned long hweight64(__u64 w);
> 
> In include/asm-generic/bitops/hweight.h
> 
> This code largely copied from:
> include/linux/bitops.h
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
>  include/asm-generic/bitops/hweight.h |   54 +++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+)
> 
> Index: 2.6-git/include/asm-generic/bitops/hweight.h
> ===================================================================
> --- /dev/null
> +++ 2.6-git/include/asm-generic/bitops/hweight.h
> @@ -0,0 +1,54 @@
> +#ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
> +#define _ASM_GENERIC_BITOPS_HWEIGHT_H_
> +
> +#include <asm/types.h>
> +
> +/**
> + * hweightN - returns the hamming weight of a N-bit word
> + * @x: the word to weigh
> + *
> + * The Hamming Weight of a number is the total number of bits set in it.
> + */
> +
> +static inline unsigned int hweight32(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
> +        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
> +        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
> +        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
> +}


The first step can be implemented slightly better:

unsigned int res = w-((w>>1)&0x55555555);

as I found once on the web[1].

Several of the following steps can also be simplified
by omitting the masking when the result can't possibly
cause a carry to propagate too far.

This might also have a non negligible impact
on code size.


> +
> +static inline unsigned int hweight16(unsigned int w)
> +{
> +        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
> +        res = (res & 0x3333) + ((res >> 2) & 0x3333);
> +        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
> +        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
> +}
> +
> +static inline unsigned int hweight8(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
> +        res = (res & 0x33) + ((res >> 2) & 0x33);
> +        return (res & 0x0F) + ((res >> 4) & 0x0F);
> +}
> +
> +static inline unsigned long hweight64(__u64 w)
> +{
> +#if BITS_PER_LONG == 32
> +	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
> +#elif BITS_PER_LONG == 64
> +	u64 res;
> +	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
> +	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
> +	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
> +	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
> +	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
> +	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
> +#else
> +#error BITS_PER_LONG not defined
> +#endif
> +}
> +
> +#endif /* _ASM_GENERIC_BITOPS_HWEIGHT_H_ */
>


	Regards,
	Gabriel

[1] It might be better to write the first line 

	unsigned res = w - ((w&0xaaaaaaaa)>>1);

but I can never remember what the C standard guarantess about 
right shifts values (very little IIRC). I believe that it will
work properly on all architectures that GCC supports, however,
and that it will help on many.
