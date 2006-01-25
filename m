Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWAYUDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWAYUDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWAYUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:03:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26639 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751177AbWAYUDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:03:08 -0500
Date: Wed, 25 Jan 2006 20:02:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060125200250.GA26443@flint.arm.linux.org.uk>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>, Andi Kleen <ak@suse.de>,
	Chris Zankel <chris@zankel.net>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125113206.GD18584@miraclelinux.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 08:32:06PM +0900, Akinobu Mita wrote:
> +#ifndef HAVE_ARCH___FFS_BITOPS
> +
> +/**
> + * __ffs - find first bit in word.
> + * @word: The word to search
> + *
> + * Returns 0..BITS_PER_LONG-1
> + * Undefined if no bit exists, so code should check against 0 first.
> + */
> +static inline unsigned long __ffs(unsigned long word)
>  {
> -	int	mask;
> +	int b = 0, s;
>  
> -	addr += nr >> 5;
> -	mask = 1 << (nr & 0x1f);
> -	return ((mask & *addr) != 0);
> +#if BITS_PER_LONG == 32
> +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
> +	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
> +	s =  1; if (word << 31 != 0) s = 0; b += s;
> +
> +	return b;
> +#elif BITS_PER_LONG == 64
> +	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
> +	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
> +	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
> +	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
> +	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
> +	s =  1; if (word << 63 != 0) s = 0; b += s;
> +
> +	return b;
> +#else
> +#error BITS_PER_LONG not defined
> +#endif

This code generates more expensive shifts than our (ARMs) existing C
version.  This is a backward step.

Basically, shifts which depend on a variable are more expensive than
constant-based shifts.

I've not really looked at the rest because I haven't figured out which
bits will be used on ARM and which won't - which I think is another
problem with this patch set.  I'll look again later tonight.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
