Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274357AbRITH6F>; Thu, 20 Sep 2001 03:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274358AbRITH5q>; Thu, 20 Sep 2001 03:57:46 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:14753 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274357AbRITH51>; Thu, 20 Sep 2001 03:57:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 20 Sep 2001 09:57:50 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920063143.424BD1E41A@Cantor.suse.de> <20010920084131.C1629@athlon.random>
In-Reply-To: <20010920084131.C1629@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920075736Z274357-761+10744@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2001 08:41 schrieb Andrea Arcangeli:
> Those inodes lines reminded me one thing, you may want to give it a try:
>
> --- 2.4.10pre12aa1/fs/inode.c.~1~	Thu Sep 20 01:44:07 2001
> +++ 2.4.10pre12aa1/fs/inode.c	Thu Sep 20 08:37:33 2001
> @@ -295,6 +295,12 @@
>  			 * so we have to start looking from the list head.
>  			 */
>  			tmp = head;
> +
> +			if (unlikely(current->need_resched)) {
> +				spin_unlock(&inode_lock);
> +				schedule();
> +				spin_lock(&inode_lock);
> +			}
>  		}
>  	}
>

You've forgotten a one liner.

  #include <linux/locks.h>
+#include <linux/compiler.h>

But this is not enough. Even with reniced artsd (-20).
Some shorter hiccups (0.5~1 sec).

-Dieter

dbench 16 (without renice)
Throughput 31.0483 MB/sec (NB=38.8104 MB/sec  310.483 MBit/sec)
7.270u 29.290s 1:09.03 52.9%    0+0k 0+0io 511pf+0w
load: 1034

Worst 20 latency times of 4261 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  4617   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
  2890  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  2072        BKL        1   533/inode.c         c016d9cd   697/sched.c
  2062        BKL        1  1302/inode.c         c016f359    52/inode.c
  2039        BKL        1  1302/inode.c         c016f359   697/sched.c
  1908        BKL        0  1302/inode.c         c016f359   929/namei.c
  1870        BKL        0  1302/inode.c         c016f359  1381/sched.c
  1859  spin_lock        0   547/sched.c         c0112fe4   697/sched.c
  1834        BKL        0    30/inode.c         c016ce51  1381/sched.c
  1834        BKL        1  1302/inode.c         c016f359  1380/sched.c
  1833        BKL        1  1437/namei.c         c014c42f   697/sched.c
  1831        BKL        1   452/exit.c          c011af61   697/sched.c
  1820        BKL        1  1437/namei.c         c014c42f   842/inode.c
  1797        BKL        0  1302/inode.c         c016f359   842/inode.c
  1741  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
  1696   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  1690        BKL        1  1437/namei.c         c014c42f  1380/sched.c
  1652        BKL        1   533/inode.c         c016d9cd  1380/sched.c
  1648        BKL        1  1870/namei.c         c014d420  1381/sched.c
  1643        BKL        0   927/namei.c         c014b2bf  1381/sched.c


dbench 16 (artsd renice -20)
Throughput 32.8102 MB/sec (NB=41.0127 MB/sec  328.102 MBit/sec)
7.490u 28.570s 1:05.38 55.1%    0+0k 0+0io 511pf+0w
load: 963

Worst 20 latency times of 4649 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  4828  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  2446  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  2237   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  2205   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  2205        BKL        1  1302/inode.c         c016f359  1380/sched.c
  2076        BKL        0  1302/inode.c         c016f359  1381/sched.c
  2065  spin_lock        0   547/sched.c         c0112fe4   697/sched.c
  2048        BKL        0    30/inode.c         c016ce51   697/sched.c
  2040        BKL        1   452/exit.c          c011af61   697/sched.c
  1982        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  1953        BKL        0  1437/namei.c         c014c42f  1380/sched.c
  1942        BKL        1  1302/inode.c         c016f359   697/sched.c
  1847        BKL        0  1302/inode.c         c016f359   842/inode.c
  1761        BKL        0  1437/namei.c         c014c42f   697/sched.c
  1734   reacqBKL        1  1375/sched.c         c0114d94    52/inode.c
  1708        BKL        0    30/inode.c         c016ce51  1306/inode.c
  1705        BKL        0   927/namei.c         c014b2bf  1381/sched.c
  1688        BKL        0  1302/inode.c         c016f359   929/namei.c
  1679        BKL        1  1437/namei.c         c014c42f   842/inode.c
  1648        BKL        1  1302/inode.c         c016f359  1439/namei.c


dbench 48 looks like this (without renice)
Throughput 24.5736 MB/sec (NB=30.717 MB/sec  245.736 MBit/sec)
23.250u 89.760s 4:18.85 43.6%   0+0k 0+0io 1311pf+0w
load: 4429

Worst 20 latency times of 8033 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 10856  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
 10705        BKL        1  1302/inode.c         c016f359   697/sched.c
 10577  spin_lock        1  1376/sched.c         c0114db3   303/namei.c
  9427  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  8526   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  4492   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  4171        BKL        1  1302/inode.c         c016f359  1381/sched.c
  3902   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c
  3376  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
  3132        BKL        0  1302/inode.c         c016f359  1380/sched.c
  3096  spin_lock        1   547/sched.c         c0112fe4  1380/sched.c
  2808        BKL        0    30/inode.c         c016ce51  1381/sched.c
  2807  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
  2782        BKL        0   452/exit.c          c011af61  1380/sched.c
  2631  spin_lock        0   483/dcache.c        c0153efa   520/dcache.c
  2533        BKL        0   533/inode.c         c016d9cd  1380/sched.c
  2489        BKL        0   927/namei.c         c014b2bf  1380/sched.c
  2389        BKL        1   452/exit.c          c011af61    52/inode.c
  2369        BKL        1  1302/inode.c         c016f359   842/inode.c
  2327        BKL        1    30/inode.c         c016ce51  1380/sched.c
