Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLZUrD>; Thu, 26 Dec 2002 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSLZUrD>; Thu, 26 Dec 2002 15:47:03 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58308 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263794AbSLZUrC>;
	Thu, 26 Dec 2002 15:47:02 -0500
Date: Thu, 26 Dec 2002 21:55:15 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212262055.VAA28874@harpo.it.uu.se>
To: manfred@colorfullife.com
Subject: Re: [PATCH] 2.5 fast poll on ppc64
Cc: anton@samba.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2002 14:53:40 +0100, Manfred Spraul wrote:
>Mikael Pettersson wrote:
>
>>Anton Blanchard writes:
>> > I was unable to boot 2.5-BK on ppc64 and narrowed it down to the fast
>> > poll patch.  I found:
>> > 
>> > offsetof(struct poll_list, entries) == 12 but
>> > sizeof(struct poll_list) == 16
...
>>To me (I'm a compiler writer) it looks like your compiler did NOT
>>mess up. Assuming struct pollfd has 32-bit alignment, the compiler
>>is doing the right thing by starting entries[] at offset 12.
>>The 16-byte size for struct poll_list is because the 'next' field
>>has 64-bit alignment, which forces the compiler to pad struct
>>poll_lists's size to a multiple of 8 bytes, i.e. 16 bytes in this
>>case. So the compiler is not broken.
>>  
>>
>I would agree, but there is a special restriction on offsetof() and 
>sizeof() of structures with flexible array members: section 6.7.2.1, 
>clause 16:
>
>First, the size of the structure shall be equal to the offset of the last element of an otherwise identical structure that replaces the flexible array member with an array of unspecified length.
>
>The simplest test case I've found is
>
>struct a1 { int a; char b; short c[];};
>struct a2 { int a; char b; short c[1];};
>
>    sizeof(struct a{1,2}) is 8.
>    offsetof(struct a{1,2}, c) is 6.
>
>--> sizeof(struct a1) != offsetof(struct a2, c)

Oh dear. I checked my C9x draft copy and you seem to be right.
The standard states that sizeof(struct a1) == offsetof(struct a1, c),
but both gcc (2.95.3 and 3.2) and Intel's icc (7.0) get it wrong on x86:
they make sizeof(struct a1) == 8 but offsetof(struct a1, c) == 6.

Technically speaking, the kernel code which uses 'entries[0]' is
non-compliant since the proper syntax is 'entries[]', but the empty
array size syntax isn't implemented in gcc 2.95.3.

>>But the old code which assumed pp+1 == pp->entries is so horribly
>>broken I can't find words for it. s/pp+1/pp->entries/ is the correct fix.

My mistake. The old code is Ok for C99, but broken for ANSI-C.

>I agree. Should we fix the kmalloc allocations, too?
>
>-	pp = kmalloc(sizeof(struct poll_list)+
>+	pp = kmalloc(offsetof(struct poll_list,entries)+
>			sizeof(struct pollfd)*
>			(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
>				GFP_KERNEL);

Yes, this should be changed as you suggest. The old code only
works in C99-compliant implementations, but we now know that both
gcc and icc get this wrong, so it seems prudent to revert to
the classical formulation, using the 'entries[0]' declaration
syntax and offsetof() instead of sizeof().

/Mikael
