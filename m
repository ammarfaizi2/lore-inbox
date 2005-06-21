Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFUNB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFUNB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFUM6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:58:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60940 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261350AbVFUMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:54:26 -0400
Date: Tue, 21 Jun 2005 14:54:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Kill signed chars !!! => PPC uses unsigned chars
Message-ID: <20050621125404.GA13437@alpha.home.local>
References: <20050525134933.5c22234a.akpm@osdl.org> <1117232503l.24619l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117232503l.24619l.1l@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 10:21:43PM +0000, J.A. Magallon wrote:
> ... and make gcc4 happy.
> 
> On 05.25, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> > 
> > 
> > - Again, if there are patches in here which you think should be merged in
> >   2.6.12, please point them out to me.
> > 
> 
> scripts/ is full of mismatches between char* params an signed char* arguments,
> and viceversa. gcc4 now complaints loud about this. Patch below deletes all
> those 'signed'. Anyways, which was the purpose of declaring 'signed char's
> to store text ?

Well, to my surprize, linux-ppc uses UNSIGNED chars by default. It has amazed
me but it's a fact. Let's compile this little program on tux-ppc :

$ cat ints.c
#include <stdio.h>

main()
{
        int i1, i2;
        char c1, c2;

        c1 = i1 = 0;

        c1--; c2 = c1;
        i1--; i2 = i1;

        c2 &= ~(c2 >> 1);
        i2 &= ~(i2 >> 1);

        if (c1 < 0) printf("c1<0: %d\n", c1); else printf("c1>=0: %d\n",c1);
        if (c2 < 0) printf("c2<0: %d\n", c2); else printf("c2>=0: %d\n",c2);
        if (i1 < 0) printf("i1<0: %d\n", i1); else printf("i1>=0: %d\n",i1);
        if (i2 < 0) printf("i2<0: %d\n", i2); else printf("i2>=0: %d\n",i2);
}

$ gcc-3.3 -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/3.3.5/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --enable-__cxa_atexit --with-system-zlib --enable-nls --without-included-gettext --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc --disable-multilib powerpc-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-13)

$ gcc-3.3 -O2 -o ints ints.c
ints.c: In function `main':
ints.c:16: warning: comparison is always false due to limited range of data type
ints.c:17: warning: comparison is always false due to limited range of data type

$ ./ints
c1>=0: 255
c2>=0: 128
i1<0: -1
i2>=0: 0

=> As you can see, 0 - 1 returns 255 as a char, and -1 & ~(-1 >> 1) = 128 !
ints are OK BTW. I'm gonna change some of my code to fix this because relying
on signed chars to to detect unassigned values (-1) is wrong !

Oh and BTW, here's the result on x86 :

$ gcc-3.3 -o ints ints.c
$ ./ints
c1<0: -1
c2>=0: 0
i1<0: -1
i2>=0: 0

Cheers,
Willy

