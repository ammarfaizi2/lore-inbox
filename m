Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbRGGCSE>; Fri, 6 Jul 2001 22:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265741AbRGGCRz>; Fri, 6 Jul 2001 22:17:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:22795 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265705AbRGGCRh>;
	Fri, 6 Jul 2001 22:17:37 -0400
Date: Fri, 6 Jul 2001 23:17:44 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] __initstr & __exitstr
Message-ID: <20010706231744.A6356@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please comment on this approach to move strings in __init functions
from .rodata to .data.init so that it get discarded after initialization,
like the variables marked as __initdata and the functions marked as __init,
as well as move strings in __exit marked functions to .data.exit, that will
be discarded and not even get into the generated kernel image.

	Please note that if possible the best approach was for gcc to move
those strings automatically if the function was marked with modified 
__init/__exit macros, but we have to keep in mind that some of the strings
in those functions can not be discarded because they keep being referenced
by say register_chrdev and others, unlike, for example, proc functions and
others that copy the string passed to some malloc'ed data structure, so we
have to be selective marking exactly the ones that can indeed be discarded.

	I've also implemented helper functions for printk thats the most
common case, and leaved the other common case, panic, using
__initstr/__exitstr explicitely, so that people can comment on what is
better.

	Here is the basic implementation in include/linux/init.h:

#define __initstr(s)    ({ static char __tmp_init_str[] __initdata=s;
__tmp_init_str;})
#define __exitstr(s)    ({ static char __tmp_exit_str[] __exitdata=s;
__tmp_exit_str;})
#define init_printk(fmt,arg...) printk(__initstr(fmt) , ##arg)
#define exit_printk(fmt,arg...) printk(__exitstr(fmt) , ##arg)

	For modules its a no op, as modules doesn't get rid of code/data
marked as __init{data}, please correct me if I'm wrong as I didn't checked
that in detail, but from first quick analysis it doesn't move it to some
different .data/.text section, so I assume it doesn't discards it after
initialization.
	
	For my config, compiling everything statically, with a pristine
2.4.6-ac1 kernel I get 172 KB freed after init, with this patch we save 16
KB more.

	I've put the patch at:
http://bazar.conectiva.com.br/~acme/patches/wip/__initstr.patch.4

	And yes, its intrusive, but it serves, IMHO, as an experiment to
see how much can be saved with this.

	Please advise/comment.

- Arnaldo
