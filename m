Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUJ2EwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUJ2EwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUJ2EwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:52:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:42184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263093AbUJ2EwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:52:06 -0400
Date: Thu, 28 Oct 2004 21:52:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <4181933A.5000402@vmware.com>
Message-ID: <Pine.LNX.4.58.0410282136030.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41801DE1.6000007@vmware.com> <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
 <Pine.LNX.4.58.0410271731010.28839@ppc970.osdl.org> <4181933A.5000402@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Oct 2004, Zachary Amsden wrote:
>
> This leaves several options:
> 
> 1) Forget the optimization altogether
> 2) Go back to the (base == 1) check

Ok, I think I led you on a merry goose-chase, and the "base == 1" check 
was the only one worth bothering with after all. Sorry about that.

> This seems like a lot of work for a trivial optimization; for i386, 
> perhaps #2 is the most appropriate - with a sufficiently new GCC, this 
> optimization should be automatic for all architectures not hardcoding 
> do_div as inline assembler.

The do_div() optimization is a trivial one, and one that gcc should 
definitely have recognized. It's not like a compiler cannot see that you 
have a 64 / 32 divide, and realize that it's cheaper than a full 64 / 64 
divide.

But hey, even if the gcc people finally did that optimization today, it 
would take a few years before we didn't support old compilers any more, 
so.

> Seems to have come full circle - the trivial extension turns out to have 
> non-trivial side effects.  If only GCC were as easily extensible as 
> sparse!  A __builtin_highest_one_bit() function would make it possible 
> to use inline assembler without degenerating to individual cases for 
> each bit.

Yes. There are tons of places where we'd love to have a constant
compile-time "log2()" function. And yes, I could do it in sparse in about
ten more lines of code, but..

I guess you could do it with a lot of tests...  Something like this should
do it

	#define __constant_log2(y) ((y==1) ? 0 : \
				    (y==2) ? 1 : \
				    (y==4) ? 2 : \
				    (y==8) ? 3 : -1)	/* We could go on ... */

	#define do_div(x,y) ({					\
		unsigned long __mod;				\
		int __log2;					\
		if (__builtin_constant_p(y) && 			\
		    !((y) & ((y)-1)) &&				\
		    (__log2 = __constant_log2((y))) >= 0) {	\
			mod = x & ((y)-1);			\
			(x) >>= __log2;				\
		} else {					\
			.. inline asm case ..			\
		}						\
		__mod; })

which looks like it should work, but it's getting so ugly that I suspect I 
should be committed for even thinking about it.

(And no, I didn't test the above. It is all trivially optimizable by a 
compiler, and I can't see how gcc could _fail_ to get it right, but hey, I 
thought the previous thing would work too, so I'm clearly not competent to 
make that judgement... ;)

			Linus
