Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSBJEW0>; Sat, 9 Feb 2002 23:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBJEWJ>; Sat, 9 Feb 2002 23:22:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26899 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289270AbSBJEVu>;
	Sat, 9 Feb 2002 23:21:50 -0500
Message-ID: <3C65F523.FDDB7FA@zip.com.au>
Date: Sat, 09 Feb 2002 20:20:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C659D8A.37EA0155@zip.com.au> from "Andrew Morton" at Feb 09, 2002 02:07:06 PM <E16Zjw9-0000Dr-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This works for me, from in-kernel as well as in-module.  It'd
> > be good if someone more familiar with x86 could check it over.
> 
> This looks a really bad reversion. The CONFIG_DEBUG_BUGVERBOSE ifdef saves
> over 70K of memory on my standard kernel build.

About the time the 70k claim was made, I moved the printk out-of-line,
so things got not so bad.  However, with my (large) kernel build, on
egcs-1.1.2:

non-verbose BUG:
        2589971  293436  373404 3256811  31b1eb vmlinux
verbose BUG:
        2709055  293436  373404 3375895  338317 vmlinux
Patched:
        2694537  293436  373404 3361377  334a61 vmlinux

Which is 100k, which is preposterous.

This is due to BUG() calls in inline functions in headers.  The biggest
culprit is dget(), in dcache.h.  This causes the full path of the header file
to be expanded into each and every compilation unit which includes
dcache.h.  In my build, it's 25 kilobytes of:

...
/net/akpm-1/usr/src/linux-akpm/include/linux/dcache.h
/net/akpm-1/usr/src/linux-akpm/include/linux/dcache.h                           /net/akpm-1/usr/src/linux-akpm/include/linux/dcache.h
...

I'm showing thirteen header files, for a total of 83k.  I'll do something
about this...

> Putting the file name pointers
> back in everywhere is going to put a fair amount of that back except on
> very new gcc's that maybe will do string merging in this case. Have you
> verified string merging occurs in gcc 2.95 for __FILE__ string constants
> passed into asm blocks ?

Yes, the compiler gets it right.
 
> I also don't understand what the problem you are trying to solve is. If you
> want to debug the kernel you build with debug verbose. If not you don't.
> With the symbol table you can still easily trace down BUG events.
> 

Alan, the thing I really don't like about the config option is
when people come onto this list reporting that they got a "Kernel
BUG" and we simply don't know where it happened.  It's especially
hard when we have a bunch of BUGs near together, such as the
rather popular ones in page_alloc.c

Fixing the above problem should reduce the overhead from 100k down
to 20k.  I'll also change the implementation to

#if 1   /* Set to zero for a slightly smaller kernel */
#define BUG()                           \
 __asm__ __volatile__(  "ud2\n"         \
                        "\t.word %c0\n" \
                        "\t.long %c1\n" \
                         : : "i" (__LINE__), "i" (__FILE__))
#else
#define BUG() __asm__ __volatile__("ud2\n")
#endif

And we can add this to the list of kernel unpiggying tricks
which Lars Brinkhoff developed, which I guess should really
be in the Documentation/ directory somewhere.

But I dislike the config option, because of the information
loss to us.

-
