Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbTLZUFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265220AbTLZUFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:05:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:38867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265218AbTLZUFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:05:14 -0500
Date: Fri, 26 Dec 2003 12:05:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <20031226110206.28382.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.58.0312261151110.14874@home.osdl.org>
References: <20031226110206.28382.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003 linux@horizon.com wrote:
> 
> Applied to integer types, it *is* pretty brain damaged.  But applied to
> pointer types, it makes a lot more sense.

No it doesn't.

Your example shows all the problems with the thing:

> Or consider the case when the structure doesn't have an explicit size
> and you have a big case statement for parsing it:
> 
> switch (a->type) {
> 	case BAR:
> 		process_bar_chunk(((struct bar *)a)++);
> 		break;

Do you _really_ want to write unportable code for no reason?

This can trivially be done portably and readably by just adding a small 
bit of verbiage, ie you could have

	#define next_ptr(x,type) (void *)(1+(type *)(x))

and just write

		process_bar_chunk(a);
		a = next_ptr(a, struct bar);

or similar. Suddenly you can compile your code with any compiler you want 
to, including one that maybe generates better code than gcc. Including 
newer versions of gcc.

And suddenly people can look at your code, and understand what it is
doing, even if they don't know all the gcc extensions. That's _important_.

Some extensions are fairly obvious. I think the "a ? : b" one is pretty
simple, conceptually (ie you can explain it to even a novice C user
without there being any confusion). But the "cast as lvalue" definitely
isn't.

> It's well-defined and has legitimate uses.

It has no legitimate uses. The only upside of it is to avoid typing a few 
extra characters, but since using macros can make the code more readable 
anyway, that's not a very good argument.

			Linus
