Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSAHLWk>; Tue, 8 Jan 2002 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287297AbSAHLWb>; Tue, 8 Jan 2002 06:22:31 -0500
Received: from [194.206.157.151] ([194.206.157.151]:19859 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S287283AbSAHLWT>; Tue, 8 Jan 2002 06:22:19 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E409@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'Rogelio M. Serrano Jr.'" <rogelio@evoserve.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'gcc@gcc.gnu.org'" <gcc@gcc.gnu.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] C undefined behavior fix 
Date: Tue, 8 Jan 2002 12:12:58 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rogelio M. Serrano Jr. [mailto:rogelio@evoserve.com]
> Sent: Tuesday, January 08, 2002 1:15 AM
> To: Bernard Dautrevaux
> Subject: Re: [PATCH] C undefined behavior fix 
> 
> 
> I tried the same thing using gcc 3.1
> the file test.c contains:
> 
> struct x{
>     volatile unsigned int x1:8;
> };
> 
> unsigned char f1(struct x* p)
> {
>     return p->x1;
> }
> 
> unsigned char f(unsigned int* p, unsigned char* q)
> {
>     *p = *q;

Note that in my case, the problem is caused by
	*q = *p;
as this request 8-bits from a 32-bits volatile, and gcc-2.95.3 generates a
byte load ;-(

> }
>  
> compiling with gcc -O2 -S test.c yields:
> 
> 	.file	"test.c"
> 	.text
> 	.align 2
> 	.p2align 4,,15
> .globl f1
> 	.type	f1,@function
> f1:
> 	pushl	%ebp
> 	movl	%esp, %ebp
> 	movl	8(%ebp), %eax
> 	movb	(%eax), %al

So here we get the (correct but annoying) byte access to an 8-bit field
taken from a 32-bit integer. That's exactly what we had to change for
volatile to be useful, so that this access is in fact a 32-bit access.

> 	andl	$255, %eax
> 	popl	%ebp
> 	ret
> .Lfe1:
> 	.size	f1,.Lfe1-f1
> 	.align 2
> 	.p2align 4,,15
> .globl f
> 	.type	f,@function
> f:
> 	pushl	%ebp
> 	movl	%esp, %ebp
> 	movl	12(%ebp), %eax
> 	xorl	%edx, %edx
> 	movb	(%eax), %dl	

This is correct as you read *q, which is a byte

> 	movl	8(%ebp), %eax
> 	movl	%edx, (%eax)

And hopefully, this is correct also as you write all the 32-bits of *p, as
requested.

> 	popl	%ebp
> 	ret
> .Lfe2:
> 	.size	f,.Lfe2-f
> 	.ident	"GCC: (GNU) 3.1 20011231 (experimental)"
> 

So at least for the first test, gcc-3.1 generates the same (anoying) code as
2.95.3. I'm quite sure this is legal, as I can't see in the standard if when
writing:

	volatile unsigned int x:8;

I define:
	1) a volatile 8-bit field to be interpreted as an unsigned int.
	2) an 8-bit field which is part of a volatile unsigned int.

It seems to me that the choice between these two interpretation is
implementation defined; what bothers me is that the GCC choice (1) is not
the more useful in my case (system programming), nor the more natural IMHO.

The second problem I had on 2.95.3 is more anoying, and may well be a GCC
bug; clearly I ask to read a volatile unsigned int, and to forget 24bits out
of it, but GCC only read th e8 interesting bits. It seems that this violate
the 'side effect preserve' definition of volatile (although in a way
coherent with choice 1 above).

So it would seem more coherent to correct the second problem (if it exists
in 3.0) and switch to model (2) above... but that has to be discussed and
documented (although that is what we made in our own compiler).

Regards,

	Bernard


--------------------------------------------
Bernard Dautrevaux
Microprocess Ingenierie
97 bis, rue de Colombes
92400 COURBEVOIE
FRANCE
Tel:	+33 (0) 1 47 68 80 80
Fax:	+33 (0) 1 47 88 97 85
e-mail:	dautrevaux@microprocess.com
		b.dautrevaux@usa.net
-------------------------------------------- 
