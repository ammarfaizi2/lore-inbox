Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSBHTdq>; Fri, 8 Feb 2002 14:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291767AbSBHTdg>; Fri, 8 Feb 2002 14:33:36 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:28299 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291766AbSBHTdX>; Fri, 8 Feb 2002 14:33:23 -0500
Message-Id: <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 19:34:07 +0000
To: Troy Benjegerdes <hozer@drgw.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
Cc: wli@holomorphy.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020208115726.U17426@altus.drgw.net>
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
 <20020207234555.N17426@altus.drgw.net>
 <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:57 08/02/02, Troy Benjegerdes wrote:
>[snip]
>
> > >+
> > >+#ifdef __USE_ASM
> > >+/* yeah, this is a mess, and leaves out m68k.... */
> > >+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) ||

Just noticed there is a typo. It should be "defined(CONFIG_ARCH_S390)" not 
"define"... Just spotted it

>defined(CONFIG_MIPS)
> > >+#  define __USE_ASM__
> > >+# endif
> > >+#endif
> >
>
>[snip]
>
> > I.e. remove the #ifdef __USE_ASM and add CONFIG_M68K dependence.
>
>Well, there's a reason I left out CONFIG_M68K deps.. Go tell me where
>CONFIG_M68K is defined.. ;)

Appologies, it's in Configure.help but that is not a too useful places to 
have it. However the kernel seems to be using:

#if defined(__mc68000__) so just use that instead. Any m68k people reading 
this care to comment?

> > >+#ifdef __USE_ASM__
> > >+#include <asm/div64.h>
> > >+#else /* __USE_ASM__ */
> > >+static inline int do_div(unsigned long long * n, unsigned long base)
> > >+{
> > >+       int res = 0;
> > >+       unsigned long long t = *n;
> > >+       if ( t == (unsigned long)t ){ /* this should handle 64 bit
> > >platforms */
> > >+               res = ((unsigned long) t) % base;
> > >+               t = ((unsigned long) t) / base;
> > >+       } else {
> >
> > This check is silly. It is _way_ more efficient to do:
> >
> > if (BITS_PER_LONG == 64) {
> >          res = ((unsigned long)t) % base;
> >          t = ((unsigned long)t) / base;
> > } else {
> >
> > This actually only compiles one or the other but not both.
>
>The intent of this is to have one check that handles both 64 and 32 bit
>platforms nicely, and handle degenerate cases where N is less than 32
>bits on 32 bit platforms.
>
>I could be persuaded to add a (BITS_PER_LONG) check for 64 bit machines
>if someone shows me ASM showing gcc isn't smart enough to figure out that
>
>         (unsigned long long)t == (unsigned long)t
>
>is always true on 64 bit.

Sorry can't say. Don't have 64 bit computers/gcc. )-: But as a matter of 
principle I wouldn't trust gcc. I remember at least one case being 
discussed on lkml before where gcc was not optimizing away obviously 
optimizable code...

> > >+#ifndef USE_SLOW_64BIT_DIVIDES
> >
> > This is stupid. If someone knows in advance they are only doing a division
> > by 8 or 16 they would not be using do_div in the first place, they 
> would be
> > using a shift or even just normal division sign which gcc is supposed to
> > optimize to a shift itself (assuming division by constant).
> >
> > Please remove this. People using do_div() are using it for a reason.
>
>I am trying to provide a cleanup that is acceptable to most people.
>
>Several people I have talked to on the issue specifically asked for the
>panic(), as people using do_div() should really know better than to do 64
>bit divides in the kernel.

This is ridiculous. There are GENUINE uses for 64-bit division. NTFS and 
SMBFS and anything else having to interoperate with Windows requires 64-bit 
divisions. Best example is time conversion. Time is 64-bit and obviously 
has to be considered as a random number for all intents and purposes. And 
converting UNIX <-> Windows times REQUIRES 64-bit arithmetic.

And this is not the only use. Fortunately most 64-bit divisions in the 
kernel are by a power of 2 so shifts are used instead.

In fact I would say that anyone using do_div() for a base of 8 or 16 should 
be shot. I would put the panic() in do_div() but only IF the base IS a 
constant and IS a power of 2 and not otherwise. Then anyone using do_div() 
on constants will learn the lesson and do it properly instead.

>I provided the #define option so we can have *one* sane cross platform 64
>bit divide, but one that still makes people think before using do_div.

You are just obfuscating the kernel code.

> > Anyway, why do you randomly pick 8 and 16? You could do any power of two
> > via shift by simply doing something along these lines:
> >
> > if (!(base & (base - 1))) {
> >          res = t & (base - 1);
> >          t >>= ffs(base) - 1;
> > } else
> >          panic("blah");
> >
> > But I still think this is a really stupid thing to do.
>
>using do_div() blindly is also considered a really stupid thing to do.
>YMMV.

Yes, indeed. But do_div() exists because there ARE genuine uses for it. And 
these will only increase over time as everything is becoming too large to 
fit in 32-bits. I think that even inodes will have to become 64 bit within 
the next few years.

>This patch is primarily intended to fix vsprintf of long longs on all
>platforms, once and for all, and vsprintf only uses base 8 and 16. Anyone
>doing a printk and wanting a decimal representation of a long long
>probably deserves a panic anyway. (IHMO)

Why? You would kill the NTFS driver's debug/error outputs completely then. 
Why should I have to use hex numbers when they are not exactly natural to 
the human brain. (Although there is a case for saying that the hex is 
shorter so easier to parse by eye...but that is not reason enough to 
panic() if someone does it). In fact IMO panic() should pretty much never 
be used anywhere as it just shows lack of proper error handling but that is 
a different issue and let us not enter into that argument...

>[snip]
>
> > Look at asm-parisc/div64.h which has an optimized version of this for t
> > actually being 32bit.
>
>That came from asm-parisc/div64 originally.
>
>The t being 32bit case is handled earlier
>
> >
> > I think the patch is generally a good idea but it has to be done right...
> >
> > Best regards,
>
>Gabriel Paubert also pointed out one problem I'm not sure how to deal
>with..
>
>The generic C algorithm only handles base < 65536.

Eeek. I hadn't even noticed that. That is not very generic is it?!?

>I can think of a couple ways around this..
>
>1) Make the base argument be a 'u16 base', and people with too large a
>    base would get compile warnings/errors.
>
>2) run-time check on base, and panic if too large
>
>3) run-time check on base, print dmesg warning if too large

No, neither of these will do. NTFS needs to divide by 10000000 (1x10^7) 
which is way above 16-bits.

>I'll re-post a new patch once I hear more feedback, and after I get some
>suggestions on how to deal with base > 65535 problem

Rewrite the algorithm is the obvious choice. The old NTFS driver used to 
have one but I got rid of it in favour of the nice do_div() assuming it 
would always work... But even that had certain restrictions put in place 
because of the special uses it had so it is not generic enough for 
do_div(). Considering do_div() is not useful in current state I may have to 
resurrect the original code and put it into NTFS (and SMBFS, which has the 
same problem). But it would be much better to have a proper do_div() 
instead. Otherwise we will just get proliferation of various do_div() 
implementations in various drivers.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

