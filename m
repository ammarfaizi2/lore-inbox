Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRGGDFs>; Fri, 6 Jul 2001 23:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265875AbRGGDFi>; Fri, 6 Jul 2001 23:05:38 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14424 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S265870AbRGGDFb>; Fri, 6 Jul 2001 23:05:31 -0400
Date: Fri, 6 Jul 2001 22:05:14 -0500
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initstr & __exitstr
Message-ID: <20010706220514.A18820@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20010706231744.A6356@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010706231744.A6356@conectiva.com.br>; from Arnaldo Carvalho de Melo on Fri, Jul 06, 2001 at 11:17:44PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 11:17:44PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please comment on this approach to move strings in __init functions
> from .rodata to .data.init so that it get discarded after initialization,
> like the variables marked as __initdata and the functions marked as __init,
> as well as move strings in __exit marked functions to .data.exit, that will
> be discarded and not even get into the generated kernel image.
> 
> 	Please note that if possible the best approach was for gcc to move
> those strings automatically if the function was marked with modified 
> __init/__exit macros, but we have to keep in mind that some of the strings
> in those functions can not be discarded because they keep being referenced
> by say register_chrdev and others, unlike, for example, proc functions and
> others that copy the string passed to some malloc'ed data structure, so we
> have to be selective marking exactly the ones that can indeed be discarded.

.. or fix all registration functions to use a private copy of the string,
which would avoid some common oopses.

> 	I've also implemented helper functions for printk thats the most
> common case, and leaved the other common case, panic, using
> __initstr/__exitstr explicitely, so that people can comment on what is
> better.

> #define init_printk(fmt,arg...) printk(__initstr(fmt) , ##arg)

I dislike init_printk;  it combines variadic functions/macros with
assumptions about how the first argument is specified (i.e. as a string
constant), so it's potentially very confusing.

Also, printk is used for debugging, and accidentally using init_printk
instead of printk would result in no messages being printed at all if
the driver is compiled into the kernel (while everything would work
fine if the driver is compiled as a module, where init_printk and printk
are identical).  I think this would be very annoying to track down for
less experienced kernel hackers.

> #define __initstr(s)    ({ static char __tmp_init_str[] __initdata=s;
> __tmp_init_str;})

I think this would fail if used in structure initialisations ?

	Philipp Rumpf
