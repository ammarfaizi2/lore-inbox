Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291839AbSBHVRk>; Fri, 8 Feb 2002 16:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291846AbSBHVQs>; Fri, 8 Feb 2002 16:16:48 -0500
Received: from altus.drgw.net ([209.234.73.40]:48134 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291849AbSBHVQ0>;
	Fri, 8 Feb 2002 16:16:26 -0500
Date: Fri, 8 Feb 2002 15:16:20 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: wli@holomorphy.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
Message-ID: <20020208151620.A1211@altus.drgw.net>
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020207234555.N17426@altus.drgw.net> <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020208115726.U17426@altus.drgw.net> <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Feb 08, 2002 at 07:34:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >+/* yeah, this is a mess, and leaves out m68k.... */
> > > >+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) ||
> 
> Just noticed there is a typo. It should be "defined(CONFIG_ARCH_S390)" not 
> "define"... Just spotted it

fixed.

> #if defined(__mc68000__) so just use that instead. Any m68k people reading 
> this care to comment?

fixed.

> Sorry can't say. Don't have 64 bit computers/gcc. )-: But as a matter of 
> principle I wouldn't trust gcc. I remember at least one case being 
> discussed on lkml before where gcc was not optimizing away obviously 
> optimizable code...

anyone else have comments on this? (for now I'm adding a '(BITS_PER_LONG == 
64) to the first if..

> >I provided the #define option so we can have *one* sane cross platform 64
> >bit divide, but one that still makes people think before using do_div.
> 
> You are just obfuscating the kernel code.

Obviously, there are good reasons for real 64 bit divides. 

Would you rather have a 'do_div64()' function that does full divisions?

For ntfs/smbfs, can you just make two consecutive calls?

	do_div(&val, 10000)
	do_div(&val, 1000)

> Rewrite the algorithm is the obvious choice. The old NTFS driver used to 
> have one but I got rid of it in favour of the nice do_div() assuming it 
> would always work... But even that had certain restrictions put in place 
> because of the special uses it had so it is not generic enough for 
> do_div(). Considering do_div() is not useful in current state I may have to 
> resurrect the original code and put it into NTFS (and SMBFS, which has the 
> same problem). But it would be much better to have a proper do_div() 
> instead. Otherwise we will just get proliferation of various do_div() 
> implementations in various drivers.

Yes, I'd like to avoid 16 different degenerate case implementations of
do_div() in various drivers.

Linus (or anyone else in a position to send stuff to Linus), could you please
make a statement about what would be acceptable? Should we have two
functions, rewrite vsprintf, or what?

I could just punt and fix powerpc with asm, but I really don't think do_div 
gets called enough to be worth the trouble of asm code. (ASM is for mucking 
with MMU's, atomic ops, etc, not 64 bit divides in-kernel)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
