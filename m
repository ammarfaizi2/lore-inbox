Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266383AbUFZTNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266383AbUFZTNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUFZTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:13:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:18822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266383AbUFZTNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:13:16 -0400
Date: Sat, 26 Jun 2004 12:11:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088276343.1750.105.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0406261203370.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave>  <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
 <1088270298.1942.40.camel@mulgrave>  <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
 <1088276343.1750.105.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, James Bottomley wrote:
> 
> 1) Volatility is a property of the code path, not the data, which I
> agree with.

Right.

> 2) the bit operators need to operate on volatile data (i.e. need a
> volatile in their prototypes) without gcc issuing a qualifier dropped
> warning.
> 
> This I disagree with because we have no volatile data currently in the
> kernel that necessitates this behavour.

Why do you disagree, since
 - right now PA-RISC is BUGGY because of the lack of volatile. gcc _does_ 
   optimize and combine accesses since it's an inline function _without_
   any volatile specifier on the pointers.
 - the volatile _documents_ the fact that the bitops have volatile 
   behaviour.

> 3) The parisc bit operator implementations as inline functions need to
> have volatile data in their function templates because otherwise gcc
> will not implement them correctly and may optimise them away when it
> shouldn't.
> 
> I disagree with this too...although I'm on shakier ground, and I'd
> prefer gcc experts quantify why this happens, but if, on parisc, I look
> at the assembly output of your example
> 
>         while (test_and_set_bit(xxx, field))
>                 while (test_bit(xx, field)) /* Nothing */;

It seems the pa-risc optimizer for gcc is somehow broken. I just checked 
on x86:

	#define test_bit(x,y) \
	        (!!((1ul << x) & *(y)))

	int test(unsigned long *a)
	{
	        while (test_bit(0, a));
	}

definitely does not re-load the value. I checked with an inline function 
too, same result:

	        testb   $1, (%eax)
	        .p2align 2,,3
	.L2:
	        jne     .L2

ie gcc _does_ optimize this away without the volatile. With the volatile 
it turns into

	        .p2align 2,,3
	.L2:
	        movl    (%edx), %eax
	        testb   $1, %al
	        jne     .L2

so there's a clear difference here.

Now, why gcc on pa-risc misses that optimization, I have no clue. 

> So my contention is that even without the volatile pointers in our
> implementation, we still correctly treat this code path as having
> volatile (i.e. we test the bits each time around the loop).  All the
> addition of the volatile to the cpumask patch does is cause us to emit
> spurious warnings.

That's apparently just you being lucky due to having a broken gcc.

			Linus
