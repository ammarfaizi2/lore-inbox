Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRITIVj>; Thu, 20 Sep 2001 04:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274369AbRITIV3>; Thu, 20 Sep 2001 04:21:29 -0400
Received: from [195.223.140.107] ([195.223.140.107]:49390 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274368AbRITIVX>;
	Thu, 20 Sep 2001 04:21:23 -0400
Date: Thu, 20 Sep 2001 10:21:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Message-ID: <20010920102139.G729@athlon.random>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920063143.424BD1E41A@Cantor.suse.de> <20010920084131.C1629@athlon.random> <20010920075751.6CA791E6B2@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010920075751.6CA791E6B2@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Thu, Sep 20, 2001 at 09:57:50AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 09:57:50AM +0200, Dieter Nützel wrote:
> Am Donnerstag, 20. September 2001 08:41 schrieb Andrea Arcangeli:
> > Those inodes lines reminded me one thing, you may want to give it a try:
> >
> > --- 2.4.10pre12aa1/fs/inode.c.~1~	Thu Sep 20 01:44:07 2001
> > +++ 2.4.10pre12aa1/fs/inode.c	Thu Sep 20 08:37:33 2001
> > @@ -295,6 +295,12 @@
> >  			 * so we have to start looking from the list head.
> >  			 */
> >  			tmp = head;
> > +
> > +			if (unlikely(current->need_resched)) {
> > +				spin_unlock(&inode_lock);
> > +				schedule();
> > +				spin_lock(&inode_lock);
> > +			}
> >  		}
> >  	}
> >
> 
> You've forgotten a one liner.
> 
>   #include <linux/locks.h>
> +#include <linux/compiler.h>

woops, didn't trapped it because of gcc 3.0.2. thanks.

> But this is not enough. Even with reniced artsd (-20).
> Some shorter hiccups (0.5~1 sec).

I'm not familiar with the output of the latency bench, but I actually
read "4617" usec as the worst latency, that means 4msec, not 500/1000
msec.

> Worst 20 latency times of 4261 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
    ^^^^
>   4617   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
    ^^^^
>   2890  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
>   2072        BKL        1   533/inode.c         c016d9cd   697/sched.c
>   2062        BKL        1  1302/inode.c         c016f359    52/inode.c
>   2039        BKL        1  1302/inode.c         c016f359   697/sched.c
>   1908        BKL        0  1302/inode.c         c016f359   929/namei.c
>   1870        BKL        0  1302/inode.c         c016f359  1381/sched.c
>   1859  spin_lock        0   547/sched.c         c0112fe4   697/sched.c
>   1834        BKL        0    30/inode.c         c016ce51  1381/sched.c
>   1834        BKL        1  1302/inode.c         c016f359  1380/sched.c
>   1833        BKL        1  1437/namei.c         c014c42f   697/sched.c
>   1831        BKL        1   452/exit.c          c011af61   697/sched.c
>   1820        BKL        1  1437/namei.c         c014c42f   842/inode.c
>   1797        BKL        0  1302/inode.c         c016f359   842/inode.c
>   1741  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
>   1696   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
>   1690        BKL        1  1437/namei.c         c014c42f  1380/sched.c
>   1652        BKL        1   533/inode.c         c016d9cd  1380/sched.c
>   1648        BKL        1  1870/namei.c         c014d420  1381/sched.c
>   1643        BKL        0   927/namei.c         c014b2bf  1381/sched.c


those are kernel addresses, can you resolve them via System.map rather
than trying to find their start/end line number?

> Worst 20 latency times of 8033 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  10856  spin_lock        1  1376/sched.c         c0114db3   697/sched.c

with dbench 48 we gone to 10msec latency as far I can see (still far
from 0.5~1 sec). dbench 48 is longer so more probability to get the
higher latency, and it does more I/O, probably also seeks more, so thre
are many variables (slower insection in I/O queues first of all, etcll).
However 10msec isn't that bad, it means 100hz, something that the human
eye cannot see. 0.5~1 sec would been horribly bad latency instead.. :)

>  10705        BKL        1  1302/inode.c         c016f359   697/sched.c
>  10577  spin_lock        1  1376/sched.c         c0114db3   303/namei.c
>   9427  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
>   8526   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
>   4492   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
>   4171        BKL        1  1302/inode.c         c016f359  1381/sched.c
>   3902   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c
>   3376  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
>   3132        BKL        0  1302/inode.c         c016f359  1380/sched.c
>   3096  spin_lock        1   547/sched.c         c0112fe4  1380/sched.c
>   2808        BKL        0    30/inode.c         c016ce51  1381/sched.c
>   2807  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
>   2782        BKL        0   452/exit.c          c011af61  1380/sched.c
>   2631  spin_lock        0   483/dcache.c        c0153efa   520/dcache.c
>   2533        BKL        0   533/inode.c         c016d9cd  1380/sched.c
>   2489        BKL        0   927/namei.c         c014b2bf  1380/sched.c
>   2389        BKL        1   452/exit.c          c011af61    52/inode.c
>   2369        BKL        1  1302/inode.c         c016f359   842/inode.c
>   2327        BKL        1    30/inode.c         c016ce51  1380/sched.c


Andrea
