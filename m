Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTEANSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTEANSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:18:54 -0400
Received: from science.horizon.com ([192.35.100.1]:41019 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261251AbTEANSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:18:53 -0400
Date: 1 May 2003 13:31:10 -0000
Message-ID: <20030501133110.7966.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Fount of Holy Pengun Pee expressed himself thus:
> Yeah, except if you want best code generation you should probably use
>
>	static inline int fls(int x)
>	{
>		int bit;
>		/* Only well-defined for non-zero */
>		asm("bsrl %1,%0":"=r" (bit):"rm" (x));
>		return x ? bit : 32;
>	}
>
> which should generate (assuming you give "-march=xxxx" to tell gcc to use 
> cmov):
>
>		movl    $32, %eax
>		bsrl %edx,%ecx
>		testl   %edx, %edx
>		cmovne  %ecx, %eax
>
> which looks pretty optimal.

Except that the testl is unnecessary.  The full semantics of
bsrl are:

if (source != 0) {
	destination = <index of most significant set bit in source>;
	ZF = 0;
} else {
	destination = UNDEFINED;
	ZF = 1;
}

Thus, there are two reasonable code sequences:

asm("	bsrl	%2, %1"
"\n	cmovne  %1, %0" : "=r" (bit), "=r" (temp) : "rm" (x), "0" (32));

and (if I've got the earlyclobber syntax right):

asm("	bsrl	%1, %0"
"\n	cmoveq  %2, %0" : "=&r,&r" (bit) : "0,rm" (x), "rm,rm" (32));

Note that in this latter case, I have to list %1 == %0 as an explicit
alternative, because otherwise the & on operand 0 would tell GCC to forbid
that combination and it's only %0 == %2 that's forbidden.

(The first alternative is listed first because it uses fewer registers
and so is preferred, all other things being equal.)

Unfortunately, I'm not sure how to let GCC choose between these two
alternatives...
