Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVLPPlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVLPPlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLPPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:41:36 -0500
Received: from smtpout.mac.com ([17.250.248.71]:4852 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751301AbVLPPlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:41:35 -0500
In-Reply-To: <wn5bqzhm5ex.fsf@linhd-2.ca.nortel.com>
References: <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk> <wn564ppnohn.fsf@linhd-2.ca.nortel.com> <20051216143110.GC1222@flint.arm.linux.org.uk> <wn5bqzhm5ex.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9E24AC2-9097-4782-9D23-727A058EADDE@mac.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Fri, 16 Dec 2005 10:40:27 -0500
To: Linh Dang <linhd@nortel.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 16, 2005, at 10:24, Linh Dang wrote:
> Well, it may be true for ARM but for ppc (i dunno what exactly llsc  
> means but someone in the thread put ppc in llsc group)  it's:
>
>    loop:
>         load-reserve foo => old
>         new = old * N
>         store-conditional new => foo
>         if failed goto loop

LLSC == Load-Locked/Store-Conditional.  It's a slightly different  
name for your Load-Reserve/Store-Conditional

You still miss his point.  That is _GOOD_ code.  Russell's point is  
that if somebody does this in generic code:

do {
	old = atomic_read(&foo);
	new = old * 2;
} while (atomic_cmpxchg(&foo, old, new) != old);

On PPC or ARM or another LLSC architecture it does not end up looking  
like the good code, it looks like this (which is clearly inefficient):

>> And for architectures with llsc, this becomes:
>>
>> loop:	load foo => old
>> 	new = old * N
>> loop2:	load locked foo => ret
>> 	compare ret & old
>> 	if equal store conditional new in foo
>> 		if store failed because we lost the lock, goto loop2
>> 	compare ret & old
>> 	if not equal goto loop

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



