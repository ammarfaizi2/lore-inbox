Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIMCbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIMCbw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUIMCbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:31:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:51670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265029AbUIMCbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:31:44 -0400
Date: Sun, 12 Sep 2004 19:31:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
In-Reply-To: <4144E93E.5030404@pobox.com>
Message-ID: <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Sep 2004, Jeff Garzik wrote:
>
> Linux Kernel Mailing List wrote:
> > --- a/include/linux/compiler.h	2004-09-11 00:26:40 -07:00
> > +++ b/include/linux/compiler.h	2004-09-11 00:26:40 -07:00
> > @@ -6,13 +6,17 @@
> >  # define __kernel	/* default address space */
> >  # define __safe		__attribute__((safe))
> >  # define __force	__attribute__((force))
> > +# define __iomem	__attribute__((noderef, address_space(2)))
> 
> Dumb gcc attribute questions:
> 
> 1) what does force do? it doesn't appear to be in gcc 3.3.3 docs.

It doesn't do anything for gcc. You're looking at the sparse-only code.

What "attribute((force))" does for sparse is to mark a type to be 
"forced", ie a cast to a forced type will not complain even if the cast 
otherwise would be invalid.

For example, "sparse" will warn about explicit casts that drop address 
space information:

	void __user *userptr;

	...
	memset((void *)userptr, 0, ...)

will cause a

	warning: cast removes address space of expression

complaint from sparse. But some _internal_ functions want to force the 
cast because they know it's safe. For example, you'll find

	#define __addr_ok(addr) ((unsigned long __force)(addr) < (current_thread_info()->addr_limit.seg))

because this internal x86 implementation detail knows that in that 
particular case it's safe to remove the address space information (it's 
just checking the user pointer against the address limit).

For gcc, none of this means anything, so all the #define's just become 
empty.

> 2) is "volatile ... __force" redundant?

No, although it's likely to be a strange combination. If you want to force 
a static address space conversion to a volatile pointer, you can do so. I 
don't see _why_ you'd want to do it ;)

> 3) can we use 'malloc' attribute on kmalloc?

Since we can't use the gcc alias analysis anyway (it's too broken until
very late gcc versions), the gcc 'malloc' attribute shouldn't make any
difference that I can tell.

But there wouldn't be anything _wrong_ in adding it to kmalloc(), if 
that's what you're asking.

		Linus
