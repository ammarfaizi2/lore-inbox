Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSHDAe2>; Sat, 3 Aug 2002 20:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSHDAe2>; Sat, 3 Aug 2002 20:34:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318037AbSHDAe1>;
	Sat, 3 Aug 2002 20:34:27 -0400
Message-ID: <3D4C799C.72D92899@zip.com.au>
Date: Sat, 03 Aug 2002 17:47:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <E17b3sE-0001T4-00@starship> <3D4C4DD9.779C057B@zip.com.au> <E17b7iB-0003Lu-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Saturday 03 August 2002 23:40, Andrew Morton wrote:
> > - total amount of CPU time lost spinning on locks is 1%, mainly
> >   in page_add_rmap and zap_pte_range.
> >
> > That's not much spintime.   The total system time with this test went
> > from 71 seconds (2.5.26) to 88 seconds (2.5.30). (4.5 seconds per CPU)
> > So all the time is presumably spent waiting on cachelines to come from
> > other CPUs, or from local L2.
> 
> Have we tried this one:
> 
>  static inline unsigned rmap_lockno(pgoff_t index)
>  {
> -       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 1);
> +       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 16);
>  }
> 
> (which puts all the rmap spinlocks in separate cache lines)

Seems a strange way of doing it?  We'll only ever use four locks
this way.

2.4.19-pre7:
	./daniel.sh  36.00s user 66.09s system 363% cpu 28.059 total
	./daniel.sh  35.49s user 67.70s system 361% cpu 28.516 total
	./daniel.sh  34.38s user 68.46s system 363% cpu 28.327 total

2.5.26
	./daniel.sh  40.90s user 75.79s system 364% cpu 31.984 total
	./daniel.sh  37.65s user 69.23s system 366% cpu 29.177 total
	./daniel.sh  37.77s user 69.45s system 364% cpu 29.408 total

2.5.30
	./daniel.sh  38.01s user 91.31s system 366% cpu 35.281 total
	./daniel.sh  37.19s user 87.69s system 368% cpu 33.884 total
	./daniel.sh  37.18s user 87.62s system 358% cpu 34.812 total

2.5.30+akpmpatchpile
	./daniel.sh  36.71s user 85.73s system 363% cpu 33.722 total
	./daniel.sh  35.60s user 83.86s system 358% cpu 33.303 total
	./daniel.sh  36.56s user 86.26s system 368% cpu 33.346 total

2.5.30+akpmpatchpile+rmap-speedup:
	./daniel.sh  36.22s user 84.09s system 361% cpu 33.237 total
	./daniel.sh  40.46s user 93.11s system 376% cpu 35.461 total
	./daniel.sh  39.29s user 91.79s system 359% cpu 36.441 total

2.5.30+akpmpatchpile+rmap-speedup+the above:
	./daniel.sh  38.75s user 102.66s system 374% cpu 37.764 total
	./daniel.sh  38.72s user 105.08s system 362% cpu 39.672 total
	./daniel.sh  40.43s user 108.00s system 373% cpu 39.722 total

Which tends to indicate that I broke your patch somehow.  It's at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/daniel-rmap-speedup.patch
and needs deep staring at.
