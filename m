Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIMDA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIMDA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUIMDA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:00:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:22507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265127AbUIMDAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:00:52 -0400
Date: Sun, 12 Sep 2004 20:00:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
In-Reply-To: <414508F6.7020301@pobox.com>
Message-ID: <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com>
 <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Sep 2004, Jeff Garzik wrote:
> 
> > No, although it's likely to be a strange combination. If you want to force 
> > a static address space conversion to a volatile pointer, you can do so. I 
> > don't see _why_ you'd want to do it ;)
> 
> Well the reason I ask....
> 
> static inline void writeb(unsigned char b, volatile void __iomem *addr)
> {
>          *(volatile unsigned char __force *) addr = b;
> }

Right. Let's look a bit closer (more of an explanation than you need, but 
hey, maybe somebody else is also wondering):

 - for gcc, none of this matters one whit. We're just passing in a 
   "volatile void *", and we're storing the value "b" to the byte pointed
   by it. Which is correct on x86, since memory-mapped PCI-space just 
   looks like memory on x86.

   This is important to remember: for gcc, the sparse annotations are 
   meaningless. They can still be useful just to tell the _programmer_ 
   that "hey, that pointer you got wasn't a normal pointer" in a fairly 
   readable manner, but in the end, unless you use sparse, they don't 
   actually _do_ anything.

HOWEVER. When you _do_ use parse, it is another matter entirely. For
"sparse", that "__iomem"  has lots of meaning:

	# define __iomem       __attribute__((noderef, address_space(2)))

ie "iomem" means two separate things: it means that sparse should complain 
if the pointer is ever dereferenced (it's a "noderef" pointer) directly, 
and it's in "address space 2" as opposed to the normal address space (0).

Now, that means that _sparse_ will complain if such a pointer is ever
passed into a function that wants a regular pointer (because it is _not_ a
normal pointer, and you obviously shouldn't do things like "strcmp()" etc 
on it), and sparse will also complain if you try to cast it to another 
pointer in another address space.

So if you compile and install sparse, and build with "make C=1", you'll 
get warnings like

	drivers/video/aty/radeon_base.c:1725:42: warning: incorrect type in argument 2 (different address spaces)
	drivers/video/aty/radeon_base.c:1725:42:    expected void const *from
	drivers/video/aty/radeon_base.c:1725:42:    got void [noderef] *[assigned] base_addr<asn:2>

which is just another way sparse tells you that there is a bug in the 
source code (in this case, we try to copy from PCI memory-mapped space 
directly to user space using "copy_to_user()", which is a _bad_ idea).

So not only can you not dereference it by mistake, you can't even _turn_
it into a pointer that you could dereference by mistake. Sparse will
complain. Sparse will complain even if you use an explicit cast to make it 
a normal "(void *)".

And that's good, because on some other architectures, if you try to 
dereference the pointer, the machine just oopses. You need to do all the 
special magic to actually read from memory-mapped PCI space.

HOWEVER. On x86, it just so happens that dereferencing the pointer _is_ 
actually the right thing to do, as long as you only do it with the proper 
interfaces (ie readb/writeb and friends). And so that sparse won't be 
upset, we use the "__force" directive - we're telling sparse that "I know 
what I'm doing". And so sparse will quietly allow us to dereference that 
pointer that was originally not dereferencable.

Generally, you shouldn't ever use __force in a driver or anything like 
that. It's usually a valid thing to do only in the code that is defined 
for that particular type. By definition, a driver isn't an entity that 
should understand how architecture-specific data structures work, so it 
shouldn't try to force things.

So a good use of "__force" is exactly the usage you quote: the 
arch-specific code that actually really _knows_ what the magic address 
space means, and knows what to do about it.

		Linus
