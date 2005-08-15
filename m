Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVHOHvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVHOHvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVHOHvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:51:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44184 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932164AbVHOHvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:51:31 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andy Isaacson <adi@hexapodia.org>, Marc Singer <elf@buici.com>
Subject: Re: [PATCH] spi
Date: Mon, 15 Aug 2005 10:51:13 +0300
User-Agent: KMail/1.5.4
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050808174721.GA2853@buici.com> <20050809190500.GA6551@buici.com> <20050809192920.GC23389@hexapodia.org>
In-Reply-To: <20050809192920.GC23389@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151051.13678.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It was explained to me that the !pointer test wasn't guaranteed to be
> > equivalent because of the way that the test is handled.
> 
> Whoever explained that to you was wrong.  6.5.3.3 is the final word on
> how "!x" is interpreted, and it *says* in the *text* that
> "!x" === "x!=0".  I don't see how this could be any clearer.
> 
> > The spec fragments above don't address how the boolean test is
> > coerced.  Does it cast pointer to an integer and perform the test, or
> > does it cast the 0 to a pointer and perform the test.  The C++ spec I
> > have is vague on this point.  The only reference it makes to pointers
> > is that the operand for ! may be a pointer.
> 
> Because of the equivalence *given in the text of 6.5.3.3* we can simply
> follow the money.  (I'm not concerned, here, about what ambiguities the
> C++ folks may or may not have introduced into their monstrosity.  The
> Linux kernel is written in C, and the C standard is unambiguous on this
> point.  Though frankly I'd be suprised if C++ breaks something so
> straightforward and useful.)
> 
> The section that defines != says
> 
> 6.5.9 Equality operators
>   Syntax
> (1)      equality-expression:
>                 relational-expression
>                 equality-expression == relational-expression
>                 equality-expression != relational-expression
>   Constraints
> 
> (2) One of the following shall hold:
>   ...
>   -- one operand is a pointer and the other is a null pointer constant.
> 
> (5) ... If one operand is a pointer and the other is a null pointer
>   constant, the null pointer constant is converted to the type of the
>   pointer. ...
> 
> So:
> 1. !x is defined equivalent to x!=0.
> 2. 0 is a "null pointer constant".
> 3. (assuming x is a pointer) 0 will be promoted to pointer type in the
>    expression "x!=0".

You are right to 99.9% ;)

The last 0.1% of wrongness comes from linux/stddef.h:
...
#define NULL ((void *)0)

Thus, !ptr is equivalent to ptr==0 but not equivalent to ptr==NULL
in general case for the kernel code (it is equivalent if ptr is
a variable of a _pointer type_ because ptr then implicitly converted
to (void*)).

Our NULL isn't 0 by design. it's not a bug, regardless what Stroustrup says
about NULL define.
--
vda

