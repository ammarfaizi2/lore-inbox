Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280656AbRKSTa5>; Mon, 19 Nov 2001 14:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280657AbRKSTas>; Mon, 19 Nov 2001 14:30:48 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:36882 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280656AbRKSTad>; Mon, 19 Nov 2001 14:30:33 -0500
Date: Mon, 19 Nov 2001 13:30:32 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119133032.C1439@asooo.flowerfire.com>
In-Reply-To: <200111191801.fAJI1l922388@neosilicon.transmeta.com> <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com> <20011119123125.B1439@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011119123125.B1439@asooo.flowerfire.com>; from brownfld@irridia.com on Mon, Nov 19, 2001 at 12:31:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I spoke too soon.  We developed a quick stress test that
causes the problem immediately:

 11:18am  up 3 days,  1:36,  3 users,  load average: 8.72, 7.18, 3.96
91 processes: 85 sleeping, 6 running, 0 zombie, 0 stopped
CPU states:  0.1% user, 93.4% system,  0.0% nice,  6.4% idle
Mem:  3343688K av, 3340784K used,    2904K free,       0K shrd,     308K buff
Swap: 1004052K av,  567404K used,  436648K free                 2994288K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
12102 oracle    13   0 16320  15M 14868 R    5584 67.2  0.4  18:58 oracle
12365 oracle    18   5 39352  38M 37796 R N   30M 66.7  1.1   4:14 oracle
12353 oracle    18   5 39956  38M 38408 R N   31M 66.5  1.1   9:14 oracle
12191 root      13   0   892  852   672 R       0 66.4  0.0   6:09 top
12366 oracle     9   0   892  892   672 S       0 60.0  0.0   3:20 top
    9 root       9   0     0    0     0 SW      0 49.0  0.0   9:27 kswapd
   11 root       9   0     0    0     0 SW      0 38.3  0.0   3:58 kupdated
  105 root       9   0     0    0     0 SW      0 28.8  0.0   4:56 kjournald
  470 root       9   0   844  828   472 S       0 28.1  0.0   1:46 gamdrvd
12351 oracle    13   5 39956  38M 38408 S N   31M 25.6  1.1   3:08 oracle
  669 oracle     9   0  4780 4780  4384 S     492 24.4  0.1   1:42 oracle
    1 root      14   0   476  424   408 R       0 21.6  0.0   1:19 init
    2 root      14   0     0    0     0 RW      0 20.8  0.0   1:29 keventd
  615 oracle     9   0  8984 8984  8460 S    4380 16.3  0.2   2:41 oracle
  388 root       9   0   732  728   592 S       0 11.5  0.0   0:17 syslogd

kswapd bounces up and down from 99%.

Keys for me are the full system time, the fact that the %CPUs seem to
add up to more than 6xCPUs (6-way Xeon), and that processes that aren't
really active show up as "active".

ASAP, I'll try -pre6 and then -aa1 to compare behavior.

The Oracle stress query looks like:

select /*+ parallel(mt,5) cache(mt) */ count(*) from mtable_units ;

Thanks much,
-- 
Ken.


On Mon, Nov 19, 2001 at 12:31:25PM -0600, Ken Brownfield wrote:
| Linus, so far 2.4.15-pre4 with your patch does not reproduce the kswapd
| issue with Oracle, but I do need to perform more deterministic tests
| before I can fully sign off on that.
| 
| BTW, didn't your patch go into -pre5?  Or is there an additional mod in
| -pre6 that we should try?
| -- 
| Ken.
| brownfld@irridia.com
| 
| On Mon, Nov 19, 2001 at 10:07:58AM -0800, Linus Torvalds wrote:
| | 
| | On Mon, 19 Nov 2001, Sebastian Dröge wrote:
| | > Hi,
| | > I couldn't answer ealier because I had some problems with my ISP
| | > the heavy swapping problem while burning a cd is solved in pre6aa1
| | > but if you want i can do some statistics tommorow
| | 
| | Well, pre6aa1 performs really badly exactly because it by default doesn't
| | swap enough even on _normal_ loads because Andrea is playing with some
| | tuning (and see the bad results of that tuning in the VM testing by
| | rwhron@earthlink.net).
| | 
| | So the pre6aa1 numbers are kind of suspect - lack of swapping may not be
| | due to fixing the problem, but due to bad tuning.
| | 
| | Does plain pre6 solve it? Plain pre6 has a fix where a locked shared
| | memory area would previously cause unnecessary swapping, and maybe the CD
| | burning buffer is using shmlock..
| | 
| | 		Linus
| | 
| | -
| | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| | the body of a message to majordomo@vger.kernel.org
| | More majordomo info at  http://vger.kernel.org/majordomo-info.html
| | Please read the FAQ at  http://www.tux.org/lkml/
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
