Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbREEWpC>; Sat, 5 May 2001 18:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbREEWow>; Sat, 5 May 2001 18:44:52 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:5320 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135548AbREEWoh>; Sat, 5 May 2001 18:44:37 -0400
Message-ID: <3AF4824F.8964E53B@home.com>
Date: Sat, 05 May 2001 15:44:31 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> As all this is trying to avoid bus turnarounds (i.e. switching from
> reading to writing), wouldn't it be fastest to just trust that the CPU
> has at least 4k worth of cache? (and hope for the best that we don't
> get interrupted in the meanwhile).
> 
> void copy_page (char *dest, char *source)
> {
>         long *dst = (long *)dest,
>                 *src=(long *)source,
>                 *end= (long *)(source+PAGE_SIZE);
> #if 1
>         register int  i;
>         long t=0;
>         static long tt;
> 
>         for (i=0;i<PAGE_SIZE/sizeof (long);i += cache_line_size()/sizeof(long))
>         /* Actually the innards of this loop should be:
>                 (void) from[i];
>            however, the compiler will probably optimize that away. */
>                 t += src[i];
> 
>         tt = t;
> #endif
>         while (src < end)
>                 *dst++ = *src++;
> 
> }
> 
> So, this is 15 lines of C, and it'd be interesting to benchmark this
> against the assembly.
> 

  Well you asked for it :) :

clear_page by 'normal_clear_page'        took 12196 cycles (318.1 MB/s)
clear_page by 'slow_zero_page'           took 12207 cycles (317.9 MB/s)
clear_page by 'fast_clear_page'          took 29272 cycles (132.6 MB/s)
clear_page by 'faster_clear_page'        took 4831 cycles (803.1 MB/s)
 
copy_page by 'normal_copy_page'  took 12607 cycles (307.8 MB/s)
copy_page by 'slow_copy_page'    took 13617 cycles (285.0 MB/s)
copy_page by 'fast_copy_page'    took 9531 cycles (407.1 MB/s)
copy_page by 'faster_copy'       took 5585 cycles (694.7 MB/s)
copy_page by 'even_faster'       took 5621 cycles (690.3 MB/s)
copy_page by 'even_faster_nopre'         took 5837 cycles (664.8 MB/s)
copy_page by 'c_source'  took 17296 cycles (224.3
MB/s)                         

 The last one is yours :).  I'd assume this is because the compiler is
not
using mmx instructions for this. (the nopre is a routine I added to
check
the speed with only a single prefetch instruction.  When I tried adding
the routing with the single prefetch instruction to mmx.c and
recompiling
and rebooted, the system stayed up a lot longer, but it still crashed (I
was in Xwindows and the crash was partially written to the log file)
after around 3 minutes of work in X.
