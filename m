Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTIFHGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIFHGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:06:06 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:43975 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262888AbTIFHGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:06:02 -0400
Date: Sat, 6 Sep 2003 09:06:01 +0200
From: Jan Hubicka <jh@suse.cz>
To: Robert Love <rml@tech9.net>
Cc: Andreas Jaeger <aj@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, rth@redhat.com,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030906070601.GE9989@kam.mff.cuni.cz>
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org> <ho65k76z9v.fsf@byrd.suse.de> <1062778587.8510.10.camel@boobies.awol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062778587.8510.10.camel@boobies.awol.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2003-09-05 at 11:17, Andreas Jaeger wrote:
> 
> 
> > Since unit-at-a-time has better inlining heuristics the better way is
> > to add the used attribute - but that takes some time.  The short-term
> > solution would be to add the compiler flag,
> 
> Won't we get a linker error if a static symbol is used but
> optimized-away?  It shouldn't be hard to fix the n linker errors that
> crop up.

Yes, you get linker error.
You may also run into misscompilation assuiming that function is static
and it is both called by hand in asm and by function call and there is
missing attribute used and asmlinkage definition.  In that case GCC
would conclude to change into register calling convention on i386
breaking asm code.

I would expect this to be rare as functions tends to be used either by
assembly or by normal code but not by both.
> 
> And why are we using static symbols in inline assembly outside of the
> compilation scope?

The toplevel asm statements are common source of this at least in glibc.
I didn't look much into the kernel sources.

I would be very happy if someone did look on that.  It may be well
possible that implementing tricks you do currently with toplevel asm
staements would need further extensions in GCC now and it would be nice
to know about that.

For instance it used to be possible to force function to go into given
section by changing the section by hand, but now you have to use section
attribute (that is cleaner anyway)
> 
> Anyhow, if it generates an error, this isn't hard to fix.
> 
> Here is the start...
> 
> 	Robert Love
> 
> 
> --- linux-rml/include/linux/compiler.h	Fri Sep  5 11:57:56 2003
> +++ linux/include/linux/compiler.h	Fri Sep  5 12:02:02 2003
> @@ -74,6 +74,19 @@
>  #define __attribute_pure__	/* unimplemented */
>  #endif
>  
> +/*
> + * As of gcc 3.2, we can mark a function as 'used' and gcc will assume that,
> + * even if it does not find a reference to it in any compilation unit.  We
> + * need this for gcc 3.4 and beyond, which can optimize on a program-wide
> + * scope, and not just one file at a time, to avoid static symbols being
> + * discarded.
> + */
> +#if (__GNUC__ == 3 && __GNUC_MINOR__ > 1) || __GNUC__ > 3
> +#define __attribute_used__	__attribute__((used))
> +#else
> +#define __attribute_used__	/* unimplemented */
> +#endif
> +
I believe there is little trick - attribute used works either for
variables or functions.  Functions can be marked as used only for GCC
3.4+ if I am right, so you may need __attribute_used_function__ and
__attribute_used_variable__ macros for that.

Honza
>  /* This macro obfuscates arithmetic on a variable address so that gcc
>     shouldn't recognize the original var, and make assumptions about it */
>  #define RELOC_HIDE(ptr, off)					\
> 
> 
