Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136078AbREDJ5x>; Fri, 4 May 2001 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136127AbREDJ5n>; Fri, 4 May 2001 05:57:43 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:8866 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136078AbREDJ5c>; Fri, 4 May 2001 05:57:32 -0400
Message-ID: <3AF27C39.9BD7EC99@home.com>
Date: Fri, 04 May 2001 02:54:01 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gordon Sadler <gbsadler1@lcisp.com>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Athlon/VIA Kernel Experimentation (mmx.c)
In-Reply-To: <20010503150346.A18141@debian-home.lcisp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I implemented a small check loop at the end of the fast_page_copy
routine in mmx.c for the Athlon.  Booting the resulting kernel
yields an interesting result. Every single time, the kernel
panics RIGHT AFTER it frees unused kernel memory from bootup.
I encourage those of you with the same problem to try this and report
when it panics.

Here is my patch to mmx.c: (sorry about the long lines)
-----------------------------------------------------cut here
diff -r linux-ref/arch/i386/lib/mmx.c linux/arch/i386/lib/mmx.c
204a205,216
>
>       {
>               register int x = 0;
>               /* do mem compares to ensure written == read */
>               for ( /* initted above */; x < (4096/sizeof(int)); x++ )
>               {
>                       if ( ((int *)to)[x] != ((int *)from)[x] ) {
>                               panic("fast_page_copy: dest value @ 0x%lx (%x) does not equal source value @ %lx (%x)!\n",
>                                               (long) to, ((int *)to)[x], (long) from, ((int *) from)[x] );
>                       }
>               }
>       }                                                                          
-----------------------------------------------------cut here

  Wouldn't it be correct to say that because it is panicking, the
page copy was not completed properly?  If that is so, the next step
is to find out why this copy is not working properly...

For me the output is:

...
Freeing unused kernel memory: 188k freed     
Kernel panic: fast_page_copy: dest value @ 0xcfed1000 (39312036) does
not equal source value @ cfed4000(79005b)!

--------

It is interesting to note that these addresses are page aligned, meaning
that the copy of even
the first byte failed!

 --Seth
