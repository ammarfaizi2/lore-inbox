Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291678AbSBHR6E>; Fri, 8 Feb 2002 12:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291679AbSBHR5z>; Fri, 8 Feb 2002 12:57:55 -0500
Received: from altus.drgw.net ([209.234.73.40]:5126 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291678AbSBHR5j>;
	Fri, 8 Feb 2002 12:57:39 -0500
Date: Fri, 8 Feb 2002 11:57:26 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: wli@holomorphy.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
Message-ID: <20020208115726.U17426@altus.drgw.net>
In-Reply-To: <20020207234555.N17426@altus.drgw.net> <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Feb 08, 2002 at 12:15:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> >+
> >+#ifdef __USE_ASM
> >+/* yeah, this is a mess, and leaves out m68k.... */
> >+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) || defined(CONFIG_MIPS)
> >+#  define __USE_ASM__
> >+# endif
> >+#endif
> 

[snip]

> I.e. remove the #ifdef __USE_ASM and add CONFIG_M68K dependence.
 
Well, there's a reason I left out CONFIG_M68K deps.. Go tell me where 
CONFIG_M68K is defined.. ;)


> >+#ifdef __USE_ASM__
> >+#include <asm/div64.h>
> >+#else /* __USE_ASM__ */
> >+static inline int do_div(unsigned long long * n, unsigned long base)
> >+{
> >+       int res = 0;
> >+       unsigned long long t = *n;
> >+       if ( t == (unsigned long)t ){ /* this should handle 64 bit 
> >platforms */
> >+               res = ((unsigned long) t) % base;
> >+               t = ((unsigned long) t) / base;
> >+       } else {
> 
> This check is silly. It is _way_ more efficient to do:
> 
> if (BITS_PER_LONG == 64) {
>          res = ((unsigned long)t) % base;
>          t = ((unsigned long)t) / base;
> } else {
>
> This actually only compiles one or the other but not both.

The intent of this is to have one check that handles both 64 and 32 bit 
platforms nicely, and handle degenerate cases where N is less than 32 
bits on 32 bit platforms.

I could be persuaded to add a (BITS_PER_LONG) check for 64 bit machines 
if someone shows me ASM showing gcc isn't smart enough to figure out that
	
	(unsigned long long)t == (unsigned long)t 

is always true on 64 bit.

> 
> >+#ifndef USE_SLOW_64BIT_DIVIDES
> 
> This is stupid. If someone knows in advance they are only doing a division 
> by 8 or 16 they would not be using do_div in the first place, they would be 
> using a shift or even just normal division sign which gcc is supposed to 
> optimize to a shift itself (assuming division by constant).
> 
> Please remove this. People using do_div() are using it for a reason.

I am trying to provide a cleanup that is acceptable to most people.

Several people I have talked to on the issue specifically asked for the 
panic(), as people using do_div() should really know better than to do 64 
bit divides in the kernel.

I provided the #define option so we can have *one* sane cross platform 64 
bit divide, but one that still makes people think before using do_div.

> Anyway, why do you randomly pick 8 and 16? You could do any power of two 
> via shift by simply doing something along these lines:
> 
> if (!(base & (base - 1))) {
>          res = t & (base - 1);
>          t >>= ffs(base) - 1;
> } else
>          panic("blah");
> 
> But I still think this is a really stupid thing to do.

using do_div() blindly is also considered a really stupid thing to do. 
YMMV.

This patch is primarily intended to fix vsprintf of long longs on all 
platforms, once and for all, and vsprintf only uses base 8 and 16. Anyone 
doing a printk and wanting a decimal representation of a long long 
probably deserves a panic anyway. (IHMO)


[snip]

> Look at asm-parisc/div64.h which has an optimized version of this for t 
> actually being 32bit.

That came from asm-parisc/div64 originally.

The t being 32bit case is handled earlier

> 
> I think the patch is generally a good idea but it has to be done right...
> 
> Best regards,

Gabriel Paubert also pointed out one problem I'm not sure how to deal 
with..

The generic C algorithm only handles base < 65536.

I can think of a couple ways around this..

1) Make the base argument be a 'u16 base', and people with too large a
   base would get compile warnings/errors.

2) run-time check on base, and panic if too large

3) run-time check on base, print dmesg warning if too large



I'll re-post a new patch once I hear more feedback, and after I get some
suggestions on how to deal with base > 65535 problem


-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
